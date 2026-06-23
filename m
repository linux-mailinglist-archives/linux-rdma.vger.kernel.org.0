Return-Path: <linux-rdma+bounces-22433-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zKIyMB1yOmrH9AcAu9opvQ
	(envelope-from <linux-rdma+bounces-22433-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 13:46:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 143FF6B6D75
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 13:46:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=Um5V27e+;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22433-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22433-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F88A30C5979
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 11:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2D73D3CFF;
	Tue, 23 Jun 2026 11:44:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470BC29ACC6;
	Tue, 23 Jun 2026 11:44:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215094; cv=none; b=OnDKlP4SMx55Zvls5Z1U4Z7lT21yGgS4oUZuliCPK3u9Xy8TUc5v8WsN8YFWipS37rvxWZXuC0YLgYbtr3WE0UmO7/h9VK9USW8MMn0Xw9vlPnCJR5n8S1aPWS1yQiyUhVyvVGCO2cXDOqF6alI7X76C0rzu504SjPKvZC9KZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215094; c=relaxed/simple;
	bh=d9fHoTuap0zrp222P/1s1EoYpoGgQa6bBD2BKN5dmtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IrWUrRD1FZL++urjvOpjXTdbtNTY5PIY+w7Poj8xABDR7fbS7QaJ1Q07KVN73k8R7VdEC3mtyZTq7L7JyvLHk1nViNsngxRsusaOfO1SZtRCTBf4AMV+4YZMGvWmGX6vQE49Bp2cBJe/ajJs0tZjNa+saZLQjG4Rn2asMfWdrOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Um5V27e+; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 0A53920B7169; Tue, 23 Jun 2026 04:44:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A53920B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782215084;
	bh=ydtVIbDDUCoEJhNLDvxbwKJdLDTaG2jOiVol6tMxc3I=;
	h=From:To:Cc:Subject:Date:From;
	b=Um5V27e+Et1JlnunQCu8J8/rOS1/nEVyntZRWqI77ful3JOedAUb9wLJpSRv0jE+X
	 /Wxg5d5nJxrUqflC4LP+LlBVICdOPsLKWZjKgBE0x15LlzSuN5B6J0IX1VR6FFp52I
	 hfDDrQ+oeYEZH9l+21oK1lpiP8LrQVMietS5+8rY=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Adopt robust udata
Date: Tue, 23 Jun 2026 04:44:43 -0700
Message-ID: <20260623114444.1429042-1-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22433-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kotaranov@microsoft.com,m:shirazsaleem@microsoft.com,m:longli@microsoft.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kotaranov@linux.microsoft.com,linux-rdma@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@linux.microsoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 143FF6B6D75

From: Konstantin Taranov <kotaranov@microsoft.com>

Enable the uverbs robust udata interface in mana_ib by setting
uverbs_robust_udata and converting the driver to the new udata
handling model.

The alloc_ucontext() request is extended to receive userspace
capability flags, providing a foundation for future feature
negotiation between rdma-core and the kernel driver.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c      | 10 ++++--
 drivers/infiniband/hw/mana/device.c  |  1 +
 drivers/infiniband/hw/mana/main.c    | 36 +++++++++++++++++-----
 drivers/infiniband/hw/mana/mana_ib.h |  4 +++
 drivers/infiniband/hw/mana/mr.c      | 15 ++++++++-
 drivers/infiniband/hw/mana/qp.c      | 46 +++++++++++++++++++++-------
 drivers/infiniband/hw/mana/wq.c      | 16 ++++++++--
 include/uapi/rdma/mana-abi.h         | 14 +++++++--
 8 files changed, 115 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index f2547989f..a5757847b 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -27,7 +27,8 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	is_rnic_cq = mana_ib_is_rnic(mdev);
 
 	if (udata) {
-		err = ib_copy_validate_udata_in(udata, ucmd, buf_addr);
+		err = ib_copy_validate_udata_in_cm(udata, ucmd, buf_addr,
+						   MANA_IB_CREATE_RNIC_CQ);
 		if (err)
 			return err;
 
@@ -105,6 +106,11 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
 	struct ib_device *ibdev = ibcq->device;
 	struct mana_ib_dev *mdev;
+	int err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
@@ -117,7 +123,7 @@ int mana_ib_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	mana_ib_destroy_queue(mdev, &cq->queue);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 static void mana_ib_cq_handler(void *ctx, struct gdma_queue *gdma_cq)
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 9811570ab..a8d19586a 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -15,6 +15,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_MANA,
 	.uverbs_abi_ver = MANA_IB_UVERBS_ABI_VERSION,
+	.uverbs_robust_udata = true,
 
 	.add_gid = mana_ib_gd_add_gid,
 	.alloc_mw = mana_ib_alloc_mw,
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index a86f80b91..d8f93502b 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -77,6 +77,10 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct gdma_context *gc;
 	int err;
 
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
+
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	gc = mdev_to_gc(dev);
 
@@ -98,7 +102,7 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 	mutex_init(&pd->vport_mutex);
 	pd->vport_use_count = 0;
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
@@ -109,6 +113,11 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct gdma_destroy_pd_req req = {};
 	struct mana_ib_dev *dev;
 	struct gdma_context *gc;
+	int err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	gc = mdev_to_gc(dev);
@@ -118,7 +127,11 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 	req.pd_handle = pd->pd_handle;
 
-	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err)
+		return err;
+
+	return ib_respond_empty_udata(udata);
 }
 
 static int mana_gd_destroy_doorbell_page(struct gdma_context *gc,
@@ -169,26 +182,33 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 	struct mana_ib_ucontext *ucontext =
 		container_of(ibcontext, struct mana_ib_ucontext, ibucontext);
 	struct ib_device *ibdev = ibcontext->device;
+	struct mana_ib_uctx_req ucmd;
 	struct mana_ib_dev *mdev;
 	struct gdma_context *gc;
 	int doorbell_page;
 	int ret;
 
+	if (udata->inlen) {
+		ret = ib_copy_validate_udata_in_cm(udata, ucmd, comp_mask, 0);
+		if (ret)
+			return ret;
+	}
+
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	gc = mdev_to_gc(mdev);
 
 	/* Allocate a doorbell page index */
 	ret = mana_gd_allocate_doorbell_page(gc, &doorbell_page);
-	if (ret) {
-		ibdev_dbg(ibdev, "Failed to allocate doorbell page %d\n", ret);
+	if (ret)
 		return ret;
-	}
-
-	ibdev_dbg(ibdev, "Doorbell page allocated %d\n", doorbell_page);
 
 	ucontext->doorbell = doorbell_page;
+	ucontext->client_caps1 = ucmd.client_caps1;
+	ucontext->client_caps2 = ucmd.client_caps2;
+	ucontext->client_caps3 = ucmd.client_caps3;
+	ucontext->client_caps4 = ucmd.client_caps4;
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index c9c94e86a..f0c605914 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -202,6 +202,10 @@ struct mana_ib_qp {
 struct mana_ib_ucontext {
 	struct ib_ucontext ibucontext;
 	u32 doorbell;
+	u64 client_caps1;
+	u64 client_caps2;
+	u64 client_caps3;
+	u64 client_caps4;
 };
 
 struct mana_ib_rwq_ind_table {
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 030bfdcff..2a85e6a04 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -113,6 +113,10 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	if (dmah)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return ERR_PTR(err);
+
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
 	ibdev_dbg(ibdev,
@@ -327,6 +331,11 @@ int mana_ib_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 {
 	struct mana_ib_dev *mdev = container_of(ibmw->device, struct mana_ib_dev, ib_dev);
 	struct mana_ib_pd *pd = container_of(ibmw->pd, struct mana_ib_pd, ibpd);
+	int err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	return mana_ib_gd_create_mw(mdev, pd, ibmw);
 }
@@ -346,6 +355,10 @@ int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	struct mana_ib_dev *dev;
 	int err;
 
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
+
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
 	err = mana_ib_gd_destroy_mr(dev, mr->mr_handle);
@@ -357,7 +370,7 @@ int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
 	kfree(mr);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 static int mana_ib_gd_alloc_dm(struct mana_ib_dev *mdev, struct mana_ib_dm *dm,
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 39d9cdcc5..727cd4c94 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -606,10 +606,8 @@ static int mana_ib_create_ud_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	u32 doorbell, queue_size;
 	int i, err;
 
-	if (udata) {
-		ibdev_dbg(&mdev->ib_dev, "User-level UD QPs are not supported\n");
+	if (udata)
 		return -EOPNOTSUPP;
-	}
 
 	for (i = 0; i < MANA_UD_QUEUE_TYPE_MAX; ++i) {
 		queue_size = mana_ib_queue_size(attr, i);
@@ -700,6 +698,11 @@ static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct mana_port_context *mpc;
 	struct net_device *ndev;
+	int err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_SET_QP_STATE, sizeof(req), sizeof(resp));
 
@@ -752,7 +755,11 @@ static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		req.ah_attr.flow_label = attr->ah_attr.grh.flow_label;
 	}
 
-	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err)
+		return err;
+
+	return ib_respond_empty_udata(udata);
 }
 
 int mana_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
@@ -779,7 +786,11 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 	struct net_device *ndev;
 	struct mana_ib_wq *wq;
 	struct ib_wq *ibwq;
-	int i;
+	int i, err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	ndev = mana_ib_get_netdev(qp->ibqp.device, qp->port);
 	mpc = netdev_priv(ndev);
@@ -807,7 +818,7 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 		mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
 	}
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
@@ -818,6 +829,11 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 	struct mana_port_context *mpc;
 	struct net_device *ndev;
 	struct mana_ib_pd *pd;
+	int err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	ndev = mana_ib_get_netdev(qp->ibqp.device, qp->port);
 	mpc = netdev_priv(ndev);
@@ -829,14 +845,18 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 
 	mana_ib_uncfg_vport(mdev, pd, qp->port);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 static int mana_ib_destroy_rc_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
 {
 	struct mana_ib_dev *mdev =
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
-	int i;
+	int i, err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	mana_table_remove_qp(mdev, qp);
 
@@ -847,14 +867,18 @@ static int mana_ib_destroy_rc_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
 	for (i = 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i)
 		mana_ib_destroy_queue(mdev, &qp->rc_qp.queues[i]);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 static int mana_ib_destroy_ud_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
 {
 	struct mana_ib_dev *mdev =
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
-	int i;
+	int i, err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	mana_remove_qp_from_cqs(qp);
 	mana_table_remove_qp(mdev, qp);
@@ -869,7 +893,7 @@ static int mana_ib_destroy_ud_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
 	for (i = 0; i < MANA_UD_QUEUE_TYPE_MAX; ++i)
 		mana_ib_destroy_queue(mdev, &qp->ud_qp.queues[i]);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
index 5c2134a0b..619c91e67 100644
--- a/drivers/infiniband/hw/mana/wq.c
+++ b/drivers/infiniband/hw/mana/wq.c
@@ -55,6 +55,11 @@ int mana_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
 	struct mana_ib_wq *wq = container_of(ibwq, struct mana_ib_wq, ibwq);
 	struct ib_device *ib_dev = ibwq->device;
 	struct mana_ib_dev *mdev;
+	int err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	mdev = container_of(ib_dev, struct mana_ib_dev, ib_dev);
 
@@ -62,18 +67,25 @@ int mana_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
 
 	kfree(wq);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 int mana_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_table,
 				 struct ib_rwq_ind_table_init_attr *init_attr,
 				 struct ib_udata *udata)
 {
+	int err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
+
 	/*
 	 * There is no additional data in ind_table to be maintained by this
 	 * driver, do nothing
 	 */
-	return 0;
+
+	return ib_respond_empty_udata(udata);
 }
 
 int mana_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_tbl)
diff --git a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h
index a75bf32b8..e6fdcefed 100644
--- a/include/uapi/rdma/mana-abi.h
+++ b/include/uapi/rdma/mana-abi.h
@@ -25,9 +25,9 @@ enum mana_ib_create_cq_flags {
 
 struct mana_ib_create_cq {
 	__aligned_u64 buf_addr;
-	__u16	flags;
-	__u16	reserved0;
-	__u32	reserved1;
+	__u16   comp_mask;
+	__u16   reserved0;
+	__u32   reserved1;
 };
 
 struct mana_ib_create_cq_resp {
@@ -68,6 +68,14 @@ enum mana_ib_rx_hash_function_flags {
 	MANA_IB_RX_HASH_FUNC_TOEPLITZ = 1 << 0,
 };
 
+struct mana_ib_uctx_req {
+	__aligned_u64 client_caps1;
+	__aligned_u64 client_caps2;
+	__aligned_u64 client_caps3;
+	__aligned_u64 client_caps4;
+	__aligned_u64 comp_mask;
+};
+
 struct mana_ib_create_qp_rss {
 	__aligned_u64 rx_hash_fields_mask;
 	__u8 rx_hash_function;
-- 
2.43.0


