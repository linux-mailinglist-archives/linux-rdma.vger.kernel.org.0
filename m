Return-Path: <linux-rdma+bounces-23278-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6KO3JBVqV2rTMwEAu9opvQ
	(envelope-from <linux-rdma+bounces-23278-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 13:08:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1023275D4DE
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 13:08:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hyILeJOd;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23278-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23278-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74BB53142743
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41346432BC5;
	Wed, 15 Jul 2026 11:03:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03141D63E;
	Wed, 15 Jul 2026 11:03:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113431; cv=none; b=Ay5J+zom6i+wgIh7VR+OfqvdJhlrQgpL1zOtiHn08f08V+jl55RUZ9BhQS/YIOV1lH840eeAuUpv1PAoMF85HvDbcxJd4nP+pSziReOmAgOhievQ5YqAnIuAAborihjz7x5ogMpfaoCxtyjTzjRyYAGLws4gxJy1uM6MVdkChAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113431; c=relaxed/simple;
	bh=tHqJEhY8nKEHbH40oSO2VwHqpVReYeEZYB4VJKU4WCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1nT9BNg1HB0LHWZmC3sBzyfmBq44LJRv/qk2Q7Q+DE4/t6ESp6gwTY1MmEGQ/1YKaMo9wjMmLxkGm7Fc5npCaVzrsTIzTH/lnnqtFPA2URpKmK1LN/07vEEA7A9uLnDVS1C37ERpm3Ylhub9ciVGsg1dxrLTsA92ZwKQWpiOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyILeJOd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27491F0155F;
	Wed, 15 Jul 2026 11:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784113423;
	bh=avljnXKrp0xXdt8T2yC/othJrQltLuKsk1y5OVGjVfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hyILeJOdi0ogtH7mULO81b+ru9V41C4HPsXQhjrNJ9QuDUdyVWVRMlVDwj4RSGpER
	 lVWV443A8scgVqo2d5L2jGTwmvbeG/Bum7mX/c9Wc7/EZBGP6/hOr6CJDjTSmJzz8t
	 hvYoV8KnZq4KfSF9wbM0JNuh6HflGrGWoxhXZIIo9q2gKCPdgcP7H1S/xgJImWdxXG
	 oFNICx6Kr6jS24qupwammUdbuYxdL2ap3MqEIGBH4y/POL2JNsjiTQXs/VsAulQuTX
	 J2VdcvzvRuZD3woSkk0rEkE0gGcwSy4/Dg5vrbhwk++xf+HoqYkR7FMk7X9FB4e0ep
	 WunzM+2PGOtxQ==
From: Leon Romanovsky <leon@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yishai Hadas <yishaih@nvidia.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH rdma-next 3/4] RDMA/usnic: use kmalloc() for the page pointer array
Date: Wed, 15 Jul 2026 14:03:11 +0300
Message-ID: <20260715-get_pages-to-kmalloc-v1-3-b0b7fce288be@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715-get_pages-to-kmalloc-v1-0-b0b7fce288be@nvidia.com>
References: <20260715-get_pages-to-kmalloc-v1-0-b0b7fce288be@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bharat@chelsio.com,m:jgg@ziepe.ca,m:yishaih@nvidia.com,m:neescoba@cisco.com,m:satishkh@cisco.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rppt@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23278-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1023275D4DE

From: Leon Romanovsky <leonro@nvidia.com>

usnic_uiom_get_pages() uses a page-sized array of struct page pointers
as temporary storage for pin_user_pages(). Nothing requires the array to
come directly from the page allocator.

Use kmalloc() for the array and kfree() after the pinning loop.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/usnic/usnic_uiom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 691c64a73516..201c35039a74 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -114,7 +114,7 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 
 	INIT_LIST_HEAD(chunk_list);
 
-	page_list = (struct page **) __get_free_page(GFP_KERNEL);
+	page_list = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!page_list)
 		return -ENOMEM;
 
@@ -182,7 +182,7 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 		mmgrab(uiomr->owning_mm);
 
 	mmap_read_unlock(mm);
-	free_page((unsigned long) page_list);
+	kfree(page_list);
 	return ret;
 }
 

-- 
2.55.0


