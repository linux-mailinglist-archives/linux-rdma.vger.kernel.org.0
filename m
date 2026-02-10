Return-Path: <linux-rdma+bounces-16706-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKhYJOUai2nSPwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16706-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 12:47:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C9011A5F5
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 12:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A941300D0E6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D381B31B80D;
	Tue, 10 Feb 2026 11:47:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EA52030A;
	Tue, 10 Feb 2026 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724058; cv=none; b=u6hHtUe+kZ6KcHQMtkE7JpSMxIDPoXw6pifyBxKnPg9uvB5X/bsG2XmmLAO/phN3XopHmUhrteTVaYPLr+04fC3qU7u70dsxlDwMHVLvcLa5+VTIEC3Yg68GZz3FR3TQAZ5HVBvtchYspmp4am3CZERQU4BvP1DaRHVsYZvYkpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724058; c=relaxed/simple;
	bh=xCh4bpvpyD8/osL25eeLBx94xZJOelWUWSyLnmZZQqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YzTaU/jKsyZUX/Oox+iYSSBX/CQEa2BlmQUNcPODnyAlFeBQGIaLsE56QM6wscQVK5M1hd1O7/j2xghtJpokzcBhSIyILVG9Rgp2MmH5dHfxcvpCGE20Oywwxj+kOjhNnvIoCnv7ywjl8Cl4cTgoi5BxgePbOmmlXNZMa8aPdEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-d3-698b1accddd2
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
Subject: [PATCH v3] mm: introduce a new page type for page pool in page type
Date: Tue, 10 Feb 2026 20:47:12 +0900
Message-Id: <20260210114712.55072-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH9/19f/f7/Tqd/ZynX5nhNjM2ecr2YWn+8904Q8aw0U2/1XGF
	60EZc9WNSiXycF2HS6NHjoseboUepGRKyQ7VJRR6QJGu2nLVGv+9935/Xq+/PhyWWyWenDok
	TNSGqDQKRkpLe91vLn/heU698t2LhWCy5DOQNxQJWe3FEnDmd1Fgyi1E8Mv5noWxsmoEA1XP
	GOiu7EeQmTGIwVSvp+G3ZRhDia0LwTfDHQY+V3ewkGdVguN2Jw2lZ4swdJyvYSBJP4KhzNnH
	QkxxtktcoGOhoTBZApeGb2Eo0rWz0GQzMdCWPyaBzookGmqNOTT8uFyFwZG8EarNc2CwrgdB
	laWIgsHEaww0p9koeFjWzEJqo5mBj3oHgsbKDhouj8YxkB6djGBkyKXsS/klgfSnbexGLxJt
	tzOksuc7Jg9y3lLkjeECTeyPnlOkxNjKErM1nBRkLyMJ9kZMrLnxDLH2X2RJy5tShtQYRmhS
	8mEdKSkeoEhSbB+zbfZeqU+AqFFHiNoVvv7SoKZWydHEPZE1mTqkQ5UkAblxAu8tjMVdZ6fy
	z4KmiczwSwS73YnH8yxeKdwtfI0SkJTDfB8rlD7+w4wPM/ktQpPu1USm+cWC3po1Acv4tUKt
	aYyalC4Q8u49wZP9DKE27ROdgDiXaIlguS4fr7HrJPZhOh73C3wLJ/Tm1KNJ1kMoz7bTKWi6
	8T/c+A83/oebEc5FcnVIRLBKrfH2CooKUUd6HTwSbEWuT7p9anRfMepv8KtAPIcU7jL/L/Fq
	uUQVERoVXIEEDitmyZTeZ9VyWYAq6oSoPXJAG64RQyvQPI5WzJWtHjweIOcDVWHiYVE8Kmqn
	Vopz89ShQJ9p5S/N3rnnd1+to6yb3Cinn81hWeB/pevLfbpn+txpMRmaG82tYZnVsDUrz3Jn
	R/eB2ecW7Uo9vEpzOiaj7MGZvS+DfPsNGyyfwo/pts/5uj/Wc/3nS0qmpTd1syNgkfu2pa2B
	p55p9GuyPTT6x+HiaTa23DJ/WGk4lLrT5p54UkGHBqlWLcPaUNVfSmVJckUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+853ds5pNTgts4MFxSqCSq3IeMMMI7CPyIoKukCXqQc9qFO2
	NO0CM9dtNbtoYXOGFZmptZrXiVY4M2c32ywWXbyUdhNTM8uUbBZR/z08z+/9/fVyWJkl8+Mk
	zS5Rq1HHqRg5LV8TnO7/wO+YNP9zqRws1mIGir6nwJXWShkMFr+jwFJYjqB/8AULIzX1CL7U
	3WPgk6MPwaULAxgsjw00fLX+wGCveofgY/Y1Bjrq21kosoVDS34nDdWHKzC0n2hgwGQYwlAz
	2M3CgcoCr7hEz4Ij1ymDpvIMGWT9uIyhQt/KgrvKwsDr4hEZdNaaaHCar9LQc6YOQ0tGKNTn
	+cLA/S4EddYKCgaO5zLw9FwVBWU1T1nIdOUx8MbQgsDlaKfhzPARBnLSMhAMffcqu0/2yyDn
	7ms2NJCkeTwMcXR9xqT06nOKPMs+RRPPrUaK2M2vWJJnSyIlBXOI0ePCxFZ4lCG2vtMsefms
	miEN2UM0sbctIfbKLxQxpXcz63y3ypdGiXFSsqgNXLZTHuN+JUs8viWl4ZIe6ZGDGNFYTuAX
	Cb0lbnY0M/xsweMZxKPZhw8Xrpc3IyOSc5jvZoXq29+Y0WEiv1pw65/8zjQ/SzDYrvw+VvBB
	gtMyQv2RThOKbtzBf/oJgvPcW9qIOK9otmA9rxytsRdJL8vBJ9E483+U+R9l/o/KQ7gQ+Uia
	5Hi1FBcUoIuNSdVIKQGRCfE25P2V/P3DpypRv3tlLeI5pBqvEIxGSSlTJ+tS42uRwGGVjyJ8
	0WFJqYhSp+4RtQk7tElxoq4WTeFo1WTFqk3iTiUfrd4lxopioqj9u1LcWD89WhwUsc8088SY
	qbb4bf5n833Wlg5tRj/nakKWT5J6Hz3PnuGeJ9/REN7TsX5qCJXxxGZeMfxQ53aF5ZDQ8zfb
	9GFVdFTL3u2NvvOmXCyL7HNZl+0OKIiOCBSCj0QNJBo+bUnKfG/fsNrk3L25+cOdmsgm5cJx
	nRunxxw85ApbKwmxsSpaF6NeMAdrdepf9kDtrCcDAAA=
