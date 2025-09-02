#!/usr/bash
new_name=$1
echo "new package name: $new_name"
name_xml=`echo "cat /package/name" | xmllint --shell package.xml`
org_name=`echo ${name_xml} | sed -e "s/^.*<name.*>\(.*\)<\/name>.*$/\1/"`
echo "current package name: $org_name"
if [ $org_name == $new_name ]; then
	echo "new package name equal original package name. "
else
	mv ../$org_name ../$new_name && cd ../$new_name
	mv include/$org_name include/$new_name
	sed -i "s/${org_name}/${new_name}/" CMakeLists.txt package.xml
fi
