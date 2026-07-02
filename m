Return-Path: <linux-rdma+bounces-22716-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zo1aNr2oRmrObAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22716-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:06:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 220C36FBD8C
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:06:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=LQM6cCLP;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22716-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22716-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D2EE33E7800
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EF034389B;
	Thu,  2 Jul 2026 17:07:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1412A33BBCD
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 17:07:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012040; cv=none; b=lOgZ0wkQa4rCTNl6BoonxXCoe7b+AeiObMWy45llCGnut8AV3FL49+vlEohtJ42qN/e5zEI0xoeBB/N1j5vguRNaV5jgRUD6SA0BSCiNK3jjrP6OWXKGJkL1yzfSBBuV+zvIsBozpqAWlcZYMszsBYglGlK881fG27ag6WTVrD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012040; c=relaxed/simple;
	bh=77b4DEjKe++cR93KODwOEfOSQWz3rtuxIljYgYHike0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RDPYtO7PTx9tKwsdxozZwoYifhK299zcGXBOqnC4A1Gysb6QR+7z7v7UT5TT4U361HGxLSIIB8Ed/ZCDOYUufSuyuz4988HqdVOdqTSCZBOSzNbdI/82E1W1w7ihM5LI+HQOcwJ2h6TyjJr+FqatCGhXjTIH/j9/NAP1cd4qt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LQM6cCLP; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-92da6f3cc81so232594685a.2
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783012038; x=1783616838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhWOVv+KL4zuExZFk/oHe2JPGTWhuhvyBNDCamcxCUA=;
        b=LQM6cCLPCPuTzgp04YLjbIm7zmGK+cJw/qN1XcZ4au9MaN9WDVMq/gAZ6BTexrgRpG
         CiK1T1ohfrTevbn/4xSvqMbJfq9W6a1VaTmu6DvrNvbCLnUWd4IQC9IwCACud50JBisx
         cdIn3ZmYSqURwQ3yFM6sGN7C0LcKi9QGTNtOzVI38F8fnh2zAny6AfmYPmoaYknyOlKx
         mCyJTPdv+TaxI5kndqjeRycrbH31ZWkfMr3hYhcjedFQ4c+uod2Htnixb7VwuQKO1P/c
         Y1TlGJtkb9Gwg7UqxyVjdhnlFmvf/fobRnhP1P4mG+35R4zav0JbH3uOuQW6QZ6125dy
         oTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012038; x=1783616838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhWOVv+KL4zuExZFk/oHe2JPGTWhuhvyBNDCamcxCUA=;
        b=ARwkYFBu6TseC6Ffpz1Qn6nIR3GSlRXzJiv9Oo3l9mk4FwwEmdBP2hFnY1rAuXSKSU
         +iI0a/BN4JOioTIdGhl4Ir4MI7glPtrHythYQo6/u2sy7gg+r6ZOqG1PYIOthX6CTPpT
         HGn9vAEE1RzA2y3Zlc0zVAh7D3G0W3k4oh7WFk4L/Uj1x8UN9kXdjTG4AF2U3sCIky1S
         S6TqYsLH3WsWYbaaerc4PxBZ9wKohQK5tHHMuR1FG816nQergmbklRAEuEniZGpqTMXu
         LMxxRvhPLxHJ8KElXbO4zufd75pDhMboW4OIwSP/LjPO/UXNZOKakutH2dIg7qrRmI+q
         V0+A==
X-Gm-Message-State: AOJu0Yx2KSDkL6wMkxB+OFbKKd1hjVR2esZjd6TE6VrdjcUM+jtIaSKf
	+CIYJfZ3M5efJ7oXOn9rCaCGeOw68jRp0eeGzddJsSLsTurl3ryGpGayrd8L5+tZq/chiZEFz5j
	DXQeWebqOFQ==
X-Received: from qknqk10.prod.google.com ([2002:a05:620a:888a:b0:92e:6008:ef8d])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:28c9:b0:914:bc2f:baf7
 with SMTP id af79cd13be357-92e7b0139b2mr769004185a.4.1783012037749; Thu, 02
 Jul 2026 10:07:17 -0700 (PDT)
Date: Thu,  2 Jul 2026 17:06:51 +0000
In-Reply-To: <20260702170652.4159201-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702170652.4159201-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702170652.4159201-7-jmoroni@google.com>
Subject: [PATCH rdma-next v3 6/7] RDMA/irdma: Fix legacy i40iw compat check in create_qp
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
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22716-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 220C36FBD8C

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
index 00a648922c7b..d8374f7afa87 100644
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
2.55.0.rc0.799.gd6f94ed593-goog


