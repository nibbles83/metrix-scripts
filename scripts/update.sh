echo "Stopping active Metrix core..."
metrix-cli stop
sleep 10
echo ""
echo "Downloading new core and installing it..."
curl -s https://api.github.com/repos/TheLindaProjectInc/Metrix/releases/latest | grep browser_download_url | grep linux-x64 | cut -d '"' -f 4 | wget -qi -
tar -xzvf metrix-linux-x64.tar.gz -C /usr/local/bin

echo ""
echo "Removing temp files..”

rm -Rf metrix-linux-x64.tar.gz

echo ""
echo "Downloading and applying bootstrap..."
echo ""
cd ~/.metrix
curl https://lindaproject.nyc3.digitaloceanspaces.com/metrix/bootstrap/metrix.zip -o metrix.zip
rm -Rf blocks chainstate database db.log
unzip metrix.zip
rm -Rf metrix.zip

echo ""
echo "Starting Core”

metrixd -daemon

echo "Check sync progress with metrix-cli getinfo”
