Return-Path: <linux-rdma+bounces-19392-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMPMNsbs4Gk4ngAAu9opvQ
	(envelope-from <linux-rdma+bounces-19392-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 16:05:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7AF40F57D
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 16:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49DB730659E3
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 14:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B61F3DB645;
	Thu, 16 Apr 2026 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y3PENRK2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5883C0625;
	Thu, 16 Apr 2026 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348153; cv=none; b=gzqGl1aTiR1Uyl3v3Z2Ic+bvjmGOiQg6vyJLW+zZzkrBPIggTYjt6V2+3Fx+ddoqYTzJOefWwNoTU6ZPOGxYGarKaWzy1qbkCc6HrbrYpNomYFQJtvLq9rrSNlEcqsg1EmsOgcN+JvijOxsprUw2p992NB8dAf88GyAQjEUExD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348153; c=relaxed/simple;
	bh=SKmtEwmTQ918ue5cQz9r8z+yvol6V9cUHf0AuHbh/eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONxpqWcYV43cJ/XSX45n6oa0tYl3T20RCAumhbGPUqagqrI1luzSR+uhuF8MNd0CchxvRVoAjSCCE8kgdI9Ar8HQvQuWxWt/8m2xok1rIGsh59J0NNBFRSxA9KiNH5PH7KzNW0K1MGOSv7WaVFFEcZyk2luCtPu4maHYRw5StKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y3PENRK2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id CB12220B6F01; Thu, 16 Apr 2026 07:02:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB12220B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776348151;
	bh=lKVXQY/j9yx3ICjyO5aXXEoFL8h3QxrZhLPGks44tX0=;
	h=From:To:Cc:Subject:Date:From;
	b=Y3PENRK22g3iNw89Od/IBmdveOthd3AD/zxqLGAXBC+cKqGY1Vdt9rNvynwrwbfgD
	 4tPQGB9qdu2+K0UJCTyOMpfovwwdA+qJQGuzO0QwiLw+tDmjnLG4Nnq3M89CYE5d9x
	 UfawUX+S5YxqY/Xnl+CTK1wlu8WvisUODMtASz/I=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 1/1] RDMA/mana_ib: UC QP support for UAPI
Date: Thu, 16 Apr 2026 07:02:31 -0700
Message-ID: <20260416140231.825205-1-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19392-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A7AF40F57D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement UC QP creation in the RNIC HW for user API. An UC QP is exposed
as three work queues: send, receive, and memory management. The latter is
used for bind and invalidate WQEs to support memory windows.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
v3: use new udata helpers
v2: removed udata check and removed enum from mana-abi.h
 drivers/infiniband/hw/mana/main.c    | 41 ++++++++++++-
 drivers/infiniband/hw/mana/mana_ib.h | 41 ++++++++++++-
 drivers/infiniband/hw/mana/qp.c      | 89 ++++++++++++++++++++++++++--
 include/uapi/rdma/mana-abi.h         | 11 ++++
 4 files changed, 173 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index ac5e75dd3..42567c30e 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -978,7 +978,46 @@ int mana_ib_gd_create_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
 	return 0;
 }
 
