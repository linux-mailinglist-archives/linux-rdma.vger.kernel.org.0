Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C03B763B95
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jul 2023 17:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjGZPuy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jul 2023 11:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjGZPux (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jul 2023 11:50:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AB5193;
        Wed, 26 Jul 2023 08:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5775D61B6C;
        Wed, 26 Jul 2023 15:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D9AC433C8;
        Wed, 26 Jul 2023 15:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690386651;
        bh=FBVPvVza7HG5I1VIoHJB6h+yX1R7w7DkdilDfqNT6DU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=maYVcK7N/Vm7jnhc68l/McAk7CYwSeld6XBM85yy8GktdXapsIj0lVxwy91fEnsNM
         qUHskpQW3xDpoahJa5Ia4h6ay96WSBm/MpB2E3Lwna0++qtXTylHp0/Fk7/om4dIXZ
         5cDAEF+kcyCYwPw4Czm4VyAnVtOOkJ/lcJLYZhEEevuujEBllPDWuf8uuXmjareC3H
         b7tO2FiRCA4uc9GitfhSc1qbPSIV0rNdyc2IfN9/vZauIQJctXvxD4/KI2jL1TRKcb
         P+TuLrNc3bw6tMDq/GipoSv4zIAoTXgbZIHE4bsLnWqj70kdEX5PbT+ULYI9M4II26
         P0CQC5tiJcQsA==
Date:   Wed, 26 Jul 2023 08:50:49 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2] page_pool: split types and declarations
 from page_pool.h
Message-ID: <20230726085049.36b527a4@kernel.org>
In-Reply-To: <CAKgT0UfL4ri-o7WifeewpezGQY1UQKwcBEUSSY80DyKoE8g-0w@mail.gmail.com>
References: <20230725131258.31306-1-linyunsheng@huawei.com>
        <94272ffed7636c4c92fcc73ccfc15236dd8e47dc.camel@gmail.com>
        <16b4ab57-dfb0-2c1d-9be1-57da30dff3c3@intel.com>
        <22af47fe-1347-3e32-70bf-745d833e88b9@huawei.com>
        <CAKgT0UcU4RJj0SMQiVM8oZu86ZzK+5NjzZ2ELg_yWZyWGr04PA@mail.gmail.com>
        <CAKgT0UfL4ri-o7WifeewpezGQY1UQKwcBEUSSY80DyKoE8g-0w@mail.gmail.com>
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

On Wed, 26 Jul 2023 08:39:43 -0700 Alexander Duyck wrote:
> > > I suppose the above suggestion is about splitting or naming by
> > > the user as the discussed in the below thread?
> > > https://lore.kernel.org/all/20230721182942.0ca57663@kernel.org/  
> >
> > Actually my suggestion is more about defining boundaries for what is
> > meant to be used by drivers and what isn't. The stuff you could keep
> > in net/core/page_pool.h would only be usable by the files in net/core/
> > whereas the stuff you are keeping in the include/net/ folder is usable
> > by drivers. It is meant to prevent things like what you were
> > complaining about with the Mellanox drivers making use of interfaces
> > you didn't intend them to use.

FWIW moving stuff which is only supposed to be used by core (xdp, skb,
etc.) to net/core/page_pool.h is a good idea, too. 
Seems a bit independent from splitting the main header, tho.

> > So for example you could pull out functions like
> > page_pool_return_skb_page, page_pool_use_xdp_mem,
> > page_pool_update_nid, and the like and look at relocating them into
> > the net/core/ folder and thereby prevent abuse of those functions by
> > drivers.  
> 
> Okay, maybe not page_pool_update_nid. It looks like that is already in
> use in the form of page_pool_nid_changed by drivers..

