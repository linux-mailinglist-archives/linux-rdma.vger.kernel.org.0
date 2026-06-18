Return-Path: <linux-rdma+bounces-22362-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FIsVDfhRNGocUwYAu9opvQ
	(envelope-from <linux-rdma+bounces-22362-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 22:15:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D23976A27AC
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 22:15:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=cupI2vQS;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22362-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22362-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F18B307B4D4
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 20:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89CB2EF67A;
	Thu, 18 Jun 2026 20:15:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D381342507
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 20:15:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813717; cv=none; b=VDRgt9uV1vqdA74BhlIh65ag/2ggqM18IhOJ74eU/ehXbPgiDGUM8VHqcrNt51yRAeqeHjQxFCb0QANmqqzoJJazE49rR37XTgVa8EsX6RHNGxd/yITSROV1eqqeCwjTVHKcgAo50ikcIY7ueW6qit8zyg7qLwoyEDllt1rOZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813717; c=relaxed/simple;
	bh=G7p3vN6nWpB2INstfUcqBWpushA7PwB0x5Fc3jYMayA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V63yqEgy60rZ8RJIARTeezQd9C65ksMey+NqGJYrXGs3D5zYG41PQjdOSOG26yYbIKdQMPvA5NZhPhalG4+QGS43E+8Dxpu+N9tXuDQq90B17LToznzE70q3mR2meCw3hBFGDV1WBsoI+QJ5zVF22GZ4eKvu8fp/jB71k5XfiGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cupI2vQS; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-517dadd84f8so29055181cf.0
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 13:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781813715; x=1782418515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iPZ+7Fxb3vKsvyt2ttQaOtLyBWy3ea97lWF5HZm/m70=;
        b=cupI2vQS0WP9+Mhd33vEtzxQSyoZXqqBGO5DVD6Y/gHSQ3nB2gmTkOCPOskaFiYjVT
         UER2Fy+1Vof66ABi+g6v9dtSj5s+vVT4+mXq3AS39C3naSUqtenfkC/rp+CpFmt5iYmo
         e/boQvuoobpiCY20+rA4A7iBgr3Ac8QSnfKpU4KYt/8eX4shBOLfTaQOExveLfigvXPr
         2WJIchS7YUJXvMJpgH8oNCEQ3OW12BjVuVfGMvg+o1MLE85YN+UiASk6rjljRuE6qyEg
         cFb/TY09ySWsvKD5zfYMcmHvWjbhSxoo3NHYUAvyboeR0yETuAzNIlRsdKx4Xl3gbPmT
         ZsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781813715; x=1782418515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPZ+7Fxb3vKsvyt2ttQaOtLyBWy3ea97lWF5HZm/m70=;
        b=VjT2ZP61V5NScPDpKrwcOQ3cUls/n598wZbb+lAXorm9YCBu2vMHR7gmaGWQT4ZrzQ
         A0j5ntTpk6xGDfMgAaGy5jbe0ryZ4B2QMQSyN1g6n1gVJdXsgO1WpU1Bqu4rGFXulcR6
         XsJaujgv0u4erThIYY031j+PbcitdoO+Rh4cjbd9svR007IubW+3TP+s3w126VLcZbcD
         xe7ur98zMCkuzqB6kPw7Ddpf8XxtPbNqjeObUCuzSjRygdx+La25HkfFdR81saijhh/7
         fqtedcMkaFNUF4PVPN63ve39Fd4hBfbUeaKr0uV1Pkag1w0hmyLCuttq/Nr8e4n98BiS
         ocag==
X-Gm-Message-State: AOJu0YwNHaduvZh/dOKcTvyeYn7ahRouzVxMHOT7CEs6UXwO/6KC//yi
	GRuL39Yah6zM8P19lE6czS0z/MJ/7q1bFFpquv/5cJbIsk8E5izImsedL9tCaFSQPrN570aE0NE
	8Gm3CT/g7mA==
X-Received: from qvji7.prod.google.com ([2002:a0c:d847:0:b0:8db:c5ea:fa77])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:5805:b0:517:7e3a:5ee1
 with SMTP id d75a77b69052e-519e4919ddcmr11488341cf.1.1781813713112; Thu, 18
 Jun 2026 13:15:13 -0700 (PDT)
Date: Thu, 18 Jun 2026 20:14:57 +0000
In-Reply-To: <20260618201458.875740-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618201458.875740-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618201458.875740-4-jmoroni@google.com>
Subject: [PATCH rdma-next 3/4] RDMA/irdma: Add irdma_cq fields to track pbl allocations
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
	TAGGED_FROM(0.00)[bounces-22362-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: D23976A27AC

These fields will be used in a subsequent commit which adds
refcounting to user CQ MRs.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 25 +++++++++++++++----------
 drivers/infiniband/hw/irdma/verbs.h |  2 ++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 2c51684dd..dccecff3c 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2129,6 +2129,11 @@ static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 		goto error;
 
 	spin_lock_irqsave(&iwcq->lock, flags);
+	if (udata)
+		/* Only update if the resize was successful. Otherwise, HW is
+		 * still pointing to the old PBL.
+		 */
+		iwcq->iwpbl = iwpbl_buf;
 	if (cq_buf) {
 		cq_buf->kmem_buf = iwcq->kmem;
 		cq_buf->hw = dev->hw;
@@ -2499,6 +2504,8 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	INIT_LIST_HEAD(&iwcq->resize_list);
 	INIT_LIST_HEAD(&iwcq->cmpl_generated);
 	iwcq->cq_num = cq_num;
+	iwcq->iwpbl = NULL;
+	iwcq->iwpbl_shadow = NULL;
 	info.dev = dev;
 	ukinfo->cq_size = max(entries, 4);
 	ukinfo->cq_id = cq_num;
@@ -2518,8 +2525,6 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 		struct irdma_ucontext *ucontext;
 		struct irdma_create_cq_req req = {};
 		struct irdma_cq_mr *cqmr;
-		struct irdma_pbl *iwpbl;
-		struct irdma_pbl *iwpbl_shadow;
 		struct irdma_cq_mr *cqmr_shadow;
 
 		iwcq->user_mode = true;
@@ -2533,34 +2538,34 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 		}
 
 		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
-		iwpbl = irdma_get_pbl((unsigned long)req.user_cq_buf,
-				      &ucontext->cq_reg_mem_list);
+		iwcq->iwpbl = irdma_get_pbl((unsigned long)req.user_cq_buf,
+					    &ucontext->cq_reg_mem_list);
 		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
-		if (!iwpbl) {
+		if (!iwcq->iwpbl) {
 			err_code = -EPROTO;
 			goto cq_free_rsrc;
 		}
 
-		cqmr = &iwpbl->cq_mr;
+		cqmr = &iwcq->iwpbl->cq_mr;
 
 		if (rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
 		    IRDMA_FEATURE_CQ_RESIZE) {
 			spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
-			iwpbl_shadow = irdma_get_pbl(
+			iwcq->iwpbl_shadow = irdma_get_pbl(
 					(unsigned long)req.user_shadow_area,
 					&ucontext->cq_reg_mem_list);
 			spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
 
-			if (!iwpbl_shadow) {
+			if (!iwcq->iwpbl_shadow) {
 				err_code = -EPROTO;
 				goto cq_free_rsrc;
 			}
-			cqmr_shadow = &iwpbl_shadow->cq_mr;
+			cqmr_shadow = &iwcq->iwpbl_shadow->cq_mr;
 			info.shadow_area_pa = cqmr_shadow->cq_pbl.addr;
 		} else {
 			info.shadow_area_pa = cqmr->shadow;
 		}
-		if (iwpbl->pbl_allocated) {
+		if (iwcq->iwpbl->pbl_allocated) {
 			info.virtual_map = true;
 			info.pbl_chunk_size = 1;
 			info.first_pm_pbl_idx = cqmr->cq_pbl.idx;
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index fbd487dbe..a1651641e 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -153,6 +153,8 @@ struct irdma_cq {
 	struct list_head resize_list;
 	struct irdma_cq_poll_info cur_cqe;
 	struct list_head cmpl_generated;
+	struct irdma_pbl *iwpbl;
+	struct irdma_pbl *iwpbl_shadow;
 };
 
 struct irdma_cmpl_gen {
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


