Return-Path: <linux-rdma+bounces-22577-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JHFNJpRbQ2rdXAoAu9opvQ
	(envelope-from <linux-rdma+bounces-22577-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 08:00:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E50716E08E2
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 08:00:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=piXO5mcB;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22577-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22577-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C286B300D941
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 06:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC948548EE;
	Tue, 30 Jun 2026 06:00:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C740D56D
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 06:00:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799247; cv=none; b=IJKeXocaPqFMHhIJs6EAi9EI1siu4hpJ5YkJuKPrC/QKb/sVMib+9kCjLKmYggymos83zC/VlIYZ7xjlCFnr3cQ4Qgv5l8SIrrel461u+z3kxgAOnAHHvwvJyzpq7v2zdSxuUCOJy0sRYsbwvBLX/WroQf9zuhcZhsFLvvshnKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799247; c=relaxed/simple;
	bh=C3a1uuIZmSQ8ER44ipUBv95Jspkk36dOUXVOrhiYPNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ix2B0uMIbjiNq53oeeakBPbx9wjz9/JWNKE2PdeJ2K2787sI8HiYg81qlhQKP43T7T2rwns8Xdvfc5I7bEdUUHqXeIPzYVCBcNB7/D8gE3+YpY6IrQA6ZN/canjCbA9z6bENH8ZJCx+V6OsfCUrhU6Tr8vUj8NiyQVxLJXB9fDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=piXO5mcB; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-846970f0acaso1571587b3a.3
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2026 23:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782799245; x=1783404045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x2WnmB43eNouYPrpSpods0e3jWSS1paq4XSGWlb6g4w=;
        b=piXO5mcB0n9ooF9kGeIrmd9b8l8asUoe3L9BKsc2YYk4iRedsXccVZF3eqoIapbzWi
         6c6gcOiY5cjN9WCWCX24jXkGG3Airqlj/FtFkarDPWyarB30dm0qk37H/lwYWPTUt0fG
         zOCO8kMtQOnhnEmDxrmbdF5dcNwpzRJhvy5aervDQYZ423GQcNqaV93fwJxjbfzylMVh
         5kz1SpvEaureUNxJeWMMc4vjcG61Oev2EIwAt8dOrvU7WntOXsO7rddYUEwyIFrKgGQC
         HqaQ/mXePotKwPs5MInr2bbeX6rcjodSyOJjMjZp5ioo22iAFMHlP1v6Qwgf5BHifNbL
         Q/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782799245; x=1783404045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2WnmB43eNouYPrpSpods0e3jWSS1paq4XSGWlb6g4w=;
        b=pz0BQ4WAv/SZ189CYS0GVX1pwgea+TLbnqPup5cbrP/GJowbWMd1zlr7p0jhr/tTF9
         OyMLbV8w+0KuFYTzwsbjzb8TQi2PM9oIsGSdtw2/ZdVl/FHYZurIWXVfosU7dHgCP3bU
         DdwChnMVuhQ7yAlQtT7/kSpXdcGlAmT4Rbjmnr0ZH1xLQGQBLqcNO7MGQl0djBDdocnY
         mhO4oyz4tgOGcQMvIfPaxuFxOemHd1HS0pxxJzEKQYBGWq55HvENfrMmTaW0glrzMhrl
         LJApvUJ84rYMLx1648Lkl+gmI7e+1Js55d732tQ5U6Z4WdwiXFSqLlcwuhPSCSHFHnmP
         WqZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqoRk4Z8H+uk5ab/jvBJFTwfoGSTbZEShXkZjTvpucieptupuTWdZRNrVHVjfap5DUdKxE1l7frRpbM@vger.kernel.org
X-Gm-Message-State: AOJu0YzWMi9BjD98qhu9N38eViRTY5isGvXTqB3BVOHyg+kayTQSg+4a
	n+2s/cRl18Mm6v9u0y6Dbdi6ov/yLjIIoPlsFcN8oAuA0Gu8t0rb/acfe/zTvkmzlI8=
X-Gm-Gg: AfdE7clDLiFDJKo0KoDbcDK/KFnkfvCclr99ncO/0euPgNegHaU8QRykCIzqqAQ9MG+
	BjcfEAMwpmz9uL+ekHtlBVA07Dv+34Fz8tvsACGXQz0fRj42x8guJD7knlEMfqY+4ezKzl/Uxy7
	Ern6nh99KkUomqin/K4d22Xtd+DRkSyDCq6iqV6LtitSkZYGPTbu4QpxM2QylmoMvVDd92ts4PW
	Fiibla6Lyvp84yknzIwvAlhGg3KxVMfTT6R+bkoDBYSokIFmp+WxCWzNu0yOjtBxeg4eTxCwuLT
	+kbwC4/zsmmdsXgO83AvKSz30E9ThbnApXTAfZsdghdTGbm15yqsbdsN2tr5BsTBiclk5c2kEtI
	ZpqaCQsGfJ8Xo9YJLu1YKUM9AbEQm1fug05MYtHqg8aY7hFYXE1rNx36x9pl5Q+FOExUKUUF/X3
	wd2omDl4LuYqV7StQQIIK+Q7q0XlbJJn2s
X-Received: by 2002:a05:6a00:4143:b0:846:8b21:6304 with SMTP id d2e1a72fcca58-8479f118f9bmr1954287b3a.14.1782799245397;
        Mon, 29 Jun 2026 23:00:45 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:1d46:59be:9028:62d2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a03a6fd5sm1095685b3a.57.2026.06.29.23.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:00:44 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Bernard Metzler <bernard.metzler@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH v4] RDMA/siw: publish QP after initialization
