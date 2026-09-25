-- ============================================================
-- PVP99 - SELETOR DE VOCACAO MEDIEVAL
-- VERSAO CORRIGIDA / COMPACTA
-- ============================================================

local BASE_URL =
  "https://raw.githubusercontent.com/oficiallpvp99/PVP99-Caves/refs/heads/main/"

local VOCATIONS = {
  knight = {
    name = "KNIGHT",
    file = "knight.lua",
    image = BASE_URL .. "knight.png"
  },

  monk = {
    name = "MONK",
    file = "monk.lua",
    image = BASE_URL .. "monk.png?v=2"
  },

  paladin = {
    name = "PALADIN",
    file = "paladin.lua",
    image = BASE_URL .. "paladin.png"
  },

  sorcerer = {
    name = "SORCERER",
    file = "sorcerer.lua",
    image = BASE_URL .. "sorcerer.png"
  },

  druid = {
    name = "DRUID",
    file = "druid.lua",
    image = BASE_URL .. "druid.png"
  }
}

local loading = false

g_ui.loadUIFromString([[

Pvp99VocationCard < Button
  width: 114
  height: 76
  background-color: #2b241f
  border-width: 1
  border-color: #5b4a35

  $hover:
    background-color: #2b241f
    border-color: #5b4a35

  $pressed:
    background-color: #433428
    border-color: #f2c676


Pvp99CancelButton < Button
  width: 74
  height: 18
  background-color: #35291f
  border-width: 1
  border-color: #765f45
  color: #e8dcc4
  font: verdana-11px-rounded

  $hover:
    background-color: #483625
    border-color: #d7ad61
    color: #fff2d1

  $pressed:
    background-color: #261d17
    border-color: #f2c676


Pvp99VocationWindow < MainWindow
  id: pvp99VocationWindow
  text: PVP99
  size: 278 346
  @onEscape: self:hide()

  Label
    id: title
    text: ESCOLHER VOCATION
    width: 250
    text-align: center
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 5
    color: #f0c36d
    font: verdana-11px-rounded

