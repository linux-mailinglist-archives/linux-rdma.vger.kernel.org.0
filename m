Return-Path: <linux-rdma+bounces-17421-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMsAKdDZpmnHWgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17421-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 13:53:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 068251EFBCB
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 13:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12F22308104D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 12:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D5435AC1C;
	Tue,  3 Mar 2026 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ts2vl7u0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAC0223DD6;
	Tue,  3 Mar 2026 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542107; cv=none; b=YEM0Fc9hReC1MJEWrraRlUw5W+1ccNL6xt1k38OrxbP014bNPI14zWwPb10HYcfcxjbb5gxST7jsvpOA+2iw8ZFM16O6K0KkoXSk8a2RjFay6JpQEkLuxvNrQHFglIw+/Pm2p5DOjkwP2xuUUkMFtlE8bG36G+BWCBTlmCbmANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542107; c=relaxed/simple;
	bh=IRjiKWB6fyHS5y6UzfVYtYwAVCCnNRWCS2o5OO/UWso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/fUGtOTLFSzG6Aj4NT4lUQ+D9YnziOQW0Js5rJ3ehGxRynJX4A6C8GAEzM0IK+okxOIdpy0IMCv9HY+AbYvs/fGMghsXW/IGv7JBztTsWrSvt0XhVZpE+BkgHeh170dso/H/CykxFDWqvqFkItZKHKTtx3NuYUpGvO5vlUT3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ts2vl7u0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 3356D20B6F03; Tue,  3 Mar 2026 04:48:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3356D20B6F03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772542105;
	bh=W9frpUI/t07uA3QFYc+fK3UQVBHW5ReAeHkTyIOxO2w=;
	h=From:To:Cc:Subject:Date:From;
	b=Ts2vl7u0H1gn3PmODcOU6+kGF8QswR3whbhq7VH3aaLuY2cGF+6lldciPXqqPybAy
	 8QWWhlrIaD3QaKYNfFKjmuJUPF/kC5e+eOD1iDeY++u3NZdjV9VcphbJ3EvhUlhByA
	 OyVBhqvPqIeEeQdvsrsjFZt/OhbT+zNQ4l+m9NTQ=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 1/1] RDMA/mana: Provide a modern CQ creation interface
Date: Tue,  3 Mar 2026 04:48:25 -0800
Message-ID: <20260303124825.301452-1-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 068251EFBCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17421-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@linux.microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Action: no action

From: Konstantin Taranov <kotaranov@microsoft.com>

The uverbs CQ creation UAPI allows users to supply their own umem for a CQ.
Update mana to support this workflow while preserving support for creating
umem through the legacy interface.

To support RDMA objects that own umem, extend mana_ib_create_queue() to return
the umem to the caller and do not allocate umem if it was allocted
by the caller.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
v2: It is a rework of the patch proposed by Leon
 drivers/infiniband/hw/mana/cq.c      | 125 +++++++++++++++++----------
 drivers/infiniband/hw/mana/device.c  |   1 +
 drivers/infiniband/hw/mana/main.c    |  30 +++++--
 drivers/infiniband/hw/mana/mana_ib.h |   5 +-
 drivers/infiniband/hw/mana/qp.c      |   5 +-
 drivers/infiniband/hw/mana/wq.c      |   3 +-
 6 files changed, 111 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index b2749f971..fa951732a 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -8,12 +8,8 @@
 int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs)
 {
-	struct ib_udata *udata = &attrs->driver_udata;
 	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
-	struct mana_ib_create_cq_resp resp = {};
-	struct mana_ib_ucontext *mana_ucontext;
 	struct ib_device *ibdev = ibcq->device;
-	struct mana_ib_create_cq ucmd = {};
 	struct mana_ib_dev *mdev;
 	bool is_rnic_cq;
 	u32 doorbell;
@@ -26,48 +22,91 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->cq_handle = INVALID_MANA_HANDLE;
 	is_rnic_cq = mana_ib_is_rnic(mdev);
 
-	if (udata) {
-		if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
-			return -EINVAL;
-
-		err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
-		if (err) {
-			ibdev_dbg(ibdev, "Failed to copy from udata for create cq, %d\n", err);
-			return err;
-		}
+	if (attr->cqe > U32_MAX / COMP_ENTRY_SIZE / 2 + 1)
+		return -EINVAL;
 
-		if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) ||
-		    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
-			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
-			return -EINVAL;
-		}
+	buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe * COMP_ENTRY_SIZE));
+	cq->cqe = buf_size / COMP_ENTRY_SIZE;
+	err = mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ, &cq->queue);
+	if (err) {
+		ibdev_dbg(ibdev, "Failed to create kernel queue for create cq, %d\n", err);
+		return err;
+	}
+	doorbell = mdev->gdma_dev->doorbell;
 
