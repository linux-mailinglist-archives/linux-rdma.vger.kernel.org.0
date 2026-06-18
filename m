Return-Path: <linux-rdma+bounces-22363-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2dOEFvtRNGofUwYAu9opvQ
	(envelope-from <linux-rdma+bounces-22363-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 22:15:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B946A27AF
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 22:15:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=VQBgCBA7;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22363-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22363-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C575307DE03
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 20:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2123128D7;
	Thu, 18 Jun 2026 20:15:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADD71C84D0
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 20:15:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813719; cv=none; b=huiQS/8AnXQUDzd9OglhZ7MSEzoKoGEw9VvhdMeXXvE0JFDAUaSE+xd9mEwVHIHASRxncFL0zJ55/vMyUt8TB/E3WHKM32oFJFGcOEt6yBuDt1fSAd0Y7DSyyQXFnuJP3ZMC0sNHkgUhBpW2wiRKfOy0F9oGfCRhW/PMykYJLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813719; c=relaxed/simple;
	bh=VcY216MY2PM239fmIeqP7i0uSwnAKPRTbfXISlV7smk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UvLq6s8W9lM6DgwQk1CSM01Dm27/HbP3dWb86kMf0jnpAx9KjOpDQ357tf6hH4lZUUyavHQBHP2SDdkyPwAmGlmaEVFj0oyZAB3wpGheu3VH4t4+KJdcIJpjdssQ7VmLTDJaa0x/vNr1d9H+YG/dvXazSF3lZ8O9fzyqhO2aZx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VQBgCBA7; arc=none smtp.client-ip=209.85.222.201
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-9157d38ab37so155496385a.1
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 13:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781813717; x=1782418517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Gly//JLUikxGXTo5fGIC2wUomADwwmr69KkHo0pAxw=;
        b=VQBgCBA7vs6wnJYxuJn7dpNepuLACaKQsJj7oP7OM2OYve9bfctLTQCpDodb+Q7nLw
         xYyaiwZRuVTPhVjaP0WeLSe0k/4LATroeenSST3CNvl6bktctGvqHbtZ5ppTc5TCR5k3
         /v8EibBo5dG/EBsak6GCUMpkq7gF5Bq4UZf916Ju6973nkbabnfjyLZsOxEVU/8vac3l
         bd0jw0JvYql+N4rFCblRyPbTW77nr61b1hr4myIkiplIq+72gQhmDPFhYSJz80STGk6c
         xEaZfdoj3PSR0weR8DhGknLBQry9RMC/YFLcq3cERva6F+D0RMZnyqyfebdAg8ZhBqPb
         9f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781813717; x=1782418517;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Gly//JLUikxGXTo5fGIC2wUomADwwmr69KkHo0pAxw=;
        b=ZXW5twJ1PKsYdf/9f/0h36mrCPvHFhnKjxQAKV1oaMP4KE4gOXQ2O75kucf2qG/T/B
         Zgp2mM3JNdnGqPtGfNAUYZmt+66XFMM6ddMtRxYMaYYQUdw/U+MdspZElj0rtkFGO3Mm
         QQxiiOzz117PP9wdiCEzsG8czbbvpOvT5+ivZ6js74IIIOGHhZwR8VqdMG1679UuJveS
         5fRsUG+R3yrGMxgewadDxtB/DpNBKZ/TN7EPV1nQ9KLRLWeLFFCUb8ddnJa63h3hUlxt
         K6gUk1RG8I4aOd4b5MYM9prjpm21xrrD/wDVSPefpfeZhlaM5/dCXD1qt6DvWxXWgU21
         KY9g==
X-Gm-Message-State: AOJu0YzImYC8mu5bqnsKtf8Ao05xHwKqNpAJsVfk02rAFeME0+f3Thxv
	+bHuxis/7ui1ParfTTSxLuZ7fLRqaMjqE2d0p8NIzq+//8AiFaXEfj6BKlYo6CxWjEA6qZZkeIP
	30bS9/u7ajA==
X-Received: from qkaz24.prod.google.com ([2002:a05:620a:a318:b0:920:a9b0:6417])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:f0f:b0:915:bf79:3e0c
 with SMTP id af79cd13be357-9208a9bd58emr106310385a.4.1781813715589; Thu, 18
 Jun 2026 13:15:15 -0700 (PDT)
Date: Thu, 18 Jun 2026 20:14:58 +0000
In-Reply-To: <20260618201458.875740-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618201458.875740-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618201458.875740-5-jmoroni@google.com>
Subject: [PATCH rdma-next 4/4] RDMA/irdma: Add refcounting to user ring MRs
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-22363-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2B946A27AF

Prevent userspace from deregistering the MRs that back QP/CQ/SRQ rings
by bumping the MR's refcount upon association.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/utils.c |  6 ++++
 drivers/infiniband/hw/irdma/verbs.c | 45 +++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index e4037d5ef..290ad02ed 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -1168,6 +1168,12 @@ void irdma_free_qp_rsrc(struct irdma_qp *iwqp)
 	iwqp->kqp.dma_mem.va = NULL;
 	kfree(iwqp->kqp.sq_wrid_mem);
 	kfree(iwqp->kqp.rq_wrid_mem);
+
+	if (iwqp->user_mode && iwqp->iwpbl) {
+		struct irdma_mr *iwmr = iwqp->iwpbl->iwmr;
+
+		refcount_dec(&iwmr->user_ring_refs);
+	}
 }
 
 /**
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index dccecff3c..70201e1e2 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -464,6 +464,9 @@ static struct irdma_pbl *irdma_get_pbl(unsigned long va,
 
 	list_for_each_entry (iwpbl, pbl_list, list) {
 		if (iwpbl->user_base == va) {
+			struct irdma_mr *iwmr = iwpbl->iwmr;
+
+			refcount_inc(&iwmr->user_ring_refs);
 			list_del(&iwpbl->list);
 			iwpbl->on_list = false;
 			return iwpbl;
@@ -1881,6 +1884,11 @@ static void irdma_srq_free_rsrc(struct irdma_pci_f *rf, struct irdma_srq *iwsrq)
 		dma_free_coherent(rf->sc_dev.hw->device, iwsrq->kmem.size,
 				  iwsrq->kmem.va, iwsrq->kmem.pa);
 		iwsrq->kmem.va = NULL;
+	} else {
+		/* Not called in any failure path, so iwpbl is valid. */
+		struct irdma_mr *iwmr = iwsrq->iwpbl->iwmr;
+
+		refcount_dec(&iwmr->user_ring_refs);
 	}
 
 	irdma_free_rsrc(rf, rf->allocated_srqs, srq->srq_uk.srq_id);
