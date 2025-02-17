Return-Path: <linux-rdma+bounces-7790-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59570A37BDE
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 08:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DE01886AB4
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 07:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530DA1990C3;
	Mon, 17 Feb 2025 07:08:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD234196DB1
	for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2025 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776137; cv=none; b=FqO5ZtpX7AJsrnwWMiMnA8uu5gJIpz1AsqCTLR82FVSj680wPNzmXJ3nZAUOOoLHgwsxoOHZmaSASq3YnwfZsk8OYhUX43ezzut9Sxk4jGwQBsuur0S2E9Z8r1YiiPW/nqZ3FPUcXc5gAdRziVxgUaVE5HAYa+5aqEyxtbI2fBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776137; c=relaxed/simple;
	bh=+kWdKglNhrRPZLzngCfDf5PC7S0XrQem79VHVjQoL8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Har8SOsX0IPzoPucRoZT1G0UhX3Mk7uNXwpOCXdlSxmsmKpZUHL3/kPXQ/Cw/3ySa+EUhHbG21ZkbL/Xs9S4ugNPaWilZKJEZPxuQ4SdN41T3+z6UEQUkBYqTHPVb6RLZLMx2C/PhPmZbV1AWcVx/sPP3gBVWCEEwcbAicE2VE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YxDHP32shzrYqm;
	Mon, 17 Feb 2025 15:07:13 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 4274F1800E7;
	Mon, 17 Feb 2025 15:08:47 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Feb 2025 15:08:46 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 2/4] RDMA/hns: Fix HW CTX UAF by adding delay-destruction mechanism
Date: Mon, 17 Feb 2025 15:01:21 +0800
Message-ID: <20250217070123.3171232-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: wenglianfa <wenglianfa@huawei.com>

When mailboxes for resource(QP/CQ/MR/SRQ) destruction fail, it's
unable to notify HW about the destruction. In this case, driver
will still free the CTX, while HW may still access them,
thus leading to a UAF.

Introduce a delay-destruction mechanism. When mailboxes for resource
destruction fail, the related buffer will not be freed in the normal
destruction flow. Instead, link the resource node to a list. Free
all buffers in the list when the device is uninited.

Fixes: b0969f83890b ("RDMA/hns: Do not destroy QP resources in the hw resetting phase")
Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 12 ++++++--
 drivers/infiniband/hw/hns/hns_roce_device.h | 26 +++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  4 ++-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  7 +++++
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 32 +++++++++++++++++++--
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  8 +++++-
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 17 ++++++++---
 7 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 236ee3fefe16..dc49d35ec4ec 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -178,9 +178,11 @@ static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 
 	ret = hns_roce_destroy_hw_ctx(hr_dev, HNS_ROCE_CMD_DESTROY_CQC,
 				      hr_cq->cqn);
-	if (ret)
+	if (ret) {
+		hr_cq->delayed_destroy_flag = true;
 		dev_err_ratelimited(dev, "DESTROY_CQ failed (%d) for CQN %06lx\n",
 				    ret, hr_cq->cqn);
+	}
 
 	xa_erase_irq(&cq_table->array, hr_cq->cqn);
 
@@ -192,7 +194,8 @@ static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 		complete(&hr_cq->free);
 	wait_for_completion(&hr_cq->free);
 
-	hns_roce_table_put(hr_dev, &cq_table->table, hr_cq->cqn);
+	if (!hr_cq->delayed_destroy_flag)
+		hns_roce_table_put(hr_dev, &cq_table->table, hr_cq->cqn);
 }
 
 static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
@@ -220,7 +223,10 @@ static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 
 static void free_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
