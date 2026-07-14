Return-Path: <linux-rdma+bounces-23194-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mn5jDgEuVmqH0wAAu9opvQ
	(envelope-from <linux-rdma+bounces-23194-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 14:39:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D65F754A6F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 14:39:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b="MBAF/oyG";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23194-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23194-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4B4E30624AB
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2DB448CEC;
	Tue, 14 Jul 2026 12:31:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C481446850;
	Tue, 14 Jul 2026 12:31:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032297; cv=none; b=Ndh+jjdPWmrJCH+VuWpkqkDcrLoBMmbsMD/lrBOIrsmPio8idqLm66BN+I74aWLNrtHPAAr1fzlXMiFs5adnohxlpFf2xpNJGlRlNaucZD3GoZaELeN6Kr/qoVg9KbAVrG/Km7tf9WhzjmT0SEmmE0+HLpfJVAThhfWwfVxQhLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032297; c=relaxed/simple;
	bh=wQSEaXHFBqls5WNbOJRriC22nKvaP+GkcVtJM9Bn8Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hP3iWzp7M8qK8t4vs5h5D5AtOFpOY4cvPTbY97Q6eDfKETzKo8OgtGDDAd/yFokwGQNAmOzAMa6FmjeLRWCwp4/S72Asq3pHXmtHfAYySrQU9Y69CtF4EN/+2SgLErayq7NdStyOLvT+JtmT+7fXwllK4khg++qxZY+hxQSMWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MBAF/oyG; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id C0BA520B7166; Tue, 14 Jul 2026 05:31:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0BA520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784032273;
	bh=xjeiPJoImuDDvKz4bTt2gPM4I2GHqgG5YjY1WrCGphU=;
	h=From:To:Cc:Subject:Date:From;
	b=MBAF/oyGurnnyF2nXJy87LYIOuY/rQHENX2PCObbZkdlNsf/2Eo/neEFdrYpfd5nA
	 3/J/AK2WaB6BYWiIsXH+FKIs37HKgXWC7DBwqg5aJhsnmc0XfyrbGLgn/xfQJCyAF5
	 /epeXURmbGywtR2jAIwyGTCFhQds1M7ZRLbjc1WQ=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3] RDMA/mana_ib: Adopt robust udata
Date: Tue, 14 Jul 2026 05:31:13 -0700
Message-ID: <20260714123113.3792099-1-kotaranov@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23194-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kotaranov@linux.microsoft.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kotaranov@microsoft.com,m:longli@microsoft.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.microsoft.com:from_mime,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D65F754A6F

From: Konstantin Taranov <kotaranov@microsoft.com>

Enable the uverbs robust udata interface in mana_ib by setting
uverbs_robust_udata and converting the driver to the new udata
handling model.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
v3: use ib_no_udata_io
v2: Removed the udata request for alloc ucontext
 drivers/infiniband/hw/mana/cq.c     |  8 +++++-
 drivers/infiniband/hw/mana/device.c |  1 +
 drivers/infiniband/hw/mana/main.c   | 29 ++++++++++++++++------
 drivers/infiniband/hw/mana/mr.c     | 13 ++++++++++
 drivers/infiniband/hw/mana/qp.c     | 38 +++++++++++++++++++++++------
 drivers/infiniband/hw/mana/wq.c     | 12 +++++++++
 include/uapi/rdma/mana-abi.h        |  2 +-
 7 files changed, 86 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index f2547989f..d4e5e3f91 100644
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
+	err = ib_no_udata_io(udata);
+	if (err)
+		return err;
 
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
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
index efe2935bd..e645b7637 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -101,6 +101,10 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct gdma_context *gc;
 	int err;
 
+	err = ib_no_udata_io(udata);
+	if (err)
+		return err;
+
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	gc = mdev_to_gc(dev);
 
@@ -133,6 +137,11 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct gdma_destroy_pd_req req = {};
 	struct mana_ib_dev *dev;
 	struct gdma_context *gc;
