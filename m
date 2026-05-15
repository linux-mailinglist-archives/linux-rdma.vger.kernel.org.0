Return-Path: <linux-rdma+bounces-20749-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO6MAFWXBmqKlAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20749-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 05:47:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B2E54907D
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 05:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 146A23030102
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 03:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956743CEBA9;
	Fri, 15 May 2026 03:47:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9B11FF1B4;
	Fri, 15 May 2026 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778816840; cv=none; b=f8LUdVv55jM6rFG6AAM3oJ7i4Z39/ELXNBvICVH4PCR0WQhlipuJX4cvGoqrV2R4tV2/BqpxfvvqSqVGzuK/7Iq0g4gHxqHQTX4JuJoYiHd4XQbd+ndUTPRIKi6Yh1tP2SmF7c8dcRJGXQjKjbpW6FoodpCpQjtFzuYEOphwtFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778816840; c=relaxed/simple;
	bh=1s4KBpflJ5ti1QKII+Sd5Q9eJ7tPMaA3nr9cneR4I2w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sKVvxV6O+hYKWslJ4igWrEM7Slsl/w2tN0XLohmg9C0fQPQsLK3rpReGFnzkhpz8a54SmxwqVNIOk7mWLMl2LOvOZDGBmQZa3LoOC4Gp84mf5+HZBSxVOBfZ6koILJoyQRVvV8QgRQheUf8aczC/3xj3YhMJETLNSZe3So0PBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-03-6a06973fa85f
From: Byungchul Park <byungchul@sk.com>
To: akpm@linux-foundation.org
Cc: kernel_team@skhynix.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	ilias.apalodimas@linaro.org,
	kas@kernel.org,
	willy@infradead.org,
	byungchul@sk.com,
	baolin.wang@linux.alibaba.com,
	asml.silence@gmail.com,
	toke@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] Revert "mm: introduce a new page type for page pool in page type"
