Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18D974F92F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 22:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjGKUjV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 16:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjGKUjU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 16:39:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01771AE;
        Tue, 11 Jul 2023 13:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45E69615D4;
        Tue, 11 Jul 2023 20:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C0FC433C8;
        Tue, 11 Jul 2023 20:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689107957;
        bh=IUkMami0q8XF0yGB572r+2o8IYCDeaMrkBy4BDhJ9Ag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gLHjwzndBZxh0m1Nwmqy8nrX9bXH8Vnv5+ZxrOfGDXN7jd40Msiv1J1bZGLXIH5z2
         oJus6+FV8hP/WWNUuLuXoDk6kzGjM/xqn2z5cs0lsl0vJoXcsLz6mxPfoPzzyXOJk2
         ORK7ZgszHiFGEYqHl5+9he/2D0jMNPJYBIXp5AuznXtKSF5+HOhzHJhAbxtRHoVsWv
         QLF/dB+6GNTaQCV8o+aXrkly/dblANoUCP5yjOBckkEnDQh7KBZVIma1e2/6qhRLSB
         INnioJnYNn4NmBgc4I1Wl8idrPvVBzvQ44p1B7prACsfxGgObO+QDbc+AaVYi/PQP3
         aNkSejK68rzag==
Date:   Tue, 11 Jul 2023 13:39:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        brouer@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
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
Message-ID: <20230711133915.03482fdc@kernel.org>
In-Reply-To: <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
References: <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
        <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
        <ZKNA9Pkg2vMJjHds@ziepe.ca>
        <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
        <ZKxDZfVAbVHgNgIM@ziepe.ca>
        <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
        <ZKyZBbKEpmkFkpWV@ziepe.ca>
        <20230711042708.GA18658@lst.de>
        <20230710215906.49514550@kernel.org>
        <20230711050445.GA19323@lst.de>
        <ZK1FbjG+VP/zxfO1@ziepe.ca>
        <20230711090047.37d7fe06@kernel.org>
        <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
        <20230711093224.1bf30ed5@kernel.org>
        <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 11 Jul 2023 10:06:28 -0700 Mina Almasry wrote:
> > > Any reason not to allow an alternative representation for skb frags than
> > > struct page?  
> >
> > I don't think there's a hard technical reason. We can make it work.  
> 
> I also think we can switch the representation for skb frags to
> something else. However - please do correct me if I'm wrong - I don't
> think that is sufficient for device memory TCP. My understanding is
> that we also need to modify any NIC drivers that want to use device
> memory TCP to understand a new memory type, and the page pool as well
> if that's involved. I think in particular modifying the memory type in
> all the NIC drivers that want to do device memory TCP is difficult. Do
> you think this is feasible?

That's why I was thinking about adding an abstraction between 
the page pool and the driver. Instead of feeding driver pages
a new abstraction could feed the driver just an identifier and a PA.

Whether we want to support fragmentation in that model or not would 
have to be decided.

We can take pages from the page pool and feed them to drivers via
such an API, but drivers need to stop expecting pages.

That's for data buffers only, obviously. We can keep using pages 
and raw page pool for headers.
