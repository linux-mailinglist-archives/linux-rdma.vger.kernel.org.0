Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F1763961E
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Nov 2022 14:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiKZNaw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Nov 2022 08:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKZNaw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 26 Nov 2022 08:30:52 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF671C90F;
        Sat, 26 Nov 2022 05:30:49 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NKCF40cN7zpWBc;
        Sat, 26 Nov 2022 21:26:48 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 21:30:46 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <bvanassche@acm.org>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <dennis.dalessandro@cornelisnetworks.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <bart.vanassche@wdc.com>,
        <easwar.hariharan@intel.com>, Wang Yufen <wangyufen@huawei.com>
Subject: [PATCH v3 1/2] RDMA/hfi1: Fix error return code in parse_platform_config()
Date:   Sat, 26 Nov 2022 21:50:53 +0800
Message-ID: <1669470654-45828-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In the previous while loop, "ret" may be assigned zero, so the error
return code may be incorrectly set to 0 instead of -EINVAL.
Add bail_with_einval goto label and covert all "goto bail;" to "goto
bail_with_einval:" where it's appropriate. Add dropping some duplicative
"ret = -EINVAL;" lines, as Andy suggessted.

Fixes: 97167e813415 ("staging/rdma/hfi1: Tune for unknown channel if configuration file is absent")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/infiniband/hw/hfi1/firmware.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/firmware.c b/drivers/infiniband/hw/hfi1/firmware.c
index 1d77514..44d8628 100644
--- a/drivers/infiniband/hw/hfi1/firmware.c
+++ b/drivers/infiniband/hw/hfi1/firmware.c
@@ -1730,7 +1730,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
 	u32 *ptr = NULL;
 	u32 header1 = 0, header2 = 0, magic_num = 0, crc = 0, file_length = 0;
 	u32 record_idx = 0, table_type = 0, table_length_dwords = 0;
-	int ret = -EINVAL; /* assume failure */
+	int ret;
 
 	/*
 	 * For integrated devices that did not fall back to the default file,
@@ -1743,7 +1743,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
 
 	if (!dd->platform_config.data) {
 		dd_dev_err(dd, "%s: Missing config file\n", __func__);
-		goto bail;
+		goto bail_with_einval;
 	}
 	ptr = (u32 *)dd->platform_config.data;
 
@@ -1751,7 +1751,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
 	ptr++;
 	if (magic_num != PLATFORM_CONFIG_MAGIC_NUM) {
 		dd_dev_err(dd, "%s: Bad config file\n", __func__);
-		goto bail;
+		goto bail_with_einval;
 	}
 
 	/* Field is file size in DWORDs */
@@ -1774,7 +1774,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
 	if (file_length > dd->platform_config.size) {
 		dd_dev_info(dd, "%s:File claims to be larger than read size\n",
 			    __func__);
-		goto bail;
+		goto bail_with_einval;
 	} else if (file_length < dd->platform_config.size) {
 		dd_dev_info(dd,
 			    "%s:File claims to be smaller than read size, continuing\n",
@@ -1794,7 +1794,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
 			dd_dev_err(dd, "%s: Failed validation at offset %ld\n",
 				   __func__, (ptr - (u32 *)
 					      dd->platform_config.data));
-			goto bail;
+			goto bail_with_einval;
 		}
 
 		record_idx = *ptr &
@@ -1837,7 +1837,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
 					   __func__, table_type,
 					   (ptr - (u32 *)
 					    dd->platform_config.data));
-				goto bail; /* We don't trust this file now */
+				goto bail_with_einval; /* We don't trust this file now */
 			}
 			pcfgcache->config_tables[table_type].table = ptr;
 		} else {
@@ -1856,7 +1856,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
 					   __func__, table_type,
 					   (ptr -
 					    (u32 *)dd->platform_config.data));
-				goto bail; /* We don't trust this file now */
+				goto bail_with_einval; /* We don't trust this file now */
 			}
 			pcfgcache->config_tables[table_type].table_metadata =
 									ptr;
@@ -1873,8 +1873,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
 			dd_dev_err(dd, "%s: Failed CRC check at offset %ld\n",
 				   __func__, (ptr -
 				   (u32 *)dd->platform_config.data));
-			ret = -EINVAL;
-			goto bail;
+			goto bail_with_einval;
 		}
 		/* Jump the CRC DWORD */
 		ptr++;
@@ -1882,6 +1881,9 @@ int parse_platform_config(struct hfi1_devdata *dd)
 
 	pcfgcache->cache_valid = 1;
 	return 0;
+
+bail_with_einval:
+	ret = -EINVAL;
 bail:
 	memset(pcfgcache, 0, sizeof(struct platform_config_cache));
 	return ret;
-- 
1.8.3.1

