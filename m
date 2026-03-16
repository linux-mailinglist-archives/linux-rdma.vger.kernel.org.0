Return-Path: <linux-rdma+bounces-18230-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMxfNvaFuGltfAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18230-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 23:36:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BC42A1934
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 23:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E200330B69C0
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 22:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B1D361DA7;
	Mon, 16 Mar 2026 22:31:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262EB15FA81;
	Mon, 16 Mar 2026 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700290; cv=none; b=iZhcKQVyNBG/cDhgJ8LHjyrYOwJgjuCqkwrpMoI/5F/AF1EsxODeRp5I7v2mJq9DuqYHkap2S2ZE1IBl/Pte/HAtcwtYbp0mowyjeLw5m6p81gqFFBSvndSzSdtEMk1Xkh+Kt0wIqDRkrXZDB+1pSY2IEXhqk16HPJyosxMI7BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700290; c=relaxed/simple;
	bh=xyHC9ohvcAWbYaHq/N8MzMZhhf2bNvPa9wrZkAo/RJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVluME9pdB6K0g2ju7ArdxgPCRP0alWBGGBpNWENYwBSZ34VRluP0Toi/ZIDkvmMQeRC5Glzr3Pn1WSZgg03Bq6YQPiAc+5gT6HBxFwiUapolpAdpj5sx+5OymjSJ2CZzQ2jX6QHAwj0o+FQJSuE43N2i/eYrGXlz4I5jdFkL38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-56-69b884bcd352
From: Byungchul Park <byungchul@sk.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	harry.yoo@oracle.com,
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
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	ilias.apalodimas@linaro.org,
	willy@infradead.org,
	brauner@kernel.org,
	kas@kernel.org,
	yuzhao@google.com,
	usamaarif642@gmail.com,
	baolin.wang@linux.alibaba.com,
	almasrymina@google.com,
	toke@redhat.com,
	asml.silence@gmail.com,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au,
	dw@davidwei.uk,
	ap420073@gmail.com,
	dtatulea@nvidia.com
