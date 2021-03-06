require! <[moment]>

module.exports = ({log, database}, id, name)-->
  err, target <- database.db.get """
    SELECT *
    FROM do
    WHERE id = $id
  """, {$id: id}
  unless target => log.output "[Rename] #id: not found task."; return
  err, id <- database.db.run """
    UPDATE do
    SET name = $name, modified = $modified
    WHERE id = $id
  """, {$id: id, $name: name, $modified: moment!.format \X}
  log.output "[Rename] #{target.id}: #{name} (#{target.modified |> moment.unix >> (.format "YYYY-MM-DD HH:mm:ss")})"

