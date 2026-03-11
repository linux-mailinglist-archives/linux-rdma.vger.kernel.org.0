Return-Path: <linux-rdma+bounces-18021-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNMOGYa+sWkwFAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18021-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:12:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D18322691C3
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8BF730A8D30
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DAF3C1400;
	Wed, 11 Mar 2026 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbG1uNUg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DCA2E62C4;
	Wed, 11 Mar 2026 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256164; cv=none; b=slSUUojRqrlLaT5GkvtfCTeBJJeuRatTS6JeDqRQ0p8BavW4DyBV56RfvUkVh/hFG/CrWmBoQoB3lwUnBOXHFuMIIZWri4j2ltFcn9+vsF13aZPFEHbxPvKpr1w+fHalDiIgNRd0EdLLmhFV+Qzr7V0Dm5JpgTKDWKu/K24R3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256164; c=relaxed/simple;
	bh=0UoS5bXBagSWSjZg7zeW+3A+vnJkjeQqWbOv9i9THFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCDdqz9wHcL8f4P9ZC+8kAHacF/zwC1SfsS6Dju6Nk+YkMtflGtbzM4TsrjPbjVA/p8+Kr7Cez67ALGKCulnyzINsjaIfftK7DmLYo0rRFswz5+jrwcVi/79FBGq9Zd8VdeIwF69wteaMErMM53VVen+HB0aIsZNWGOS+6I12cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbG1uNUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11621C4CEF7;
	Wed, 11 Mar 2026 19:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773256163;
	bh=0UoS5bXBagSWSjZg7zeW+3A+vnJkjeQqWbOv9i9THFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LbG1uNUgq/sPRE98pW+ZT3GTFULJ3gWkdpAIhlzPdLfdX5pxbYb4ITlF1lhbKP6iq
	 MQghWEVT49xo+z6Jd1VwWinJTQF25MNokpn8ET2N3EwR8syaKhSSHoWafZm52xyvQM
	 0KkhwoP8HpVYEKOfw6TefQuqKlcbeGxQQdMP7j/xhwru4WpEu1Rq/0kN0tmpmcvwCU
	 K2zLd56Qbc+IV0Qp0sp9JYawQz8u83W38bdwA8Pab+Bwk2cIXDM+qCJB+/qWhFf4sT
	 3aEVAVELkWJ8vkKSvt+0Kot1TRelXPsq7crc7VKcS9VDPgF8WwzsW+jpN/wXdaYTuh
	 MNcha2q9yYS6w==
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
Subject: [PATCH v2 8/8] mm/hmm: Indicate that HMM requires DMA coherency
Date: Wed, 11 Mar 2026 21:08:51 +0200
Message-ID: <20260311-dma-debug-overlap-v2-8-e00bc2ca346d@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18021-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: D18322691C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

HMM mirroring can work on coherent systems without SWIOTLB path only.
Until introduction of DMA_ATTR_REQUIRE_COHERENT, there was no reliable
way to indicate that and various approximation was done:

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
to prevent DMA debugging warnings for cache overlapped entries.

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


