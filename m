Return-Path: <linux-rdma+bounces-20563-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA0KJhhJBGrNGgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20563-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 11:49:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3824D530ED6
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 11:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72CD2303D71A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 09:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EBB3EAC7D;
	Wed, 13 May 2026 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr8uxAh+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CC33E9F61;
	Wed, 13 May 2026 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665362; cv=none; b=lGxSeZxlIrM7SZ8VrXRu/b+pVbuyv6BxatoFqBM0BNB4YCFfCPNAYNRRsxhji9R5Vi1jZxl6dlI/Xg+ByTR7jozR93Q9RSwl5fvRYkM21knNkVlHoNDzAmgF72fVuzjynaDWO0TTucPGjGlQ7adbZHZz5rvQXlISzzTghMATN2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665362; c=relaxed/simple;
	bh=i+awaBjbzoGv+bzIIAVOHA5A0tzwaWXH1wgME3EZtME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaOgR2cAdHmCw9r+IeyPcVmXpG2WhVE99peiarqBNf6JS1RlCq8SlVnXZjsHLAwc2QCtYsTtOzmW6opXo3QsRxqjoWqqZ3tAaR65lkqZnY8m9n7X6NXeTkrZtWrKGQeTc4mlLB/xo+UKac21/z8wN0zOXJkNSfI0IfErwFuwez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr8uxAh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23B4C2BCB7;
	Wed, 13 May 2026 09:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778665361;
	bh=i+awaBjbzoGv+bzIIAVOHA5A0tzwaWXH1wgME3EZtME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cr8uxAh+loQpjXmCoE2TaiGITt+TcZwPIbr+2RkfQvmH016d7LsS1fYXzAGa6tfaf
	 9aDJgI4NZQWIIfDBz/fxuLE/C3bF1QUfjJm+eaXZpA2bd1iUEfFaidDc9+2lnQk7Q3
	 fQJRqh1thkcoH/XcJKSphQ+kRTI9UCWbfmO7NEFJcIOb1DT9Y1d3+rxytyM6koiRnU
	 o67Kghqz/3Sl1fwOV1noQq1Zz+1JhcTHzbgMwOwLPK3z3cP5r0vFt1ZXjSDshcLTta
	 3mJYS/6/YKEFhO2y4qtuIGDtUUcWsUjMz9l5ZpGFjeP+r/soM1XXNhz2++NoEly8au
	 TOmcMnI67TGGw==
Date: Wed, 13 May 2026 10:42:38 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	pabeni@redhat.com, david@kernel.org, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org, 
	willy@infradead.org, brauner@kernel.org, kas@kernel.org, yuzhao@google.com, 
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com, almasrymina@google.com, 
	toke@redhat.com, asml.silence@gmail.com, bpf@vger.kernel.org, 
	linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com, 
	dtatulea@nvidia.com
Subject: Re: [PATCH v4] mm: introduce a new page type for page pool in page
 type
Message-ID: <agRHF2EnFw-OZ2-u@lucifer>
References: <20260224051347.19621-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224051347.19621-1-byungchul@sk.com>
X-Rspamd-Queue-Id: 3824D530ED6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20563-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,vger.kernel.org,skhynix.com,oracle.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,sk.com:email,nvidia.com:email]
X-Rspamd-Action: no action

-cc previous kernel mail address
-cc David's very previous kernel mail address
+cc David's current mail address

Hi,

Just an annoying reminder to please check people's addresses via
get_maintainer.pl, as otherwise stuff might get missed! :)

Cheers, Lorenzo

