# 需要在目标机器上安装 oss util mac 版本，并且配置 akid 和 aksecret

#FT_PUSH_TAG="refs/tags/agent_1.0.0-alpha.7"
POD_PRODUCT_PATH="ft-sdk-ios/Pod_Products/"

upperFirstLetter(){
  foo=$1
  foo="$(tr '[:lower:]' '[:upper:]' <<< "${foo:0:1}")${foo:1}"
  echo $foo
}

FT_PROD_TYPE=$(echo "$FT_PUSH_TAG" | sed -e 's/_.*//g'| sed -e 's/refs\/tags\///g')
# shellcheck disable=SC2001
VERSION=$(echo "$FT_PUSH_TAG" | sed -e 's/.*_//g' | sed -e 's/~.*//g' )

#echo "version:$VERSION"
#echo "type:$FT_PROD_TYPE"


if [ "$FT_PROD_TYPE" == "track" ] ; then
  PRODUCT_NAME="FTAutoTrack"
elif [ "$FT_PROD_TYPE" == "agent" ] ; then
  PRODUCT_NAME="FTMobileAgent"
fi

SCHEME_MERGE_NAME=$(upperFirstLetter "$FT_PROD_TYPE")

xcodebuild -project ft-sdk-ios/ft-sdk-ios.xcodeproj -sdk  iphoneos -scheme BuildFramwork"$SCHEME_MERGE_NAME" -configuration "Release"

#进入打包目录
cd "$POD_PRODUCT_PATH"

ZIP_PATH="$VERSION.zip"
FRAMEWORK_PATH="$PRODUCT_NAME.framework"

zip -q -r "$ZIP_PATH" "$FRAMEWORK_PATH"

~/ossutilmac64 cp "$ZIP_PATH" oss://zhuyun-static-files-production/ft-sdk-package/ios/"$PRODUCT_NAME"/

cd ../"$PRODUCT_NAME"

sed  -i -e 's/SDK_VERSION.*/SDK_VERSION @"'$VERSION'"/g' "$PRODUCT_NAME"Version.h

# 回到项目根目录
cd ..&&cd ..
# 替代文件中的版本号
sed  -i -e 's/$JENKINS_DYNAMIC_VERSION/'"$VERSION"'/g' "$PRODUCT_NAME".podspec

pod trunk push "$PRODUCT_NAME".podspec --verbose --allow-warnings
