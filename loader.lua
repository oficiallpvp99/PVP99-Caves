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

-- ============================================================
-- PVP99 - POSICOES AUTOMATICAS DOS ICONES POR VOCACAO
-- Gerado a partir dos profiles Knight/Monk/Paladin/Sorcerer/Druid
-- Apenas X/Y sao aplicados. ON/OFF dos macros nao e alterado.
-- ============================================================

local PVP99_ICON_POSITIONS = {
  knight = {
    ["(RP) PvP"] = { x = 0.55154639175258, y = 0.14883720930233 },
    ["AtkAll"] = { x = 0.069264069264069, y = 0.13006396588486 },
    ["AVA"] = { x = 0.046153846153846, y = 0.8 },
    ["cI"] = { x = 0, y = 0.40085287846482 },
    ["Co"] = { x = 0, y = 0.10660980810235 },
    ["cr"] = { x = 0.078512396694215, y = 0.14418604651163 },
    ["CUR"] = { x = 0.10714285714286, y = 0.57782515991471 },
    ["ekAureraAttack"] = { x = 0.0032967032967033, y = 0.53186813186813 },
    ["ekAureraDefense"] = { x = 0.069230769230769, y = 0.52307692307692 },
    ["ekAureraRotation"] = { x = 0.049450549450549, y = 0.68571428571429 },
    ["exori"] = { x = 0.087809917355372, y = 0 },
    ["exori1"] = { x = 0.94834710743802, y = 0.027906976744186 },
    ["exori2"] = { x = 0.41978021978022, y = 0.25217391304348 },
    ["heals"] = { x = 0.57802197802198, y = 0.25217391304348 },
    ["HP"] = { x = 0.0021645021645022, y = 0.27078891257996 },
    ["monk"] = { x = 0.01, y = 0.25 },
    ["MP"] = { x = 0.075757575757576, y = 0.26652452025586 },
    ["RG"] = { x = 0.11776859504132, y = 0.14651162790698 },
    ["SD"] = { x = 0.054945054945055, y = 0.45507246376812 },
    ["teste"] = { x = 0.01, y = 0.45 },
    ["tI"] = { x = 0.070021881838074, y = 0.40085287846482 },
  },
  monk = {
    ["(RP) PvP"] = { x = 0.55154639175258, y = 0.14883720930233 },
    ["AtkAll"] = { x = 0.0086580086580087, y = 0.20042643923241 },
    ["AVA"] = { x = 0.046153846153846, y = 0.8 },
    ["cI"] = { x = 0.080962800875274, y = 0.40938166311301 },
    ["Co"] = { x = 0.0032467532467532, y = 0.051172707889126 },
    ["cr"] = { x = 0.078512396694215, y = 0.14418604651163 },
    ["CUR"] = { x = 0.076839826839827, y = 0.05543710021322 },
    ["exori"] = { x = 0.087809917355372, y = 0 },
    ["exori1"] = { x = 0.94834710743802, y = 0.027906976744186 },
    ["exori2"] = { x = 0.41978021978022, y = 0.25217391304348 },
    ["heals"] = { x = 0.57802197802198, y = 0.25217391304348 },
    ["HP"] = { x = 0.08008658008658, y = 0.18976545842217 },
    ["monk"] = { x = 0.01, y = 0.25 },
    ["monkAureraHarmonyV5"] = { x = 0.91648351648352, y = 0.085714285714286 },
    ["monkAureraJusticeV5"] = { x = 1, y = 0.079120879120879 },
    ["monkAureraRotationV5"] = { x = 0.91208791208791, y = 0.29010989010989 },
    ["monkAureraSustainV5"] = { x = 1, y = 0.28791208791209 },
    ["MP"] = { x = 0.085497835497836, y = 0.30277185501066 },
    ["RG"] = { x = 0.11776859504132, y = 0.14651162790698 },
    ["SD"] = { x = 0.054945054945055, y = 0.45507246376812 },
    ["teste"] = { x = 0.01, y = 0.45 },
    ["tI"] = { x = 0, y = 0.40724946695096 },
  },
  paladin = {
    ["(RP) PvP"] = { x = 0.1038961038961, y = 0.32835820895522 },
    ["AtkAll"] = { x = 0.91341991341991, y = 0.010660980810235 },
    ["AVA"] = { x = 0.046153846153846, y = 0.8 },
    ["cI"] = { x = 0.90919037199125, y = 0.36673773987207 },
    ["Co"] = { x = 0, y = 0.058139534883721 },
    ["cr"] = { x = 0.078512396694215, y = 0.14418604651163 },
    ["CUR"] = { x = 0.079004329004329, y = 0.063965884861407 },
    ["exori"] = { x = 0, y = 0.33049040511727 },
    ["exori1"] = { x = 0.94834710743802, y = 0.027906976744186 },
    ["exori2"] = { x = 0.41978021978022, y = 0.25217391304348 },
    ["heals"] = { x = 0.57802197802198, y = 0.25217391304348 },
    ["HP"] = { x = 0.0010822510822511, y = 0.2046908315565 },
    ["monk"] = { x = 0.01, y = 0.25 },
    ["monkAureraHarmonyV5"] = { x = 0.01, y = 0.05 },
    ["monkAureraJusticeV5"] = { x = 0.01, y = 0.25 },
    ["monkAureraRotationV5"] = { x = 0.01, y = 0.65 },
    ["monkAureraSustainV5"] = { x = 0.01, y = 0.45 },
    ["MP"] = { x = 0.084415584415584, y = 0.20255863539446 },
    ["paladinAureraAttackV5"] = { x = 0.90549450549451, y = 0.2 },
    ["paladinAureraDefenseV5"] = { x = 0.98571428571429, y = 0.2021978021978 },
    ["paladinAureraRotationV5"] = { x = 0.99230769230769, y = 0.0043956043956044 },
    ["RG"] = { x = 0.11776859504132, y = 0.14651162790698 },
    ["SD"] = { x = 0.054945054945055, y = 0.45507246376812 },
    ["teste"] = { x = 0.01, y = 0.45 },
    ["tI"] = { x = 1, y = 0.37526652452026 },
  },
  sorcerer = {
    ["(RP) PvP"] = { x = 0.55154639175258, y = 0.14883720930233 },
    ["AtkAll"] = { x = 0.081168831168831, y = 0.69509594882729 },
    ["AVA"] = { x = 0.96645021645022, y = 0 },
    ["cI"] = { x = 0.26373626373626, y = 0.51780821917808 },
    ["Co"] = { x = 0.91450216450216, y = 0.20255863539446 },
    ["CUR"] = { x = 0, y = 0.6908315565032 },
    ["edAureraAttack"] = { x = 0.011530398322851, y = 0.066037735849057 },
    ["edAureraHeal"] = { x = 0.12054507337526, y = 0.24056603773585 },
    ["edAureraRotation"] = { x = 0.10167714884696, y = 0.058962264150943 },
    ["exori1"] = { x = 0.36793692509855, y = 0.23719676549865 },
    ["exori2"] = { x = 0.44021024967148, y = 0.23854447439353 },
    ["heals"] = { x = 0.51182654402103, y = 0.24258760107817 },
    ["msAureraDecay"] = { x = 0.93396226415094, y = 0.30188679245283 },
    ["msAureraExpose"] = { x = 0.78721174004193, y = 0.17452830188679 },
    ["msAureraFire"] = { x = 0.95702306079665, y = 0.0047169811320755 },
    ["msAureraRotation"] = { x = 0.86373165618449, y = 0 },
    ["msAureraSap"] = { x = 0.77253668763103, y = 0.32311320754717 },
    ["msAureraThunder"] = { x = 0.9601677148847, y = 0.16745283018868 },
    ["runeSelectorV1"] = { x = 0.01, y = 0.05 },
    ["SD"] = { x = 0.9025974025974, y = 0.0085287846481876 },
    ["sorcAureraDecayV5"] = { x = 0.082417582417582, y = 0.26593406593407 },
    ["sorcAureraExposedV5"] = { x = 0.083516483516484, y = 0.10989010989011 },
    ["sorcAureraFlamesV5"] = { x = 0, y = 0.28351648351648 },
    ["sorcAureraRotationV5"] = { x = 0.085714285714286, y = 0.48791208791209 },
    ["sorcAureraSappedV5"] = { x = 0, y = 0.10769230769231 },
    ["sorcAureraThunderV5"] = { x = 0, y = 0.50769230769231 },
    ["tI"] = { x = 0.67032967032967, y = 0.51506849315068 },
  },
  druid = {
    ["(RP) PvP"] = { x = 0.55154639175258, y = 0.14883720930233 },
    ["AtkAll"] = { x = 0.0054112554112554, y = 0.12366737739872 },
    ["AVA"] = { x = 0.0064935064935065, y = 0.62473347547974 },
    ["cI"] = { x = 0.26373626373626, y = 0.51780821917808 },
    ["Co"] = { x = 0.085497835497836, y = 0.59275053304904 },
    ["CUR"] = { x = 0.084415584415584, y = 0.45202558635394 },
    ["druidAureraConservationV5"] = { x = 0.073626373626374, y = 0.28571428571429 },
    ["druidAureraRotationV5"] = { x = 0, y = 0.26813186813187 },
    ["druidAureraSynthesisV5"] = { x = 0.08021978021978, y = 0.12307692307692 },
    ["edAureraAttack"] = { x = 0.011530398322851, y = 0.066037735849057 },
    ["edAureraHeal"] = { x = 0.12054507337526, y = 0.24056603773585 },
    ["edAureraRotation"] = { x = 0.10167714884696, y = 0.058962264150943 },
    ["exori1"] = { x = 0.36793692509855, y = 0.23719676549865 },
    ["exori2"] = { x = 0.44021024967148, y = 0.23854447439353 },
    ["heals"] = { x = 0.51182654402103, y = 0.24258760107817 },
    ["msAureraDecay"] = { x = 0.93396226415094, y = 0.30188679245283 },
    ["msAureraExpose"] = { x = 0.78721174004193, y = 0.17452830188679 },
    ["msAureraFire"] = { x = 0.95702306079665, y = 0.0047169811320755 },
    ["msAureraRotation"] = { x = 0.86373165618449, y = 0 },
    ["msAureraSap"] = { x = 0.77253668763103, y = 0.32311320754717 },
    ["msAureraThunder"] = { x = 0.9601677148847, y = 0.16745283018868 },
    ["runeSelectorV1"] = { x = 0.01, y = 0.05 },
    ["SD"] = { x = 0, y = 0.46908315565032 },
    ["sorcAureraDecayV5"] = { x = 0.43396226415094, y = 0.28537735849057 },
    ["sorcAureraExposedV5"] = { x = 0.01, y = 0.85 },
    ["sorcAureraFlamesV5"] = { x = 0.35324947589099, y = 0.28537735849057 },
    ["sorcAureraRotationV5"] = { x = 0.57861635220126, y = 0.29245283018868 },
    ["sorcAureraSappedV5"] = { x = 0.01, y = 0.65 },
    ["sorcAureraThunderV5"] = { x = 0.51153039832285, y = 0.2877358490566 },
    ["tI"] = { x = 0.67032967032967, y = 0.51506849315068 },
  },
}

