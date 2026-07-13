Return-Path: <linux-rdma+bounces-23158-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k5nWL7scVWpOkAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23158-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:13:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD9C74DE7A
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:13:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=pHzxCFak;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23158-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23158-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04102300601A
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7CF344D8D;
	Mon, 13 Jul 2026 17:13:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94A224F3
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 17:13:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962802; cv=none; b=GwZl92zZWkYNIuYkVXfzUR6MwrBbbvFS0DMRUZvOAzt0d+8b732yuAIXXWzKs7FJEsSRR2EOyo5OSQHzAsjW4qDaSRddhurCtRI4uj9yDGMlgFatDI9uld09opS7FESZ9EQFUvZ9AFTmcwe0N1k3wNlfTWM2pZjQtjCpB2Qk/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962802; c=relaxed/simple;
	bh=IolL5WaVx4I4N8xX/xSa1M6YYfc8ASUPlW/BmsQ32l4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VLRgCgmfBsXs4st2ehmVmyWUT4zjCpGqjVBR22bGC77vvYdJyCYcXvejtzUEIcUOiBObKuhnBJaOfcvFsCxQHR4ZEIdZqoYOBxxiEprq6NcOtEgCpNPBBtIH1fC+9Z9G9naMYOuUs22dhkYk8Qzjx05pA80DDePbc72lXO7l8GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pHzxCFak; arc=none smtp.client-ip=74.125.224.73
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-6675e8ebb1aso202832d50.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783962800; x=1784567600; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUfDmaVEl4TM1JCKAnizd64TvGzfqXehiuP40eAA4ko=;
        b=pHzxCFakw4tP5dges+mwX5qK7vmUABTbyjiLJ8KV+LyzDzFj0os4lbHYG7R5/koCfA
         ZJS7SrNhoCWCwBdXbcV1nJ+xuU0EpXE/JnmjwwUl4Ed3Zb6w0MlGr9hQOApy8ndwFyY4
         mDh970jHAQr13P/B9YODPQLuKWyRHtxnsRerC2IuzUeXmd077oQ01bJJFZAI3+NqdSWN
         92UjzSiPHXuj3nkV7U/zGm4Unrs6+4+CDdxsmyq605zJpNM3DCKR3LyQ5IurqyHSe32O
         4DMh46kAEGKwTkO9eTNKgOVzoWLJmB9QP0kqieddkDmkPEyBEaKLNNn6tvoeHDzvNxF1
         5rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783962800; x=1784567600;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jUfDmaVEl4TM1JCKAnizd64TvGzfqXehiuP40eAA4ko=;
        b=JUUwEdQ7rydnIe2ie4EyO5jq5mjyCwhf2C/gS9qYW4lDBaQ7huBcfVAIF0Eu6oXvW4
         jtxYsyWzaeoC+2eAflQ6eXeSnpKHq2c5WAxDbG9t4dVMt7uqVDaLxk6K9dXkoFu4VXg7
         gAIAzvclJRC8CWRZrSZkQg4EMc2JEnrq8T0ICgZc9YVtIJ3V8kpc7mF6HYGBlOVbPV2S
         LNIEY2FXwVvIoDlGVIcQXXkT5xEIlbELyuRqkBDjBTd4O6gWXtHZmUEsZbyRc2AZX6AS
         3s82aDYkoeOqSzon467BcyIhYSkfSDikjKoBMSZBMGrQHsqGZrp7x/Fy3afHTzDFl/WZ
         jZ4w==
X-Gm-Message-State: AOJu0YyIaPrr9kvxo0OvGq79/bkl+w9CJKqmQUm7v9BUzpZCBHsQ7I1Q
	rjP/riMtdVGf9IwA4GAOkhPgiiYyHExJlUMiW/Vyh8IfWJGpmR+9hpjuyTfVeMgc5BdUDtHQ2tm
	pAhSxQTjrlQ==
X-Received: from yxrt12.prod.google.com ([2002:a53:c90c:0:b0:664:aaf4:a27d])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:158d:20b0:667:9ae7:8d21
 with SMTP id 956f58d0204a3-667d7c3e71dmr5637090d50.84.1783962800000; Mon, 13
 Jul 2026 10:13:20 -0700 (PDT)
Date: Mon, 13 Jul 2026 17:12:56 +0000
In-Reply-To: <20260713171257.3131493-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713171257.3131493-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713171257.3131493-6-jmoroni@google.com>
Subject: [PATCH rdma-next v4 5/6] RDMA/irdma: Fix legacy i40iw compat check in create_qp
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
	TAGGED_FROM(0.00)[bounces-23158-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFD9C74DE7A

The irdma driver maintains backward compatibility with the
legacy i40iw userspace provider by checking the length of
the user response buffer in irdma_create_qp.

Previously, the check relied on udata->outlen < sizeof(uresp).
That is technically okay since there have only ever been two
sizes for the resp struct (legacy and current). However, it
would be a problem if the resp struct is ever expanded in
the future because it would end up triggering the legacy
fallback path for non-legacy irdma providers that just  haven't
moved over to the newer expanded struct yet.

Fix this by explicitly checking for the exact legacy resp size.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f74e5ca89e1..e87c879cecd 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1139,8 +1139,12 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	init_completion(&iwqp->free_qp);
 
 	if (udata) {
-		/* GEN_1 legacy support with libi40iw does not have expanded uresp struct */
-		if (udata->outlen < sizeof(uresp)) {
+		/* GEN_1 legacy support with libi40iw does not have expanded
+		 * uresp struct. Check for the exact legacy size (20 bytes) to
+		 * ensure that newer expanded uresp structs don't accidentally
+		 * trigger the legacy fallback.
+		 */
+		if (udata->outlen == IRDMA_CREATE_QP_MIN_RESP_LEN) {
 			uresp.lsmm = 1;
 			uresp.push_idx = IRDMA_INVALID_PUSH_PAGE_INDEX_GEN_1;
 		} else {
-- 
2.55.0.795.g602f6c329a-goog


