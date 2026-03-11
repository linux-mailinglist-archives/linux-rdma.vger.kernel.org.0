Return-Path: <linux-rdma+bounces-18022-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M5pFia/sWkwFAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18022-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:14:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AB9269249
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 353E6316360F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 19:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1053EC2C0;
	Wed, 11 Mar 2026 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHKnRO6y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C643CF032;
	Wed, 11 Mar 2026 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256167; cv=none; b=HQj+w29171Ow5h7l8P4L6Vinb8c7wFkc7olWZYYidW8OfUAGSonlFHL3cY59g37sf3FwGJaO3LiO8L6cOTad3VmwAMSlWTO5R8yPcGwLy2DzCVnJcEj6AF3/eOJOAqFtRm9q39n1H+Jd0QNroe4av/ShUudwqhOAweNYH8LTzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256167; c=relaxed/simple;
	bh=8pwuaCiDUSCBcuJ0n9V3xnzMZmgOorpLbuob290/9q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puo1njSIq/6zKedsvaB/xzth4NRfb/WxHRy5OGZND7oJfgyR78VAgSsKoSqH/QB9IrWtYDrJK6xUMi4bPaa9xfdj9Q+fMCW3+56E2Y3EtaSJgzzUJjz/2HAXjHj7+jQ0z9ufHHGjY42r1mwbXYdNiLXol32NAMBc+rvjZ7Xu+Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHKnRO6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8658CC4CEF7;
	Wed, 11 Mar 2026 19:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773256167;
	bh=8pwuaCiDUSCBcuJ0n9V3xnzMZmgOorpLbuob290/9q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHKnRO6yqtY5rofM6SDr4DHDapAJhsI0XJQi4O9p65/khxIvwwDdKmxcfP8QYi6A2
	 m104LZo+8JeIN3EoFgQM5Elab2cHsl5k8qdT1jPMH3o3Dzz6r5kBM+nkshU7bgmuWj
	 iEcMBWWDHna5UV8c+CTUfuJ6W6gkfU1mWntrsCIn5VobxHkCLxQcD7/p0cM11R/5kr
	 F2/iLjoVMLIfU9H6nkJoCL4rhAdIR+aXP4WOX2Dvv4Kv8MnhhPCcvvORJXpnDAduD5
	 uVQcX6poI5WbBIl7IXu3Irg6tUKQGpfuh/AJs2iPba4QxwYO9dwxL3VAGMO2PcW34p
	 Tzux8OKSdH0Mw==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 5/8] dma-direct: prevent SWIOTLB path when DMA_ATTR_REQUIRE_COHERENT is set
Date: Wed, 11 Mar 2026 21:08:48 +0200
Message-ID: <20260311-dma-debug-overlap-v2-5-e00bc2ca346d@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18022-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: F0AB9269249
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

DMA_ATTR_REQUIRE_COHERENT indicates that SWIOTLB must not be used.
Ensure the SWIOTLB path is declined whenever the DMA direct path is
selected.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/direct.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index e89f175e9c2d0..6184ff303f080 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -84,7 +84,7 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 	dma_addr_t dma_addr;
 
 	if (is_swiotlb_force_bounce(dev)) {
-		if (attrs & DMA_ATTR_MMIO)
+		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
 			return DMA_MAPPING_ERROR;
 
 		return swiotlb_map(dev, phys, size, dir, attrs);
@@ -98,7 +98,8 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 		dma_addr = phys_to_dma(dev, phys);
 		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
 		    dma_kmalloc_needs_bounce(dev, size, dir)) {
-			if (is_swiotlb_active(dev))
+			if (is_swiotlb_active(dev) &&
+			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
 				return swiotlb_map(dev, phys, size, dir, attrs);
 
 			goto err_overflow;
@@ -123,7 +124,7 @@ static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
 {
 	phys_addr_t phys;
 
-	if (attrs & DMA_ATTR_MMIO)
+	if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
 		/* nothing to do: uncached and no swiotlb */
 		return;
 

-- 
2.53.0


