Return-Path: <linux-rdma+bounces-22472-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CmX7MvswPWrvyggAu9opvQ
	(envelope-from <linux-rdma+bounces-22472-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 15:45:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF456C63C0
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 15:45:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Gepoy817;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22472-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22472-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD9B63023DF5
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD78339853;
	Thu, 25 Jun 2026 13:44:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B57D3264E5
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jun 2026 13:44:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395079; cv=none; b=hBAYklf6MgDVQKGOZa6vH1hx250RR3p7B3+x99EIVnNyDn4ZwjBZOHvPpXOF/IDdXhH7hlukR/gKnwzA+3v5Q8Ba7e8e4/lacbFO6HkH0m/5EHFlyDheNQhM7VlbOxh3OqKA5kX5pYHXoyfvWYNNFlO3k/hbK1H+lb9+wfE4Sdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395079; c=relaxed/simple;
	bh=DKP4p+F1gbMZPOryRL81pPG491H/HsqC3RvfauC/hJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djfHGuuABsbzE4+H53h2/6FXcxJPqu9cNH4Pz/lVESLE+XbCAEORWvm9lpc3LeDHcAlaj3DncP0qhfCmprNDYCxVglPxhSkfVmt96WKkxWo3/fEYRDVre3Hf35Jg618dJ+j9deWvoScdNlSKv/8C2+D+31ICGW6baiPjueLcM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gepoy817; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37d7c265ca5so1813061a91.2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jun 2026 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782395077; x=1782999877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/3iI6+GQ7Nx6Y3HeWNjB9zYGFeER3TxI8ACBQoDMKU=;
        b=Gepoy817kEjEH+MOErlfTPzJvfImeiMxNp3WxqDeFFydyaGT5UigtRWuJwm5K8OCVf
         I/EvYZWuhjGJp74Uz4kgW1Cz47lO0uDGT8WqAOUwjLJsm4wUF4kHmXXlgcNJiZSBJNYQ
         PC8ANYtxgU5Hi75ENDiCWRzPXmhHkMjQKnMFzx+k6VC4f1vF6fUCkzJLUIwPWG30C5sz
         n4JFOTMvQXIb5xFZdrxFRll9r5S4plKa/GuojFihuw878SmINzpSW+27YadOk+2k7v1r
         Q17Q/PQmaG3hGkhtha1TWddO4ZczlK48ULLmYv4m6Fq2ad6cHQmpCIGnRhhwZu5uRLaH
         fYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395077; x=1782999877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/3iI6+GQ7Nx6Y3HeWNjB9zYGFeER3TxI8ACBQoDMKU=;
        b=qVJ3jyhK+0qXsnxtYiR1QiyTAwE3IHhZ1bal2G4bBCODSAv78XSniLZqzaIenyFfs9
         0I+sFhMZpazLnYXT3bPiSxki4HhMNTGfTzmOZOt0OJNbHIz9SShLVQezY7QygghwEMQl
         PguWTs8bve3b4bXAQoL3ihZm6jEh1vblqqPDV5WQ5qhqPgZ/kBKGvBL1CNTHkTz0UiZK
         s6t037bWKCaY7U6tpBCzxkzmhxieh6ryZHyDiJ+nAPM3DCemVZLLb5QRL4nTX2xTA9SX
         HIVGtx6Sv0eQUAa2rHQttw4bVXWlppsjNcokm08hYLntbqCsNa5dzbJv1+bGRSxLlveM
         yfKg==
X-Forwarded-Encrypted: i=1; AHgh+Rp/n6ZGo/wnnXme+aERACL/fnQh3c5UirogUl8yYAKr8A6uzH+IGKaiG3snXJDGLFCVhD3FBF9TVlwD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz717Tv/4Wg2uoHu0sFHmz0zP0G/RCd1efgMkBlTVSRwpkxcLb
	w1M0FUzOBooxOnm+XtC1rXzR/e4ZtmyPtVPho3vGo8+HWOZ8F063+Mio
X-Gm-Gg: AfdE7cn9xmoM4pdDEADBwftsddZ5qVIbPakhxldeJlJFbmK/b8DPYHRHDRIXEhNzoCQ
	9aSXJTQST2LUzY4JwAp36tg1z9iP98Nw0/IV3aO/C2742D3vlsXwk/0S+qmsPvfwN2NDZKG7Wj7
	uW+h0lcyJ5sFbuMIDDs47HGlnPaLRqZqDRtOXLaAK1PInQMfuLLnDOf2U2XRwFFNd9yYuzKUJrZ
	Amy7cYbrwZvtv9LMiqzsaIAcdZUEKbHSdoJivSkz1cU1o6RbYBOh1ChHysLsrFs/X5guXhYMMli
	IhTNrTCNBQWNKd3JrOpkgH/b9xFxwCcUkF/jJiq4HLVsNUkMCoZUhVrJfI4kaU9GbVw0Oe8WrxY
	BBCMz6WeKdREm97Qa7SDAjy9LhzeWPvnMlbAYmz/mOc+7SeGlQ1s8oB5aU5k8aQieecprecAzku
	UzhPyISDTGAPWPR6HHrhFVVoDaxp0YG7o=
X-Received: by 2002:a17:90b:28cc:b0:37e:a09:2432 with SMTP id 98e67ed59e1d1-37e0a0936b9mr240729a91.4.1782395077313;
        Thu, 25 Jun 2026 06:44:37 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:839d:ff7d:8c1:eb6d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df757696asm710486a91.2.2026.06.25.06.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 06:44:35 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Bernard Metzler <bernard.metzler@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH v2] RDMA/siw: publish QP after initialization
