----------
-- contains all the important scrips that might be used for this SP
----------

-- Get all the links that branch off this pages
SELECT (id, link_text) FROM pages WHERE parent_id = %%%;


SELECT (id, title)