X-CFilter-Loop: Reflected
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16706-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[sk.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[47];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: B6C9011A5F5
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
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
The following 'Acked-by's were given only for mm part:

  Acked-by: David Hildenbrand <david@redhat.com>
  Acked-by: Zi Yan <ziy@nvidia.com>

This patch changes both mm and page-pool, but I'm currently targetting
mm tree because Jakub asked and I also think it's more about mm change.
See the following link:

  https://lore.kernel.org/all/20250813075212.051b5178@kernel.org/

Changes from v2:
	1. Fix a issue reported by kernel test robot due to incorrect
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
index f8a8fd47399c4..15465f1bd68fc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4839,10 +4839,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
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
@@ -4877,26 +4876,6 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
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
index f7a0e4af0c734..39a21ee87b437 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -934,6 +934,7 @@ enum pagetype {
 	PGTY_zsmalloc		= 0xf6,
 	PGTY_unaccepted		= 0xf7,
 	PGTY_large_kmalloc	= 0xf8,
+	PGTY_netpp		= 0xf9,
 
 	PGTY_mapcount_underflow = 0xff
 };
@@ -1066,6 +1067,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
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
index 9e10f4ac50c3d..2a73b68f16b15 100644
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
index 81a9789c40013..206bfe98af285 100644
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
index 23175cb2bd866..02fbc4545ffa9 100644
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
+	netmem_ref clr_ref;
+
+	/* XXX: Now that the offset of page_type is shared between
+	 * struct page and net_iov, just cast the netmem to struct page
+	 * unconditionally by clearing NET_IOV if any, no matter whether
+	 * it comes from struct net_iov or struct page.  This should be
+	 * adjusted once the offset is no longer shared.
+	 */
+	clr_ref = (netmem_ref)((__force unsigned long)netmem & ~NET_IOV);
+	return PageNetpp(__netmem_to_page(clr_ref));
 }
 
 static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 265a729431bb7..32a13a065ad30 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -702,8 +702,18 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
 
 void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
+	netmem_ref clr_ref;
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
+	clr_ref = (netmem_ref)((__force unsigned long)netmem & ~NET_IOV);
+	__SetPageNetpp(__netmem_to_page(clr_ref));
 
 	/* Ensuring all pages have been split into one fragment initially:
 	 * page_pool_set_pp_info() is only called once for every page when it
@@ -718,7 +728,17 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 
 void page_pool_clear_pp_info(netmem_ref netmem)
 {
-	netmem_clear_pp_magic(netmem);
+	netmem_ref clr_ref;
+
+	/* XXX: Now that the offset of page_type is shared between
+	 * struct page and net_iov, just cast the netmem to struct page
+	 * unconditionally by clearing NET_IOV if any, no matter whether
+	 * it comes from struct net_iov or struct page.  This should be
+	 * adjusted once the offset is no longer shared.
+	 */
+	clr_ref = (netmem_ref)((__force unsigned long)netmem & ~NET_IOV);
+	__ClearPageNetpp(__netmem_to_page(clr_ref));
+
 	netmem_set_pp(netmem, NULL);
 }
 
-- 
2.17.1


