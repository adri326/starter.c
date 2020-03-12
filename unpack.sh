#! /bin/sh

DIR=$(pwd)"/$1"
SRC=$(dirname "$0")

echo -n "Project name: "
read NAME
echo -n "Repository name: "
read REPO_NAME
echo -n "Description: "
read DESCRIPTION

NAME=$(sed 's/[&/\]/\\&/g' <<<"${NAME}")
REPO_NAME=$(sed 's/[&/\]/\\&/g' <<<"${REPO_NAME}")
DESCRIPTION=$(sed 's/[&/\]/\\&/g' <<<"${DESCRIPTION}")

mkdir "${DIR}"
mkdir "${DIR}/src"

sed "s/REPO_NAME/${REPO_NAME}/g" "${SRC}/README.md" \
  | sed "s/DESCRIPTION/${DESCRIPTION}/g" \
  | sed "s/NAME/${NAME}/g" \
  > "${DIR}/README.md"

sed "s/NAME/${NAME}/g" "${SRC}/CMakeLists.txt" > "${DIR}/CMakeLists.txt"

cp "${SRC}/src/main.c" "${DIR}/src/main.c"
cp "${SRC}/.gitignore" "${DIR}/.gitignore"
