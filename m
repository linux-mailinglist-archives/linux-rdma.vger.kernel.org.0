Return-Path: <linux-rdma+bounces-14083-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3B9C128B6
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 02:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCFB562C9D
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 01:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965FD2253FF;
	Tue, 28 Oct 2025 01:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lcSjYkrs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFDDB672
	for <linux-rdma@vger.kernel.org>; Tue, 28 Oct 2025 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614924; cv=none; b=GjwmWw35q/06Glqq2HDox0asegKxp0J7GLcbORaLPWO4wkFsIlw5/iTnkTToYjWmX9Vpx8F1o2EYKCG+BAv521yECwf+Fg8fTrD8ms3FnRX0vItHas73zHID2MC0rIwVkYRKI+fPtUUenoqfpjHFb5QiX6sNBIrlvNtrMujdKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614924; c=relaxed/simple;
	bh=aGG3Gw+w6lOYVsiP26zpdZv4HXKbmHv+t/RvawfEBeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfLHbTHpVZpPo+g6++2874WnCpYg+F8JTuLIW7nD5Qtg5HXgKW2+njDItjFKQi/cbx/GN255Ysygytk5JQiuWClp1QpuXFyStYfH+KEWXSlokvqV5JRya7BM4k++JYV53KVimAJwg0K/Vi1gju/Of4aGX06qJM5w3B/sDakmfgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lcSjYkrs; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-587bdad8919so3837e87.0
        for <linux-rdma@vger.kernel.org>; Mon, 27 Oct 2025 18:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761614920; x=1762219720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uudUrLm/0mjXC7TKzbbAq1WAckCAEYcLZ5na1CdGW7A=;
        b=lcSjYkrspnbLS5O7aoUCoaikErc82vyE5O6KJAbsFXRPb2NYw0jKojUDrVEE47LWDx
         lqyiSf2YKAmzu1z4GOzR8ptiZSWgbTnpoaamWhTS25Q/9NOfiZxmv3HwSSzkVObUGEff
         NlTxz6DqfDK8FJlJw/NDL6RfM/rlweoY/7pt+CIojqISaume2BKFs2+Ju1m2fmfcGMdb
         d4JlEtGPuWd0A/SUQYBxfad7aveLZyhtCp309C09H2jx0+R9QgvthwbsT/lAX4myamka
         XxAtDjc0ul1onBOlgY9sAvczGjmIHzPoQet8UBCBgQwaFj2M5PvzQ0BMSICMwqjg9sj3
         mSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761614920; x=1762219720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uudUrLm/0mjXC7TKzbbAq1WAckCAEYcLZ5na1CdGW7A=;
        b=jdr3TmK7K+Ea0MqursWHzDiiLSDfV5oeNysGHlbhtYdSVA4E+jFUjqZuL1YHK/qi9g
         kCIwCYPFiAyVtRwSla9a+Le13Jp0kQKtghNVpCTDIjLDoqYklXGrLivcyK3wFKnvz+7P
         wQVdMe0kSidt2197IBOHlidVjOZ6jAQuanCOgIqtRKkbPCpItSB7YJvKXjhEFMzOriDw
         QEE5lNU4RE+gb7s4KQbhJniWm/dun2ZkPCt8P2tx/AtyuEgdCu4bSzPETXnCYf2XxJf6
         TzAnXo03lgMgfz/SciCjCT5XzA5NNP8aDIBpEguW4NZtomKJpY5RzXLWAJQlGgN6hnzD
         o68w==
X-Forwarded-Encrypted: i=1; AJvYcCXjXEpUYngllIxcd3bc4KjKtTqLeMvz+s4Av1bPxF1iE2ApVmt0kK5ntFgi/GZf27XYWyWsDMwz53K8@vger.kernel.org
X-Gm-Message-State: AOJu0YxS90vx2Yswgkf6GPy+Lj+Bvs+Epn3v0VNBGbt8JiOKixfqTKEZ
	E6sYC5M1QFlJ2uAQ5DtmMlpUm+ZBqlDj8APvdbsjyQ27UxiSA68OUFIiznlKYS8vFXjgHW3ZNnI
	5UEop2phAJRzcIc6m7EzkxkPAi4JINL6fR5PIW/zn
X-Gm-Gg: ASbGnct1hHCdNHxCNQ2qkd4YlOZf8BbHmDWTPcrEK4duP8HBgMRRU2DVPFod5kyZLLo
	Ry6m+hrTPm6Mj14FHJ5QdzCVQcLVr3nt63pTM16ATNqg5X/DZQ3dkOH1mgNW0fhyV6qIntdbuvO
	3oole8HEQtDPDQ05wSNI08Ewdr73bQKbFPhDesb0++z744QTbS9g2O0YBN2ASdNuPqC9zAlDoAz
	/sbzgGDtmOM4aTDV2JyDCPB4VKFbwvHCCT56QE9JotEew7aMzfMvDbMqMRF
X-Google-Smtp-Source: AGHT+IFBoLiQRrpBTKUGaTQcXL4ERfHZgHQ/w/BLDv8lG1Ga2BhuiFhb7mtWJmnIqYrW8x0KSDkdefcJDzm8uzajoY0=
X-Received: by 2002:a05:6512:ad2:b0:592:ee58:60a4 with SMTP id
 2adb3069b0e04-5930eee6e42mr242838e87.0.1761614919618; Mon, 27 Oct 2025
 18:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023074410.78650-1-byungchul@sk.com> <20251023074410.78650-3-byungchul@sk.com>