Subject: [PATCH v5] mm: introduce a new page type for page pool in page type
Date: Tue, 17 Mar 2026 07:31:13 +0900
Message-Id: <20260316223113.20097-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260316222901.GA59948@system.software.com>
References: <20260316222901.GA59948@system.software.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW2yLYRjHvd/7nVYanxrecUEqIog5hHgWh7hw8ZFNCC6clX2xz7puaW02
	CemYYNE5Lqor2SJqh9LprO2WFTuYDWGZjdZhmzEW7JBtRk1MaxHufnme///33Dw8Vj1kJvOy
	br+k12m0alZBK7rG5M31Znjk+cMuHqwOOwtF31PhepuHgYD9IwXWQheCgcArDoa9tQj6ax6w
	8Lm6D8HVvEEM1qcZNHx1/MBQVv4RwSfzDRY6ats5KHLGQKvtAw0Vx90Y2k/XsWDKGMLgDXRz
	cMSTHxSXGDlocGUxcOHHNQxuYxsHz8qtLLTYhxn4UGWiod5SQENvdg2G1qyVUJs7EQYffUFQ
	43BTMHjqMgvNl8opKPU2c3C+MZeFdxmtCBqr22nI/nmChZz0LARD34PK7jMDDOTcb+FWRorp
	Ph8rVn/pweLtAj8lPjefpUXfnYeUWGZ5w4m5zmSxJH+2mOlrxKKz8CQrOvvOceLr5xWsWGce
	osWyt1FimaefEk1Hu9l1E7YolsVKWjlF0s9bsUsR13mihEr6tT21x/6NMaL86EwUxhNhEel/
	+pL7yy/q/FSIWWEm8fkCOMThQgy56WpCmUjBY6GbIxV3v7GhxXghmtS9CPxhWphB0i900SFW
	CotJz7XHaEQ6lRQV3wuKeD5MiCKPOteHxioBSG9TBTMSH0fqL72nQxEcvOu4ogqNcbB5tDQH
	h84SoZcnZnMpNaKMIJX5PvoMEiz/1S3/6pb/6rkIFyKVrEtJ0MjaRZFxaTo5NXJPYoITBT/M
	dujnVg/qa9hQhQQeqccofYxHVjGaFENaQhUiPFaHK201LlmljNWkHZT0iTv1yVrJUIWm8LR6
	knLh4IFYlbBXs1+Kl6QkSf93S/Fhk40omR1y2JY0JJkinuwYy7jvHl61zaZbUr+j80HlgdHF
	4S89m590yP7s4xZv/L5of9Pe9Mzpd6IMczZHdLhjYrXl796Ex6+xd82pxAPNLWtNknX6tnZt
	XvRFI7HosmdlrZ16bOPyq5v8q42Jt9qWniuwFMdXjmp1BqbN2h21gt/OvB2tpg1xmgWzsd6g
	+Q2S4FsTXQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec97bo5GxyV2sEIadIXSouCJbtKXjreoT0EUOvPUTuqUrUyL
	QnOQSTNNBZ0aRuVlzqyZc8rUUvNSQTlLF6s0K0srDTNtKtVWRH37839+z+/58rBYYaYCWElz
	XNRqVPFKWkbK9mzNWGfX26TgzDcboKTWTEP19xSoGLJR4Da/J6DEZEUw5XYx8LO5E8HXji4a
	PrZPIrh2dRpDyWM9Cd9qZzE0Nr1HMFZYQ8O7zmEGqi2RMFg+QoL9fAOG4UvdNBj0cxia3eMM
	nLNVesR1aQy0l/ZQ8MSaTUH+7A0MDWlDDPQ1ldDwyvyTgpE2Awk9xioSvhR0YBjMDoHOMn+Y
	fvgJQUdtAwHTF0tpeFbUREB98zMG8hxlNLzRDyJwtA+TUDCfSUNxejaCue8e5XjOFAXF918x
	IUFCutNJC+2fJrBwp+o5IfQX5pKCs+UBITQaXzJCmeWEUFe5VshyOrBgMV2gBcvkZUZ40W+n
	he7COVJofL1FaLR9JQRDxji91/+AbFusGC8li9qgHdEy9YfMOiLpx6GUCfMMlYYqI7KQD8tz
	m/iB7ueEN9PcKt7pdGNv9uMi+ZvWpygLyVjMjTO8vXWG9g4WcRF894D7dya5FXx6/mfSm+Xc
	Zn7ixiP0RxrIV9+66xGxrA+3hX/4YZ+3VnDAf3lqp/7gvnxP0VvSi2DP3dorCm+NPZsZ9cU4
	B8mN/1HGf5TxP6oMYRPykzTJCSopfvN6XZw6VSOlrD+cmGBBnh8qPzOfa0NTfbvbEMci5QK5
	k7JJCkqVrEtNaEM8i5V+8vIOq6SQx6pST4naxCjtiXhR14aWsKRysTxsvxit4I6qjotxopgk
	av9OCdYnIA25rKsHpJR7vuS+k60JqlnNxx2jLnG3YSSO3WUtWhp2TD1UZzjPjK50VLTuPc1d
	PzJ0Jzh4Z6grSJ8od2w/1ane2BtzN3AqdDggvGZNcpXv5LVzOktLVU/UyYJyHNMFeS3L0NuF
	0TVJP0LD7VvHGnpdufnKnQfP9l+8HfHCtDzAT0nq1KoNa7FWp/oFypO+ET8DAAA=
X-CFilter-Loop: Reflected
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18230-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[sk.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[47];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.063];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cmpxchg.org:email,nvidia.com:email,suse.cz:email]
X-Rspamd-Queue-Id: 52BC42A1934
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
determine if a page belongs to a page pool.  However, with the planned
removal of @pp_magic, we should instead leverage the page_type in struct
page, such as PGTY_netpp, for this purpose.

Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
and __ClearPageNetpp() instead, and remove the existing APIs accessing
@pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
netmem_clear_pp_magic().

Plus, add @page_type to struct net_iov at the same offset as struct page
so as to use the page_type APIs for struct net_iov as well.  While at it,
reorder @type and @owner in struct net_iov to avoid a hole and
increasing the struct size.

This work was inspired by the following link:

  https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/

While at it, move the sanity check for page pool to on the free path.

Suggested-by: David Hildenbrand <david@redhat.com>
Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Byungchul Park <byungchul@sk.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
The following 'Acked-by's were given only for mm part:

  Acked-by: David Hildenbrand <david@redhat.com>
  Acked-by: Zi Yan <ziy@nvidia.com>
  Acked-by: Vlastimil Babka <vbabka@suse.cz>
  Acked-by: Johannes Weiner <hannes@cmpxchg.org>

This patch changes both mm and page-pool, but I'm currently targetting
mm tree because Jakub asked and I also think it's more about mm change.
See the following link:

  https://lore.kernel.org/all/20250813075212.051b5178@kernel.org/

