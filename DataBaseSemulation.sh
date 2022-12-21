DBsFolder=$(ls -d */ | grep "DBs")

if [[ "$DBsFolder" != *"DBs"* ]]; then
  mkdir DBs
fi