Date: Thu, 25 Jun 2026 21:44:26 +0800
Message-ID: <20260625134426.3084850-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620155306.78919-1-ruoyuw560@gmail.com>
References: <20260620155306.78919-1-ruoyuw560@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-22472-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FF456C63C0

siw_create_qp() currently calls siw_qp_add() before the queues, CQ
pointers, state, completion, and device list entry are ready. A QPN
lookup can therefore reach a QP that is still being constructed.

Move the siw_qp_add() publication step to the end of siw_create_qp(),
after the kernel-visible QP state is initialized. The QPN must still be
known before copying the siw-specific create response to userspace, so
reserve the QPN first with an empty XArray entry. This lets
siw_create_qp() report the QPN while QPN lookups still return NULL until
the QP is published.

Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
Suggested-by: Bernard Metzler <bernard.metzler@linux.dev>
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
Changes in v2:
- Move the siw_qp_add() publication step to the end of siw_create_qp().
- Add siw_qp_reserve_qpn() so the udata response can still report qp_num
  before the QP becomes visible to QPN lookups.

 drivers/infiniband/sw/siw/siw.h       |  1 +
 drivers/infiniband/sw/siw/siw_qp.c    | 26 ++++++++++++++++++--------
 drivers/infiniband/sw/siw/siw_verbs.c | 14 ++++++++++++--
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index f5fd71717b80..f8d28dd7dd86 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -510,6 +510,7 @@ void siw_send_terminate(struct siw_qp *qp);
 
 void siw_qp_get_ref(struct ib_qp *qp);
 void siw_qp_put_ref(struct ib_qp *qp);
+int siw_qp_reserve_qpn(struct siw_device *sdev, struct siw_qp *qp);
 int siw_qp_add(struct siw_device *sdev, struct siw_qp *qp);
 void siw_free_qp(struct kref *ref);
 
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index bb780e3904a2..7d6224ebfe71 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -1279,17 +1279,27 @@ void siw_rq_flush(struct siw_qp *qp)
 	}
 }
 
+int siw_qp_reserve_qpn(struct siw_device *sdev, struct siw_qp *qp)
+{
+	qp->sdev = sdev;
+
+	return xa_alloc(&sdev->qp_xa, &qp->base_qp.qp_num, NULL,
+			xa_limit_32b, GFP_KERNEL);
+}
+
 int siw_qp_add(struct siw_device *sdev, struct siw_qp *qp)
 {
-	int rv = xa_alloc(&sdev->qp_xa, &qp->base_qp.qp_num, qp, xa_limit_32b,
-			  GFP_KERNEL);
+	void *old;
 
-	if (!rv) {
-		kref_init(&qp->ref);
-		qp->sdev = sdev;
-		siw_dbg_qp(qp, "new QP\n");
-	}
-	return rv;
+	kref_init(&qp->ref);
+
+	old = xa_store(&sdev->qp_xa, qp_id(qp), qp, GFP_KERNEL);
+	if (xa_is_err(old))
+		return xa_err(old);
+
+	siw_dbg_qp(qp, "new QP\n");
+
+	return 0;
 }
 
 void siw_free_qp(struct kref *ref)
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 1e1d262a4ae2..ef9fa9c5bf88 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -369,7 +369,7 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	spin_lock_init(&qp->rq_lock);
 	spin_lock_init(&qp->orq_lock);
 
-	rv = siw_qp_add(sdev, qp);
+	rv = siw_qp_reserve_qpn(sdev, qp);
 	if (rv)
 		goto err_atomic;
 
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
+	rv = siw_qp_add(sdev, qp);
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