-		cq->cqe = attr->cqe;
-		err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE,
-					   &cq->queue);
+	if (is_rnic_cq) {
+		err = mana_ib_gd_create_cq(mdev, cq, doorbell);
 		if (err) {
-			ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
-			return err;
+			ibdev_dbg(ibdev, "Failed to create RNIC cq, %d\n", err);
+			goto err_destroy_queue;
 		}
 
-		mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
-							  ibucontext);
-		doorbell = mana_ucontext->doorbell;
-	} else {
-		if (attr->cqe > U32_MAX / COMP_ENTRY_SIZE / 2 + 1) {
-			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
-			return -EINVAL;
-		}
-		buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe * COMP_ENTRY_SIZE));
-		cq->cqe = buf_size / COMP_ENTRY_SIZE;
-		err = mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ, &cq->queue);
+		err = mana_ib_install_cq_cb(mdev, cq);
 		if (err) {
-			ibdev_dbg(ibdev, "Failed to create kernel queue for create cq, %d\n", err);
-			return err;
+			ibdev_dbg(ibdev, "Failed to install cq callback, %d\n", err);
+			goto err_destroy_rnic_cq;
 		}
-		doorbell = mdev->gdma_dev->doorbell;
 	}
 
+	spin_lock_init(&cq->cq_lock);
+	INIT_LIST_HEAD(&cq->list_send_qp);
+	INIT_LIST_HEAD(&cq->list_recv_qp);
+
+	return 0;
+
+err_destroy_rnic_cq:
+	mana_ib_gd_destroy_cq(mdev, cq);
+err_destroy_queue:
+	mana_ib_destroy_queue(mdev, &cq->queue);
+
+	return err;
+}
+
+int mana_ib_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct uverbs_attr_bundle *attrs)
+{
+	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
+	struct ib_udata *udata = &attrs->driver_udata;
+	struct mana_ib_create_cq_resp resp = {};
+	struct mana_ib_ucontext *mana_ucontext;
+	struct ib_device *ibdev = ibcq->device;
+	struct mana_ib_create_cq ucmd = {};
+	struct mana_ib_dev *mdev;
+	bool is_rnic_cq;
+	u32 doorbell;
+	int err;
+
+	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+
+	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
+	cq->cq_handle = INVALID_MANA_HANDLE;
+	is_rnic_cq = mana_ib_is_rnic(mdev);
+
+	if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
+		return -EINVAL;
+
+	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
+	if (err) {
+		ibdev_dbg(ibdev, "Failed to copy from udata for create cq, %d\n", err);
+		return err;
+	}
+
+	if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) ||
+	    attr->cqe > U32_MAX / COMP_ENTRY_SIZE)
+		return -EINVAL;
+
+	cq->cqe = attr->cqe;
+	err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE,
+				   &cq->queue, &ibcq->umem);
+	if (err) {
+		ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
+		return err;
+	}
+
+	mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
+						  ibucontext);
+	doorbell = mana_ucontext->doorbell;
+
 	if (is_rnic_cq) {
 		err = mana_ib_gd_create_cq(mdev, cq, doorbell);
 		if (err) {
@@ -82,13 +121,11 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		}
 	}
 
-	if (udata) {
-		resp.cqid = cq->queue.id;
-		err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
-			goto err_remove_cq_cb;
-		}
+	resp.cqid = cq->queue.id;
+	err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+	if (err) {
+		ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
+		goto err_remove_cq_cb;
 	}
 
 	spin_lock_init(&cq->cq_lock);
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index ccc2279ca..c5c5fe051 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -21,6 +21,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.alloc_ucontext = mana_ib_alloc_ucontext,
 	.create_ah = mana_ib_create_ah,
 	.create_cq = mana_ib_create_cq,
+	.create_user_cq = mana_ib_create_user_cq,
 	.create_qp = mana_ib_create_qp,
 	.create_rwq_ind_table = mana_ib_create_rwq_ind_table,
 	.create_wq = mana_ib_create_wq,
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 8d99cd00f..d1f1e217b 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -262,33 +262,45 @@ int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_qu
 }
 
 int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