local function applyVocationIconPositions(vocation)
  local positions = PVP99_ICON_POSITIONS[vocation]
  if not positions then return false end

  storage._icons = storage._icons or {}

  for id, pos in pairs(positions) do
    storage._icons[id] = storage._icons[id] or {}
    storage._icons[id].x = pos.x
    storage._icons[id].y = pos.y
  end

  return true
end

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

  Label
    id: subtitle
    text: Selecione
    width: 250
    text-align: center
    anchors.top: title.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 2
    color: #d9d0c2
    font: verdana-11px-rounded


  Pvp99VocationCard
    id: knightButton
    anchors.top: subtitle.bottom
    anchors.left: parent.left
    margin-top: 8
    margin-left: 13

    Label
      id: knightImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 3
      size: 42 36
      phantom: true

    Label
      id: knightName
      text: KNIGHT
      width: 112
      text-align: center
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 7
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: knightCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Pvp99VocationCard
    id: monkButton
    anchors.top: subtitle.bottom
    anchors.right: parent.right
    margin-top: 8
    margin-right: 13

    Label
      id: monkImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 3
      size: 42 36
      phantom: true

    Label
      id: monkName
      text: MONK
      width: 112
      text-align: center
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 7
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: monkCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Pvp99VocationCard
    id: paladinButton
    anchors.top: knightButton.bottom
    anchors.left: parent.left
    margin-top: 5
    margin-left: 13

    Label
      id: paladinImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 3
      size: 42 36
      phantom: true

    Label
      id: paladinName
      text: PALADIN
      width: 112
      text-align: center
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 7
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: paladinCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Pvp99VocationCard
    id: sorcererButton
    anchors.top: monkButton.bottom
    anchors.right: parent.right
    margin-top: 5
    margin-right: 13

    Label
      id: sorcererImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 3
      size: 42 36
      phantom: true

    Label
      id: sorcererName
      text: SORCERER
      width: 112
      text-align: center
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 7
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: sorcererCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Pvp99VocationCard
    id: druidButton
    anchors.top: paladinButton.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-top: 5

    Label
      id: druidImage
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      margin-top: 3
      size: 42 36
      phantom: true

    Label
      id: druidName
      text: DRUID
      width: 112
      text-align: center
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      margin-bottom: 7
      color: #ffffff
      font: verdana-11px-rounded
      phantom: true

    Label
      id: druidCheck
      text: ✓
      anchors.top: parent.top
      anchors.right: parent.right
      margin-top: 3
      margin-right: 5
      color: #74ff8b
      font: verdana-11px-rounded
      visible: false
      phantom: true


  Pvp99CancelButton
    id: cancelButton
    text: CANCELAR
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    margin-bottom: 5

]])

