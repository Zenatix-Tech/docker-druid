-- INSERT INTO druid_segments (id, dataSource, created_date, start, end, partitioned, version, used, payload) VALUES ('wikipedia_2013-08-01T00:00:00.000Z_2013-08-02T00:00:00.000Z_2013-08-08T21:22:48.989Z', 'wikipedia', '2013-08-08T21:26:23.799Z', '2013-08-01T00:00:00.000Z', '2013-08-02T00:00:00.000Z', '0', '2013-08-08T21:22:48.989Z', '1', '{\"dataSource\":\"wikipedia\",\"interval\":\"2013-08-01T00:00:00.000Z/2013-08-02T00:00:00.000Z\",\"version\":\"2013-08-08T21:22:48.989Z\",\"loadSpec\":{\"type\":\"s3_zip\",\"bucket\":\"static.druid.io\",\"key\":\"data/segments/wikipedia/20130801T000000.000Z_20130802T000000.000Z/2013-08-08T21_22_48.989Z/0/index.zip\"},\"dimensions\":\"dma_code,continent_code,geo,area_code,robot,country_name,network,city,namespace,anonymous,unpatrolled,page,postal_code,language,newpage,user,region_lookup\",\"metrics\":\"count,delta,variation,added,deleted\",\"shardSpec\":{\"type\":\"none\"},\"binaryVersion\":9,\"size\":24664730,\"identifier\":\"wikipedia_2013-08-01T00:00:00.000Z_2013-08-02T00:00:00.000Z_2013-08-08T21:22:48.989Z\"}');
