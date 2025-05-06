Return-Path: <linux-rdma+bounces-10106-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A5AACD83
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 20:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B986D1BA6D11
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 18:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FF4286D76;
	Tue,  6 May 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="n4k6L3I2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A18286413;
	Tue,  6 May 2025 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557544; cv=none; b=J+pdYKhe7K1pRuxWXqhjlUE712fxIRvk8om8lCA8kEmyOKq7mao27rkiLWFrKHOrJOkNXaajH1B4OjOWXzEtwg2wku/Qxhqxv7aCClLBLWDG5MIlmaPMwwSg+O5nkaXMILaFMU9upjr2FJFSEjkXzg0crDXlrauZi0rqtP9Xhkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557544; c=relaxed/simple;
	bh=E9zyVeuLSd/Q3m8or8d/zlcpfY40P06hv95j4xTg6Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LOe8FDGBw37hou7fVlKeqpexF+fRvpGgLfxBveihtaKh50unsJNjGY8sOzmA2GtiJcdG6slOmLMmuxvl/zTiHYK2jHwpXFBQjv02ENe37AT1RmvaSrpvQNSOHbf511RUEzUPgHOV761Gb4k2UKJOy/SU5uRqaawykVn6XhKN6E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=n4k6L3I2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id D16962115DD3; Tue,  6 May 2025 11:52:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D16962115DD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746557541;
	bh=2FDkAduyf1th1FuQPp51hcm7T+5yFvKHn4bWMU4AQ40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4k6L3I2CmHdDfjwhMbO2xcUO4qShRy285EEdPGTjg2ozHjdFCmY+phYQwO3p6Sza
	 b/xQqXNyAITvPf18P1aVfPQ7wQy2F6wRUM/kEyrZINbzWiKZG6jnkYx709afOYQED4
	 tnq2BfTBjHERRuiIsVYwblaSe7Y/30X9xnjLiCmM=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH rdma-next v3 3/4] RDMA/mana_ib: unify mana_ib functions to support any gdma device
Date: Tue,  6 May 2025 11:52:20 -0700
Message-Id: <1746557541-3617-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746557541-3617-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1746557541-3617-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Use the installed gdma_device instead of hard-coded device
in requests to the HW.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c   |  4 +---
 drivers/infiniband/hw/mana/main.c | 27 +++++++++++++--------------
 drivers/infiniband/hw/mana/qp.c   |  5 ++---
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 0fc4e26..28e154b 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -15,14 +15,12 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_create_cq ucmd = {};
 	struct mana_ib_dev *mdev;
-	struct gdma_context *gc;
 	bool is_rnic_cq;
 	u32 doorbell;
 	u32 buf_size;
 	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mdev_to_gc(mdev);
 
 	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
 	cq->cq_handle = INVALID_MANA_HANDLE;
@@ -65,7 +63,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			ibdev_dbg(ibdev, "Failed to create kernel queue for create cq, %d\n", err);
 			return err;
 		}
-		doorbell = gc->mana_ib.doorbell;
+		doorbell = mdev->gdma_dev->doorbell;
 	}
 
 	if (is_rnic_cq) {
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index dd8bfb8..db60979 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -244,7 +244,6 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_queue_type type,
 				struct mana_ib_queue *queue)
 {
-	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct gdma_queue_spec spec = {};
 	int err;
 
@@ -253,7 +252,7 @@ int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_qu
 	spec.type = type;
 	spec.monitor_avl_buf = false;
 	spec.queue_size = size;
-	err = mana_gd_create_mana_wq_cq(&gc->mana_ib, &spec, &queue->kmem);
+	err = mana_gd_create_mana_wq_cq(mdev->gdma_dev, &spec, &queue->kmem);
 	if (err)
 		return err;
 	/* take ownership into mana_ib from mana */
@@ -784,7 +783,7 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
 	spec.eq.msix_index = 0;
 
-	err = mana_gd_create_mana_eq(&gc->mana_ib, &spec, &mdev->fatal_err_eq);
+	err = mana_gd_create_mana_eq(mdev->gdma_dev, &spec, &mdev->fatal_err_eq);
 	if (err)
 		return err;
 
@@ -835,7 +834,7 @@ int mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev)
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_ADAPTER, sizeof(req), sizeof(resp));
 	req.hdr.req.msg_version = GDMA_MESSAGE_V2;
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.notify_eq_id = mdev->fatal_err_eq->id;
 
 	if (mdev->adapter_caps.feature_flags & MANA_IB_FEATURE_CLIENT_ERROR_CQE_SUPPORT)
