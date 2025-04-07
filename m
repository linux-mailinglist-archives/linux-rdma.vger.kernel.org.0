Return-Path: <linux-rdma+bounces-9198-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E955BA7E7B8
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 19:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E9844049A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 16:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C80E21771F;
	Mon,  7 Apr 2025 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGJcTuru"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA03A14A4C6
	for <linux-rdma@vger.kernel.org>; Mon,  7 Apr 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044929; cv=none; b=XWaTqa+F0TkRa4H94BFZ5uLAO26coXGr4fH1Nc8yU6osCXAotzAZSTG8wzXB1m8UR1Lk0jLjCK3Wrna2CQqQ47xGWm93zX3fmB472uJGAar31eSLpFzBG/Ldex/+3Cn5OZShC9C33gjigeY1XvRA+4XoW+mX8XBZvH90ORdk5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044929; c=relaxed/simple;
	bh=VfEr44wnQ1peg9OWFMsfhfuaaRb0JefOs48WafKrrdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L1IOIJZGAcp7n68JKQ9s7jR6hbVEteClSHBYX6tw1mPQq9qDObCuQQNHa2K3dxjeFXbCrK/dkCOY8Y4RRTHmyUAe6wbuEFs1XAHIIUMMkAfgkG0Pbkuiyz+HMapEezvahHMRxMnUQcydrEfEjvFudhTWMePc/cNL3Myc6WhWfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGJcTuru; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744044924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmWHrHuVRgKH+JhKAsvyJxgLEkq6TW3TK9aZ+ghtur0=;
	b=KGJcTuruodf/bjZ7zkUbsKlVxs5I3GLsEvoinw28PKjOLYI1rh7pfcvKkuHqMZSj+q6Y8Z
	vfT0urRmcIr98Yq6RBEhXgxEqowNOBBx6N2NmPhnvfDGBzwDUBH2s0UIM6kmExb66T39Wq
	PgZv4MWi8pjlqzM7/NpXbFVDZTypDzQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-SOxG1ntHOVywr81blVlsGg-1; Mon, 07 Apr 2025 12:55:23 -0400
X-MC-Unique: SOxG1ntHOVywr81blVlsGg-1
X-Mimecast-MFC-AGG-ID: SOxG1ntHOVywr81blVlsGg_1744044922
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30bfae51e79so21201601fa.0
        for <linux-rdma@vger.kernel.org>; Mon, 07 Apr 2025 09:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744044922; x=1744649722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmWHrHuVRgKH+JhKAsvyJxgLEkq6TW3TK9aZ+ghtur0=;
        b=txkvjMK1S66Q7fycdVocYw3Q7Y6wHD3yiaW8fDRFoZldO0t7o3AXJVYlVxc38/TGWz
         Iu74uReDKn0zRu4DoOkzVUydI58OjquehPpi7J/iGJhouZZZp04RT2itSmHhZMBWd6q2
         kmxUouztrzFggYHwil9rm3GztlrN8pafwaaRrbOY6zA0QL63gp9EBCe+lo8ypyonZp6J
         fXyK0TdEnwgoGMlUITslUaTNeDgcMbuj7+YRDXZv86yeasoLOe4/F0VAYL6l8sJ/Iulb
         dl7sGY5N/qpKYryJc65Z+A8rxGb7F9Zg+XnP3lRHLqXDLEO1yEXFoN1VbPc/01HPFkKa
         z8uw==
X-Forwarded-Encrypted: i=1; AJvYcCVoK+kwyKaCrcjSV64zQGKLT/rA6imlAfJPWi15j40RLYq6davVJBvK8FOBNzqH2Mo6Z5WheJNYD7Ro@vger.kernel.org
X-Gm-Message-State: AOJu0YyraGtrq6mKRG2ipf3CcnFlJF/M2/DmviBfdStg+3G5QCUSm8tt
	btg0MqNBSfjRTKbpdLC2tk+FIMbdjJkyZQbgTEivVLM3GL71C2KmZ55M4YnAGN1O0isQs1SyXz9
	K4nNIqt/uetsQoc/HFy5ZOVJCAwtQNJhMZCJ6fo1w46jhSLIZbGtDJM9wiYY=
