Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD31B753EA0
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jul 2023 17:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjGNPSy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jul 2023 11:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbjGNPSx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jul 2023 11:18:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718D21734;
        Fri, 14 Jul 2023 08:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F9C161D27;
        Fri, 14 Jul 2023 15:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F26C433C8;
        Fri, 14 Jul 2023 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689347929;
        bh=GHCoMZ/UoQEwvyyLj6obOxuoQTyZeeHkQU5SH5+3Uxs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lrmyl9F8q9Rq2thyyQq0ZVZLcPhb4o/lwoL+z/+ADAjtZdUKdfTZTiunxbU+4kdKK
         0Da5r0Eqg/61a4BCR/TFnukrBg1hJ7hEXuVYybrFim2RlP3R8UrA4w+0ROUPMcdX9f
         1+xUb26QVvO2B/rhetJRb87Q5Q3VURFnqoLzqkAn2E0hFpF9NPAg9uj0EQdClX9hb6
         C21oI9cSaPoxbm5sZLfsENXUBliAPZVEL1tx/P1ZxBiNTYRTv23FAc5qinpPFMLPDV
         Vf3K0PJg8Ga+KB1Oi1jU7cRPCbfbwS3CAx+M2LAUNJAog2sZeKoQb8gvPpvQiiLyz9
         al4TZNje6hjmA==
Message-ID: <9cf3ce79-2d5e-090d-c83e-0c359ace1cb9@kernel.org>
Date:   Fri, 14 Jul 2023 09:18:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Hari Ramakrishnan <rharix@google.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
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
References: <20230710215906.49514550@kernel.org>
 <20230711050445.GA19323@lst.de> <ZK1FbjG+VP/zxfO1@ziepe.ca>
 <20230711090047.37d7fe06@kernel.org>
 <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org>
 <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org>
 <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
 <ZK6kOBl4EgyYPtaD@ziepe.ca>
 <CAHS8izNuda2DXKTFAov64F7J2_BbMPaqJg1NuMpWpqGA20+S_Q@mail.gmail.com>
 <143a7ca4-e695-db98-9488-84cf8b78cf86@amd.com>
 <CAHS8izPm6XRS54LdCDZVd0C75tA1zHSu6jLVO8nzTLXCc=H7Nw@mail.gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <CAHS8izPm6XRS54LdCDZVd0C75tA1zHSu6jLVO8nzTLXCc=H7Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/14/23 8:55 AM, Mina Almasry wrote:
> 
> I guess the remaining option not fully explored is the idea of getting
> the networking stack to consume the scatterlist that
> dma_buf_map_attachment() provides for the device memory. The very
> rough approach I have in mind (for the RX path) is:
> 
> 1. Some uapi that binds a dmabuf to an RX queue. It will do a
> dma_buf_map_attachment() and get the sg table.
> 
> 2. We need to feed the scratterlist entries to some allocator that
> will chunk it up into pieces that can be allocated by the NIC for
> incoming traffic. I'm thinking genalloc may work for this as-is, but I
> may need to add one or use something else if I run into some issue.
> 
> 3. We can implement a memory_provider that allocates these chunks and
> wraps them in a struct new_abstraction (as David called it) and feeds
> those into the page pool.
> 
> 4. The page pool would need to be able to process these struct
> new_abstraction alongside the struct pages it normally gets from
> providers. This is maybe the most complicated part, but looking at the
> page pool code it doesn't seem that big of a hurdle (but I have not
> tried a POC yet).
> 
> 5. The drivers (I looked at mlx5) seem to avoid making any mm calls on
> the struct pages returned by the pool; the pool abstracts everything
> already. The changes to the drivers may be minimal..?
> 
> 6. We would need to add a new helper, skb_add_rx_new_abstraction_frag
> that creates a frag out of new_abstraction rather than a struct page.
> 
> Once the skb frags with struct new_abstraction are in the TCP stack,
> they will need some special handling in code accessing the frags. But
> my RFC already addressed that somewhat because the frags were
> inaccessible in that case. In this case the frags will be both
> inaccessible and will not be struct pages at all (things like
> get_page() will not work), so more special handling will be required,
> maybe.
> 
> I imagine the TX path would be considerably less complicated because
> the allocator and page pool are not involved (I think).
> 
> Anyone see any glaring issues with this approach?

Moving skb_frags to an alternative scheme is essential to make this
work. The current page scheme to go from user virtual to pages to
physical is not needed for the dmabuf use case.

For the driver and hardware queue: don't you need a dedicated queue for
the flow(s) in question? If not, how can you properly handle the
teardown case (e.g., app crashes and you need to ensure all references
to GPU memory are removed from NIC descriptors)? If you agree on this
point, then you can require the dedicated queue management in the driver
to use and expect only the alternative frag addressing scheme. ie., it
knows the address is not struct page (validates by checking skb flag or
frag flag or address magic), but a reference to say a page_pool entry
(if you are using page_pool for management of the dmabuf slices) which
contains the metadata needed for the use case.
