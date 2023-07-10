Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D0074DCAA
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jul 2023 19:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGJRoK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jul 2023 13:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGJRoJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jul 2023 13:44:09 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9834612B
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 10:44:07 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-765a4ff26cdso433080585a.0
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689011047; x=1691603047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOnVzen9HDghW2bswxVCUVsZLhlFm73bqh1O1PTU2i4=;
        b=WLQs6EGun6B4BulXmKogPdCt5oDVFVpE2okzj27FHCHNnLDGIi5Czr14p89ybAaXYJ
         lhMk1w685GxTpiUrgFlizkUlyNVVz8nobylcjl30cPaLaTPeJE3z6JVgYmXjCN3ss5vo
         Q82dok6ccsNwR6dZZeC5Uc8sSHaM9gSRZNnou3UkB0vrGQPnuGeSrm1Q/3KZboxAzoVb
         H13lwGXwQ6e6Km+Dl3IMJxRHMGkEVGEkOp0D+LLl6byPLvxeJpBIju++uVvCt5NYV2/7
         7w/6QRlieWrNTaKDG74MRdVrZ5SqOcAGw5ip54VjrxKSNLq8BAtYgaaEz7vgDQF4W/kA
         ufBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689011047; x=1691603047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOnVzen9HDghW2bswxVCUVsZLhlFm73bqh1O1PTU2i4=;
        b=lk6o/G/sY/bkkmzAint7n9u1pQ57Q3Answ7AHCgXgp/+1W9Kp5G00PbnCDOEuIyYJk
         nPtZgeH49CgFNXC8rkuyvD/5xTPGRy/Aw1NE7DtfPDdrl0yZ+s+QVGooCFxPEHK3HE2W
         Rtlt8lYIC5E7BMwUg6MSQCukjCyE7qPg7hvuFbllI26wz3T/9tnpZhvzv6S5upOm3JMU
         pXjH8qhA+vFIr1HGrU5y7uZn1T0rJ9U99PaZzJrveDh+qFC3zsm8aWu0xFeZzbTsaIrf
         D2tmJVgmHw27xArT3Ak17AYz5EKQt2agO0bs0A/ikkMPecSvUPH3p48+lWR6xIR0meKK
         jyuA==
X-Gm-Message-State: ABy/qLbwDc0aFGGaKy3sihr3jDe25bD1v9oyiE3MZtwfGV9L+O6VL1+b
        J/ovpVjY5NOt4APVIXibdkwN1w==
X-Google-Smtp-Source: APBJJlEadY1dI3vNQ2N0fmgDC+Ual1DpU2psFdVln3u1qHl6Z/3ncb0HysMERESWP4YSo180rdHzZw==
X-Received: by 2002:a37:b645:0:b0:75d:4e8b:9d19 with SMTP id g66-20020a37b645000000b0075d4e8b9d19mr14672746qkf.26.1689011046739;
        Mon, 10 Jul 2023 10:44:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id o8-20020a0cf4c8000000b0063007ccaf42sm59906qvm.57.2023.07.10.10.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 10:44:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qIuvd-0004KO-KO;
        Mon, 10 Jul 2023 14:44:05 -0300
Date:   Mon, 10 Jul 2023 14:44:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <ZKxDZfVAbVHgNgIM@ziepe.ca>
References: <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
 <72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com>
 <20230616122140.6e889357@kernel.org>
 <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com>
 <20230619110705.106ec599@kernel.org>
 <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
 <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
 <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <ZKNA9Pkg2vMJjHds@ziepe.ca>
 <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 05, 2023 at 06:17:39PM -0700, Mina Almasry wrote:

> Another issue is that in networks with low MTU, we could be DMAing
> 1400/1500 bytes into each allocation, which is problematic if the
> allocation is 8K+. I would need to investigate a bit to see if/how to
> solve that, and we may end up having to split the page and again run
> into the 'not enough room in struct page' problem.

You don't have an intree driver to use this with, so who knows, but
the out of tree GPU drivers tend to use a 64k memory management page
size, and I don't expect you'd make progress with a design where a 64K
naturaly sized allocator is producing 4k/8k non-compound pages just
for netdev. We are still struggling with pagemap support for variable
page size folios, so there is a bunch of technical blockers before
drivers could do this.

This is why it is so important to come with a complete in-tree
solution, as we cannot review this design if your work is done with
hacked up out of tree drivers.

Fully and properly adding P2P ZONE_DEVICE to a real world driver is a
pretty big ask still.

> > Or allocate per page memory and do a memdesc like thing..
> 
> I need to review memdesc more closely. Do you imagine I add a pointer
> in struct page that points to the memdesc? 

Pointer to extra memory from the PFN has been the usual meaning of
memdesc, so doing an interm where the pointer is in the struct page is
a reasonable starting point.

> > Though overall, you won't find devices creating struct pages for their
> > P2P memory today, so I'm not sure what the purpose is. Jonathan
> > already got highly slammed for proposing code to the kernel that was
> > unusable. Please don't repeat that. Other than a special NVMe use case
> > the interface for P2P is DMABUF right now and it is not struct page
> > backed.
> >
> 
> Our approach is actually to extend DMABUF to provide struct page
> backed attachment mappings, which as far as I understand sidesteps the
> issues Jonathan ran into.

No DMABUF exporters do this today, so your patch series is just as
incomplete as the prior ones. Please don't post it as non-RFC,
unusable code like this must not be merged.

> that supports dmabuf and in fact a lot of my tests use udmabuf to
> minimize the dependencies. The RFC may come with a udmabuf selftest to
> showcase that any dmabuf, even a mocked one, would be supported.

That is not good enough to get merged. You need to get agreement and
coded merged from actual driver owners of dmabuf exporters that they
want to support this direction. As above it has surprising road
blocks outside netdev :\

Jason