X-Gm-Gg: ASbGncv2tfR3kBMYL71aVphB6+frr9vCmFE6DwoRNWHEBhFWcUWndtV/W8T7tc0qcYV
	ZM+Af+DQ322nxl3acLO//v73dD2f8vKpZdOiEK1CytoQS1wuYhjqHafW1hC1AB5Xm6ky23zbFdd
	g24c35w1WuV3THBKlgNmHzoBvmMZFR4vr0N/QYqSzsehfrZn1gf+uL+CEJ/ONXT+BQl4d2OUipL
	Kh5siJvje71tajEbalro1EL1+Lomcu9tWeGf7AvLJzjH2J9EMmd+IieqXzIn/sTC3yAoc5D4R5r
	VNnjrWSduIXi
X-Received: by 2002:a05:651c:150e:b0:30c:514c:55d4 with SMTP id 38308e7fff4ca-30f0bf223c5mr40328281fa.16.1744044921457;
        Mon, 07 Apr 2025 09:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+W1FxsZTSUOd6avRoJtTcE7IasTTLXu1j9TAww8Yox/ia12ZyPiFOL0s7dEly7IFB19T7Yg==
X-Received: by 2002:a05:651c:150e:b0:30c:514c:55d4 with SMTP id 38308e7fff4ca-30f0bf223c5mr40328091fa.16.1744044920938;
        Mon, 07 Apr 2025 09:55:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f0313f374sm15981161fa.24.2025.04.07.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:55:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4FBCD19918DC; Mon, 07 Apr 2025 18:55:19 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 07 Apr 2025 18:53:29 +0200
