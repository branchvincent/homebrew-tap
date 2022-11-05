cask "font-meslo-lgs-nerd-font" do
  version :latest
  sha256 :no_check

  url "https://github.com/romkatv/powerlevel10k-media.git"
  name "MesloLGS Nerd Font families (Meslo LG)"
  desc "Meslo Nerd Font patched for Powerlevel10k"
  homepage "https://github.com/romkatv/powerlevel10k-media"

  font "MesloLGS NF Bold Italic.ttf"
  font "MesloLGS NF Bold.ttf"
  font "MesloLGS NF Italic.ttf"
  font "MesloLGS NF Regular.ttf"
end