-	hns_roce_mtr_destroy(hr_dev, hr_cq->mtr);
+	if (hr_cq->delayed_destroy_flag)
+		hns_roce_add_unfree_mtr(hr_dev, hr_cq->mtr);
+	else
+		hns_roce_mtr_destroy(hr_dev, hr_cq->mtr);
 }
 
 static int alloc_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index ed0fa29f0cff..e010fb3230a2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -314,6 +314,7 @@ struct hns_roce_mtr {
 	struct ib_umem		*umem; /* user space buffer */
 	struct hns_roce_buf	*kmem; /* kernel space buffer */
 	struct hns_roce_hem_cfg  hem_cfg; /* config for hardware addressing */
+	struct list_head	 node; /* list node for delay-destruction */
 };
 
 struct hns_roce_mw {
@@ -339,6 +340,11 @@ struct hns_roce_mr {
 	struct hns_roce_mtr	*pbl_mtr;
 	u32			npages;
 	dma_addr_t		*page_list;
+	/* When this is true, the free and destruction of the related
+	 * resources will be delayed until the device is uninited, ensuring
+	 * no memory leak.
+	 */
+	bool delayed_destroy_flag;
 };
 
 struct hns_roce_mr_table {
@@ -442,6 +448,11 @@ struct hns_roce_cq {
 	struct list_head		rq_list; /* all qps on this recv cq */
 	int				is_armed; /* cq is armed */
 	struct list_head		node; /* all armed cqs are on a list */
+	/* When this is true, the free and destruction of the related
+	 * resources will be delayed until the device is uninited, ensuring
+	 * no memory leak.
+	 */
+	bool delayed_destroy_flag;
 };
 
 struct hns_roce_idx_que {
@@ -475,6 +486,11 @@ struct hns_roce_srq {
 	void (*event)(struct hns_roce_srq *srq, enum hns_roce_event event);
 	struct hns_roce_db	rdb;
 	u32			cap_flags;
+	/* When this is true, the free and destruction of the related
+	 * resources will be delayed until the device is uninited, ensuring
+	 * no memory leak.
+	 */
+	bool delayed_destroy_flag;
 };
 
 struct hns_roce_uar_table {
@@ -642,6 +658,11 @@ struct hns_roce_qp {
 
 	/* 0: flush needed, 1: unneeded */
 	unsigned long		flush_flag;
+	/* When this is true, the free and destruction of the related
+	 * resources will be delayed until the device is uninited, ensuring
+	 * no memory leak.
+	 */
+	bool delayed_destroy_flag;
 	struct hns_roce_work	flush_work;
 	struct list_head	node; /* all qps are on a list */
 	struct list_head	rq_node; /* all recv qps are on a list */
@@ -1025,6 +1046,8 @@ struct hns_roce_dev {
 	u64 dwqe_page;
 	struct hns_roce_dev_debugfs dbgfs;
 	atomic64_t *dfx_cnt;
+	struct list_head mtr_unfree_list; /* list of unfree mtr on this dev */
+	struct mutex mtr_unfree_list_mutex; /* protect mtr_unfree_list */
 };
 
 static inline struct hns_roce_dev *to_hr_dev(struct ib_device *ib_dev)
@@ -1296,6 +1319,9 @@ int hns_roce_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp);
 int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp);
 int hns_roce_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
 int hns_roce_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ib_mr);
+void hns_roce_add_unfree_mtr(struct hns_roce_dev *hr_dev,
+			     struct hns_roce_mtr *mtr);
+void hns_roce_free_unfree_mtr(struct hns_roce_dev *hr_dev);
 int hns_roce_fill_res_srq_entry(struct sk_buff *msg, struct ib_srq *ib_srq);
 int hns_roce_fill_res_srq_entry_raw(struct sk_buff *msg, struct ib_srq *ib_srq);
 struct hns_user_mmap_entry *
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d60ca0a306e9..86d6a8f2a26d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5587,10 +5587,12 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 		/* Modify qp to reset before destroying qp */
 		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
 					    hr_qp->state, IB_QPS_RESET, udata);
-		if (ret)
+		if (ret) {
+			hr_qp->delayed_destroy_flag = true;
 			ibdev_err_ratelimited(ibdev,
 					      "failed to modify QP to RST, ret = %d.\n",
 					      ret);
+		}
 	}
 
 	send_cq = hr_qp->ibqp.send_cq ? to_hr_cq(hr_qp->ibqp.send_cq) : NULL;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index ae24c81c9812..b5ece1bedc11 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -952,6 +952,8 @@ static void hns_roce_teardown_hca(struct hns_roce_dev *hr_dev)
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
 		mutex_destroy(&hr_dev->pgdir_mutex);