local root = g_ui.getRootWidget()
if not root then return end

local old = root:recursiveGetChildById("pvp99VocationWindow")
if old then
  old:destroy()
end

local window = UI.createWindow("Pvp99VocationWindow", root)

local buttons = {
  knight = window:recursiveGetChildById("knightButton"),
  monk = window:recursiveGetChildById("monkButton"),
  paladin = window:recursiveGetChildById("paladinButton"),
  sorcerer = window:recursiveGetChildById("sorcererButton"),
  druid = window:recursiveGetChildById("druidButton")
}

local images = {
  knight = window:recursiveGetChildById("knightImage"),
  monk = window:recursiveGetChildById("monkImage"),
  paladin = window:recursiveGetChildById("paladinImage"),
  sorcerer = window:recursiveGetChildById("sorcererImage"),
  druid = window:recursiveGetChildById("druidImage")
}

local checks = {
  knight = window:recursiveGetChildById("knightCheck"),
  monk = window:recursiveGetChildById("monkCheck"),
  paladin = window:recursiveGetChildById("paladinCheck"),
  sorcerer = window:recursiveGetChildById("sorcererCheck"),
  druid = window:recursiveGetChildById("druidCheck")
}

local names = {
  knight = window:recursiveGetChildById("knightName"),
  monk = window:recursiveGetChildById("monkName"),
  paladin = window:recursiveGetChildById("paladinName"),
  sorcerer = window:recursiveGetChildById("sorcererName"),
  druid = window:recursiveGetChildById("druidName")
}

