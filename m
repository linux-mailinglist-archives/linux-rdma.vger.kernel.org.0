Return-Path: <linux-rdma+bounces-8980-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8737EA71A6B
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 16:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C243BAEAB
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696F91F4160;
	Wed, 26 Mar 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHQ+4T+p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E21F0E5D
	for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003029; cv=none; b=Nj11GC4mhOkJxh/vGcXJihA5BSKnbuFD1A9yaCkkV3VB2IiHy761yKArWHS7QVflRBftPZ9cBF0UWcmjkxwIxAu8mgmOWe1lb9hrBKcbqiFVokoa7Z9FZ3PJOjvGLmlzlxvos0xpGu44ERGlPpxP1BCCNyF9HRnlvkmIuK7E884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003029; c=relaxed/simple;
	bh=Cv64vhmr3AnQcFMcFJ9GFOHmofZWm79nyfDAYd/Jy4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuE/UKIEm8c/pLZVAyhZtK51SL9jS5Ow8TE0CYejCIVsUc8cAMLFQZuvMPuv7znVHZyzSodDCm3lHNRoYhBW7dGTQUrDOI/O4uyCpfR+ZLofKZByt0XM5Kcr5zq/rQN/ArZm07n9E0SFOi1Tp48uXmPCZ6y2aG2yRO6H03kQlak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHQ+4T+p; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e60cab0f287so16496276.0
        for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743003026; x=1743607826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tp8PX3VrlT3xj5/bJFgA5hrm+xCmQXv7oRpmonMlOI=;
        b=EHQ+4T+pU7CXfIaF0yYJRiv4W6THMOFnnMGgkiys1Gg9GoRPuZErUP1KFZcCp1sRIg
         u7wbwEqi93oKvRV/YG2g1JA+HXH8od4GvYZynGk2R/hc1eD6BNvZxEqI0QfIuYR1vjZZ
         sgEXhZbSo8MH1tcaP0BPg4M8n3cOK9Yeb6yhwjX3SLV1gA9WxlZNt/cZZMPr9kehiCD7
         BgjnBjlzFnLtFm59IUPEXv/mG6rHAX8oPN/jujizS2N2UBAhjsnpGGewl7qqM2F0n/Ph
         4lNfkc6hFsFOQ+Pvb1ULMvIsaVXUPsFOHhs822aVRDmlTi8tWly2DyStV0SJV/7yqpXO
         1fWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743003026; x=1743607826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tp8PX3VrlT3xj5/bJFgA5hrm+xCmQXv7oRpmonMlOI=;
        b=NKaWPbMt2jJkwqyvUflhklAAxApEQVv3+nUaSiMkFuGhRSZ4sbCRXjcpAUgic5lpdk
         B4WQQOBFmw0dBQrjJ7MtIXq4sA5iTQ15XgSLaNIZ91YZiRnIEJrHOuDKoo3qZLghsOBD
         dTit1wRH+tZJBldDU/OEgER7PhxNyKmA8L4syjf/WC7FcohhVoShR3yflvEPwiUDKcDk
         bU5te2FEe54X3mKS/dyfVepsLYaIkz+KEk6szzN+gSK6T5KBN48XAhIDEcx8WUna17sA
         GKHuzSHe+bNbVKqEwl2AcP/jpmEacaMX17+t2aXatWxxXGTyIYHQB6EIexc3GB7o1hTE
         4gnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXss7rr6EuEpuWPe2qXHOmo2eQuJPPA8pMqh6JGhGmf+WeEfkEQZH6QWwwor5VY2BdjqBmnc1hbWIx2@vger.kernel.org
X-Gm-Message-State: AOJu0YzTsIb5TbBCORM/44j6kVvbXswvxiQP54+tlly/g5AiO/VfyaK1
	Qq1RD1mtrowhdGLx5a6VCbBlarurFAYY7uOJCVO5kMBykyDqPiYcBBhiy8YP23Jtuu5f8WWKM8w
	OUkkPnuR7DjrFbDPA7rfHCnRPpqIfAmNqlsd4iA==
X-Gm-Gg: ASbGncsxAvcWTSnLyZcX0ZlIvavzLaLl4B3SUBBzwMFQK08C4ZMtEypzpVobbydGYO0
	PNAM10cNtWtFmn+IPoihMlCNZXGUBwmFiyCsCtKgd8Y8c9nLM2x3/wf7UgNY3LM10EE7H1LYAnL
	kgJs8OtYGf+g/JrO8nOFXXCZ247LI=
