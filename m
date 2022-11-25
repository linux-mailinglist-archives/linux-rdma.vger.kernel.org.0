Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D446388FF
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Nov 2022 12:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiKYLnq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Nov 2022 06:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKYLnp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Nov 2022 06:43:45 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12ADBE1D;
        Fri, 25 Nov 2022 03:43:44 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NJXzx4p5Hz15Mv1;
        Fri, 25 Nov 2022 19:43:09 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 19:43:42 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <bvanassche@acm.org>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <dennis.dalessandro@cornelisnetworks.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <bart.vanassche@wdc.com>,
        <easwar.hariharan@intel.com>, Wang Yufen <wangyufen@huawei.com>
Subject: [PATCH 1/2] RDMA/hfi1: Fix error return code in parse_platform_config()
Date:   Fri, 25 Nov 2022 20:03:50 +0800
Message-ID: <1669377831-41386-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In the previous while loop, "ret" may be assigned zero. Therefore,
"ret" needs to be assigned -EINVAL at the beginning of each loop.

Fixes: 97167e813415 ("staging/rdma/hfi1: Tune for unknown channel if configuration file is absent")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
---
 drivers/infiniband/hw/hfi1/firmware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/hfi1/firmware.c b/drivers/infiniband/hw/hfi1/firmware.c
index 1d77514..c179dfe 100644
--- a/drivers/infiniband/hw/hfi1/firmware.c
+++ b/drivers/infiniband/hw/hfi1/firmware.c
@@ -1788,6 +1788,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
 	 * being used.
 	 */
 	while (ptr < (u32 *)(dd->platform_config.data + file_length)) {
+		ret = -EINVAL;
 		header1 = *ptr;
 		header2 = *(ptr + 1);
 		if (header1 != ~header2) {
-- 
1.8.3.1

