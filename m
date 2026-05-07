Return-Path: <linux-rdma+bounces-20136-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE5XBsF1/GmdQQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20136-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 13:21:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6355A4E75DC
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 13:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 171F130053DC
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7AB388E61;
	Thu,  7 May 2026 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Wj1Vo9wU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1474C30BF68
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152894; cv=none; b=UUTuslHQS1oyxy1V+tuxsPmm9k69CRQH/s5ynr0E8ZbEwZXoVsRD/pAo8TEUWHcCBb95jfcUlEwcxPbDvnl5TtgaSKUxwO1iy4ibfMcCSzgkvk++Xnnpk7ibWgvSItReQzZYN7x0zMfy+QryE77z3pGPKsXmqaUE3O+EGoj90sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152894; c=relaxed/simple;
	bh=F9+6oDIXQ9rdrQt2y0B2jTwhDXpYlx+y7GWke0yfK3U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DmNU+ZpdU5Vz+kZDMhYwRDwqror8E1cQS3LxrmaLXO3IpFX6IV26NRrHIAZqeS9OFBraH0xQ6HiQXE6lloaQMdkzwEJzM9a8r7tbi4N/rwSe21x4hRPOUlXFPFb72MmmIR5pymjjUp92U8ux0+YrXh8IegsM7mTdTX31CakvjAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Wj1Vo9wU; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778152893; x=1809688893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5Gg7SonK7SBMA5NkS/IxXFVLSCMYnvZ5Qb7otOX6+Ik=;
  b=Wj1Vo9wUI47XXFMvtnr+djS54nw8Kn5L3lB+bQmO38EOKHth89o8FxZS
   l4Zi8pbIYdPhh22HK9f5meNe1pDNmZ9O2GNd033A9KvydAa/Oa6UKzh2A
   zNYFPfq+oimGsLIVjD6NqSzfQcYyS5pjToOYbjygdCgdaxKsQbOaeAZAp
   +qXM3twjPFxnkAyV5qTN4y0/uK4+FXvygx4xA4MkFlTLr3MUE7/8okJp6
   RJB56blqqhaa3JTK2StBVmgT3+X/UCLlffGYQDac2nL48ol7ItlKlKYGf
   xE41LHQYsNRAMC/5+whov6D6/Svomzxhox6ZJQsDgVp/ChAr7Ghu6JZk1
   A==;
X-CSE-ConnectionGUID: tkR7HxDWR0WuA9OGqKJjQg==
X-CSE-MsgGUID: Zk4bCZ87QvyTg5JqKbQyJg==
X-IronPort-AV: E=Sophos;i="6.23,221,1770595200"; 
   d="scan'208";a="18959073"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 11:21:29 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:3620]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.165:2525] with esmtp (Farcaster)
 id c9af87e0-1cb4-4e01-8870-7b8f487fbf9b; Thu, 7 May 2026 11:21:29 +0000 (UTC)
X-Farcaster-Flow-ID: c9af87e0-1cb4-4e01-8870-7b8f487fbf9b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 7 May 2026 11:21:28 +0000
Received: from dev-dsk-ynachum-1b-0ecf7b87.eu-west-1.amazon.com
 (10.13.226.176) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 7 May 2026
 11:21:26 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Daniel Kranzdorf <dkkranzd@amazon.com>, "Yonatan
 Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Validate SQ depth based on WQE size
Date: Thu, 7 May 2026 11:21:10 +0000
Message-ID: <20260507112110.869212-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 6355A4E75DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20136-lists,linux-rdma=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Michael Margolin <mrgolin@amazon.com>

Change the SQ depth validation to take into account the SQ WQE size.
This is needed since when using 128-byte WQE the max SQ depth is cut in
half. On create QP command, userspace provides SQ ring size which is SQ
depth X WQE size so we can calculate the requested WQE size in the
kernel.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 39 ++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 7bd0838ebc99..eb95ed4e25f7 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -612,14 +612,27 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
 	return -ENOMEM;
 }
 
+static int efa_calc_sq_wqe_size(u32 sq_ring_size, u32 max_send_wr)
+{
+	return max_send_wr == 0 ? 0 : sq_ring_size / max_send_wr;
+}
+
+static u32 efa_calc_sq_max_depth(struct efa_dev *dev, u32 sq_wqe_size)
+{
+	return sq_wqe_size == 0 ? 0 :
+		rounddown_pow_of_two(dev->dev_attr.max_llq_size / sq_wqe_size);
+}
+
 static int efa_qp_validate_cap(struct efa_dev *dev,
-			       struct ib_qp_init_attr *init_attr)
+			       struct ib_qp_init_attr *init_attr,
+			       u32 sq_wqe_size)
 {
-	if (init_attr->cap.max_send_wr > dev->dev_attr.max_sq_depth) {
+	u32 sq_max_depth = efa_calc_sq_max_depth(dev, sq_wqe_size);
+
+	if (init_attr->cap.max_send_wr > sq_max_depth) {
 		ibdev_dbg(&dev->ibdev,
 			  "qp: requested send wr[%u] exceeds the max[%u]\n",
-			  init_attr->cap.max_send_wr,
-			  dev->dev_attr.max_sq_depth);
+			  init_attr->cap.max_send_wr, sq_max_depth);
 		return -EINVAL;
 	}
 	if (init_attr->cap.max_recv_wr > dev->dev_attr.max_rq_depth) {
@@ -686,19 +699,12 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	struct efa_qp *qp = to_eqp(ibqp);
 	struct efa_ucontext *ucontext;
 	u16 supported_efa_flags = 0;
+	u32 sq_wqe_size;
 	int err;
 
 	ucontext = rdma_udata_to_drv_context(udata, struct efa_ucontext,
 					     ibucontext);
 
-	err = efa_qp_validate_cap(dev, init_attr);
-	if (err)
-		goto err_out;
-
-	err = efa_qp_validate_attr(dev, init_attr);
-	if (err)
-		goto err_out;
-
 	err = ib_copy_validate_udata_in_cm(udata, cmd, driver_qp_type, 0);
 	if (err)
 		goto err_out;
@@ -720,6 +726,15 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 		goto err_out;
 	}
 
+	sq_wqe_size = efa_calc_sq_wqe_size(cmd.sq_ring_size, init_attr->cap.max_send_wr);
+	err = efa_qp_validate_cap(dev, init_attr, sq_wqe_size);
+	if (err)
+		goto err_out;
+
+	err = efa_qp_validate_attr(dev, init_attr);
+	if (err)
+		goto err_out;
+
 	create_qp_params.uarn = ucontext->uarn;
 	create_qp_params.pd = to_epd(ibqp->pd)->pdn;
 
-- 
2.50.1