@@ -1903,6 +1911,21 @@ static void irdma_cq_free_rsrc(struct irdma_pci_f *rf, struct irdma_cq *iwcq)
 				  iwcq->kmem_shadow.size,
 				  iwcq->kmem_shadow.va, iwcq->kmem_shadow.pa);
 		iwcq->kmem_shadow.va = NULL;
+	} else {
+		struct irdma_mr *iwmr;
+
+		/* May be called in a failure path before iwpbl is valid. */
+		if (iwcq->iwpbl) {
+			iwmr = iwcq->iwpbl->iwmr;
+
+			refcount_dec(&iwmr->user_ring_refs);
+		}
+
+		if (iwcq->iwpbl_shadow) {
+			iwmr = iwcq->iwpbl_shadow->iwmr;
+
+			refcount_dec(&iwmr->user_ring_refs);
+		}
 	}
 
 	irdma_free_rsrc(rf, rf->allocated_cqs, cq->cq_uk.cq_id);
@@ -2018,7 +2041,7 @@ static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	struct irdma_modify_cq_info info = {};
 	struct irdma_dma_mem kmem_buf;
 	struct irdma_cq_mr *cqmr_buf;
-	struct irdma_pbl *iwpbl_buf;
+	struct irdma_pbl *iwpbl_buf = NULL;
 	struct irdma_device *iwdev;
 	struct irdma_pci_f *rf;
 	struct irdma_cq_buf *cq_buf = NULL;
@@ -2129,11 +2152,19 @@ static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 		goto error;
 
 	spin_lock_irqsave(&iwcq->lock, flags);
-	if (udata)
+	if (udata) {
+		struct irdma_pbl *old_iwpbl = iwcq->iwpbl;
+
 		/* Only update if the resize was successful. Otherwise, HW is
 		 * still pointing to the old PBL.
 		 */
 		iwcq->iwpbl = iwpbl_buf;
+		if (old_iwpbl) {
+			struct irdma_mr *old_iwmr = old_iwpbl->iwmr;
+
+			refcount_dec(&old_iwmr->user_ring_refs);
+		}
+	}
 	if (cq_buf) {
 		cq_buf->kmem_buf = iwcq->kmem;
 		cq_buf->hw = dev->hw;
@@ -2149,6 +2180,11 @@ static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 
 	return 0;
 error:
+	if (iwpbl_buf) {
+		struct irdma_mr *iwmr = iwpbl_buf->iwmr;
+
+		refcount_dec(&iwmr->user_ring_refs);
+	}
 	if (!udata) {
 		dma_free_coherent(dev->hw->device, kmem_buf.size, kmem_buf.va,
 				  kmem_buf.pa);
@@ -2425,6 +2461,11 @@ static int irdma_create_srq(struct ib_srq *ibsrq,
 		dma_free_coherent(rf->hw.device, iwsrq->kmem.size,
 				  iwsrq->kmem.va, iwsrq->kmem.pa);
 free_rsrc:
+	if (iwsrq->user_mode && iwsrq->iwpbl) {
+		struct irdma_mr *iwmr = iwsrq->iwpbl->iwmr;
+
+		refcount_dec(&iwmr->user_ring_refs);
+	}
 	irdma_free_rsrc(rf, rf->allocated_srqs, iwsrq->srq_num);
 	return err_code;
 }
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