In-Reply-To: <20251023074410.78650-3-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 27 Oct 2025 18:28:09 -0700
X-Gm-Features: AWmQ_bnqYdKwxxg9YQPGoqUVrnDXXkWGqIBoMC60Klx63No-6OANkxxfufMibgc
Message-ID: <CAHS8izME4W3ENXNXf4Cxegmk9xnRmKajpRMQ18L0=FGTFebeaw@mail.gmail.com>
Subject: Re: [RFC mm v4 2/2] mm: introduce a new page type for page pool in
 page type
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org, 
	kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com, 
	baolin.wang@linux.alibaba.com, toke@redhat.com, asml.silence@gmail.com, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, 
	dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:45=E2=80=AFAM Byungchul Park <byungchul@sk.com> =
wrote:
>
> ->pp_magic field in struct page is current used to identify if a page
> belongs to a page pool.  However, ->pp_magic will be removed and page
> type bit in struct page e.i. PGTY_netpp can be used for that purpose.
>
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
>
> This work was inspired by the following link:
>
> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmai=
l.com/
>
> While at it, move the sanity check for page pool to on free.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> ---
> Hi Mina,
>
> I dropped your Reviewed-by tag since there are updates on some comments
> in network part.  Can I still keep your Reviewed-by?
>
>         Byungchul
> ---
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
>  include/linux/mm.h                            | 27 +++----------------
>  include/linux/page-flags.h                    |  6 +++++
>  include/net/netmem.h                          |  2 +-
>  mm/page_alloc.c                               |  8 +++---
>  net/core/netmem_priv.h                        | 17 +++---------
>  net/core/page_pool.c                          | 14 +++++-----
>  7 files changed, 25 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/en/xdp.c
> index 5d51600935a6..def274f5c1ca 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -707,7 +707,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq =
*sq,
>                                 xdpi =3D mlx5e_xdpi_fifo_pop(xdpi_fifo);
>                                 page =3D xdpi.page.page;
>
> -                               /* No need to check page_pool_page_is_pp(=
) as we
> +                               /* No need to check PageNetpp() as we
>                                  * know this is a page_pool page.
>                                  */
>                                 page_pool_recycle_direct(pp_page_to_nmdes=
c(page)->pp,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b6fdf3557807..f5155f1c75f5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4361,10 +4361,9 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>   * DMA mapping IDs for page_pool
>   *
>   * When DMA-mapping a page, page_pool allocates an ID (from an xarray) a=
nd
> - * stashes it in the upper bits of page->pp_magic. We always want to be =
able to
> - * unambiguously identify page pool pages (using page_pool_page_is_pp())=
. Non-PP
> - * pages can have arbitrary kernel pointers stored in the same field as =
pp_magic
> - * (since it overlaps with page->lru.next), so we must ensure that we ca=
nnot
> + * stashes it in the upper bits of page->pp_magic. Non-PP pages can have
> + * arbitrary kernel pointers stored in the same field as pp_magic (since
> + * it overlaps with page->lru.next), so we must ensure that we cannot
>   * mistake a valid kernel pointer with any of the values we write into t=
his
>   * field.
>   *
> @@ -4399,26 +4398,6 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>  #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT=
 - 1, \
>                                   PP_DMA_INDEX_SHIFT)
>
> -/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magi=
c is
> - * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit=
 0 for
> - * the head page of compound page and bit 1 for pfmemalloc page, as well=
 as the
> - * bits used for the DMA index. page_is_pfmemalloc() is checked in
> - * __page_pool_put_page() to avoid recycling the pfmemalloc page.
> - */
> -#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> -
> -#ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(const struct page *page)
> -{
> -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> -}
> -#else
> -static inline bool page_pool_page_is_pp(const struct page *page)
> -{
> -       return false;
> -}
> -#endif
> -
>  #define PAGE_SNAPSHOT_FAITHFUL (1 << 0)
>  #define PAGE_SNAPSHOT_PG_BUDDY (1 << 1)
>  #define PAGE_SNAPSHOT_PG_IDLE  (1 << 2)
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 0091ad1986bf..edf5418c91dd 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -934,6 +934,7 @@ enum pagetype {
>         PGTY_zsmalloc           =3D 0xf6,
>         PGTY_unaccepted         =3D 0xf7,
>         PGTY_large_kmalloc      =3D 0xf8,
> +       PGTY_netpp              =3D 0xf9,
>
>         PGTY_mapcount_underflow =3D 0xff
>  };
> @@ -1078,6 +1079,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>  PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
>  FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
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
> index 651e2c62d1dd..0ec4c7561081 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -260,7 +260,7 @@ static inline unsigned long netmem_pfn_trace(netmem_r=
ef netmem)
>   */
>  #define pp_page_to_nmdesc(p)                                           \
>  ({                                                                     \
> -       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));               \
> +       DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));                          \
>         __pp_page_to_nmdesc(p);                                         \
>  })
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fb91c566327c..c69ed3741bbc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1042,7 +1042,6 @@ static inline bool page_expected_state(struct page =
*page,
>  #ifdef CONFIG_MEMCG
>                         page->memcg_data |
>  #endif
> -                       page_pool_page_is_pp(page) |

Shouldn't you replace the page_pool_page_is_pp check with a PageNetpp
check in this call site and below? Or is that no longer necessary for
some reason?