Date: Tue, 30 Jun 2026 14:00:40 +0800
Message-ID: <20260630060040.966461-1-ruoyuw560@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-22577-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E50716E08E2

siw_create_qp() currently calls siw_qp_add() before the queues, CQ
pointers, state, completion, and device list entry are ready. A QPN
lookup can therefore reach a QP that is still being constructed.

Move siw_qp_add() to the end of siw_create_qp(), after QP
initialization and before adding the QP to the siw device list.

Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
Suggested-by: Bernard Metzler <bernard.metzler@linux.dev>
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
Changes in v4:
- Move `if (udata->outlen < sizeof(uresp))` into the second `if (udata)`
  clause, right before ib_copy_to_udata() (Bernard Metzler).
- Move INIT_LIST_HEAD(&qp->devq) to just before spin_lock_irqsave(),
  close to list_add_tail() where it logically belongs (Bernard Metzler).

Changes in v3:
- Move siw_qp_add()/xa_alloc() to the end of siw_create_qp().
- Drop the QPN reservation helper from v2.

 drivers/infiniband/sw/siw/siw_verbs.c | 57 ++++++++++++++++----------
 1 file changed, 35 insertions(+), 22 deletions(-)

--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -316,6 +316,7 @@
 	struct siw_ucontext *uctx =
 		rdma_udata_to_drv_context(udata, struct siw_ucontext,
 					  base_ucontext);
+	struct siw_uresp_create_qp uresp = {};
 	unsigned long flags;
 	int num_sqe, num_rqe, rv = 0;
 	size_t length;
@@ -369,11 +370,6 @@
 	spin_lock_init(&qp->rq_lock);
 	spin_lock_init(&qp->orq_lock);
 
-	rv = siw_qp_add(sdev, qp);
-	if (rv)
-		goto err_atomic;
-
-
 	/* All queue indices are derived from modulo operations
 	 * on a free running 'get' (consumer) and 'put' (producer)
 	 * unsigned counter. Having queue sizes at power of two
@@ -391,14 +387,14 @@
 
 	if (qp->sendq == NULL) {
 		rv = -ENOMEM;
-		goto err_out_xa;
+		goto err_out;
 	}
 	if (attrs->sq_sig_type != IB_SIGNAL_REQ_WR) {
 		if (attrs->sq_sig_type == IB_SIGNAL_ALL_WR)
 			qp->attrs.flags |= SIW_SIGNAL_ALL_WR;
 		else {
 			rv = -EINVAL;
-			goto err_out_xa;
+			goto err_out;
 		}
 	}
 	qp->pd = pd;
@@ -424,7 +420,7 @@
 
 		if (qp->recvq == NULL) {
 			rv = -ENOMEM;
-			goto err_out_xa;
+			goto err_out;
 		}
 		qp->attrs.rq_size = num_rqe;
 	}
@@ -439,11 +435,8 @@
 	qp->attrs.state = SIW_QP_STATE_IDLE;
 
 	if (udata) {
-		struct siw_uresp_create_qp uresp = {};
-
 		uresp.num_sqe = num_sqe;
 		uresp.num_rqe = num_rqe;
-		uresp.qp_id = qp_id(qp);
 
 		if (qp->sendq) {
 			length = num_sqe * sizeof(struct siw_sqe);
@@ -452,7 +445,7 @@
 						      length, &uresp.sq_key);
 			if (!qp->sq_entry) {
 				rv = -ENOMEM;
-				goto err_out_xa;
+				goto err_out;
 			}
 		}
 
@@ -464,9 +457,23 @@
 			if (!qp->rq_entry) {
 				uresp.sq_key = SIW_INVAL_UOBJ_KEY;
 				rv = -ENOMEM;
-				goto err_out_xa;
+				goto err_out;
 			}
 		}
+	}
+	qp->tx_cpu = siw_get_tx_cpu(sdev);
+	if (qp->tx_cpu < 0) {
+		rv = -EINVAL;
+		goto err_out;
+	}
+	init_completion(&qp->qp_free);
+
+	rv = siw_qp_add(sdev, qp);
+	if (rv)
+		goto err_out_tx;
+
+	if (udata) {
+		uresp.qp_id = qp_id(qp);
 
 		if (udata->outlen < sizeof(uresp)) {
 			rv = -EINVAL;
@@ -476,22 +483,19 @@
 		if (rv)
 			goto err_out_xa;
 	}
-	qp->tx_cpu = siw_get_tx_cpu(sdev);
-	if (qp->tx_cpu < 0) {
-		rv = -EINVAL;
-		goto err_out_xa;
-	}
+
 	INIT_LIST_HEAD(&qp->devq);
 	spin_lock_irqsave(&sdev->lock, flags);
 	list_add_tail(&qp->devq, &sdev->qp_list);
 	spin_unlock_irqrestore(&sdev->lock, flags);
 
-	init_completion(&qp->qp_free);
-
 	return 0;
 
 err_out_xa:
 	xa_erase(&sdev->qp_xa, qp_id(qp));
+err_out_tx:
+	siw_put_tx_cpu(qp->tx_cpu);
+err_out:
 	if (uctx) {
 		rdma_user_mmap_entry_remove(qp->sq_entry);
 		rdma_user_mmap_entry_remove(qp->rq_entry);

-- 
2.51.0

