#Source: https://linuxconfig.org/how-to-install-go-on-ubuntu-20-04-focal-fossa-linux/
#!/bin/bash
#
sudo apt update && sudo apt upgrade -y
#
sudo apt install golang -y
#Check...
echo ""
go version
echo ""
echo "Download Golang hello world example:..."
go get github.com/golang/example/hello
echo ""
echo "Given that the new go directory is located within you user home directory, to execute the hello program run:"
~/go/bin/hello
#Hello, Go examples!
