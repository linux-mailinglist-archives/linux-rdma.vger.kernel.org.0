Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394DC4FA609
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 10:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiDIIgM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Apr 2022 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbiDIIgM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 9 Apr 2022 04:36:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A402AF4
        for <linux-rdma@vger.kernel.org>; Sat,  9 Apr 2022 01:34:05 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kb7dB32kFzDq8g;
        Sat,  9 Apr 2022 16:31:42 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 16:33:32 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 16:33:32 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 3/5] RDMA/hns: Remove redundant variable "ret"
Date:   Sat, 9 Apr 2022 16:32:52 +0800
Message-ID: <20220409083254.9696-4-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220409083254.9696-1-liangwenpeng@huawei.com>
References: <20220409083254.9696-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guofeng Yue <yueguofeng@hisilicon.com>

It is completely redundant for this function to use "ret" to store the
return value of the subfunction.

Signed-off-by: Guofeng Yue <yueguofeng@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index cd87e6e86720..aa3eca16e04a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3257,7 +3257,6 @@ static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
 				  void *mb_buf, struct hns_roce_mr *mr)
 {
 	struct hns_roce_v2_mpt_entry *mpt_entry;
-	int ret;
 
 	mpt_entry = mb_buf;
 	memset(mpt_entry, 0, sizeof(*mpt_entry));
@@ -3296,9 +3295,7 @@ static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
 		     to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.ba_pg_shift));
 	hr_reg_enable(mpt_entry, MPT_INNER_PA_VLD);
 
-	ret = set_mtpt_pbl(hr_dev, mpt_entry, mr);
-
-	return ret;
+	return set_mtpt_pbl(hr_dev, mpt_entry, mr);
 }
 
 static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
-- 
2.33.0

