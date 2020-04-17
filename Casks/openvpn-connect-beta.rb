cask 'openvpn-connect-beta' do
  version '3.1.1.1089'
  sha256 '92ef85ccf5fff1665b26d2f55b1a8694cbc9df1f284ec4795b6413879fe17772'

  url "https://swupdate.openvpn.net/beta-downloads/connect/openvpn-connect-#{version}_signed.dmg"
  appcast 'https://openvpn.net/client-connect-vpn-for-mac-os/'
  name 'OpenVPN Connect'
  homepage 'https://openvpn.net/client-connect-vpn-for-mac-os/'

  pkg 'OpenVPN_Connect_3_1_1(1089)_Installer_signed.pkg'

  uninstall script: {
                      executable: '/Applications/OpenVPN Connect/Uninstall OpenVPN Connect.app/Contents/Resources/remove.sh',
                      sudo:       true,
                    }
end