Date: Fri, 15 May 2026 12:47:01 +0900
Message-Id: <20260515034701.17027-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG+59z9j/H5ei0xI5KGgMrBO2CwRuWSqGcrkiBSH3IpaeceWNe
	JyjWBC+o3ZTUJqysttSy5qVp6nKamUGKoizKS5quyBsaK7Uwp/Ttx/N73ufLy5BSE+XKKOKS
	BGWcPEaGxZR4xvGBd8BdHL1PV+4JmtoaDLoxowg0VY0Ifi59omG1tQvBYudbDJX3bSRoerMp
	sDYsI5jsGqeh2nAaWnJekjB+oxtDYfYKCa1LszRcN+oJ0NRl0dDXWCSC4uVHJDzrMWMYaNZg
	GKlZFcGUuZCC6YlgmC/pJGG0KBC6tM5gez+NoLP2JQG2ggoMg2XNBNzp12KYyB5F0N8xTkHu
	91EKVn6v7dx7M0IHevId03MkX//kI8Fb2noIvql8mOa1hmS+Tu/F51v6Sd5QlYd5w8Jtmv88
	1IL57tIVim/6cohvMi4SfKF6FvNzbYOYr60fpEK2nhcfjhRiFCmCcq9/uDhqaKpclKAOTdNq
	1SgLzQTlIweGY325d+oGKh8x62zNuWyPMbubs1iWSDs7sTu4kr+9axUxQ7JDmLuePyCyi23s
	WW7x19g6U6wn9zXXiuwsYQ9yy8VGvLHvwVU/f03ajzl2ieZ0qxP0hnDh2vUW6ibarEWbqpBU
	EZcSK1fE+PpEqeIUaT4R8bEGtPbWxxl/LhjRQt85M2IZJHOUhH0QRUtF8pREVawZcQwpc5J4
	v1qLJJFyVbqgjL+oTI4REs3IjaFk2yUHbKmRUvaKPEm4KggJgvK/JRgH1yyEpufD/L4FnAoT
	t2cK/aZSVVj6BMuKiBerVr3fGfc6D510ZE9l448gU2pdRBkFnu7e+t+7sHXSfDwq9Chx7FKq
	aSozVacsWHgY6J9Zf56zKfI6MoY3LzgHP13U0A2TWyou/XJV20KenTjiv7PCTR7goqm6JqFu
	ccbwzqCTYhmVGCXf70UqE+X/AE6rb73SAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXReUiTcRwG8H7v8dvravAyV70VUSzKgzKFpK90+UfWr3tEFAhRK191U5ds
	KhpEloI2skzt0kkLO9a0sq3ctBoy55Fd4nIYHV6lBHZaK11hLui/D88Dzz8PR8uvMnM5jS5L
	1OvU6UosZaTbVxUsW3cea6MDV+Rgul2H4Xq/kwWTtQHB9/FXEph82IZgzNOO4VlFFYaay34a
	TM8LGRi5N4HgfdugBGpt2+BBkYOGwdMdGEoKAzQ8HP8kgeNOCwUme74EWqofsdDVcIqFiomr
	NNzqdGPwNpkwvK2bZGHYXcLA6NAG+HLWQ0PfqXhoM88C/+NRBJ7bDgr8J6sx9FxsoqC824xh
	qLAPQXfLIAPFH/oYCPya2qlqfSuJDyMto59pcvfGS4r0ujop0lj5RkLMtmxit0QSY283TWzW
	E5jYvpVJyGvfA0w6LgQY0jgQRxqdYxQpKfiEyWdXDyb+V0QVmihdnSSma3JE/fK1+6WpvuFK
	NrNgd67ZXIDy0ccEI+I4gV8hjBQlG1EIh/kwobd3nA5awc8Xzv55zhiRlKN5HxaOG71ssAjl
	dwpjP/v/meEXC++KR1DQMj5WmKhw4qAFfoFQW99MlyLOjKZZkUKjy8lQa9JjowxpqXk6TW7U
	wUMZNjR13rUjv8840XfvRjfiOaScIVO1s1o5q84x5GW4kcDRSoVs2f2pSJakzjss6g/t02en
	iwY3mscxytmyzXvE/XI+RZ0lpolipqj/31JcyNx8ZFy6aeG0OfWumC7fUrsjvAhX18SlzYyI
	51K2NicwTKKitL8889IJxbXWiJPFTxZh1Y8DQ5PUQP6diLWWW64Oj96i3LVymy0yYYuDPD53
	9OmSrzuSu7Wqir3am4GYkKJ1rSV1548dfu0t086MLbXa7dHeNc6yuOnhA3BsvePFs3IlY0hV
	x0TSeoP6LwILq1q4AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 60B2E54907D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20749-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[skhynix.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,infradead.org,suse.com,cmpxchg.org,linaro.org,sk.com,linux.alibaba.com,vger.kernel.org,kvack.org];
	DMARC_NA(0.00)[sk.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[39];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.951];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This reverts commit db359fccf212e7fa3136e6edbed6228475646fd7.

Netpp page_type'ed pages might be used in mapping so as to use
@_mapcount.  However, since @page_type and @_mapcount are union'ed in
struct page, these two can't be used at the same time.  Revert the
commit introducing page_type for Netpp for now.

The patch will be retried once @page_type and @_mapcount get allowed to
be used at the same time.

