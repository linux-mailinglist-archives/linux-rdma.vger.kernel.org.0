Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B294CFFD23
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 03:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfKRCi2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 21:38:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbfKRCi1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Nov 2019 21:38:27 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6BC0B4E22E296112C2AB;
        Mon, 18 Nov 2019 10:38:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Mon, 18 Nov 2019 10:38:14 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 3/4] RDMA/hns: Rename the functions used inside creating cq
Date:   Mon, 18 Nov 2019 10:34:52 +0800
Message-ID: <1574044493-46984-4-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1574044493-46984-1-git-send-email-liweihang@hisilicon.com>
References: <1574044493-46984-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

Current names of functions are not proper, such as hns_roce_free_cq,
actually it means free cqc, thus we rename them. Furthermore,
functions used inside one file can be named without the prefix
hns_roce_ which will make the functions for verbs symbols
more eye-catching.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.h    |  4 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 66 ++++++++++-------------------
 drivers/infiniband/hw/hns/hns_roce_device.h |  9 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  8 ++--
 drivers/infiniband/hw/hns/hns_roce_main.c   |  4 +-
 5 files changed, 35 insertions(+), 56 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index cd3ed2b..1915bac 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -119,8 +119,8 @@ enum {
 	HNS_ROCE_CMD_DESTROY_MPT	= 0xf,
 
 	/* CQ commands */
-	HNS_ROCE_CMD_CREATE_CQ		= 0x16,
-	HNS_ROCE_CMD_DESTROY_CQ		= 0x17,
+	HNS_ROCE_CMD_CREATE_CQC		= 0x16,
+	HNS_ROCE_CMD_DESTROY_CQC	= 0x17,
 
 	/* QP/EE commands */
 	HNS_ROCE_CMD_RST2INIT_QP	= 0x19,
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index e9c9453..9174d33 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -73,17 +73,8 @@ static void hns_roce_ib_cq_event(struct hns_roce_cq *hr_cq,
 	}
 }
 
