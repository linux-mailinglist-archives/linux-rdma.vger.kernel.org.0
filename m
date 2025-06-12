Return-Path: <linux-rdma+bounces-11231-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AE9AD6719
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 07:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C497D1BC0B24
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 05:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BED1DA60D;
	Thu, 12 Jun 2025 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gp9w4x3N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74391DB124
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 05:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705110; cv=none; b=UZz+dxyOOM1Ll84UKTvQgP4DTYcIWwhu1dd0M0cYxk8fZOhH93/7WuqvVX9dBbO2t1PPfEe1US+J5naonxa7WMr8qjoRMOqE/f8fB/bxVNmcW4Va/7KNYfB7ux71uEiFjh0aRRN9+xe7IZSc6azLIE7MBWFFHHdkgQYdIDRVS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705110; c=relaxed/simple;
	bh=PqkBG+4nUJ1VxMC+pPmDp9KgVxS+nrzT9SNkoIxqku8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkQw6KVLn2QVGyfb2egm9P2YwbdEC5aEc6/yUo/EkowFlemD7rNbCe/72nbFa3mCd5iWieYnrUBW42upEHsUswjz19ZQzmMHi9QY95TPtB00pNTI2frEKFaiSALR4DoSZSn4IM9xhidru+bPOz3Uveset/RfC1VUpSeqBL9z+Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gp9w4x3N; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235ca5eba8cso98025ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 22:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749705108; x=1750309908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdEv5qKXliKu38n+kbYUXx4rRb8cp55dcu4kDcmFYcU=;
        b=gp9w4x3Nar79sAttawd1OlfTAWgAaBwEKmoZ0nzlFVl53FcKlSTRVUTuJy5Su+YTtJ
         mPcqxw90UORIdL0AqHkIeeDiRZ6HwOcSrOmrx/n/cbSXGFBOF0mJAjejoHC++OElLymv
         Xgz3EkvCmsYmdqwdwdSA93eIuK+xW7iOnluw8YXo2tjVf46em2Bd1YXYUXNe+enPl92K
         eEvis0W+zx0gU+TCohSbaR8ZhYbZsWqT4lAxZh48zu4MWDJ8yutfhnd+AliU5Q4CqWxr
         4X773LjOHGVIhRfTOMm1EVeZFCeI3McAs49W0ZKzdFkbj32sFyhx06oa3LQgPYJ0T4z2
         AyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749705108; x=1750309908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdEv5qKXliKu38n+kbYUXx4rRb8cp55dcu4kDcmFYcU=;
        b=a6KjMd58YqvfoJ5stb54SbIQzNLI0gKLK/7EJFuT4qKCKXC3qIX+B8yhHZV8BjkwUO
         17IST0vnX0ZuRReAMF4irYHFOViy73j5t3KM6ymN7g5D5rFZ6UNauSoSr06uc5eQdqh/
         +QMRUvReZFU4jsZiFbyVfdOazQYxiOCyDdrwiCJuAgA2GCdoX7prJy45VyK/GBIz1h4r
         oXJ8oOJBuL4eaCYY/byRcpEuZDMKkueuoaFS1TiTtZCj9lGEW1or4MO9KNly6U9uJ6qd
         BS1BUbRtGREGzfAjUyRqRZg9YvqvniXaA35L+Oofnd6/cNh2lsqv4YG3uVD+7QX94qPY
         /+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCX8RD/OlbyqTQPTcWoUKEMofm7eu5WKE5UAQXrleSNbFFgpC1yCLEcEjwr1ps3rtvlZIzF5AKI51WTr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi3461d2vXUtRT0sVAs3kCyxANTdZ+lAkog9TGVMF8HJ6H6sBZ
	6XOC9eVCeCzVqmighya+jQeLzooSK0hHM7JRbANSzOpMFb16UfZ54xUmiDSxIgCMSAswtVukfUZ
	tdwxZibN/ejOIzQyMb/UwuBlwQMbbpbrVVcwWXJNu
X-Gm-Gg: ASbGncsSHlt4dxxSnn5TWdku2UZCXA+yuoT3wlCdVcch1WzF1uwbJpyp178yX71Gm9t
	rYDvmNWkBhfrVMc614UY35Op99L32CpFek/b56vgxI88zB/xlHxwzeyv/LHz1xETBzpDMvBfFh2
	/3XhvQ/dfA5BEuXzsJxFrCipZm4aoYUr7kgUFVkw/DJJVS
