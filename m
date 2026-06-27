Return-Path: <linux-rdma+bounces-22510-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Oz/WI/jgP2rrZwkAu9opvQ
	(envelope-from <linux-rdma+bounces-22510-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 16:40:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF426D21AB
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 16:40:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=o4I5KaMp;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22510-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22510-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C1E23012264
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEF93AEF43;
	Sat, 27 Jun 2026 14:40:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96CD3A7194
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 14:40:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571251; cv=none; b=ZTDt+HTzrMcut9AoNHjeN9IKxCE1A7UJZzG+6B6t7KfyZRams2fQdsQu9N5nQyBS2kBRrWtWFhos/uq6K+PCxugYK0G/FpOVUgNHjiMg9teGXQLSpPjz1k4HfidBCSleGP8vsalPcLTa7kcdt9v3fWmH9Cz/2jCRad4uuEMEjK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571251; c=relaxed/simple;
	bh=kkKrKlylRitcuuIhwiFd3qB3C4dqDOM9cWAQyIgwSDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJlNt1B3v6thyNMPbSRX69/mQtdpDhpiWvhRq07R96S+BNAUDGpZHmKxZ3d8kt51jmzbcV14zJkiHOhqDIv4gAmyV0ACyc5etrAWyGiQZOAptErB/+Ie+qzIF+WvPu0mSR0H95OZdFkJEpz0XRCv1Bx5+xzReOyrd8UA/U7JTvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4I5KaMp; arc=none smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8584e80d59so847614a12.2
        for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782571249; x=1783176049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h4pw/eKWNE8b6ED8RoStvS1xnksY43TVFgRlNG9amCA=;
        b=o4I5KaMpqdSHnoTAU4MpRu9XVAxZdrS235SlzoQECYjFKVdVsiErqigo84tTPo297E
         Zzxh5tEJWau5ZIuqyqgRSYluzJmR/ydZu1NAxD376pEycRjWEYplbf4CkKwq1/URwNj9
         4wzskuJwvnBgPhtWcU8Id9Gr7P+OPt8NBjYk355boEiOqHOkd3QqeDC+oGqiaVhPH0TR
         4Plwsi4Wo9cJ1sNzpa+PxUnnwZAJQ1eMASqws5l28XpHf8WIqWYl6lCXstjHRWGpposu
         aBQoyo32Gby3Jqw/K+kXSNAiiqLETkPYKW36wX1UeiyEgYvj/SiIxD+qC3BjIzfK4L4l
         FbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782571249; x=1783176049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4pw/eKWNE8b6ED8RoStvS1xnksY43TVFgRlNG9amCA=;
        b=Bpk1dT4yK3RfflRcTyDZfImPTcSYZpyRRDTJZkVdcyIR6jyrL/h5Y/5x/nCXswB1aG
         rFXwDcl7/g8rA2w+1SIArMsErD505KSET1ki4x8M4IVe8qC4jZGBkPHQ8ekW+P6Q1EmN
         hJ3JxVEm5FS+EFr3WX892VLP6jaZ9k/TdXHjAfXEcsTKuHqokJ5AW67UkFm/o+nX8Nd0
         ZixK/f7Oag3p3VlKR5l1rEOigm+1bNwjhcfZ/qyc0mvS2EDNm2XP+A2ErSmSxt7XuDtn
         swxW/DRiqmnOLEt4lAmctY61r+RseCsgBnk+Hy3BAiX5fQujRML4MCl29vtOmKcZYDtj
         3fyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hhjmpmQYDSuLMZiOCl+6ficbnjIM64OR5iszPRfvKoFO86J7S+qnTyuE/lKwpIqLriEf66TXZ/2si@vger.kernel.org
X-Gm-Message-State: AOJu0YwybAR5SKMLagHPxWpYcNYGj4Lgjl+PxVSEzfKVRh4aGTlTEL2P
	6iNNwUnpxSxy4gnbZpG10um7QTJLCqybz62UjmArh2ywmTQw11E4v6Fl
X-Gm-Gg: AfdE7cmR4PxGVl9jqR5vP9tBfCR2bn+bADxvlHmAnUfNSWnIdHlI3boOMldq5WwlcKb
	lFGHxb3BzH0azohPa56YaF1nPd3ozP0P5aiaP0aSQY394eibPAfQiYU8bUtZAjDFLyBcsDPZKwG
	z1ksRKRV3+muP+JMrfvQumiEIRmGyfb7Y8b7QYSHyFbfI3Jfq9LrNXLbRT+9BVg3q+DTmLkRQod
	3N9UzLragIVldzZ6ZiXVMkS8HapZnlzoEAasH0L012LSpS/SloYX5L8pIE2TNlnn+YnOxy4/snw
	acw/xOvhI5RivKQq8tT6l07Nr3wZ4Eei2I46LJ8v5m6SYGkWBowzkWpi9C0MH4I1PGUswufUmAm
	hf1SLptAu4cy/xGj5+x5o5AXZEl5F/XlMTrQ3r6QvLiY6VVKhMFROOVBNDbtXqUiegMV8k67pk2
	nseW9SYHAYIPAazOdoIFnZDN7cO2QhCWg=
X-Received: by 2002:a05:6a20:4327:b0:3bc:5284:4859 with SMTP id adf61e73a8af0-3bd4ad4809amr11564442637.13.1782571249185;
        Sat, 27 Jun 2026 07:40:49 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:6375:bc2e:f11b:4e0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b9eb8a30sm5286604a12.10.2026.06.27.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 07:40:48 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Bernard Metzler <bernard.metzler@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH v3] RDMA/siw: publish QP after initialization