X-Google-Smtp-Source: AGHT+IHH8roGtvYn4zIkkHyeZONRNkqexqeYCf0x2L8a8OYlH8Bn8/yS0J4dIX1ClKxWSBASDFTCClZLBfb0+pTFgfY=
X-Received: by 2002:a05:6902:228f:b0:e63:ebc9:656 with SMTP id
 3f1490d57ef6-e66a4fa21e2mr25381574276.35.1743003025980; Wed, 26 Mar 2025
 08:30:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com> <20250326-page-pool-track-dma-v3-1-8e464016e0ac@redhat.com>
In-Reply-To: <20250326-page-pool-track-dma-v3-1-8e464016e0ac@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Mar 2025 17:29:49 +0200
X-Gm-Features: AQ5f1JrJyBnSFqybq6WlsgbDPnbPbzUh4cR4XN8mgb-NDuFNFyPbV6xmXGZAU5M
Message-ID: <CAC_iWjJKPkNGEVOoOCAn1ghmP7UvynG4Fjrxbj8+RFwKMG977w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] page_pool: Move pp_magic check into
 helper functions
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>, 
	Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Toke,

On Wed, 26 Mar 2025 at 10:19, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat=
.com> wrote:
>
> Since we are about to stash some more information into the pp_magic
> field, let's move the magic signature checks into a pair of helper
> functions so it can be changed in one place.
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>  include/net/page_pool/types.h                    | 18 ++++++++++++++++++
>  mm/page_alloc.c                                  |  9 +++------
>  net/core/netmem_priv.h                           |  5 +++++
>  net/core/skbuff.c                                | 16 ++--------------
>  net/core/xdp.c                                   |  4 ++--
>  6 files changed, 32 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/en/xdp.c
> index 6f3094a479e1ec61854bb48a6a0c812167487173..70c6f0b2abb921778c98fbd42=
8594ebd7986a302 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -706,8 +706,8 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq =
*sq,
>                                 xdpi =3D mlx5e_xdpi_fifo_pop(xdpi_fifo);
>                                 page =3D xdpi.page.page;
>
> -                               /* No need to check ((page->pp_magic & ~0=
x3UL) =3D=3D PP_SIGNATURE)
> -                                * as we know this is a page_pool page.
> +                               /* No need to check page_pool_page_is_pp(=
) as we
> +                                * know this is a page_pool page.
>                                  */
>                                 page_pool_recycle_direct(page->pp, page);
>                         } while (++n < num);
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 36eb57d73abc6cfc601e700ca08be20fb8281055..df0d3c1608929605224feb261=
73135ff37951ef8 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -54,6 +54,14 @@ struct pp_alloc_cache {
>         netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>  };
>
> +/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magi=
c is
> + * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit=
 0 for
