#!bin/bash

# This script will make a single SQL file from all the SQL files in the current directory
# It will also add a DROP TABLE IF EXISTS statement to the beginning of the file

# Name of the SQL file to be created
SQL_NAME="create_and_insert_all.sql"

# Remove the old SQL file if it exists
if [ -f $SQL_NAME ]; then
    rm $SQL_NAME
fi

# Read all the SQL files in the current directory
# Add the contents of the file to the SQL file
cat "create_table.sql" >> $SQL_NAME
# Add a new line to the SQL file
echo "" >> $SQL_NAME

cat "create_trigger.sql" >> $SQL_NAME
echo "" >> $SQL_NAME

cat "create_function.sql" >> $SQL_NAME
echo "" >> $SQL_NAME

cat "create_procedure.sql" >> $SQL_NAME
echo "" >> $SQL_NAME

cat "insert_room.sql" >> $SQL_NAME
echo "" >> $SQL_NAME

cat "insert_department.sql" >> $SQL_NAME
echo "" >> $SQL_NAME

cat "insert_user.sql" >> $SQL_NAME
echo "" >> $SQL_NAME

cat "insert_course.sql" >> $SQL_NAME
echo "" >> $SQL_NAME

cat "insert_class.sql" >> $SQL_NAME
echo "" >> $SQL_NAME

cat "insert_enroll.sql" >> $SQL_NAME
echo "" >> $SQL_NAME



echo "SQL file created!"