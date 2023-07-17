Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5D7559D6
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jul 2023 05:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGQDIW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Jul 2023 23:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGQDIV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Jul 2023 23:08:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1401310C;
        Sun, 16 Jul 2023 20:08:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A69560E55;
        Mon, 17 Jul 2023 03:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49F7C433C7;
        Mon, 17 Jul 2023 03:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689563298;
        bh=DSxcgd+h1hGjsDVfLvnriZE2CKrET78BMSu4MXjeR7M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YTijYacIaCLpeCIu4hFMEWWLRsZeU8gUwVXMB8UgLTTK3K17+3iipTywexQpUR9Rf
         mSDpXwyCUxhaIqhc/oduUcFTSQQFbcBIW/MYnZ26RwP2997OCHeT5mu7AKXsO8ZZyJ
         FFBEDJFA38Gv5aZdq7T21ljBzICWz3BJbje8hndefWaDVVUTtqRR6zgFYbSOd7qbcj
         ne7HNlTnPpCH6jgV8g90LL+dOM4ctEikTxj8SWixcIIEHfHphoJ6JiOm3tN5aRyJPA
         pYQ2F1nGLNmxSeNGyDOH+xhkrH/BDP4j/aog++4OlifwqDe9PvAGS+QFKhXDLqwD2U
         xBtctmPa6qW/w==
Message-ID: <765b02a5-2f09-e744-f441-c082fa3987ff@kernel.org>
Date:   Sun, 16 Jul 2023 21:08:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Hari Ramakrishnan <rharix@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
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
 <9cf3ce79-2d5e-090d-c83e-0c359ace1cb9@kernel.org>
 <CAHS8izOL593X7=9pGaeC1JJ_5hYookZDn7O=fike=e48+myvxA@mail.gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <CAHS8izOL593X7=9pGaeC1JJ_5hYookZDn7O=fike=e48+myvxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/16/23 8:05 PM, Mina Almasry wrote:
>>
>> For the driver and hardware queue: don't you need a dedicated queue for
>> the flow(s) in question?
> 
> In the RFC and the implementation I'm thinking of, the queue is
> 'dedicated' in that each queue will be a devmem TCP queue or a regular
> queue. devmem queues generate devmem skbs and non-devmem queues
> generate non-devmem skbs. We support switching queues between devmem
> mode and non-devmem mode via a uapi.

ethtool APIs or something else?

> 
>> If not, how can you properly handle the
>> teardown case (e.g., app crashes and you need to ensure all references
>> to GPU memory are removed from NIC descriptors)?
> 
> Jason and Christian will correct me if I'm wrong, but AFAICT the
> dma-buf API requires the dma-buf provider to keep the attachment
> mapping alive as long as the importer requires it. The dma-buf API
> gives the importer dma_buf_map_attachment() and
> dma_buf_unmap_attachment() APIs, but there is no callback for the
> exporter to inform the importer that it has to take the mapping away.

Isn't the importer that application that terminated (cleanly or other)?
That was my thinking but I guess there are other designs that can cross
a single application.

> The closest thing I saw was the move_notify() callback, but that is
> optional.
> 
> In my mind the way it works is that there will be some uapi that binds
> a dma-buf to an RX queue, that will create the attachment and the
> mapping. If the user crashes or closes the dma-buf handle then that
> will unbind the dma-buf from the RX queue, but the mapping will remain
> alive (via some refcounting) until all the NIC descriptors are freed
> and the mapping is not under use anymore. Usually this will happen
> next driver reset which destroys and recreates rx queues thereby
> freeing all the NIC descriptors (but could be a new API so that we
> don't rely on a driver reset).
> 
>> If you agree on this
>> point, then you can require the dedicated queue management in the driver
>> to use and expect only the alternative frag addressing scheme. ie., it
>> knows the address is not struct page (validates by checking skb flag or
>> frag flag or address magic), but a reference to say a page_pool entry
>> (if you are using page_pool for management of the dmabuf slices) which
>> contains the metadata needed for the use case.
> 
> Honestly if my understanding above doesn't match what you want, I
> could implement 'dedicated queues' instead, just let me know what you
> want at some future iteration. Now, I'm more worried about this memory
> format issue and I'm working on an RX prototype without struct pages.
> So far purely technically speaking it seems possible.
> 
> 

My comment was only a suggestion on how to simplify driver changes. ie.,
a queue is either pages (based on standard page_pool or alloc_pages) or
some "special" page_pool (ie., new abstraction) but not mixed. In that
case it knows how to handle the overloaded 'address' in skb_frag in a
clean manner.