+
+	mutex_destroy(&hr_dev->mtr_unfree_list_mutex);
 }
 
 /**
@@ -966,6 +968,9 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 
 	spin_lock_init(&hr_dev->sm_lock);
 
+	INIT_LIST_HEAD(&hr_dev->mtr_unfree_list);
+	mutex_init(&hr_dev->mtr_unfree_list_mutex);
+
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) {
 		INIT_LIST_HEAD(&hr_dev->pgdir_list);
@@ -1005,6 +1010,7 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
 	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
 		mutex_destroy(&hr_dev->pgdir_mutex);
+	mutex_destroy(&hr_dev->mtr_unfree_list_mutex);
 
 	return ret;
 }
@@ -1179,6 +1185,7 @@ void hns_roce_exit(struct hns_roce_dev *hr_dev)
 
 	if (hr_dev->hw->hw_exit)
 		hr_dev->hw->hw_exit(hr_dev);
+	hns_roce_free_unfree_mtr(hr_dev);
 	hns_roce_teardown_hca(hr_dev);
 	hns_roce_cleanup_hem(hr_dev);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 3902243cac96..228a3512e1a0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -83,7 +83,8 @@ static void free_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 {
 	unsigned long obj = key_to_hw_index(mr->key);
 
-	hns_roce_table_put(hr_dev, &hr_dev->mr_table.mtpt_table, obj);
+	if (!mr->delayed_destroy_flag)
+		hns_roce_table_put(hr_dev, &hr_dev->mr_table.mtpt_table, obj);
 	ida_free(&hr_dev->mr_table.mtpt_ida.ida, (int)obj);
 }
 
@@ -125,7 +126,10 @@ static int alloc_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
 
 static void free_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 {
-	hns_roce_mtr_destroy(hr_dev, mr->pbl_mtr);
+	if (mr->delayed_destroy_flag && mr->type != MR_TYPE_DMA)
+		hns_roce_add_unfree_mtr(hr_dev, mr->pbl_mtr);
+	else
+		hns_roce_mtr_destroy(hr_dev, mr->pbl_mtr);
 }
 
 static void hns_roce_mr_free(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
@@ -137,9 +141,11 @@ static void hns_roce_mr_free(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr
 		ret = hns_roce_destroy_hw_ctx(hr_dev, HNS_ROCE_CMD_DESTROY_MPT,
 					      key_to_hw_index(mr->key) &
 					      (hr_dev->caps.num_mtpts - 1));
-		if (ret)
+		if (ret) {
+			mr->delayed_destroy_flag = true;
 			ibdev_warn_ratelimited(ibdev, "failed to destroy mpt, ret = %d.\n",
 					       ret);
+		}
 	}
 
 	free_mr_pbl(hr_dev, mr);
@@ -1220,3 +1226,23 @@ void hns_roce_mtr_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
 	mtr_free_bufs(hr_dev, mtr);
 	kvfree(mtr);
 }
+
+void hns_roce_add_unfree_mtr(struct hns_roce_dev *hr_dev,
+			     struct hns_roce_mtr *mtr)
+{
+	mutex_lock(&hr_dev->mtr_unfree_list_mutex);
+	list_add_tail(&mtr->node, &hr_dev->mtr_unfree_list);
+	mutex_unlock(&hr_dev->mtr_unfree_list_mutex);
+}
+
+void hns_roce_free_unfree_mtr(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_mtr *mtr, *next;
+
+	mutex_lock(&hr_dev->mtr_unfree_list_mutex);
+	list_for_each_entry_safe(mtr, next, &hr_dev->mtr_unfree_list, node) {
+		list_del(&mtr->node);
+		hns_roce_mtr_destroy(hr_dev, mtr);
+	}
+	mutex_unlock(&hr_dev->mtr_unfree_list_mutex);
+}
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 62fc9a3c784e..91c605f67dca 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -410,6 +410,9 @@ static void free_qpc(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
 	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
 
+	if (hr_qp->delayed_destroy_flag)
+		return;
+
 	if (hr_dev->caps.trrl_entry_sz)
 		hns_roce_table_put(hr_dev, &qp_table->trrl_table, hr_qp->qpn);
 	hns_roce_table_put(hr_dev, &qp_table->irrl_table, hr_qp->qpn);
@@ -801,7 +804,10 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 
 static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
-	hns_roce_mtr_destroy(hr_dev, hr_qp->mtr);
+	if (hr_qp->delayed_destroy_flag)
+		hns_roce_add_unfree_mtr(hr_dev, hr_qp->mtr);
+	else
+		hns_roce_mtr_destroy(hr_dev, hr_qp->mtr);
 }
 
 static inline bool user_qp_has_sdb(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 6685e5a1afd2..848a82395185 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -150,9 +150,11 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 
 	ret = hns_roce_destroy_hw_ctx(hr_dev, HNS_ROCE_CMD_DESTROY_SRQ,
 				      srq->srqn);
-	if (ret)
+	if (ret) {
+		srq->delayed_destroy_flag = true;
 		dev_err_ratelimited(hr_dev->dev, "DESTROY_SRQ failed (%d) for SRQN %06lx\n",
 				    ret, srq->srqn);
+	}
 
 	xa_erase_irq(&srq_table->xa, srq->srqn);
 
@@ -160,7 +162,8 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 		complete(&srq->free);
 	wait_for_completion(&srq->free);
 
-	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
+	if (!srq->delayed_destroy_flag)
+		hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
 }
 
 static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
@@ -213,7 +216,10 @@ static void free_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 
 	bitmap_free(idx_que->bitmap);
 	idx_que->bitmap = NULL;
-	hns_roce_mtr_destroy(hr_dev, idx_que->mtr);
+	if (srq->delayed_destroy_flag)
+		hns_roce_add_unfree_mtr(hr_dev, idx_que->mtr);
+	else
+		hns_roce_mtr_destroy(hr_dev, idx_que->mtr);
 }
 
 static int alloc_srq_wqe_buf(struct hns_roce_dev *hr_dev,
@@ -248,7 +254,10 @@ static int alloc_srq_wqe_buf(struct hns_roce_dev *hr_dev,
 static void free_srq_wqe_buf(struct hns_roce_dev *hr_dev,
 			     struct hns_roce_srq *srq)
 {
-	hns_roce_mtr_destroy(hr_dev, srq->buf_mtr);
+	if (srq->delayed_destroy_flag)
+		hns_roce_add_unfree_mtr(hr_dev, srq->buf_mtr);
+	else
+		hns_roce_mtr_destroy(hr_dev, srq->buf_mtr);
 }
 
 static int alloc_srq_wrid(struct hns_roce_srq *srq)
-- 
2.33.0


