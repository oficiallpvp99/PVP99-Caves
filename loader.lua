
    
  
-- ============================================================
-- PVP99 - LOADER FUTURISTA | OTCv8
-- 4 VOCACOES: KNIGHT / PALADIN / SORCERER / DRUID
-- Sem JSON, sem profiles e sem sistema proprio de posicoes.
-- ============================================================

local SCRIPT_BASE =
  "https://raw.githubusercontent.com/oficiallpvp99/PVP99-Dist/refs/heads/main/"

local IMAGE_BASE =
  "https://raw.githubusercontent.com/oficiallpvp99/PVP99-Caves/refs/heads/main/"

local VOCATIONS = {
  knight = {
    name = "KNIGHT",
    subtitle = "MELEE / DEFESA",
    file = "knight.lua",
    image = IMAGE_BASE .. "knight.png"
  },

  paladin = {
    name = "PALADIN",
    subtitle = "DISTANCIA / SUPORTE",
    file = "paladin.lua",
    image = IMAGE_BASE .. "paladin.png"
  },

  sorcerer = {
    name = "SORCERER",
    subtitle = "MAGIA / DANO",
    file = "sorcerer.lua",
    image = IMAGE_BASE .. "sorcerer.png"
  },

  druid = {
    name = "DRUID",
    subtitle = "CURA / MAGIA",
    file = "druid.lua",
    image = IMAGE_BASE .. "druid.png"
  }
}

local loading = false

-- ============================================================
-- UI
-- ============================================================

g_ui.loadUIFromString([[
Pvp99FutureCard < Button
  width: 122
  height: 92
  background-color: #17131f
  border-width: 1
  border-color: #5f3a7a

  $hover:
    background-color: #21172c
    border-color: #c05cff

  $pressed:
    background-color: #2b1d3a
    border-color: #ff72df

Pvp99FutureClose < Button
  width: 86
  height: 22
  background-color: #1b1522
  border-width: 1
  border-color: #62406f
  color: #d8cae8
  font: verdana-11px-rounded

  $hover:
    background-color: #291d34
    border-color: #d263ff
    color: #ffffff

  $pressed:
    background-color: #140f19
    border-color: #ff72df

Pvp99FutureWindow < MainWindow
  id: pvp99FutureWindow
  text: PVP99
  size: 292 312
  @onEscape: self:hide()

  Label
    id: glowTop
    text: ◆ PVP99 SYSTEM ◆
    width: 260
    text-align: center
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 6