@@ -860,7 +859,7 @@ int mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev)
 
 	gc = mdev_to_gc(mdev);
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_ADAPTER, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
@@ -887,7 +886,7 @@ int mana_ib_gd_add_gid(const struct ib_gid_attr *attr, void **context)
 	}
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_IP_ADDR, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.op = ADDR_OP_ADD;
 	req.sgid_type = (ntype == RDMA_NETWORK_IPV6) ? SGID_TYPE_IPV6 : SGID_TYPE_IPV4;
@@ -917,7 +916,7 @@ int mana_ib_gd_del_gid(const struct ib_gid_attr *attr, void **context)
 	}
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_IP_ADDR, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.op = ADDR_OP_REMOVE;
 	req.sgid_type = (ntype == RDMA_NETWORK_IPV6) ? SGID_TYPE_IPV6 : SGID_TYPE_IPV4;
@@ -940,7 +939,7 @@ int mana_ib_gd_config_mac(struct mana_ib_dev *mdev, enum mana_ib_addr_op op, u8
 	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_MAC_ADDR, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.op = op;
 	copy_in_reverse(req.mac_addr, mac, ETH_ALEN);
@@ -965,7 +964,7 @@ int mana_ib_gd_create_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq, u32 do
 		return -EINVAL;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_CQ, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.gdma_region = cq->queue.gdma_region;
 	req.eq_id = mdev->eqs[cq->comp_vector]->id;
@@ -997,7 +996,7 @@ int mana_ib_gd_destroy_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 		return 0;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_CQ, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.cq_handle = cq->cq_handle;
 
@@ -1023,7 +1022,7 @@ int mana_ib_gd_create_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
 	int err, i;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_RC_QP, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.pd_handle = pd->pd_handle;
 	req.send_cq_handle = send_cq->cq_handle;
@@ -1059,7 +1058,7 @@ int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
 	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_RC_QP, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.rc_qp_handle = qp->qp_handle;
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
@@ -1082,7 +1081,7 @@ int mana_ib_gd_create_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
 	int err, i;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_UD_QP, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.pd_handle = pd->pd_handle;
 	req.send_cq_handle = send_cq->cq_handle;
@@ -1117,7 +1116,7 @@ int mana_ib_gd_destroy_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
 	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_UD_QP, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.qp_handle = qp->qp_handle;
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index c928af5..14fd7d6 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -635,7 +635,6 @@ static int mana_ib_create_ud_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 {
 	struct mana_ib_dev *mdev = container_of(ibpd->device, struct mana_ib_dev, ib_dev);
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
-	struct gdma_context *gc = mdev_to_gc(mdev);
 	u32 doorbell, queue_size;
 	int i, err;
 
@@ -654,7 +653,7 @@ static int mana_ib_create_ud_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 			goto destroy_queues;
 		}
 	}
-	doorbell = gc->mana_ib.doorbell;
+	doorbell = mdev->gdma_dev->doorbell;
 
 	err = create_shadow_queue(&qp->shadow_rq, attr->cap.max_recv_wr,
 				  sizeof(struct ud_rq_shadow_wqe));
@@ -736,7 +735,7 @@ static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_SET_QP_STATE, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.qp_handle = qp->qp_handle;
 	req.qp_state = attr->qp_state;
-- 
1.8.3.1


