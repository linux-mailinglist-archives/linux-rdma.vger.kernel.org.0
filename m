Return-Path: <linux-rdma+bounces-22383-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gBwsMnC3Nmr6DgcAu9opvQ
	(envelope-from <linux-rdma+bounces-22383-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jun 2026 17:53:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C36A926C
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jun 2026 17:53:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gbSrojJT;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22383-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22383-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AC9630137A2
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jun 2026 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A4E397AF2;
	Sat, 20 Jun 2026 15:53:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3EF331EC5
	for <linux-rdma@vger.kernel.org>; Sat, 20 Jun 2026 15:53:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970794; cv=none; b=bU+sOG8mtlYngezVn6KJmUeS+mydxjLHE2FUqNV5nSwfQ1gHc81nWghvF/+6oe9n7ZLGUYJ/hr70NumMTdyuswMfgBNaz2riXX/RDrfbBrLH25Y8u7KbKBMtYR7s9CpXNwwDtUDUE9pn9xjKY/grEGaDN4nDKduWuQjjyZmUrjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970794; c=relaxed/simple;
	bh=nUEOUJPcMM6F3ojO7jNZx+tzFDczA+xoIvOWV0cS0sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8JQrLjYhlQy6JO8H+UdLknIJ+vQz+pVoSQ88b/Gh7C3//vdAhyyo7VOL/epA1BVBHDxrR6AY26U19b8G5YORvrSTho+VyzH6+Z6VKGhs/0oL2qSPWPRQIdkCYtFgxoLfY24vsmAM6KGuXzDgS2j/STeXeXw7cqXbiL50I+Nu2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbSrojJT; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so1724215b3a.1
        for <linux-rdma@vger.kernel.org>; Sat, 20 Jun 2026 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781970792; x=1782575592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MreWZ5YlOFE+/jjPmoYRzaFL7VfpWqK9ApPBCskwOcE=;
        b=gbSrojJTO7ENL7G33ZVziN72C/F0u+Jy74tyRcEUeJmxtk8gzZTLEWdnK9FKaskjkw
         eIBrws5lTP+S6T87nkLkh1rPGpJa6MVHEyr0JhnFBGtinUZwwdTKzKtW7QYzRStQEO80
         xfvaoPsGb2Q8mQ2tnOWW0zZoohjjswRx5WaT3dWgv9yBFt72cb+scfZCyexhIUop7v2q
         VcOK3wW/xD9zUZNlzLW7wJXc8iINq+iwnQEqiStgtxtYuZjQRm/00xF3Viatu4IANRTM
         jz3yF9QJTc/VEWkTR5csBY67CfcJHH1ib4yoROIAwLBLd0bg9T98i1XFOmpIXdZD7hKH
         woXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781970792; x=1782575592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MreWZ5YlOFE+/jjPmoYRzaFL7VfpWqK9ApPBCskwOcE=;
        b=Db025g7WBZpUm4L/DQUpaiqmXzk5aE0Cotrnb2fkubKRnl+Pj4J730HxUSXLWH2G/B
         JFdNglbD9k5MLIT3j/Tkci3sPqGvcsfXB4RUOU4y0lqZB4M5tSHDgYz7O3+AsZ3hCbMx
         kabxw+GKVPIBkvVY/MDTFgXlekWsW+RyPztwOtfTUkC4bGVncyKQNJNNutxHOFMvqDUU
         UbVx9mqiIVWMoGhljmx3kFjt89UwhzhfG+waxX9uDCa8wAZOm6FidHFjhAwtUezksyqA
         GQFYc2m5wCkSfXJxjjlVhjYhdVT/TrDxXCxGM03ysFllq86q3/KxXFmWIBhGKzzCEbCf
         HT+w==
X-Gm-Message-State: AOJu0YzHINeaGqx/eBqyljHl9JIa8z8IF/9tJ4/mnQ9egao+8utiFrIY
	WLJNUC7oYDgorGtv8SBaKd0UhGbKqYkexGIGW6y46w8W8dtcZY4Jx6P9
X-Gm-Gg: AfdE7ckpqXVb30igF2+imlyniS1AHx1DqPyA5FDV72ddZUGHZAMuSMTJpCCA3q2lpcy
	+tCtXdCLsyqFssRPUk6cvTs228+ash/AXX8CD2JsqLve+rDO7nrE7StU3BbNek4JUqfpRkK/CrJ
	yLB1RqfUt71cWTWw1wUjChuDQM+PNlll42nC8X7yp2mm2kikYdmlGO8MjW28z1F1RXqOo00njQc
	yagPMe9BNI+BFT/5Q7PS2smgN9Y+cys/aAeM3DccAiPktYUJmNizmYXXp7+CkBXoTqBR1iou9d7
	dLSpeMCy1VWNYEbMujd4peV2qBdtrsmF+LIjOS4nsQDw/TzD29BL99vvHOgyetbue78AWmbTaFW
	yCGSjS0LqVJwrzjn76yivevL28XY5ku0J6KC+FL3TY5fZgUFGlAKpdCyKibRr8hx+hsdhKDKmpx
	glrFlrwi65zkW+pz78F3Vby6ZL/wfw5g3i
X-Received: by 2002:a05:6a00:94f6:b0:842:5a8d:3036 with SMTP id d2e1a72fcca58-845508aeb2dmr8960456b3a.35.1781970792330;
        Sat, 20 Jun 2026 08:53:12 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:8e0e:956e:b09c:23cd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d8cd9csm2489413b3a.21.2026.06.20.08.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 08:53:12 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Bernard Metzler <bernard.metzler@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] RDMA/siw: publish QP after initialization
