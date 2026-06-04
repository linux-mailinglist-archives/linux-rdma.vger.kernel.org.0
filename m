Return-Path: <linux-rdma+bounces-21786-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ch/UDIifIWqqKAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21786-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 17:53:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6CD6419A8
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 17:53:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=NqHhiBdB;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21786-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21786-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41412313DBC7
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77C927707;
	Thu,  4 Jun 2026 15:41:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54B36A36E
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 15:41:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587670; cv=none; b=F39Mzxipt02e1ffq3I66u+7qmvw5Z9GSj+SPHdgwK1Ij8/Iwc8BRtIhgN0W/LujOtUNURUBXbHtTmtXiF8SQp47TBEJmcNefkZsNmxXvHA8QB0E0OLOobWFM/UtXIM6p8sL2zHzuFWFoWs9h5MvrtSiWeDvSHeFpvvx1rYiKS3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587670; c=relaxed/simple;
	bh=cnrIDcRJbOq0Bm9/54IUsDTdSvEFQvNluro+6vv8cdA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nZYnzNEP/0qkW/loXSnhqwZjbXYsEf4A81FNkDM5eGCpBxKUh51LSGnMWwRQDJEayHS1JWjZIPG75k8DVfwJRr5F9yDK8G1KoiQqSD6OiiyIvIJR19mJ1ZzxuFIHXAeRjZIOwu5jHGe3aGTvKsU1Ld25iuGqSnBMxkwiOhlgQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NqHhiBdB; arc=none smtp.client-ip=209.85.219.74
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8ccd3213beaso17818536d6.0
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2026 08:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780587668; x=1781192468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QdX/SBJQJVwpbcApirhkI+SYibeOOzFEZ9Gv2IlIrcQ=;
        b=NqHhiBdBl8StOy2ACAD9dak2JExl0n3KAYq6+2zXACE0lwUhv4jj+diZ2YVr5bG0Jt
         qvpWHeDbbdfLAmmkYGFq1husYKYev/XZZT+36ecltzCdSDBZGPFX+VvRcxUomUf4RK9c
         QraouzQsMDR3dvNBtdRy5oBQx2ohJfEMfyc7MSsug3N9xyRs2bhNFltQ0gENZYavRXrE
         4vYjTVcYf/GC2GLRTwyxESszq5JQRSzQCjBa4O/eyPytr9URP5McB3zNFVW9gb4YtsPL
         rH6EF7w6Oeyj0T3fDdGwGG11tfro/Gp6zQvBPvQENXKiC5G/2VGccf+rh5F8cmLSZcSX
         +prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780587668; x=1781192468;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QdX/SBJQJVwpbcApirhkI+SYibeOOzFEZ9Gv2IlIrcQ=;
        b=r5QX1rUGWslPsK960Oqy1HG2ZSWtN25TrAaHlNyaxQ3xWaar9IR0dBnmpafLqapP3J
         f0smZ3lAF8p5bUTjIUB7VtalegHd/pGkKhui3KWO1TE+UWMZ0EtoabP+GqPQi6nCqZjT
         yj+RpQlLjOsvIY0hqq7A+ZVxWse7daWQTWXCy6MF1S/OOj5HEX6GRb4z7PuEp1zZsFU2
         2q8afEOuy755/VhTgtdcfGI5subpUixK3WDsiJJQmG8rc2WU+wJxIYYhPVgPxs/CT8Ii
         lr7A7MFIKrvIQDygkH+2WiERsgAwtu74F87GwEEsMjY4RMH2WOSjC5ZKkAJrak+aj5Ev
         IHGg==
X-Gm-Message-State: AOJu0YxBZvfBBGvUcW2l2WkSYKdYFQsoOJDtlsKYi7Ctf+XDTpHFaHhb
	z/p7eHkWbief/gjp3UqUwOyaaxph89UYrUzZN8o7178swOnyOfJGGD96sbcYXSEldpQuTyzOg/j
	vdZUVO6e+UQ==
X-Received: from qvbfh16.prod.google.com ([2002:a05:6214:1a10:b0:8cc:d535:be3d])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:260e:b0:8b2:8b6:4bcf
 with SMTP id 6a1803df08f44-8cecda15864mr131408906d6.0.1780587667868; Thu, 04
 Jun 2026 08:41:07 -0700 (PDT)
Date: Thu,  4 Jun 2026 15:41:04 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604154104.4035581-1-jmoroni@google.com>
Subject: [PATCH] RDMA/irdma: Initialize iwmr->access during MR registration
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
	TAGGED_FROM(0.00)[bounces-21786-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B6CD6419A8

Initialize iwmr->access during initial user mem registration so
that it contains a valid value during a subsequent rereg_mr.

Otherwise, a rereg_mr that doesn't set IB_MR_REREG_ACCESS (for
example, one that only changes the PD) ends up clearing the
access flags in HW since iwmr->access is zero-initialized, which
is not intended.

Fixes: 5ac388db27c4 ("RDMA/irdma: Add support to re-register a memory region")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index baee48df5fd..f2f487e9540 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3309,6 +3309,7 @@ static int irdma_reg_user_mr_type_mem(struct irdma_mr *iwmr, int access,
 	int err;
 
 	lvl = iwmr->page_cnt != 1 ? PBLE_LEVEL_1 | PBLE_LEVEL_2 : PBLE_LEVEL_0;
+	iwmr->access = access;
 
 	err = irdma_setup_pbles(iwdev->rf, iwmr, lvl);
 	if (err)
-- 
2.54.0.1032.g2f8565e1d1-goog


