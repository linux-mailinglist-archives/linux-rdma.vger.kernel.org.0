Return-Path: <linux-rdma+bounces-18213-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBfZFnZWuGmKcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18213-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:13:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1456F29F9C8
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E80830333D6
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529A73F0748;
	Mon, 16 Mar 2026 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRyYIodO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6353EFD21;
	Mon, 16 Mar 2026 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688065; cv=none; b=Dd6hKr6mKa4n3NQpDuXPdjfVPP0s4K3PTpf/XnXT6KCT4r5MwElEftmNDXjK4pd0R8LFJ9hckQ94DV4Mb4wyJspaHVAW9tEQKOkwTl/nW48S05s6bXgCoKFaUL1aNzfQ4ghta7N8o3lyt7VDQJmWTQDDrIxI9xQi/5/JWgcns/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688065; c=relaxed/simple;
	bh=ZPv8i4FB+9gmQ6im9/gIYrUtjuhhh3DQksE2tI3ZIHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2XqLaIt3dVo7b6WOCxDy7fTtxpsX+ANLwXudm+Ty0HSkktz+YN0WlYTpcgq+8Th4pfPkC13oDU/m2AGUL8d3NKhjFvEYJr4xf2s2CB+tCpdk6S2lNOPmgua54Wgs968FrLDy+mUl7D+bC6KS69SIM9c9a9gVRJzcRXzMY28rdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRyYIodO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0505C2BC9E;
	Mon, 16 Mar 2026 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773688064;
	bh=ZPv8i4FB+9gmQ6im9/gIYrUtjuhhh3DQksE2tI3ZIHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRyYIodOfdcUjLcCDu/jidDUh2A0CrnVqmtrZoS38nnxbv1K9xKH4U2nERAxw5Dnr
	 xpZMTzOwGgNefLLEJdu7kIACNybDBIMeL2gjYa/WsKkEztHVvNTf3FGyuY67ZRhp+B
	 VVAoPRKw7x3JJlrrtCVE+XCdZ9KBdWNwdoyr/19oYyN0h4MOOzpQgv0brQidAnBnWt
	 IAidaFL/EszVCVmuUZfxp1MrjtA+RoOGA+j/sIW0az0Wpz08Zo769/4qrzdnIx+1mD
	 unjW1nqdLdGReK4dBwDjXVamQtoCFyEea/CaTevOe/aCsHEI+wMr6SICzVMhes72VG
	 AYqyNZR5FO0ow==
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
	linux-mm@kvack.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 8/8] mm/hmm: Indicate that HMM requires DMA coherency
Date: Mon, 16 Mar 2026 21:06:52 +0200
Message-ID: <20260316-dma-debug-overlap-v3-8-1dde90a7f08b@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-18213-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 1456F29F9C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

HMM is fundamentally about allowing a sophisticated device to perform DMA
directly to a process’s memory while the CPU accesses that same memory at
the same time. It is similar to SVA but does not rely on IOMMU support.
Because the entire model depends on concurrent access to shared memory, it
fails as a uAPI if SWIOTLB substitutes the memory or if the CPU caches are
not coherent with DMA.

Until now, there has been no reliable way to report this, and various
approximations have been used:

int hmm_dma_map_alloc(struct device *dev, struct hmm_dma_map *map,
                      size_t nr_entries, size_t dma_entry_size)
{
<...>
        /*
         * The HMM API violates our normal DMA buffer ownership rules and can't
         * transfer buffer ownership.  The dma_addressing_limited() check is a
         * best approximation to ensure no swiotlb buffering happens.
         */
        dma_need_sync = !dev->dma_skip_sync;
        if (dma_need_sync || dma_addressing_limited(dev))
                return -EOPNOTSUPP;

So let's mark mapped buffers with DMA_ATTR_REQUIRE_COHERENT attribute
to prevent silent data corruption if someone tries to use hmm in a system
with swiotlb or incoherent DMA

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 mm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index f6c4ddff4bd61..5955f2f0c83db 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -778,7 +778,7 @@ dma_addr_t hmm_dma_map_pfn(struct device *dev, struct hmm_dma_map *map,
 	struct page *page = hmm_pfn_to_page(pfns[idx]);
 	phys_addr_t paddr = hmm_pfn_to_phys(pfns[idx]);
 	size_t offset = idx * map->dma_entry_size;
-	unsigned long attrs = 0;
+	unsigned long attrs = DMA_ATTR_REQUIRE_COHERENT;
 	dma_addr_t dma_addr;
 	int ret;
 
@@ -871,7 +871,7 @@ bool hmm_dma_unmap_pfn(struct device *dev, struct hmm_dma_map *map, size_t idx)
 	struct dma_iova_state *state = &map->state;
 	dma_addr_t *dma_addrs = map->dma_list;
 	unsigned long *pfns = map->pfn_list;
-	unsigned long attrs = 0;
+	unsigned long attrs = DMA_ATTR_REQUIRE_COHERENT;
 
 	if ((pfns[idx] & valid_dma) != valid_dma)
 		return false;

-- 
2.53.0