Date: Sat, 20 Jun 2026 23:53:06 +0800
Message-ID: <20260620155306.78919-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-22383-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bernard.metzler@linux.dev,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A9C36A926C

siw_create_qp() allocates a QP number before the queues, CQ pointers,
state, completion, and device list entry are ready. A QPN lookup can
therefore reach a QP that is still being constructed if the object is
published at allocation time.

Reserve the QPN with an empty XArray entry first. Publish the QP object
only after the kernel-visible QP state is initialized and just before
siw_create_qp() returns it to the caller.

Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/infiniband/sw/siw/siw.h       |  1 +
 drivers/infiniband/sw/siw/siw_qp.c    | 26 ++++++++++++++++++--------
 drivers/infiniband/sw/siw/siw_verbs.c | 12 +++++++++++-
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index f5fd71717b80..ade7c96135c2 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -511,6 +511,7 @@ void siw_send_terminate(struct siw_qp *qp);
 void siw_qp_get_ref(struct ib_qp *qp);
 void siw_qp_put_ref(struct ib_qp *qp);
 int siw_qp_add(struct siw_device *sdev, struct siw_qp *qp);
+int siw_qp_publish(struct siw_qp *qp);
 void siw_free_qp(struct kref *ref);
 
 void siw_init_terminate(struct siw_qp *qp, enum term_elayer layer,
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index bb780e3904a2..1a9135d9a2a7 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -1281,15 +1281,25 @@ void siw_rq_flush(struct siw_qp *qp)
 
 int siw_qp_add(struct siw_device *sdev, struct siw_qp *qp)
 {
-	int rv = xa_alloc(&sdev->qp_xa, &qp->base_qp.qp_num, qp, xa_limit_32b,
-			  GFP_KERNEL);
+	qp->sdev = sdev;
 
-	if (!rv) {
-		kref_init(&qp->ref);
-		qp->sdev = sdev;
-		siw_dbg_qp(qp, "new QP\n");
-	}
-	return rv;
+	return xa_alloc(&sdev->qp_xa, &qp->base_qp.qp_num, NULL,
+			xa_limit_32b, GFP_KERNEL);
+}
+
+int siw_qp_publish(struct siw_qp *qp)
+{
+	void *old;
+
+	kref_init(&qp->ref);
+
+	old = xa_store(&qp->sdev->qp_xa, qp_id(qp), qp, GFP_KERNEL);
+	if (xa_is_err(old))
+		return xa_err(old);
+
+	siw_dbg_qp(qp, "new QP\n");
+
+	return 0;
 }
 
 void siw_free_qp(struct kref *ref)
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 1e1d262a4ae2..71bc0cc59e3d 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -482,14 +482,24 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 		goto err_out_xa;
 	}
 	INIT_LIST_HEAD(&qp->devq);
+	init_completion(&qp->qp_free);
+
 	spin_lock_irqsave(&sdev->lock, flags);
 	list_add_tail(&qp->devq, &sdev->qp_list);
 	spin_unlock_irqrestore(&sdev->lock, flags);
 
-	init_completion(&qp->qp_free);
+	rv = siw_qp_publish(qp);
+	if (rv)
+		goto err_out_list;
 
 	return 0;
 
+err_out_list:
+	spin_lock_irqsave(&sdev->lock, flags);
+	list_del(&qp->devq);
+	spin_unlock_irqrestore(&sdev->lock, flags);
+
+	siw_put_tx_cpu(qp->tx_cpu);
 err_out_xa:
 	xa_erase(&sdev->qp_xa, qp_id(qp));
 	if (uctx) {

