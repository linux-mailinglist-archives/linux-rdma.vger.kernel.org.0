Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38BA74DD70
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jul 2023 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGJShc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jul 2023 14:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjGJSha (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jul 2023 14:37:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4E5E7A;
        Mon, 10 Jul 2023 11:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEC7161188;
        Mon, 10 Jul 2023 18:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4E8C433C8;
        Mon, 10 Jul 2023 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689014216;
        bh=3V48iVlWikK7+xkrQrVzUL1afLYqdz5P3aWe2xP9aKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mtKID28LzQLD3ZKaKVednP+/AYI/nIBf3aeVEYSNOMj0K/CS77ps4kCUTSxM4mNmJ
         7BmZ1h6pa3jvSNZDQ52kuCvbTRC3T+2O3N1SN7jpJXQpjTdCHV+s+1iU1V3O1ECQrC
         tF8OpR6hqvfahjNhiAXGIWt6jTBN8QWuBLlYvaD4X85LZcDJZTZRiyWWyzWwHkczR0
         Lo3S+TFqfwZlKg2Brnw71cuFAyH1IrgSoo+22tDLuLsx06OMm5r3lL1ueYOgAY8zIW
         ne9p/DlyMzbYFhgU3pKz6f3pyDZf5r+QwA+bObVKNSHtHtGSrIOk3Tbu8PUkPNURot
         uFtodyGqbtADQ==
Date:   Mon, 10 Jul 2023 11:36:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <yunshenglin0825@gmail.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Message-ID: <20230710113654.71d1ac84@kernel.org>
In-Reply-To: <81a8b412-f2b5-fac9-caa4-149d5bf71510@gmail.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
        <20230629120226.14854-2-linyunsheng@huawei.com>
        <20230707165921.565b1228@kernel.org>
        <81a8b412-f2b5-fac9-caa4-149d5bf71510@gmail.com>
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

On Sun, 9 Jul 2023 20:39:45 +0800 Yunsheng Lin wrote:
> On 2023/7/8 7:59, Jakub Kicinski wrote:
> > On Thu, 29 Jun 2023 20:02:21 +0800 Yunsheng Lin wrote:  
> >> +		/* Return error here to avoid mlx5e_page_release_fragmented()
> >> +		 * calling page_pool_defrag_page() to write to pp_frag_count
> >> +		 * which is overlapped with dma_addr_upper in 'struct page' for
> >> +		 * arch with PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true.
> >> +		 */
> >> +		if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
> >> +			err = -EINVAL;
> >> +			goto err_free_by_rq_type;
> >> +		}  
> > 
> > I told you not to do this in a comment on v4.
> > Keep the flag in page pool params and let the creation fail.  
> 
> There seems to be naming disagreement in the previous discussion,
> The simplest way seems to be reuse the
> PAGE_POOL_DMA_USE_PP_FRAG_COUNT and do the checking in the driver
> without introducing new macro or changing macro name.
> 
> Let's be more specific about what is your suggestion here:
> Do you mean keep the PP_FLAG_PAGE_FRAG flag and keep the below
> checking in page_pool_init(), right?
> 	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
> 	    pool->p.flags & PP_FLAG_PAGE_FRAG)
> 		return -EINVAL;
> 
> Isn't it confusing to still say page frag is not supported
> for PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true case when this
> patch will now add support for it, at least from API POV, the
> page_pool_alloc_frag() is always supported now.

I don't mind what the flag is called, I just want the check to stay
inside the page_pool code, acting on driver info passed inside
pp_params.

> Maybe remove the PP_FLAG_PAGE_FRAG and add a new macro named
> PP_FLAG_PAGE_SPLIT_IN_DRIVER, and do the checking as before in
> page_pool_init() like below?
> 	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
> 	    pool->p.flags & PP_FLAG_PAGE_SPLIT_IN_DRIVER)
> 		return -EINVAL;

Yup, that sound good.
