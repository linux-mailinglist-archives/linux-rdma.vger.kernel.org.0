Return-Path: <linux-rdma+bounces-592-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00A1829C2B
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jan 2024 15:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C815F1C2272B
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jan 2024 14:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC754BA80;
	Wed, 10 Jan 2024 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TYQ6n5xg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E76495C5;
	Wed, 10 Jan 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D920D20AECA9;
	Wed, 10 Jan 2024 06:10:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D920D20AECA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704895801;
	bh=Bx6tpgbJ7znSR0iIVezjMBXLyqJuhwxy1SofVQ/JPvw=;
	h=From:To:Cc:Subject:Date:From;
	b=TYQ6n5xgLYzvwXzwRXHkniE+tEWgLDTHg81bu4RjBUSBaxtaIEDCh3i1pGZQkfndT
	 NaIfEX81DNwWbIZX36q83QA3GYzqzf+SlKgbP92uYZbqSUAlX8B4J5QgZFhuZuWlWE
	 N4aJtpYkMa38CIaE575e1F7ywfzYsb5E1VnwtOrI=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH next 1/1] Introduce three helper functions to clean mana_ib code
Date: Wed, 10 Jan 2024 06:09:54 -0800
Message-Id: <1704895794-3501-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch aims to address two issues in mana_ib:
1) Unsafe and inconsistent access to gdma_dev and  gdma_context
2) Code repetitions

As a rule of thumb, functions should not access gdma_dev directly

Introduced functions:
1) mdev_to_gc
2) mana_ib_get_netdev
3) mana_ib_install_cq_cb


Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      | 23 ++++++++++++++--
 drivers/infiniband/hw/mana/main.c    | 40 ++++++++++------------------
 drivers/infiniband/hw/mana/mana_ib.h | 17 ++++++++++++
 drivers/infiniband/hw/mana/mr.c      | 13 +++------
 drivers/infiniband/hw/mana/qp.c      | 36 ++++++-------------------
 5 files changed, 63 insertions(+), 66 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 83ebd0705..255e74ab7 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -16,7 +16,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mdev->gdma_dev->gdma_context;
+	gc = mdev_to_gc(mdev);
 
 	if (udata->inlen < sizeof(ucmd))
 		return -EINVAL;
@@ -81,7 +81,7 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	int err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mdev->gdma_dev->gdma_context;
+	gc = mdev_to_gc(mdev);
 
 	err = mana_ib_gd_destroy_dma_region(mdev, cq->gdma_region);
 	if (err) {
@@ -107,3 +107,22 @@ void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq)
 	if (cq->ibcq.comp_handler)
 		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 }
+
+int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
+{
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct gdma_queue *gdma_cq;
+
+	/* Create CQ table entry */
+	WARN_ON(gc->cq_table[cq->id]);
+	gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
+	if (!gdma_cq)
+		return -ENOMEM;
+
+	gdma_cq->cq.context = cq;
+	gdma_cq->type = GDMA_CQ;
+	gdma_cq->cq.callback = mana_ib_cq_handler;
+	gdma_cq->id = cq->id;
+	gc->cq_table[cq->id] = gdma_cq;
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index faca09245..29dd2438d 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -8,13 +8,10 @@
 void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
 			 u32 port)
 {
-	struct gdma_dev *gd = &dev->gdma_dev->gdma_context->mana;
 	struct mana_port_context *mpc;
 	struct net_device *ndev;
-	struct mana_context *mc;
 
-	mc = gd->driver_data;
-	ndev = mc->ports[port];
+	ndev = mana_ib_get_netdev(&dev->ib_dev, port);
 	mpc = netdev_priv(ndev);
 
 	mutex_lock(&pd->vport_mutex);
@@ -31,14 +28,11 @@ void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
 int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
 		      u32 doorbell_id)
 {
-	struct gdma_dev *mdev = &dev->gdma_dev->gdma_context->mana;
 	struct mana_port_context *mpc;
-	struct mana_context *mc;
 	struct net_device *ndev;
 	int err;
 
-	mc = mdev->driver_data;
-	ndev = mc->ports[port];
+	ndev = mana_ib_get_netdev(&dev->ib_dev, port);
 	mpc = netdev_priv(ndev);
 
 	mutex_lock(&pd->vport_mutex);
@@ -79,17 +73,17 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct gdma_create_pd_req req = {};
 	enum gdma_pd_flags flags = 0;
 	struct mana_ib_dev *dev;
-	struct gdma_dev *mdev;
+	struct gdma_context *gc;
 	int err;
 
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	mdev = dev->gdma_dev;
+	gc = mdev_to_gc(dev);
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
 			     sizeof(resp));
 
 	req.flags = flags;
