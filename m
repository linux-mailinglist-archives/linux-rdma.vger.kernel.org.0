Return-Path: <linux-rdma+bounces-21652-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jRqMGQlPH2ookAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21652-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 23:45:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3047B6322E3
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 23:45:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=g6lu8TOM;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21652-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21652-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DCE830404A6
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 21:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC293AB466;
	Tue,  2 Jun 2026 21:45:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC45203710
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 21:45:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436717; cv=none; b=S/F2AkjSxdJ5mOz0jMEs1Jq9UBHC4W5IYiGUJO+oCMhQE/HMUWdnEx4dj6snm3feG2OAdU4zfatyvXQsTEJhYjdqxuLKQw+GFsJUL+XeArlC/tc94Q6WGpMBHe+IisZdVaoQslfX0TwWdiN0IKNUI0YCW/Riya2k4W8nQuTlFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436717; c=relaxed/simple;
	bh=dQe1Hie47eex+U2zDIAul2hhVeOFxiwvLQlcvOLtdD4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GcozdgriWU2YwaWbsi2pS6dVpiCnoKlrkSv4R+3SF4PHtC64OEJv+3adg8dhUrgDwaJJnzngI3pEBaTQOi/PildqEJ9xOlAmUz2hGQa3MMehiSStg8+8cGYnDKqT2QIEisb3lKqhyhNEh4ks5Z1UmKUYy22uuF3UllqEf4DkKT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g6lu8TOM; arc=none smtp.client-ip=209.85.219.74
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8ce9de04835so88980976d6.0
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780436715; x=1781041515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OMrqm1KbwSnMRaDmHRuy0ZpQql8lqXS3V8rSv/zBF2s=;
        b=g6lu8TOMjJrKRCgZrQVNix+x4dS6NQTPbznuD2niFR0QRaKQVWKwy6oMniXVsgvvJT
         TRkAnswLPYTK6fswd+lEP5lH88Ng3dteezyJfUF5lgXPL17LQscPUU5TmxFpVy2c9MER
         don+IGaYjZoAlDlmuW5qB2pqDnr/wmTh6Z/D7/pQoIauQB2u+KlE3KX2MzJowwPwpsa8
         4xrBnnENWkFDv4EuoYwuCJyoFfqUaLHo1B1WXMXYeDiC/c7GTOK4yb79TzhNTAlGb5/e
         VJpFfGxtY+SsJcbUO2gWb+oG6fQBeptWS9Xs2R0I2ltB9UafNIMv5ePh/WNk2GTKskUZ
         xIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780436715; x=1781041515;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMrqm1KbwSnMRaDmHRuy0ZpQql8lqXS3V8rSv/zBF2s=;
        b=LPwonfG/wlnFE4/In9uTSy0nFM3Bxdl0umAq2gN84q+8spniRkjXa4lQGW1OSUzttz
         DjEV2M907jlP0lw2+/xIa/dZK/+yZ9vdAivLx0WdC2v7Ps63hVvjvUu+hky6/+Qb7FC5
         L1H4isVX/v81CUvDdphBqv8F/qk7SqcfYWBfwLzx5HyDSYOyg8tRBs7yKmJYg9gIwl5G
         8PeHIbKn8imric4LjjQcFue8wgfYodI9rtKYt6Mo+09SKcevoS+oicgLeZWJVl1Maj4o
         y80RMmzTRkUbjzq9aJzDKgS7lsZofqfF/dBPGl6cWryImdlmbqL1eSO28NoGrG77w7Sn
         T0LQ==
X-Gm-Message-State: AOJu0YxDRD/uM905ekH1rX1iPCE6wTWTiNSBkZDIJ7zvOrYUZWmVbtrS
	XjoOQnNaMAx4WNcCZeA8EKn3LARnKJIC2jpGSHb2jElMMGMzVHHlI8ivaOmrR8APhw4Sux8kNFh
	SJnUGxhQQlw==
X-Received: from qvbgw4.prod.google.com ([2002:a05:6214:f04:b0:8c6:6d4a:bd05])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:c24:b0:8a4:58ff:f0f8
 with SMTP id 6a1803df08f44-8cecdf0c4f4mr6152626d6.29.1780436715054; Tue, 02
 Jun 2026 14:45:15 -0700 (PDT)
