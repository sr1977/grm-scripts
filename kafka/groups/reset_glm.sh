date=${1:?No date given, should be in form 'YYYY-MM-DDTHH:mm'}
./reset_glm_kafkaconnect.sh $date
./reset_glm_metadata.sh $date
./reset_glm_results.sh $date
./reset_glm_runup.sh $date
