Return-Path: <linux-rdma+bounces-17086-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBrYB2jxnGkaMQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17086-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 01:31:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5091803CF
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 01:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ACB630A005A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 00:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A057222580;
	Tue, 24 Feb 2026 00:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h3aSgw4y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F21F12E0
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 00:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771893089; cv=none; b=Wa7qXVTiPzuo8QxOq9XzVougrKklnmBdkeFbRHSEIPoVXanlm6Bbe8+ZlNkPZYysoK1BuQa/ZBmhXa4rFX4pk7OR4zF9n1uXRtC4aJ/28u5RIR9zYZJazm6fzHhkTbsjMwLAT3eZQcvTJO7NphUSR+n20DKL90601mepgmGL2J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771893089; c=relaxed/simple;
	bh=wWEC4736PnYfOLONkyHFbMcvNBdEyudc8K0V6YfEf/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sXxCDWDTVJwTqwEwCyXA2ppoiA4IXOmriV+VwURvEAZrEroCP5RnxqbLA14SolDQUeWyUeDWzyQRzffOt9Xzm3MxBDGc0V0CavWoUWHIek30EFdeORKnIQ8XXoBiC1LedmfEAYeNp67YoZmNR0qnaJQN437hag1J8DoKKu/yJZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h3aSgw4y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=cm+uF+pI6r6VcuzFcklybphQkJLxhNeJMKUB1+x0I6o=; b=h3aSgw4yk+B9KjEA8wCfgzQaLj
	KNb4Zqfib1sWsmTjEvBV2yKyKdqxSdbJXo5gaMTJalbMn+S/i1x5vrY1eYBfcusYRB32sHse1N3ET
	7V8Ji6u38QttvhnZ9eSsI8VXcuUlnbX12cgg7uhaEIO49ojqTxUEJCfErkLKDkLlqK71o9fD2qZnc
	Df+weTLg1p3pwSdlEOSaQ4jmuVKcuoOWgeATyBoeVDLdKt0md1Cx9V/YIjaYwAqYYVD5yz9uYyxbx
	1r6fdVlfQTUBndXJD2rWGMjzzXRghKqWKlY8Th96zJira70KwsGFuOFMObAgCAyg5KX+izCZVVyYd
	eL4a4+8g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vugKk-00000001F7j-3DBZ;
	Tue, 24 Feb 2026 00:31:26 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-rdma@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH] RDMA/umem: fix kernel-doc warnings
Date: Mon, 23 Feb 2026 16:31:20 -0800
Message-ID: <20260224003120.3173892-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17086-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim,infradead.org:email,nvidia.com:email]
X-Rspamd-Queue-Id: 6E5091803CF
X-Rspamd-Action: no action

Add or correct kernel-doc comments to eliminate warnings:

Warning: include/rdma/ib_umem.h:104 function parameter 'biter' not
 described in 'rdma_umem_for_each_dma_block'
Warning: include/rdma/ib_umem.h:140 function parameter 'pgsz_bitmap' not
 described in 'ib_umem_find_best_pgoff'
Warning: include/rdma/ib_umem.h:141 No description found for return
 value of 'ib_umem_find_best_pgoff'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>

 include/rdma/ib_umem.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-next-20260205.orig/include/rdma/ib_umem.h
+++ linux-next-20260205/include/rdma/ib_umem.h
@@ -94,6 +94,7 @@ static inline bool __rdma_umem_block_ite
 /**
  * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of the umem
  * @umem: umem to iterate over
+ * @biter: block iterator variable
  * @pgsz: Page size to split the list into
  *
  * pgsz must be <= PAGE_SIZE or computed by ib_umem_find_best_pgsz(). The
@@ -121,7 +122,7 @@ unsigned long ib_umem_find_best_pgsz(str
  * ib_umem_find_best_pgoff - Find best HW page size
  *
  * @umem: umem struct
- * @pgsz_bitmap bitmap of HW supported page sizes
+ * @pgsz_bitmap: bitmap of HW supported page sizes
  * @pgoff_bitmask: Mask of bits that can be represented with an offset
  *
  * This is very similar to ib_umem_find_best_pgsz() except instead of accepting
@@ -134,6 +135,9 @@ unsigned long ib_umem_find_best_pgsz(str
  *
  * If the pgoff_bitmask requires either alignment in the low bit or an
  * unavailable page size for the high bits, this function returns 0.
+ *
+ * Returns: best HW page size for the parameters or 0 if none available
+ *   for the given parameters.
  */
 static inline unsigned long ib_umem_find_best_pgoff(struct ib_umem *umem,
 						    unsigned long pgsz_bitmap,

