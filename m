Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897EC74E24C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 01:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjGJXtb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jul 2023 19:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGJXta (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jul 2023 19:49:30 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B211A2
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 16:49:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7659cb9c42aso393569685a.3
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 16:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689032967; x=1691624967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C1+7UfAMLI/Nu08LQwOr0R45kQ38N0MvpsViC9OWNis=;
        b=lOjm4Lx/2UPcQ0vl1fIalkQvnZK8D4gJI18w5QRFNsP45noSZ/Hlwqq9fLf6qno8S0
         GvM986sAXOOWD+3KlsW4spYFl1h5PPJyrFeDcdlNkEDclq35TvtosJh62CTCTkoRD9GK
         MqGXs6RSufFFgYmbGJAlQr1lrEr/1f2OYUXg5i3nLAJvb7ECX/2/AfZpA3lyMOZeND1n
         lFl8txf7CyG92a7kngcJ7Vq6bV3YMDykveds9sCnMS+V3OZ/EyLY8FCZCXVFPUP4B0LH
         qdqAHT53dGIFQ6ev9mJkB5oMnZhst31KWNYei6EFEyMLWMXAOhxl5/HniRY/5EQC+kez
         oVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689032967; x=1691624967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1+7UfAMLI/Nu08LQwOr0R45kQ38N0MvpsViC9OWNis=;
        b=P4BMZ/qU+2pB/ukPI6X/wBGAE6/3QZFVJddQElBMubMONgqcI6fqSxF8AphPr682P8
         GyOCGzFoaLBKKhN1o7zcCW5Sze11Q8eO7PkL13FBw+AS3ULIF7Jout8cUaLX1amLaJP6
         fCMlHDFocr5wNMpYd1iOmlRzWiPK5+Q0THecuN/tMmqDcobL8lofkws7LjJnTF3iucr1
         qQ45SBdu7MTWvDFqV5KNj0tlbkuDjH1cLCgEKR6G4RocZKJqlSipNI712aVoBbgQizzH
         cJSLtJZM5DJXuuwyEdZFmBA/y746741m+R4jUmBes9RbZUKowK6IBf/D8ndRo4yfyXiA
         q9MQ==
X-Gm-Message-State: ABy/qLb93PrepQNTZutjzoofgDDPmI6kjnwg7jJw9r/tTMvmDEJ668/D
        9OLy8nXmMgNOenOQ+cXgcNy94A==
X-Google-Smtp-Source: APBJJlEaSNhVB0rSanYyr8pEV+vVSyEFUXx0WrPVnHkD5VoRVa+WNmm9a90Aeu3n/gnPT2vgrqrtcw==
X-Received: by 2002:a0c:b3ce:0:b0:636:fda0:a23 with SMTP id b14-20020a0cb3ce000000b00636fda00a23mr10701191qvf.27.1689032967061;
        Mon, 10 Jul 2023 16:49:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id u14-20020a0c8dce000000b00632191a70a2sm370778qvb.103.2023.07.10.16.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 16:49:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qJ0dB-00063Y-Eu;
        Mon, 10 Jul 2023 20:49:25 -0300
Date:   Mon, 10 Jul 2023 20:49:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mina Almasry <almasrymina@google.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
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
Message-ID: <ZKyZBbKEpmkFkpWV@ziepe.ca>
References: <20230616122140.6e889357@kernel.org>
 <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com>
 <20230619110705.106ec599@kernel.org>
 <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
 <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
 <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <ZKNA9Pkg2vMJjHds@ziepe.ca>
 <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
 <ZKxDZfVAbVHgNgIM@ziepe.ca>
 <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 10, 2023 at 04:02:59PM -0700, Mina Almasry wrote:
> On Mon, Jul 10, 2023 at 10:44 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Jul 05, 2023 at 06:17:39PM -0700, Mina Almasry wrote:
> >
> > > Another issue is that in networks with low MTU, we could be DMAing
> > > 1400/1500 bytes into each allocation, which is problematic if the
> > > allocation is 8K+. I would need to investigate a bit to see if/how to
> > > solve that, and we may end up having to split the page and again run
> > > into the 'not enough room in struct page' problem.
> >
> > You don't have an intree driver to use this with, so who knows, but
> > the out of tree GPU drivers tend to use a 64k memory management page
> > size, and I don't expect you'd make progress with a design where a 64K
> > naturaly sized allocator is producing 4k/8k non-compound pages just
> > for netdev. We are still struggling with pagemap support for variable
> > page size folios, so there is a bunch of technical blockers before
> > drivers could do this.
> >
> > This is why it is so important to come with a complete in-tree
> > solution, as we cannot review this design if your work is done with
> > hacked up out of tree drivers.
> >
> 
> I think you're assuming the proposal requires dma-buf exporter driver
> changes, and I have a 'hacked up out of tree driver' not visible to
> you.

Oh, I thought it was obvious what you did in patch 1 was a total
non-starter when I said you can't abuse the ZONE_DEVICE pages like
this.

You must create ZONE_DEVICE P2P pages, not MEMORY_DEVICE_PRIVATE to
represent P2P memory, and you can't do that automatically from the
dmabuf core code.

Without doing this the DMA API doesn't actually work properly because
it doesn't have enough information to know about what the underlying
exporter is.

The entire point of DEVICE_PRIVATE is that the page content, and
access to the page's physical location, is *explicitly* unavailable to
anyone but the pgmap owner.

> > Fully and properly adding P2P ZONE_DEVICE to a real world driver is a
> > pretty big ask still.
> 
> There is no such ask.

Well, there is from me if you want to use stuct pages as handles for
P2P memory. That is what we have defined in the pgmap area.

Also I should warn you that your 'option 2' is being NAK'd by
Christoph for now, we are not adding any new code around DMABUF's
hacky use of NULL sg_page scatterlist for P2P memory either. I've been
working on solutions here but it is slow going.

> On dma-buf changes required. I do need approval from the dma-buf
> maintainers,

It is a neat hack, of sorts, to abuse DEVICE_PRIVATE to create struct
pages for the exclusive use of pagepool - but you need more approval
than just dmabuf maintainers to abuse the pgmap framework like
this.

At least from my position I want to see MEMORY_DEVICE_PCI_P2PDMA used
to represent P2P memory. You haven't CC'd anyone from the mm community
so I've added some people here to see if there are other opinions.

To be clear, you need an explicit ack from mm people on the abusive
use of pgmap in patch 1.

I know it is not what you want to hear, but there are actual reasons
why the P2P DMA problem has been festering for so long, and hacky
quick fixes like this are not going to be enough..

Jason
