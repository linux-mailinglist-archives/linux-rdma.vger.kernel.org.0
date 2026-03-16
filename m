Return-Path: <linux-rdma+bounces-18210-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KvmLQBWuGmKcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18210-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:12:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F18329F938
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E99C305E821
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99983EF640;
	Mon, 16 Mar 2026 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qShwIFNF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E03EF0B8;
	Mon, 16 Mar 2026 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688050; cv=none; b=CGsoYKYlABHtXx32Sz1w2Q9eevxEH8qENdNViN2iI+hEyirvp1a4iJQR1tRQ72F+9DfG3F0T8WVHlujQXTT12aSqYqKb9xOleahEat8iatYGwKV1iA3Hb47k13AXvNK3T/TibC4i5nxVaTKLzAjiwhL/WAFvLt0kS/NkdYUGp9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688050; c=relaxed/simple;
	bh=aXwCdr26DGL4+NaZEE3PT+YDkt3E2yVN7za/ReeSxow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a84LPs3i3nZ3lyq2832cfJ1ZPeiSUJy6UiBlrAKWAhnT9gkk9d95tCIOpw7Y9xJjx0TrcqrYIPGa3cznUkuz620FC0eBMO0isxVAvDcGdDSEb/GDVVAVSUyVj/rSb2As7NtD1Glu9rq9Z9xiDCBkfAqugeQiT5dvBnhLmy2R7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qShwIFNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BF4C19421;
	Mon, 16 Mar 2026 19:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773688050;
	bh=aXwCdr26DGL4+NaZEE3PT+YDkt3E2yVN7za/ReeSxow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qShwIFNFGuszc3wiBhUM/dXxzghLUfqSxNk6dSgejFCa16sP7mJ0YnF6nuboDJQ0I
	 V1hdbvS1Cw4Q8UMNmIyZewdSbxL6PjFsKqY3LNx7tSYGdDqKW1taN6l2fo9mdtgC8y
	 iHvFgLqcBiNy7tYnGM7quwPT+cd6RXOSvqXFQIO3R0aHDLowDG6fgtIPenYBLlYyQi
	 8npPn1RHBtah/rBZsE9wx+ixSFiZXVoxr3c+0eLM5qx/BZ1L86QMlxbXrzlzw+5VLo
	 owZUj8Y7VbcTo2sOQlqSsHYt9BPLxuC7yd10mWvitREI5onnc8psViY7rBblB38Pad
	 i7l8YW5XaRDUA==
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
Subject: [PATCH v3 6/8] iommu/dma: add support for DMA_ATTR_REQUIRE_COHERENT attribute
Date: Mon, 16 Mar 2026 21:06:50 +0200
Message-ID: <20260316-dma-debug-overlap-v3-6-1dde90a7f08b@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
References: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18210-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F18329F938
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

Add support for the DMA_ATTR_REQUIRE_COHERENT attribute to the exported
functions. This attribute indicates that the SWIOTLB path must not be
used and that no sync operations should be performed.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5dac64be61bb2..94d5141696424 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1211,7 +1211,7 @@ dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 	 */
 	if (dev_use_swiotlb(dev, size, dir) &&
 	    iova_unaligned(iovad, phys, size)) {
-		if (attrs & DMA_ATTR_MMIO)
+		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
 			return DMA_MAPPING_ERROR;
 
 		phys = iommu_dma_map_swiotlb(dev, phys, size, dir, attrs);
@@ -1223,7 +1223,8 @@ dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 		arch_sync_dma_for_device(phys, size, dir);
 
 	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
-	if (iova == DMA_MAPPING_ERROR && !(attrs & DMA_ATTR_MMIO))
+	if (iova == DMA_MAPPING_ERROR &&
+	    !(attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT)))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 	return iova;
 }
@@ -1233,7 +1234,7 @@ void iommu_dma_unmap_phys(struct device *dev, dma_addr_t dma_handle,
 {
 	phys_addr_t phys;
 
-	if (attrs & DMA_ATTR_MMIO) {
+	if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT)) {
 		__iommu_dma_unmap(dev, dma_handle, size);
 		return;
 	}
@@ -1945,9 +1946,21 @@ int dma_iova_link(struct device *dev, struct dma_iova_state *state,
 	if (WARN_ON_ONCE(iova_start_pad && offset > 0))
 		return -EIO;
 
+	/*
+	 * DMA_IOVA_USE_SWIOTLB is set on state after some entry
+	 * took SWIOTLB path, which we were supposed to prevent
+	 * for DMA_ATTR_REQUIRE_COHERENT attribute.
+	 */
+	if (WARN_ON_ONCE((state->__size & DMA_IOVA_USE_SWIOTLB) &&
+			 (attrs & DMA_ATTR_REQUIRE_COHERENT)))
+		return -EOPNOTSUPP;
+
+	if (!dev_is_dma_coherent(dev) && (attrs & DMA_ATTR_REQUIRE_COHERENT))
+		return -EOPNOTSUPP;
+
 	if (dev_use_swiotlb(dev, size, dir) &&
 	    iova_unaligned(iovad, phys, size)) {
-		if (attrs & DMA_ATTR_MMIO)
+		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
 			return -EPERM;
 
 		return iommu_dma_iova_link_swiotlb(dev, state, phys, offset,

-- 
2.53.0