The revert also includes removal of @page_type initialization part
introduced by commit 735a309b4bfb9e ("net: add net_iov_init() and use it
to initialize ->page_type"), which will be restored on the retry.

Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
Closes: https://lore.kernel.org/all/982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com
Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
 include/linux/mm.h                            | 27 ++++++++++++++++---
 include/linux/page-flags.h                    |  6 -----
 include/net/netmem.h                          | 19 ++-----------
 mm/page_alloc.c                               | 13 +++------
 net/core/netmem_priv.h                        | 23 +++++++++-------
 net/core/page_pool.c                          | 24 ++---------------
 7 files changed, 46 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 190b8b66b3ce1..d3bab198c99c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -708,7 +708,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 				page = xdpi.page.page;
 
-				/* No need to check PageNetpp() as we
+				/* No need to check page_pool_page_is_pp() as we
 				 * know this is a page_pool page.
 				 */
 				page_pool_recycle_direct(pp_page_to_nmdesc(page)->pp,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 31e27ff6a35fa..9cedc5e75aa93 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5156,9 +5156,10 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
  * DMA mapping IDs for page_pool
  *
  * When DMA-mapping a page, page_pool allocates an ID (from an xarray) and
- * stashes it in the upper bits of page->pp_magic. Non-PP pages can have
- * arbitrary kernel pointers stored in the same field as pp_magic (since
- * it overlaps with page->lru.next), so we must ensure that we cannot
+ * stashes it in the upper bits of page->pp_magic. We always want to be able to
+ * unambiguously identify page pool pages (using page_pool_page_is_pp()). Non-PP
+ * pages can have arbitrary kernel pointers stored in the same field as pp_magic
+ * (since it overlaps with page->lru.next), so we must ensure that we cannot
  * mistake a valid kernel pointer with any of the values we write into this
  * field.
  *
@@ -5193,6 +5194,26 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
 				  PP_DMA_INDEX_SHIFT)
 
+/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
+ * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
+ * the head page of compound page and bit 1 for pfmemalloc page, as well as the
+ * bits used for the DMA index. page_is_pfmemalloc() is checked in
+ * __page_pool_put_page() to avoid recycling the pfmemalloc page.
+ */
+#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
+
+#ifdef CONFIG_PAGE_POOL
+static inline bool page_pool_page_is_pp(const struct page *page)
+{
+	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
+}
+#else
+static inline bool page_pool_page_is_pp(const struct page *page)
+{
+	return false;
+}
+#endif
+
 #define PAGE_SNAPSHOT_FAITHFUL (1 << 0)
 #define PAGE_SNAPSHOT_PG_BUDDY (1 << 1)
 #define PAGE_SNAPSHOT_PG_IDLE  (1 << 2)
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0e03d816e8b9d..7223f6f4e2b40 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -923,7 +923,6 @@ enum pagetype {
 	PGTY_zsmalloc		= 0xf6,
 	PGTY_unaccepted		= 0xf7,
 	PGTY_large_kmalloc	= 0xf8,
-	PGTY_netpp		= 0xf9,
 
 	PGTY_mapcount_underflow = 0xff
 };
@@ -1056,11 +1055,6 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
 PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
 PAGE_TYPE_OPS(LargeKmalloc, large_kmalloc, large_kmalloc)
 
-/*
- * Marks page_pool allocated pages.
- */
-PAGE_TYPE_OPS(Netpp, netpp, netpp)
-
 /**
  * PageHuge - Determine if the page belongs to hugetlbfs
  * @page: The page to test.
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 78fe51e5756b1..bccacd21b6c37 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -94,20 +94,10 @@ enum net_iov_type {
  */
 struct net_iov {
 	struct netmem_desc desc;
-	unsigned int page_type;
 	enum net_iov_type type;
 	struct net_iov_area *owner;
 };
 
-/* Make sure 'the offset of page_type in struct page == the offset of
- * type in struct net_iov'.
- */
-#define NET_IOV_ASSERT_OFFSET(pg, iov)			\
-	static_assert(offsetof(struct page, pg) ==	\
-		      offsetof(struct net_iov, iov))
-NET_IOV_ASSERT_OFFSET(page_type, page_type);
-#undef NET_IOV_ASSERT_OFFSET
-
 struct net_iov_area {
 	/* Array of net_iovs for this area. */
 	struct net_iov *niovs;
@@ -127,11 +117,7 @@ static inline unsigned int net_iov_idx(const struct net_iov *niov)
 	return niov - net_iov_owner(niov)->niovs;
 }
 
-/* Initialize a niov: stamp the owning area, the memory provider type,
- * and the page_type "no type" sentinel expected by the page-type API
- * (see PAGE_TYPE_OPS in <linux/page-flags.h>) so that
- * page_pool_set_pp_info() can later call __SetPageNetpp() on a niov
- * cast to struct page.
+/* Initialize a niov: stamp the owning area, the memory provider type.
  */
 static inline void net_iov_init(struct net_iov *niov,
 				struct net_iov_area *owner,
@@ -139,7 +125,6 @@ static inline void net_iov_init(struct net_iov *niov,
 {
 	niov->owner = owner;
 	niov->type = type;
-	niov->page_type = UINT_MAX;
 }
 
 /* netmem */
@@ -245,7 +230,7 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
  */
 #define pp_page_to_nmdesc(p)						\
 ({									\
-	DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));				\
+	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
 	__pp_page_to_nmdesc(p);						\
 })
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e262d1316259d..91e7075918ada 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1046,6 +1046,7 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
+			page_pool_page_is_pp(page) |
 			(page->flags.f & check_flags)))
 		return false;
 
