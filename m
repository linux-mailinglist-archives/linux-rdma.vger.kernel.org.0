Return-Path: <linux-rdma+bounces-3449-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A3A915323
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 18:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC8428180E
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B7119D886;
	Mon, 24 Jun 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pq4Rc3E6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C006D19D094
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245378; cv=none; b=kQ6Fz6pkMH5vX16vyT8S/c5NkfJqIjt0dAoWnJsCf1MAT4pPeP0lMb4JMeGPtoEKtZaiLjK7yQrSdKjKq8jz34i1bN69TaV6NDUSIxH0lyZuHqagd+3ycVWEFMEvM7mrPxFF8FNjbI3zkWEerkmPWTs2JXyfRINw7Lc8C926/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245378; c=relaxed/simple;
	bh=Fi1HRGuZOBI3DzFRkIAAJa+b/gEuHLS5amsLegcJFvo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Quzo1yxBOVf+Z7XTixT2JGM5KeIgD+u4AUxAN7c3bJ8e0SxwcTBfK1nbg8CpfRPkNHXZL4VgGaXlxmtHgd+ooaOv/B6qVdm1Q7e4+bLO8pj7WORVUtNbopbKEhsCOHIXtzqckOYhvAUEWtclpYqKYYr2GR207EtqnkGlmauALys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pq4Rc3E6; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719245376; x=1750781376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4bX5GXToIChq40vQxKBH23TmEXiFRoBOGg20RPJq2eU=;
  b=pq4Rc3E66YuwmqUtmDXF3p5oX4JRHiEiurYJuXbw4tE3tis4BwEkpL5n
   XOuUppj5wgARa+54DeQhwHC4ZaeW1H2BXs6GF92D1ZUeKlD0HBcYe89tj
   AHd8RWc3h4YFqU3zKU3qBuajY1y5AjQm3a8NfPFWC8uiSAS4wTQy8myMV
   4=;
X-IronPort-AV: E=Sophos;i="6.08,262,1712620800"; 
   d="scan'208";a="352108345"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 16:09:30 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:17090]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.61:2525] with esmtp (Farcaster)
 id 12faa0de-9aef-48e4-a0b9-da5941011683; Mon, 24 Jun 2024 16:09:28 +0000 (UTC)
X-Farcaster-Flow-ID: 12faa0de-9aef-48e4-a0b9-da5941011683
Received: from EX19D045EUA003.ant.amazon.com (10.252.50.74) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Jun 2024 16:09:27 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D045EUA003.ant.amazon.com (10.252.50.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Jun 2024 16:09:26 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.252.134.102) with Microsoft
 SMTP Server id 15.2.1258.34 via Frontend Transport; Mon, 24 Jun 2024 16:09:25
 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Firas
 Jahjah" <firasj@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next 5/5] RDMA/efa: Align private func names to a single convention
Date: Mon, 24 Jun 2024 16:09:18 +0000
Message-ID: <20240624160918.27060-6-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240624160918.27060-1-mrgolin@amazon.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Name functions that aren't exposed outside of a file with '_' prefix and
make sure that all verbs ops' implementations are named according to the
op name with an additional 'efa_' prefix.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h       |   6 +-
 drivers/infiniband/hw/efa/efa_main.c  |   2 +-
 drivers/infiniband/hw/efa/efa_verbs.c | 285 ++++++++++++--------------
 3 files changed, 132 insertions(+), 161 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index f1020bf85b78..655db23e81b6 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -197,9 +197,9 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		  struct ib_udata *udata);
-struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
-			 u64 virt_addr, int access_flags,
-			 struct ib_udata *udata);
+struct ib_mr *efa_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
+			      u64 virt_addr, int access_flags,
+			      struct ib_udata *udata);
 struct ib_mr *efa_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start,
 				     u64 length, u64 virt_addr,
 				     int fd, int access_flags,
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 99f9ac23c721..bff2485a76a0 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -394,7 +394,7 @@ static const struct ib_device_ops efa_dev_ops = {
 	.query_pkey = efa_query_pkey,
 	.query_port = efa_query_port,
 	.query_qp = efa_query_qp,
-	.reg_user_mr = efa_reg_mr,
+	.reg_user_mr = efa_reg_user_mr,
 	.reg_user_mr_dmabuf = efa_reg_user_mr_dmabuf,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, efa_ah, ibah),
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 34a9f86af9bd..f56ba8732aef 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -128,7 +128,7 @@ struct pbl_context {
 };
 
 static inline struct efa_user_mmap_entry *
-to_emmap(struct rdma_user_mmap_entry *rdma_entry)
+_to_emmap(struct rdma_user_mmap_entry *rdma_entry)
 {
 	return container_of(rdma_entry, struct efa_user_mmap_entry, rdma_entry);
 }
@@ -140,8 +140,8 @@ to_emmap(struct rdma_user_mmap_entry *rdma_entry)
 #define is_reserved_cleared(reserved) \
 	!memchr_inv(reserved, 0, sizeof(reserved))
 
