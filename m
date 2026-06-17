Return-Path: <linux-rdma+bounces-22326-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BatbFvbNMmq55gUAu9opvQ
	(envelope-from <linux-rdma+bounces-22326-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 18:40:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEC769B6FC
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 18:40:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=j9MVj3f7;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22326-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22326-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A77243023315
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF4F2F362B;
	Wed, 17 Jun 2026 16:40:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173C2192F4
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 16:40:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781714417; cv=none; b=GHHlQB1A1r5aFwYx1z94RnJmpuN0O24ampQWdOg5Pm1rIU7Bs2tMTJsNOkm49mTFZb5Zzu8EZm1Mx+mjijVyEldFniRT4U2sQ2oJRrJKqsFFLvM0lre12ArTI2ONodOr3vp8FQIqK0rGXxHuVBdhY5zFjGHAY4POYtdkVwiD4RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781714417; c=relaxed/simple;
	bh=ND/3R3FflrteRpfZ11GZNAwVRBulAFLOPxtSxNOsfkM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ehnnFPYoNMw639wzIB015jnb6GZBaoDCvOG9i086DLUbeU4nlgS45W4H0+e2/V16jZ++1t2VcRwlU68iRKfUiohAM0lcwo1kX6b0uWuxThaqr/p4RjYqAChwYlq/3qIzXUzgmZlsir12bQFw2R/c5fxJEBs8rpdyUnq8vZMc13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9MVj3f7; arc=none smtp.client-ip=209.85.128.202
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7ff705a4289so307337b3.2
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 09:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781714415; x=1782319215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5svaNNp7cKnsud3bHF5lflk5qficdk4WzHew0OsUOC0=;
        b=j9MVj3f7BY4VsHBYyynF6iPK9hMzicCUaM9/4yP/YtYHDK5iUNhqxB4vfod64kcFj3
         +TEzPfFe/P1Dwm0Ag8JVH43Zy8Ip6viv8A9Vwn9kmvQdPz9g+frO5i0NJDbrfoaF9zLl
         rHNnDk+2LkkzTGOtSbJe1k5QaEfbCm76sS0VeJ6jTujXnVlPiCYpxvNF/fk1JlETi2K5
         C2OUaXG1p/eB7azcVdcdmMJPnaT9zi/sYRUyGvH/JK9SZuNq8rtUTx4rmwRcC2VQLLQy
         mAbxsCu0TjtXZYv1l5aCKulAOdst+MoB2r13exVEl3uqZ4P7vGXnS7dqvJUNoI0sJ/yL
         u/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781714415; x=1782319215;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5svaNNp7cKnsud3bHF5lflk5qficdk4WzHew0OsUOC0=;
        b=GsJBfj8Y1t0c7zr8QThrwD3x/ZnHs8/qZScIXo+wqPtJ1JS7oNuBdxCiiVLqRUsoxx
         WnMknCc0cdzsy14CkaAZNhcaiSNLWTokMT1uxhMnkYBSY+V3Kif5cMXjIhmq4Y1KYx5a
         bKsQL24gJ7+iTEOyxbguRDfo6bJ/IDsI3c41zcUoBwAVYXVo7iUc1Hw5qfbQ2JpYBWXu
         LKvXdbwG+/zhOJ5VyHBOTDpADB/RL/uzaO2aexVICRfh4Q+bYMReSzOd6rJS6ykHaOtt
         jKsLqZv29csSOAdRXqaoS6iH+nzXFHS97eHsflaaEOX0YC5CDRpyGMSUYCkzdQRLev9U
         p1Tg==
X-Gm-Message-State: AOJu0Yxfb91HVJ7yQcDfTEC+VYDVBeUb+cbXnHAcFqonIP56UxViy5qs
	6vtdtmQtEjGDKzY7Jq67m5XxWXVtuFLPpQCE/24RbYV1UDPMSeXqqYIWTJpqqea1vw/sPBpOX8W
	mCrpYClkROQ==
X-Received: from ywbni25.prod.google.com ([2002:a05:690c:8d19:b0:7fe:abec:8fcb])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:f01:b0:7dc:313d:afec
 with SMTP id 00721157ae682-7fe5c244953mr52082497b3.22.1781714415383; Wed, 17
 Jun 2026 09:40:15 -0700 (PDT)
Date: Wed, 17 Jun 2026 16:40:13 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260617164013.280790-1-jmoroni@google.com>
Subject: [PATCH rdma-next] RDMA/irdma: Prevent user-triggered null deref on QP create
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22326-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFEC769B6FC

Previously, the user QP creation path would only attempt to
populate iwqp->iwpbl if the user-provided req.user_wqe_bufs
field was non-zero. The problem is that iwqp->iwpbl is
unconditionally dereferenced later on in irdma_setup_virt_qp.

While there was a check for iwqp->iwpbl != NULL, this check
would only occur if req.user_wqe_bufs was non-zero. The end
result is that a user could send a zero user_wqe_bufs value
and trigger a null ptr deref.

Fix this by unconditionally calling irdma_get_pbl and bailing
if it fails, similar to the CQ and SRQ paths.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 4c0ea7c9b9..4124e4d732 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -638,17 +638,16 @@ static int irdma_setup_umode_qp(struct ib_udata *udata,
 
 	iwqp->ctx_info.qp_compl_ctx = req.user_compl_ctx;
 	iwqp->user_mode = 1;
-	if (req.user_wqe_bufs) {
-		spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
-		iwqp->iwpbl = irdma_get_pbl((unsigned long)req.user_wqe_bufs,
-					    &ucontext->qp_reg_mem_list);
-		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
-
-		if (!iwqp->iwpbl) {
-			ret = -ENODATA;
-			ibdev_dbg(&iwdev->ibdev, "VERBS: no pbl info\n");
-			return ret;
-		}
+
+	spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
+	iwqp->iwpbl = irdma_get_pbl((unsigned long)req.user_wqe_bufs,
+				    &ucontext->qp_reg_mem_list);
+	spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
+
+	if (!iwqp->iwpbl) {
+		ret = -ENODATA;
+		ibdev_dbg(&iwdev->ibdev, "VERBS: no pbl info\n");
+		return ret;
 	}
 
 	if (!ucontext->use_raw_attrs) {
-- 
2.54.0.1189.g8c84645362-goog


