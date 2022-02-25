Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549954C43A1
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 12:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbiBYL1Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 06:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240129AbiBYL1O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 06:27:14 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F711E4823
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 03:26:25 -0800 (PST)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K4nR15Lj2z1FDZd;
        Fri, 25 Feb 2022 19:21:33 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 19:26:07 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 19:26:06 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v2 for-next 6/9] RDMA/hns: Remove similar code that configures the hardware contexts
Date:   Fri, 25 Feb 2022 19:25:56 +0800
Message-ID: <20220225112559.43300-7-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220225112559.43300-1-liangwenpeng@huawei.com>
References: <20220225112559.43300-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

From: Chengchang Tang <tangchengchang@huawei.com>

Remove duplicate code for creating and destroying hardware contexts via
mailbox.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c    | 12 +++++++++
 drivers/infiniband/hw/hns/hns_roce_cmd.h    |  5 ++++
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  8 +++---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 --
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  4 +--
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 29 ++++++---------------
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 20 +++-----------
 7 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 7e37066b272d..864413607571 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -262,3 +262,15 @@ void hns_roce_free_cmd_mailbox(struct hns_roce_dev *hr_dev,
 	dma_pool_free(hr_dev->cmd.pool, mailbox->buf, mailbox->dma);
 	kfree(mailbox);
 }
+
+int hns_roce_create_hw_ctx(struct hns_roce_dev *dev,
+			   struct hns_roce_cmd_mailbox *mailbox,
+			   u8 cmd, unsigned long idx)
+{
+	return hns_roce_cmd_mbox(dev, mailbox->dma, 0, cmd, idx);
+}
+
+int hns_roce_destroy_hw_ctx(struct hns_roce_dev *dev, u8 cmd, unsigned long idx)
+{
+	return hns_roce_cmd_mbox(dev, 0, 0, cmd, idx);
+}
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index 759da8981c71..052a3d60905a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -146,5 +146,10 @@ struct hns_roce_cmd_mailbox *
 hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev);
 void hns_roce_free_cmd_mailbox(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_cmd_mailbox *mailbox);
+int hns_roce_create_hw_ctx(struct hns_roce_dev *dev,
+			   struct hns_roce_cmd_mailbox *mailbox,
+			   u8 cmd, unsigned long idx);
+int hns_roce_destroy_hw_ctx(struct hns_roce_dev *dev, u8 cmd,
+			    unsigned long idx);
 
 #endif /* _HNS_ROCE_CMD_H */
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index a335fa8481a5..3d10300cab85 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -139,8 +139,8 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 
 	hr_dev->hw->write_cqc(hr_dev, hr_cq, mailbox->buf, mtts, dma_handle);
 
-	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0,
-				HNS_ROCE_CMD_CREATE_CQC, hr_cq->cqn);
+	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, HNS_ROCE_CMD_CREATE_CQC,
+				     hr_cq->cqn);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	if (ret) {
 		ibdev_err(ibdev,
@@ -173,8 +173,8 @@ static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	struct device *dev = hr_dev->dev;
 	int ret;
 
-	ret = hns_roce_cmd_mbox(hr_dev, 0, 0, HNS_ROCE_CMD_DESTROY_CQC,
-				hr_cq->cqn);
+	ret = hns_roce_destroy_hw_ctx(hr_dev, HNS_ROCE_CMD_DESTROY_CQC,
+				      hr_cq->cqn);
 	if (ret)
 		dev_err(dev, "DESTROY_CQ failed (%d) for CQN %06lx\n", ret,
 			hr_cq->cqn);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 5e4a3536c41b..21182ec56f18 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1152,8 +1152,6 @@ struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		       unsigned int *sg_offset);
 int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
-int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
-			    unsigned long mpt_index);
 unsigned long key_to_hw_index(u32 key);
 
 int hns_roce_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 55c49d358f76..631f6e233492 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5868,7 +5868,7 @@ static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev, u32 eqn)
 	else
 		cmd = HNS_ROCE_CMD_DESTROY_AEQC;
 
-	ret = hns_roce_cmd_mbox(hr_dev, 0, 0, cmd, eqn & HNS_ROCE_V2_EQN_M);
+	ret = hns_roce_destroy_hw_ctx(hr_dev, cmd, eqn & HNS_ROCE_V2_EQN_M);
 	if (ret)
 		dev_err(dev, "[mailbox cmd] destroy eqc(%u) failed.\n", eqn);
 }
@@ -5992,7 +5992,7 @@ static int hns_roce_v2_create_eq(struct hns_roce_dev *hr_dev,
 	if (ret)
 		goto err_cmd_mbox;
 
-	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, eq_cmd, eq->eqn);
+	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, eq_cmd, eq->eqn);
 	if (ret) {
 		dev_err(hr_dev->dev, "[mailbox cmd] create eqc failed.\n");
 		goto err_cmd_mbox;
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 22ff78a5a1a7..39de862666d7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -47,21 +47,6 @@ unsigned long key_to_hw_index(u32 key)
 	return (key << 24) | (key >> 8);
 }
 
