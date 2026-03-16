Return-Path: <linux-rdma+bounces-18212-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHyWCIhVuGmKcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18212-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:10:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BD229F8DA
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65C583027E02
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB963EFD11;
	Mon, 16 Mar 2026 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCGCn64m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD73EDABB;
	Mon, 16 Mar 2026 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688060; cv=none; b=INKpSXWtDhy4+hDy8Aa2HaOvA7TJBXEfBR6YhpSOK20KringqoUAclDt955kmd/nqNJ4+JB6Nn4+kP0vXZ9GlHMTjyYd4okaWctTlrYSGx/GKVyw9h/98rygvlX+m5Bg3GShBy4zevt00WCVSnmOkuf8l8rJnL8I5fle+0fxdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688060; c=relaxed/simple;
	bh=8pwuaCiDUSCBcuJ0n9V3xnzMZmgOorpLbuob290/9q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQC0mVB3nO7A0B+jUtjyoPJMG8EjoYYF8O9XkjQU3oDuwWbP8sHgDKPk4J59BY18WFoQcfyw8Gr+c2lTDmP/6pMyQC4qT8LSeMfyYEuPZs6fBgqiOEkkVAlRNucs6IQDy0GZ17VSjY1FDXUnlJxeanvEf/j0OWlFiUa8BnMLTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCGCn64m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17F4C2BC87;
	Mon, 16 Mar 2026 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773688059;
	bh=8pwuaCiDUSCBcuJ0n9V3xnzMZmgOorpLbuob290/9q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GCGCn64m17HUEqXK/h5IorRImzMcDPJU0tCmJDbB3L4vZKoJ0IPFeBCRy+wsuVOsq
	 QdLTqB+gMICogw/16bSnE5fKFrNacTDn0dgvpd9diHLoKz+MPcFcA3Moa3f7VJeLjJ
	 1ej0Ud0wWhcmuYammtYQZHu2U6ujMP2SzDcIO/KtqJUu3zi2ahSbrZoMmCZZRQkJ0r
	 G8Hmu6p0/RxKO0n5ZlwCOD7NB007g+yepdwOdggQWqPLaCSyWzx36KVZ7tV6Qx3o/c
	 VUo3XtlNgXCcmPathZVid/O+mA8txRCpS7WCOQ9I3ZLhHxZyH7AYAGU+Kep7Jz77mP
	 /gXA1Yq4XBbOA==
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
Subject: [PATCH v3 5/8] dma-direct: prevent SWIOTLB path when DMA_ATTR_REQUIRE_COHERENT is set
Date: Mon, 16 Mar 2026 21:06:49 +0200
Message-ID: <20260316-dma-debug-overlap-v3-5-1dde90a7f08b@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18212-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6BD229F8DA
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