-int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
+int mana_ib_gd_create_uc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
+			    struct ib_qp_init_attr *attr, u32 doorbell, u64 flags)
+{
+	struct mana_ib_cq *send_cq = container_of(qp->ibqp.send_cq, struct mana_ib_cq, ibcq);
+	struct mana_ib_cq *recv_cq = container_of(qp->ibqp.recv_cq, struct mana_ib_cq, ibcq);
+	struct mana_ib_pd *pd = container_of(qp->ibqp.pd, struct mana_ib_pd, ibpd);
+	struct gdma_context *gc = mdev_to_gc(mdev);
+	struct mana_rnic_create_uc_qp_resp resp = {};
+	struct mana_rnic_create_uc_qp_req req = {};
+	int err, i;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_UC_QP, sizeof(req), sizeof(resp));
+	req.hdr.dev_id = mdev->gdma_dev->dev_id;
+	req.adapter = mdev->adapter_handle;
+	req.pd_handle = pd->pd_handle;
+	req.send_cq_handle = send_cq->cq_handle;
+	req.recv_cq_handle = recv_cq->cq_handle;
+	for (i = 0; i < MANA_UC_QUEUE_TYPE_MAX; i++)
+		req.dma_region[i] = qp->uc_qp.queues[i].gdma_region;
+	req.doorbell_page = doorbell;
+	req.max_send_wr = attr->cap.max_send_wr;
+	req.max_recv_wr = attr->cap.max_recv_wr;
+	req.max_send_sge = attr->cap.max_send_sge;
+	req.max_recv_sge = attr->cap.max_recv_sge;
+	req.flags = flags;
+
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err)
+		return err;
+
+	qp->qp_handle = resp.qp_handle;
+	for (i = 0; i < MANA_UC_QUEUE_TYPE_MAX; i++) {
+		qp->uc_qp.queues[i].id = resp.queue_ids[i];
+		/* The GDMA regions are now owned by the RNIC QP handle */
+		qp->uc_qp.queues[i].gdma_region = GDMA_INVALID_DMA_REGION;
+	}
+	return 0;
+}
+
+int mana_ib_gd_destroy_rnic_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
 {
 	struct mana_rnic_destroy_rc_qp_resp resp = {0};
 	struct mana_rnic_destroy_rc_qp_req req = {0};
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index c9c94e86a..0f21a4b25 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -166,6 +166,17 @@ struct mana_ib_rc_qp {
 	struct mana_ib_queue queues[MANA_RC_QUEUE_TYPE_MAX];
 };
 
+enum mana_uc_queue_type {
+	MANA_UC_SEND_QUEUE_REQUESTER = 0,
+	MANA_UC_RECV_QUEUE_RESPONDER,
+	MANA_UC_SEND_QUEUE_MMQ,
+	MANA_UC_QUEUE_TYPE_MAX,
+};
+
+struct mana_ib_uc_qp {
+	struct mana_ib_queue queues[MANA_UC_QUEUE_TYPE_MAX];
+};
+
 enum mana_ud_queue_type {
 	MANA_UD_SEND_QUEUE = 0,
 	MANA_UD_RECV_QUEUE,
@@ -184,6 +195,7 @@ struct mana_ib_qp {
 	union {
 		struct mana_ib_queue raw_sq;
 		struct mana_ib_rc_qp rc_qp;
+		struct mana_ib_uc_qp uc_qp;
 		struct mana_ib_ud_qp ud_qp;
 	};
 
@@ -221,6 +233,7 @@ enum mana_ib_command_code {
 	MANA_IB_CREATE_RC_QP    = 0x3000a,
 	MANA_IB_DESTROY_RC_QP   = 0x3000b,
 	MANA_IB_SET_QP_STATE	= 0x3000d,
+	MANA_IB_CREATE_UC_QP    = 0x30020,
 	MANA_IB_QUERY_VF_COUNTERS = 0x30022,
 	MANA_IB_QUERY_DEVICE_COUNTERS = 0x30023,
 };
@@ -380,6 +393,29 @@ struct mana_rnic_destroy_rc_qp_resp {
 	struct gdma_resp_hdr hdr;
 }; /* HW Data */
 
+struct mana_rnic_create_uc_qp_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t adapter;
+	mana_handle_t pd_handle;
+	mana_handle_t send_cq_handle;
+	mana_handle_t recv_cq_handle;
+	u64 dma_region[MANA_UC_QUEUE_TYPE_MAX];
+	u64 flags;
+	u32 doorbell_page;
+	u32 max_send_wr;
+	u32 max_recv_wr;
+	u32 max_send_sge;
+	u32 max_recv_sge;
+	u32 reserved;
+}; /* HW Data */
+
+struct mana_rnic_create_uc_qp_resp {
+	struct gdma_resp_hdr hdr;
+	mana_handle_t qp_handle;
+	u32 queue_ids[MANA_UC_QUEUE_TYPE_MAX];
+	u32 reserved;
+}; /* HW Data*/
+
 struct mana_rnic_create_udqp_req {
 	struct gdma_req_hdr hdr;
 	mana_handle_t adapter;
@@ -722,8 +758,9 @@ int mana_ib_gd_destroy_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq);
 
 int mana_ib_gd_create_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
 			    struct ib_qp_init_attr *attr, u32 doorbell, u64 flags);
-int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp);
-
+int mana_ib_gd_destroy_rnic_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp);
+int mana_ib_gd_create_uc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
+			    struct ib_qp_init_attr *attr, u32 doorbell, u64 flags);
 int mana_ib_gd_create_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
 			    struct ib_qp_init_attr *attr, u32 doorbell, u32 type);
 int mana_ib_gd_destroy_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 645581359..b13449b48 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -420,13 +420,13 @@ static enum gdma_queue_type mana_ib_queue_type(struct ib_qp_init_attr *attr, u32
 	return type;
 }
 