-			 struct mana_ib_queue *queue)
+			 struct mana_ib_queue *queue, struct ib_umem **umem)
 {
-	struct ib_umem *umem;
 	int err;
 
 	queue->umem = NULL;
 	queue->id = INVALID_QUEUE_ID;
 	queue->gdma_region = GDMA_INVALID_DMA_REGION;
 
-	umem = ib_umem_get(&mdev->ib_dev, addr, size, IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(umem)) {
-		ibdev_dbg(&mdev->ib_dev, "Failed to get umem, %pe\n", umem);
-		return PTR_ERR(umem);
+	if (umem)
+		queue->umem = *umem;
+
+	if (!queue->umem) {
+		/* if umem is not provided, allocate it */
+		queue->umem = ib_umem_get(&mdev->ib_dev, addr, size, IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(queue->umem)) {
+			ibdev_dbg(&mdev->ib_dev, "Failed to get umem, %pe\n", queue->umem);
+			return PTR_ERR(queue->umem);
+		}
 	}
 
-	err = mana_ib_create_zero_offset_dma_region(mdev, umem, &queue->gdma_region);
+	err = mana_ib_create_zero_offset_dma_region(mdev, queue->umem, &queue->gdma_region);
 	if (err) {
 		ibdev_dbg(&mdev->ib_dev, "Failed to create dma region, %d\n", err);
 		goto free_umem;
 	}
-	queue->umem = umem;
 
 	ibdev_dbg(&mdev->ib_dev, "created dma region 0x%llx\n", queue->gdma_region);
 
+	if (umem) {
+		/* Give ownership of umem to the caller */
+		*umem = queue->umem;
+		queue->umem = NULL;
+	}
+
 	return 0;
 free_umem:
-	ib_umem_release(umem);
+	if (!umem || !(*umem))
+		/* deallocate mana's umem */
+		ib_umem_release(queue->umem);
 	return err;
 }
 
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index a7c8c0fd7..56ebd086b 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -625,7 +625,7 @@ int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev,
 int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_queue_type type,
 				struct mana_ib_queue *queue);
 int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
-			 struct mana_ib_queue *queue);
+			 struct mana_ib_queue *queue, struct ib_umem **umem);
 void mana_ib_destroy_queue(struct mana_ib_dev *mdev, struct mana_ib_queue *queue);
 
 struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
@@ -667,7 +667,8 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
 
 int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
-
+int mana_ib_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct uverbs_attr_bundle *attrs);
 int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 
 int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 82f84f7ad..29cf3f85a 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -325,7 +325,8 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	ibdev_dbg(&mdev->ib_dev, "ucmd sq_buf_addr 0x%llx port %u\n",
 		  ucmd.sq_buf_addr, ucmd.port);
 
-	err = mana_ib_create_queue(mdev, ucmd.sq_buf_addr, ucmd.sq_buf_size, &qp->raw_sq);
+	err = mana_ib_create_queue(mdev, ucmd.sq_buf_addr, ucmd.sq_buf_size,
+				   &qp->raw_sq, NULL);
 	if (err) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to create queue for create qp-raw, err %d\n", err);
@@ -555,7 +556,7 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 			continue;
 		}
 		err = mana_ib_create_queue(mdev, ucmd.queue_buf[j], ucmd.queue_size[j],
-					   &qp->rc_qp.queues[i]);
+					   &qp->rc_qp.queues[i], NULL);
 		if (err) {
 			ibdev_err(&mdev->ib_dev, "Failed to create queue %d, err %d\n", i, err);
 			goto destroy_queues;
diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
index 6206244f7..944218b12 100644
--- a/drivers/infiniband/hw/mana/wq.c
+++ b/drivers/infiniband/hw/mana/wq.c
@@ -31,7 +31,8 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 
 	ibdev_dbg(&mdev->ib_dev, "ucmd wq_buf_addr 0x%llx\n", ucmd.wq_buf_addr);
 
-	err = mana_ib_create_queue(mdev, ucmd.wq_buf_addr, ucmd.wq_buf_size, &wq->queue);
+	err = mana_ib_create_queue(mdev, ucmd.wq_buf_addr, ucmd.wq_buf_size,
+				   &wq->queue, NULL);
 	if (err) {
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to create queue for create wq, %d\n", err);
-- 
2.43.0


