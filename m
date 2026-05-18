Return-Path: <linux-rdma+bounces-20898-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJmZKE/xCmpv+AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20898-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 13:00:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4546F56B210
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 13:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A39C30065C6
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C713F077C;
	Mon, 18 May 2026 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6491LHe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3173E32AABD;
	Mon, 18 May 2026 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102023; cv=none; b=gvu0WVADfslj0OcX8MdxvDZc+lMtImLiyREBEEakI6yRMAx4s9AdCv6OZ5loETo8cW4ZZ7d+TODlWoteyEYLnCRkB9Xmx0lSFS+GR2Om8sq06uYO/tJTIje39SgUX1Cuy38FvDHFfaKWI7Yl51eLPzi6QlpoepEIV7v+yrKoffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102023; c=relaxed/simple;
	bh=FHc0G3/xnjnqaR5kQLoT+qWz2mYKz5GEnLVNjxlKxyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz69NaAGGSATQpLFhunAJxcVwJssLZ/B7jt+7korFR5OHUkN+K3A//xVXrtLcKt5GPhIPHN8lvuokhp34W4YHI9iOn2FtFmcDMIxlF6ShVUDzD5X8HOfaWT8PYKed7ecygiVIrxazF/CM2QAqBiUa4Ud23+dNpflzRDYWsw6tGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6491LHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69A0C2BCB7;
	Mon, 18 May 2026 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779102022;
	bh=FHc0G3/xnjnqaR5kQLoT+qWz2mYKz5GEnLVNjxlKxyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6491LHe37SDRrVj7v/mPkLCVr++4ZIOxsbNjNQdpFxazBhqm5/eA+Z0bGvsZSFZ/
	 y7U0ya97FYLgSQZxl09X2rVnAW+KRzCcuW8AGBCk8vR6jU0gQvvPSydn/Ehv/PsK8b
	 jafzq09eBMYXZqf5qqy5mGu7WZk+ZRfMd6ELTVA47GhGxRUv68No5d0JpgcMioxZ5C
	 jCjRDZbAZ6tQEvqEY277/Q4su6ARAuUMTRezrPEHgZDyNZSO5ddlw8YiFK+K0AB8Wd
	 ElL4zf9+csl1mHEFwn+Gnw5wj+RotrmFz1vtkxGwXrUGRwIqk/NRLZXrqU4ydHV7um
	 lR5OQN/L+vJSg==
Date: Mon, 18 May 2026 12:00:11 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: akpm@linux-foundation.org, kernel_team@skhynix.com, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	pabeni@redhat.com, david@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org, 
	kas@kernel.org, willy@infradead.org, baolin.wang@linux.alibaba.com, 
	asml.silence@gmail.com, toke@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Revert "mm: introduce a new page type for page pool in
 page type"
Message-ID: <agruFy80Ag3uIab0@lucifer>
References: <20260515034701.17027-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515034701.17027-1-byungchul@sk.com>
X-Rspamd-Queue-Id: 4546F56B210
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20898-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,skhynix.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,infradead.org,suse.com,cmpxchg.org,linaro.org,linux.alibaba.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Maybe worth putting [PATCH mm-hotfixes] just to make it clear this should be an
urgent hotfix?

On Fri, May 15, 2026 at 12:47:01PM +0900, Byungchul Park wrote:
> This reverts commit db359fccf212e7fa3136e6edbed6228475646fd7.

Maybe 'this reverts commit db359fccf212 ("...") and partially reverts commit
735a309b4bfb9e ("...") <details>'?

>
> Netpp page_type'ed pages might be used in mapping so as to use
> @_mapcount.  However, since @page_type and @_mapcount are union'ed in
> struct page, these two can't be used at the same time.  Revert the
> commit introducing page_type for Netpp for now.

Yikes!