-static void *efa_zalloc_mapped(struct efa_dev *dev, dma_addr_t *dma_addr,
-			       size_t size, enum dma_data_direction dir)
+static void *_zalloc_mapped(struct efa_dev *dev, dma_addr_t *dma_addr,
+			    size_t size, enum dma_data_direction dir)
 {
 	void *addr;
 
@@ -159,9 +159,8 @@ static void *efa_zalloc_mapped(struct efa_dev *dev, dma_addr_t *dma_addr,
 	return addr;
 }
 
-static void efa_free_mapped(struct efa_dev *dev, void *cpu_addr,
-			    dma_addr_t dma_addr,
-			    size_t size, enum dma_data_direction dir)
+static void _free_mapped(struct efa_dev *dev, void *cpu_addr, dma_addr_t dma_addr,
+			 size_t size, enum dma_data_direction dir)
 {
 	dma_unmap_single(&dev->pdev->dev, dma_addr, size, dir);
 	free_pages_exact(cpu_addr, size);
@@ -334,7 +333,7 @@ int efa_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
 	return 0;
 }
 
-static int efa_pd_dealloc(struct efa_dev *dev, u16 pdn)
+static int _dealloc_pd(struct efa_dev *dev, u16 pdn)
 {
 	struct efa_com_dealloc_pd_params params = {
 		.pdn = pdn,
@@ -381,7 +380,7 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	return 0;
 
 err_dealloc_pd:
-	efa_pd_dealloc(dev, result.pdn);
+	_dealloc_pd(dev, result.pdn);
 err_out:
 	atomic64_inc(&dev->stats.alloc_pd_err);
 	return err;
@@ -393,18 +392,18 @@ int efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct efa_pd *pd = to_epd(ibpd);
 
 	ibdev_dbg(&dev->ibdev, "Dealloc pd[%d]\n", pd->pdn);
-	efa_pd_dealloc(dev, pd->pdn);
+	_dealloc_pd(dev, pd->pdn);
 	return 0;
 }
 
-static int efa_destroy_qp_handle(struct efa_dev *dev, u32 qp_handle)
+static int _destroy_qp_handle(struct efa_dev *dev, u32 qp_handle)
 {
 	struct efa_com_destroy_qp_params params = { .qp_handle = qp_handle };
 
 	return efa_com_destroy_qp(&dev->edev, &params);
 }
 
-static void efa_qp_user_mmap_entries_remove(struct efa_qp *qp)
+static void _qp_user_mmap_entries_remove(struct efa_qp *qp)
 {
 	rdma_user_mmap_entry_remove(qp->rq_mmap_entry);
 	rdma_user_mmap_entry_remove(qp->rq_db_mmap_entry);
@@ -420,28 +419,26 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	ibdev_dbg(&dev->ibdev, "Destroy qp[%u]\n", ibqp->qp_num);
 
-	err = efa_destroy_qp_handle(dev, qp->qp_handle);
+	err = _destroy_qp_handle(dev, qp->qp_handle);
 	if (err)
 		return err;
 
-	efa_qp_user_mmap_entries_remove(qp);
+	_qp_user_mmap_entries_remove(qp);
 
 	if (qp->rq_cpu_addr) {
 		ibdev_dbg(&dev->ibdev,
 			  "qp->cpu_addr[0x%p] freed: size[%lu], dma[%pad]\n",
 			  qp->rq_cpu_addr, qp->rq_size,
 			  &qp->rq_dma_addr);
-		efa_free_mapped(dev, qp->rq_cpu_addr, qp->rq_dma_addr,
-				qp->rq_size, DMA_TO_DEVICE);
+		_free_mapped(dev, qp->rq_cpu_addr, qp->rq_dma_addr, qp->rq_size, DMA_TO_DEVICE);
 	}
 
 	return 0;
 }
 
 static struct rdma_user_mmap_entry*
-efa_user_mmap_entry_insert(struct ib_ucontext *ucontext,
-			   u64 address, size_t length,
-			   u8 mmap_flag, u64 *offset)
+_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address, size_t length,
+			u8 mmap_flag, u64 *offset)
 {
 	struct efa_user_mmap_entry *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	int err;
@@ -463,21 +460,19 @@ efa_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 	return &entry->rdma_entry;
 }
 
-static int qp_mmap_entries_setup(struct efa_qp *qp,
-				 struct efa_dev *dev,
-				 struct efa_ucontext *ucontext,
-				 struct efa_com_create_qp_params *params,
-				 struct efa_ibv_create_qp_resp *resp)
+static int _qp_mmap_entries_setup(struct efa_qp *qp,
+				  struct efa_dev *dev,
+				  struct efa_ucontext *ucontext,
+				  struct efa_com_create_qp_params *params,
+				  struct efa_ibv_create_qp_resp *resp)
 {
 	size_t length;
 	u64 address;
 
 	address = dev->db_bar_addr + resp->sq_db_offset;
-	qp->sq_db_mmap_entry =
-		efa_user_mmap_entry_insert(&ucontext->ibucontext,
-					   address,
-					   PAGE_SIZE, EFA_MMAP_IO_NC,
-					   &resp->sq_db_mmap_key);
+	qp->sq_db_mmap_entry = _user_mmap_entry_insert(&ucontext->ibucontext, address,
+						       PAGE_SIZE, EFA_MMAP_IO_NC,
+						       &resp->sq_db_mmap_key);
 	if (!qp->sq_db_mmap_entry)
 		return -ENOMEM;
 
@@ -487,11 +482,9 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
 	length = PAGE_ALIGN(params->sq_ring_size_in_bytes +
 			    offset_in_page(resp->llq_desc_offset));
 
-	qp->llq_desc_mmap_entry =
-		efa_user_mmap_entry_insert(&ucontext->ibucontext,
-					   address, length,
-					   EFA_MMAP_IO_WC,
-					   &resp->llq_desc_mmap_key);
+	qp->llq_desc_mmap_entry = _user_mmap_entry_insert(&ucontext->ibucontext, address,
+							  length, EFA_MMAP_IO_WC,
+							  &resp->llq_desc_mmap_key);
 	if (!qp->llq_desc_mmap_entry)
 		goto err_remove_mmap;
 
@@ -500,22 +493,18 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
 	if (qp->rq_size) {
 		address = dev->db_bar_addr + resp->rq_db_offset;
 
-		qp->rq_db_mmap_entry =
-			efa_user_mmap_entry_insert(&ucontext->ibucontext,
-						   address, PAGE_SIZE,
-						   EFA_MMAP_IO_NC,
-						   &resp->rq_db_mmap_key);
+		qp->rq_db_mmap_entry = _user_mmap_entry_insert(&ucontext->ibucontext, address,
+							       PAGE_SIZE, EFA_MMAP_IO_NC,
+							       &resp->rq_db_mmap_key);
 		if (!qp->rq_db_mmap_entry)
 			goto err_remove_mmap;
 
 		resp->rq_db_offset &= ~PAGE_MASK;
 
 		address = virt_to_phys(qp->rq_cpu_addr);
-		qp->rq_mmap_entry =
-			efa_user_mmap_entry_insert(&ucontext->ibucontext,
-						   address, qp->rq_size,
-						   EFA_MMAP_DMA_PAGE,
-						   &resp->rq_mmap_key);
+		qp->rq_mmap_entry = _user_mmap_entry_insert(&ucontext->ibucontext, address,
+							    qp->rq_size, EFA_MMAP_DMA_PAGE,
+							    &resp->rq_mmap_key);
 		if (!qp->rq_mmap_entry)
 			goto err_remove_mmap;
 
@@ -525,13 +514,12 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
 	return 0;
 
 err_remove_mmap:
-	efa_qp_user_mmap_entries_remove(qp);
+	_qp_user_mmap_entries_remove(qp);
 
 	return -ENOMEM;
 }
 
-static int efa_qp_validate_cap(struct efa_dev *dev,
-			       struct ib_qp_init_attr *init_attr)
+static int _qp_validate_cap(struct efa_dev *dev, struct ib_qp_init_attr *init_attr)
 {
 	if (init_attr->cap.max_send_wr > dev->dev_attr.max_sq_depth) {
 		ibdev_dbg(&dev->ibdev,
@@ -570,8 +558,7 @@ static int efa_qp_validate_cap(struct efa_dev *dev,
 	return 0;
 }
 
-static int efa_qp_validate_attr(struct efa_dev *dev,
-				struct ib_qp_init_attr *init_attr)
+static int _qp_validate_attr(struct efa_dev *dev, struct ib_qp_init_attr *init_attr)
 {
 	if (init_attr->qp_type != IB_QPT_DRIVER &&
 	    init_attr->qp_type != IB_QPT_UD) {
@@ -609,11 +596,11 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	ucontext = rdma_udata_to_drv_context(udata, struct efa_ucontext,
 					     ibucontext);
 
-	err = efa_qp_validate_cap(dev, init_attr);
+	err = _qp_validate_cap(dev, init_attr);
 	if (err)
 		goto err_out;
 
-	err = efa_qp_validate_attr(dev, init_attr);
+	err = _qp_validate_attr(dev, init_attr);
 	if (err)
 		goto err_out;
 
@@ -684,8 +671,8 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	create_qp_params.rq_ring_size_in_bytes = cmd.rq_ring_size;
 	qp->rq_size = PAGE_ALIGN(create_qp_params.rq_ring_size_in_bytes);
 	if (qp->rq_size) {
-		qp->rq_cpu_addr = efa_zalloc_mapped(dev, &qp->rq_dma_addr,
-						    qp->rq_size, DMA_TO_DEVICE);
+		qp->rq_cpu_addr = _zalloc_mapped(dev, &qp->rq_dma_addr,
+						 qp->rq_size, DMA_TO_DEVICE);
 		if (!qp->rq_cpu_addr) {
 			err = -ENOMEM;
 			goto err_out;
@@ -711,8 +698,7 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	resp.send_sub_cq_idx = create_qp_resp.send_sub_cq_idx;
 	resp.recv_sub_cq_idx = create_qp_resp.recv_sub_cq_idx;
 
-	err = qp_mmap_entries_setup(qp, dev, ucontext, &create_qp_params,
-				    &resp);
+	err = _qp_mmap_entries_setup(qp, dev, ucontext, &create_qp_params, &resp);
 	if (err)
 		goto err_destroy_qp;
 
@@ -740,13 +726,12 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	return 0;
 
 err_remove_mmap_entries:
-	efa_qp_user_mmap_entries_remove(qp);
+	_qp_user_mmap_entries_remove(qp);
 err_destroy_qp:
-	efa_destroy_qp_handle(dev, create_qp_resp.qp_handle);
+	_destroy_qp_handle(dev, create_qp_resp.qp_handle);
 err_free_mapped:
 	if (qp->rq_size)
-		efa_free_mapped(dev, qp->rq_cpu_addr, qp->rq_dma_addr,
-				qp->rq_size, DMA_TO_DEVICE);
+		_free_mapped(dev, qp->rq_cpu_addr, qp->rq_dma_addr, qp->rq_size, DMA_TO_DEVICE);
 err_out:
 	atomic64_inc(&dev->stats.create_qp_err);
 	return err;
@@ -835,9 +820,8 @@ static const struct {
 	}
 };
 
-static bool efa_modify_srd_qp_is_ok(enum ib_qp_state cur_state,
-				    enum ib_qp_state next_state,
-				    enum ib_qp_attr_mask mask)
+static bool _modify_srd_qp_is_ok(enum ib_qp_state cur_state, enum ib_qp_state next_state,
+				 enum ib_qp_attr_mask mask)
 {
 	enum ib_qp_attr_mask req_param, opt_param;
 
@@ -861,10 +845,10 @@ static bool efa_modify_srd_qp_is_ok(enum ib_qp_state cur_state,
 	return true;
 }
 
-static int efa_modify_qp_validate(struct efa_dev *dev, struct efa_qp *qp,
-				  struct ib_qp_attr *qp_attr, int qp_attr_mask,
-				  enum ib_qp_state cur_state,
-				  enum ib_qp_state new_state)
+static int _modify_qp_validate(struct efa_dev *dev, struct efa_qp *qp,
+			       struct ib_qp_attr *qp_attr, int qp_attr_mask,
+			       enum ib_qp_state cur_state,
+			       enum ib_qp_state new_state)
 {
 	int err;
 
@@ -881,8 +865,7 @@ static int efa_modify_qp_validate(struct efa_dev *dev, struct efa_qp *qp,
 	}
 
 	if (qp->ibqp.qp_type == IB_QPT_DRIVER)
-		err = !efa_modify_srd_qp_is_ok(cur_state, new_state,
-					       qp_attr_mask);
+		err = !_modify_srd_qp_is_ok(cur_state, new_state, qp_attr_mask);
 	else
 		err = !ib_modify_qp_is_ok(cur_state, new_state, IB_QPT_UD,
 					  qp_attr_mask);
@@ -929,8 +912,7 @@ int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 						     qp->state;
 	new_state = qp_attr_mask & IB_QP_STATE ? qp_attr->qp_state : cur_state;
 
-	err = efa_modify_qp_validate(dev, qp, qp_attr, qp_attr_mask, cur_state,
-				     new_state);
+	err = _modify_qp_validate(dev, qp, qp_attr, qp_attr_mask, cur_state, new_state);
 	if (err)
 		return err;
 
@@ -976,14 +958,14 @@ int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	return 0;
 }
 
-static int efa_destroy_cq_idx(struct efa_dev *dev, int cq_idx)
+static int _destroy_cq_idx(struct efa_dev *dev, int cq_idx)
 {
 	struct efa_com_destroy_cq_params params = { .cq_idx = cq_idx };
 
 	return efa_com_destroy_cq(&dev->edev, &params);
 }
 
-static void efa_cq_user_mmap_entries_remove(struct efa_cq *cq)
+static void _cq_user_mmap_entries_remove(struct efa_cq *cq)
 {
 	rdma_user_mmap_entry_remove(cq->db_mmap_entry);
 	rdma_user_mmap_entry_remove(cq->mmap_entry);
@@ -998,40 +980,38 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		  "Destroy cq[%d] virt[0x%p] freed: size[%lu], dma[%pad]\n",
 		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
 
-	efa_destroy_cq_idx(dev, cq->cq_idx);
-	efa_cq_user_mmap_entries_remove(cq);
+	_destroy_cq_idx(dev, cq->cq_idx);
+	_cq_user_mmap_entries_remove(cq);
 	if (cq->eq) {
 		xa_erase(&dev->cqs_xa, cq->cq_idx);
 		synchronize_irq(cq->eq->irq.irqn);
 	}
-	efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
-			DMA_FROM_DEVICE);
+	_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size, DMA_FROM_DEVICE);
 	return 0;
 }
 
-static struct efa_eq *efa_vec2eq(struct efa_dev *dev, int vec)
+static struct efa_eq *_vec2eq(struct efa_dev *dev, int vec)
 {
 	return vec < dev->neqs ? &dev->eqs[vec] : NULL;
 }
 
-static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
-				 struct efa_ibv_create_cq_resp *resp,
-				 bool db_valid)
+static int _cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
+				  struct efa_ibv_create_cq_resp *resp,
+				  bool db_valid)
 {
 	resp->q_mmap_size = cq->size;
-	cq->mmap_entry = efa_user_mmap_entry_insert(&cq->ucontext->ibucontext,
-						    virt_to_phys(cq->cpu_addr),
-						    cq->size, EFA_MMAP_DMA_PAGE,
-						    &resp->q_mmap_key);
+	cq->mmap_entry = _user_mmap_entry_insert(&cq->ucontext->ibucontext,
+						 virt_to_phys(cq->cpu_addr),
+						 cq->size, EFA_MMAP_DMA_PAGE,
+						 &resp->q_mmap_key);
 	if (!cq->mmap_entry)
 		return -ENOMEM;
 
 	if (db_valid) {
-		cq->db_mmap_entry =
-			efa_user_mmap_entry_insert(&cq->ucontext->ibucontext,
-						   dev->db_bar_addr + resp->db_off,
-						   PAGE_SIZE, EFA_MMAP_IO_NC,
-						   &resp->db_mmap_key);
+		cq->db_mmap_entry = _user_mmap_entry_insert(&cq->ucontext->ibucontext,
+							    dev->db_bar_addr + resp->db_off,
+							    PAGE_SIZE, EFA_MMAP_IO_NC,
+							    &resp->db_mmap_key);
 		if (!cq->db_mmap_entry) {
 			rdma_user_mmap_entry_remove(cq->mmap_entry);
 			return -ENOMEM;
@@ -1123,8 +1103,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	cq->ucontext = ucontext;
 	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
-	cq->cpu_addr = efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
-					 DMA_FROM_DEVICE);
+	cq->cpu_addr = _zalloc_mapped(dev, &cq->dma_addr, cq->size, DMA_FROM_DEVICE);
 	if (!cq->cpu_addr) {
 		err = -ENOMEM;
 		goto err_out;
@@ -1137,7 +1116,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	params.num_sub_cqs = cmd.num_sub_cqs;
 	params.set_src_addr = set_src_addr;
 	if (cmd.flags & EFA_CREATE_CQ_WITH_COMPLETION_CHANNEL) {
-		cq->eq = efa_vec2eq(dev, attr->comp_vector);
+		cq->eq = _vec2eq(dev, attr->comp_vector);
 		if (!cq->eq) {
 			ibdev_dbg(ibdev, "Invalid EQ requested[%u]\n", attr->comp_vector);
 			err = -EINVAL;
@@ -1157,7 +1136,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->ibcq.cqe = result.actual_depth;
 	WARN_ON_ONCE(entries != result.actual_depth);
 
-	err = cq_mmap_entries_setup(dev, cq, &resp, result.db_valid);
+	err = _cq_mmap_entries_setup(dev, cq, &resp, result.db_valid);
 	if (err) {
 		ibdev_dbg(ibdev, "Could not setup cq[%u] mmap entries\n",
 			  cq->cq_idx);
@@ -1192,12 +1171,11 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (cq->eq)
 		xa_erase(&dev->cqs_xa, cq->cq_idx);
 err_remove_mmap:
-	efa_cq_user_mmap_entries_remove(cq);
+	_cq_user_mmap_entries_remove(cq);
 err_destroy_cq:
-	efa_destroy_cq_idx(dev, cq->cq_idx);
+	_destroy_cq_idx(dev, cq->cq_idx);
 err_free_mapped:
-	efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
-			DMA_FROM_DEVICE);
+	_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size, DMA_FROM_DEVICE);
 
 err_out:
 	atomic64_inc(&dev->stats.create_cq_err);
@@ -1223,7 +1201,7 @@ static int umem_to_page_list(struct efa_dev *dev,
 	return 0;
 }
 
-static struct scatterlist *efa_vmalloc_buf_to_sg(u64 *buf, int page_cnt)
+static struct scatterlist *_vmalloc_buf_to_sg(u64 *buf, int page_cnt)
 {
 	struct scatterlist *sglist;
 	struct page *pg;
@@ -1251,7 +1229,7 @@ static struct scatterlist *efa_vmalloc_buf_to_sg(u64 *buf, int page_cnt)
  * create a chunk list of physical pages dma addresses from the supplied
  * scatter gather list
  */
-static int pbl_chunk_list_create(struct efa_dev *dev, struct pbl_context *pbl)
+static int _pbl_chunk_list_create(struct efa_dev *dev, struct pbl_context *pbl)
 {
 	struct pbl_chunk_list *chunk_list = &pbl->phys.indirect.chunk_list;
 	int page_cnt = pbl->phys.indirect.pbl_buf_size_in_pages;
@@ -1351,7 +1329,7 @@ static int pbl_chunk_list_create(struct efa_dev *dev, struct pbl_context *pbl)
 	return -ENOMEM;
 }
 
-static void pbl_chunk_list_destroy(struct efa_dev *dev, struct pbl_context *pbl)
+static void _pbl_chunk_list_destroy(struct efa_dev *dev, struct pbl_context *pbl)
 {
 	struct pbl_chunk_list *chunk_list = &pbl->phys.indirect.chunk_list;
 	int i;
@@ -1366,8 +1344,7 @@ static void pbl_chunk_list_destroy(struct efa_dev *dev, struct pbl_context *pbl)
 }
 
 /* initialize pbl continuous mode: map pbl buffer to a dma address. */
-static int pbl_continuous_initialize(struct efa_dev *dev,
-				     struct pbl_context *pbl)
+static int _pbl_continuous_initialize(struct efa_dev *dev, struct pbl_context *pbl)
 {
 	dma_addr_t dma_addr;
 
@@ -1391,14 +1368,14 @@ static int pbl_continuous_initialize(struct efa_dev *dev,
  * create a chunk list out of the dma addresses of the physical pages of
  * pbl buffer.
  */
-static int pbl_indirect_initialize(struct efa_dev *dev, struct pbl_context *pbl)
+static int _pbl_indirect_initialize(struct efa_dev *dev, struct pbl_context *pbl)
 {
 	u32 size_in_pages = DIV_ROUND_UP(pbl->pbl_buf_size_in_bytes, EFA_CHUNK_PAYLOAD_SIZE);
 	struct scatterlist *sgl;
 	int sg_dma_cnt, err;
 
 	BUILD_BUG_ON(EFA_CHUNK_PAYLOAD_SIZE > PAGE_SIZE);
-	sgl = efa_vmalloc_buf_to_sg(pbl->pbl_buf, size_in_pages);
+	sgl = _vmalloc_buf_to_sg(pbl->pbl_buf, size_in_pages);
 	if (!sgl)
 		return -ENOMEM;
 
@@ -1411,7 +1388,7 @@ static int pbl_indirect_initialize(struct efa_dev *dev, struct pbl_context *pbl)
 	pbl->phys.indirect.pbl_buf_size_in_pages = size_in_pages;
 	pbl->phys.indirect.sgl = sgl;
 	pbl->phys.indirect.sg_dma_cnt = sg_dma_cnt;
-	err = pbl_chunk_list_create(dev, pbl);
+	err = _pbl_chunk_list_create(dev, pbl);
 	if (err) {
 		ibdev_dbg(&dev->ibdev,
 			  "chunk_list creation failed[%d]\n", err);
@@ -1432,20 +1409,20 @@ static int pbl_indirect_initialize(struct efa_dev *dev, struct pbl_context *pbl)
 	return err;
 }
 
-static void pbl_indirect_terminate(struct efa_dev *dev, struct pbl_context *pbl)
+static void _pbl_indirect_terminate(struct efa_dev *dev, struct pbl_context *pbl)
 {
-	pbl_chunk_list_destroy(dev, pbl);
+	_pbl_chunk_list_destroy(dev, pbl);
 	dma_unmap_sg(&dev->pdev->dev, pbl->phys.indirect.sgl,
 		     pbl->phys.indirect.pbl_buf_size_in_pages, DMA_TO_DEVICE);
 	kfree(pbl->phys.indirect.sgl);
 }
 
 /* create a page buffer list from a mapped user memory region */
-static int pbl_create(struct efa_dev *dev,
-		      struct pbl_context *pbl,
-		      struct ib_umem *umem,
-		      int hp_cnt,
-		      u8 hp_shift)
+static int _pbl_create(struct efa_dev *dev,
+		       struct pbl_context *pbl,
+		       struct ib_umem *umem,
+		       int hp_cnt,
+		       u8 hp_shift)
 {
 	int err;
 
@@ -1461,7 +1438,7 @@ static int pbl_create(struct efa_dev *dev,
 		if (err)
 			goto err_free;
 
-		err = pbl_indirect_initialize(dev, pbl);
+		err = _pbl_indirect_initialize(dev, pbl);
 		if (err)
 			goto err_free;
 	} else {
@@ -1471,7 +1448,7 @@ static int pbl_create(struct efa_dev *dev,
 		if (err)
 			goto err_free;
 
-		err = pbl_continuous_initialize(dev, pbl);
+		err = _pbl_continuous_initialize(dev, pbl);
 		if (err)
 			goto err_free;
 	}
@@ -1487,19 +1464,19 @@ static int pbl_create(struct efa_dev *dev,
 	return err;
 }
 
-static void pbl_destroy(struct efa_dev *dev, struct pbl_context *pbl)
+static void _pbl_destroy(struct efa_dev *dev, struct pbl_context *pbl)
 {
 	if (pbl->physically_continuous)
 		dma_unmap_single(&dev->pdev->dev, pbl->phys.continuous.dma_addr,
 				 pbl->pbl_buf_size_in_bytes, DMA_TO_DEVICE);
 	else
-		pbl_indirect_terminate(dev, pbl);
+		_pbl_indirect_terminate(dev, pbl);
 
 	kvfree(pbl->pbl_buf);
 }
 
-static int efa_create_inline_pbl(struct efa_dev *dev, struct efa_mr *mr,
-				 struct efa_com_reg_mr_params *params)
+static int _create_inline_pbl(struct efa_dev *dev, struct efa_mr *mr,
+			      struct efa_com_reg_mr_params *params)
 {
 	int err;
 
@@ -1515,15 +1492,12 @@ static int efa_create_inline_pbl(struct efa_dev *dev, struct efa_mr *mr,
 	return 0;
 }
 
-static int efa_create_pbl(struct efa_dev *dev,
-			  struct pbl_context *pbl,
-			  struct efa_mr *mr,
-			  struct efa_com_reg_mr_params *params)
+static int _create_pbl(struct efa_dev *dev, struct pbl_context *pbl, struct efa_mr *mr,
+		       struct efa_com_reg_mr_params *params)
 {
 	int err;
 
-	err = pbl_create(dev, pbl, mr->umem, params->page_num,
-			 params->page_shift);
+	err = _pbl_create(dev, pbl, mr->umem, params->page_num, params->page_shift);
 	if (err) {
 		ibdev_dbg(&dev->ibdev, "Failed to create pbl[%d]\n", err);
 		return err;
@@ -1549,8 +1523,7 @@ static int efa_create_pbl(struct efa_dev *dev,
 	return 0;
 }
 
-static struct efa_mr *efa_alloc_mr(struct ib_pd *ibpd, int access_flags,
-				   struct ib_udata *udata)
+static struct efa_mr *_alloc_mr(struct ib_pd *ibpd, int access_flags, struct ib_udata *udata)
 {
 	struct efa_dev *dev = to_edev(ibpd->device);
 	int supp_access_flags;
@@ -1583,8 +1556,8 @@ static struct efa_mr *efa_alloc_mr(struct ib_pd *ibpd, int access_flags,
 	return mr;
 }
 
-static int efa_register_mr(struct ib_pd *ibpd, struct efa_mr *mr, u64 start,
-			   u64 length, u64 virt_addr, int access_flags)
+static int _register_mr(struct ib_pd *ibpd, struct efa_mr *mr, u64 start,
+			u64 length, u64 virt_addr, int access_flags)
 {
 	struct efa_dev *dev = to_edev(ibpd->device);
 	struct efa_com_reg_mr_params params = {};
@@ -1617,7 +1590,7 @@ static int efa_register_mr(struct ib_pd *ibpd, struct efa_mr *mr, u64 start,
 
 	inline_size = ARRAY_SIZE(params.pbl.inline_pbl_array);
 	if (params.page_num <= inline_size) {
-		err = efa_create_inline_pbl(dev, mr, &params);
+		err = _create_inline_pbl(dev, mr, &params);
 		if (err)
 			return err;
 
@@ -1625,12 +1598,12 @@ static int efa_register_mr(struct ib_pd *ibpd, struct efa_mr *mr, u64 start,
 		if (err)
 			return err;
 	} else {
-		err = efa_create_pbl(dev, &pbl, mr, &params);
+		err = _create_pbl(dev, &pbl, mr, &params);
 		if (err)
 			return err;
 
 		err = efa_com_register_mr(&dev->edev, &params, &result);
-		pbl_destroy(dev, &pbl);
+		_pbl_destroy(dev, &pbl);
 
 		if (err)
 			return err;
@@ -1660,7 +1633,7 @@ struct ib_mr *efa_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start,
 	struct efa_mr *mr;
 	int err;
 
-	mr = efa_alloc_mr(ibpd, access_flags, udata);
+	mr = _alloc_mr(ibpd, access_flags, udata);
 	if (IS_ERR(mr)) {
 		err = PTR_ERR(mr);
 		goto err_out;
@@ -1675,7 +1648,7 @@ struct ib_mr *efa_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start,
 	}
 
 	mr->umem = &umem_dmabuf->umem;
-	err = efa_register_mr(ibpd, mr, start, length, virt_addr, access_flags);
+	err = _register_mr(ibpd, mr, start, length, virt_addr, access_flags);
 	if (err)
 		goto err_release;
 
@@ -1690,15 +1663,15 @@ struct ib_mr *efa_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start,
 	return ERR_PTR(err);
 }
 
-struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
-			 u64 virt_addr, int access_flags,
-			 struct ib_udata *udata)
+struct ib_mr *efa_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
+			      u64 virt_addr, int access_flags,
+			      struct ib_udata *udata)
 {
 	struct efa_dev *dev = to_edev(ibpd->device);
 	struct efa_mr *mr;
 	int err;
 
-	mr = efa_alloc_mr(ibpd, access_flags, udata);
+	mr = _alloc_mr(ibpd, access_flags, udata);
 	if (IS_ERR(mr)) {
 		err = PTR_ERR(mr);
 		goto err_out;
@@ -1712,7 +1685,7 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		goto err_free;
 	}
 
-	err = efa_register_mr(ibpd, mr, start, length, virt_addr, access_flags);
+	err = _register_mr(ibpd, mr, start, length, virt_addr, access_flags);
 	if (err)
 		goto err_release;
 
@@ -1798,7 +1771,7 @@ int efa_get_port_immutable(struct ib_device *ibdev, u32 port_num,
 	return 0;
 }
 
-static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
+static int _dealloc_uar(struct efa_dev *dev, u16 uarn)
 {
 	struct efa_com_dealloc_uar_params params = {
 		.uarn = uarn,
@@ -1811,8 +1784,8 @@ static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
 	(_attr_str = (!(_dev)->dev_attr._attr || ((_comp_mask) & (_mask))) ? \
 		     NULL : #_attr)
 
-static int efa_user_comp_handshake(const struct ib_ucontext *ibucontext,
-				   const struct efa_ibv_alloc_ucontext_cmd *cmd)
+static int _user_comp_handshake(const struct ib_ucontext *ibucontext,
+				const struct efa_ibv_alloc_ucontext_cmd *cmd)
 {
 	struct efa_dev *dev = to_edev(ibucontext->device);
 	char *attr_str;
@@ -1856,7 +1829,7 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 		goto err_out;
 	}
 
-	err = efa_user_comp_handshake(ibucontext, &cmd);
+	err = _user_comp_handshake(ibucontext, &cmd);
 	if (err)
 		goto err_out;
 
@@ -1882,7 +1855,7 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 	return 0;
 
 err_dealloc_uar:
-	efa_dealloc_uar(dev, result.uarn);
+	_dealloc_uar(dev, result.uarn);
 err_out:
 	atomic64_inc(&dev->stats.alloc_ucontext_err);
 	return err;
@@ -1893,18 +1866,18 @@ void efa_dealloc_ucontext(struct ib_ucontext *ibucontext)
 	struct efa_ucontext *ucontext = to_eucontext(ibucontext);
 	struct efa_dev *dev = to_edev(ibucontext->device);
 
-	efa_dealloc_uar(dev, ucontext->uarn);
+	_dealloc_uar(dev, ucontext->uarn);
 }
 
 void efa_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
 {
-	struct efa_user_mmap_entry *entry = to_emmap(rdma_entry);
+	struct efa_user_mmap_entry *entry = _to_emmap(rdma_entry);
 
 	kfree(entry);
 }
 
-static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
-		      struct vm_area_struct *vma)
+static int _efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
+		     struct vm_area_struct *vma)
 {
 	struct rdma_user_mmap_entry *rdma_entry;
 	struct efa_user_mmap_entry *entry;
@@ -1920,7 +1893,7 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
 		atomic64_inc(&dev->stats.mmap_err);
 		return -EINVAL;
 	}
-	entry = to_emmap(rdma_entry);
+	entry = _to_emmap(rdma_entry);
 
 	ibdev_dbg(&dev->ibdev,
 		  "Mapping address[%#llx], length[%#zx], mmap_flag[%d]\n",
@@ -1977,10 +1950,10 @@ int efa_mmap(struct ib_ucontext *ibucontext,
 		  "start %#lx, end %#lx, length = %#zx, pgoff = %#lx\n",
 		  vma->vm_start, vma->vm_end, length, vma->vm_pgoff);
 
-	return __efa_mmap(dev, ucontext, vma);
+	return _efa_mmap(dev, ucontext, vma);
 }
 
-static int efa_ah_destroy(struct efa_dev *dev, struct efa_ah *ah)
+static int _destroy_ah(struct efa_dev *dev, struct efa_ah *ah)
 {
 	struct efa_com_destroy_ah_params params = {
 		.ah = ah->ah,
@@ -2042,7 +2015,7 @@ int efa_create_ah(struct ib_ah *ibah,
 	return 0;
 
 err_destroy_ah:
-	efa_ah_destroy(dev, ah);
+	_destroy_ah(dev, ah);
 err_out:
 	atomic64_inc(&dev->stats.create_ah_err);
 	return err;
@@ -2061,7 +2034,7 @@ int efa_destroy_ah(struct ib_ah *ibah, u32 flags)
 		return -EOPNOTSUPP;
 	}
 
-	efa_ah_destroy(dev, ah);
+	_destroy_ah(dev, ah);
 	return 0;
 }
 
@@ -2080,8 +2053,7 @@ struct rdma_hw_stats *efa_alloc_hw_device_stats(struct ib_device *ibdev)
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
-static int efa_fill_device_stats(struct efa_dev *dev,
-				 struct rdma_hw_stats *stats)
+static int _fill_device_stats(struct efa_dev *dev, struct rdma_hw_stats *stats)
 {
 	struct efa_com_stats_admin *as = &dev->edev.aq.stats;
 	struct efa_stats *s = &dev->stats;
@@ -2104,8 +2076,7 @@ static int efa_fill_device_stats(struct efa_dev *dev,
 	return ARRAY_SIZE(efa_device_stats_descs);
 }
 
-static int efa_fill_port_stats(struct efa_dev *dev, struct rdma_hw_stats *stats,
-			       u32 port_num)
+static int _fill_port_stats(struct efa_dev *dev, struct rdma_hw_stats *stats, u32 port_num)
 {
 	struct efa_com_get_stats_params params = {};
 	union efa_com_get_stats_result result;
@@ -2171,9 +2142,9 @@ int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 		     u32 port_num, int index)
 {
 	if (port_num)
-		return efa_fill_port_stats(to_edev(ibdev), stats, port_num);
+		return _fill_port_stats(to_edev(ibdev), stats, port_num);
 	else
-		return efa_fill_device_stats(to_edev(ibdev), stats);
+		return _fill_device_stats(to_edev(ibdev), stats);
 }
 
 enum rdma_link_layer efa_port_link_layer(struct ib_device *ibdev,
-- 
2.40.1