-static int hns_roce_hw_create_cq(struct hns_roce_dev *dev,
-				 struct hns_roce_cmd_mailbox *mailbox,
-				 unsigned long cq_num)
-{
-	return hns_roce_cmd_mbox(dev, mailbox->dma, 0, cq_num, 0,
-				 HNS_ROCE_CMD_CREATE_CQ,
-				 HNS_ROCE_CMD_TIMEOUT_MSECS);
-}
-
-static int hns_roce_cq_alloc(struct hns_roce_dev *hr_dev,
-			     struct hns_roce_cq *hr_cq)
+static int hns_roce_alloc_cqc(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_cq *hr_cq)
 {
 	struct hns_roce_cmd_mailbox *mailbox;
 	struct hns_roce_hem_table *mtt_table;
@@ -140,7 +131,8 @@ static int hns_roce_cq_alloc(struct hns_roce_dev *hr_dev,
 	hr_dev->hw->write_cqc(hr_dev, hr_cq, mailbox->buf, mtts, dma_handle);
 
 	/* Send mailbox to hw */
-	ret = hns_roce_hw_create_cq(hr_dev, mailbox, hr_cq->cqn);
+	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_cq->cqn, 0,
+			HNS_ROCE_CMD_CREATE_CQC, HNS_ROCE_CMD_TIMEOUT_MSECS);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	if (ret) {
 		dev_err(dev,
@@ -168,22 +160,15 @@ static int hns_roce_cq_alloc(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-static int hns_roce_hw_destroy_cq(struct hns_roce_dev *dev,
-				  struct hns_roce_cmd_mailbox *mailbox,
-				  unsigned long cq_num)
-{
-	return hns_roce_cmd_mbox(dev, 0, mailbox ? mailbox->dma : 0, cq_num,
-				 mailbox ? 0 : 1, HNS_ROCE_CMD_DESTROY_CQ,
-				 HNS_ROCE_CMD_TIMEOUT_MSECS);
-}
-
-void hns_roce_free_cq(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
+void hns_roce_free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
 	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
 	struct device *dev = hr_dev->dev;
 	int ret;
 
-	ret = hns_roce_hw_destroy_cq(hr_dev, NULL, hr_cq->cqn);
+	ret = hns_roce_cmd_mbox(hr_dev, 0, 0, hr_cq->cqn, 1,
+				HNS_ROCE_CMD_DESTROY_CQC,
+				HNS_ROCE_CMD_TIMEOUT_MSECS);
 	if (ret)
 		dev_err(dev, "DESTROY_CQ failed (%d) for CQN %06lx\n", ret,
 			hr_cq->cqn);
@@ -202,10 +187,9 @@ void hns_roce_free_cq(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	hns_roce_bitmap_free(&cq_table->bitmap, hr_cq->cqn, BITMAP_NO_RR);
 }
 
-static int hns_roce_ib_get_cq_umem(struct hns_roce_dev *hr_dev,
-				   struct hns_roce_cq *hr_cq,
-				   struct hns_roce_ib_create_cq ucmd,
-				   struct ib_udata *udata)
+static int get_cq_umem(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
+		       struct hns_roce_ib_create_cq ucmd,
+		       struct ib_udata *udata)
 {
 	struct hns_roce_buf *buf = &hr_cq->buf;
 	struct hns_roce_mtt *mtt = &hr_cq->mtt;
@@ -243,8 +227,7 @@ static int hns_roce_ib_get_cq_umem(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-static int hns_roce_ib_alloc_cq_buf(struct hns_roce_dev *hr_dev,
-				    struct hns_roce_cq *hr_cq)
+static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
 	struct hns_roce_buf *buf = &hr_cq->buf;
 	struct hns_roce_mtt *mtt = &hr_cq->mtt;
@@ -280,8 +263,7 @@ static int hns_roce_ib_alloc_cq_buf(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-static void hns_roce_ib_free_cq_buf(struct hns_roce_dev *hr_dev,
-				    struct hns_roce_cq *hr_cq)
+static void free_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
 	hns_roce_buf_free(hr_dev, hr_cq->buf.size, &hr_cq->buf);
 }
@@ -303,7 +285,7 @@ static int create_user_cq(struct hns_roce_dev *hr_dev,
 	}
 
 	/* Get user space address, write it into mtt table */
-	ret = hns_roce_ib_get_cq_umem(hr_dev, hr_cq, ucmd, udata);
+	ret = get_cq_umem(hr_dev, hr_cq, ucmd, udata);
 	if (ret) {
 		dev_err(dev, "Failed to get_cq_umem.\n");
 		return ret;
@@ -347,7 +329,7 @@ static int create_kernel_cq(struct hns_roce_dev *hr_dev,
 	}
 
 	/* Init mtt table and write buff address to mtt table */
-	ret = hns_roce_ib_alloc_cq_buf(hr_dev, hr_cq);
+	ret = alloc_cq_buf(hr_dev, hr_cq);
 	if (ret) {
 		dev_err(dev, "Failed to alloc_cq_buf.\n");
 		goto err_db;
@@ -385,15 +367,14 @@ static void destroy_kernel_cq(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_cq *hr_cq)
 {
 	hns_roce_mtt_cleanup(hr_dev, &hr_cq->mtt);
-	hns_roce_ib_free_cq_buf(hr_dev, hr_cq);
+	free_cq_buf(hr_dev, hr_cq);
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB)
 		hns_roce_free_db(hr_dev, &hr_cq->db);
 }
 
-int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
-			  const struct ib_cq_init_attr *attr,
-			  struct ib_udata *udata)
+int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
+		       struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
 	struct hns_roce_ib_create_cq_resp resp = {};
@@ -438,8 +419,7 @@ int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 		}
 	}
 
-	/* Allocate cq index, fill cq_context */
-	ret = hns_roce_cq_alloc(hr_dev,	hr_cq);
+	ret = hns_roce_alloc_cqc(hr_dev, hr_cq);
 	if (ret) {
 		dev_err(dev, "Alloc CQ failed(%d).\n", ret);
 		goto err_dbmap;
@@ -468,7 +448,7 @@ int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 	return 0;
 
 err_cqc:
-	hns_roce_free_cq(hr_dev, hr_cq);
+	hns_roce_free_cqc(hr_dev, hr_cq);
 
 err_dbmap:
 	if (udata)
@@ -480,7 +460,7 @@ int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 	return ret;
 }
 
-void hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
+void hns_roce_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
@@ -490,7 +470,7 @@ void hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 		return;
 	}
 
-	hns_roce_free_cq(hr_dev, hr_cq);
+	hns_roce_free_cqc(hr_dev, hr_cq);
 	hns_roce_mtt_cleanup(hr_dev, &hr_cq->mtt);
 
 	ib_umem_release(hr_cq->umem);
@@ -503,7 +483,7 @@ void hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 					       &hr_cq->db);
 	} else {
 		/* Free the buff of stored cq */
-		hns_roce_ib_free_cq_buf(hr_dev, hr_cq);
+		free_cq_buf(hr_dev, hr_cq);
 		if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB)
 			hns_roce_free_db(hr_dev, &hr_cq->db);
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 608ec59..152701e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1240,12 +1240,11 @@ void hns_roce_release_range_qp(struct hns_roce_dev *hr_dev, int base_qpn,
 __be32 send_ieth(const struct ib_send_wr *wr);
 int to_hr_qp_type(int qp_type);
 
-int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
-			  const struct ib_cq_init_attr *attr,
-			  struct ib_udata *udata);
+int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
+		       struct ib_udata *udata);
 
-void hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
-void hns_roce_free_cq(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq);
+void hns_roce_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
+void hns_roce_free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq);
 
 int hns_roce_db_map_user(struct hns_roce_ucontext *context,
 			 struct ib_udata *udata, unsigned long virt,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 9a00361..2a2b211 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -732,7 +732,7 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 	if (!cq)
 		return -ENOMEM;
 
-	ret = hns_roce_ib_create_cq(cq, &cq_init_attr, NULL);
+	ret = hns_roce_create_cq(cq, &cq_init_attr, NULL);
 	if (ret) {
 		dev_err(dev, "Create cq for reserved loop qp failed!");
 		goto alloc_cq_failed;
@@ -868,7 +868,7 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 	kfree(pd);
 
 alloc_mem_failed:
-	hns_roce_ib_destroy_cq(cq, NULL);
+	hns_roce_destroy_cq(cq, NULL);
 alloc_cq_failed:
 	kfree(cq);
 	return ret;
@@ -897,7 +897,7 @@ static void hns_roce_v1_release_lp_qp(struct hns_roce_dev *hr_dev)
 				i, ret);
 	}
 
