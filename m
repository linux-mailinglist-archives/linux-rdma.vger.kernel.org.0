Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1421750902
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 15:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjGLNB5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 09:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjGLNB4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 09:01:56 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C3A19B4
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 06:01:52 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-765942d497fso651063085a.1
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689166911; x=1691758911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YWpuSX94flQxvT/7GFNnyt8FcFburvzifDepq9lHVso=;
        b=iYD+caT5C5DZuj4SVL8bXKmm54Fife2Oz9uLMzl6trcTZ3BhImO/CJ2diP8cel4MIq
         XvWzM2pXRBQEjLiVo3Hgt06eJWjI2g2knQDKpA2bpSVnKpPcB5kCx3F2DSBXcUoh1RcW
         evRk6qNJjMFTRHZraP9CHksMsuP51beQli1rjtg5cRvCFZIiXfjjqzmq7912pS2ynyNH
         /SqCiWdXv8u7bRbNQhIjI9Y4D6U/0F8mt1bkXpyu60M2tzC25xcrXZUnG7XOxux/chyn
         iUj28ba/siqynf7x2SgrK9XpRda5v7gelAg/mnDloWN4XKIrIZHL0ttb9xLfMYOzQPpS
         n/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689166911; x=1691758911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWpuSX94flQxvT/7GFNnyt8FcFburvzifDepq9lHVso=;
        b=PPX7fHuKCdsSMXbpFl6uEGsibJz0loy/sU4NA00p7U6vyeQCdc/gyc+coJ8DG+7VXX
         qRFD6/0m/ggbK2fCS3d57LlYsXrFkbsmgNpDnXMeSu+WGhNIc3wpgzo3IJTOKescPh9p
         XKX2/+laSm5u/eiwPTpAymKZ0bEZV+aSbiHzv9GIMdMAzs7aGInp4H5kyysA7pDTi/0N
         BlnOpaFF5hOCaqyinSikZEMmXFCMwfjr1xtBzWvOi7QJV2PKB9gHbYx6wDJJlkvkkrkz
         eRqoN4JukjfCu0/Zr42VK+eGT67fWRDjwt8Bn5KhkP+IuObf+N2XehMF6ZqJM78GsA+i
         Q73g==
X-Gm-Message-State: ABy/qLa5ZNXY4iXwuTxiwm7MQfs2ACwtB7IWMcQ9NCLiGmG7QkcV7Ybk
        13R1QP7KtH7eJfTqF9D1t02/Ag==
X-Google-Smtp-Source: APBJJlFY1e3i66W1OtOcIX3n2XlytjAfsqmXfgyyy6DjtCl2reodlKdOdi1miiqTfvLyhJirNei5sQ==
X-Received: by 2002:ae9:dfc5:0:b0:767:d847:278a with SMTP id t188-20020ae9dfc5000000b00767d847278amr6940605qkf.74.1689166911567;
        Wed, 12 Jul 2023 06:01:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id u17-20020a05620a121100b007673f8803c3sm2105604qkj.96.2023.07.12.06.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:01:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qJZTU-000OJR-6S;
        Wed, 12 Jul 2023 10:01:44 -0300
Date:   Wed, 12 Jul 2023 10:01:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Ahern <dsahern@kernel.org>,
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
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        logang@deltatee.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Message-ID: <ZK6kOBl4EgyYPtaD@ziepe.ca>
References: <20230710215906.49514550@kernel.org>
 <20230711050445.GA19323@lst.de>
 <ZK1FbjG+VP/zxfO1@ziepe.ca>
 <20230711090047.37d7fe06@kernel.org>
 <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org>
 <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org>
 <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 11, 2023 at 08:42:24PM -0700, Mina Almasry wrote:

> 1. The device memory driver would be the p2pdma provider. It would
> expose a user API which allocates a device memory region, calls
> pci_p2pdma_add_resource() and pci_p2pmem_publish() on it, and returns
> a reference to it to the userspace.

This is not quite right, if you convert any of the GPU drivers to use
P2PDMA you are going to need to restructure the p2pmem stuff to
seperate the genalloc. The GPU driver must continue to be the owner
and allocator of the MMIO memory it already controls, we can't have
two allocators working in parallel. 

The genalloc stuff supports the special NVMe use case, I don't know of
anything else that would like to work that way.

> 2. The NIC driver would be the p2pdma client and orchestrator. It
> would expose a user API which binds an rxq to a pci device. Prior to
> the bind the user API would check that the pci device has published
> p2p memory (pci_has_p2pmem()), and check the the p2p mem is accessible
> to the driver (pci_p2pdma_distance() I think), etc.

This doesn't fit the programming model for GPUs at all. You don't want
to get packets landing in random GPU memory that a kernel side
allocator selects, you want packets landing in GPU memory owned by a
specific process that owns the TCP connection.

This is why DMABUF is used here as it gives a handle to the GPU
memory. What you want is to get the P2P pages either directly from the
DMABUF or via pin_user_pages() on the DMABUF's mmap.

> AFAICT, all the concerns brought up in this thread are sidestepped by
> using p2pdma. I need not allocate struct pages in the core dma-buf
> code anymore (or anywhere), and I need not allocate pgmaps. I would
> just re-use the p2pdma support.

Well, as I said it is going to be a big ask to P2P enable any of the
DRM drivers.

And you still have the netmem vs zone_device struct page conflict to
figure out

But it is alot closer to reasonable than this RFC.

Jason
