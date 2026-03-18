Return-Path: <linux-rdma+bounces-18358-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BWSIXvquml0dAIAu9opvQ
	(envelope-from <linux-rdma+bounces-18358-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 19:10:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B462C104A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 19:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D92393245AA3
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 17:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134531352A;
	Wed, 18 Mar 2026 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KQ3DgePC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8E930DEA0;
	Wed, 18 Mar 2026 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855580; cv=none; b=aPvGxJF44+yFSpDxn3hOq1YB+iMMiZaf1KYZ3/QyKoK5H2Wrj6gsNystWyHKS3jlS7drX7bdF9V8tf19Ye7voIovuhLkfR8OGbG1n9t6Jaf7izFKJEsyqkV/mEvYPLfYI6MLhtVGx4gUJ84Voqyssr6FmNRrzJ+CjkKR1Usosu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855580; c=relaxed/simple;
	bh=xzTyEtxEhJl874ZDRJRMBfLaFIZMqYaX5uoqss9TYOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V7JfMwlwoi3N+UVr+ox0EF3UGgnz1aZJvu1cAHdA7Dd+2Ejt874UkOaGJZxKsh32vQlArTKmHvCQDkroa25fn8PeynGvPtM28yfoDZWkq/YU5R3ru41ysE7cc1wqKVuqlSoCdibIB/rzJ+3UogaEmJbRIOF5HPFXBcl1GbK6l78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KQ3DgePC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 510E920B710C; Wed, 18 Mar 2026 10:39:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 510E920B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773855579;
	bh=7nQtp/nAZ/sCgfBkg8g1gxZrV+QbGfJl1b4ANBZm+X8=;
	h=From:To:Cc:Subject:Date:From;
	b=KQ3DgePCPFJ7eo44kve+xgfacJJyqQLAzWiBeGfPhR2Mpzm+dy2YOVFUNk+A7MLdv
	 jN/QAiGBmBrDjx2C4yjhEJ5Pj1M7wpdZuUdn+5UFKQy90Vlc9OMNlfXl9fsWNpMWDJ
	 sHOLre3rw4+7BexJgBErRfgYp3YuWu+a1aRSZP3U=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: cleanup the usage of mana_gd_send_request()
Date: Wed, 18 Mar 2026 10:39:39 -0700
Message-ID: <20260318173939.1417856-1-kotaranov@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18358-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@linux.microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.949];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: D9B462C104A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Konstantin Taranov <kotaranov@microsoft.com>

Do not check the status of the response header returned by mana_gd_send_request(),
as the returned error code already indicates the request status.

The mana_gd_send_request() may return no error code and have the response status
GDMA_STATUS_MORE_ENTRIES, which is a successful completion. It is used
for checking the correctness of multi-request operations, such as creation of
a dma region with mana_ib_gd_create_dma_region().

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 105 ++++--------------------------
 drivers/infiniband/hw/mana/mr.c   |  38 ++---------
 drivers/infiniband/hw/mana/qp.c   |   9 +--
 3 files changed, 19 insertions(+), 133 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 8d99cd00f002..47c71793793f 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -90,15 +90,8 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	err = mana_gd_send_request(gc, sizeof(req), &req,
 				   sizeof(resp), &resp);
 
-	if (err || resp.hdr.status) {
-		ibdev_dbg(&dev->ib_dev,
-			  "Failed to get pd_id err %d status %u\n", err,
-			  resp.hdr.status);
-		if (!err)
-			err = -EPROTO;
-
+	if (err)
 		return err;
-	}
 
 	pd->pd_handle = resp.pd_handle;
 	pd->pdn = resp.pd_id;
@@ -118,7 +111,6 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct gdma_destroy_pd_req req = {};
 	struct mana_ib_dev *dev;
 	struct gdma_context *gc;
-	int err;
 
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	gc = mdev_to_gc(dev);
@@ -127,18 +119,8 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 			     sizeof(resp));
 
 	req.pd_handle = pd->pd_handle;
-	err = mana_gd_send_request(gc, sizeof(req), &req,
-				   sizeof(resp), &resp);
 
