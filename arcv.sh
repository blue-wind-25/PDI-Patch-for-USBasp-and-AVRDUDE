COPY_NAME=PDI-Patch-for-USBasp-and-AVRDUDE-GIT-`date +'%Y%m%d-%H%M'`

echo -e "Cleaning the project tree ..."
cd ..

echo -e "Copying the project tree ..."
cd ..
cp -Rv PDI-Patch-for-USBasp-and-AVRDUDE $$COPY_NAME > /dev/null

echo -e "Deleting the '.git' directory from the copied project tree ..."
cd $$COPY_NAME
rm -rvf .git > /dev/null

echo -e "Archiving files from the copied project tree ..."
cd ..
tar -cjvpf $${COPY_NAME}.tar.bz2 $$COPY_NAME > /dev/null
echo -e "Done '$${COPY_NAME}.tar.bz2'"
