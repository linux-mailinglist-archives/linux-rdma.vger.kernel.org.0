Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D5477AF46
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Aug 2023 03:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjHNB6u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 21:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjHNB6m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 21:58:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149E4E54
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 18:58:41 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPHXT06L3ztRdm;
        Mon, 14 Aug 2023 09:55:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 09:58:38 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linux-rdma@vger.kernel.org>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v2] RDMA/irdma: Silence the warnings in irdma_uk_rdma_write()
Date:   Mon, 14 Aug 2023 09:58:05 +0800
Message-ID: <20230814015805.1002656-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove sparse warnings introduced by commit 272bba19d631 ("RDMA: Remove
unnecessary ternary operators"):

drivers/infiniband/hw/irdma/uk.c:285:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
drivers/infiniband/hw/irdma/uk.c:285:24: sparse:     expected bool [usertype] push_wqe:1
drivers/infiniband/hw/irdma/uk.c:285:24: sparse:     got restricted __le32 [usertype] *push_db
drivers/infiniband/hw/irdma/uk.c:386:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
drivers/infiniband/hw/irdma/uk.c:386:24: sparse:     expected bool [usertype] push_wqe:1
drivers/infiniband/hw/irdma/uk.c:386:24: sparse:     got restricted __le32 [usertype] *push_db
drivers/infiniband/hw/irdma/uk.c:471:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
drivers/infiniband/hw/irdma/uk.c:471:24: sparse:     expected bool [usertype] push_wqe:1
drivers/infiniband/hw/irdma/uk.c:471:24: sparse:     got restricted __le32 [usertype] *push_db
drivers/infiniband/hw/irdma/uk.c:723:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
drivers/infiniband/hw/irdma/uk.c:723:24: sparse:     expected bool [usertype] push_wqe:1
drivers/infiniband/hw/irdma/uk.c:723:24: sparse:     got restricted __le32 [usertype] *push_db
drivers/infiniband/hw/irdma/uk.c:797:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
drivers/infiniband/hw/irdma/uk.c:797:24: sparse:     expected bool [usertype] push_wqe:1
drivers/infiniband/hw/irdma/uk.c:797:24: sparse:     got restricted __le32 [usertype] *push_db
drivers/infiniband/hw/irdma/uk.c:875:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
drivers/infiniband/hw/irdma/uk.c:875:24: sparse:     expected bool [usertype] push_wqe:1
drivers/infiniband/hw/irdma/uk.c:875:24: sparse:     got restricted __le32 [usertype] *push_db

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308110251.BV6BcwUR-lkp@intel.com/
---
v2:
- Use "qp->push_mode" check instead of "qp->push_db"
---
 drivers/infiniband/hw/irdma/uk.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index a0739503140d..f7150aa75827 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -282,7 +282,7 @@ int irdma_uk_rdma_write(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
 	bool read_fence = false;
 	u16 quanta;
 
-	info->push_wqe = qp->push_db;
+	info->push_wqe = qp->push_mode;
 
 	op_info = &info->op.rdma_write;
 	if (op_info->num_lo_sges > qp->max_sq_frag_cnt)
@@ -383,7 +383,7 @@ int irdma_uk_rdma_read(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
 	u16 quanta;
 	u64 hdr;
 
-	info->push_wqe = qp->push_db;
+	info->push_wqe = qp->push_mode;
 
 	op_info = &info->op.rdma_read;
 	if (qp->max_sq_frag_cnt < op_info->num_lo_sges)
@@ -468,7 +468,7 @@ int irdma_uk_send(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
 	bool read_fence = false;
 	u16 quanta;
 
-	info->push_wqe = qp->push_db;
+	info->push_wqe = qp->push_mode;
 
 	op_info = &info->op.send;
 	if (qp->max_sq_frag_cnt < op_info->num_sges)
@@ -720,7 +720,7 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
 	u32 i, total_size = 0;
 	u16 quanta;
 
-	info->push_wqe = qp->push_db;
+	info->push_wqe = qp->push_mode;
 	op_info = &info->op.rdma_write;
 
 	if (unlikely(qp->max_sq_frag_cnt < op_info->num_lo_sges))
@@ -794,7 +794,7 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
 	u32 i, total_size = 0;
 	u16 quanta;
 
-	info->push_wqe = qp->push_db;
+	info->push_wqe = qp->push_mode;
 	op_info = &info->op.send;
 
 	if (unlikely(qp->max_sq_frag_cnt < op_info->num_sges))
@@ -872,7 +872,7 @@ int irdma_uk_stag_local_invalidate(struct irdma_qp_uk *qp,
 	bool local_fence = false;
 	struct ib_sge sge = {};
 
-	info->push_wqe = qp->push_db;
+	info->push_wqe = qp->push_mode;
 	op_info = &info->op.inv_local_stag;
 	local_fence = info->local_fence;
 
-- 
2.34.1