X-Google-Smtp-Source: AGHT+IFXutW3ZqifkpQX73zVMcoi2GswkeL0OzDcKImyoEu/KLr1VYXb/adEhwkaYVitvijNlGA9OiPBEfkFRQu5shs=
X-Received: by 2002:a17:903:948:b0:234:c2e7:a0e7 with SMTP id
 d9443c01a7336-2364dd8118emr1922745ad.4.1749705107723; Wed, 11 Jun 2025
 22:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610150950.1094376-1-mbloch@nvidia.com> <20250610150950.1094376-8-mbloch@nvidia.com>
In-Reply-To: <20250610150950.1094376-8-mbloch@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Jun 2025 22:11:32 -0700
X-Gm-Features: AX0GCFtH6sPx3EXqTqBrKzXvc9h7jOqyKJNqVFjQhsca8EETnSeN7Ssm9aCXjWg
Message-ID: <CAHS8izNkYg6GoMNZOaridxWLYpE3WU0yWpNV2-g4oLd7q9TfuQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 07/11] net/mlx5e: Convert over to netmem
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, gal@nvidia.com, 
	leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 8:19=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrot=
e:
>
> From: Saeed Mahameed <saeedm@nvidia.com>
>
> mlx5e_page_frag holds the physical page itself, to naturally support
> zc page pools, remove physical page reference from mlx5 and replace it
> with netmem_ref, to avoid internal handling in mlx5 for net_iov backed
> pages.
>
> SHAMPO can issue packets that are not split into header and data. These
> packets will be dropped if the data part resides in a net_iov as the
> driver can't read into this area.
>
> No performance degradation observed.
>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +-
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 103 ++++++++++--------
>  2 files changed, 61 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/e=
thernet/mellanox/mlx5/core/en.h
> index c329de1d4f0a..65a73913b9a2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -553,7 +553,7 @@ struct mlx5e_icosq {
>  } ____cacheline_aligned_in_smp;
>
>  struct mlx5e_frag_page {
> -       struct page *page;
> +       netmem_ref netmem;
>         u16 frags;
>  };
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_rx.c
> index e34ef53ebd0e..75e753adedef 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -273,33 +273,33 @@ static inline u32 mlx5e_decompress_cqes_start(struc=
t mlx5e_rq *rq,
>
>  #define MLX5E_PAGECNT_BIAS_MAX (PAGE_SIZE / 64)
>
> -static int mlx5e_page_alloc_fragmented(struct page_pool *pool,
> +static int mlx5e_page_alloc_fragmented(struct page_pool *pp,
>                                        struct mlx5e_frag_page *frag_page)
>  {
> -       struct page *page;
> +       netmem_ref netmem =3D page_pool_alloc_netmems(pp,
> +                                                   GFP_ATOMIC | __GFP_NO=
WARN);
>

I would prefer if you add page_pool_dev_alloc_netmems helper for all
drivers to use rather than specify the GFP params inline here.

> -       page =3D page_pool_dev_alloc_pages(pool);
> -       if (unlikely(!page))
> +       if (unlikely(!netmem))
>                 return -ENOMEM;
>
> -       page_pool_fragment_page(page, MLX5E_PAGECNT_BIAS_MAX);
> +       page_pool_fragment_netmem(netmem, MLX5E_PAGECNT_BIAS_MAX);
>
>         *frag_page =3D (struct mlx5e_frag_page) {
> -               .page   =3D page,
> +               .netmem =3D netmem,
>                 .frags  =3D 0,
>         };
>
>         return 0;
>  }
>
> -static void mlx5e_page_release_fragmented(struct page_pool *pool,
> +static void mlx5e_page_release_fragmented(struct page_pool *pp,
>                                           struct mlx5e_frag_page *frag_pa=
ge)
>  {
>         u16 drain_count =3D MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
> -       struct page *page =3D frag_page->page;
> +       netmem_ref netmem =3D frag_page->netmem;
>
> -       if (page_pool_unref_page(page, drain_count) =3D=3D 0)
> -               page_pool_put_unrefed_page(pool, page, -1, true);
> +       if (page_pool_unref_netmem(netmem, drain_count) =3D=3D 0)
> +               page_pool_put_unrefed_netmem(pp, netmem, -1, true);
>  }
>
>  static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
> @@ -359,7 +359,7 @@ static int mlx5e_alloc_rx_wqe(struct mlx5e_rq *rq, st=
ruct mlx5e_rx_wqe_cyc *wqe,
>                 frag->flags &=3D ~BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
>
>                 headroom =3D i =3D=3D 0 ? rq->buff.headroom : 0;
> -               addr =3D page_pool_get_dma_addr(frag->frag_page->page);
> +               addr =3D page_pool_get_dma_addr_netmem(frag->frag_page->n=
etmem);
>                 wqe->data[i].addr =3D cpu_to_be64(addr + frag->offset + h=
eadroom);
>         }
>
> @@ -500,9 +500,10 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, =
struct skb_shared_info *sinf
>                                struct xdp_buff *xdp, struct mlx5e_frag_pa=
ge *frag_page,
>                                u32 frag_offset, u32 len)
>  {
> +       netmem_ref netmem =3D frag_page->netmem;
>         skb_frag_t *frag;
>
> -       dma_addr_t addr =3D page_pool_get_dma_addr(frag_page->page);
> +       dma_addr_t addr =3D page_pool_get_dma_addr_netmem(netmem);
>
>         dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len, rq->bu=
ff.map_dir);
>         if (!xdp_buff_has_frags(xdp)) {
> @@ -515,9 +516,9 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, s=
truct skb_shared_info *sinf
>         }
>
>         frag =3D &sinfo->frags[sinfo->nr_frags++];
> -       skb_frag_fill_page_desc(frag, frag_page->page, frag_offset, len);
> +       skb_frag_fill_netmem_desc(frag, netmem, frag_offset, len);
>
> -       if (page_is_pfmemalloc(frag_page->page))
> +       if (!netmem_is_net_iov(netmem) && netmem_is_pfmemalloc(netmem))

Unnecessary netmem_is_net_iov check.

>                 xdp_buff_set_frag_pfmemalloc(xdp);
>         sinfo->xdp_frags_size +=3D len;
>  }
> @@ -528,27 +529,29 @@ mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_b=
uff *skb,
>                    u32 frag_offset, u32 len,
>                    unsigned int truesize)
>  {
> -       dma_addr_t addr =3D page_pool_get_dma_addr(frag_page->page);
> +       dma_addr_t addr =3D page_pool_get_dma_addr_netmem(frag_page->netm=
em);
>         u8 next_frag =3D skb_shinfo(skb)->nr_frags;
> +       netmem_ref netmem =3D frag_page->netmem;
>
>         dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len,
>                                 rq->buff.map_dir);
>
> -       if (skb_can_coalesce(skb, next_frag, frag_page->page, frag_offset=
)) {
> +       if (skb_can_coalesce_netmem(skb, next_frag, netmem, frag_offset))=
 {
>                 skb_coalesce_rx_frag(skb, next_frag - 1, len, truesize);
> -       } else {
> -               frag_page->frags++;
> -               skb_add_rx_frag(skb, next_frag, frag_page->page,
> -                               frag_offset, len, truesize);
> +               return;
>         }
> +
> +       frag_page->frags++;
> +       skb_add_rx_frag_netmem(skb, next_frag, netmem,
> +                              frag_offset, len, truesize);
>  }
>
>  static inline void
>  mlx5e_copy_skb_header(struct mlx5e_rq *rq, struct sk_buff *skb,
> -                     struct page *page, dma_addr_t addr,
> +                     netmem_ref netmem, dma_addr_t addr,
>                       int offset_from, int dma_offset, u32 headlen)
>  {
> -       const void *from =3D page_address(page) + offset_from;
> +       const void *from =3D netmem_address(netmem) + offset_from;
>         /* Aligning len to sizeof(long) optimizes memcpy performance */
>         unsigned int len =3D ALIGN(headlen, sizeof(long));
>
> @@ -685,7 +688,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq =
*rq,
>                 if (unlikely(err))
>                         goto err_unmap;
>
> -               addr =3D page_pool_get_dma_addr(frag_page->page);
> +               addr =3D page_pool_get_dma_addr_netmem(frag_page->netmem)=
;
>
>                 for (int j =3D 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j+=
+) {
>                         header_offset =3D mlx5e_shampo_hd_offset(index++)=
;
> @@ -796,7 +799,8 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, =
u16 ix)
>                 err =3D mlx5e_page_alloc_fragmented(rq->page_pool, frag_p=
age);
>                 if (unlikely(err))
>                         goto err_unmap;
> -               addr =3D page_pool_get_dma_addr(frag_page->page);
> +
> +               addr =3D page_pool_get_dma_addr_netmem(frag_page->netmem)=
;
>                 umr_wqe->inline_mtts[i] =3D (struct mlx5_mtt) {
>                         .ptag =3D cpu_to_be64(addr | MLX5_EN_WR),
>                 };
> @@ -1216,7 +1220,7 @@ static void *mlx5e_shampo_get_packet_hd(struct mlx5=
e_rq *rq, u16 header_index)
>         struct mlx5e_frag_page *frag_page =3D mlx5e_shampo_hd_to_frag_pag=
e(rq, header_index);
>         u16 head_offset =3D mlx5e_shampo_hd_offset(header_index) + rq->bu=
ff.headroom;
>
> -       return page_address(frag_page->page) + head_offset;
> +       return netmem_address(frag_page->netmem) + head_offset;
>  }
>
>  static void mlx5e_shampo_update_ipv4_udp_hdr(struct mlx5e_rq *rq, struct=
 iphdr *ipv4)
