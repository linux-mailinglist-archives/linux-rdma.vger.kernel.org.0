Return-Path: <linux-rdma+bounces-23112-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UEoVKbq5VGqFqAMAu9opvQ
	(envelope-from <linux-rdma+bounces-23112-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 12:11:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F27C9749A4E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 12:11:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=nKyv9hYR;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23112-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23112-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A50A3030B3B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1733D954E;
	Mon, 13 Jul 2026 10:10:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C8C3D565C;
	Mon, 13 Jul 2026 10:10:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937409; cv=none; b=gAYWuo2xFRSRN1lk+TOnOwrRGZB1VP4jVjf0/o5Qmu6MhDt+Rq4OXQ6GqZKsbSf2VzoiGJ5thUHIXgJ8eUdLc7kaa4asff3xUtwZpqB7sj3ADkO6dPH64FwgNQ538JIfhL9DTtpDjsUcjzIT/m4RDQ8unC9ewX1YLGcKMMEZ2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937409; c=relaxed/simple;
	bh=8Be7kGd/bFRcUlKEwR6TA9Fs430SeCTeys0zT5CVh7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mp75snMYZqM5G0qDHeIPmMvSnWb3sbim7RF4Awqftlos68OqAOgP1u4OtIfrsbERoUBFwAfLCEYDVS5Ulf8wf4jD7P/Do9nhY+NmAanXDR+2o7z0jHfytgfnYUDK9hNAmJ944tDHLFjgccV0cEdo6CwSmfmd1YkJP+2rFl24RRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nKyv9hYR; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 657FD20B716F; Mon, 13 Jul 2026 03:09:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 657FD20B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783937395;
	bh=Fx5X9le/Wxy8iM6hx0HHIJ7FEYrwpGR+qW5IUNCk9ZA=;
	h=From:To:Cc:Subject:Date:From;
	b=nKyv9hYRFxSh9K6xl3F40kL849bDVgQyPBtKj34VD3zFSN90AhQ9N+Zu2fHUln9K+
	 BzP/kTr5qMOEljw57lxWt/jLZzESrIJMHOte95KP7OcsHoKqr11XG6sDAEkCk/WsQ9
	 zf7l9EK766IxdMnkJepeFCK+lAtpw+o4JBnf1AlQ=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2] RDMA/mana_ib: Adopt robust udata
Date: Mon, 13 Jul 2026 03:09:55 -0700
Message-ID: <20260713100955.3512145-1-kotaranov@linux.microsoft.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23112-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kotaranov@microsoft.com,m:longli@microsoft.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kotaranov@linux.microsoft.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@linux.microsoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F27C9749A4E

From: Konstantin Taranov <kotaranov@microsoft.com>

Enable the uverbs robust udata interface in mana_ib by setting
uverbs_robust_udata and converting the driver to the new udata
handling model.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
v2: Removed the udata request for alloc ucontext
 drivers/infiniband/hw/mana/cq.c     | 10 +++++--
 drivers/infiniband/hw/mana/device.c |  1 +
 drivers/infiniband/hw/mana/main.c   | 29 +++++++++++++-----
 drivers/infiniband/hw/mana/mr.c     | 15 +++++++++-
 drivers/infiniband/hw/mana/qp.c     | 46 ++++++++++++++++++++++-------
 drivers/infiniband/hw/mana/wq.c     | 16 ++++++++--
 include/uapi/rdma/mana-abi.h        |  2 +-
 7 files changed, 94 insertions(+), 25 deletions(-)

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
index efe2935bd..6258f834b 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -101,6 +101,10 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct gdma_context *gc;
 	int err;
 
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
+
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	gc = mdev_to_gc(dev);
 
@@ -122,7 +126,7 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 	mutex_init(&pd->vport_mutex);
 	pd->vport_use_count = 0;
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
@@ -133,6 +137,11 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
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
@@ -142,7 +151,11 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 	req.pd_handle = pd->pd_handle;
 
-	return mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
+	if (err)
+		return err;
+
+	return ib_respond_empty_udata(udata);
 }
 
 static int mana_gd_destroy_doorbell_page(struct gdma_context *gc,
@@ -198,21 +211,21 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 	int doorbell_page;
 	int ret;
 
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ret;
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
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
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
index 60926f39a..7f7e35941 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -651,10 +651,8 @@ static int mana_ib_create_ud_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	u32 doorbell, queue_size;
 	int i, err;
 
-	if (udata) {
-		ibdev_dbg(&mdev->ib_dev, "User-level UD QPs are not supported\n");
+	if (udata)
 		return -EOPNOTSUPP;
-	}
 
 	for (i = 0; i < MANA_UD_QUEUE_TYPE_MAX; ++i) {
 		queue_size = mana_ib_queue_size(attr, i);
@@ -745,6 +743,11 @@ static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct mana_port_context *mpc;
 	struct net_device *ndev;
+	int err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_SET_QP_STATE, sizeof(req), sizeof(resp));
 
@@ -797,7 +800,11 @@ static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
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
@@ -826,7 +833,11 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 	struct mana_ib_pd *pd;
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
@@ -861,7 +872,7 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 
 	mana_ib_uncfg_vport(mdev, pd, qp->port);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
@@ -872,6 +883,11 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
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
@@ -883,14 +899,18 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 
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
 
@@ -901,14 +921,18 @@ static int mana_ib_destroy_rc_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
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
@@ -923,7 +947,7 @@ static int mana_ib_destroy_ud_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
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
index a75bf32b8..8336bf51b 100644
--- a/include/uapi/rdma/mana-abi.h
+++ b/include/uapi/rdma/mana-abi.h
@@ -25,7 +25,7 @@ enum mana_ib_create_cq_flags {
 
 struct mana_ib_create_cq {
 	__aligned_u64 buf_addr;
-	__u16	flags;
+	__u16	comp_mask;
 	__u16	reserved0;
 	__u32	reserved1;
 };
-- 
2.43.0