local title = window:recursiveGetChildById("title")
local subtitle = window:recursiveGetChildById("subtitle")

local function loadRemoteImage(widget, url)
  if not widget or not url then return end

  HTTP.downloadImage(url, function(path, err)
    if err then
      print("[PVP99] Erro imagem: " .. tostring(err))
      return
    end

    if not path then return end

    if widget then
      widget:setImageSource(path)

      if widget.setImageFixedRatio then
        widget:setImageFixedRatio(true)
      end
    end
  end)
end

for key, data in pairs(VOCATIONS) do
  loadRemoteImage(images[key], data.image)
end

-- ============================================================
-- HOVER: BRILHO SOMENTE NO NOME DA VOCACAO
-- ============================================================

local function setNameHighlight(key, hovered)
  local nameWidget = names[key]
  if not nameWidget then return end

  if hovered then
    nameWidget:setColor("#ffd46e")
  else
    nameWidget:setColor("#ffffff")
  end
end

for key, button in pairs(buttons) do
  button.onHoverChange = function(widget, hovered)
    setNameHighlight(key, hovered)
  end
end

local function clearChecks()
  for _, check in pairs(checks) do
    if check then
      check:hide()
    end
  end
end

local function selectVocation(key)
  clearChecks()

  if checks[key] then
    checks[key]:show()
  end
end

local function loadVocation(key)
  if loading then return end

  local data = VOCATIONS[key]
  if not data then return end

  loading = true
  clearChecks()

  -- Aplica as coordenadas do perfil escolhido antes do addIcon criar os icones.
  applyVocationIconPositions(key)

  title:setText("ATIVANDO...")
  title:setColor("#f0d8a0")
  subtitle:hide()

  HTTP.get(BASE_URL .. data.file, function(script)
    loading = false

    if not script or script == "" then
      clearChecks()
      title:setText("ERRO NO MACRO")
      title:setColor("#ff6b6b")
      subtitle:hide()
      print("[PVP99] Falha ao baixar " .. data.name)
      return
    end

    local func, err = loadstring(script)

    if not func then
      clearChecks()
      title:setText("ERRO NO MACRO")
      title:setColor("#ff6b6b")
      subtitle:hide()
      print("[PVP99] Erro no " .. data.name .. ": " .. tostring(err))
      return
    end

    local ok, runError = pcall(func)

    if not ok then
      clearChecks()
      title:setText("ERRO NO MACRO")
      title:setColor("#ff6b6b")
      subtitle:hide()
      print("[PVP99] Erro executando " .. data.name .. ": " .. tostring(runError))
      return
    end

    clearChecks()
    title:setText("MACRO ATIVADO")
    title:setColor("#8dff9c")
    subtitle:hide()

    schedule(850, function()
      if window then
        window:hide()
      end
    end)
  end)
end

buttons.knight.onClick = function() loadVocation("knight") end
buttons.monk.onClick = function() loadVocation("monk") end
buttons.paladin.onClick = function() loadVocation("paladin") end
buttons.sorcerer.onClick = function() loadVocation("sorcerer") end
buttons.druid.onClick = function() loadVocation("druid") end

local cancelButton = window:recursiveGetChildById("cancelButton")

if cancelButton then
  cancelButton.onClick = function()
    if window then
      window:destroy()
      window = nil
    end
  end
end

window:show()
window:raise()
window:focus()
