Return-Path: <linux-rdma+bounces-2312-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3608BDF03
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 11:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB701C20D18
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 09:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2B914F13A;
	Tue,  7 May 2024 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MLMJRB2o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E03014D6EB;
	Tue,  7 May 2024 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075610; cv=none; b=OTdNh7UWXPpSIUdyJ87lW3b5NclX6LRXsXUryZgvjdVOP5pyPejugYiF2uLIlslRbzfdjZaRk8iAXqFW3xxEnGG6oEmiHYCBXZN4XC714lSHY8SW+PTuxy+ybkTFKBt93HhIWHNr5K06qEtpi6US6tA7OTtUqBGCb3TDtADWMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075610; c=relaxed/simple;
	bh=4qkWqM/PRjPINX7Cp0H2sO1jItmV8+Exr95ZhIACmEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uctFLVQpoSf5yjAH6SE06JJAzFftB6Hc/D9woiRcDQUFfg4wASJ452jNqCWedlft6RQp+hFr8Kgoif4foBtnGzAY5sBt0bo+iBEEL/aOOZ60xFZ654YaMCNMDjoDxOsEp6JNeK585avfAx4RLBgmsZbXpdrn2GAk9zJFjjtZN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MLMJRB2o; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D932420B2C84;
	Tue,  7 May 2024 02:53:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D932420B2C84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715075600;
	bh=HgZFHhJlwM0NqIiFtpKskjvYc629noqEAZv1L4k/RxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLMJRB2oyIHypJ6QEITmvDLsaJtjhg9gQae3pJHANHK1sCHyq6XJEYHQHLdoCy7Z5
	 QfDyaBBpADtOjccaNLaumc8BD0asGe9MWAJJaYgmVf0/544Gvktu0S4UJ/CbBkt6Co
	 SPaccWLz2gVbfFMCZ3TQOj2BI0WtVVVgkN2cX1Ao=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/3] RDMA/mana_ib: Create and destroy RC QP
Date: Tue,  7 May 2024 02:53:13 -0700
Message-Id: <1715075595-24470-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1715075595-24470-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1715075595-24470-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement HW requests to create and destroy an RC QP.
An RC QP may have 5 queues.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    | 59 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 58 ++++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 2a41135..6bd6072 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -888,3 +888,62 @@ int mana_ib_gd_destroy_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 
 	return 0;
 }
+
+int mana_ib_gd_create_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
+			    struct ib_qp_init_attr *attr, u32 doorbell, u64 flags)
+{
+	struct mana_ib_cq *send_cq = container_of(qp->ibqp.send_cq, struct mana_ib_cq, ibcq);
+	struct mana_ib_cq *recv_cq = container_of(qp->ibqp.recv_cq, struct mana_ib_cq, ibcq);
+	struct mana_ib_pd *pd = container_of(qp->ibqp.pd, struct mana_ib_pd, ibpd);
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct mana_rnic_create_qp_resp resp = {};
+	struct mana_rnic_create_qp_req req = {};
+	int err, i;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_RC_QP, sizeof(req), sizeof(resp));
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.adapter = mdev->adapter_handle;
+	req.pd_handle = pd->pd_handle;
+	req.send_cq_handle = send_cq->cq_handle;
+	req.recv_cq_handle = recv_cq->cq_handle;
+	for (i = 0; i < MANA_RC_QUEUE_TYPE_MAX; i++)
+		req.dma_region[i] = qp->rc_qp.queues[i].gdma_region;
+	req.doorbell_page = doorbell;
+	req.max_send_wr = attr->cap.max_send_wr;
+	req.max_recv_wr = attr->cap.max_recv_wr;
+	req.max_send_sge = attr->cap.max_send_sge;
+	req.max_recv_sge = attr->cap.max_recv_sge;
+	req.flags = flags;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to create rc qp err %d", err);
+		return err;
+	}
+	qp->qp_handle = resp.rc_qp_handle;
+	for (i = 0; i < MANA_RC_QUEUE_TYPE_MAX; i++) {
+		qp->rc_qp.queues[i].id = resp.queue_ids[i];
+		/* The GDMA regions are now owned by the RNIC QP handle */
+		qp->rc_qp.queues[i].gdma_region = GDMA_INVALID_DMA_REGION;
+	}
+	return 0;
+}
+
+int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
+{
+	struct mana_rnic_destroy_rc_qp_resp resp = {0};
+	struct mana_rnic_destroy_rc_qp_req req = {0};
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_RC_QP, sizeof(req), sizeof(resp));
+	req.hdr.dev_id = gc->mana_ib.dev_id;
+	req.adapter = mdev->adapter_handle;
+	req.rc_qp_handle = qp->qp_handle;
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err) {
+		ibdev_err(&mdev->ib_dev, "Failed to destroy rc qp err %d", err);
+		return err;
+	}
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 68c3b4f..a3e229c 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -95,11 +95,27 @@ struct mana_ib_cq {
 	mana_handle_t  cq_handle;
 };
 
+enum mana_rc_queue_type {
+	MANA_RC_SEND_QUEUE_REQUESTER = 0,
+	MANA_RC_SEND_QUEUE_RESPONDER,
+	MANA_RC_SEND_QUEUE_FMR,
+	MANA_RC_RECV_QUEUE_REQUESTER,
+	MANA_RC_RECV_QUEUE_RESPONDER,
+	MANA_RC_QUEUE_TYPE_MAX,
+};
+
+struct mana_ib_rc_qp {
+	struct mana_ib_queue queues[MANA_RC_QUEUE_TYPE_MAX];
+};
+
 struct mana_ib_qp {
 	struct ib_qp ibqp;
 
 	mana_handle_t qp_handle;
-	struct mana_ib_queue raw_sq;
+	union {
+		struct mana_ib_queue raw_sq;
+		struct mana_ib_rc_qp rc_qp;
+	};
 
 	/* The port on the IB device, starting with 1 */
 	u32 port;
@@ -122,6 +138,8 @@ enum mana_ib_command_code {
 	MANA_IB_CONFIG_MAC_ADDR	= 0x30005,
 	MANA_IB_CREATE_CQ       = 0x30008,
 	MANA_IB_DESTROY_CQ      = 0x30009,
+	MANA_IB_CREATE_RC_QP    = 0x3000a,
+	MANA_IB_DESTROY_RC_QP   = 0x3000b,
 };
 
 struct mana_ib_query_adapter_caps_req {
@@ -230,6 +248,40 @@ struct mana_rnic_destroy_cq_resp {
 	struct gdma_resp_hdr hdr;
 }; /* HW Data */
 
+struct mana_rnic_create_qp_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+	mana_handle_t pd_handle;
+	mana_handle_t send_cq_handle;
+	mana_handle_t recv_cq_handle;
+	u64 dma_region[MANA_RC_QUEUE_TYPE_MAX];
+	u64 deprecated[2];
+	u64 flags;
+	u32 doorbell_page;
+	u32 max_send_wr;
+	u32 max_recv_wr;
+	u32 max_send_sge;
+	u32 max_recv_sge;
+	u32 reserved;
+}; /* HW Data */
+
+struct mana_rnic_create_qp_resp {
+	struct gdma_resp_hdr hdr;
+	mana_handle_t rc_qp_handle;
+	u32 queue_ids[MANA_RC_QUEUE_TYPE_MAX];
+	u32 reserved;
+}; /* HW Data*/
+
+struct mana_rnic_destroy_rc_qp_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+	mana_handle_t rc_qp_handle;
+}; /* HW Data */
+
+struct mana_rnic_destroy_rc_qp_resp {
+	struct gdma_resp_hdr hdr;
+}; /* HW Data */
+
 static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)
 {
 	return mdev->gdma_dev->gdma_context;
@@ -354,4 +406,8 @@ int mana_ib_gd_config_mac(struct mana_ib_dev *mdev, enum mana_ib_addr_op op, u8
 int mana_ib_gd_create_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq, u32 doorbell);
 
 int mana_ib_gd_destroy_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
+
+int mana_ib_gd_create_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
+			    struct ib_qp_init_attr *attr, u32 doorbell, u64 flags);
+int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp);
 #endif
-- 
2.43.0


