        local Players = game:GetService("Players")
            local CoreGui = game:GetService("CoreGui")

            if getgenv().HighlightESP then
                return
            end

            getgenv().HighlightESP = true

            local LocalPlayer = Players.LocalPlayer
            local ESPs = {}

            local function onPlayerAdded(player, Player)
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(160, 32, 240)
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.RobloxLocked = true
                ESPs[player] = highlight
                highlight.Parent = CoreGui

                local function onCharacterAdded(character, Model)
                    highlight.Adornee = character
                end

                player.CharacterAdded:Connect(onCharacterAdded)
                do
                    local character = player.Character
                    if character then
                        onCharacterAdded(character)
                    end
                end
            end

            local function onPlayerRemoving(player, Player)
                local highlight = ESPs[player]
                highlight:Destroy()
                ESPs[player] = nil
            end

            Players.PlayerAdded:Connect(onPlayerAdded)
            Players.PlayerRemoving:Connect(onPlayerRemoving)

            for i, v in ipairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then
                    onPlayerAdded(v)
                end
            end
