Return-Path: <linux-rdma+bounces-20856-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJc2BmkACmoOwAQAu9opvQ
	(envelope-from <linux-rdma+bounces-20856-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 19:52:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD29562C98
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 19:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96DC330022EE
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 17:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C74F3C4B8A;
	Sun, 17 May 2026 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lbehUQ0e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0630AABE
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040357; cv=none; b=p12wT73APXBNzDo4VZrUI67q6VXz9LYtOIq5bz/Gr5ua+t2jbUjNmc8umgTJULGKotizHMuGVt6vceX7B70HQ/8oRTZ8uEg3RHpA/ZXey9P5Md9dNnu0s8FrHLiCtq9IWDZk2plzwPlWoqjGvnG5/xDf3Ar0w+M1h0ND985ePhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040357; c=relaxed/simple;
	bh=fPNHC1Afvc+5k1iaBw8leSaZI0XikqeTUl9oq+5cjg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kRPaIBMAeah0nYB/e45kFYiTtHtXI7oa28mo+FTMzj2nvSNidana9IPSdXmjcY/MgwqSMQ0gwveUchvmbiWcnB/SeAh3xSJ0e9gpI2VGL1uT9w3Z/lk6hSpxHsV0ZWk79X3j80MMntz3gIsC7OaTbpjnTqfWosh9NfMik4GGl2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lbehUQ0e; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1779040355; x=1810576355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YUWUC5vUYt/lA+KaKiPj0xHEj9l0aJQO8J2hm7mmKl8=;
  b=lbehUQ0ejJVva9a+vqvv+3DQ2/OQjIlbtk+xmhs6/tFajbEjH0CO8Xzo
   hFPczl3YDzVX9zHZinODBXvqU9KnnyC0OV7ThRM9Eh0aRTl9Y7Vd7Xoaq
   ddMN/zjf7sKWS+Fo2xtWt2uFnghn3jUIlXyUaZlzV3aM2tGHSW5pNeruM
   uwll1IL5/vX12zUzoq4JWjvCoRVWIaxfsaOBUqXjamO5lsQjMMxSUO6qG
   W1d/b4c6P2L9ztcMNAhvzBbkOi0I+5SgLnTS8kUvysSsWQlw6QoJxMWOL
   ju+I0K+iVPsPFFEYKTYSXqSuCKsiPTNyp74dIwQY7MbR+cM7DBkCgff7w
   g==;
X-CSE-ConnectionGUID: eGsrzlhbRBuXyM8nkZ6qlQ==
X-CSE-MsgGUID: BIxUiipXTsGWHUdbNyhKVA==
X-IronPort-AV: E=Sophos;i="6.23,240,1770595200"; 
   d="scan'208";a="19825498"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 17:52:33 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:23723]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.30:2525] with esmtp (Farcaster)
 id 3b256d02-750c-4812-ac08-6570b4c1366a; Sun, 17 May 2026 17:52:33 +0000 (UTC)
X-Farcaster-Flow-ID: 3b256d02-750c-4812-ac08-6570b4c1366a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 17 May 2026 17:52:31 +0000
Received: from dev-dsk-ynachum-1b-0ecf7b87.eu-west-1.amazon.com
 (10.13.226.176) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Sun, 17 May 2026
 17:52:30 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>
Subject: [PATCH for-next v2] RDMA/efa: Validate SQ depth based on WQE size
Date: Sun, 17 May 2026 17:52:16 +0000
Message-ID: <20260517175216.614494-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: ABD29562C98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20856-lists,linux-rdma=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Change the SQ depth validation to take into account the SQ WQE size.
This is needed since when using 128-byte WQE the max SQ depth is cut in
half. On create QP command, userspace provides SQ ring size which is SQ
depth X WQE size so we can calculate the requested WQE size in the
kernel.

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
Changelog:
v2:
 * Add fixes line.
v1: https://lore.kernel.org/all/20260507112110.869212-1-ynachum@amazon.com/

 drivers/infiniband/hw/efa/efa_verbs.c | 39 ++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 395290ab0584..9a6cbb70581b 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -597,14 +597,27 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
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
@@ -671,19 +684,12 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
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
@@ -705,6 +711,15 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
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