Subject: [PATCH net-next v8 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-page-pool-track-dma-v8-2-da9500d4ba21@redhat.com>
References: <20250407-page-pool-track-dma-v8-0-da9500d4ba21@redhat.com>
In-Reply-To: <20250407-page-pool-track-dma-v8-0-da9500d4ba21@redhat.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Mina Almasry <almasrymina@google.com>, 
 Yonglong Liu <liuyonglong@huawei.com>, 
 Yunsheng Lin <linyunsheng@huawei.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
X-Mailer: b4 0.14.2

When enabling DMA mapping in page_pool, pages are kept DMA mapped until
they are released from the pool, to avoid the overhead of re-mapping the
pages every time they are used. This causes resource leaks and/or
crashes when there are pages still outstanding while the device is torn
down, because page_pool will attempt an unmap through a non-existent DMA
device on the subsequent page return.

To fix this, implement a simple tracking of outstanding DMA-mapped pages
in page pool using an xarray. This was first suggested by Mina[0], and
turns out to be fairly straight forward: We simply store pointers to
pages directly in the xarray with xa_alloc() when they are first DMA
mapped, and remove them from the array on unmap. Then, when a page pool
is torn down, it can simply walk the xarray and unmap all pages still
present there before returning, which also allows us to get rid of the
get/put_device() calls in page_pool. Using xa_cmpxchg(), no additional
synchronisation is needed, as a page will only ever be unmapped once.

To avoid having to walk the entire xarray on unmap to find the page
reference, we stash the ID assigned by xa_alloc() into the page
structure itself, using the upper bits of the pp_magic field. This
requires a couple of defines to avoid conflicting with the
POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
so does not affect run-time performance. The bitmap calculations in this
patch gives the following number of bits for different architectures:

- 23 bits on 32-bit architectures
- 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
- 32 bits on other 64-bit architectures

Stashing a value into the unused bits of pp_magic does have the effect
that it can make the value stored there lie outside the unmappable
range (as governed by the mmap_min_addr sysctl), for architectures that
don't define ILLEGAL_POINTER_VALUE. This means that if one of the
pointers that is aliased to the pp_magic field (such as page->lru.next)
is dereferenced while the page is owned by page_pool, that could lead to
a dereference into userspace, which is a security concern. The risk of
this is mitigated by the fact that (a) we always clear pp_magic before
releasing a page from page_pool, and (b) this would need a
use-after-free bug for struct page, which can have many other risks
since page->lru.next is used as a generic list pointer in multiple
places in the kernel. As such, with this patch we take the position that
this risk is negligible in practice. For more discussion, see[1].

Since all the tracking added in this patch is performed on DMA
map/unmap, no additional code is needed in the fast path, meaning the
performance overhead of this tracking is negligible there. A
micro-benchmark shows that the total overhead of the tracking itself is
about 400 ns (39 cycles(tsc) 395.218 ns; sum for both map and unmap[2]).
Since this cost is only paid on DMA map and unmap, it seems like an
acceptable cost to fix the late unmap issue. Further optimisation can
narrow the cases where this cost is paid (for instance by eliding the
tracking when DMA map/unmap is a no-op).

The extra memory needed to track the pages is neatly encapsulated inside
xarray, which uses the 'struct xa_node' structure to track items. This
structure is 576 bytes long, with slots for 64 items, meaning that a
full node occurs only 9 bytes of overhead per slot it tracks (in
practice, it probably won't be this efficient, but in any case it should
be an acceptable overhead).

[0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KBG9DcVJcyWg@mail.gmail.com/
[1] https://lore.kernel.org/r/20250320023202.GA25514@openwall.com
[2] https://lore.kernel.org/r/ae07144c-9295-4c9d-a400-153bb689fe9e@huawei.com

Reported-by: Yonglong Liu <liuyonglong@huawei.com>
Closes: https://lore.kernel.org/r/8743264a-9700-4227-a556-5f931c720211@huawei.com
Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
Suggested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Qiuling Ren <qren@redhat.com>
Tested-by: Yuying Ma <yuma@redhat.com>
Tested-by: Yonglong Liu <liuyonglong@huawei.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/mm.h            | 46 +++++++++++++++++++++---
 include/linux/poison.h        |  4 +++
 include/net/page_pool/types.h |  6 ++++
 net/core/netmem_priv.h        | 28 ++++++++++++++-
 net/core/page_pool.c          | 81 ++++++++++++++++++++++++++++++++++++-------
 5 files changed, 147 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6f9ef1634f75701ae0be146add1ea2c11beb6e48..6f1d835b1213845940c49f2dd591b7392abbb472 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4248,13 +4248,51 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 #define VM_SEALED_SYSMAP	VM_NONE
 #endif
 
+/*
+ * DMA mapping IDs for page_pool
+ *
+ * When DMA-mapping a page, page_pool allocates an ID (from an xarray) and
+ * stashes it in the upper bits of page->pp_magic. We always want to be able to
+ * unambiguously identify page pool pages (using page_pool_page_is_pp()). Non-PP
+ * pages can have arbitrary kernel pointers stored in the same field as pp_magic
+ * (since it overlaps with page->lru.next), so we must ensure that we cannot
+ * mistake a valid kernel pointer with any of the values we write into this
+ * field.
+ *
+ * On architectures that set POISON_POINTER_DELTA, this is already ensured,
+ * since this value becomes part of PP_SIGNATURE; meaning we can just use the
+ * space between the PP_SIGNATURE value (without POISON_POINTER_DELTA), and the
+ * lowest bits of POISON_POINTER_DELTA. On arches where POISON_POINTER_DELTA is
+ * 0, we make sure that we leave the two topmost bits empty, as that guarantees
+ * we won't mistake a valid kernel pointer for a value we set, regardless of the
+ * VMSPLIT setting.
+ *
+ * Altogether, this means that the number of bits available is constrained by
+ * the size of an unsigned long (at the upper end, subtracting two bits per the
+ * above), and the definition of PP_SIGNATURE (with or without
+ * POISON_POINTER_DELTA).
+ */
+#define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA))
+#if POISON_POINTER_DELTA > 0
+/* PP_SIGNATURE includes POISON_POINTER_DELTA, so limit the size of the DMA
+ * index to not overlap with that if set
+ */
+#define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_INDEX_SHIFT)
+#else
+/* Always leave out the topmost two; see above. */
+#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2)
+#endif
+
+#define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
+				  PP_DMA_INDEX_SHIFT)
+
 /* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
  * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
- * the head page of compound page and bit 1 for pfmemalloc page.
- * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid recycling
- * the pfmemalloc page.
+ * the head page of compound page and bit 1 for pfmemalloc page, as well as the
+ * bits used for the DMA index. page_is_pfmemalloc() is checked in
+ * __page_pool_put_page() to avoid recycling the pfmemalloc page.
  */
-#define PP_MAGIC_MASK ~0x3UL
+#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
 
 #ifdef CONFIG_PAGE_POOL
 static inline bool page_pool_page_is_pp(struct page *page)
diff --git a/include/linux/poison.h b/include/linux/poison.h
index 331a9a996fa8746626afa63ea462b85ca3e5938b..8ca2235f78d5d9c070ae816cfd57fe2984db5562 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -70,6 +70,10 @@
 #define KEY_DESTROY		0xbd
 
 /********** net/core/page_pool.c **********/
+/*
+ * page_pool uses additional free bits within this value to store data, see the
+ * definition of PP_DMA_INDEX_MASK in mm.h
+ */
 #define PP_SIGNATURE		(0x40 + POISON_POINTER_DELTA)
 
 /********** net/core/skbuff.c **********/
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 31e6c5c6724b1cffbf5ad2535b3eaee5dec54d9d..b201e7d81dc493b0ec9ccbe73a7e6b2aa55af514 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -6,6 +6,7 @@
 #include <linux/dma-direction.h>
 #include <linux/ptr_ring.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 #include <net/netmem.h>
 
 #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
@@ -33,6 +34,9 @@
 #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | \
 				 PP_FLAG_SYSTEM_POOL | PP_FLAG_ALLOW_UNREADABLE_NETMEM)
 