-	hns_roce_ib_destroy_cq(&free_mr->mr_free_cq->ib_cq, NULL);
+	hns_roce_destroy_cq(&free_mr->mr_free_cq->ib_cq, NULL);
 	kfree(&free_mr->mr_free_cq->ib_cq);
 	hns_roce_dealloc_pd(&free_mr->mr_free_pd->ibpd, NULL);
 	kfree(&free_mr->mr_free_pd->ibpd);
@@ -3656,7 +3656,7 @@ static void hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	u32 cqe_cnt_cur;
 	int wait_time = 0;
 
-	hns_roce_free_cq(hr_dev, hr_cq);
+	hns_roce_free_cqc(hr_dev, hr_cq);
 
 	/*
 	 * Before freeing cq buffer, we need to ensure that the outstanding CQE
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 066f01c..854ef6e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -419,14 +419,14 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.alloc_pd = hns_roce_alloc_pd,
 	.alloc_ucontext = hns_roce_alloc_ucontext,
 	.create_ah = hns_roce_create_ah,
-	.create_cq = hns_roce_ib_create_cq,
+	.create_cq = hns_roce_create_cq,
 	.create_qp = hns_roce_create_qp,
 	.dealloc_pd = hns_roce_dealloc_pd,
 	.dealloc_ucontext = hns_roce_dealloc_ucontext,
 	.del_gid = hns_roce_del_gid,
 	.dereg_mr = hns_roce_dereg_mr,
 	.destroy_ah = hns_roce_destroy_ah,
-	.destroy_cq = hns_roce_ib_destroy_cq,
+	.destroy_cq = hns_roce_destroy_cq,
 	.disassociate_ucontext = hns_roce_disassociate_ucontext,
 	.fill_res_entry = hns_roce_fill_res_entry,
 	.get_dma_mr = hns_roce_get_dma_mr,
-- 
2.8.1