Changes from v4:
	1. Gate the sanity check, 'if (unlikely(PageNetpp(page)))' on
	   free path, with is_check_pages_enabled(). (Feedbacked by
	   Johannes Weiner)
	2. Add 'Acked-by's.  Thanks.

Changes from v3:
	1. Rebase on mm-new as of Feb 24, 2026.
	2. Fix an issue reported by kernel test robot due to incorrect
	   type.
	3. Add 'Acked-by: Vlastimil Babka <vbabka@suse.cz>'.  Thanks.

Changes from v2:
	1. Fix an issue reported by kernel test robot due to incorrect
	   type in argument of __netmem_to_page().

Changes from v1:
	1. Drop the finalizing patch removing the pp fields of struct
	   page since I found that there is still code accessing a pp
	   field via struct page.  I will retry the finalizing patch
	   after resolving the issue.
---
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
 include/linux/mm.h                            | 27 +++----------------
 include/linux/page-flags.h                    |  6 +++++
 include/net/netmem.h                          | 15 +++++++++--
 mm/page_alloc.c                               | 13 ++++++---
 net/core/netmem_priv.h                        | 23 +++++++---------
 net/core/page_pool.c                          | 24 +++++++++++++++--
 7 files changed, 64 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 80f9fc10877ad..7d90d2485c787 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -707,7 +707,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 				page = xdpi.page.page;
 
-				/* No need to check page_pool_page_is_pp() as we
+				/* No need to check PageNetpp() as we
 				 * know this is a page_pool page.
 				 */
 				page_pool_recycle_direct(pp_page_to_nmdesc(page)->pp,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52206525af7c7..6f0a3edb24e14 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5197,10 +5197,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
  * DMA mapping IDs for page_pool
  *
  * When DMA-mapping a page, page_pool allocates an ID (from an xarray) and
- * stashes it in the upper bits of page->pp_magic. We always want to be able to
- * unambiguously identify page pool pages (using page_pool_page_is_pp()). Non-PP
- * pages can have arbitrary kernel pointers stored in the same field as pp_magic
- * (since it overlaps with page->lru.next), so we must ensure that we cannot
+ * stashes it in the upper bits of page->pp_magic. Non-PP pages can have
+ * arbitrary kernel pointers stored in the same field as pp_magic (since
+ * it overlaps with page->lru.next), so we must ensure that we cannot
  * mistake a valid kernel pointer with any of the values we write into this
  * field.
  *
@@ -5235,26 +5234,6 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
 				  PP_DMA_INDEX_SHIFT)
 
-/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
- * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
- * the head page of compound page and bit 1 for pfmemalloc page, as well as the
- * bits used for the DMA index. page_is_pfmemalloc() is checked in
- * __page_pool_put_page() to avoid recycling the pfmemalloc page.
- */
-#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
-
-#ifdef CONFIG_PAGE_POOL
-static inline bool page_pool_page_is_pp(const struct page *page)
-{
-	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
-}
-#else
-static inline bool page_pool_page_is_pp(const struct page *page)
-{
-	return false;
-}
-#endif
-
 #define PAGE_SNAPSHOT_FAITHFUL (1 << 0)
 #define PAGE_SNAPSHOT_PG_BUDDY (1 << 1)
 #define PAGE_SNAPSHOT_PG_IDLE  (1 << 2)
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 7223f6f4e2b40..0e03d816e8b9d 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -923,6 +923,7 @@ enum pagetype {
 	PGTY_zsmalloc		= 0xf6,
 	PGTY_unaccepted		= 0xf7,
 	PGTY_large_kmalloc	= 0xf8,
+	PGTY_netpp		= 0xf9,
 
 	PGTY_mapcount_underflow = 0xff
 };
@@ -1055,6 +1056,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
 PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
 PAGE_TYPE_OPS(LargeKmalloc, large_kmalloc, large_kmalloc)
 