>
> The patch will be retried once @page_type and @_mapcount get allowed to
> be used at the same time.
>
> The revert also includes removal of @page_type initialization part
> introduced by commit 735a309b4bfb9e ("net: add net_iov_init() and use it
> to initialize ->page_type"), which will be restored on the retry.

As above maybe mentioning at top of commit msg, as right now this reads as a
pure revert of db359fccf212.

>
> Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
> Closes: https://lore.kernel.org/all/982b9bc1-0a0a-4fc5-8e3a-3672db2b29a1@nvidia.com

Fixes tag?

> Signed-off-by: Byungchul Park <byungchul@sk.com>

This LGTM, but see above for nits. So:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

Cheers, Lorenzo

> ---
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
>  include/linux/mm.h                            | 27 ++++++++++++++++---
>  include/linux/page-flags.h                    |  6 -----
>  include/net/netmem.h                          | 19 ++-----------
>  mm/page_alloc.c                               | 13 +++------
>  net/core/netmem_priv.h                        | 23 +++++++++-------
>  net/core/page_pool.c                          | 24 ++---------------
>  7 files changed, 46 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 190b8b66b3ce1..d3bab198c99c0 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -708,7 +708,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
>  				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
>  				page = xdpi.page.page;
>
> -				/* No need to check PageNetpp() as we
> +				/* No need to check page_pool_page_is_pp() as we
>  				 * know this is a page_pool page.
>  				 */
>  				page_pool_recycle_direct(pp_page_to_nmdesc(page)->pp,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 31e27ff6a35fa..9cedc5e75aa93 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -5156,9 +5156,10 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>   * DMA mapping IDs for page_pool
>   *
>   * When DMA-mapping a page, page_pool allocates an ID (from an xarray) and
> - * stashes it in the upper bits of page->pp_magic. Non-PP pages can have
> - * arbitrary kernel pointers stored in the same field as pp_magic (since
> - * it overlaps with page->lru.next), so we must ensure that we cannot
> + * stashes it in the upper bits of page->pp_magic. We always want to be able to
> + * unambiguously identify page pool pages (using page_pool_page_is_pp()). Non-PP
> + * pages can have arbitrary kernel pointers stored in the same field as pp_magic
> + * (since it overlaps with page->lru.next), so we must ensure that we cannot
>   * mistake a valid kernel pointer with any of the values we write into this
>   * field.
>   *
> @@ -5193,6 +5194,26 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>  #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
>  				  PP_DMA_INDEX_SHIFT)
>
> +/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
> + * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
> + * the head page of compound page and bit 1 for pfmemalloc page, as well as the
> + * bits used for the DMA index. page_is_pfmemalloc() is checked in
> + * __page_pool_put_page() to avoid recycling the pfmemalloc page.
> + */
> +#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> +
> +#ifdef CONFIG_PAGE_POOL
> +static inline bool page_pool_page_is_pp(const struct page *page)
> +{
> +	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> +}
> +#else
> +static inline bool page_pool_page_is_pp(const struct page *page)
> +{
> +	return false;
> +}
> +#endif
> +
>  #define PAGE_SNAPSHOT_FAITHFUL (1 << 0)
>  #define PAGE_SNAPSHOT_PG_BUDDY (1 << 1)
>  #define PAGE_SNAPSHOT_PG_IDLE  (1 << 2)
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 0e03d816e8b9d..7223f6f4e2b40 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -923,7 +923,6 @@ enum pagetype {
>  	PGTY_zsmalloc		= 0xf6,
>  	PGTY_unaccepted		= 0xf7,
>  	PGTY_large_kmalloc	= 0xf8,
> -	PGTY_netpp		= 0xf9,
>
>  	PGTY_mapcount_underflow = 0xff
>  };
> @@ -1056,11 +1055,6 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
>  PAGE_TYPE_OPS(LargeKmalloc, large_kmalloc, large_kmalloc)
>
> -/*
> - * Marks page_pool allocated pages.
> - */
> -PAGE_TYPE_OPS(Netpp, netpp, netpp)
> -
>  /**
>   * PageHuge - Determine if the page belongs to hugetlbfs
>   * @page: The page to test.
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 78fe51e5756b1..bccacd21b6c37 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -94,20 +94,10 @@ enum net_iov_type {
>   */
>  struct net_iov {
>  	struct netmem_desc desc;
> -	unsigned int page_type;
>  	enum net_iov_type type;
>  	struct net_iov_area *owner;

Nit, but this isn't a straight revert, as in the original code owner came before
type :P

I'm not sure this really matters though (the size should remain the same also
either way).


>  };
>
> -/* Make sure 'the offset of page_type in struct page == the offset of
> - * type in struct net_iov'.
> - */
> -#define NET_IOV_ASSERT_OFFSET(pg, iov)			\
> -	static_assert(offsetof(struct page, pg) ==	\
> -		      offsetof(struct net_iov, iov))
> -NET_IOV_ASSERT_OFFSET(page_type, page_type);
> -#undef NET_IOV_ASSERT_OFFSET
> -
>  struct net_iov_area {
>  	/* Array of net_iovs for this area. */
>  	struct net_iov *niovs;
> @@ -127,11 +117,7 @@ static inline unsigned int net_iov_idx(const struct net_iov *niov)
>  	return niov - net_iov_owner(niov)->niovs;
>  }
>
> -/* Initialize a niov: stamp the owning area, the memory provider type,
> - * and the page_type "no type" sentinel expected by the page-type API
> - * (see PAGE_TYPE_OPS in <linux/page-flags.h>) so that
> - * page_pool_set_pp_info() can later call __SetPageNetpp() on a niov
> - * cast to struct page.
> +/* Initialize a niov: stamp the owning area, the memory provider type.
>   */
>  static inline void net_iov_init(struct net_iov *niov,
>  				struct net_iov_area *owner,
> @@ -139,7 +125,6 @@ static inline void net_iov_init(struct net_iov *niov,
>  {
>  	niov->owner = owner;
>  	niov->type = type;
> -	niov->page_type = UINT_MAX;
>  }

Ah OK this must be the part of the revert from 735a309b4bfb9e.

>
>  /* netmem */
> @@ -245,7 +230,7 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
>   */
>  #define pp_page_to_nmdesc(p)						\
>  ({									\
> -	DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));				\
> +	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
>  	__pp_page_to_nmdesc(p);						\
>  })
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e262d1316259d..91e7075918ada 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1046,6 +1046,7 @@ static inline bool page_expected_state(struct page *page,
>  #ifdef CONFIG_MEMCG
>  			page->memcg_data |
>  #endif
> +			page_pool_page_is_pp(page) |
>  			(page->flags.f & check_flags)))
>  		return false;
>
> @@ -1072,6 +1073,8 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>  	if (unlikely(page->memcg_data))
>  		bad_reason = "page still charged to cgroup";
>  #endif
> +	if (unlikely(page_pool_page_is_pp(page)))
> +		bad_reason = "page_pool leak";
>  	return bad_reason;
>  }
>
> @@ -1395,17 +1398,9 @@ static __always_inline bool __free_pages_prepare(struct page *page,
>  		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>  		folio->mapping = NULL;
>  	}
> -	if (unlikely(page_has_type(page))) {
> -		/* networking expects to clear its page type before releasing */
> -		if (is_check_pages_enabled()) {
> -			if (unlikely(PageNetpp(page))) {
> -				bad_page(page, "page_pool leak");
> -				return false;
> -			}
> -		}
> +	if (unlikely(page_has_type(page)))
>  		/* Reset the page_type (which overlays _mapcount) */
>  		page->page_type = UINT_MAX;
> -	}
>
>  	if (is_check_pages_enabled()) {
>  		if (free_page_is_bad(page))
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index 3e6fde8f1726f..23175cb2bd866 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -8,18 +8,21 @@ static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
>  	return netmem_to_nmdesc(netmem)->pp_magic & ~PP_DMA_INDEX_MASK;
>  }
>
> -static inline bool netmem_is_pp(netmem_ref netmem)
> +static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
> +{
> +	netmem_to_nmdesc(netmem)->pp_magic |= pp_magic;
> +}
> +
> +static inline void netmem_clear_pp_magic(netmem_ref netmem)
>  {
> -	struct page *page;
> +	WARN_ON_ONCE(netmem_to_nmdesc(netmem)->pp_magic & PP_DMA_INDEX_MASK);
>
> -	/* XXX: Now that the offset of page_type is shared between
> -	 * struct page and net_iov, just cast the netmem to struct page
> -	 * unconditionally by clearing NET_IOV if any, no matter whether
> -	 * it comes from struct net_iov or struct page.  This should be
> -	 * adjusted once the offset is no longer shared.
> -	 */
> -	page = (struct page *)((__force unsigned long)netmem & ~NET_IOV);
> -	return PageNetpp(page);
> +	netmem_to_nmdesc(netmem)->pp_magic = 0;
> +}
> +
> +static inline bool netmem_is_pp(netmem_ref netmem)
> +{
> +	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
>  }
>
>  static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 6e576dec80db4..8171d1173221b 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -707,18 +707,8 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
>
>  void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>  {
> -	struct page *page;
> -
>  	netmem_set_pp(netmem, pool);
> -
> -	/* XXX: Now that the offset of page_type is shared between
> -	 * struct page and net_iov, just cast the netmem to struct page
> -	 * unconditionally by clearing NET_IOV if any, no matter whether
> -	 * it comes from struct net_iov or struct page.  This should be
> -	 * adjusted once the offset is no longer shared.
> -	 */
> -	page = (struct page *)((__force unsigned long)netmem & ~NET_IOV);
> -	__SetPageNetpp(page);
> +	netmem_or_pp_magic(netmem, PP_SIGNATURE);
>
>  	/* Ensuring all pages have been split into one fragment initially:
>  	 * page_pool_set_pp_info() is only called once for every page when it
> @@ -733,17 +723,7 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>
>  void page_pool_clear_pp_info(netmem_ref netmem)
>  {
> -	struct page *page;
> -
> -	/* XXX: Now that the offset of page_type is shared between
> -	 * struct page and net_iov, just cast the netmem to struct page
> -	 * unconditionally by clearing NET_IOV if any, no matter whether
> -	 * it comes from struct net_iov or struct page.  This should be
> -	 * adjusted once the offset is no longer shared.
> -	 */
> -	page = (struct page *)((__force unsigned long)netmem & ~NET_IOV);
> -	__ClearPageNetpp(page);
> -
> +	netmem_clear_pp_magic(netmem);
>  	netmem_set_pp(netmem, NULL);
>  }
>
>
> base-commit: 0cec77cfd5314c0b3b03530abe1a4b32e991f639
> --
> 2.17.1
>

