local utils = require 'mp.utils'

-- Define shader sets for easy management and updating
local shader_sets = {
    anime_420 = {
        path = {
            "~~/shaders/shaders_anime/Anime4K_Clamp_Highlights.glsl",
            "~~/shaders/shaders_anime/Anime4K_Upscale_Denoise_CNN_x2_M.glsl",
            "~~/shaders/shaders_anime/Anime4K_AutoDownscalePre_x2.glsl",
            "~~/shaders/shaders_anime/Anime4K_AutoDownscalePre_x4.glsl",
            "~~/shaders/shaders_anime/Anime4K_Upscale_CNN_x2_S.glsl",
        },
        message = "Anime4K: Mode C 420p (Fast)"
    },
    anime_720 = {
        path = {
            "~~/shaders/shaders_anime/Anime4K_Clamp_Highlights.glsl",
            "~~/shaders/shaders_anime/Anime4K_Restore_CNN_Soft_M.glsl",
            "~~/shaders/shaders_anime/Anime4K_Upscale_CNN_x2_M.glsl",
            "~~/shaders/shaders_anime/Anime4K_AutoDownscalePre_x2.glsl",
            "~~/shaders/shaders_anime/Anime4K_AutoDownscalePre_x4.glsl",
            "~~/shaders/shaders_anime/Anime4K_Upscale_CNN_x2_S.glsl",
        },
        message = "Anime4K: Mode B 720p (Fast)"
    },
    anime_1080 = {
        path = {
            "~~/shaders/shaders_anime/Anime4K_Clamp_Highlights.glsl",
            "~~/shaders/shaders_anime/Anime4K_Restore_CNN_M.glsl",
            "~~/shaders/shaders_anime/Anime4K_Upscale_CNN_x2_M.glsl",
            "~~/shaders/shaders_anime/Anime4K_AutoDownscalePre_x2.glsl",
            "~~/shaders/shaders_anime/Anime4K_AutoDownscalePre_x4.glsl",
            "~~/shaders/shaders_anime/Anime4K_Upscale_CNN_x2_S.glsl",
        },
        message = "Anime4K: Mode A 1080p (Fast)"
    }
}

-- Function to check if shader files exist
function shaders_exist(shader_paths)
    for _, path in ipairs(shader_paths) do
        local resolved_path = mp.command_native({"expand-path", path})
        if not utils.file_info(resolved_path) then
            return false
        end
    end
    return true
end

function toggle_shaders_conditionally()
    local width, height = mp.get_property_number("width"), mp.get_property_number("height")
    local selected_set = nil

    -- Determine which set of shaders to use based on resolution
    if width < 1280 and height < 720 then
        selected_set = shader_sets.anime_420
    elseif width == 1280 and height == 720 then
        selected_set = shader_sets.anime_720
    elseif width == 1920 and height == 1080 then
        selected_set = shader_sets.anime_1080
    end

    -- Apply the selected set of shaders if any
    if selected_set and shaders_exist(selected_set.path) then
        local shader_command = "no-osd change-list glsl-shaders set \"" .. table.concat(selected_set.path, ":") .. "\"; show-text \"" .. selected_set.message .. "\""
        mp.command(shader_command)
    else
        mp.osd_message("Shader files not found or resolution not matched.")
    end
end

mp.add_key_binding(nil, "toggle_shaders_conditionally", toggle_shaders_conditionally)

