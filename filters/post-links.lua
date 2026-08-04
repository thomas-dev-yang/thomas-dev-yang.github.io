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

local function display_date(date)
  local months = {
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
  }
  local year, month, day = date:match("^(%d%d%d%d)%-(%d%d)%-(%d%d)$")
  local month_name = month and months[tonumber(month)]

  if not month_name then return date end
  return month_name .. " " .. tonumber(day) .. ", " .. year
end

function Link(link)
  if not is_wikilink(link) then return nil end

  local slug = link.target
  local title, date = read_post(slug)

  link.target = slug .. ".html"
  link.classes:insert("post-entry")

  local date_badge = pandoc.Span(
    { pandoc.Str(display_date(date)) },
    pandoc.Attr("", { "post-date" })
  )
  local title_text = pandoc.Span(
    title,
    pandoc.Attr("", { "post-title" })
  )

  link.content = { title_text, date_badge }
  return link
end