-	err = mana_gd_send_request(mdev->gdma_context, sizeof(req), &req,
+	err = mana_gd_send_request(gc, sizeof(req), &req,
 				   sizeof(resp), &resp);
 
 	if (err || resp.hdr.status) {
@@ -119,17 +113,17 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct gdma_destory_pd_resp resp = {};
 	struct gdma_destroy_pd_req req = {};
 	struct mana_ib_dev *dev;
-	struct gdma_dev *mdev;
+	struct gdma_context *gc;
 	int err;
 
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	mdev = dev->gdma_dev;
+	gc = mdev_to_gc(dev);
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),
 			     sizeof(resp));
 
 	req.pd_handle = pd->pd_handle;
-	err = mana_gd_send_request(mdev->gdma_context, sizeof(req), &req,
+	err = mana_gd_send_request(gc, sizeof(req), &req,
 				   sizeof(resp), &resp);
 
 	if (err || resp.hdr.status) {
@@ -206,13 +200,11 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 	struct ib_device *ibdev = ibcontext->device;
 	struct mana_ib_dev *mdev;
 	struct gdma_context *gc;
-	struct gdma_dev *dev;
 	int doorbell_page;
 	int ret;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	dev = mdev->gdma_dev;
-	gc = dev->gdma_context;
+	gc = mdev_to_gc(mdev);
 
 	/* Allocate a doorbell page index */
 	ret = mana_gd_allocate_doorbell_page(gc, &doorbell_page);
@@ -238,7 +230,7 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	int ret;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mdev->gdma_dev->gdma_context;
+	gc = mdev_to_gc(mdev);
 
 	ret = mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell);
 	if (ret)
@@ -322,15 +314,13 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 	size_t max_pgs_create_cmd;
 	struct gdma_context *gc;
 	size_t num_pages_total;
-	struct gdma_dev *mdev;
 	unsigned long page_sz;
 	unsigned int tail = 0;
 	u64 *page_addr_list;
 	void *request_buf;
 	int err;
 
-	mdev = dev->gdma_dev;
-	gc = mdev->gdma_context;
+	gc = mdev_to_gc(dev);
 	hwc = gc->hwc.driver_data;
 
 	/* Hardware requires dma region to align to chosen page size */
@@ -426,10 +416,8 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 
 int mana_ib_gd_destroy_dma_region(struct mana_ib_dev *dev, u64 gdma_region)
 {
-	struct gdma_dev *mdev = dev->gdma_dev;
-	struct gdma_context *gc;
+	struct gdma_context *gc = mdev_to_gc(dev);
 
-	gc = mdev->gdma_context;
 	ibdev_dbg(&dev->ib_dev, "destroy dma region 0x%llx\n", gdma_region);
 
 	return mana_gd_destroy_dma_region(gc, gdma_region);
@@ -447,7 +435,7 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
 	int ret;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
-	gc = mdev->gdma_dev->gdma_context;
+	gc = mdev_to_gc(mdev);
 
 	if (vma->vm_pgoff != 0) {
 		ibdev_dbg(ibdev, "Unexpected vm_pgoff %lu\n", vma->vm_pgoff);
@@ -531,7 +519,7 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
 	req.hdr.resp.msg_version = GDMA_MESSAGE_V3;
 	req.hdr.dev_id = dev->gdma_dev->dev_id;
 
-	err = mana_gd_send_request(dev->gdma_dev->gdma_context, sizeof(req),
+	err = mana_gd_send_request(mdev_to_gc(dev), sizeof(req),
 				   &req, sizeof(resp), &resp);
 
 	if (err) {
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 6bdc0f549..6b15b2ab5 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -142,6 +142,22 @@ struct mana_ib_query_adapter_caps_resp {
 	u32 max_inline_data_size;
 }; /* HW Data */
 
+static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
+{
+	return mdev->gdma_dev->gdma_context;
+}
+
+static inline struct net_device *mana_ib_get_netdev(struct ib_device *ibdev, u32 port)
+{
+	struct mana_ib_dev *mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct mana_context *mc = gc->mana.driver_data;
+
+	if (port < 1 || port > mc->num_ports)
+		return NULL;
+	return mc->ports[port - 1];
+}
+
 int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 				 mana_handle_t *gdma_region);
 
@@ -188,6 +204,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct ib_udata *udata);
 
 int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
+int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
 
 int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
 int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 351207c60..ee4d4f834 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -30,12 +30,9 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_mr *mr,
 {
 	struct gdma_create_mr_response resp = {};
 	struct gdma_create_mr_request req = {};
-	struct gdma_dev *mdev = dev->gdma_dev;
-	struct gdma_context *gc;
+	struct gdma_context *gc = mdev_to_gc(dev);
 	int err;
 
-	gc = mdev->gdma_context;
-
 	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_MR, sizeof(req),
 			     sizeof(resp));
 	req.pd_handle = mr_params->pd_handle;
@@ -77,12 +74,9 @@ static int mana_ib_gd_destroy_mr(struct mana_ib_dev *dev, u64 mr_handle)
 {
 	struct gdma_destroy_mr_response resp = {};
 	struct gdma_destroy_mr_request req = {};
-	struct gdma_dev *mdev = dev->gdma_dev;
-	struct gdma_context *gc;
+	struct gdma_context *gc = mdev_to_gc(dev);
 	int err;
 
-	gc = mdev->gdma_context;
-
 	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_MR, sizeof(req),
 			     sizeof(resp));
 
@@ -164,8 +158,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	return &mr->ibmr;
 
 err_dma_region:
-	mana_gd_destroy_dma_region(dev->gdma_dev->gdma_context,
-				   dma_region_handle);
+	mana_gd_destroy_dma_region(mdev_to_gc(dev), dma_region_handle);
 
 err_umem:
 	ib_umem_release(mr->umem);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index e6d063d45..e889c798f 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -17,12 +17,10 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	struct mana_cfg_rx_steer_resp resp = {};
 	mana_handle_t *req_indir_tab;
 	struct gdma_context *gc;
-	struct gdma_dev *mdev;
 	u32 req_buf_size;
 	int i, err;
 
-	gc = dev->gdma_dev->gdma_context;
-	mdev = &gc->mana;
+	gc = mdev_to_gc(dev);
 
 	req_buf_size =
 		sizeof(*req) + sizeof(mana_handle_t) * MANA_INDIRECT_TABLE_SIZE;
@@ -39,7 +37,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	req->rx_enable = 1;
 	req->update_default_rxobj = 1;
 	req->default_rxobj = default_rxobj;
-	req->hdr.dev_id = mdev->dev_id;
+	req->hdr.dev_id = gc->mana.dev_id;
 
 	/* If there are more than 1 entries in indirection table, enable RSS */
 	if (log_ind_tbl_size)
@@ -106,7 +104,6 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	struct gdma_queue **gdma_cq_allocated;
 	mana_handle_t *mana_ind_table;
 	struct mana_port_context *mpc;
-	struct gdma_queue *gdma_cq;
 	unsigned int ind_tbl_size;
 	struct net_device *ndev;
 	struct mana_ib_cq *cq;
@@ -231,19 +228,11 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		mana_ind_table[i] = wq->rx_object;
 
 		/* Create CQ table entry */
-		WARN_ON(gc->cq_table[cq->id]);
-		gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
-		if (!gdma_cq) {
-			ret = -ENOMEM;
+		ret = mana_ib_install_cq_cb(mdev, cq);
+		if (!ret)
 			goto fail;
-		}
-		gdma_cq_allocated[i] = gdma_cq;
 
-		gdma_cq->cq.context = cq;
-		gdma_cq->type = GDMA_CQ;
-		gdma_cq->cq.callback = mana_ib_cq_handler;
-		gdma_cq->id = cq->id;
-		gc->cq_table[cq->id] = gdma_cq;
+		gdma_cq_allocated[i] = gc->cq_table[cq->id];
 	}
 	resp.num_entries = i;
 
@@ -409,18 +398,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	send_cq->id = cq_spec.queue_index;
 
 	/* Create CQ table entry */
-	WARN_ON(gc->cq_table[send_cq->id]);
-	gdma_cq = kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
-	if (!gdma_cq) {
-		err = -ENOMEM;
+	err = mana_ib_install_cq_cb(mdev, send_cq);
+	if (err)
 		goto err_destroy_wq_obj;
-	}
-
-	gdma_cq->cq.context = send_cq;
-	gdma_cq->type = GDMA_CQ;
-	gdma_cq->cq.callback = mana_ib_cq_handler;
-	gdma_cq->id = send_cq->id;
-	gc->cq_table[send_cq->id] = gdma_cq;
 
 	ibdev_dbg(&mdev->ib_dev,
 		  "ret %d qp->tx_object 0x%llx sq id %llu cq id %llu\n", err,
@@ -442,7 +422,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 
 err_release_gdma_cq:
 	kfree(gdma_cq);
-	gd->gdma_context->cq_table[send_cq->id] = NULL;
+	gc->cq_table[send_cq->id] = NULL;
 
 err_destroy_wq_obj:
 	mana_destroy_wq_obj(mpc, GDMA_SQ, qp->tx_object);

base-commit: d24b923f1d696ddacb09f0f2d1b1f4f045cfe65e
prerequisite-patch-id: 1b5d35ba40b675d080bfbe6a0e73b0dd163f4a03
-- 
2.43.0