-static int hns_roce_hw_create_mpt(struct hns_roce_dev *hr_dev,
-				  struct hns_roce_cmd_mailbox *mailbox,
-				  unsigned long mpt_index)
-{
-	return hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0,
-				 HNS_ROCE_CMD_CREATE_MPT, mpt_index);
-}
-
-int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
-			    unsigned long mpt_index)
-{
-	return hns_roce_cmd_mbox(hr_dev, 0, 0, HNS_ROCE_CMD_DESTROY_MPT,
-				 mpt_index);
-}
-
 static int alloc_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 {
 	struct hns_roce_ida *mtpt_ida = &hr_dev->mr_table.mtpt_ida;
@@ -141,7 +126,7 @@ static void hns_roce_mr_free(struct hns_roce_dev *hr_dev,
 	int ret;
 
 	if (mr->enabled) {
-		ret = hns_roce_hw_destroy_mpt(hr_dev,
+		ret = hns_roce_destroy_hw_ctx(hr_dev, HNS_ROCE_CMD_DESTROY_MPT,
 					      key_to_hw_index(mr->key) &
 					      (hr_dev->caps.num_mtpts - 1));
 		if (ret)
@@ -177,7 +162,7 @@ static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 		goto err_page;
 	}
 
-	ret = hns_roce_hw_create_mpt(hr_dev, mailbox,
+	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, HNS_ROCE_CMD_CREATE_MPT,
 				     mtpt_idx & (hr_dev->caps.num_mtpts - 1));
 	if (ret) {
 		dev_err(dev, "failed to create mpt, ret = %d.\n", ret);
@@ -306,7 +291,8 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 	if (ret)
 		goto free_cmd_mbox;
 
-	ret = hns_roce_hw_destroy_mpt(hr_dev, mtpt_idx);
+	ret = hns_roce_destroy_hw_ctx(hr_dev, HNS_ROCE_CMD_DESTROY_MPT,
+				      mtpt_idx);
 	if (ret)
 		ibdev_warn(ib_dev, "failed to destroy MPT, ret = %d.\n", ret);
 
@@ -336,7 +322,8 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 		goto free_cmd_mbox;
 	}
 
-	ret = hns_roce_hw_create_mpt(hr_dev, mailbox, mtpt_idx);
+	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, HNS_ROCE_CMD_CREATE_MPT,
+				     mtpt_idx);
 	if (ret) {
 		ibdev_err(ib_dev, "failed to create MPT, ret = %d.\n", ret);
 		goto free_cmd_mbox;
@@ -477,7 +464,7 @@ static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,
 	int ret;
 
 	if (mw->enabled) {
-		ret = hns_roce_hw_destroy_mpt(hr_dev,
+		ret = hns_roce_destroy_hw_ctx(hr_dev, HNS_ROCE_CMD_DESTROY_MPT,
 					      key_to_hw_index(mw->rkey) &
 					      (hr_dev->caps.num_mtpts - 1));
 		if (ret)
@@ -517,7 +504,7 @@ static int hns_roce_mw_enable(struct hns_roce_dev *hr_dev,
 		goto err_page;
 	}
 
-	ret = hns_roce_hw_create_mpt(hr_dev, mailbox,
+	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, HNS_ROCE_CMD_CREATE_MPT,
 				     mtpt_idx & (hr_dev->caps.num_mtpts - 1));
 	if (ret) {
 		dev_err(dev, "MW CREATE_MPT failed (%d)\n", ret);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index f270563aca97..e316276e18c2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -59,20 +59,6 @@ static void hns_roce_ib_srq_event(struct hns_roce_srq *srq,
 	}
 }
 
-static int hns_roce_hw_create_srq(struct hns_roce_dev *dev,
-				  struct hns_roce_cmd_mailbox *mailbox,
-				  unsigned long srq_num)
-{
-	return hns_roce_cmd_mbox(dev, mailbox->dma, 0, HNS_ROCE_CMD_CREATE_SRQ,
-				 srq_num);
-}
-
-static int hns_roce_hw_destroy_srq(struct hns_roce_dev *dev,
-				   unsigned long srq_num)
-{
-	return hns_roce_cmd_mbox(dev, 0, 0, HNS_ROCE_CMD_DESTROY_SRQ, srq_num);
-}
-
 static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 {
 	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
@@ -115,7 +101,8 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 		goto err_mbox;
 	}
 
-	ret = hns_roce_hw_create_srq(hr_dev, mailbox, srq->srqn);
+	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, HNS_ROCE_CMD_CREATE_SRQ,
+				     srq->srqn);
 	if (ret) {
 		ibdev_err(ibdev, "failed to config SRQC, ret = %d.\n", ret);
 		goto err_mbox;
@@ -142,7 +129,8 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
 	int ret;
 
-	ret = hns_roce_hw_destroy_srq(hr_dev, srq->srqn);
+	ret = hns_roce_destroy_hw_ctx(hr_dev, HNS_ROCE_CMD_DESTROY_SRQ,
+				      srq->srqn);
 	if (ret)
 		dev_err(hr_dev->dev, "DESTROY_SRQ failed (%d) for SRQN %06lx\n",
 			ret, srq->srqn);
-- 
2.33.0

