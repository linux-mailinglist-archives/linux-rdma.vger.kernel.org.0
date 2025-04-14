Return-Path: <linux-rdma+bounces-9426-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE646A88B12
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 20:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD0E3B3DF4
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC7228E603;
	Mon, 14 Apr 2025 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="skldsk11"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6A228BABF;
	Mon, 14 Apr 2025 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655332; cv=none; b=vEegigpzcWSNk3+5aK81Wt8zIRq7HnpppuFB5oN6et9ctOfS+uPHpPADBt5++I736nuX3+c9mjT2S5/qlLNFEJAVoIZTGGd6OaZ755FYrb6vjAy3p6lH1sZq718/QedIp0g8XLTPRXt8DAKnGSs79ytVQD+pCEofw7vhcFtnv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655332; c=relaxed/simple;
	bh=vdywQtUI0NTlRBdA8wejaH5TuzVIPohsDKIIzgaougg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=q/l18TdF0a7oTyLqNAo9SsDXKMqKgOOYPeRtRz/7LR0T5RSWZ3BLWxvtn7/MyEdm7Qm2sS/cndGgFGZhIN5VJ3r/RQdqDOuK6mcpc5iJ+5vRjsj/Dz0OelpelVON2cSSd/nL6AKQsOnhd3opN0r7VxlWWHvVQw+onRUeHbOBlZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=skldsk11; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id C18972052510; Mon, 14 Apr 2025 11:28:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C18972052510
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744655329;
	bh=BqzGqTyz4cd1XDrpGFG8FMLlvLuq/f9Rt5jVkarMP0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skldsk11Md0yD9FOBtjsEzs4ps481WFSBmf7PU3xKanyg38iK8tCf3Gz7CdzT083C
	 hVtKShGZBPmRpIzw/s3tVivpbIJjXKkgfXm0Smpt57LgsKmM4KVmxfI8y4UR7Tibo2
	 rkQboEddTvBUO86bbg1P7DjEFBZzdy49nJWjKOXs=
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
Subject: [PATCH rdma-next 3/4] RDMA/mana_ib: unify mana_ib functions to support any gdma device
Date: Mon, 14 Apr 2025 11:28:48 -0700
Message-Id: <1744655329-13601-4-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744655329-13601-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1744655329-13601-1-git-send-email-kotaranov@linux.microsoft.com>
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
 drivers/infiniband/hw/mana/main.c | 28 ++++++++++++++--------------
 drivers/infiniband/hw/mana/qp.c   |  5 ++---
 3 files changed, 17 insertions(+), 20 deletions(-)

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
index 64526b8..95ade5b 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -243,7 +243,6 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_queue_type type,
 				struct mana_ib_queue *queue)
 {
-	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct gdma_queue_spec spec = {};
 	int err;
 
@@ -252,7 +251,7 @@ int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_qu
 	spec.type = type;
 	spec.monitor_avl_buf = false;
 	spec.queue_size = size;
-	err = mana_gd_create_mana_wq_cq(&gc->mana_ib, &spec, &queue->kmem);
+	err = mana_gd_create_mana_wq_cq(mdev->gdma_dev, &spec, &queue->kmem);
 	if (err)
 		return err;
 	/* take ownership into mana_ib from mana */
@@ -737,6 +736,7 @@ int mana_eth_query_adapter_caps(struct mana_ib_dev *dev)
 				0x100000 / GDMA_MAX_RQE_SIZE);
 	caps->max_send_sge_count = 30;
 	caps->max_recv_sge_count = 15;
+	caps->page_size_cap = PAGE_SZ_BM;
 
 	return 0;
 }
@@ -782,7 +782,7 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
 	spec.eq.msix_index = 0;
 
-	err = mana_gd_create_mana_eq(&gc->mana_ib, &spec, &mdev->fatal_err_eq);
+	err = mana_gd_create_mana_eq(mdev->gdma_dev, &spec, &mdev->fatal_err_eq);
 	if (err)
 		return err;
 
@@ -833,7 +833,7 @@ int mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev)
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_ADAPTER, sizeof(req), sizeof(resp));
 	req.hdr.req.msg_version = GDMA_MESSAGE_V2;
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.notify_eq_id = mdev->fatal_err_eq->id;
 
 	if (mdev->adapter_caps.feature_flags & MANA_IB_FEATURE_CLIENT_ERROR_CQE_SUPPORT)
@@ -858,7 +858,7 @@ int mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev)
 
 	gc = mdev_to_gc(mdev);
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_ADAPTER, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
@@ -885,7 +885,7 @@ int mana_ib_gd_add_gid(const struct ib_gid_attr *attr, void **context)
 	}
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_IP_ADDR, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.op = ADDR_OP_ADD;
 	req.sgid_type = (ntype == RDMA_NETWORK_IPV6) ? SGID_TYPE_IPV6 : SGID_TYPE_IPV4;
@@ -915,7 +915,7 @@ int mana_ib_gd_del_gid(const struct ib_gid_attr *attr, void **context)
 	}
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_IP_ADDR, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.op = ADDR_OP_REMOVE;
 	req.sgid_type = (ntype == RDMA_NETWORK_IPV6) ? SGID_TYPE_IPV6 : SGID_TYPE_IPV4;
@@ -938,7 +938,7 @@ int mana_ib_gd_config_mac(struct mana_ib_dev *mdev, enum mana_ib_addr_op op, u8
 	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_MAC_ADDR, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.op = op;
 	copy_in_reverse(req.mac_addr, mac, ETH_ALEN);
@@ -963,7 +963,7 @@ int mana_ib_gd_create_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq, u32 do
 		return -EINVAL;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_CQ, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.gdma_region = cq->queue.gdma_region;
 	req.eq_id = mdev->eqs[cq->comp_vector]->id;
@@ -995,7 +995,7 @@ int mana_ib_gd_destroy_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 		return 0;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_CQ, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.cq_handle = cq->cq_handle;
 
@@ -1021,7 +1021,7 @@ int mana_ib_gd_create_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
 	int err, i;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_RC_QP, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.pd_handle = pd->pd_handle;
 	req.send_cq_handle = send_cq->cq_handle;
@@ -1057,7 +1057,7 @@ int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
 	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_RC_QP, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.rc_qp_handle = qp->qp_handle;
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
@@ -1080,7 +1080,7 @@ int mana_ib_gd_create_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
 	int err, i;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_UD_QP, sizeof(req), sizeof(resp));
-	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.pd_handle = pd->pd_handle;
 	req.send_cq_handle = send_cq->cq_handle;
@@ -1115,7 +1115,7 @@ int mana_ib_gd_destroy_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
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
2.43.0