+/*
+ * Marks page_pool allocated pages.
+ */
+PAGE_TYPE_OPS(Netpp, netpp, netpp)
+
 /**
  * PageHuge - Determine if the page belongs to hugetlbfs
  * @page: The page to test.
diff --git a/include/net/netmem.h b/include/net/netmem.h
index a96b3e5e5574c..85e3b26ec547f 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -110,10 +110,21 @@ struct net_iov {
 			atomic_long_t pp_ref_count;
 		};
 	};
-	struct net_iov_area *owner;
+
+	unsigned int page_type;
 	enum net_iov_type type;
+	struct net_iov_area *owner;
 };
 
+/* Make sure 'the offset of page_type in struct page == the offset of
+ * type in struct net_iov'.
+ */
+#define NET_IOV_ASSERT_OFFSET(pg, iov)			\
+	static_assert(offsetof(struct page, pg) ==	\
+		      offsetof(struct net_iov, iov))
+NET_IOV_ASSERT_OFFSET(page_type, page_type);
+#undef NET_IOV_ASSERT_OFFSET
+
 struct net_iov_area {
 	/* Array of net_iovs for this area. */
 	struct net_iov *niovs;
@@ -256,7 +267,7 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
  */
 #define pp_page_to_nmdesc(p)						\
 ({									\
-	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
+	DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));				\
 	__pp_page_to_nmdesc(p);						\
 })
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9f2fe46ff69a1..ee81f5c67c18f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1044,7 +1044,6 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
-			page_pool_page_is_pp(page) |
 			(page->flags.f & check_flags)))
 		return false;
 
@@ -1071,8 +1070,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 	if (unlikely(page->memcg_data))
 		bad_reason = "page still charged to cgroup";
 #endif
-	if (unlikely(page_pool_page_is_pp(page)))
-		bad_reason = "page_pool leak";
 	return bad_reason;
 }
 
@@ -1381,9 +1378,17 @@ __always_inline bool __free_pages_prepare(struct page *page,
 		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 		folio->mapping = NULL;
 	}
-	if (unlikely(page_has_type(page)))
+	if (unlikely(page_has_type(page))) {
+		/* networking expects to clear its page type before releasing */
+		if (is_check_pages_enabled()) {
+			if (unlikely(PageNetpp(page))) {
+				bad_page(page, "page_pool leak");
+				return false;
+			}
+		}
 		/* Reset the page_type (which overlays _mapcount) */
 		page->page_type = UINT_MAX;
+	}
 
 	if (is_check_pages_enabled()) {
 		if (free_page_is_bad(page))
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 23175cb2bd866..3e6fde8f1726f 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -8,21 +8,18 @@ static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
 	return netmem_to_nmdesc(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
 }
 
-static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
-{
-	netmem_to_nmdesc(netmem)->pp_magic |= pp_magic;
-}
-
-static inline void netmem_clear_pp_magic(netmem_ref netmem)
-{
-	WARN_ON_ONCE(netmem_to_nmdesc(netmem)->pp_magic & PP_DMA_INDEX_MASK);
-
-	netmem_to_nmdesc(netmem)->pp_magic = 0;
-}
-
 static inline bool netmem_is_pp(netmem_ref netmem)
 {
-	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
+	struct page *page;
+
+	/* XXX: Now that the offset of page_type is shared between
+	 * struct page and net_iov, just cast the netmem to struct page
+	 * unconditionally by clearing NET_IOV if any, no matter whether
+	 * it comes from struct net_iov or struct page.  This should be
+	 * adjusted once the offset is no longer shared.
+	 */
+	page = (struct page *)((__force unsigned long)netmem & ~NET_IOV);
+	return PageNetpp(page);
 }
 
 static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 265a729431bb7..877bbf7a19389 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -702,8 +702,18 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
 
 void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
+	struct page *page;
+
 	netmem_set_pp(netmem, pool);
-	netmem_or_pp_magic(netmem, PP_SIGNATURE);
+
+	/* XXX: Now that the offset of page_type is shared between
+	 * struct page and net_iov, just cast the netmem to struct page
+	 * unconditionally by clearing NET_IOV if any, no matter whether
+	 * it comes from struct net_iov or struct page.  This should be
+	 * adjusted once the offset is no longer shared.
+	 */
+	page = (struct page *)((__force unsigned long)netmem & ~NET_IOV);
+	__SetPageNetpp(page);
 
 	/* Ensuring all pages have been split into one fragment initially:
 	 * page_pool_set_pp_info() is only called once for every page when it
@@ -718,7 +728,17 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 
 void page_pool_clear_pp_info(netmem_ref netmem)
 {
-	netmem_clear_pp_magic(netmem);
+	struct page *page;
+
+	/* XXX: Now that the offset of page_type is shared between
+	 * struct page and net_iov, just cast the netmem to struct page
+	 * unconditionally by clearing NET_IOV if any, no matter whether
+	 * it comes from struct net_iov or struct page.  This should be
+	 * adjusted once the offset is no longer shared.
+	 */
+	page = (struct page *)((__force unsigned long)netmem & ~NET_IOV);
+	__ClearPageNetpp(page);
+
 	netmem_set_pp(netmem, NULL);
 }
 
-- 
2.17.1


