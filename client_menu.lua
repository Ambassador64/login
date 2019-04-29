	--PERSONAL ACCOUNT TABLE--
	--------------------------
	--outputChatBox(tostring(setElementData(getPlayerFromName("Ambassador46"), "org", nil, true)))
	addEventHandler("login-menu:close", localPlayer, function(username)
		outputChatBox(tostring(username).." test.")
		
		sUsername = getElementData(localPlayer, "username")
		sGang = getElementData(localPlayer, "org")
		outputChatBox(sUsername.." "..sGang)
		exports.dxgui_v1:dxSetText(uUsernameLabel, "User: "..tostring(sUsername))
		exports.dxgui_v1:dxSetText(uGangLabel, "Organization: "..tostring(sGang))
	end)
	
	--------------------------
	
	--UTILITY--
	-----------
	-- Number check is from client territories
	
	function RGBToHexZeroX(red, green, blue, alpha)
		if(numberCheck(red)) then
			red = tonumber(red)
			if (red < 0 or red > 255) then
				red = 120
			end
		else return end
		if (numberCheck(green)) then
			green = tonumber(green)
			if (green < 0 or green > 255) then
				green = 120
			end
		else return end
		if (numberCheck(blue)) then
			blue = tonumber(blue)
			if (blue < 0 or blue > 255) then
				blue = 120
			end
		else return end
		if (numberCheck(alpha)) then
			alpha = tonumber(alpha)
			if (alpha < 0 or alpha > 255) then
				alpha = 120
			end
		else return end
		
		if(alpha) then
			return string.format("0x%.2X%.2X%.2X%.2X", red,green,blue,alpha)
		else
			return string.format("0x%.2X%.2X%.2X", red,green,blue)
		end
	end
	
	--ABILITY TO TOGGLE MENU--
	--------------------------
	local lastCurrentTab = "" -- Put this here so toggleMenu can use it
	
	local isOpen
	function toggleMenu(buttonParam, stateParam)
		if (buttonParam ~= "F1" and stateParam ~= "up") then -- If F1 wasn't pressed and released, do not continue
			return
		end
		
		if (isOpen) then -- If true then make it false
			isOpen = false
			lastCurrentTab = "" --The menu will only open is isOpen is true, we wanna make the lastCurrentTab nothing so the same stuff pops up again
		else
			isOpen = true -- else if it's false then make it true
		end
	end
	
	bindKey("F1", "up", toggleMenu)
	--------------------------
	
	--WHEN THE TCURRENT TABLES CHANGE--
	-----------------------------------
	local sCurrentTab = "Profile"
	
	function switch(sCurrentTabPara)
		if (sCurrentTabPara) then
			if (lastCurrentTab ~= sCurrentTabPara) then -- If the last tab variable isn't the current..
				lastCurrentTab = sCurrentTabPara  -- Make the last current tab equal current
				return false -- Return false so tables update
			else
				return true
			end
		end
	end
	
	addEvent("menu:force-switch", true)
	addEventHandler("menu:force-switch", localPlayer, function()
		lastCurrentTab = ""
	end)
	
	function setDxVisibleFalseInTable()
		for i, v in pairs(tCurrentDxVisible) do
			--outputChatBox("Switching to Profile: "..i.." "..tostring(v))
			exports.dxgui_v1:dxSetVisible(v, false)
			tCurrentDxVisible[i] = nil
			--table.remove(tCurrentDxVisible, i) table.remove DONT WORK
		end
	end
	
	function setGuiVisibleFalseInTable()
		for i, v in pairs(tCurrentGuiVisible) do
			guiSetVisible(v, false)
			tCurrentGuiVisible[i] = nil
			--table.remove(tCurrentGuiVisible, i) table.remove DONT WORK
		end
	end
	
	function setDxVisibleTrueInTable()
		for i, v in pairs(tCurrentDxVisible) do
		--	outputChatBox("Current profile indices and values: "..i.." "..tostring(v))
			exports.dxgui_v1:dxSetVisible(v, true)
		end
	end
	
	function setGuiVisibleTrueInTable()
		for i, v in pairs(tCurrentGuiVisible) do
			guiSetVisible(v, true)
		end
	end
		
	
	-----------------------------------
	
	
	
	local iScreenWidth, iScreenHeight = guiGetScreenSize()
	local bIsOpen = false
	
	local iBackgroundWidth, iBackgroundHeight = 800, 500
	local iBackgroundX, iBackgroundY = (iScreenWidth / 2) - (iBackgroundWidth / 2), (iScreenHeight / 2) - (iBackgroundHeight / 2)
	
	local bAnimDirection = false
	local bAnimStopped = false
	
	
	local iButtonsY = (iScreenHeight / 2) - (iBackgroundHeight / 2) + 5
	local iButtonsW = 100
	
	local iButton1X = (iScreenWidth / 2) - (iBackgroundWidth / 2) + 10
	local iButton2X = iButton1X + iButtonsW + 10
	local iButton3X = iButton2X + iButtonsW + 10
	
	local tButtons = 
	{
	[1] = exports.dxgui_v1:dxCreateButton(iButton1X, iButtonsY, iButtonsW, 30, "Profile"),
	[2] = exports.dxgui_v1:dxCreateButton(iButton2X, iButtonsY, iButtonsW, 30, "Organization"),
	[3] = exports.dxgui_v1:dxCreateButton(iButton3X, iButtonsY, iButtonsW, 30, "Settings")
	}
	local iCenterWindowH = iBackgroundHeight - 70 - 15
	local uCenterWindow = exports.dxGUI_v1:dxCreateWindow(iButton1X,iButtonsY+40, 780, iCenterWindowH,sCurrentTab, tocolor(10,10,10,127))
	exports.dxGUI_v1:dxWindowSetMovable(uCenterWindow, false)
	--exports.dxGUI_v1:dxWindowSetTitleVisible(uCenterWindow, false)
	exports.dxgui_v1:dxSetVisible(uCenterWindow, false)
	
	for i, v in ipairs(tButtons) do
		exports.dxgui_v1:dxSetVisible(v, false)
	end
	
	local iProfileLabelsX = iButton1X+5
	local iUsernameLabelY = iButtonsY+60
	local sUsername = getElementData(localPlayer, "username") or "none"
	local uUsernameLabel = exports.dxGUI_v1:dxCreateLabel(iProfileLabelsX, iUsernameLabelY, 30, 20, "Username: "..sUsername)
	exports.dxgui_v1:dxSetVisible(uUsernameLabel, false)
	
	local iGangLabelY = iUsernameLabelY + 40
	local sGang = getElementData(localPlayer, "org") or "none"
	local uGangLabel = exports.dxGUI_v1:dxCreateLabel(iProfileLabelsX, iGangLabelY, 30, 20, "Organization: "..sGang)
	exports.dxgui_v1:dxSetVisible(uGangLabel, false)
	
	local iRankLabelY = iGangLabelY + 40
	local sRank = "none"
	local uRankLabel = exports.dxGUI_v1:dxCreateLabel(iProfileLabelsX, iRankLabelY, 30, 20, "Rank: "..sRank)
	exports.dxgui_v1:dxSetVisible(uRankLabel, false)
	
	local iWalletBalanceLabelY = iRankLabelY + 40
	local iWalletBalance = 0
	local uWalletBalanceLabel = exports.dxGUI_v1:dxCreateLabel(iProfileLabelsX, iWalletBalanceLabelY, 30, 20, "Wallet Balance: "..iWalletBalance)
	exports.dxgui_v1:dxSetVisible(uWalletBalanceLabel, false)
	
	local iBankBalanceLabelY = iWalletBalanceLabelY + 40
	local iBankBalance = 0
	local uBankBalanceLabel = exports.dxGUI_v1:dxCreateLabel(iProfileLabelsX, iBankBalanceLabelY, 30, 20, "Bank Balance: "..iWalletBalance)
	exports.dxgui_v1:dxSetVisible(uBankBalanceLabel, false)
	
	
	--Independent without an organization options--
	local iOrganizationLabelsX = iButton1X+5
	local iCreateGangLabelY = iButtonsY+60
	local sCreateGang = "Independent"
	local uCreateGangLabel = exports.dxGUI_v1:dxCreateLabel(iOrganizationLabelsX, iCreateGangLabelY, 30, 20, sCreateGang)
	exports.dxgui_v1:dxSetVisible(uCreateGangLabel, false)
	
	local iCreateGangEditX = iOrganizationLabelsX + 5
	local iCreateGangEditY = iCreateGangLabelY + 30
	local uCreateGangEdit = guiCreateEdit(iCreateGangEditX, iCreateGangEditY, 200, 20, "", false)
	guiSetVisible(uCreateGangEdit, false)
	
	local iCreateGangButtonX = iOrganizationLabelsX + 5
	local iCreateGangButtonY = iCreateGangEditY + 30
	local uCreateGangButton = exports.dxgui_v1:dxCreateButton(iCreateGangButtonX, iCreateGangButtonY, 100, 30, "Create Gang", false)
	exports.dxgui_v1:dxSetVisible(uCreateGangButton, false)
	
	local iColorRx = iCreateGangButtonX + 210
	local iColorsRgba = iCreateGangEditY
	local uColorButtonR = guiCreateEdit(iColorRx, iColorsRgba, 50, 20, "", false)
	guiSetVisible(uColorButtonR, false)
	
	local iColorGx = iColorRx + 50
	local uColorButtonG = guiCreateEdit(iColorGx, iColorsRgba, 50, 20, "", false)
	guiSetVisible(uColorButtonG, false)
	
	local iColorBx = iColorGx + 50
	local uColorButtonB = guiCreateEdit(iColorBx, iColorsRgba, 50, 20, "", false)
	guiSetVisible(uColorButtonB, false)
	
	local iColorAx = iColorBx + 50
	local uColorButtonA = guiCreateEdit(iColorAx, iColorsRgba, 50, 20, "", false)
	guiSetVisible(uColorButtonA, false)
	
	--
	
	local iColorLabels = iColorsRgba + 30
	local uRedLabel = exports.dxGUI_v1:dxCreateLabel(iColorRx, iCreateGangLabelY, 30, 20, "R")
	exports.dxgui_v1:dxSetVisible(uRedLabel, false)
	
	local uGreenLabel = exports.dxGUI_v1:dxCreateLabel(iColorGx, iCreateGangLabelY, 30, 20, "G")
	exports.dxgui_v1:dxSetVisible(uGreenLabel, false)
	
	local uBlueLabel = exports.dxGUI_v1:dxCreateLabel(iColorBx, iCreateGangLabelY, 30, 20, "B")
	exports.dxgui_v1:dxSetVisible(uBlueLabel, false)
	
	local uAlphaLabel = exports.dxGUI_v1:dxCreateLabel(iColorAx, iCreateGangLabelY, 30, 20, "A")
	exports.dxgui_v1:dxSetVisible(uAlphaLabel, false)
	
	function showColor()
		local red = guiGetText(uColorButtonR)
		local green = guiGetText(uColorButtonG)
		local blue = guiGetText(uColorButtonB)
		local alpha = guiGetText(uColorButtonA)
		
		local sHexColor = RGBToHexZeroX(red, green, blue, alpha) -- Used from client_territories
		if sHexColor then
			dxDrawRectangle(iColorRx, iColorsRgba + 20, 200, 20, sHexColor, true)
		end
	end
		
	
	--Independent as a leader options--
	local sGangName = getElementData(localPlayer, "org")
	local uGangLabelName = exports.dxGUI_v1:dxCreateLabel(iOrganizationLabelsX, iCreateGangLabelY, 30, 20, getElementData(localPlayer, "org") or "none")
	exports.dxgui_v1:dxSetVisible(uGangLabelName, false)
	
	local iDestroyGangButtonX = iOrganizationLabelsX + 5
	local iDestroyGangButtonY = iCreateGangEditY + 30
	local uDestroyGangButton = exports.dxgui_v1:dxCreateButton(iCreateGangButtonX, iCreateGangButtonY, 100, 30, "Destroy Gang", false)
	exports.dxgui_v1:dxSetVisible(uDestroyGangButton, false)
	
	
	addEventHandler("onClientRender", root, function()
		
		if (isOpen) then
			showCursor(true, true)
			if not tCurrentDxVisible then 
				tCurrentDxVisible = 
				{
					--uUsernameLabel, uGangLabel, uRankLabel, uWalletBalanceLabel, uBankBalanceLabel
				}
			end
			
			if not tCurrentGuiVisible then 
				tCurrentGuiVisible = {}
			end
			
			dxDrawRectangle(iBackgroundX, iBackgroundY, iBackgroundWidth, iBackgroundHeight, tocolor(0, 0, 0, 127)) --77000000
			
			if(not exports.dxgui_v1:dxGetVisible(tButtons[1])) then
				for i, _ in ipairs(tButtons) do
					exports.dxgui_v1:dxSetVisible(tButtons[i], true)
				end
				exports.dxgui_v1:dxSetVisible(uCenterWindow, true)
			end
			
			if (sCurrentTab == "Profile") then
				
				
				if (not switch(sCurrentTab)) then
					setDxVisibleFalseInTable()
					setGuiVisibleFalseInTable()
					
					
					if(exports.dxgui_v1:dxGetText(uGangLabel) ~= "Organization: "..tostring(getElementData(localPlayer, "org"))) then 
						exports.dxgui_v1:dxSetText(uGangLabel, "Organization: "..tostring(getElementData(localPlayer, "org")))
					end
					if(exports.dxgui_v1:dxGetText(uUsernameLabel) ~= "Username: "..getPlayerName(localPlayer)) then 
						exports.dxgui_v1:dxSetText(uUsernameLabel, "Username: "..getPlayerName(localPlayer))
					end
					table.insert(tCurrentDxVisible, uUsernameLabel)
					table.insert(tCurrentDxVisible, uGangLabel)
					table.insert(tCurrentDxVisible, uRankLabel)
					table.insert(tCurrentDxVisible, uWalletBalanceLabel)
					table.insert(tCurrentDxVisible, uBankBalanceLabel)
					
					
					setDxVisibleTrueInTable()
					-- No GUI's yet
				end
			end
			if (sCurrentTab == "Organization") then
				--outputChatBox(getElementData(localPlayer, "org").." Is getElementData in organization")
				if (not switch(sCurrentTab) ) then --or not exports.dxgui_v1:dxGetVisible(uCreateGangLabel)
					setDxVisibleFalseInTable()
					setGuiVisibleFalseInTable()
					
					if (getElementData(localPlayer, "org") == "Independent") then
						table.insert(tCurrentDxVisible, uCreateGangLabel)
						table.insert(tCurrentDxVisible, uCreateGangButton)
						
						table.insert(tCurrentGuiVisible, uCreateGangEdit)
						table.insert(tCurrentGuiVisible, uColorButtonR)
						table.insert(tCurrentGuiVisible, uColorButtonG)
						table.insert(tCurrentGuiVisible, uColorButtonB)
						table.insert(tCurrentGuiVisible, uColorButtonA)
						
						table.insert(tCurrentDxVisible, uRedLabel)
						table.insert(tCurrentDxVisible, uGreenLabel)
						table.insert(tCurrentDxVisible, uBlueLabel)
						table.insert(tCurrentDxVisible, uAlphaLabel)
						showColor()
					elseif (getElementData(localPlayer, "org")) then
						if(exports.dxgui_v1:dxGetText(uGangLabelName) ~= "Organization: "..tostring(getElementData(localPlayer, "org"))) then 
							exports.dxgui_v1:dxSetText(uGangLabelName, "Organization: "..tostring(getElementData(localPlayer, "org")))
						end
						table.insert(tCurrentDxVisible, uGangLabelName)
						table.insert(tCurrentDxVisible, uDestroyGangButton)
					end
					
					setDxVisibleTrueInTable()
					setGuiVisibleTrueInTable()
				end
			end
		
			
		else
			showCursor(false, false)
			if(exports.dxgui_v1:dxGetVisible(tButtons[1])) then
				for i, _ in ipairs(tButtons) do
					exports.dxgui_v1:dxSetVisible(tButtons[i], false)
				end
				exports.dxgui_v1:dxSetVisible(uCenterWindow, false)
				for i, v in pairs(tCurrentDxVisible) do
					exports.dxgui_v1:dxSetVisible(v, false)
				end
				for i, v in pairs(tCurrentGuiVisible) do
					guiSetVisible(v, false)
				end
			end
		end
	end)
	
	
	addEventHandler("onClientDXClick", uCreateGangButton, function(button, state)
		if (button ~= "left" or state ~= "up") then
			return
		end
		
		local bGangEditInputIsValid = true
		local sGangName = guiGetText(uCreateGangEdit)
		if (sGangName == "") then
			--guiInvalidMessage(errorLabel, "A name is required.")
			bGangEditInputIsValid = false
		elseif (string.len(sGangName) > 22 or string.len(sGangName) < 3) then
			bGangEditInputIsValid = false
			--Your gang name can only be 3-22 characters long
		elseif (sGangName == "Independent" or sGangName == "indepedent") then
			-- This name is not allowed.
		end
		
		if not( bGangEditInputIsValid )then
			return
		end
		
		triggerServerEvent("menu:gang-create-attempt", localPlayer, sGangName)
		
	end)
	
	addEventHandler("onClientDXClick", uDestroyGangButton, function(button, state)
		if (button ~= "left" or state ~= "up") then
			return
		end
		triggerServerEvent("menu:gang-destroy-attempt", localPlayer)
	end)
	
	addEventHandler("onClientDXClick", root, function(button, state)
		if (button ~= "left" or state ~= "up") then
			return
		end
		
		if (source == tButtons[1]) then
			sCurrentTab = "Profile"
		elseif (source == tButtons[2]) then
			sCurrentTab = "Organization"
		elseif (source == tButtons[3]) then
			sCurrentTab = "Settings"
		end
	end)
	
	-------------ULTILITIES-----------
	----------------------------------
	local animationTimeStop, animationTimeStart = 0, 0
	local valueStart, valueEnd = 0, 0
	local animationHasStarted = false
	local value = 0
	
	function setAlphaCheck(errorLabelPara, valuePara)
		if (not errorLabelPara or not valuePara) then
			return
		end
		guiSetAlpha(errorLabelPara, valuePara)
	end
	
	local function onRendering()
		if (animationHasStarted) then
			local progress = 1 / ((animationTimeStop - animationTimeStart) / (getTickCount() - animationTimeStart))
			
			if (getTickCount() >= animationTimeStop) then
				progress = 1
				value = 0
				animationHasStarted = false
			else
			value = valueStart + ((valueEnd - valueStart) * progress)
			end

		end
		
		setAlphaCheck(errorLabel, value)
		-- Below works, renable it later
		--guiSetAlpha(errorLabel, value) -- Bug the script keeps checking for this even after the window has been deleted

	end
	
	local function fadeAnimation(seconds, guiElement)
		animationHasStarted = true
		value = 1

		valueStart = value
		valueEnd = 0
		
		animationTimeStart = getTickCount()
		animationTimeStop = getTickCount() + (seconds * 1000)
	end	

	local function guiInvalidMessage (label, errorMessage)
		guiSetText(label, errorMessage)
		guiSetAlpha(label, 1)
		
		fadeAnimation(5, errorLabel)
	end
	----------------------------------
	
	-----------EVENTS FOR UTILITIE----
	----------------------------------
	
	addEventHandler("onClientRender", root, onRendering)
	
	----------------------------------
	
		
		