-	if (err || resp.hdr.status) {
-		ibdev_dbg(&dev->ib_dev,
-			  "Failed to destroy pd_handle 0x%llx err %d status %u",
-			  pd->pd_handle, err, resp.hdr.status);
-		if (!err)
-			err = -EPROTO;
-	}
-
-	return err;
+	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 }
 
 static int mana_gd_destroy_doorbell_page(struct gdma_context *gc,
@@ -146,7 +128,6 @@ static int mana_gd_destroy_doorbell_page(struct gdma_context *gc,
 {
 	struct gdma_destroy_resource_range_req req = {};
 	struct gdma_resp_hdr resp = {};
-	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_RESOURCE_RANGE,
 			     sizeof(req), sizeof(resp));
@@ -155,15 +136,7 @@ static int mana_gd_destroy_doorbell_page(struct gdma_context *gc,
 	req.num_resources = 1;
 	req.allocated_resources = doorbell_page;
 
-	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-	if (err || resp.status) {
-		dev_err(gc->dev,
-			"Failed to destroy doorbell page: ret %d, 0x%x\n",
-			err, resp.status);
-		return err ?: -EPROTO;
-	}
-
-	return 0;
+	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 }
 
 static int mana_gd_allocate_doorbell_page(struct gdma_context *gc,
@@ -184,12 +157,8 @@ static int mana_gd_allocate_doorbell_page(struct gdma_context *gc,
 	req.allocated_resources = 0;
 
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-	if (err || resp.hdr.status) {
-		dev_err(gc->dev,
-			"Failed to allocate doorbell page: ret %d, 0x%x\n",
-			err, resp.hdr.status);
-		return err ?: -EPROTO;
-	}
+	if (err)
+		return err;
 
 	*doorbell_page = resp.allocated_resources;
 
@@ -861,20 +830,13 @@ int mana_ib_gd_destroy_rnic_adapter(struct mana_ib_dev *mdev)
 	struct mana_rnic_destroy_adapter_resp resp = {};
 	struct mana_rnic_destroy_adapter_req req = {};
 	struct gdma_context *gc;
-	int err;
 
 	gc = mdev_to_gc(mdev);
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_ADAPTER, sizeof(req), sizeof(resp));
 	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 
-	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-	if (err) {
-		ibdev_err(&mdev->ib_dev, "Failed to destroy RNIC adapter err %d", err);
-		return err;
-	}
-
-	return 0;
+	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 }
 
 int mana_ib_gd_add_gid(const struct ib_gid_attr *attr, void **context)
@@ -884,7 +846,6 @@ int mana_ib_gd_add_gid(const struct ib_gid_attr *attr, void **context)
 	struct mana_rnic_config_addr_resp resp = {};
 	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct mana_rnic_config_addr_req req = {};
-	int err;
 
 	if (ntype != RDMA_NETWORK_IPV4 && ntype != RDMA_NETWORK_IPV6) {
 		ibdev_dbg(&mdev->ib_dev, "Unsupported rdma network type %d", ntype);
@@ -898,13 +859,7 @@ int mana_ib_gd_add_gid(const struct ib_gid_attr *attr, void **context)
 	req.sgid_type = (ntype == RDMA_NETWORK_IPV6) ? SGID_TYPE_IPV6 : SGID_TYPE_IPV4;
 	copy_in_reverse(req.ip_addr, attr->gid.raw, sizeof(union ib_gid));
 
-	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-	if (err) {
-		ibdev_err(&mdev->ib_dev, "Failed to config IP addr err %d\n", err);
-		return err;
-	}
-
-	return 0;
+	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 }
 
 int mana_ib_gd_del_gid(const struct ib_gid_attr *attr, void **context)
@@ -914,7 +869,6 @@ int mana_ib_gd_del_gid(const struct ib_gid_attr *attr, void **context)
 	struct mana_rnic_config_addr_resp resp = {};
 	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct mana_rnic_config_addr_req req = {};
-	int err;
 
 	if (ntype != RDMA_NETWORK_IPV4 && ntype != RDMA_NETWORK_IPV6) {
 		ibdev_dbg(&mdev->ib_dev, "Unsupported rdma network type %d", ntype);
@@ -928,13 +882,7 @@ int mana_ib_gd_del_gid(const struct ib_gid_attr *attr, void **context)
 	req.sgid_type = (ntype == RDMA_NETWORK_IPV6) ? SGID_TYPE_IPV6 : SGID_TYPE_IPV4;
 	copy_in_reverse(req.ip_addr, attr->gid.raw, sizeof(union ib_gid));
 
-	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-	if (err) {
-		ibdev_err(&mdev->ib_dev, "Failed to config IP addr err %d\n", err);
-		return err;
-	}
-
-	return 0;
+	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 }
 
 int mana_ib_gd_config_mac(struct mana_ib_dev *mdev, enum mana_ib_addr_op op, u8 *mac)
@@ -942,7 +890,6 @@ int mana_ib_gd_config_mac(struct mana_ib_dev *mdev, enum mana_ib_addr_op op, u8
 	struct mana_rnic_config_mac_addr_resp resp = {};
 	struct mana_rnic_config_mac_addr_req req = {};
 	struct gdma_context *gc = mdev_to_gc(mdev);
-	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_MAC_ADDR, sizeof(req), sizeof(resp));
 	req.hdr.dev_id = mdev->gdma_dev->dev_id;
@@ -950,13 +897,7 @@ int mana_ib_gd_config_mac(struct mana_ib_dev *mdev, enum mana_ib_addr_op op, u8
 	req.op = op;
 	copy_in_reverse(req.mac_addr, mac, ETH_ALEN);
 
-	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-	if (err) {
-		ibdev_err(&mdev->ib_dev, "Failed to config Mac addr err %d", err);
-		return err;
-	}
-
-	return 0;
+	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 }
 
 int mana_ib_gd_create_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq, u32 doorbell)
@@ -996,7 +937,6 @@ int mana_ib_gd_destroy_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct mana_rnic_destroy_cq_resp resp = {};
 	struct mana_rnic_destroy_cq_req req = {};
-	int err;
 
 	if (cq->cq_handle == INVALID_MANA_HANDLE)
 		return 0;
@@ -1006,14 +946,7 @@ int mana_ib_gd_destroy_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 	req.adapter = mdev->adapter_handle;
 	req.cq_handle = cq->cq_handle;
 
-	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-
-	if (err) {
-		ibdev_err(&mdev->ib_dev, "Failed to destroy cq err %d", err);
-		return err;
-	}
-
-	return 0;
+	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 }
 
 int mana_ib_gd_create_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
