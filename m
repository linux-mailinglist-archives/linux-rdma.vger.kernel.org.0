Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BE777E056
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 13:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244499AbjHPL1Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 07:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244577AbjHPL1P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 07:27:15 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177C3272C
        for <linux-rdma@vger.kernel.org>; Wed, 16 Aug 2023 04:26:57 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bb8a12e819so25845451fa.1
        for <linux-rdma@vger.kernel.org>; Wed, 16 Aug 2023 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692185215; x=1692790015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jdqXLx5XWStq+9cLlC6wOm/1TMw9og16TtkojIWGoi8=;
        b=Ma15+fY6wVBfh31fR4jEu3Pq0sTvbG9FYaTIpwkA8e/IqW0cQGppM4IF5FNWJeJqiE
         6b4+VZ3yAZko2drR/4JNhnrH0XGk0ypitLWsCFOCI2+q/sll4N0GwjINrCh+zQPoiPZe
         Gu3pucBeptjfeE6AnquvD6K+DRbZF79KBGytRtmL9kIvn+G8wsDFZJ51DgacJqOE8OWU
         /xdkab94z+DLwaQM15rdfq84C/Ed/swPprITEwrsomNtPFnzoyoxNnWh9wFrjs7bL3qW
         cBZMWY2BFsawzi4iJop8u7L3Tmkw1f5p8zVzHSQJiSIr8wHKfXj3DQexQ8HkALalnxX/
         Ne4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692185215; x=1692790015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdqXLx5XWStq+9cLlC6wOm/1TMw9og16TtkojIWGoi8=;
        b=JZX4xj2y1QLdS+YwaZsjSQxaZ/oSk9tWLuZHIUebz75cd+N0n0JY7PqnpoLrha9BBb
         8dyUn1JsYf+0i5m9fcLF+B1nS2je4mIDsHPW9GiwjXLWbe14tUKXT5TTClI60a+2gIBb
         q2c1rEyuCLDX3UorEna+13kcECp5G2yS3vJ7/4UkU+sdXwim09Zsnk8toWNQP/Qs99Zg
         YNoyUnFfsOCpxX3n34Cu3BEmZmUbn8APqSRwtt0tmBW8EH1oeyINU0L7Y4hnRwzcIFOF
         XakrBqtkhXuXbtOvcBVG83YWCM3AP4t4wAzpWJlFOHixV9rIjbkAzY+MuFkveHI5iUj7
         pXRw==
X-Gm-Message-State: AOJu0Ywz+rCa8OLuL9/KXsYa41HF3YjBA38/t4bW2SJL15QkDAkjdka6
        RqoAfmbp3DoBkgh+nalYc7RcLvdpLdrW2rElWQZg7g==
X-Google-Smtp-Source: AGHT+IHNQn6zFil4Uau1m3wCi9bFrYxUNd2VolPBahHJJqNLtSnnus5aLyZXJZqfT82LDYrsZmjtX0bNAmoP0eX2rck=
X-Received: by 2002:a2e:958a:0:b0:2b9:4418:b46e with SMTP id
 w10-20020a2e958a000000b002b94418b46emr1469690ljh.21.1692185215304; Wed, 16
 Aug 2023 04:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230814125643.59334-1-linyunsheng@huawei.com> <20230814125643.59334-2-linyunsheng@huawei.com>
In-Reply-To: <20230814125643.59334-2-linyunsheng@huawei.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 16 Aug 2023 14:26:19 +0300
Message-ID: <CAC_iWjKMLoUu4bctrWtK46mpyhQ7LoKe4Nm2t8jZVMM0L9O2xA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Yunsheng

On Mon, 14 Aug 2023 at 15:59, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> Currently page_pool_alloc_frag() is not supported in 32-bit
> arch with 64-bit DMA because of the overlap issue between
> pp_frag_count and dma_addr_upper in 'struct page' for those
> arches, which seems to be quite common, see [1], which means
> driver may need to handle it when using frag API.

That wasn't so common. IIRC it was a single TI platform that was breaking?

>
> In order to simplify the driver's work when using frag API
> this patch allows page_pool_alloc_frag() to call
> page_pool_alloc_pages() to return pages for those arches.

Do we have any use cases of people needing this?  Those architectures
should be long dead and although we have to support them in the
kernel,  I don't personally see the advantage of adjusting the API to
do that.  Right now we have a very clear separation between allocating
pages or fragments.   Why should we hide a page allocation under a
frag allocation?  A driver writer can simply allocate pages for those
boards.  Am I the only one not seeing a clean win here?

Thanks
/Ilias

>
> Add a PP_FLAG_PAGE_SPLIT_IN_DRIVER flag in order to fail the
> page_pool creation for 32-bit arch with 64-bit DMA when driver
> tries to do the page splitting itself.
>
> Note that it may aggravate truesize underestimate problem for
> skb as there is no page splitting for those pages, if driver
> need a accurate truesize, it may calculate that according to
> frag size, page order and PAGE_POOL_DMA_USE_PP_FRAG_COUNT
> being true or not. And we may provide a helper for that if it
> turns out to be helpful.
>
> 1. https://lore.kernel.org/all/20211117075652.58299-1-linyunsheng@huawei.com/
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Liang Chen <liangchen.linux@gmail.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |  3 +-
>  include/net/page_pool/helpers.h               | 38 +++++++++++++++--
>  include/net/page_pool/types.h                 | 42 ++++++++++++-------
>  net/core/page_pool.c                          | 15 +++----
>  4 files changed, 68 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index bc9d5a5bea01..ec9c5a8cbda6 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -834,7 +834,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
>                 struct page_pool_params pp_params = { 0 };
>
>                 pp_params.order     = 0;
> -               pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | PP_FLAG_PAGE_FRAG;
> +               pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
> +                                       PP_FLAG_PAGE_SPLIT_IN_DRIVER;
>                 pp_params.pool_size = pool_size;
>                 pp_params.nid       = node;
>                 pp_params.dev       = rq->pdev;
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 94231533a369..cb18de55f239 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -29,8 +29,12 @@
>  #ifndef _NET_PAGE_POOL_HELPERS_H
>  #define _NET_PAGE_POOL_HELPERS_H
>
> +#include <linux/dma-mapping.h>
>  #include <net/page_pool/types.h>
>
> +#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT        \
> +               (sizeof(dma_addr_t) > sizeof(unsigned long))
> +
>  #ifdef CONFIG_PAGE_POOL_STATS
>  int page_pool_ethtool_stats_get_count(void);
>  u8 *page_pool_ethtool_stats_get_strings(u8 *data);
> @@ -73,6 +77,29 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
>         return page_pool_alloc_pages(pool, gfp);
>  }
>
> +static inline struct page *page_pool_alloc_frag(struct page_pool *pool,
> +                                               unsigned int *offset,
> +                                               unsigned int size, gfp_t gfp)
> +{
> +       unsigned int max_size = PAGE_SIZE << pool->p.order;
> +
> +       size = ALIGN(size, dma_get_cache_alignment());
> +
> +       if (WARN_ON(size > max_size))
> +               return NULL;
> +
> +       /* Don't allow page splitting and allocate one big frag
> +        * for 32-bit arch with 64-bit DMA, corresponding to
> +        * the checking in page_pool_is_last_frag().
> +        */
> +       if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
> +               *offset = 0;
> +               return page_pool_alloc_pages(pool, gfp);
> +       }
> +
> +       return __page_pool_alloc_frag(pool, offset, size, gfp);
> +}
> +
>  static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
>                                                     unsigned int *offset,
>                                                     unsigned int size)
> @@ -134,8 +161,14 @@ static inline long page_pool_defrag_page(struct page *page, long nr)
>  static inline bool page_pool_is_last_frag(struct page_pool *pool,
>                                           struct page *page)
>  {
> -       /* If fragments aren't enabled or count is 0 we were the last user */
> +       /* We assume we are the last frag user that is still holding
> +        * on to the page if:
> +        * 1. Fragments aren't enabled.
> +        * 2. We are running in 32-bit arch with 64-bit DMA.
> +        * 3. page_pool_defrag_page() indicate we are the last user.
> +        */
>         return !(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
> +              PAGE_POOL_DMA_USE_PP_FRAG_COUNT ||
>                (page_pool_defrag_page(page, 1) == 0);
>  }
>
> @@ -197,9 +230,6 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
>         page_pool_put_full_page(pool, page, true);
>  }
>
> -#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT        \
> -               (sizeof(dma_addr_t) > sizeof(unsigned long))
> -
>  /**
>   * page_pool_get_dma_addr() - Retrieve the stored DMA address.
>   * @page:      page allocated from a page pool
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 887e7946a597..079337c42aa6 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -6,21 +6,29 @@
>  #include <linux/dma-direction.h>
>  #include <linux/ptr_ring.h>
>
> -#define PP_FLAG_DMA_MAP                BIT(0) /* Should page_pool do the DMA
> -                                       * map/unmap
> -                                       */
> -#define PP_FLAG_DMA_SYNC_DEV   BIT(1) /* If set all pages that the driver gets
> -                                       * from page_pool will be
> -                                       * DMA-synced-for-device according to
> -                                       * the length provided by the device
> -                                       * driver.
> -                                       * Please note DMA-sync-for-CPU is still
> -                                       * device driver responsibility
> -                                       */
> -#define PP_FLAG_PAGE_FRAG      BIT(2) /* for page frag feature */
> +/* Should page_pool do the DMA map/unmap */
> +#define PP_FLAG_DMA_MAP                        BIT(0)
> +
> +/* If set all pages that the driver gets from page_pool will be
> + * DMA-synced-for-device according to the length provided by the device driver.
> + * Please note DMA-sync-for-CPU is still device driver responsibility
> + */
> +#define PP_FLAG_DMA_SYNC_DEV           BIT(1)
> +
> +/* for page frag feature */
> +#define PP_FLAG_PAGE_FRAG              BIT(2)
> +
> +/* If set driver will do the page splitting itself. This is used to fail the
> + * page_pool creation because there is overlap issue between pp_frag_count and
> + * dma_addr_upper in 'struct page' for some arches with
> + * PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true.
> + */
> +#define PP_FLAG_PAGE_SPLIT_IN_DRIVER   BIT(3)
> +
>  #define PP_FLAG_ALL            (PP_FLAG_DMA_MAP |\
>                                  PP_FLAG_DMA_SYNC_DEV |\
> -                                PP_FLAG_PAGE_FRAG)
> +                                PP_FLAG_PAGE_FRAG |\
> +                                PP_FLAG_PAGE_SPLIT_IN_DRIVER)
>
>  /*
>   * Fast allocation side cache array/stack
> @@ -45,7 +53,8 @@ struct pp_alloc_cache {
>
>  /**
>   * struct page_pool_params - page pool parameters
> - * @flags:     PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_PAGE_FRAG
> + * @flags:     PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_PAGE_FRAG,
> + *             PP_FLAG_PAGE_SPLIT_IN_DRIVER
>   * @order:     2^order pages on allocation
>   * @pool_size: size of the ptr_ring
>   * @nid:       NUMA node id to allocate from pages from
> @@ -183,8 +192,9 @@ struct page_pool {
>  };
>
>  struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
> -struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
> -                                 unsigned int size, gfp_t gfp);
> +struct page *__page_pool_alloc_frag(struct page_pool *pool,
> +                                   unsigned int *offset, unsigned int size,
> +                                   gfp_t gfp);
>  struct page_pool *page_pool_create(const struct page_pool_params *params);
>
>  struct xdp_mem_info;
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 77cb75e63aca..d62c11aaea9a 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -14,7 +14,6 @@
>  #include <net/xdp.h>
>
>  #include <linux/dma-direction.h>
> -#include <linux/dma-mapping.h>
>  #include <linux/page-flags.h>
>  #include <linux/mm.h> /* for put_page() */
>  #include <linux/poison.h>
> @@ -212,7 +211,7 @@ static int page_pool_init(struct page_pool *pool,
>         }
>
>         if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
> -           pool->p.flags & PP_FLAG_PAGE_FRAG)
> +           pool->p.flags & PP_FLAG_PAGE_SPLIT_IN_DRIVER)
>                 return -EINVAL;
>
>  #ifdef CONFIG_PAGE_POOL_STATS
> @@ -737,18 +736,16 @@ static void page_pool_free_frag(struct page_pool *pool)
>         page_pool_return_page(pool, page);
>  }
>
> -struct page *page_pool_alloc_frag(struct page_pool *pool,
> -                                 unsigned int *offset,
> -                                 unsigned int size, gfp_t gfp)
> +struct page *__page_pool_alloc_frag(struct page_pool *pool,
> +                                   unsigned int *offset,
> +                                   unsigned int size, gfp_t gfp)
>  {
>         unsigned int max_size = PAGE_SIZE << pool->p.order;
>         struct page *page = pool->frag_page;
>
> -       if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
> -                   size > max_size))
> +       if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG))
>                 return NULL;
>
> -       size = ALIGN(size, dma_get_cache_alignment());
>         *offset = pool->frag_offset;
>
>         if (page && *offset + size > max_size) {
> @@ -781,7 +778,7 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
>         alloc_stat_inc(pool, fast);
>         return page;
>  }
> -EXPORT_SYMBOL(page_pool_alloc_frag);
> +EXPORT_SYMBOL(__page_pool_alloc_frag);
>
>  static void page_pool_empty_ring(struct page_pool *pool)
>  {
> --
> 2.33.0
>
