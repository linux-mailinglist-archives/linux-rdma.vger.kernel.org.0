Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC67370AC
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 17:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjFTPjX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 11:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjFTPjW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 11:39:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982C191;
        Tue, 20 Jun 2023 08:39:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B916612DF;
        Tue, 20 Jun 2023 15:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65912C433C8;
        Tue, 20 Jun 2023 15:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687275560;
        bh=eh34y9JToGjs/7tQpZPrFocGaATF0555w4p+49MYf6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BChDFjZiWdpXuqeqasgk2boOiqjtppRkgXuquTvIS7LVqDZY7gCCSAcUsDL7RE6qk
         dL/oIyufJi7RFC3c58IfogutCWO72JdOcfN9fVjrt3UTLWIqa2pnFgA6FJSphu1ueg
         z7tSuJhyX8tTDSCa29z9nXZtfBp1REMty8YJjGxpdOxfnC4icpAjyx2hEXIp0mYOnQ
         ab906KaL1s0MOlgX7shSm1SCOplTvhRtuvwZpTQIoIKUAEshyWBChMc4hXy2YSlq+R
         M5dhBkPvYZmRffUG3qsa6RT5P2sRHMwfrW5N5bcyC0CFwpau0zNisO0bSKP53O9mvr
         pjZRXwa2lBxnA==
Date:   Tue, 20 Jun 2023 08:39:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     brouer@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Message-ID: <20230620083918.2e3dbade@kernel.org>
In-Reply-To: <6909d28b-0ffc-a02a-235b-7bdce594965d@redhat.com>
References: <20230612130256.4572-1-linyunsheng@huawei.com>
        <20230612130256.4572-5-linyunsheng@huawei.com>
        <20230614101954.30112d6e@kernel.org>
        <8c544cd9-00a3-2f17-bd04-13ca99136750@huawei.com>
        <20230615095100.35c5eb10@kernel.org>
        <CAKgT0Uc6Xoyh3Edgt+83b+HTM5j4JDr3fuxcyL9qDk+Wwt9APg@mail.gmail.com>
        <908b8b17-f942-f909-61e6-276df52a5ad5@huawei.com>
        <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
        <72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com>
        <20230616122140.6e889357@kernel.org>
        <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com>
        <20230619110705.106ec599@kernel.org>
        <6909d28b-0ffc-a02a-235b-7bdce594965d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 20 Jun 2023 17:12:41 +0200 Jesper Dangaard Brouer wrote:
> > The workaround solution I had in mind would be to create a narrower API
> > for just data pages. Since we'd need to sprinkle ifs anyway, pull them
> > up close to the call site. Allowing to switch page pool for a
> > completely different implementation, like the one Jonathan coded up for
> > iouring. Basically
> > 
> > $name_alloc_page(queue)
> > {
> > 	if (queue->pp)
> > 		return page_pool_dev_alloc_pages(queue->pp);
> > 	else if (queue->iouring..)
> > 		...
> > }  
> 
> Yes, this is more the direction I'm thinking.
> In many cases, you don't need this if-statement helper in the driver, as
> driver RX side code will know the API used upfront.

Meaning that the driver "knows" if it's in the XDP, AF_XDP, iouring 
or "normal" Rx path?  I hope we can avoid extra code in the driver
completely, for data pages.

> The TX completion side will need this kind of multiplexing return
> helper, to return the pages to the correct memory allocator type (e.g.
> page_pool being one).  See concept in [1] __xdp_return().
> 
> Performance wise, function pointers are slow due to RETPOLINE, but
> switch-case statements (below certain size) becomes a jump table, which
> is fast.  See[1].
> 
> [1] https://elixir.bootlin.com/linux/v6.4-rc7/source/net/core/xdp.c#L377

SG!

> Regarding room in "struct page", notice that page->pp_magic will have
> plenty room for e.g. storing xdp_mem_type or even xdp_mem_info (which
> also contains an ID).

I was worried about fitting the DMA address, if the pages code from user
space.