> + * the head page of compound page and bit 1 for pfmemalloc page.
> + * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid re=
cycling
> + * the pfmemalloc page.
> + */
> +#define PP_MAGIC_MASK ~0x3UL
> +
>  /**
>   * struct page_pool_params - page pool parameters
>   * @fast:      params accessed frequently on hotpath
> @@ -264,6 +272,11 @@ void page_pool_destroy(struct page_pool *pool);
>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(vo=
id *),
>                            const struct xdp_mem_info *mem);
>  void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
> +
> +static inline bool page_pool_page_is_pp(struct page *page)
> +{
> +       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> +}
>  #else
>  static inline void page_pool_destroy(struct page_pool *pool)
>  {
> @@ -278,6 +291,11 @@ static inline void page_pool_use_xdp_mem(struct page=
_pool *pool,
>  static inline void page_pool_put_netmem_bulk(netmem_ref *data, u32 count=
)
>  {
>  }
> +
> +static inline bool page_pool_page_is_pp(struct page *page)
> +{
> +       return false;
> +}
>  #endif
>
>  void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref net=
mem,
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 542d25f77be80304b731411ffd29b276ee13be0c..3535ee76afe946cbb042ecbce=
603bdbedc9233b9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -55,6 +55,7 @@
>  #include <linux/delayacct.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/pgalloc_tag.h>
> +#include <net/page_pool/types.h>
>  #include <asm/div64.h>
>  #include "internal.h"
>  #include "shuffle.h"
> @@ -872,9 +873,7 @@ static inline bool page_expected_state(struct page *p=
age,
>  #ifdef CONFIG_MEMCG
>                         page->memcg_data |
>  #endif
> -#ifdef CONFIG_PAGE_POOL
> -                       ((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE) |
> -#endif
> +                       page_pool_page_is_pp(page) |
>                         (page->flags & check_flags)))
>                 return false;
>
> @@ -901,10 +900,8 @@ static const char *page_bad_reason(struct page *page=
, unsigned long flags)
>         if (unlikely(page->memcg_data))
>                 bad_reason =3D "page still charged to cgroup";
>  #endif
> -#ifdef CONFIG_PAGE_POOL
> -       if (unlikely((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE))
> +       if (unlikely(page_pool_page_is_pp(page)))
>                 bad_reason =3D "page_pool leak";
> -#endif
>         return bad_reason;
>  }
>
> diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
> index 7eadb8393e002fd1cc2cef8a313d2ea7df76f301..f33162fd281c23e109273ba09=
950c5d0a2829bc9 100644
> --- a/net/core/netmem_priv.h
> +++ b/net/core/netmem_priv.h
> @@ -18,6 +18,11 @@ static inline void netmem_clear_pp_magic(netmem_ref ne=
tmem)
>         __netmem_clear_lsb(netmem)->pp_magic =3D 0;
>  }
>
> +static inline bool netmem_is_pp(netmem_ref netmem)
> +{
> +       return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) =3D=3D PP_SI=
GNATURE;
> +}
> +
>  static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *po=
ol)
>  {
>         __netmem_clear_lsb(netmem)->pp =3D pool;
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ab8acb737b93299f503e5c298b87e18edd59d555..a64d777488e403d5fdef83ae4=
2ae9e4924c1a0dc 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -893,11 +893,6 @@ static void skb_clone_fraglist(struct sk_buff *skb)
>                 skb_get(list);
>  }
>
> -static bool is_pp_netmem(netmem_ref netmem)
> -{
> -       return (netmem_get_pp_magic(netmem) & ~0x3UL) =3D=3D PP_SIGNATURE=
;
> -}
> -
>  int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
>                     unsigned int headroom)
>  {
> @@ -995,14 +990,7 @@ bool napi_pp_put_page(netmem_ref netmem)
>  {
>         netmem =3D netmem_compound_head(netmem);
>
> -       /* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
> -        * in order to preserve any existing bits, such as bit 0 for the
> -        * head page of compound page and bit 1 for pfmemalloc page, so
> -        * mask those bits for freeing side when doing below checking,
> -        * and page_is_pfmemalloc() is checked in __page_pool_put_page()
> -        * to avoid recycling the pfmemalloc page.
> -        */
> -       if (unlikely(!is_pp_netmem(netmem)))
> +       if (unlikely(!netmem_is_pp(netmem)))
>                 return false;
>
>         page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
> @@ -1042,7 +1030,7 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
>
>         for (i =3D 0; i < shinfo->nr_frags; i++) {
>                 head_netmem =3D netmem_compound_head(shinfo->frags[i].net=
mem);
> -               if (likely(is_pp_netmem(head_netmem)))
> +               if (likely(netmem_is_pp(head_netmem)))
>                         page_pool_ref_netmem(head_netmem);
>                 else
>                         page_ref_inc(netmem_to_page(head_netmem));
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index f86eedad586a77eb63a96a85aa6d068d3e94f077..0ba73943c6eed873b3d1c681b=
3b9a802b590f2d9 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -437,8 +437,8 @@ void __xdp_return(netmem_ref netmem, enum xdp_mem_typ=
e mem_type,
>                 netmem =3D netmem_compound_head(netmem);
>                 if (napi_direct && xdp_return_frame_no_direct())
>                         napi_direct =3D false;
> -               /* No need to check ((page->pp_magic & ~0x3UL) =3D=3D PP_=
SIGNATURE)
> -                * as mem->type knows this a page_pool page
> +               /* No need to check netmem_is_pp() as mem->type knows thi=
s a
> +                * page_pool page
>                  */
>                 page_pool_put_full_netmem(netmem_get_pp(netmem), netmem,
>                                           napi_direct);
>
> --
> 2.48.1
>