+	int err;
+
+	err = ib_no_udata_io(udata);
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
+	return 0;
 }
 
 static int mana_gd_destroy_doorbell_page(struct gdma_context *gc,
@@ -198,17 +211,17 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 	int doorbell_page;
 	int ret;
 
+	ret = ib_no_udata_io(udata);
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
 
@@ -575,7 +588,7 @@ int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 	struct pci_dev *pdev = to_pci_dev(mdev_to_gc(dev)->dev);
 	int err;
 
-	err = ib_is_udata_in_empty(uhw);
+	err = ib_no_udata_io(uhw);
 	if (err)
 		return err;
 
@@ -605,7 +618,7 @@ int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 	if (!mana_ib_is_rnic(dev))
 		props->raw_packet_caps = IB_RAW_PACKET_CAP_IP_CSUM;
 
-	return ib_respond_empty_udata(uhw);
+	return 0;
 }
 
 int mana_ib_query_port(struct ib_device *ibdev, u32 port,
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 030bfdcff..1233685b4 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -113,6 +113,10 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	if (dmah)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	err = ib_no_udata_io(udata);
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
+	err = ib_no_udata_io(udata);
+	if (err)
+		return err;
 
 	return mana_ib_gd_create_mw(mdev, pd, ibmw);
 }
@@ -346,6 +355,10 @@ int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	struct mana_ib_dev *dev;
 	int err;
 
+	err = ib_no_udata_io(udata);
+	if (err)
+		return err;
+
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
 	err = mana_ib_gd_destroy_mr(dev, mr->mr_handle);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 60926f39a..b5ff07e34 100644
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
+	err = ib_no_udata_io(udata);
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
+	return 0;
 }
 
 int mana_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
@@ -826,7 +833,11 @@ static int mana_ib_destroy_qp_rss(struct mana_ib_qp *qp,
 	struct mana_ib_pd *pd;
 	struct mana_ib_wq *wq;
 	struct ib_wq *ibwq;
-	int i;
+	int i, err;
+
+	err = ib_no_udata_io(udata);
+	if (err)
+		return err;
 
 	ndev = mana_ib_get_netdev(qp->ibqp.device, qp->port);
 	mpc = netdev_priv(ndev);
@@ -872,6 +883,11 @@ static int mana_ib_destroy_qp_raw(struct mana_ib_qp *qp, struct ib_udata *udata)
 	struct mana_port_context *mpc;
 	struct net_device *ndev;
 	struct mana_ib_pd *pd;
+	int err;
+
+	err = ib_no_udata_io(udata);
+	if (err)
+		return err;
 
 	ndev = mana_ib_get_netdev(qp->ibqp.device, qp->port);
 	mpc = netdev_priv(ndev);
@@ -890,7 +906,11 @@ static int mana_ib_destroy_rc_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
 {
 	struct mana_ib_dev *mdev =
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
-	int i;
+	int i, err;
+
+	err = ib_no_udata_io(udata);
+	if (err)
+		return err;
 
 	mana_table_remove_qp(mdev, qp);
 
@@ -908,7 +928,11 @@ static int mana_ib_destroy_ud_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
 {
 	struct mana_ib_dev *mdev =
 		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
-	int i;
+	int i, err;
+
+	err = ib_no_udata_io(udata);
+	if (err)
+		return err;
 
 	mana_remove_qp_from_cqs(qp);
 	mana_table_remove_qp(mdev, qp);
diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
index 5c2134a0b..6b066d605 100644
--- a/drivers/infiniband/hw/mana/wq.c
+++ b/drivers/infiniband/hw/mana/wq.c
@@ -55,6 +55,11 @@ int mana_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
 	struct mana_ib_wq *wq = container_of(ibwq, struct mana_ib_wq, ibwq);
 	struct ib_device *ib_dev = ibwq->device;
 	struct mana_ib_dev *mdev;
+	int err;
+
+	err = ib_no_udata_io(udata);
+	if (err)
+		return err;
 
 	mdev = container_of(ib_dev, struct mana_ib_dev, ib_dev);
 
@@ -69,10 +74,17 @@ int mana_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_table,
 				 struct ib_rwq_ind_table_init_attr *init_attr,
 				 struct ib_udata *udata)
 {
+	int err;
+
+	err = ib_no_udata_io(udata);
+	if (err)
+		return err;
+
 	/*
 	 * There is no additional data in ind_table to be maintained by this
 	 * driver, do nothing
 	 */
+
 	return 0;
 }
 
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