+/* Index limit to stay within PP_DMA_INDEX_BITS for DMA indices */
+#define PP_DMA_INDEX_LIMIT XA_LIMIT(1, BIT(PP_DMA_INDEX_BITS) - 1)
+
 /*
  * Fast allocation side cache array/stack
  *
@@ -221,6 +225,8 @@ struct page_pool {
 	void *mp_priv;
 	const struct memory_provider_ops *mp_ops;
 
+	struct xarray dma_mapped;
+
 #ifdef CONFIG_PAGE_POOL_STATS
 	/* recycle stats are per-cpu to avoid locking */
 	struct page_pool_recycle_stats __percpu *recycle_stats;
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index f33162fd281c23e109273ba09950c5d0a2829bc9..cd95394399b40c3604934ba7898eeeeacb8aee99 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -5,7 +5,7 @@
 
 static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
 {
-	return __netmem_clear_lsb(netmem)->pp_magic;
+	return __netmem_clear_lsb(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
 }
 
 static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
@@ -15,6 +15,8 @@ static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
 
 static inline void netmem_clear_pp_magic(netmem_ref netmem)
 {
+	WARN_ON_ONCE(__netmem_clear_lsb(netmem)->pp_magic & PP_DMA_INDEX_MASK);
+
 	__netmem_clear_lsb(netmem)->pp_magic = 0;
 }
 
@@ -33,4 +35,28 @@ static inline void netmem_set_dma_addr(netmem_ref netmem,
 {
 	__netmem_clear_lsb(netmem)->dma_addr = dma_addr;
 }
+
+static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
+{
+	unsigned long magic;
+
+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
+		return 0;
+
+	magic = __netmem_clear_lsb(netmem)->pp_magic;
+
+	return (magic & PP_DMA_INDEX_MASK) >> PP_DMA_INDEX_SHIFT;
+}
+
+static inline void netmem_set_dma_index(netmem_ref netmem,
+					unsigned long id)
+{
+	unsigned long magic;
+
+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
+		return;
+
+	magic = netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT);
+	__netmem_clear_lsb(netmem)->pp_magic = magic;
+}
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 7745ad924ae2d801580a6760eba9393e1cf67b01..2b7684865941854660d32b8d1bb00a72fb550563 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -276,8 +276,7 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
-	if (pool->dma_map)
-		get_device(pool->p.dev);
+	xa_init_flags(&pool->dma_mapped, XA_FLAGS_ALLOC1);
 
 	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
 		netdev_assert_locked(pool->slow.netdev);
@@ -320,9 +319,7 @@ static int page_pool_init(struct page_pool *pool,
 static void page_pool_uninit(struct page_pool *pool)
 {
 	ptr_ring_cleanup(&pool->ring, NULL);
-
-	if (pool->dma_map)
-		put_device(pool->p.dev);
+	xa_destroy(&pool->dma_mapped);
 
 #ifdef CONFIG_PAGE_POOL_STATS
 	if (!pool->system)
@@ -463,13 +460,21 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
-		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
+	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev)) {
+		rcu_read_lock();
+		/* re-check under rcu_read_lock() to sync with page_pool_scrub() */
+		if (pool->dma_sync)
+			__page_pool_dma_sync_for_device(pool, netmem,
+							dma_sync_size);
+		rcu_read_unlock();
+	}
 }
 
