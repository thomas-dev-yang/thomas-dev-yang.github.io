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
  local bundle_path = "content/" .. slug .. "/index.md"
  local bundle = io.open(bundle_path, "r")
  if file and bundle then
    file:close()
    bundle:close()
    fail(slug, "ambiguous post: both " .. path .. " and " .. bundle_path .. " exist")
  end
  local target = slug .. ".html"
  if bundle then
    file = bundle
    target = slug .. "/"
  end
  if not file then fail(slug, "missing " .. path .. " or " .. bundle_path) end

  local source = file:read("*a")
  file:close()

  local post = pandoc.read(source, "markdown")
  local title = pandoc.utils.stringify(post.meta.title or "")
  local date = pandoc.utils.stringify(post.meta.date or "")

  if title == "" then fail(slug, "missing title metadata") end
  if date == "" then fail(slug, "missing date metadata") end

  return post.meta.title, date, target
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

local function post_link(link)
  if not is_wikilink(link) then return nil end

  local slug = link.target
  local title, date, target = read_post(slug)
  local sort_date = pandoc.utils.normalize_date(date)
  if not sort_date then fail(slug, "invalid date metadata: " .. date) end

  link.target = target
  link.classes:insert("post-entry")
  link.attributes["data-post-date"] = sort_date

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

local function sort_posts(list)
  local entries = {}
  for index, item in ipairs(list.content) do
    -- Only sort lists made entirely of standalone post links.
    if #item ~= 1 or (item[1].t ~= "Plain" and item[1].t ~= "Para") then
      return nil
    end
    local content = item[1].content
    if #content ~= 1 or content[1].t ~= "Link" then return nil end
    local link = content[1]
    local date = link.attributes["data-post-date"]
    if not date then return nil end
    entries[#entries + 1] = {
      item = item, date = date, path = link.target, index = index,
    }
  end

  table.sort(entries, function(a, b)
    if a.date ~= b.date then return a.date > b.date end
    if a.path ~= b.path then return a.path < b.path end
    return a.index < b.index
  end)

  for index, entry in ipairs(entries) do
    list.content[index] = entry.item
  end
  return list
end

return {
  { Link = post_link },
  { BulletList = sort_posts },
}
