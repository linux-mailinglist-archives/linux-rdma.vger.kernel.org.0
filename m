Return-Path: <linux-rdma+bounces-18017-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE3XM/q+sWkwFAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18017-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:14:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD4D269215
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 20:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E853326640D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 19:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E2D36EA8A;
	Wed, 11 Mar 2026 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uX7fuLiv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E105D366DCC;
	Wed, 11 Mar 2026 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256149; cv=none; b=MQ9GCDAi8enyT52wRJJdoUdAjtTpckkIls6QxxJVRruRWPAnktL4FKgQCAp/bxPHaeMN6KELfFkDqytRFZtTZp4DEEru37vaZftCSGjw/9C1uf+ueiycI5BvbYwsj28ZQ+1ztmQFkKYhENL44AYr+k7JHdmJ0jWyFnof2Yn7+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256149; c=relaxed/simple;
	bh=Caib8MH0BZPS5GoBVp5443hRjoVeLP/iROeH38ZKBek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8n93Kpz1PIW6+GO7inilj6LIOYWwEO/wUhv+ppnBFWNv6dk5q5IQapmqlTAHluvQs4rYUmY0Kxr0buygGQ5ridaR1pG+HWZDoZk2yZXMaeAXk2b5EOT/Vfan9e03zORhuiiT336WKjWVdO8hukIlhf/Mcn/WwJKmMhFyVw3kSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uX7fuLiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEB6C4CEF7;
	Wed, 11 Mar 2026 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773256148;
	bh=Caib8MH0BZPS5GoBVp5443hRjoVeLP/iROeH38ZKBek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uX7fuLiv2dqrXYExHFjcHx7N9C8rKXe9c03Xu0WIBHJmwCB9rHlFRYKVS82RDSyi4
	 SbhA5HmIgdVVR4KsVb4/1mFJ6KqvncGYuwNwZSda5Zjon4pY9/tgioJs2Xm+pql3oh
	 LWyIiOyY0mGkP9F1jPPS2RsqY9jiS9KoqgyrB3rH9emmpAG8tV5IR6xKxuWhUftFkI
	 fZ3veNg46sNPb7csrLsgu0bdyxFY4IjnGZY9iHwkH2f2DipheEWOq90pkMcFloOXvW
	 Q8awvutvZGHd2RgO5mAfioeREd771cZIuR58KwK+upvv/yITUKz0VacsDBuOe3Sr4T
	 IsZWX4Mz5m9Mw==
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
Subject: [PATCH v2 4/8] dma-mapping: Introduce DMA require coherency attribute
Date: Wed, 11 Mar 2026 21:08:47 +0200
Message-ID: <20260311-dma-debug-overlap-v2-4-e00bc2ca346d@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18017-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 2CD4D269215
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

The mapping buffers which carry this attribute require DMA coherent system.
This means that they can't take SWIOTLB path, can perform CPU cache overlap
and doesn't perform cache flushing.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/core-api/dma-attributes.rst | 12 ++++++++++++
 include/linux/dma-mapping.h               |  7 +++++++
 include/trace/events/dma.h                |  3 ++-
 kernel/dma/debug.c                        |  3 ++-
 kernel/dma/mapping.c                      |  6 ++++++
 5 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 48cfe86cc06d7..69d094f144c70 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -163,3 +163,15 @@ data corruption.
 
 All mappings that share a cache line must set this attribute to suppress DMA
 debug warnings about overlapping mappings.
+
+DMA_ATTR_REQUIRE_COHERENT
+-------------------------
+
+The mapping buffers which carry this attribute require DMA coherent system. This means
+that they can't take SWIOTLB path, can perform CPU cache overlap and doesn't perform
+cache flushing.
+
+If the mapping has this attribute then it is prevented from running on systems
+where these cache artifacts can cause corruption, and as such doesn't need
+cache overlapping debugging code (same behavior as for
+DMA_ATTR_DEBUGGING_IGNORE_CACHELINES).
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index da44394b3a1a7..482b919f040f7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -86,6 +86,13 @@
  */
 #define DMA_ATTR_DEBUGGING_IGNORE_CACHELINES	(1UL << 11)
 
+/*
+ * DMA_ATTR_REQUIRE_COHERENT: Indicates that DMA coherency is required.
+ * All mappings that carry this attribute can't work with SWIOTLB and cache
+ * flushing.
+ */
+#define DMA_ATTR_REQUIRE_COHERENT	(1UL << 12)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 8c64bc0721fe4..63597b0044247 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -33,7 +33,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
 		{ DMA_ATTR_NO_WARN, "NO_WARN" }, \
 		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
 		{ DMA_ATTR_MMIO, "MMIO" }, \
-		{ DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, "CACHELINES_OVERLAP" })
+		{ DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, "CACHELINES_OVERLAP" }, \
+		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" })
 
 DECLARE_EVENT_CLASS(dma_map,
 	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 83e1cfe05f08d..0677918f06a80 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -601,7 +601,8 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 	unsigned long flags;
 	int rc;
 
-	entry->is_cache_clean = attrs & DMA_ATTR_DEBUGGING_IGNORE_CACHELINES;
+	entry->is_cache_clean = attrs & (DMA_ATTR_DEBUGGING_IGNORE_CACHELINES |
+					 DMA_ATTR_REQUIRE_COHERENT);
 
 	bucket = get_hash_bucket(entry, &flags);
 	hash_bucket_add(bucket, entry);
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 3928a509c44c2..6d3dd0bd3a886 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -164,6 +164,9 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 	if (WARN_ON_ONCE(!dev->dma_mask))
 		return DMA_MAPPING_ERROR;
 
+	if (!dev_is_dma_coherent(dev) && (attrs & DMA_ATTR_REQUIRE_COHERENT))
+		return DMA_MAPPING_ERROR;
+
 	if (dma_map_direct(dev, ops) ||
 	    (!is_mmio && arch_dma_map_phys_direct(dev, phys + size)))
 		addr = dma_direct_map_phys(dev, phys, size, dir, attrs);
@@ -235,6 +238,9 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 
 	BUG_ON(!valid_dma_direction(dir));
 
+	if (!dev_is_dma_coherent(dev) && (attrs & DMA_ATTR_REQUIRE_COHERENT))
+		return -EOPNOTSUPP;
+
 	if (WARN_ON_ONCE(!dev->dma_mask))
 		return 0;
 

-- 
2.53.0


