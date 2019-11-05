Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D464EFC27
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 12:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbfKELLt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 06:11:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5723 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388735AbfKELLs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 06:11:48 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 80A51D6EFD19A1B11F2D;
        Tue,  5 Nov 2019 19:11:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 19:11:37 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 5/9] RDMA/hns: Replace not intuitive function/macro names
Date:   Tue, 5 Nov 2019 19:07:58 +0800
Message-ID: <1572952082-6681-6-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572952082-6681-1-git-send-email-liweihang@hisilicon.com>
References: <1572952082-6681-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

Replace "sw2hw" and "hw2sw" which is hard to understand with "create"
and "destroy".

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.h    | 14 ++++----
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 23 ++++++-------
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  7 ++--
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 50 +++++++++++++++--------------
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 22 ++++++-------
 6 files changed, 63 insertions(+), 59 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index 2b6ac64..cd3ed2b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -115,12 +115,12 @@ enum {
 
 enum {
 	/* TPT commands */
-	HNS_ROCE_CMD_SW2HW_MPT		= 0xd,
-	HNS_ROCE_CMD_HW2SW_MPT		= 0xf,
+	HNS_ROCE_CMD_CREATE_MPT		= 0xd,
+	HNS_ROCE_CMD_DESTROY_MPT	= 0xf,
 
 	/* CQ commands */
-	HNS_ROCE_CMD_SW2HW_CQ		= 0x16,
-	HNS_ROCE_CMD_HW2SW_CQ		= 0x17,
+	HNS_ROCE_CMD_CREATE_CQ		= 0x16,
+	HNS_ROCE_CMD_DESTROY_CQ		= 0x17,
 
 	/* QP/EE commands */
 	HNS_ROCE_CMD_RST2INIT_QP	= 0x19,
@@ -129,14 +129,14 @@ enum {
 	HNS_ROCE_CMD_RTS2RTS_QP		= 0x1c,
 	HNS_ROCE_CMD_2ERR_QP		= 0x1e,
 	HNS_ROCE_CMD_RTS2SQD_QP		= 0x1f,
-	HNS_ROCE_CMD_SQD2SQD_QP		= 0x38,
 	HNS_ROCE_CMD_SQD2RTS_QP		= 0x20,
 	HNS_ROCE_CMD_2RST_QP		= 0x21,
 	HNS_ROCE_CMD_QUERY_QP		= 0x22,
-	HNS_ROCE_CMD_SW2HW_SRQ		= 0x70,
+	HNS_ROCE_CMD_SQD2SQD_QP		= 0x38,
+	HNS_ROCE_CMD_CREATE_SRQ		= 0x70,
 	HNS_ROCE_CMD_MODIFY_SRQC	= 0x72,
 	HNS_ROCE_CMD_QUERY_SRQC		= 0x73,
-	HNS_ROCE_CMD_HW2SW_SRQ		= 0x74,
+	HNS_ROCE_CMD_DESTROY_SRQ	= 0x74,
 };
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index d1d7739..713df1f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -73,12 +73,13 @@ static void hns_roce_ib_cq_event(struct hns_roce_cq *hr_cq,
 	}
 }
 
-static int hns_roce_sw2hw_cq(struct hns_roce_dev *dev,
-			     struct hns_roce_cmd_mailbox *mailbox,
-			     unsigned long cq_num)
+static int hns_roce_hw_create_cq(struct hns_roce_dev *dev,
+				 struct hns_roce_cmd_mailbox *mailbox,
+				 unsigned long cq_num)
 {
 	return hns_roce_cmd_mbox(dev, mailbox->dma, 0, cq_num, 0,
-			    HNS_ROCE_CMD_SW2HW_CQ, HNS_ROCE_CMD_TIMEOUT_MSECS);
+				 HNS_ROCE_CMD_CREATE_CQ,
+				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
 
 static int hns_roce_cq_alloc(struct hns_roce_dev *hr_dev, int nent,
@@ -144,7 +145,7 @@ static int hns_roce_cq_alloc(struct hns_roce_dev *hr_dev, int nent,
 			      nent, vector);
 
 	/* Send mailbox to hw */
-	ret = hns_roce_sw2hw_cq(hr_dev, mailbox, hr_cq->cqn);
+	ret = hns_roce_hw_create_cq(hr_dev, mailbox, hr_cq->cqn);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	if (ret) {
 		dev_err(dev, "CQ alloc.Failed to cmd mailbox.\n");
@@ -170,12 +171,12 @@ static int hns_roce_cq_alloc(struct hns_roce_dev *hr_dev, int nent,
 	return ret;
 }
 
-static int hns_roce_hw2sw_cq(struct hns_roce_dev *dev,
-			     struct hns_roce_cmd_mailbox *mailbox,
-			     unsigned long cq_num)
+static int hns_roce_hw_destroy_cq(struct hns_roce_dev *dev,
+				  struct hns_roce_cmd_mailbox *mailbox,
+				  unsigned long cq_num)
 {
 	return hns_roce_cmd_mbox(dev, 0, mailbox ? mailbox->dma : 0, cq_num,
-				 mailbox ? 0 : 1, HNS_ROCE_CMD_HW2SW_CQ,
+				 mailbox ? 0 : 1, HNS_ROCE_CMD_DESTROY_CQ,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
 
@@ -185,9 +186,9 @@ void hns_roce_free_cq(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	struct device *dev = hr_dev->dev;
 	int ret;
 
-	ret = hns_roce_hw2sw_cq(hr_dev, NULL, hr_cq->cqn);
+	ret = hns_roce_hw_destroy_cq(hr_dev, NULL, hr_cq->cqn);
 	if (ret)
-		dev_err(dev, "HW2SW_CQ failed (%d) for CQN %06lx\n", ret,
+		dev_err(dev, "DESTROY_CQ failed (%d) for CQN %06lx\n", ret,
 			hr_cq->cqn);
 
 	xa_erase(&cq_table->array, hr_cq->cqn);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 5b499a9..d5d9521 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1186,9 +1186,9 @@ struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		       unsigned int *sg_offset);
 int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
-int hns_roce_hw2sw_mpt(struct hns_roce_dev *hr_dev,
-		       struct hns_roce_cmd_mailbox *mailbox,
-		       unsigned long mpt_index);
+int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_cmd_mailbox *mailbox,
+			    unsigned long mpt_index);
 unsigned long key_to_hw_index(u32 key);
 
 struct ib_mw *hns_roce_alloc_mw(struct ib_pd *pd, enum ib_mw_type,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index bfe9cee..89a4c3a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1114,9 +1114,10 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
 	free_mr = &priv->free_mr;
 
 	if (mr->enabled) {
-		if (hns_roce_hw2sw_mpt(hr_dev, NULL, key_to_hw_index(mr->key)
-				       & (hr_dev->caps.num_mtpts - 1)))
-			dev_warn(dev, "HW2SW_MPT failed!\n");
+		if (hns_roce_hw_destroy_mpt(hr_dev, NULL,
+					    key_to_hw_index(mr->key) &
+					    (hr_dev->caps.num_mtpts - 1)))
+			dev_warn(dev, "DESTROY_MPT failed!\n");
 	}
 
 	mr_work = kzalloc(sizeof(*mr_work), GFP_KERNEL);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 5f8416b..577946b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -48,21 +48,21 @@ unsigned long key_to_hw_index(u32 key)
 	return (key << 24) | (key >> 8);
 }
 
-static int hns_roce_sw2hw_mpt(struct hns_roce_dev *hr_dev,
-			      struct hns_roce_cmd_mailbox *mailbox,
-			      unsigned long mpt_index)
+static int hns_roce_hw_create_mpt(struct hns_roce_dev *hr_dev,
+				  struct hns_roce_cmd_mailbox *mailbox,
+				  unsigned long mpt_index)
 {
 	return hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, mpt_index, 0,
-				 HNS_ROCE_CMD_SW2HW_MPT,
+				 HNS_ROCE_CMD_CREATE_MPT,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
 
-int hns_roce_hw2sw_mpt(struct hns_roce_dev *hr_dev,
-			      struct hns_roce_cmd_mailbox *mailbox,
-			      unsigned long mpt_index)
+int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_cmd_mailbox *mailbox,
+			    unsigned long mpt_index)
 {
 	return hns_roce_cmd_mbox(hr_dev, 0, mailbox ? mailbox->dma : 0,
-				 mpt_index, !mailbox, HNS_ROCE_CMD_HW2SW_MPT,
+				 mpt_index, !mailbox, HNS_ROCE_CMD_DESTROY_MPT,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
 
@@ -707,10 +707,11 @@ static void hns_roce_mr_free(struct hns_roce_dev *hr_dev,
 	int ret;
 
 	if (mr->enabled) {
-		ret = hns_roce_hw2sw_mpt(hr_dev, NULL, key_to_hw_index(mr->key)
-					 & (hr_dev->caps.num_mtpts - 1));
+		ret = hns_roce_hw_destroy_mpt(hr_dev, NULL,
+					      key_to_hw_index(mr->key) &
+					      (hr_dev->caps.num_mtpts - 1));
 		if (ret)
-			dev_warn(dev, "HW2SW_MPT failed (%d)\n", ret);
+			dev_warn(dev, "DESTROY_MPT failed (%d)\n", ret);
 	}
 
 	if (mr->size != ~0ULL) {
@@ -763,10 +764,10 @@ static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 		goto err_page;
 	}
 
-	ret = hns_roce_sw2hw_mpt(hr_dev, mailbox,
-				 mtpt_idx & (hr_dev->caps.num_mtpts - 1));
+	ret = hns_roce_hw_create_mpt(hr_dev, mailbox,
+				     mtpt_idx & (hr_dev->caps.num_mtpts - 1));
 	if (ret) {
-		dev_err(dev, "SW2HW_MPT failed (%d)\n", ret);
+		dev_err(dev, "CREATE_MPT failed (%d)\n", ret);
 		goto err_page;
 	}
 
@@ -1308,9 +1309,9 @@ int hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start, u64 length,
 	if (ret)
 		goto free_cmd_mbox;
 
-	ret = hns_roce_hw2sw_mpt(hr_dev, NULL, mtpt_idx);
+	ret = hns_roce_hw_destroy_mpt(hr_dev, NULL, mtpt_idx);
 	if (ret)
-		dev_warn(dev, "HW2SW_MPT failed (%d)\n", ret);
+		dev_warn(dev, "DESTROY_MPT failed (%d)\n", ret);
 
 	mr->enabled = 0;
 
@@ -1332,9 +1333,9 @@ int hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start, u64 length,
 			goto free_cmd_mbox;
 	}
 
-	ret = hns_roce_sw2hw_mpt(hr_dev, mailbox, mtpt_idx);
+	ret = hns_roce_hw_create_mpt(hr_dev, mailbox, mtpt_idx);
 	if (ret) {
-		dev_err(dev, "SW2HW_MPT failed (%d)\n", ret);
+		dev_err(dev, "CREATE_MPT failed (%d)\n", ret);
 		ib_umem_release(mr->umem);
 		goto free_cmd_mbox;
 	}
@@ -1448,10 +1449,11 @@ static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,
 	int ret;
 
 	if (mw->enabled) {
-		ret = hns_roce_hw2sw_mpt(hr_dev, NULL, key_to_hw_index(mw->rkey)
-					 & (hr_dev->caps.num_mtpts - 1));
+		ret = hns_roce_hw_destroy_mpt(hr_dev, NULL,
+					      key_to_hw_index(mw->rkey) &
+					      (hr_dev->caps.num_mtpts - 1));
 		if (ret)
-			dev_warn(dev, "MW HW2SW_MPT failed (%d)\n", ret);
+			dev_warn(dev, "MW DESTROY_MPT failed (%d)\n", ret);
 
 		hns_roce_table_put(hr_dev, &hr_dev->mr_table.mtpt_table,
 				   key_to_hw_index(mw->rkey));
@@ -1487,10 +1489,10 @@ static int hns_roce_mw_enable(struct hns_roce_dev *hr_dev,
 		goto err_page;
 	}
 
-	ret = hns_roce_sw2hw_mpt(hr_dev, mailbox,
-				 mtpt_idx & (hr_dev->caps.num_mtpts - 1));
+	ret = hns_roce_hw_create_mpt(hr_dev, mailbox,
+				     mtpt_idx & (hr_dev->caps.num_mtpts - 1));
 	if (ret) {
-		dev_err(dev, "MW sw2hw_mpt failed (%d)\n", ret);
+		dev_err(dev, "MW CREATE_MPT failed (%d)\n", ret);
 		goto err_page;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 6f9d1d2..d275818 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -59,21 +59,21 @@ static void hns_roce_ib_srq_event(struct hns_roce_srq *srq,
 	}
 }
 
-static int hns_roce_sw2hw_srq(struct hns_roce_dev *dev,
-			      struct hns_roce_cmd_mailbox *mailbox,
-			      unsigned long srq_num)
+static int hns_roce_hw_create_srq(struct hns_roce_dev *dev,
+				  struct hns_roce_cmd_mailbox *mailbox,
+				  unsigned long srq_num)
 {
 	return hns_roce_cmd_mbox(dev, mailbox->dma, 0, srq_num, 0,
-				 HNS_ROCE_CMD_SW2HW_SRQ,
+				 HNS_ROCE_CMD_CREATE_SRQ,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
 
-static int hns_roce_hw2sw_srq(struct hns_roce_dev *dev,
-			     struct hns_roce_cmd_mailbox *mailbox,
-			     unsigned long srq_num)
+static int hns_roce_hw_destroy_srq(struct hns_roce_dev *dev,
+				   struct hns_roce_cmd_mailbox *mailbox,
+				   unsigned long srq_num)
 {
 	return hns_roce_cmd_mbox(dev, 0, mailbox ? mailbox->dma : 0, srq_num,
-				 mailbox ? 0 : 1, HNS_ROCE_CMD_HW2SW_SRQ,
+				 mailbox ? 0 : 1, HNS_ROCE_CMD_DESTROY_SRQ,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
 
@@ -134,7 +134,7 @@ static int hns_roce_srq_alloc(struct hns_roce_dev *hr_dev, u32 pdn, u32 cqn,
 			       mtts_wqe, mtts_idx, dma_handle_wqe,
 			       dma_handle_idx);
 
-	ret = hns_roce_sw2hw_srq(hr_dev, mailbox, srq->srqn);
+	ret = hns_roce_hw_create_srq(hr_dev, mailbox, srq->srqn);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	if (ret)
 		goto err_xa;
@@ -160,9 +160,9 @@ static void hns_roce_srq_free(struct hns_roce_dev *hr_dev,
 	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
 	int ret;
 
-	ret = hns_roce_hw2sw_srq(hr_dev, NULL, srq->srqn);
+	ret = hns_roce_hw_destroy_srq(hr_dev, NULL, srq->srqn);
 	if (ret)
-		dev_err(hr_dev->dev, "HW2SW_SRQ failed (%d) for CQN %06lx\n",
+		dev_err(hr_dev->dev, "DESTROY_SRQ failed (%d) for SRQN %06lx\n",
 			ret, srq->srqn);
 
 	xa_erase(&srq_table->xa, srq->srqn);
-- 
2.8.1

