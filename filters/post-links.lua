local function fail(slug, message)
  error("post link [[" .. slug .. "]]: " .. message)
end

local function is_wikilink(link)
  for _, class in ipairs(link.classes) do
    if class == "wikilink" then return true end
  end
  return false
end

local function read_post(slug)
  if slug:match("^/") or slug:find("..", 1, true) or
      not slug:match("^[%w][%w%._/-]*$") then
    fail(slug, "invalid path")
  end

  local path = "content/" .. slug .. ".md"
  local file = io.open(path, "r")
  if not file then fail(slug, "missing " .. path) end

  local source = file:read("*a")
  file:close()

  local post = pandoc.read(source, "markdown")
  local title = pandoc.utils.stringify(post.meta.title or "")
  local date = pandoc.utils.stringify(post.meta.date or "")

  if title == "" then fail(slug, "missing title metadata") end
  if date == "" then fail(slug, "missing date metadata") end

  return post.meta.title, date
end

function Link(link)
  if not is_wikilink(link) then return nil end

  local slug = link.target
  local title, date = read_post(slug)

  link.content = title
  link.target = slug .. ".html"

  return {
    link,
    pandoc.Space(),
    pandoc.Str("—"),
    pandoc.Space(),
    pandoc.Str(date),
  }
end

