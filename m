Return-Path: <linux-rdma+bounces-20416-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDObCC9aAmosrgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20416-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 00:37:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B469F517001
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 00:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B3733036FAB
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 22:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2352A35675D;
	Mon, 11 May 2026 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PM4Eb5Gs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18CE356750
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778539051; cv=none; b=ciHrL0AWll2bgp1mzM2vphqbfW+ipFQDiA+rr5OgtpGzwZBJ7G/vCTM00ePY+vn+5RDsP6lkLhHArVoxnnwGsUKpW0S6bESTd9anRGVWAljupZN5IuRZvYEW8EJ7kQ5deX9e8sWIFl+bFXOcOAebuK3W/P99ATP0QWus7+DWBWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778539051; c=relaxed/simple;
	bh=afU6G9DE2A/txjcpaKRv+sSDHlHLmfdPtJg6cU04JWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ie/spUd+EFRd31car4wD4wZtjmsev1KXuQafJ1i/8h51Odt0T6Igq6gRFo0dzPMNrY/8iMF3M/qQFIQrNs7PdtgSeFjBMCKMDzGKDaryVzvo9/lPDRAGVXqtd5qTn/8cty8ljyq3OXNKKi9a32wSgV0b86oehtiVKDWNCA88ihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PM4Eb5Gs; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778539050; x=1810075050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O45qDKR6z42oM7mED6pyq4LMRkJjhPH0ji9GG9scv5I=;
  b=PM4Eb5GsSF1w8YStrChLfndzk4EV0N/bXBuUGKnHQcvKayDI6AskuuYV
   l/rXJ7I+oaxQ3VRuOGhFjd5e1ulnDDYT+1eVn2SyzgnVwHlRBbsTyYD08
   9kCH1/isyuLTLoHtMv3X5plJ8kMLhO8rd5xGqwZznsIO5egqxVGFY4uYq
   aghG7vIfD3Vzd6xgxCmudjDdtJvXe23VIOKUNJhd1bRBLNZlxfJkj3+up
   SOuMAnYg6UoucIN7wK13zocOXjJdPza1mG4MKuF2tQVLzVKlkbgIUpMsk
   In2o0XVdVZ2muw+Tf4E5P7Q1Nkg9S6wsBVMPGgrkEOGt77AeWzJiwL5qw
   A==;
X-CSE-ConnectionGUID: O5ItwJ2iQCmULsWXiFxerw==
X-CSE-MsgGUID: jULjj08PTiOEI/jjnsN6PA==
X-IronPort-AV: E=Sophos;i="6.23,229,1770595200"; 
   d="scan'208";a="19392972"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:37:28 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:19362]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.135:2525] with esmtp (Farcaster)
 id fda1b552-3b67-4839-88c2-82fc1a69b610; Mon, 11 May 2026 22:37:27 +0000 (UTC)
X-Farcaster-Flow-ID: fda1b552-3b67-4839-88c2-82fc1a69b610
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 11 May 2026 22:37:27 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 11 May 2026
 22:37:25 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next v4 2/5] RDMA/core: Prevent destroying in-use completion counters
Date: Mon, 11 May 2026 22:37:18 +0000
Message-ID: <20260511223721.18365-3-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511223721.18365-1-mrgolin@amazon.com>
References: <20260511223721.18365-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: B469F517001
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20416-lists,linux-rdma=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Reject comp_cntr destroy while it is attached to any QP. Track
attachments using an xarray in ib_qp keyed by the attach op_mask.
Use op bitmask to reject overlapping attaches early.

Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 .../core/uverbs_std_types_comp_cntr.c         |  3 +++
 drivers/infiniband/core/uverbs_std_types_qp.c | 22 ++++++++++++++++++-
 drivers/infiniband/core/verbs.c               |  1 +
 include/rdma/ib_verbs.h                       |  3 +++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_comp_cntr.c b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
index c1cf0f59d483..d64ec4c296dd 100644
--- a/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
+++ b/drivers/infiniband/core/uverbs_std_types_comp_cntr.c
@@ -13,6 +13,9 @@ static int uverbs_free_comp_cntr(struct ib_uobject *uobject, enum rdma_remove_re
 	struct ib_comp_cntr *cc = uobject->object;
 	int ret;
 
+	if (atomic_read(&cc->usecnt))
+		return -EBUSY;
+
 	ret = cc->device->ops.destroy_comp_cntr(cc);
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index dec4c0ebb41c..51a4639ef053 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -15,6 +15,8 @@ static int uverbs_free_qp(struct ib_uobject *uobject,
 	struct ib_qp *qp = uobject->object;
 	struct ib_uqp_object *uqp =
 		container_of(uobject, struct ib_uqp_object, uevent.uobject);
+	struct ib_comp_cntr *cc;
+	unsigned long index;
 	int ret;
 
 	/*
@@ -35,6 +37,10 @@ static int uverbs_free_qp(struct ib_uobject *uobject,
 	if (ret)
 		return ret;
 
+	xa_for_each(&qp->comp_cntrs, index, cc)
+		atomic_dec(&cc->usecnt);
+	xa_destroy(&qp->comp_cntrs);
+
 	if (uqp->uxrcd)
 		atomic_dec(&uqp->uxrcd->refcnt);
 
@@ -392,7 +398,21 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_ATTACH_COMP_CNTR)(
 	if (ret)
 		return ret;
 
-	return qp->device->ops.qp_attach_comp_cntr(qp, cc, &attr);
+	if (attr.op_mask & qp->comp_cntr_op_mask)
+		return -EBUSY;
+
+	ret = qp->device->ops.qp_attach_comp_cntr(qp, cc, &attr);
+	if (ret)
+		return ret;
+
+	ret = xa_err(xa_store(&qp->comp_cntrs, attr.op_mask, cc, GFP_KERNEL));
+	if (ret)
+		return ret;
+
+	atomic_inc(&cc->usecnt);
+	qp->comp_cntr_op_mask |= attr.op_mask;
+
+	return 0;
 }
 
 DECLARE_UVERBS_NAMED_METHOD(
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bac87de9cc67..df9a1bb9ece4 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1293,6 +1293,7 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	qp->qp_context = attr->qp_context;
 
 	spin_lock_init(&qp->mr_lock);
+	xa_init(&qp->comp_cntrs);
 	INIT_LIST_HEAD(&qp->rdma_mrs);
 	INIT_LIST_HEAD(&qp->sig_mrs);
 	init_completion(&qp->srq_completion);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index f36a6d48790a..270b49a7d174 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1752,6 +1752,7 @@ struct ib_comp_cntr {
 	struct ib_uobject *uobject;
 	u64 comp_count_max_value;
 	u64 err_count_max_value;
+	atomic_t usecnt;
 };
 
 enum ib_comp_cntr_entry {
@@ -1947,6 +1948,8 @@ struct ib_qp {
 	struct completion	srq_completion;
 	struct ib_xrcd	       *xrcd; /* XRC TGT QPs only */
 	struct list_head	xrcd_list;
+	struct xarray		comp_cntrs; /* op_mask -> comp_cntr */
+	u32			comp_cntr_op_mask;
 
 	/* count times opened, mcast attaches, flow attaches */
 	atomic_t		usecnt;
-- 
2.47.3


