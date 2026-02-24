Return-Path: <linux-rdma+bounces-17093-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CA1L64znWlINQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17093-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 06:14:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D8181D4A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 06:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5594130325CD
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 05:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73D228314B;
	Tue, 24 Feb 2026 05:14:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C511607A4;
	Tue, 24 Feb 2026 05:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771910057; cv=none; b=JZ1zdzIOXsRjaA79IwJn2+q4ZYXCqY9v2rfLXZQM8ke341deyMlFja4XpXUtILAQtB8LOXeBT/K28zi40EHf7LgQUhmW/jeKDXNs1yP0TnvjpldNgb95FGSP1HZs0pMb3jD4PuWnNocpLl9UrFtPjmFl8EmyBaYtMIN4KIq9m3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771910057; c=relaxed/simple;
	bh=qdfjXsgniKxwDH9jw9QV4KZNp1Vb6+UDU/qmPnmvIiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AMPZMK2KGoi2dHRAMdAUak2Uj7uXURnzSTSiACypdmwDR2vcPo57oiNJtYsCzN4Bb/vyrubr3Duob6tJ8nuoiDNnwp8+rH+/g6kLGwqXALIsEa3CottzemYkFezOt8kiCNJ9SqebM4DS7UR1fjMKOZojzsOSH+KjuvMNrIliZZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-77-699d3398a6b8
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
Subject: [PATCH v4] mm: introduce a new page type for page pool in page type
Date: Tue, 24 Feb 2026 14:13:47 +0900
Message-Id: <20260224051347.19621-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+XbOvnMcLk7L8mRQNIrIyrQsXiGiC8EXJRhRgRU58pCHnMUs
	00LQsouWppXg5hQz0nkpa142TTOneanosszWxdssBatZZk5dUdOQ+u/heZ/f76+XpRRGqQ8r
	Rh0TNFGqSCWW0bIvnvkrtKtzRH+7wQf0ZaUYSsZiobDHLIXx0gEJ6IurEIyMv2Pgd10zgu9N
	LRg+NQ4juHF9lAL9syQafpRNUFBdM4BgMOsWho/NdgZKjMHQXdBPQ+15EwX2y60YUpNcFNSN
	Oxg4bTa4xeUJDDyvSpPCtYmbFJgSehh4WaPH0FX6Wwr9llQa2nRFNHzNbKKgO20DNOfNgdHH
	nxE0lZkkMHopB8MrbY0EKuteMXDVmoehL6kbgbXRTkPmzwsYshPTELjG3EpH+ogUsh92MRv8
	SKLNhknj5yGKVBS9kZCOrAya2O4/kpBqXSdD8ozHSbnBl6TYrBQxFidjYhy+wpD3HbWYtGa5
	aFLdG0Sqzd8lJPWMA4fMDpWtCxcixRhBs3J9mCzidprX0aHQ2Ir8RpyA7FtTkAfLc4F8a2Y9
	NZ3vJ1royYy5JbzNNj7Ve3HB/O2qdpSCZCzFORi+tt6JJw+zuO382JeOKYDmFvMNjgdTgJxb
	w7+1djF/pQv4kjvT/Uy+TfvBvWfdoiV8Wa5isqbckzOV2dSkn+faWf5J4gj+y87lGww2Oh3N
	0P2H6/7huv/wPEQVI4UYFaNWiZGBfhFxUWKs38EjaiNyf1JB/M+9ZjT8fKcFcSxSesrD9utF
	hVQVEx2ntiCepZRecpdLJyrk4aq4k4LmyAHN8Ugh2oLmsbTSW75q9ES4gjukOiYcFoSjgmb6
	KmE9fBLQSm282f76co82daFr8JrnuiHz2RTn7me95ecC/DPyzx3wN29clLs4qEhn+mVKJ23J
	yVnO9TWWLW13M5Y7rd/WvP3Uvcm5ozfsRV3nhT71xYrAbUWbX0+cunrjqW9MvKeisDJk59PQ
	rfWiR/m9ff17vAfNPf27JC2Ghvlrly4LUj8eIEo6OkIV4EtpolV/AKMgQPhFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z9zds5xOjgtqZNG0SgUJS1s9XYliPJfZAR9KLLIkQc9NLW2
	FA2KmVYmurQUdM7SLmZeY6Zu81abmdaHxErWTc1KqWxFmjlX2DQkvz087+/5fXpZUp4n8WPF
	+JOCJl6lVtBSSrpnY9rKgrBicZW5UwnG2ioaKieS4faAWQKuqmECjBUNCMZcrxmYaulAMNr+
	iIYv9h8IbpSOk2B8mk7Bz9pJEizWYQSfC6pp+NgxyEClKQL6y4YoaL7QSMLgpU4astPdJLS4
	nAycNZd7xHU6BuzFXRLobtBLIG/yFgmNugEGnlmNNPRVTUlgyJZNQZfhDgXf89tJ6NdvhY6S
	BTD+ZARBe20jAeNZxTS8KLQSUN/ygoErPSU0vE/vR9BjH6Qg/3cGDUWpegTuCY/SmTMmgaKH
	fczWUJzqcNDYPvKNxPfuvCRwb0EuhR2tjwlsMbxlcIkpEdeVB+FMRw+JTRUXaWz6cZnBb3qb
	adxZ4Kaw5d16bDGPEjg7zUnvXXBQuilaUItJgiZ0S5Q0tkbve/zbweR71+20Dg3uzEReLM+t
	4VtTbdR0prkA3uFwkdPZl4vgaxqeo0wkZUnOyfDNbb/o6cN8bjc/8bV3ZkBxK/gHzvszAxmn
	5F/19DH/pEv5yruz/Ty+q/CDh2c9ogC+9qp8uiY9SFp9EZmDvA1zKMN/yjCHKkFkBfIV45Pi
	VKJaGaI9FpsSLyaHHE2IMyHPr5Sd/p1rRmPPwm2IY5HCRxZ12CjKJaokbUqcDfEsqfCVud0G
	US6LVqWcEjQJRzSJakFrQ/4spVgo27VfiJJzMaqTwjFBOC5oZq8E6+WnQ4skN61BpZe83254
	vc10vs07cDiL5ZTLI9MiX0UvPmOPEy9uRsZqrDhUduD7olCnaJEnlrYF123f8YerO0d0LBsI
	X1eVVSPfoE4IlAbrwsxN2vF9n5m1zdeeHzqxpF3p8mODh7t9yhMVPwn/Jv166yd7yGjfEC+N
	8YpyphdlNCgobaxqdRCp0ar+Atxkpu0nAwAA