Date: Tue,  2 Jun 2026 21:44:22 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602214423.1315105-1-jmoroni@google.com>
Subject: [PATCH rdma-next 1/2] RDMA/irdma: Remove redundant legacy_mode checks
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21652-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3047B6322E3

The driver has the following invariants:

1. legacy_mode is only allowed on GEN_1 hardware (enforced
   in irdma_alloc_ucontext).

2. GEN_1 hardware does not set IRDMA_FEATURE_CQ_RESIZE or
   IRDMA_FEATURE_RTS_AE. These feature flags are only set
   for GEN_2 and GEN_3 hardware.

Therefore, legacy_mode is always false if IRDMA_FEATURE_CQ_RESIZE
or IRDMA_FEATURE_RTS_AE is set, so remove the redundant checks.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/uk.c    | 9 +++------
 drivers/infiniband/hw/irdma/user.h  | 1 -
 drivers/infiniband/hw/irdma/verbs.c | 7 +------
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index 4718acf6c6fd..a34883fe9983 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1568,15 +1568,12 @@ static const struct irdma_wqe_uk_ops iw_wqe_uk_ops_gen_1 = {
  * irdma_setup_connection_wqes - setup WQEs necessary to complete
  * connection.
  * @qp: hw qp (user and kernel)
- * @info: qp initialization info
  */
-static void irdma_setup_connection_wqes(struct irdma_qp_uk *qp,
-					struct irdma_qp_uk_init_info *info)
+static void irdma_setup_connection_wqes(struct irdma_qp_uk *qp)
 {
 	u16 move_cnt = 1;
 
-	if (!info->legacy_mode &&
-	    (qp->uk_attrs->feature_flags & IRDMA_FEATURE_RTS_AE))
+	if (qp->uk_attrs->feature_flags & IRDMA_FEATURE_RTS_AE)
 		move_cnt = 3;
 
 	qp->conn_wqes = move_cnt;
@@ -1727,7 +1724,7 @@ int irdma_uk_qp_init(struct irdma_qp_uk *qp, struct irdma_qp_uk_init_info *info)
 	sq_ring_size = qp->sq_size << info->sq_shift;
 	IRDMA_RING_INIT(qp->sq_ring, sq_ring_size);
 	if (info->first_sq_wq) {
-		irdma_setup_connection_wqes(qp, info);
+		irdma_setup_connection_wqes(qp);
 		qp->swqe_polarity = 1;
 		qp->first_sq_wq = true;
 	} else {
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 008af1acc928..4dd3776a4cdd 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -563,7 +563,6 @@ struct irdma_qp_uk_init_info {
 	u8 sq_shift;
 	u8 rq_shift;
 	int abi_ver;
-	bool legacy_mode;
 	struct irdma_srq_uk *srq_uk;
 };
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index b30e81d2b933..670b0e0f9200 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -634,7 +634,6 @@ static int irdma_setup_umode_qp(struct ib_udata *udata,
 	iwqp->ctx_info.qp_compl_ctx = req.user_compl_ctx;
 	iwqp->user_mode = 1;
 	if (req.user_wqe_bufs) {
-		info->qp_uk_init_info.legacy_mode = ucontext->legacy_mode;
 		spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
 		iwqp->iwpbl = irdma_get_pbl((unsigned long)req.user_wqe_bufs,
 					    &ucontext->qp_reg_mem_list);
@@ -2074,10 +2073,6 @@ static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 			rdma_udata_to_drv_context(udata, struct irdma_ucontext,
 						  ibucontext);
 
-		/* CQ resize not supported with legacy GEN_1 libi40iw */
-		if (ucontext->legacy_mode)
-			return -EOPNOTSUPP;
-
 		if (ib_copy_from_udata(&req, udata,
 				       min(sizeof(req), udata->inlen)))
 			return -EINVAL;
@@ -2559,7 +2554,7 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 		cqmr = &iwpbl->cq_mr;
 
 		if (rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
-		    IRDMA_FEATURE_CQ_RESIZE && !ucontext->legacy_mode) {
+		    IRDMA_FEATURE_CQ_RESIZE) {
 			spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
 			iwpbl_shadow = irdma_get_pbl(
 					(unsigned long)req.user_shadow_area,
-- 
2.54.0.1032.g2f8565e1d1-goog


