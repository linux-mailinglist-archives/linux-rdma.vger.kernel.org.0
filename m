Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7576974FBF6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 01:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGKX5C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 19:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGKX5B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 19:57:01 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC051712
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 16:57:00 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a1e6022b93so4843529b6e.1
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 16:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689119819; x=1691711819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=leJKi4u06YRTzo0lBrUW1GjV6mczJ561dFwtREQL+Dg=;
        b=DXK8WidcvmvzjeVYH/6WijviZ73toBOmyVp9mIOd03ZD+R3rHWdoxQSvE5e9wD1KCJ
         9mK/DDwssbLXSnouE8MAwnVDe+VkRcpQSrinJNmyu0FnYmd+CKVNA1F34dvSGu5lfZwy
         cyr25JKjczwfRObdI7oARPE9gHghtmOAegQpocDq/APkFl+1PNSXGJo1xP2SNdGpJGtv
         /nEQL7vqxVxYsTwIY7luylFSj8xoTEsYM9t5cm2HxYfPwTnzx8rs4qClhieKHRjwL54Q
         8sya8gM8UB4rmOcx/i0v01+HlH4cbtNGlO2x9kzZaZUcFmUL9dtfGxX7fDRkv+FMzf1u
         InjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689119819; x=1691711819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leJKi4u06YRTzo0lBrUW1GjV6mczJ561dFwtREQL+Dg=;
        b=iQv+pP8BAHUJCp+G9HoSIGKNer5WZXzZdA6OpUgcfx9Iy9TAFzrN5zrIq8VL4Qv3Am
         gio855eC4ZOPrCuwUU3D1h253U8DI98QWIr5lntwj+rMiVIWdshhMudbaEFyAOZIHLLZ
         Pvxis2fpEVB22v4teV8ar/2eI7wwwa5kK7JWA/CqWco3wnbYuvOnlmUwQb89kSDdf8+P
         58Nc04LreAZjDGXahPSonPpz7w5r6vRTWU++cyss+x5PEEv+Dv4vdyWJbv1b7tuMD2wN
         Zn2R9SkDxIUMSkqDxT61LDk5xotcQgVRYLF6ulLOWJmKL/Xvz3DL4OQ9schhHU4oJJCC
         8gnw==
X-Gm-Message-State: ABy/qLbpou5qvY+qS2VlkQpx9l6CWDHjXAyUz/VSkhaNAY5nR7F7kmZ5
        BgomOFii6o8KNifUjjBVfQ1P1g==
X-Google-Smtp-Source: APBJJlHPVDwycmPbbNO1kwHaGDMrzsNQAmVLFppzVomF/d82yUMQJxrek5vJqs3gAPlID0cxcW6lxg==
X-Received: by 2002:a05:6808:11cf:b0:3a3:fa64:b543 with SMTP id p15-20020a05680811cf00b003a3fa64b543mr9841890oiv.12.1689119819344;
        Tue, 11 Jul 2023 16:56:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id x11-20020a63b34b000000b005533c53f550sm1952223pgt.45.2023.07.11.16.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 16:56:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qJNE0-000KOY-Hj;
        Tue, 11 Jul 2023 20:56:56 -0300
Date:   Tue, 11 Jul 2023 20:56:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mina Almasry <almasrymina@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Ahern <dsahern@kernel.org>,
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
Message-ID: <ZK3sSMSVWM5EbHLG@ziepe.ca>
References: <ZKyZBbKEpmkFkpWV@ziepe.ca>
 <20230711042708.GA18658@lst.de>
 <20230710215906.49514550@kernel.org>
 <20230711050445.GA19323@lst.de>
 <ZK1FbjG+VP/zxfO1@ziepe.ca>
 <20230711090047.37d7fe06@kernel.org>
 <ZK2Gh2qGxlpZexCM@ziepe.ca>
 <20230711100636.63b0a88a@kernel.org>
 <ZK2k9YQiXTtcGhp0@ziepe.ca>
 <20230711133420.5df88f02@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711133420.5df88f02@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 11, 2023 at 01:34:20PM -0700, Jakub Kicinski wrote:

> > Yep. At the high end open standards based ethernet has also notably
> > "failed" as well. Every switch vendor now offers their own proprietary
> > ecosystem on a whole bunch of different axis. They all present
> > "ethernet" toward the host but the host often needs to work in a
> > special way to really take full advantage of the proprietary fabric
> > behaviors.
> 
> I'm not familiar with "high end open standards based on ethernet", would
> those be some RDMA / storage things? For TCP/IP networks pretty much
> the only things that matter in a switch are bandwidth, size of buffers,
> power... Implementation stuff.

I would say when you are getting into ethernet deployments with 25 or
51 Tbps switches directly connected to hosts running at >100G you are
getting into the high end side of things.

These are very expensive networks. They run complex congestion
provoking workloads. They have sophisticated multi-pathing. They often
use use a non-blocking topology. Congestion management is important.

Making this work with good utilization, and low tail latency is a
really hard problem. Many of the solutions come with switch features
supporting it.

You'd proably say these are not TCP focused networks, even though they
are based on ethernet and IP.

So I think of them as high end "standards based" ethernet and IP
looking networks that have proprietary elements mixed in throughout.

Right now there is a bit of a press war between vendors on 'ethernet
for AI'. Both Broadcom and NVIDIA are taking techonlogies that were
originally built for TCP ethernet networks and remixing/speeding them
up to run roce workloads effectively. There is alot more information
available now without NDA that shows some detail on this space.

AWS's SRD multipathing, Broadcom "AI Ethernet" and NVIDIA's Spectrum-X
spring to mind as topical to what these sorts of ethernet networks
are.

> A lot of "standardization" efforts are just attempts to prove to 
> a buyers that an ecosystem exists.

Heh, that was probably more true years ago. These days it seems like
some standardization is also being done so the large hyperscalers can
improve their Approved Vendors List.

I suppose as long as the result is something we can implement openly
in Linux the motivation for standardization is less important.

Jason
