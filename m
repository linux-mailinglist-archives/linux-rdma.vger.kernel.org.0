Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB3974A27A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jul 2023 18:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGFQuf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jul 2023 12:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjGFQue (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jul 2023 12:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463A91BE9;
        Thu,  6 Jul 2023 09:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9237560F7F;
        Thu,  6 Jul 2023 16:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BD1C433C8;
        Thu,  6 Jul 2023 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688662230;
        bh=JMMqVQ1L/TaeP106mVLOHP/qWvAPkrzYjnG3d18DeQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ir2qoTruxn8EC28k39ppqWj7eeCov8opvLIoQZDd9BhZVvkq75++NiA9T82jyZMlh
         6U1NrBurZzJhfQjPAN2sTXnXGC4DfyJzAcO0hs6Kz36cWRbuYi8qSUGcEz2wVc1/Wh
         pGMtk8MYumaTLJ8dFBEdjMMWmAfXNvu9r61AKfepXcOKlskr+CjiUhqnkU66slIy2A
         e1Kpy0y130Rov3/L/vDz+JPUAacRFI7+70NBn2tN/y+bvukoOufS+HrZ1PSFqgqE25
         PuYlNZIFJ2WmeMrJnak39p7WkaAWuDU++qQoJO51pr3abUjH+93nsp3+ELFvhVYgqt
         9piME/8krW9sg==
Date:   Thu, 6 Jul 2023 09:50:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com,
        Alexander Duyck <alexander.duyck@gmail.com>,
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
Message-ID: <20230706095028.19c4c637@kernel.org>
In-Reply-To: <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
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
        <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 29 Jun 2023 19:27:46 -0700 Mina Almasry wrote:
> I've discussed your page pool frontend idea with our gve owners and
> the idea is attractive. In particular it would be good not to insert
> much custom code into the driver to support device memory pages or
> other page types. I plan on trying to change my approach to match the
> page pool provider you have in progress here:
> https://github.com/kuba-moo/linux/tree/pp-providers
> 
> In particular the main challenge right now seems to be that my device
> memory pages are ZONE_DEVICE pages, which can't be inserted to the
> page pool as-is due to the union in struct page between the page pool
> entries and the ZONE_DEVICE entries. I have some ideas on how to work
> around that I'm looking into.

Right, have you talked to Willem? I mentioned to him that I initially
pursued the idea of using the page pool as an abstraction but I
realized that fitting both the dma addr and the frag reference count
into struct page which isn't just a basic page will be a challenge.

So the second best thing seems to be to create an API which matches 
the page pool API, and have it select between a page pool and another
provider based on user configuration. As you said the main goal is to
be able to feed kernel / user / device memory to the driver without
having to modify driver code.

I thought this would live "above" the page pool (perhaps that's what
you mean by gen_pool) but Jesper brought up integrating it into the
(middle of?) page pool and have page pool switch on the pp_magic.
No strong preference on which on is better, seems like something that
can only be ironed out by modifying a couple of drivers to find out
what fits best :(

I'm hoping to jump back into the pp_provider work and finish that up
over the next few days, to at least post a PoC. Even if it doesn't work
for user / device memory - being able to feed the page pool from huge
pages is already a big win for the IOTLB.
