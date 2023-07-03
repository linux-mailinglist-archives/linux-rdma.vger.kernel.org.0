Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C107745568
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jul 2023 08:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGCGWr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jul 2023 02:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGCGWr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jul 2023 02:22:47 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C015CC1
        for <linux-rdma@vger.kernel.org>; Sun,  2 Jul 2023 23:22:45 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-78a1e095508so1371325241.0
        for <linux-rdma@vger.kernel.org>; Sun, 02 Jul 2023 23:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688365365; x=1690957365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh2dAhBT/r+t8dBDKmgiVOzd46bgkC5w60SC2kQomME=;
        b=CSbXeIllDKG52Hz2y0BzvzeWTNUEc4fr1uNpd8I0jFTbwT+x3xDzfAMsPWIKx6IndK
         bOfUdQihG5MDXKogCsRu0ZSQMmMqJLNluQnXpau1J4w9cUIMMHIL/jF+DEbhCBDpOV4D
         UrvGya3awuDtGeA3F5CEGu7Tsy5x6It+z9gqJsw2oPuPXEPiIxuE9fQSoLE3tGreKNSn
         n29sZy8eBYgJ3uG2O2Vor2R9NR0H8vnSeaY4+eTO2hqtFSudrrp5NWwTcNsssh4ExF2G
         md6hi/utlTHH/EJqeqUjebheF7KLxlDoH+TCdnplsNmsiqqiOSECjVqhIKnbPUezcxIN
         Ax/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688365365; x=1690957365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh2dAhBT/r+t8dBDKmgiVOzd46bgkC5w60SC2kQomME=;
        b=cYk48PVm22sEpqVZw2eOjJkLI3CSGYJ/7w7RgK4EcLF+9i4phWiy+rFvQD+3Pw5q4Q
         qaPAhQYo3yw78Ouoaw5edJlbvJuJw5LZ7rj+/yYny/o0KoOByDyVm8xmKmENEB+urRNu
         NeKMRzXwusKBIpO3XaErgCX7/fllNbavlqvXL4LHrbBKwrE1Ys85Ux8nRXRFjtDlRuNj
         fs3+URiqoMH9yKQRCn9LSe8fyXgKaWo9GrmHDDm0PuSSVIXwn+DQdhK05HXPQ52r5IQm
         SnvXiB9ehdx2Awk6A5udq7AyyaWEw0kfBbMUoW2XKpBINvzofCc7WJc7Z8iEGsIKPOki
         t/Tw==
X-Gm-Message-State: ABy/qLasNGXUlhSuLnovcPmvXWJv1/VNyFyreuaMpV2SEVW7T6MZZYlh
        i8mBHwboZ+wCPOEK19jMfwcZjpPxcaSj3Ljkqw56Fw==
X-Google-Smtp-Source: APBJJlH0cEalozKdN1PxBzsfGgMveO3/o2cxZaibne5GXfrl3uwlOSKqPsgSIeVejxm1iGr09N+dbcj5d2OvkAVr1vs=
X-Received: by 2002:a67:ee55:0:b0:443:6052:43ac with SMTP id
 g21-20020a67ee55000000b00443605243acmr3287737vsp.30.1688365364750; Sun, 02
 Jul 2023 23:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230612130256.4572-1-linyunsheng@huawei.com> <20230612130256.4572-5-linyunsheng@huawei.com>
 <20230614101954.30112d6e@kernel.org> <8c544cd9-00a3-2f17-bd04-13ca99136750@huawei.com>
 <20230615095100.35c5eb10@kernel.org> <CAKgT0Uc6Xoyh3Edgt+83b+HTM5j4JDr3fuxcyL9qDk+Wwt9APg@mail.gmail.com>
 <908b8b17-f942-f909-61e6-276df52a5ad5@huawei.com> <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
 <72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com> <20230616122140.6e889357@kernel.org>
 <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com> <20230619110705.106ec599@kernel.org>
 <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com> <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
In-Reply-To: <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sun, 2 Jul 2023 23:22:33 -0700
Message-ID: <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To:     David Ahern <dsahern@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 2, 2023 at 9:20=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 6/29/23 8:27 PM, Mina Almasry wrote:
> >
> > Hello Jakub, I'm looking into device memory (peer-to-peer) networking
> > actually, and I plan to pursue using the page pool as a front end.
> >
> > Quick description of what I have so far:
> > current implementation uses device memory with struct pages; I am
> > putting all those pages in a gen_pool, and we have written an
> > allocator that allocates pages from the gen_pool. In the driver, we
> > use this allocator instead of alloc_page() (the driver in question is
> > gve which currently doesn't use the page pool). When the driver is
> > done with the p2p page, it simply decrements the refcount on it and
> > the page is freed back to the gen_pool.

Quick update here, I was able to get my implementation working with
the page pool as a front end with the memory provider API Jakub wrote
here:
https://github.com/kuba-moo/linux/tree/pp-providers

The main complication indeed was the fact that my device memory pages
are ZONE_DEVICE pages, which are incompatible with the page_pool due
to the union in struct page. I thought of a couple of approaches to
resolve that.

1. Make my device memory pages non-ZONE_DEVICE pages. The issue with
that is that if the page is not ZONE_DEVICE, put_page(page) will
attempt to free it to the buddy allocator I think, which is not
correct. The only places where the mm stack currently allow custom
freeing callback (AFAIK), are for ZONE_DEVICE page where
free_zone_device_page() will call the provided callback in
page->pgmap->ops->page_free, and compound pages where the
compound_dtor is specified. My device memory pages aren't compound
pages so only ZONE_DEVICE pages do what I want.

2. Convert the pages from ZONE_DEVICE pages to page_pool pages and
vice versa as they're being inserted and removed from the page pool.
This, I think, works elegantly without any issue, and is the option I
went with. The info from ZONE_DEVICE that I care about for device
memory TCP is the page->zone_device_data which holds the dma_addr, and
the page->pgmap which holds the page_free op. I'm able to store both
in my memory provider so I can swap pages from ZONE_DEVICE and
page_pool back and forth.

So far I haven't needed to make any modifications to the memory
provider implementation Jakub has pretty much, and my functionality
tests are passing. If there are no major objections I'll look into
cleaning up the interface a bit and propose it for merge. This is a
prerequisite of device memory TCP via the page_pool.

>
> I take it these are typical Linux networking applications using standard
> socket APIs (not dpdk or xdp sockets or such)? If so, what does tcpdump
> show for those skbs with pages for the device memory?
>

Yes these are using (mostly) standing socket APIs. We have small
extensions to sendmsg() and recvmsg() to pass a reference to the
device memory in both these cases, but that's about it.

tcpdump is able to access the header of these skbs which is in host
memory, but not the payload in device memory. Here is an example
session with my netcat-like test for device memory TCP:
https://pastebin.com/raw/FRjKf0kv

tcpdump seems to work, and the length of the packets above is correct.
tcpdump -A however isn't able to print the payload of the packets:
https://pastebin.com/raw/2PcNxaZV

--=20
Thanks,
Mina
