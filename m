Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382E37513B6
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jul 2023 00:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjGLWmD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 18:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjGLWmC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 18:42:02 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31151BF6
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 15:42:00 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-440b66adc81so73504137.1
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689201720; x=1691793720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mz/xfQs228JkD+EmKHVt4aMZuBD4Ky+nWhlpQiowkyI=;
        b=3JuEXg+yPSc6oD9k/gVHY9JmrXpcmYz2DdmUKfAenXycWth8Ys52+0sfJNBJqhx+JA
         POfjtfGzT4R2YWrxkgajUcAHuZwh0tHTbms8ZnyvNuUeIHHVBkyqjnNmi7pVjn+1p2XO
         FT+BJijgfx1i+WKA7jlT7PyuiJDtM4V2bSpZ2ORkcz5BPrprzhZVrwTkYbGJtevpuwWu
         +4s8IYxiO+jzUiXLxbNo6SvC/rtIpPMvBFlxMxrSFT5yrglpO/RRHqDNwsQ7XIWt3Mrm
         6q7/TIQmwLLzR3bbJ6UgAadSF6ClWCYMawulX/tcO2I2umBPB5clyz54VDHR+jYWjASk
         +o/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201720; x=1691793720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mz/xfQs228JkD+EmKHVt4aMZuBD4Ky+nWhlpQiowkyI=;
        b=gjPP2T0aqxIIohmJ7wtZ1x26LX66M+ueoqKgVW8umg6g0eWPQbI/2DNmoQSnisdeWH
         4JFI53dYv5KZa5Rcsh9ktwMgWq23zHp2BDJJhyjgW9lc0I4hACqswRiEpgfOSyllzbNC
         lR2WfeGPDykVgNhv97O0XD1ymfuUO+sxCdae9A9evC4ha4mlh5F1qm4DcbOfyc9s0Kx/
         +azTSDQmEdfKzU/dOT+4mRJAOsKtA7ChVNXjCmelsotUdAmRZt+GGdG9Ii/9n8Sct9QO
         Xc2wG8RH84Wj1jqAhEJLKIVrtrzciUxabLZ2Kx39VC+Q6APwtHkL50iFXPcFcxILr+xL
         5UeA==
X-Gm-Message-State: ABy/qLZK2lDNl9QSDS5dfqlEnIICyHhM9NAG6t+FWxfwddApnpcwTwFe
        yYENvDC/XAMoGiJ/PQNqyRbOVFdOV+yN/+x3aCt2PQ==
X-Google-Smtp-Source: APBJJlHG9tuCdU7vOjJOYos5RKoNNv0/pCxlxo2gIMlFQovsMtvJLWra+WgillnY1AK2C/ycTstYjvsR47Bt+BOekOU=
X-Received: by 2002:a67:b407:0:b0:443:4eca:f7f0 with SMTP id
 x7-20020a67b407000000b004434ecaf7f0mr99255vsl.11.1689201719631; Wed, 12 Jul
 2023 15:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230711050445.GA19323@lst.de> <ZK1FbjG+VP/zxfO1@ziepe.ca>
 <20230711090047.37d7fe06@kernel.org> <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org> <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org> <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
 <20f6cbda-e361-9a81-de51-b395ec13841a@amd.com> <ZK6ktnwIjXIobFIM@ziepe.ca> <4f6e62e0-b4c2-9fca-6964-28cfea902de0@amd.com>
In-Reply-To: <4f6e62e0-b4c2-9fca-6964-28cfea902de0@amd.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 12 Jul 2023 15:41:47 -0700
Message-ID: <CAHS8izPK4DZ-7JKuxh712tjuh1zpB+Stu6aSdC6vbN3YWHLfMg@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, David Ahern <dsahern@kernel.org>,
        Samiullah Khawaja <skhawaja@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
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
        Jonathan Lemon <jonathan.lemon@gmail.com>, logang@deltatee.com,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 12, 2023 at 6:35=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 12.07.23 um 15:03 schrieb Jason Gunthorpe:
> > On Wed, Jul 12, 2023 at 09:55:51AM +0200, Christian K=C3=B6nig wrote:
> >
> >>> Anyone see any glaring issues with this approach? I plan on trying to
> >>> implement a PoC and sending an RFC v2.
> >> Well we already have DMA-buf as user API for this use case, which is
> >> perfectly supported by RDMA if I'm not completely mistaken.
> >>
> >> So what problem do you try to solve here actually?
> > In a nutshell, netdev's design currently needs struct pages to do DMA
> > to it's packet buffers.
> >
> > So it cannot consume the scatterlist that dmabuf puts out
> >
> > RDMA doesn't need struct pages at all, so it is fine.
> >
> > If Mina can go down the path of changing netdev to avoid needing
> > struct pages then no changes to DRM side things.
> >
> > Otherwise a P2P struct page and a co-existance with netmem on a
> > ZONE_DEVICE page would be required. :\
>
> Uff, depending on why netdev needs struct page (I think I have a good
> idea why) this isn't really going to work generically either way.
>
> What we maybe able to do is to allow copy_file_range() between DMA-buf
> file descriptor and a TCP socket.
>
> If I'm not completely mistaken that should then end up in DMA-bufs
> file_operations->copy_file_range callback (maybe with some minor change
> to allows this).
>
> The DMA-buf framework could then forward this to the exporter of the
> memory which owns the backing memory could then do the necessary steps.
>

I may be missing something, but the way it works on our end for
receive is that we give a list of buffers (dma_addr + length + other
metadata) to the network card, and the network card writes incoming
packets to these dma_addrs and gives us an rx completion pointing to
the data it DMA'd. Usually the network card does something like an
alloc_page() + dma_map_page() and provides the to the network card.
Transmit path works similarly. Not sure that adding copy_file_range()
support to dma-buf enables this in some way.

--=20
Thanks,
Mina