-static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
+static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t gfp)
 {
 	dma_addr_t dma;
+	int err;
+	u32 id;
 
 	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
 	 * since dma_addr_t can be either 32 or 64 bits and does not always fit
@@ -483,15 +488,30 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 	if (dma_mapping_error(pool->p.dev, dma))
 		return false;
 
-	if (page_pool_set_dma_addr_netmem(netmem, dma))
+	if (page_pool_set_dma_addr_netmem(netmem, dma)) {
+		WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
 		goto unmap_failed;
+	}
 
+	if (in_softirq())
+		err = xa_alloc(&pool->dma_mapped, &id, netmem_to_page(netmem),
+			       PP_DMA_INDEX_LIMIT, gfp);
+	else
+		err = xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_page(netmem),
+				  PP_DMA_INDEX_LIMIT, gfp);
+	if (err) {
+		WARN_ONCE(err != -ENOMEM, "couldn't track DMA mapping, please report to netdev@");
+		goto unset_failed;
+	}
+
+	netmem_set_dma_index(netmem, id);
 	page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
 
 	return true;
 
+unset_failed:
+	page_pool_set_dma_addr_netmem(netmem, 0);
 unmap_failed:
-	WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
 	dma_unmap_page_attrs(pool->p.dev, dma,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
@@ -508,7 +528,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 	if (unlikely(!page))
 		return NULL;
 
-	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page)))) {
+	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page), gfp))) {
 		put_page(page);
 		return NULL;
 	}
@@ -554,7 +574,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		netmem = pool->alloc.cache[i];
-		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem))) {
+		if (dma_map && unlikely(!page_pool_dma_map(pool, netmem, gfp))) {
 			put_page(netmem_to_page(netmem));
 			continue;
 		}
@@ -656,6 +676,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 							 netmem_ref netmem)
 {
+	struct page *old, *page = netmem_to_page(netmem);
+	unsigned long id;
 	dma_addr_t dma;
 
 	if (!pool->dma_map)
@@ -664,6 +686,17 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 		 */
 		return;
 
+	id = netmem_get_dma_index(netmem);
+	if (!id)
+		return;
+
+	if (in_softirq())
+		old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
+	else
+		old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
+	if (old != page)
+		return;
+
 	dma = page_pool_get_dma_addr_netmem(netmem);
 
 	/* When page is unmapped, it cannot be returned to our pool */
@@ -671,6 +704,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
 	page_pool_set_dma_addr_netmem(netmem, 0);
+	netmem_set_dma_index(netmem, 0);
 }
 
 /* Disconnects a page (from a page_pool).  API users can have a need
@@ -1080,8 +1114,29 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 
 static void page_pool_scrub(struct page_pool *pool)
 {
+	unsigned long id;
+	void *ptr;
+
 	page_pool_empty_alloc_cache_once(pool);
-	pool->destroy_cnt++;
+	if (!pool->destroy_cnt++ && pool->dma_map) {
+		if (pool->dma_sync) {
+			/* Disable page_pool_dma_sync_for_device() */
+			pool->dma_sync = false;
+
+			/* Make sure all concurrent returns that may see the old
+			 * value of dma_sync (and thus perform a sync) have
+			 * finished before doing the unmapping below. Skip the
+			 * wait if the device doesn't actually need syncing, or
+			 * if there are no outstanding mapped pages.
+			 */
+			if (dma_dev_need_sync(pool->p.dev) &&
+			    !xa_empty(&pool->dma_mapped))
+				synchronize_net();
+		}
+
+		xa_for_each(&pool->dma_mapped, id, ptr)
+			__page_pool_release_page_dma(pool, page_to_netmem(ptr));
+	}
 
 	/* No more consumers should exist, but producers could still
 	 * be in-flight.

-- 
2.49.0


