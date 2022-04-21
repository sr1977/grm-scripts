for cert in `keytool -list -keystore ../keystores/kafkaconnecteventupdate-test-keystore.jks -storepass j4tn3489jgns | grep trustedCertEntry | grep -Eo "^[^,]*"`;do
    `keytool -exportcert -keystore cacerts -alias $cert -file ${cert}.crt <<< $'cwj4tn3489jgns'`
done
