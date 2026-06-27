Return-Path: <linux-rdma+bounces-22503-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bireBwI8P2qFQAkAu9opvQ
	(envelope-from <linux-rdma+bounces-22503-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 04:57:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4336D0CF9
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 04:57:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=jelneAyt;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22503-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22503-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07A6D300C7FD
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 02:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EDC331EAC;
	Sat, 27 Jun 2026 02:57:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6631419A4
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 02:56:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782529019; cv=none; b=RkVJ+5FJ/eLiYoy27mfZOhxJjyKMYcl8UkJHb4hjjcFmGKbmd9ngcKOEn5DevEG9gWCZVALX3XFlELW8PctE+Jk5309Gj/W/1P5EYhEs68D0p56sLgWs6OQqNsfyW/VSHi0x2Epj5eafZkEQz9HrVxnll8E1uefUJT51pTf+4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782529019; c=relaxed/simple;
	bh=tbleTv6wSRr+3pCeeAsgRWFgCNfIWAG7LiwaDn1zGsg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NL32ZOOhyu8ComtO7lhWn2j+01ouBtg2ZRbM4ZVNnZ89s7QcLkpTZAKrbJopPdO5bryqT0cbPZOQ/ttC2CNcVYscjbjcQKntXPQLBUWozfP5LznuUr561/8UOEa31QHtge20zK0/2/GM3Hmy3kOUST1iPL9d3Vz1MP1w3lUax2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jelneAyt; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-915f6ff639aso383726985a.1
        for <linux-rdma@vger.kernel.org>; Fri, 26 Jun 2026 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782529017; x=1783133817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wyKTjR1ifW+yBpadNYvDD5Qz8RyS5RIbiostlSY7Clg=;
        b=jelneAyt99JC6Z/WVW4PCmA5V/WYOlHWq85RTH94BkiatxK/DQYSbTrqrmsSNPWjro
         XAc4/0MkOjr8Pl09kSwLh+an1iOl/gBH8SQMAXR3VkLIfPiVQr5YBFlkUiitnd+3ldtm
         nmtkDx4VNVQVO8I7Eta0gqX3iyOSvurtmpcFgDXETMiZXvqfni8NvOgtLPu3qRQpT8t/
         uDCVHQ1bvvhs425iaigudmWCJ/vSuEMknVSxz2I2HOgXdY8JoiANr43mFzhaaPkWD50+
         zVsu/WU0abDz9Vn8bzCxt4/FfgQz9Fxd5izULZWSrRMneKRREvZKGvHe5XmRc6t3S5ZL
         3Skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782529017; x=1783133817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyKTjR1ifW+yBpadNYvDD5Qz8RyS5RIbiostlSY7Clg=;
        b=cKomfJWk04Kg5wQ+8YQyuEoVykVSBkmVLDHbUWr4YFAeReUpj//Anv0MquK0o1mJB9
         CJvioGdFk6a2IYDVcbCHAbi01MnXgtHzJMTduJ4mOt/8+/keClCU540bMSlLinhoESwA
         V5Ni7JRjaP4w02Nx1CpJg/ANrgwDDxaO5erNKtx08YcwvPdeckKCFD/QpUo4y27SLG+w
         KmMj6mBdBS0aJ0LgAJG8wDvrmgn69ZDpMaRI2gPvBBczpjp1Q/0+7EsBFA+8kHjgsKJc
         QIcwvpuCQLiB7pqIfx97WKEJfBMrL+0NgTESm3OvFjjGImsOMHBducx2QRKJ2MRuBMLc
         BmDQ==
X-Gm-Message-State: AOJu0YyFF4eWWzMbsWHScXK7++2L7hnBBL1J2z0pIlAnr2kGWFCCZCkw
	uNCrrBgU8xB5D2bthIkL7pnKHOIzkwHUeKB4UhClyXpiRfrJHMgL6UZUBMeeZy9EStSHDt6ZEs9
	aZMR5S66+Pg==
X-Received: from qkoc11.prod.google.com ([2002:a05:620a:164b:b0:92d:1df4:489b])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:1a20:b0:915:8055:3f91
 with SMTP id af79cd13be357-9293c9e8124mr1431690685a.43.1782529017295; Fri, 26
 Jun 2026 19:56:57 -0700 (PDT)
Date: Sat, 27 Jun 2026 02:56:40 +0000
In-Reply-To: <20260627025642.4064973-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260627025642.4064973-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260627025642.4064973-4-jmoroni@google.com>
Subject: [PATCH rdma-next 3/5] RDMA/irdma: Use ib_respond_empty_udata where applicable
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22503-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F4336D0CF9

Methods that do not provide any user response should use
the ib_respond_empty_udata() helper to ensure that user
response buffers are cleared.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 19dcc475c355..d06df520d9be 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -457,7 +457,7 @@ static int irdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 	irdma_free_rsrc(iwdev->rf, iwdev->rf->allocated_pds, iwpd->sc_pd.pd_id);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 /**
@@ -585,7 +585,7 @@ static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		iwdev->rf->hwqp1_rsvd = false;
 	irdma_free_qp_rsrc(iwqp);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 /**
@@ -1984,7 +1984,7 @@ static int irdma_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 
 	irdma_srq_wq_destroy(iwdev->rf, srq);
 	irdma_srq_free_rsrc(iwdev->rf, iwsrq);
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 /**
@@ -2024,7 +2024,7 @@ static int irdma_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	spin_unlock_irqrestore(&iwceq->ce_lock, flags);
 	irdma_cq_free_rsrc(iwdev->rf, iwcq);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 /**
@@ -2256,7 +2256,7 @@ static int irdma_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 
 	iwsrq->sc_srq.srq_limit = info->srq_limit;
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 static int irdma_setup_umode_srq(struct irdma_device *iwdev,
@@ -3076,7 +3076,7 @@ static int irdma_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 		return err_code;
 	}
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 /**
@@ -4043,7 +4043,7 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 
 	kfree(iwmr);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 /**
-- 
2.55.0.rc0.799.gd6f94ed593-goog