> @@ -1677,11 +1681,11 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, st=
ruct mlx5e_wqe_frag_info *wi,
>         dma_addr_t addr;
>         u32 frag_size;
>
> -       va             =3D page_address(frag_page->page) + wi->offset;
> +       va             =3D netmem_address(frag_page->netmem) + wi->offset=
;
>         data           =3D va + rx_headroom;
>         frag_size      =3D MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
>
> -       addr =3D page_pool_get_dma_addr(frag_page->page);
> +       addr =3D page_pool_get_dma_addr_netmem(frag_page->netmem);
>         dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
>                                       frag_size, rq->buff.map_dir);
>         net_prefetch(data);
> @@ -1731,10 +1735,10 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq,=
 struct mlx5e_wqe_frag_info *wi
>
>         frag_page =3D wi->frag_page;
>
> -       va =3D page_address(frag_page->page) + wi->offset;
> +       va =3D netmem_address(frag_page->netmem) + wi->offset;
>         frag_consumed_bytes =3D min_t(u32, frag_info->frag_size, cqe_bcnt=
);
>
> -       addr =3D page_pool_get_dma_addr(frag_page->page);
> +       addr =3D page_pool_get_dma_addr_netmem(frag_page->netmem);
>         dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
>                                       rq->buff.frame0_sz, rq->buff.map_di=
r);
>         net_prefetchw(va); /* xdp_frame data area */
> @@ -2007,13 +2011,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_mpw_info *w
>
>         if (prog) {
>                 /* area for bpf_xdp_[store|load]_bytes */
> -               net_prefetchw(page_address(frag_page->page) + frag_offset=
);
> +               net_prefetchw(netmem_address(frag_page->netmem) + frag_of=
fset);
>                 if (unlikely(mlx5e_page_alloc_fragmented(rq->page_pool,
>                                                          &wi->linear_page=
))) {
>                         rq->stats->buff_alloc_err++;
>                         return NULL;
>                 }
> -               va =3D page_address(wi->linear_page.page);
> +
> +               va =3D netmem_address(wi->linear_page.netmem);
>                 net_prefetchw(va); /* xdp_frame data area */
>                 linear_hr =3D XDP_PACKET_HEADROOM;
>                 linear_data_len =3D 0;
> @@ -2124,8 +2129,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq =
*rq, struct mlx5e_mpw_info *w
>                         while (++pagep < frag_page);
>                 }
>                 /* copy header */
> -               addr =3D page_pool_get_dma_addr(head_page->page);
> -               mlx5e_copy_skb_header(rq, skb, head_page->page, addr,
> +               addr =3D page_pool_get_dma_addr_netmem(head_page->netmem)=
;
> +               mlx5e_copy_skb_header(rq, skb, head_page->netmem, addr,
>                                       head_offset, head_offset, headlen);
>                 /* skb linear part was allocated with headlen and aligned=
 to long */
>                 skb->tail +=3D headlen;
> @@ -2155,11 +2160,11 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *=
rq, struct mlx5e_mpw_info *wi,
>                 return NULL;
>         }
>
> -       va             =3D page_address(frag_page->page) + head_offset;
> +       va             =3D netmem_address(frag_page->netmem) + head_offse=
t;
>         data           =3D va + rx_headroom;
>         frag_size      =3D MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
>
> -       addr =3D page_pool_get_dma_addr(frag_page->page);
> +       addr =3D page_pool_get_dma_addr_netmem(frag_page->netmem);
>         dma_sync_single_range_for_cpu(rq->pdev, addr, head_offset,
>                                       frag_size, rq->buff.map_dir);
>         net_prefetch(data);
> @@ -2198,16 +2203,19 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, st=
ruct mlx5e_mpw_info *wi,
>                           struct mlx5_cqe64 *cqe, u16 header_index)
>  {
>         struct mlx5e_frag_page *frag_page =3D mlx5e_shampo_hd_to_frag_pag=
e(rq, header_index);
> -       dma_addr_t page_dma_addr =3D page_pool_get_dma_addr(frag_page->pa=
ge);
>         u16 head_offset =3D mlx5e_shampo_hd_offset(header_index);
> -       dma_addr_t dma_addr =3D page_dma_addr + head_offset;
>         u16 head_size =3D cqe->shampo.header_size;
>         u16 rx_headroom =3D rq->buff.headroom;
>         struct sk_buff *skb =3D NULL;
> +       dma_addr_t page_dma_addr;
> +       dma_addr_t dma_addr;
>         void *hdr, *data;
>         u32 frag_size;
>
> -       hdr             =3D page_address(frag_page->page) + head_offset;
> +       page_dma_addr =3D page_pool_get_dma_addr_netmem(frag_page->netmem=
);
> +       dma_addr =3D page_dma_addr + head_offset;
> +
> +       hdr             =3D netmem_address(frag_page->netmem) + head_offs=
et;
>         data            =3D hdr + rx_headroom;
>         frag_size       =3D MLX5_SKB_FRAG_SZ(rx_headroom + head_size);
>
> @@ -2232,7 +2240,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, stru=
ct mlx5e_mpw_info *wi,
>                 }
>
>                 net_prefetchw(skb->data);
> -               mlx5e_copy_skb_header(rq, skb, frag_page->page, dma_addr,
> +               mlx5e_copy_skb_header(rq, skb, frag_page->netmem, dma_add=
r,
>                                       head_offset + rx_headroom,
>                                       rx_headroom, head_size);
>                 /* skb linear part was allocated with headlen and aligned=
 to long */
> @@ -2326,11 +2334,20 @@ static void (struct mlx5e_rq *rq, struct mlx5_cq
>         }
>
>         if (!*skb) {
> -               if (likely(head_size))
> +               if (likely(head_size)) {
>                         *skb =3D mlx5e_skb_from_cqe_shampo(rq, wi, cqe, h=
eader_index);
> -               else
> -                       *skb =3D mlx5e_skb_from_cqe_mpwrq_nonlinear(rq, w=
i, cqe, cqe_bcnt,
> -                                                                 data_of=
fset, page_idx);
> +               } else {
> +                       struct mlx5e_frag_page *frag_page;
> +
> +                       frag_page =3D &wi->alloc_units.frag_pages[page_id=
x];
> +                       if (unlikely(netmem_is_net_iov(frag_page->netmem)=
))
> +                               goto free_hd_entry;

If I understand correctly, when the code reaches here, head_size =3D=3D 0,
which means the packet was not split. And if netmem_is_net_iov =3D=3D
true, then the entire packet (including the header) has landed in
unreadable memory so now you are going to drop the packet, right?

If my understanding is correct, this is all subtle enough that it
maybe warrants a comment. Also you may want driver stats to see how
often this happens (seems like a headersplit failure causing packet
drops).

Mostly nits, so,

Reviewed-by: Mina Almasry <almasrymina@google.com>

--
Thanks,
Mina

