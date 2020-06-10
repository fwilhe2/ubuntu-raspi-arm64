echo '::group::Setup Environment'
if [ `id -u` -ne 0 ];then
    echo "Please run this script with 'sudo' or by root user."
    exit 1
fi
whereisme=$(pwd)
chmod +x $whereisme/scripts/*.sh
whereisme=$whereisme $whereisme/scripts/environment.sh
if [ $? -ne 0 ]; then
    exit 1
fi
echo '::endgroup'
echo '::group::Create Image'
whereisme=$whereisme $whereisme/scripts/image.sh
if [ $? -ne 0 ]; then
    exit 1
fi
echo '::endgroup'
echo '::group::Building boot partition'
whereisme=$whereisme $whereisme/scripts/boot.sh
if [ $? -ne 0 ]; then
    exit 1
fi
echo '::endgroup'
echo '::group::Building root file system'
whereisme=$whereisme $whereisme/scripts/rootfs.sh
if [ $? -ne 0 ]; then
    exit 1
fi
echo '::endgroup'
echo '::group::Building linux kernel'
whereisme=$whereisme $whereisme/scripts/kernel.sh
if [ $? -ne 0 ]; then
    exit 1
fi
echo '::endgroup'
echo '::group::Cleaning'
whereisme=$whereisme $whereisme/scripts/final.sh
echo '::endgroup'