On Tue, Feb 24, 2026 at 02:13:47PM +0900, Byungchul Park wrote:
> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of @pp_magic, we should instead leverage the page_type in struct
> page, such as PGTY_netpp, for this purpose.
>
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
>
> Plus, add @page_type to struct net_iov at the same offset as struct page
> so as to use the page_type APIs for struct net_iov as well.  While at it,
> reorder @type and @owner in struct net_iov to avoid a hole and
> increasing the struct size.
>
> This work was inspired by the following link:
>
>   https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
>
> While at it, move the sanity check for page pool to on the free path.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
> The following 'Acked-by's were given only for mm part:
>
>   Acked-by: David Hildenbrand <david@redhat.com>
>   Acked-by: Zi Yan <ziy@nvidia.com>
>   Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> This patch changes both mm and page-pool, but I'm currently targetting
> mm tree because Jakub asked and I also think it's more about mm change.
> See the following link:
>
>   https://lore.kernel.org/all/20250813075212.051b5178@kernel.org/
>
> Changes from v3:
> 	1. Rebase on mm-new as of Feb 24, 2026.
> 	2. Fix an issue reported by kernel test robot due to incorrect
> 	   type.
> 	3. Add 'Acked-by: Vlastimil Babka <vbabka@suse.cz>'.  Thanks.
>
> Changes from v2:
> 	1. Fix an issue reported by kernel test robot due to incorrect
> 	   type in argument of __netmem_to_page().
>
> Changes from v1:
> 	1. Drop the finalizing patch removing the pp fields of struct
> 	   page since I found that there is still code accessing a pp
> 	   field via struct page.  I will retry the finalizing patch
> 	   after resolving the issue.
> ---
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
>  include/linux/mm.h                            | 27 +++----------------
>  include/linux/page-flags.h                    |  6 +++++
>  include/net/netmem.h                          | 15 +++++++++--
>  mm/page_alloc.c                               | 11 +++++---
>  net/core/netmem_priv.h                        | 23 +++++++---------
>  net/core/page_pool.c                          | 24 +++++++++++++++--
>  7 files changed, 62 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 80f9fc10877ad..7d90d2485c787 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -707,7 +707,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
>  				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
>  				page = xdpi.page.page;
>
> -				/* No need to check page_pool_page_is_pp() as we
> +				/* No need to check PageNetpp() as we
>  				 * know this is a page_pool page.
>  				 */
>  				page_pool_recycle_direct(pp_page_to_nmdesc(page)->pp,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 13336340612e2..0db764b3d6b84 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4824,10 +4824,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>   * DMA mapping IDs for page_pool
>   *
>   * When DMA-mapping a page, page_pool allocates an ID (from an xarray) and
> - * stashes it in the upper bits of page->pp_magic. We always want to be able to
> - * unambiguously identify page pool pages (using page_pool_page_is_pp()). Non-PP
> - * pages can have arbitrary kernel pointers stored in the same field as pp_magic
> - * (since it overlaps with page->lru.next), so we must ensure that we cannot
> + * stashes it in the upper bits of page->pp_magic. Non-PP pages can have
> + * arbitrary kernel pointers stored in the same field as pp_magic (since
> + * it overlaps with page->lru.next), so we must ensure that we cannot
>   * mistake a valid kernel pointer with any of the values we write into this
>   * field.
>   *
> @@ -4862,26 +4861,6 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>  #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
>  				  PP_DMA_INDEX_SHIFT)
>
> -/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
> - * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
> - * the head page of compound page and bit 1 for pfmemalloc page, as well as the
> - * bits used for the DMA index. page_is_pfmemalloc() is checked in
> - * __page_pool_put_page() to avoid recycling the pfmemalloc page.
> - */
> -#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> -
> -#ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(const struct page *page)
> -{
> -	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> -}
> -#else
> -static inline bool page_pool_page_is_pp(const struct page *page)
> -{
> -	return false;
> -}
> -#endif
> -
>  #define PAGE_SNAPSHOT_FAITHFUL (1 << 0)
>  #define PAGE_SNAPSHOT_PG_BUDDY (1 << 1)
>  #define PAGE_SNAPSHOT_PG_IDLE  (1 << 2)
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 0426cac91c0bb..30c4eb24e4edf 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -939,6 +939,7 @@ enum pagetype {
>  	PGTY_zsmalloc		= 0xf6,
>  	PGTY_unaccepted		= 0xf7,
>  	PGTY_large_kmalloc	= 0xf8,
> +	PGTY_netpp		= 0xf9,
>
>  	PGTY_mapcount_underflow = 0xff
>  };
> @@ -1071,6 +1072,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
>  PAGE_TYPE_OPS(LargeKmalloc, large_kmalloc, large_kmalloc)
>
> +/*
> + * Marks page_pool allocated pages.
> + */
> +PAGE_TYPE_OPS(Netpp, netpp, netpp)
> +
>  /**
>   * PageHuge - Determine if the page belongs to hugetlbfs
>   * @page: The page to test.
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index a96b3e5e5574c..85e3b26ec547f 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -110,10 +110,21 @@ struct net_iov {
>  			atomic_long_t pp_ref_count;
>  		};
>  	};
> -	struct net_iov_area *owner;
> +
> +	unsigned int page_type;
>  	enum net_iov_type type;
> +	struct net_iov_area *owner;
>  };
>
> +/* Make sure 'the offset of page_type in struct page == the offset of
> + * type in struct net_iov'.
> + */
> +#define NET_IOV_ASSERT_OFFSET(pg, iov)			\
> +	static_assert(offsetof(struct page, pg) ==	\
> +		      offsetof(struct net_iov, iov))
> +NET_IOV_ASSERT_OFFSET(page_type, page_type);
> +#undef NET_IOV_ASSERT_OFFSET
> +
>  struct net_iov_area {
>  	/* Array of net_iovs for this area. */
>  	struct net_iov *niovs;
> @@ -256,7 +267,7 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
>   */
>  #define pp_page_to_nmdesc(p)						\
>  ({									\
> -	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
> +	DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));				\
>  	__pp_page_to_nmdesc(p);						\
>  })
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d88c8c67ac0b7..cae9f93271469 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1079,7 +1079,6 @@ static inline bool page_expected_state(struct page *page,
>  #ifdef CONFIG_MEMCG
>  			page->memcg_data |
>  #endif
> -			page_pool_page_is_pp(page) |
>  			(page->flags.f & check_flags)))
>  		return false;
>
> @@ -1106,8 +1105,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>  	if (unlikely(page->memcg_data))
>  		bad_reason = "page still charged to cgroup";
>  #endif
> -	if (unlikely(page_pool_page_is_pp(page)))
> -		bad_reason = "page_pool leak";
>  	return bad_reason;
>  }
>
> @@ -1416,9 +1413,15 @@ __always_inline bool __free_pages_prepare(struct page *page,
>  		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>  		folio->mapping = NULL;
>  	}
> -	if (unlikely(page_has_type(page)))
> +	if (unlikely(page_has_type(page))) {
> +		/* networking expects to clear its page type before releasing */
> +		if (unlikely(PageNetpp(page))) {
> +			bad_page(page, "page_pool leak");
> +			return false;
> +		}
>  		/* Reset the page_type (which overlays _mapcount) */
>  		page->page_type = UINT_MAX;
> +	}
>
>  	if (is_check_pages_enabled()) {
>  		if (free_page_is_bad(page))
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index 23175cb2bd866..3e6fde8f1726f 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -8,21 +8,18 @@ static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
>  	return netmem_to_nmdesc(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
>  }
>
> -static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
> -{
> -	netmem_to_nmdesc(netmem)->pp_magic |= pp_magic;
> -}
> -
> -static inline void netmem_clear_pp_magic(netmem_ref netmem)
> -{
> -	WARN_ON_ONCE(netmem_to_nmdesc(netmem)->pp_magic & PP_DMA_INDEX_MASK);
> -
> -	netmem_to_nmdesc(netmem)->pp_magic = 0;
> -}
> -
>  static inline bool netmem_is_pp(netmem_ref netmem)
>  {
> -	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
> +	struct page *page;
> +
> +	/* XXX: Now that the offset of page_type is shared between
> +	 * struct page and net_iov, just cast the netmem to struct page
> +	 * unconditionally by clearing NET_IOV if any, no matter whether
> +	 * it comes from struct net_iov or struct page.  This should be
> +	 * adjusted once the offset is no longer shared.
> +	 */
> +	page = (struct page *)((__force unsigned long)netmem & ~NET_IOV);
> +	return PageNetpp(page);
>  }
>
>  static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 265a729431bb7..877bbf7a19389 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -702,8 +702,18 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
>
>  void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>  {
> +	struct page *page;
> +
>  	netmem_set_pp(netmem, pool);
> -	netmem_or_pp_magic(netmem, PP_SIGNATURE);
> +
> +	/* XXX: Now that the offset of page_type is shared between
> +	 * struct page and net_iov, just cast the netmem to struct page
> +	 * unconditionally by clearing NET_IOV if any, no matter whether
> +	 * it comes from struct net_iov or struct page.  This should be
> +	 * adjusted once the offset is no longer shared.
> +	 */
> +	page = (struct page *)((__force unsigned long)netmem & ~NET_IOV);
> +	__SetPageNetpp(page);
>
>  	/* Ensuring all pages have been split into one fragment initially:
>  	 * page_pool_set_pp_info() is only called once for every page when it
> @@ -718,7 +728,17 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>
>  void page_pool_clear_pp_info(netmem_ref netmem)
>  {
> -	netmem_clear_pp_magic(netmem);
> +	struct page *page;
> +
> +	/* XXX: Now that the offset of page_type is shared between
> +	 * struct page and net_iov, just cast the netmem to struct page
> +	 * unconditionally by clearing NET_IOV if any, no matter whether
> +	 * it comes from struct net_iov or struct page.  This should be
> +	 * adjusted once the offset is no longer shared.
> +	 */
> +	page = (struct page *)((__force unsigned long)netmem & ~NET_IOV);
> +	__ClearPageNetpp(page);
> +
>  	netmem_set_pp(netmem, NULL);
>  }
>
> --
> 2.17.1
>

