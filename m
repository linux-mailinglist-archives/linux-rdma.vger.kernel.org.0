Return-Path: <linux-rdma+bounces-23088-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jqw0J1aRVGrLnQMAu9opvQ
	(envelope-from <linux-rdma+bounces-23088-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 09:18:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC93747F19
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 09:18:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mVklzPwn;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23088-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23088-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A29833033AF7
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 07:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937DB370D6B;
	Mon, 13 Jul 2026 07:17:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A89367B7B;
	Mon, 13 Jul 2026 07:17:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927054; cv=none; b=qN7ph7hQxpD4V9dPwjyD5dd7f1zQLS0QLUNzdtPszfnFgL6cweQfqUH02CPY3vkdcJdccPIWwm7XePoejDMQLqjj39NVE9eIoNS7+Ix8Qw6OQWIbWY8l9M38JbLCzFSdRh9dVRXkLO0pRJb0wP5kVJcbe4H4OB1z+U4T/LZSk4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927054; c=relaxed/simple;
	bh=dU8D4V8tvsrJySrwR2gVQPb9mt0ZOvQF8iVTdyhEZdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jolRQPoryNAo3X4kOSD2LMgHsQA5YEUHSN6P28OUHAPGHRTFxdHqgYenARdqdiQxpUoSswf9Yg1HOWrWU4mDJJTWCJ275UXqA2rbbzFx1SAVqV/Ds1vfopIhQ/omLHUK3BISgnsEfPupj+AKTtNmd8OXPkxV8PQ3R7ogXaeJja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVklzPwn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864261F00A3A;
	Mon, 13 Jul 2026 07:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783927053;
	bh=N1GD0Oj81wk33gSXNYFk26bc8DHHpPqcq8HMI+cgJUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mVklzPwnjtBYd+N3Q1NTXm8l+G32kSV0uADFNMVZ8zoEX2vISW7RRd4d/NPd12JOh
	 DzxIKDw/Yt++8V/vrQHUfVzIi6FQ5tiWtLY0oMeG9eE25+rSnBmB6k1lqEcHp3Ko+M
	 SDTuufoH7QqmiMlseyEIUUScT72Gq+35ghE6HXuXL0Y8HPFf0//qsgaGGQ5PsrymfU
	 RkhBMQlqCLUqscttXvtCJU/wbAbnoqr29BiiAi1Q53EE56nvDVnArYJIWay2NOIyLo
	 Y5h+aMGGNZPCE5Q1kaPFlT+G2B17cd8C2zP+4/u0Q7m3D7ITJXHilhhJh96jwlzB/g
	 qT0T1CnxHBwHg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 13 Jul 2026 10:17:24 +0300
Subject: [PATCH v2 3/5] IB/mthca: mthca_reg_user_mr(): use kmalloc() to
 allocate addresses array
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-rdma-v2-3-65d2a1a5180c@kernel.org>
References: <20260713-b4-rdma-v2-0-65d2a1a5180c@kernel.org>
In-Reply-To: <20260713-b4-rdma-v2-0-65d2a1a5180c@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-rdma@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23088-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:rppt@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rppt@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EC93747F19

mthca_reg_user_mr() allocates an array of DMA addresses during memory
registration.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/infiniband/hw/mthca/mthca_provider.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index f90f67afc8fa..9940165781e1 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -895,7 +895,8 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		goto err_umem;
 	}
 
-	pages = (u64 *) __get_free_page(GFP_KERNEL);
+	/* TODO: switch to "fast and as large as possible" allocation helper */
+	pages = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!pages) {
 		err = -ENOMEM;
 		goto err_mtt;
@@ -924,7 +925,7 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (i)
 		err = mthca_write_mtt(dev, mr->mtt, n, pages, i);
 mtt_done:
-	free_page((unsigned long) pages);
+	kfree(pages);
 	if (err)
 		goto err_mtt;
 

-- 
2.53.0


