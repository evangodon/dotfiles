
function drop_restore --description "Drop and restore Lane database"
  set dbfile $1
	psql -U lane -d postgres -c 'DROP DATABASE "lane";'
	psql -U lane -d postgres -c 'CREATE DATABASE "lane";'
	pg_restore --no-acl -h localhost --username=lane --verbose --no-owner --dbname=lane $dbfile
	pushd $LANE_NEXT
	yarn db:migrate && yarn db:seed
	psql -U lane -d lane -c 'UPDATE "User" SET "password"='"'"'epsqNQldzf7f3w74EDELQJ44ySwgy9UQiOpeS8SHO9rP6ynxS38u0DPYf60AA22oPVxZen50KbxwzsN4203mpg=='"'"' WHERE "password" != '"'"'tD8dKKPb8wBwvxrnyI7ieEBH/IbXvoYgyFEN672FVbPvC5Y3ak3UlK4FYVgCdLz3owafXAvs7/Y9EjehPU1ytw=='"'"';'
end