@@ -1072,6 +1073,8 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 	if (unlikely(page->memcg_data))
 		bad_reason = "page still charged to cgroup";
 #endif
+	if (unlikely(page_pool_page_is_pp(page)))
+		bad_reason = "page_pool leak";
 	return bad_reason;
 }
 
@@ -1395,17 +1398,9 @@ static __always_inline bool __free_pages_prepare(struct page *page,
 		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 		folio->mapping = NULL;
 	}
-	if (unlikely(page_has_type(page))) {
-		/* networking expects to clear its page type before releasing */
-		if (is_check_pages_enabled()) {
-			if (unlikely(PageNetpp(page))) {
-				bad_page(page, "page_pool leak");
-				return false;
-			}
-		}
+	if (unlikely(page_has_type(page)))
 		/* Reset the page_type (which overlays _mapcount) */
 		page->page_type = UINT_MAX;
-	}
 
 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 3e6fde8f1726f..23175cb2bd866 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -8,18 +8,21 @@ static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
 	return netmem_to_nmdesc(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
 }
 
-static inline bool netmem_is_pp(netmem_ref netmem)
+static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
+{
+	netmem_to_nmdesc(netmem)->pp_magic |= pp_magic;
+}
+
+static inline void netmem_clear_pp_magic(netmem_ref netmem)
 {
-	struct page *page;
+	WARN_ON_ONCE(netmem_to_nmdesc(netmem)->pp_magic & PP_DMA_INDEX_MASK);
 
-	/* XXX: Now that the offset of page_type is shared between
-	 * struct page and net_iov, just cast the netmem to struct page
-	 * unconditionally by clearing NET_IOV if any, no matter whether
-	 * it comes from struct net_iov or struct page.  This should be
-	 * adjusted once the offset is no longer shared.
-	 */
-	page = (struct page *)((__force unsigned long)netmem & ~NET_IOV);
-	return PageNetpp(page);
+	netmem_to_nmdesc(netmem)->pp_magic = 0;
+}
+
+static inline bool netmem_is_pp(netmem_ref netmem)
+{
+	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
 }
 
 static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 6e576dec80db4..8171d1173221b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -707,18 +707,8 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
 
 void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
-	struct page *page;
-
 	netmem_set_pp(netmem, pool);
-
-	/* XXX: Now that the offset of page_type is shared between
-	 * struct page and net_iov, just cast the netmem to struct page
-	 * unconditionally by clearing NET_IOV if any, no matter whether
-	 * it comes from struct net_iov or struct page.  This should be
-	 * adjusted once the offset is no longer shared.
-	 */
-	page = (struct page *)((__force unsigned long)netmem & ~NET_IOV);
-	__SetPageNetpp(page);
+	netmem_or_pp_magic(netmem, PP_SIGNATURE);
 
 	/* Ensuring all pages have been split into one fragment initially:
 	 * page_pool_set_pp_info() is only called once for every page when it
@@ -733,17 +723,7 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 
 void page_pool_clear_pp_info(netmem_ref netmem)
 {
-	struct page *page;
-
-	/* XXX: Now that the offset of page_type is shared between
-	 * struct page and net_iov, just cast the netmem to struct page
-	 * unconditionally by clearing NET_IOV if any, no matter whether
-	 * it comes from struct net_iov or struct page.  This should be
-	 * adjusted once the offset is no longer shared.
-	 */
-	page = (struct page *)((__force unsigned long)netmem & ~NET_IOV);
-	__ClearPageNetpp(page);
-
+	netmem_clear_pp_magic(netmem);
 	netmem_set_pp(netmem, NULL);
 }
 

base-commit: 0cec77cfd5314c0b3b03530abe1a4b32e991f639
-- 
2.17.1


