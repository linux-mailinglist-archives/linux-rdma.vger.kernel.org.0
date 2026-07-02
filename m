Return-Path: <linux-rdma+bounces-22710-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PNZyF7WoRmrKbAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22710-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:06:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 753236FBD83
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:06:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=haccZjfY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22710-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22710-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5A9331C52F0
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F53346BE;
	Thu,  2 Jul 2026 17:07:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D74310779
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 17:06:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012020; cv=none; b=klxSNapkyz7BYtBb8F5yqLPNf0AuaZHLbQfSg/sAOF4Fl86dCq0fi106GGjAQfIptwp/C84LhQTUmfOvBDZIG0P11ME0KyxGOUznBbHq1yl5S6N4PzfPtef0RpaIpesGFLp/faPFpnEK43um/fTrlA+T4tF8mvXFPPFgkYJr/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012020; c=relaxed/simple;
	bh=5JYiWjVxG86jB6F6ZYghT48QpIp+7LBQJG14gHZfSz8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=txfxQxFNVR5oySMk8g86vWMynJUgyIyiYHUe+XIQ1HkGAb/wSjc1qH24ws4odb+/8oZAnp4n0m4j92duE4zlg7ad/YTrJof+npPt1OCrbVTS2mNAYbEk79rGc0Ygnmlb4n15IsTG4yGJ5LdErIjpTvvUprmYK1SdbAbSXu/Zs30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=haccZjfY; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-92ac0a54110so271857085a.2
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783012018; x=1783616818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6OOVEosaORG0Mai3nLQ3tfiaTnLky+bmyaDO5aNiwSg=;
        b=haccZjfYXwHRcqchv530hu+7VWBSNKQA2+OHHS2hazpnv01uJLWR4Kv1uddrAAliSt
         qAr1AY6mRr6wv+Jxr6pvL5/dCYERBmNZzNIu3sAJW302RPNYs56mHeMD1lICSxrvQ9Bu
         bwKOq6EiscrIzbAijiLHtOa879xwmtftdj18ioy2dDkowdzkUzwHdyUQURUEKFEYcYKc
         uPalwWbAF9uOaWC7XYCZ5RrQuXDa2i1Ats/mZW2dZflabtL/kPAbCfQvjbsL37qRv/cG
         hclCc8JzT92AHT8psDJ0xl3fR/XlhG5v05byYV76fXVr0jSKad8Mt7gojAaBOlILz0v/
         2T2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012018; x=1783616818;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6OOVEosaORG0Mai3nLQ3tfiaTnLky+bmyaDO5aNiwSg=;
        b=J9ka+jpi5qxlZk+IjwpJk+CAKpqIuxUWtFStmKWYDepZ3Umf1VZSDjn/Ov24ViGg2P
         k7XSo+ZoMdOQLtetuo8UvTzy9IjJ/R1B0CpkXFSukITjW4ex7ooTJdfX5twJqcdrAhEa
         0fwSU8qk5x02PMH+/lFqYg9cJAmBkAo0L9+tr2L9M1M6d1I71jU9LvzPNMVLLOIMp+7+
         3kqUZEUQrE7BNILab7+jQXDxt9g+3kPt0C3UibVxCPm6aPkWls1yfJUSYv6lhuRfsVv7
         jerMbrQARIfU1cOgcgN+c353ttqPhy9YbSo1t1JvW3EQC/AU4SGohH+Lppou1AO2z7Zx
         5a/g==
X-Gm-Message-State: AOJu0YxL848yR0ZhAmQ2i/L4JOaYb0/N09Ma7jUFxyFLhi2A+6fdpSNH
	gyno4l1V9Dm+ScBbXL2EMSiQPwXdSNzhd41MfKHc73mOIhodc0xi0oV4oyrDMZdkklhplkWhMFx
	fYYu3E1lndA==
X-Received: from qkax22-n1.prod.google.com ([2002:a05:620a:2256:10b0:92e:781d:bd06])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:1a26:b0:915:cb40:f76a
 with SMTP id af79cd13be357-92e782c44c1mr1028171485a.39.1783012017819; Thu, 02
 Jul 2026 10:06:57 -0700 (PDT)
Date: Thu,  2 Jul 2026 17:06:45 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702170652.4159201-1-jmoroni@google.com>
Subject: [PATCH rdma-next v3 0/7] RDMA/irdma: Adopt robust udata
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22710-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 753236FBD83

This series brings irdma up to uverbs_robust_udata compliance.

The driver has been audited to confirm that:

  1. Methods which do not accept udata input perform an explicit
     check for no (or zero value) input.

  2. Methods which do accept input perform the correct validation
     to ensure that additional udata beyond the kernel's current
     ABI definition is zero, and to enforce the required minimum
     length.

  3. Methods which do not return udata responses use the proper
     helper.

The irdma driver is backwards compatible with the legacy i40iw
provider, so special care was taken to avoid breaking any legacy
binaries, as there were some small differences in the ABI/semantics.

This has passed the rdma-unit-test suite using the normal irdma
provider from upstream rdma-core.

NOTE: This series is based on a few irdma bug fix patches
      which have not yet been merged:

- RDMA/irdma: Prevent user-triggered null deref on QP create
  https://patchwork.kernel.org/project/linux-rdma/list/?series=1113053
     
- RDMA/irdma: Prevent premature deregistration of user ring MRs
  https://patchwork.kernel.org/project/linux-rdma/list/?series=1113648

Changes in v3:
* Add ib_no_udata_io helper to more easily handle the
  common case of no input/no output ops.
* Fixed regression in create_qp failure path caught by sashiko.
* Rebased on top of previous posted irdma fixes.
* Fixed an additional latent legacy compat bug in create_qp.
* Added missing response buffer clearing for reg/rereg_user_mr.
Changes in v2:
* Fixed Sashiko findings:
  - Moved ib_respond_empty_udata to beginning of most
    methods to close gaps where it could previously
    return 0 without calling ib_respond_empty_udata. This
    also fixes issues where the ib_respond_empty_udata
    call itself could fail, which may leave resources
    in an inconsistent state (kernel believes object
    is alive, but driver resources have been cleaned up).
  - Moved input validation to beginning of modify_qp
    methods to close gaps where the op could be invoked
    with udata but without input checking.
  - Fixed a QPN leak that could occur during QP create
    by moving input validation earlier.

v2: https://lore.kernel.org/linux-rdma/20260629232532.2057423-1-jmoroni@google.com/
v1: https://lore.kernel.org/linux-rdma/20260627025642.4064973-1-jmoroni@google.com/T/#t

Jacob Moroni (7):
  RDMA/core: Add ib_no_udata_io() helper
  RDMA/irdma: Add checks for no udata
  RDMA/irdma: Clear udata response buffers where necessary
  RDMA/irdma: Use robust input copy helpers
  RDMA/irdma: Use robust udata helper for QP creation
  RDMA/irdma: Fix legacy i40iw compat check in create_qp
  RDMA/irdma: Enable uverbs_robust_udata compliance flag

 drivers/infiniband/hw/irdma/verbs.c | 216 +++++++++++++++++++---------
 include/rdma/uverbs_ioctl.h         |  20 +++
 include/uapi/rdma/irdma-abi.h       |   1 +
 3 files changed, 167 insertions(+), 70 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog


