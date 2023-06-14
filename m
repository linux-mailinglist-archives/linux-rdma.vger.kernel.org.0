Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2C172F35F
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 06:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjFNEJM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jun 2023 00:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjFNEJL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jun 2023 00:09:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4E411C;
        Tue, 13 Jun 2023 21:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 951066148B;
        Wed, 14 Jun 2023 04:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5949EC433C0;
        Wed, 14 Jun 2023 04:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686715748;
        bh=yG/U6Ks90Qon8HXe90awol5NmPipuQ3/JKA84Zfu4H0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JLbww1UgJFhNhtyf61pVhxIVSrQeRbUIf9/7kpp52qvXgx32Pdt6fIw+r50fQaBpk
         qKct6FT70tTLinUmhBUHHrBZ3oGdGwTH6ogG3GdOfLgIJTH6VLgNgMaWxtWNsaTAU+
         RSItd1IHG+1vZnfzyw5qhFZ0/CbRgI8Ilkg9etJK6uhnaEImSsiA/v9JD7WqC8gIGB
         uZ71u5AnOIVBVrKCIO4rQjIMF2qyNULT6THlLLrwfLURMwQjKWKI4IhVBoOZM/EgzE
         oCa7EsW2oVk9cYHIEKLItONBFMu2fO6Q5u+tHQ1D/IYDAM0lGLgMA5NoznP3tNVYQQ
         ZyKNUE64NIp9Q==
Date:   Tue, 13 Jun 2023 21:09:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/5] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
Message-ID: <20230613210906.42ea393e@kernel.org>
In-Reply-To: <20230612130256.4572-2-linyunsheng@huawei.com>
References: <20230612130256.4572-1-linyunsheng@huawei.com>
        <20230612130256.4572-2-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 12 Jun 2023 21:02:52 +0800 Yunsheng Lin wrote:
> Currently page_pool_alloc_frag() is not supported in 32-bit
> arch with 64-bit DMA, which seems to be quite common, see
> [1], which means driver may need to handle it when using
> page_pool_alloc_frag() API.
> 
> In order to simplify the driver's work for supporting page
> frag, this patch allows page_pool_alloc_frag() to call
> page_pool_alloc_pages() to return a big page frag without

it returns an entire (potentially compound) page, not a frag.
AFAICT

> page splitting because of overlap issue between pp_frag_count
> and dma_addr_upper in 'struct page' for those arches.

These two lines seem to belong in the first paragraph,

> As page_pool_create() with PP_FLAG_PAGE_FRAG is supported in

"is" -> "will now be"

> 32-bit arch with 64-bit DMA now, mlx5 calls page_pool_create()
> with PP_FLAG_PAGE_FRAG and manipulate the page->pp_frag_count
> directly using the page_pool_defrag_page(), so add a checking
> for it to aoivd writing to page->pp_frag_count that may not
> exist in some arch.

This paragraph needs some proof reading :(

> Note that it may aggravate truesize underestimate problem for
> skb as there is no page splitting for those pages, if driver
> need a accuate truesize, it may calculate that according to

accurate

> frag size, page order and PAGE_POOL_DMA_USE_PP_FRAG_COUNT
> being true or not. And we may provide a helper for that if it
> turns out to be helpful.
> 
> 1. https://lore.kernel.org/all/20211117075652.58299-1-linyunsheng@huawei.com/

> +		/* Return error here to avoid writing to page->pp_frag_count in
> +		 * mlx5e_page_release_fragmented() for page->pp_frag_count is

I don't see any direct access to pp_frag_count anywhere outside of
page_pool.h in net-next. PAGE_POOL_DMA_USE_PP_FRAG_COUNT sounds like 
an internal flag, drivers shouldn't be looking at it, IMO.
