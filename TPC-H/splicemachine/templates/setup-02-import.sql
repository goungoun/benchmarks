call SYSCS_UTIL.IMPORT_DATA ('##SCHEMA##', 'LINEITEM', null, 's3a://splice-benchmark-data/flat/TPCH/##SCALE##/lineitem', '|', null, null, null, null, 0, '/tmp', true, null);
call SYSCS_UTIL.IMPORT_DATA ('##SCHEMA##', 'ORDERS',   null, 's3a://splice-benchmark-data/flat/TPCH/##SCALE##/orders',   '|', null, null, null, null, 0, '/tmp', true, null);
call SYSCS_UTIL.IMPORT_DATA ('##SCHEMA##', 'CUSTOMER', null, 's3a://splice-benchmark-data/flat/TPCH/##SCALE##/customer', '|', null, null, null, null, 0, '/tmp', true, null);
call SYSCS_UTIL.IMPORT_DATA ('##SCHEMA##', 'PARTSUPP', null, 's3a://splice-benchmark-data/flat/TPCH/##SCALE##/partsupp', '|', null, null, null, null, 0, '/tmp', true, null);
call SYSCS_UTIL.IMPORT_DATA ('##SCHEMA##', 'SUPPLIER', null, 's3a://splice-benchmark-data/flat/TPCH/##SCALE##/supplier', '|', null, null, null, null, 0, '/tmp', true, null);
call SYSCS_UTIL.IMPORT_DATA ('##SCHEMA##', 'PART',     null, 's3a://splice-benchmark-data/flat/TPCH/##SCALE##/part',     '|', null, null, null, null, 0, '/tmp', true, null);
call SYSCS_UTIL.IMPORT_DATA ('##SCHEMA##', 'REGION',   null, 's3a://splice-benchmark-data/flat/TPCH/##SCALE##/region',   '|', null, null, null, null, 0, '/tmp', true, null);
call SYSCS_UTIL.IMPORT_DATA ('##SCHEMA##', 'NATION',   null, 's3a://splice-benchmark-data/flat/TPCH/##SCALE##/nation',   '|', null, null, null, null, 0, '/tmp', true, null);
