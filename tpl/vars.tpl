set_var EASYRSA                 "$PWD"
set_var EASYRSA_PKI             "$EASYRSA/pki"
set_var EASYRSA_DN              "cn_only"
set_var EASYRSA_REQ_COUNTRY     "US"
set_var EASYRSA_REQ_PROVINCE    "NJ"
set_var EASYRSA_REQ_CITY        "Matawan"
set_var EASYRSA_REQ_ORG         "Test CERTIFICATE AUTHORITY"
set_var EASYRSA_REQ_EMAIL	"admin@test.test"
set_var EASYRSA_REQ_OU          "Test EASY CA"
set_var EASYRSA_KEY_SIZE        2048
set_var EASYRSA_ALGO            rsa
set_var EASYRSA_CA_EXPIRE	7500
set_var EASYRSA_CERT_EXPIRE     365
set_var EASYRSA_NS_SUPPORT	"no"
set_var EASYRSA_NS_COMMENT	"Test CERTIFICATE AUTHORITY"
set_var EASYRSA_EXT_DIR         "$EASYRSA/x509-types"
set_var EASYRSA_SSL_CONF        "$EASYRSA/openssl-easyrsa.cnf"
set_var EASYRSA_DIGEST          "sha256"
set_var EASYRSA_BATCH		"1"
#set_var EASYRSA_CRL_DAYS	365
