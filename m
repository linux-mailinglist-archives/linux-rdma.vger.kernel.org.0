Return-Path: <linux-rdma+bounces-22360-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O1KKKPFRNGoaUwYAu9opvQ
	(envelope-from <linux-rdma+bounces-22360-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 22:15:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 064776A27A4
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 22:15:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=IMbDAzXp;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22360-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22360-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10B863076302
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 20:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B250346FA8;
	Thu, 18 Jun 2026 20:15:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBFF30675D
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 20:15:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813713; cv=none; b=YujFMU35gSFXLZsdJjLsioOQlCqMlEfH8sGV0k2hPfy9GCZLbcMYlaXZVCfzpgiSVkZyB05EMo6luNoHrg1XRcEIazmTnlJycWtVnXw9npvmDrNjsu3sTu818/DVSg4j3OIqMDvBrwsoMCbNG2vATN79ky+xiizQThpm9B71MkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813713; c=relaxed/simple;
	bh=PK12U2N5tRhadpSrb+F2vOyhhViC742+oJtAqzi5BcU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MBuBg3JP1aNjexEHJT/X/hX0X5IEgLzbBr2+cvpZGm+Kuh4hLklyQkKjH4ZoLSp9zz3siDk4E/Cy2q1wvCBQ6+RXiyYqQl3kbcvi2Z+EfdAvVPkNfEeZX2RczaiEzssjti130U0ignyOQZjM75nwNNocQRC1o4p1aUhxbeM9n80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IMbDAzXp; arc=none smtp.client-ip=209.85.128.202
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7ea35baee37so26976617b3.1
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781813710; x=1782418510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/X8+1KwPn5hv+AExwLe1AH3uxNYmkZOrrd+57RINVG4=;
        b=IMbDAzXp8W/6Hd6ydqW+qDIm9581Nod3BXCaJ5dAcNoH9umw+lDP/DoAp6DpSEQFxB
         EQWZ1eI63o4Bu9Zi32srdQL+NHK4vwxZzpwBrf3JD/lDewpREWptu22NCdcD/FgboLQx
         II9gfN4tjpWBVSFGH9KO7H/O0A8iv5XonTXqOp6ZCME57JdmETl4JgP58vX6eChZt/Jb
         8a//hJl/etV+BgGO8mJMHHfU0mLtBOxsc99rjZEG/mOM3OoAl4+lvy5wnVAOY8xsEt2N
         7XkGjUgqO+ih+gU/KtDH9DlnOC62zBPsfJhzMFOhWXYcrtcXYlFxV+F7UhXj/2Vaqch0
         bZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781813710; x=1782418510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/X8+1KwPn5hv+AExwLe1AH3uxNYmkZOrrd+57RINVG4=;
        b=MC0kxmUK/rKaKXTVSc7Us9SmG7tjaw/dYRYFq/GWyeuVQqUbjOtzM66+mRMiIX9RQG
         RPnJiXbWTDUA4eU52mWexmTTPeJLjj2KisokkgWQxWsjzyG1RIg2OguX/YcO4IMBO6/4
         WRdNF4/fRIPxT8IhgqXTIJFh9jNqbB3icnUYobzOkgM/MOI0nhUe+xgsAmHa7BqoaxZE
         A4qYsROuBa/Wir5qXSfHcY3Q0T3msskMVr1huw+AjuDtxpFnnjTP5CzZ51h0r3g56YT9
         ZfjJcDja/rrI98Dh1aeXC3Arbm0k7tnrSnneoaxSTHaxPX2swXsk9UUDxEUPWlFTlwjx
         TOlQ==
X-Gm-Message-State: AOJu0Yx+MkxEB2adPT6Jd/s/s3nsrji/AD6v6oSP9pxFt/4025vps5pN
	EskWlosMSMB7cAIHov9o0xmSC5nf3D5A9626PrB9fIGy6I83nGyPVuZH0gwg1iP9bGtN2ETt5Bn
	d9AOHaSClKw==
X-Received: from ywbdz3.prod.google.com ([2002:a05:690c:2783:b0:7dc:abbf:2799])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:7106:b0:7db:a5e5:3677
 with SMTP id 00721157ae682-80130b07d6cmr4343577b3.2.1781813710325; Thu, 18
 Jun 2026 13:15:10 -0700 (PDT)
Date: Thu, 18 Jun 2026 20:14:55 +0000
In-Reply-To: <20260618201458.875740-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618201458.875740-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618201458.875740-2-jmoroni@google.com>
Subject: [PATCH rdma-next 1/4] RDMA/irdma: Deduplicate the irdma_del_memlist logic
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
	TAGGED_FROM(0.00)[bounces-22360-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 064776A27A4

Simplify/dedup the irdma_del_memlist logic in preparation for
the QP/CQ/SRQ ring MR refcounting change that will follow in
a subsequent commit.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 31 +++++++++++------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index b79f5afe6..af04dd554 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3929,35 +3929,28 @@ static void irdma_del_memlist(struct irdma_mr *iwmr,
 {
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
 	unsigned long flags;
+	spinlock_t *lock;
 
 	switch (iwmr->type) {
 	case IRDMA_MEMREG_TYPE_CQ:
-		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
-		if (iwpbl->on_list) {
-			iwpbl->on_list = false;
-			list_del(&iwpbl->list);
-		}
-		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
+		lock = &ucontext->cq_reg_mem_list_lock;
 		break;
 	case IRDMA_MEMREG_TYPE_QP:
-		spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
-		if (iwpbl->on_list) {
-			iwpbl->on_list = false;
-			list_del(&iwpbl->list);
-		}
-		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
+		lock = &ucontext->qp_reg_mem_list_lock;
 		break;
 	case IRDMA_MEMREG_TYPE_SRQ:
-		spin_lock_irqsave(&ucontext->srq_reg_mem_list_lock, flags);
-		if (iwpbl->on_list) {
-			iwpbl->on_list = false;
-			list_del(&iwpbl->list);
-		}
-		spin_unlock_irqrestore(&ucontext->srq_reg_mem_list_lock, flags);
+		lock = &ucontext->srq_reg_mem_list_lock;
 		break;
 	default:
-		break;
+		return;
+	}
+
+	spin_lock_irqsave(lock, flags);
+	if (iwpbl->on_list) {
+		iwpbl->on_list = false;
+		list_del(&iwpbl->list);
 	}
+	spin_unlock_irqrestore(lock, flags);
 }
 
 /**
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