Date: Sat, 27 Jun 2026 22:40:39 +0800
Message-ID: <20260627144039.3109422-1-ruoyuw560@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-22510-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFF426D21AB

siw_create_qp() currently calls siw_qp_add() before the queues, CQ
pointers, state, completion, and device list entry are ready. A QPN
lookup can therefore reach a QP that is still being constructed.

Move siw_qp_add() to the end of siw_create_qp(), after QP
initialization and before adding the QP to the siw device list.

Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
Suggested-by: Bernard Metzler <bernard.metzler@linux.dev>
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
Changes in v3:
- Move siw_qp_add()/xa_alloc() to the end of siw_create_qp().
- Drop the QPN reservation helper from v2.

 drivers/infiniband/sw/siw/siw_verbs.c | 45 +++++++++++++++------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 1e1d262a4ae2..ee3e5529d6f4 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -316,6 +316,7 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	struct siw_ucontext *uctx =
 		rdma_udata_to_drv_context(udata, struct siw_ucontext,
 					  base_ucontext);
+	struct siw_uresp_create_qp uresp = {};
 	unsigned long flags;
 	int num_sqe, num_rqe, rv = 0;
 	size_t length;
@@ -369,11 +370,6 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
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
@@ -391,14 +387,14 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 
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
@@ -424,7 +420,7 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 
 		if (qp->recvq == NULL) {
 			rv = -ENOMEM;
-			goto err_out_xa;
+			goto err_out;
 		}
 		qp->attrs.rq_size = num_rqe;
 	}
@@ -439,11 +435,8 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	qp->attrs.state = SIW_QP_STATE_IDLE;
 
 	if (udata) {
-		struct siw_uresp_create_qp uresp = {};
-
 		uresp.num_sqe = num_sqe;
 		uresp.num_rqe = num_rqe;
-		uresp.qp_id = qp_id(qp);
 
 		if (qp->sendq) {
 			length = num_sqe * sizeof(struct siw_sqe);
@@ -452,7 +445,7 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 						      length, &uresp.sq_key);
 			if (!qp->sq_entry) {
 				rv = -ENOMEM;
-				goto err_out_xa;
+				goto err_out;
 			}
 		}
 
@@ -464,34 +457,46 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 			if (!qp->rq_entry) {
 				uresp.sq_key = SIW_INVAL_UOBJ_KEY;
 				rv = -ENOMEM;
-				goto err_out_xa;
+				goto err_out;
 			}
 		}
 
 		if (udata->outlen < sizeof(uresp)) {
 			rv = -EINVAL;
-			goto err_out_xa;
+			goto err_out;
 		}
-		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
-		if (rv)
-			goto err_out_xa;
 	}
 	qp->tx_cpu = siw_get_tx_cpu(sdev);
 	if (qp->tx_cpu < 0) {
 		rv = -EINVAL;
-		goto err_out_xa;
+		goto err_out;
 	}
 	INIT_LIST_HEAD(&qp->devq);
+	init_completion(&qp->qp_free);
+
+	rv = siw_qp_add(sdev, qp);
+	if (rv)
+		goto err_out_tx;
+
+	if (udata) {
+		uresp.qp_id = qp_id(qp);
+
+		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		if (rv)
+			goto err_out_xa;
+	}
+
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


