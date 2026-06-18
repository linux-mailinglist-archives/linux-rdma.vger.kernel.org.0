Return-Path: <linux-rdma+bounces-22361-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BIgBA/VRNGobUwYAu9opvQ
	(envelope-from <linux-rdma+bounces-22361-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 22:15:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A461B6A27A7
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 22:15:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Rg8tkSfu;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22361-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22361-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C74493078E8F
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 20:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC2C31E82F;
	Thu, 18 Jun 2026 20:15:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE22342507
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 20:15:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813714; cv=none; b=Yh4cf8QTNiElbn/AE/RZ8tJtnJC+HDZvCc3RUmLlFnPdiC2BdOumS5gQU6Ox645URCXbZ3nw8ducuAtBWwZlE631kbFJ1YycmThK9ILduWoVcJcsx5JKeDh+7sYGdr1nobLrXviz5OZmS0DwwhSiKvpz7BVI7SWv4c7lcdYcARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813714; c=relaxed/simple;
	bh=9c8nAfu2Q9ej218cr8xu90lW+ChGXv/nlZz84LGqKAs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SaPNXbu1TBmV3fpfCFWj9NKrpECq8GcaHSXIkhy6pKc5JFwFStnFVNyZdtEp/FdodNy/Nv3/zKrexOZZf84Hwsx3Geh4KjssXCIwviIr56QH1QCtxZkRSBigwO/dgHY+iUhqONzRtywXCZO/T0F+cWLEDNVO86QoBBly1bHsuGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rg8tkSfu; arc=none smtp.client-ip=209.85.128.201
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7fe835353acso27443407b3.2
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 13:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781813712; x=1782418512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ7kCGxeOJTuTQuNkZROJIq5kvePEAgMZKyCReuSiKE=;
        b=Rg8tkSfuLc/oxzgQH58eWPWDKHl8ZJkAEuyWjvXuaqE/LD6F7NZ8MAwy+CmiNHS+8P
         a+Z6HKOZIv9Q/oRNQtBrlIQ/wn9QhteuJ1Aotrfa19Qh3As//hq9WH6GAsBDtHnQjHtb
         X0pkymNYfa/7CpL3KHw1ZnQ/EmzORpHMvy2rRRH1b7MPv4WR1Wwea0Kr+ZCiNG4eK3ML
         Hcfm0klY1p9Vyi9941TKuTXtiPtq5T6xjSvVN21afzERNAi2soWOGOHdpu5buEIuLa/o
         WzXuM2ElEbw0ZnDsNDBfpBCz9r9zG4DpABhAAgIY3dz5RjGeaJeyiRAT72moeM5b/rZ4
         Zbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781813712; x=1782418512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ7kCGxeOJTuTQuNkZROJIq5kvePEAgMZKyCReuSiKE=;
        b=i2BmzwLYOa6OS2ta5jBjH2XNb5Lbe6UPumlNH3MfsN+1tx8ZEdmjX666K5e5S+K6vA
         oDpiCQMpnbmh6JypSowoVZpL8NZl23kFuz6cNff4b/xTXAL00fMH7i7rQcT0JJK+UnHZ
         AlBPBJWEt9lC4VVGq1eFC8QX0Gbed/W2kWHtY0os02gxug8CecEQwX2YGfDx3AiSevb/
         +Pny7b1pFnkng/4lAo6WnFCg6M0V4H/mAWUppiIu65KGopXIGbu7ADRCT4TCSmoldpdc
         Z+jycVzo3UwfeQAJF4FhZ+z9kwLTZ83Fx2hswFgQV9KNM53ZA4bOSajZn6VVSKhfu5xR
         vhTA==
X-Gm-Message-State: AOJu0YzmGzXmwgY5B9RxmhAXjRTzKsufEb1n54q+pd/N3cMHs4L/QB4O
	cuywxlV7pQCyd1dFP3eAtHbpZxAoOev4TvxTuEoAauyrg+WBfWGrem0r2rTKFpn/M0iaQTa5vBq
	m4bpt3umcWg==
X-Received: from ywbiv1.prod.google.com ([2002:a05:690c:6d01:b0:7ba:f963:b978])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:e3d2:b0:7ff:5a4:b296
 with SMTP id 00721157ae682-80134b7aa7fmr3148047b3.51.1781813711705; Thu, 18
 Jun 2026 13:15:11 -0700 (PDT)
Date: Thu, 18 Jun 2026 20:14:56 +0000
In-Reply-To: <20260618201458.875740-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618201458.875740-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618201458.875740-3-jmoroni@google.com>
Subject: [PATCH rdma-next 2/4] RDMA/irdma: Add a refcount to track user ring
 MR associations
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
	TAGGED_FROM(0.00)[bounces-22361-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: A461B6A27A7

User QP/CQ/SRQ rings are registered with the normal reg_mr
mechanism prior to creating the actual QP/CQ/SRQ object. In
order to prevent userspace from deregistering these special MRs
while the child object still exists, a refcount will be used.

This commit adds the refcount and logic to reject a dereg_mr
with active references. Subsequent commits will add logic to
bump this refcount when the user QP/CQ/SRQ objects are created.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 21 +++++++++++++++++----
 drivers/infiniband/hw/irdma/verbs.h |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index af04dd554..2c51684dd 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3363,6 +3363,7 @@ static struct irdma_mr *irdma_alloc_iwmr(struct ib_umem *region,
 	if (!iwmr)
 		return ERR_PTR(-ENOMEM);
 
+	refcount_set(&iwmr->user_ring_refs, 1);
 	iwpbl = &iwmr->iwpbl;
 	iwpbl->iwmr = iwmr;
 	iwmr->region = region;
@@ -3923,13 +3924,16 @@ static struct ib_mr *irdma_get_dma_mr(struct ib_pd *pd, int acc)
  * irdma_del_memlist - Deleting pbl list entries for CQ/QP
  * @iwmr: iwmr for IB's user page addresses
  * @ucontext: ptr to user context
+ *
+ * Return: True if the MR is currently in-use by a QP/CQ/SRQ ring.
  */
-static void irdma_del_memlist(struct irdma_mr *iwmr,
+static bool irdma_del_memlist(struct irdma_mr *iwmr,
 			      struct irdma_ucontext *ucontext)
 {
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
 	unsigned long flags;
 	spinlock_t *lock;
+	bool in_use = false;
 
 	switch (iwmr->type) {
 	case IRDMA_MEMREG_TYPE_CQ:
@@ -3942,15 +3946,19 @@ static void irdma_del_memlist(struct irdma_mr *iwmr,
 		lock = &ucontext->srq_reg_mem_list_lock;
 		break;
 	default:
-		return;
+		return false;
 	}
 
 	spin_lock_irqsave(lock, flags);
-	if (iwpbl->on_list) {
+	if (!refcount_dec_if_one(&iwmr->user_ring_refs)) {
+		in_use = true;
+	} else if (iwpbl->on_list) {
 		iwpbl->on_list = false;
 		list_del(&iwpbl->list);
 	}
 	spin_unlock_irqrestore(lock, flags);
+
+	return in_use;
 }
 
 /**
@@ -3973,7 +3981,12 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 			ucontext = rdma_udata_to_drv_context(udata,
 						struct irdma_ucontext,
 						ibucontext);
-			irdma_del_memlist(iwmr, ucontext);
+
+			/* Do not allow the MR to be unpinned if it is still
+			 * backing a user ring.
+			 */
+			if (irdma_del_memlist(iwmr, ucontext))
+				return -EBUSY;
 		}
 		goto done;
 	}
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index 289ebc9b2..fbd487dbe 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -120,6 +120,7 @@ struct irdma_mr {
 	u64 len;
 	u64 pgaddrmem[IRDMA_MAX_SAVED_PHY_PGADDR];
 	struct irdma_pbl iwpbl;
+	refcount_t user_ring_refs;
 };
 
 struct irdma_srq {
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


