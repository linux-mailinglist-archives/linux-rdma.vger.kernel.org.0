Return-Path: <linux-rdma+bounces-22359-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NufNHe1RNGoXUwYAu9opvQ
	(envelope-from <linux-rdma+bounces-22359-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 22:15:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E67B6A279F
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 22:15:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Bw5p+hXj;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22359-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22359-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A9DC30730CF
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 20:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E839F34EF0E;
	Thu, 18 Jun 2026 20:15:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77804342507
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 20:15:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813710; cv=none; b=bmlFkg61RjVWrg9SS6mnzdKYg4uqohPJrCDP8ExMft6l28ujtI3/h+4Lx6+yWoHDQivqITK9x9xvQkBZ+V8dk+Q7paq9T+ZsJ/QUTRKeBIzcWfy55WCL3PlWAfuO9DNrwJRAgH4gvAd+vsShh6+iz1d6eKK9mKb+C2YBwsX1y68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813710; c=relaxed/simple;
	bh=AFgRhvu6fyS7GcUht1WKtVCR+LLur5O5tryG1Tylb6M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GmWJn9ckyL2AGwYzkkCp0gn20SfZjhAD8J9ngggum1d4oQcdh/CwwwmSwlhQLj/PPbNgL2162dOkI/x+WOqDNCNz8EVsJ6JoaJrtWwAgRzPG8R3tdIRJuz+TTFgsaKUW9W9m4W2mneF+cup8X6hi7gq3m6XWxpxhpQfYsDym6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bw5p+hXj; arc=none smtp.client-ip=209.85.128.201
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7ddd34a6336so32565897b3.2
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 13:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781813708; x=1782418508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=osZ2eq9rj8dgpFcAMwkAFVer9EM1ZoDEZ5xp6NFPRvU=;
        b=Bw5p+hXj3bpNnDP6c+PU6BDRc4vmOfxhf/R4xdX1vttKga2aWFgohfgVDzD6t2+3t2
         EXhWepFKVzkWe7bzVlsFL2xuQD/mn1dlzYttJhenYOWPDAP4d2QwLE6n4GvSoSpkLfwH
         1CNKCLhAiL4W8ucmTA+xj1A2RsLyfSZwCkeEDyl1x9NEcr5JDfzaauapzbkw6/nM0vW4
         faS477ZSf1WSZrkx/7rpdY1z/jQQF4tgGVDeeosDYY28f3ic7QBzhZv5Yh4knDnVljYi
         gJ0fxNfW5DVHW0ADEMP5V1UV/u0/vT1TXCW5JQKCvtFInKXohjKBZteQ7aA+vFP0rjSE
         CTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781813708; x=1782418508;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=osZ2eq9rj8dgpFcAMwkAFVer9EM1ZoDEZ5xp6NFPRvU=;
        b=L+Zf/mnMnLP8F7eDoZ0/bu+D8+2CHieEPixcs0xmh8k4ZCao+P1XoeqHaMPYORQDm1
         0Hg/ej4cceNPHjo04FKZKM0I1EkqYFgngZ8bz5JLxpThBdYMbzANM2oSr+izfCc46myS
         ssNmhjnXSS+spZWRcFw0DqBmeM43uasiO8ksSy3f5adglt2Ov1NoVc/kSxLuBiAuAwvA
         cfUW0W1I5qvDT4P8LYQ2A5QgGxaqxPx71ERRrIG6C4q8Rs+QY1bSTzaQ2t+4FFAFofdm
         uODUX1fjoBnpwh7xyAjn4+nJjLNsW5GL+qMxR3DLELL1x6M9wauq+IEUzWEHqUg3773a
         gmGA==
X-Gm-Message-State: AOJu0YyGwdDKzM1xDul5CoM+6loIcafKBihjFKnSlVZa4eaGYhIFZVSN
	io/8EHdxOJmCIzd1fzjccrWcefZ0Mc/jbpKLe3ygq+buAejFsy1cKZvQjdEmsdI8gXuQg6/yFgs
	xha4xJlW/qA==
X-Received: from ywbnv26-n1.prod.google.com ([2002:a05:690c:931a:10b0:7bd:f416:6744])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:9986:b0:7dc:aa85:5c67
 with SMTP id 00721157ae682-80135256f16mr3695817b3.11.1781813708157; Thu, 18
 Jun 2026 13:15:08 -0700 (PDT)
Date: Thu, 18 Jun 2026 20:14:54 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618201458.875740-1-jmoroni@google.com>
Subject: [PATCH rdma-next 0/4] RDMA/irdma: Prevent premature deregistration of
 user ring MRs
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
	TAGGED_FROM(0.00)[bounces-22359-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 0E67B6A279F

When a QP/CQ/SRQ is created, a two step process is used where the
buffer is allocated in userspace and explicitly registered with the
normal reg_mr mechanism prior to creating the actual QP/CQ/SRQ object.

Even though these special MRs are internal to the verbs provider,
nothing actually prevents a custom/malicious user application from
manually invoking dereg_mr on these regions. If this occurs, the PBL
is freed and umem is released while the HW may still be accessing it.

Since the core layer is unaware of the relationship between these MRs
and their associated QP/CQ/SRQ objects, refcounting must be performed
in the irdma driver to block any deregistration attempts if the region
is still associated with an active ring object.

Jacob Moroni (4):
  RDMA/irdma: Deduplicate the irdma_del_memlist logic
  RDMA/irdma: Add a refcount to track user ring MR associations
  RDMA/irdma: Add irdma_cq fields to track pbl allocations
  RDMA/irdma: Add refcounting to user ring MRs

 drivers/infiniband/hw/irdma/utils.c |   6 ++
 drivers/infiniband/hw/irdma/verbs.c | 116 ++++++++++++++++++++--------
 drivers/infiniband/hw/irdma/verbs.h |   3 +
 3 files changed, 93 insertions(+), 32 deletions(-)

-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