-static int mana_table_store_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
+static int mana_table_store_rnic_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
 {
 	return xa_insert_irq(&mdev->qp_table_wq, qp->ibqp.qp_num, qp,
 			     GFP_KERNEL);
 }
 
-static void mana_table_remove_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
+static void mana_table_remove_rnic_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
 {
 	xa_erase_irq(&mdev->qp_table_wq, qp->ibqp.qp_num);
 }
@@ -468,7 +468,8 @@ static int mana_table_store_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
 
 	switch (qp->ibqp.qp_type) {
 	case IB_QPT_RC:
-		return mana_table_store_rc_qp(mdev, qp);
+	case IB_QPT_UC:
+		return mana_table_store_rnic_qp(mdev, qp);
 	case IB_QPT_UD:
 	case IB_QPT_GSI:
 		return mana_table_store_ud_qp(mdev, qp);
@@ -485,7 +486,8 @@ static void mana_table_remove_qp(struct mana_ib_dev *mdev,
 {
 	switch (qp->ibqp.qp_type) {
 	case IB_QPT_RC:
-		mana_table_remove_rc_qp(mdev, qp);
+	case IB_QPT_UC:
+		mana_table_remove_rnic_qp(mdev, qp);
 		break;
 	case IB_QPT_UD:
 	case IB_QPT_GSI:
@@ -567,13 +569,67 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	return 0;
 
 destroy_qp:
-	mana_ib_gd_destroy_rc_qp(mdev, qp);
+	mana_ib_gd_destroy_rnic_qp(mdev, qp);
 destroy_queues:
 	while (i-- > 0)
 		mana_ib_destroy_queue(mdev, &qp->rc_qp.queues[i]);
 	return err;
 }
 
+static int mana_ib_create_uc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
+				struct ib_qp_init_attr *attr, struct ib_udata *udata)
+{
+	struct mana_ib_dev *mdev = container_of(ibpd->device, struct mana_ib_dev, ib_dev);
+	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
+	struct mana_ib_create_uc_qp_resp resp = {};
+	struct mana_ib_ucontext *mana_ucontext;
+	struct mana_ib_create_uc_qp ucmd;
+	u64 flags = 0;
+	u32 doorbell;
+	int err, i;
+
+	if (!udata)
+		return -EINVAL;
+
+	mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext, ibucontext);
+	doorbell = mana_ucontext->doorbell;
+	err = ib_copy_validate_udata_in(udata, ucmd, reserved);
+	if (err)
+		return err;
+
+	for (i = 0; i < MANA_UC_QUEUE_TYPE_MAX; ++i) {
+		err = mana_ib_create_queue(mdev, ucmd.queue_buf[i], ucmd.queue_size[i],
+					   &qp->uc_qp.queues[i]);
+		if (err)
+			goto destroy_queues;
+	}
+
+	err = mana_ib_gd_create_uc_qp(mdev, qp, attr, doorbell, flags);
+	if (err)
+		goto destroy_queues;
+
+	qp->ibqp.qp_num = qp->uc_qp.queues[MANA_UC_RECV_QUEUE_RESPONDER].id;
+	qp->port = attr->port_num;
+
+	for (i = 0; i < MANA_UC_QUEUE_TYPE_MAX; ++i)
+		resp.queue_id[i] = qp->uc_qp.queues[i].id;
+
+	err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+	if (err)
+		goto destroy_qp;
+
+	err = mana_table_store_qp(mdev, qp);
+	if (err)
+		goto destroy_qp;
+	return 0;
+destroy_qp:
+	mana_ib_gd_destroy_rnic_qp(mdev, qp);
+destroy_queues:
+	while (i-- > 0)
+		mana_ib_destroy_queue(mdev, &qp->uc_qp.queues[i]);
+	return err;
+}
+
 static void mana_add_qp_to_cqs(struct mana_ib_qp *qp)
 {
 	struct mana_ib_cq *send_cq = container_of(qp->ibqp.send_cq, struct mana_ib_cq, ibcq);
@@ -685,6 +741,8 @@ int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 		return mana_ib_create_qp_raw(ibqp, ibqp->pd, attr, udata);
 	case IB_QPT_RC:
 		return mana_ib_create_rc_qp(ibqp, ibqp->pd, attr, udata);
+	case IB_QPT_UC:
+		return mana_ib_create_uc_qp(ibqp, ibqp->pd, attr, udata);
 	case IB_QPT_UD:
 	case IB_QPT_GSI:
 		return mana_ib_create_ud_qp(ibqp, ibqp->pd, attr, udata);
@@ -766,6 +824,7 @@ int mana_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 {
 	switch (ibqp->qp_type) {
 	case IB_QPT_RC:
+	case IB_QPT_UC:
 	case IB_QPT_UD:
 	case IB_QPT_GSI:
 		return mana_ib_gd_modify_qp(ibqp, attr, attr_mask, udata);
@@ -849,13 +908,29 @@ static int mana_ib_destroy_rc_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
 	/* Ignore return code as there is not much we can do about it.
 	 * The error message is printed inside.
 	 */
-	mana_ib_gd_destroy_rc_qp(mdev, qp);
+	mana_ib_gd_destroy_rnic_qp(mdev, qp);
 	for (i = 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i)
 		mana_ib_destroy_queue(mdev, &qp->rc_qp.queues[i]);
 
 	return 0;
 }
 
+static int mana_ib_destroy_uc_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
+{
+	struct mana_ib_dev *mdev =
+		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
+	int i;
+
+	mana_table_remove_qp(mdev, qp);
+	/* Ignore return code as there is not much we can do about it.
+	 * The error message is printed inside.
+	 */
+	mana_ib_gd_destroy_rnic_qp(mdev, qp);
+	for (i = 0; i < MANA_UC_QUEUE_TYPE_MAX; ++i)
+		mana_ib_destroy_queue(mdev, &qp->uc_qp.queues[i]);
+	return 0;
+}
+
 static int mana_ib_destroy_ud_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
 {
 	struct mana_ib_dev *mdev =
@@ -891,6 +966,8 @@ int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		return mana_ib_destroy_qp_raw(qp, udata);
 	case IB_QPT_RC:
 		return mana_ib_destroy_rc_qp(qp, udata);
+	case IB_QPT_UC:
+		return mana_ib_destroy_uc_qp(qp, udata);
 	case IB_QPT_UD:
 	case IB_QPT_GSI:
 		return mana_ib_destroy_ud_qp(qp, udata);
diff --git a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h
index a75bf32b8..f844afb6b 100644
--- a/include/uapi/rdma/mana-abi.h
+++ b/include/uapi/rdma/mana-abi.h
@@ -57,6 +57,17 @@ struct mana_ib_create_rc_qp_resp {
 	__u32 queue_id[4];
 };
 
+struct mana_ib_create_uc_qp {
+	__aligned_u64 queue_buf[3];
+	__u32 queue_size[3];
+	__u32 reserved;
+};
+
+struct mana_ib_create_uc_qp_resp {
+	__u32 queue_id[3];
+	__u32 reserved;
+};
+
 struct mana_ib_create_wq {
 	__aligned_u64 wq_buf_addr;
 	__u32 wq_buf_size;
-- 
2.43.0


