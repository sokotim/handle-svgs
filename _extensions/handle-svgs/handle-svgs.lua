file_ending = ""

if FORMAT:match 'latex' or FORMAT:match 'pdf' or FORMAT:match 'beamer' then file_ending = ".pdf" end

if FORMAT:match 'pptx' or FORMAT:match 'docx' then file_ending = ".emf" end


local function file_exists(name)
  local f = io.open(name, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

function convert_with_inkscape(source_filename, export_filename)
  os.execute("inkscape " .. source_filename .. " --export-filename " .. export_filename)
end

function Image(elem)
  if file_ending and elem.src:match(".svg$") then
    local export_filename = elem.src .. file_ending
    if not file_exists(export_filename) then
      convert_with_inkscape(elem.src, export_filename)
    end
    elem.src = export_filename
  end
  return elem
end