X-CFilter-Loop: Reflected
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17093-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[sk.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[47];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sk.com:mid,sk.com:email]
X-Rspamd-Queue-Id: 069D8181D4A
X-Rspamd-Action: no action

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
---
The following 'Acked-by's were given only for mm part:

  Acked-by: David Hildenbrand <david@redhat.com>
  Acked-by: Zi Yan <ziy@nvidia.com>
  Acked-by: Vlastimil Babka <vbabka@suse.cz>

This patch changes both mm and page-pool, but I'm currently targetting
mm tree because Jakub asked and I also think it's more about mm change.
See the following link:

  https://lore.kernel.org/all/20250813075212.051b5178@kernel.org/

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
 mm/page_alloc.c                               | 11 +++++---
 net/core/netmem_priv.h                        | 23 +++++++---------
 net/core/page_pool.c                          | 24 +++++++++++++++--
 7 files changed, 62 insertions(+), 46 deletions(-)

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
index 13336340612e2..0db764b3d6b84 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4824,10 +4824,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
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
@@ -4862,26 +4861,6 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
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
index 0426cac91c0bb..30c4eb24e4edf 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -939,6 +939,7 @@ enum pagetype {
 	PGTY_zsmalloc		= 0xf6,
 	PGTY_unaccepted		= 0xf7,
 	PGTY_large_kmalloc	= 0xf8,
+	PGTY_netpp		= 0xf9,
 
 	PGTY_mapcount_underflow = 0xff
 };
@@ -1071,6 +1072,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
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
index d88c8c67ac0b7..cae9f93271469 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1079,7 +1079,6 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
-			page_pool_page_is_pp(page) |
 			(page->flags.f & check_flags)))
 		return false;
 
@@ -1106,8 +1105,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 	if (unlikely(page->memcg_data))
 		bad_reason = "page still charged to cgroup";
 #endif
-	if (unlikely(page_pool_page_is_pp(page)))
-		bad_reason = "page_pool leak";
 	return bad_reason;
 }
 
@@ -1416,9 +1413,15 @@ __always_inline bool __free_pages_prepare(struct page *page,
 		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 		folio->mapping = NULL;
 	}
-	if (unlikely(page_has_type(page)))
+	if (unlikely(page_has_type(page))) {
+		/* networking expects to clear its page type before releasing */
+		if (unlikely(PageNetpp(page))) {
+			bad_page(page, "page_pool leak");
+			return false;
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


