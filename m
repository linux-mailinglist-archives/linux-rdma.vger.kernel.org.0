Return-Path: <linux-rdma+bounces-23086-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YCYmGCiRVGrBnQMAu9opvQ
	(envelope-from <linux-rdma+bounces-23086-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 09:18:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C497F747EF9
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 09:17:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mK7Rs7Ep;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23086-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23086-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3389B3025C7F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 07:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FBA368296;
	Mon, 13 Jul 2026 07:17:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DAF369991;
	Mon, 13 Jul 2026 07:17:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927050; cv=none; b=fHlr67kFmGJgLnAcuBFNNqNE3y2IQ8AwS9lXMP36Hie+bnLVPoHsEbfVwa4S7TC+zPVD+hpdg3v4uFuRfSnIqs6Q4yDDBN2dynZdnPt1a2suePQiaWq9Id37rn6Lzch4wHrLqLZ2LshIsxFLpGyTgFGY2pC7vApU6KDgFii+BJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927050; c=relaxed/simple;
	bh=LzIP6fu0a/gDtXYl3FhLJ6KZZBXl115F0W3SEbdUqaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UZbJd/5G+BqovHPOpZgQV1ack0vZUSjPWolNYz9ZT7LMlRFBH+5xFDgpU+6yqyKycMHeidPsQEScPoIh15dyJTEOyqxzxL9oZ377eJZTKXVowk88hn8TMsqpzUqzUB+r3OsmnOXJviBJ3oW6+YbktNbOC2rqMj91EIPYpVD49B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mK7Rs7Ep; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AE91F00A3A;
	Mon, 13 Jul 2026 07:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783927048;
	bh=uWIVcjeEM70jyTaGHVgY1Rp3qpXgQEqVNmxGrIcRzKo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mK7Rs7Ep2oHn7rc1lfqFdey6hB435+rCXTeAcd4DVnnNK0XLMIaVlziT5O8hxIvLb
	 UvjsqfP7CFqucFochDH4MO8liVKybOtB/MpvIkXF+UXRbIdgeK5cyqUJ23NnezYe4k
	 1CyVypk/ieWMmRUqBFK48kK+DdRpdDp14sqrdYo7aQhAIAwJExbfxbbxW9eBWrDNWI
	 yQ/587Sxd9rWeCacocCogH4nCaJSoq3zF4NEinV+4c66JO63tYnA1exxwVPjupPzgJ
	 re/RsnjkCnKo2BIVPEM1vSW/Y6wuKAs+uGaXcOHdG0ZdZELLsioRWTsSlTTuBeq5Sy
	 lX2LdrbLdp/4w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 13 Jul 2026 10:17:22 +0300
Subject: [PATCH v2 1/5] RDMA/umem: ib_umem_get(): use kmalloc() to allocate
 page array
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-rdma-v2-1-65d2a1a5180c@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-23086-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C497F747EF9

ib_umem_get() allocates an array of pointers to struct page for
pin_user_pages_fast() calls during memory registration.

This array can be allocated with kmalloc() as there's nothing special
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
 drivers/infiniband/core/umem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 73498723a5d5..81f44dadfa52 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -209,7 +209,8 @@ static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
 
 	mmgrab(mm);
 
-	page_list = (struct page **) __get_free_page(GFP_KERNEL);
+	/* TODO: switch to "fast and as large as possible" allocation helper */
+	page_list = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!page_list) {
 		ret = -ENOMEM;
 		goto umem_kfree;
@@ -269,7 +270,7 @@ static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
 	__ib_umem_release(device, umem, 0);
 	atomic64_sub(ib_umem_num_pages(umem), &mm->pinned_vm);
 out:
-	free_page((unsigned long) page_list);
+	kfree(page_list);
 umem_kfree:
 	if (ret) {
 		mmdrop(umem->owning_mm);

-- 
2.53.0