@@ -1061,18 +994,13 @@ int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
 	struct mana_rnic_destroy_rc_qp_resp resp = {0};
 	struct mana_rnic_destroy_rc_qp_req req = {0};
 	struct gdma_context *gc = mdev_to_gc(mdev);
-	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_RC_QP, sizeof(req), sizeof(resp));
 	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.rc_qp_handle = qp->qp_handle;
-	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-	if (err) {
-		ibdev_err(&mdev->ib_dev, "Failed to destroy rc qp err %d", err);
-		return err;
-	}
-	return 0;
+
+	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 }
 
 int mana_ib_gd_create_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp,
@@ -1119,16 +1047,11 @@ int mana_ib_gd_destroy_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp *qp)
 	struct mana_rnic_destroy_udqp_resp resp = {0};
 	struct mana_rnic_destroy_udqp_req req = {0};
 	struct gdma_context *gc = mdev_to_gc(mdev);
-	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_UD_QP, sizeof(req), sizeof(resp));
 	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.qp_handle = qp->qp_handle;
-	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-	if (err) {
-		ibdev_err(&mdev->ib_dev, "Failed to destroy ud qp err %d", err);
-		return err;
-	}
-	return 0;
+
+	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 }
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 9613b225dad4..9bae99c8e846 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -70,15 +70,8 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_mr *mr,
 	}
 
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-
-	if (err || resp.hdr.status) {
-		ibdev_dbg(&dev->ib_dev, "Failed to create mr %d, %u", err,
-			  resp.hdr.status);
-		if (!err)
-			err = -EPROTO;
-
+	if (err)
 		return err;
-	}
 
 	mr->ibmr.lkey = resp.lkey;
 	mr->ibmr.rkey = resp.rkey;
@@ -92,23 +85,13 @@ static int mana_ib_gd_destroy_mr(struct mana_ib_dev *dev, u64 mr_handle)
 	struct gdma_destroy_mr_response resp = {};
 	struct gdma_destroy_mr_request req = {};
 	struct gdma_context *gc = mdev_to_gc(dev);
-	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_MR, sizeof(req),
 			     sizeof(resp));
 
 	req.mr_handle = mr_handle;
 
-	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-	if (err || resp.hdr.status) {
-		dev_err(gc->dev, "Failed to destroy MR: %d, 0x%x\n", err,
-			resp.hdr.status);
-		if (!err)
-			err = -EPROTO;
-		return err;
-	}
-
-	return 0;
+	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 }
 
 struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
@@ -339,12 +322,8 @@ static int mana_ib_gd_alloc_dm(struct mana_ib_dev *mdev, struct mana_ib_dm *dm,
 	req.flags =  attr->flags;
 
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-	if (err || resp.hdr.status) {
-		if (!err)
-			err = -EPROTO;
-
+	if (err)
 		return err;
-	}
 
 	dm->dm_handle = resp.dm_handle;
 
@@ -380,20 +359,11 @@ static int mana_ib_gd_destroy_dm(struct mana_ib_dev *mdev, struct mana_ib_dm *dm
 	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct gdma_destroy_dm_resp resp = {};
 	struct gdma_destroy_dm_req req = {};
-	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_DM, sizeof(req), sizeof(resp));
 	req.dm_handle = dm->dm_handle;
 
-	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-	if (err || resp.hdr.status) {
-		if (!err)
-			err = -EPROTO;
-
-		return err;
-	}
-
-	return 0;
+	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 }
 
 int mana_ib_dealloc_dm(struct ib_dm *ibdm, struct uverbs_attr_bundle *attrs)
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 82f84f7ad37a..7bf0753a7d28 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -731,7 +731,6 @@ static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct mana_port_context *mpc;
 	struct net_device *ndev;
-	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_SET_QP_STATE, sizeof(req), sizeof(resp));
 
@@ -784,13 +783,7 @@ static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		req.ah_attr.flow_label = attr->ah_attr.grh.flow_label;
 	}
 
-	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-	if (err) {
-		ibdev_err(&mdev->ib_dev, "Failed modify qp err %d", err);
-		return err;
-	}
-
-	return 0;
+	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 }
 
 int mana_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
-- 
2.43.0


