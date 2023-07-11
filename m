Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE0A74F9ED
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 23:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGKVjy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 17:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGKVju (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 17:39:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D2170F;
        Tue, 11 Jul 2023 14:39:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1F8861632;
        Tue, 11 Jul 2023 21:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF44BC433CD;
        Tue, 11 Jul 2023 21:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689111588;
        bh=JeYMKVTHpX+mkS2wyDV046rxCvoZrycBAR6v9F7dqzQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BIxi+xqxXbSAAHSDt3HW5sc8s+Bze60OcJfIesLMLzc3ubmdKI+LkzhTB6R385BCP
         ZhuOVwrSSGqlRFzuRdfUliB9xXFKZGpWJHG15yymsWXnC28OMSwPdlipwDoPyC8WaV
         qahwRAi9RNg8YBfqDKMYKzV9b0pgM/uxXj6JTR5iBr+Ev1d7+XD/0PRdNrLF2uuoCB
         AH9nKR1XnLkK2FVLC6O8IE9/rZA7whb6wtYFFvPEGTwU68azvz2XzarsLz99lntKFG
         LFYDygWxhUZbte80d+3b6lTReiohgRpfR+oaqjY/lBz9Jho4pWgrC65B6XcKEjtKng
         vXGneiM3kO1GQ==
Message-ID: <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
Date:   Tue, 11 Jul 2023 15:39:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Mina Almasry <almasrymina@google.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
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
References: <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
 <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <ZKNA9Pkg2vMJjHds@ziepe.ca>
 <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
 <ZKxDZfVAbVHgNgIM@ziepe.ca>
 <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
 <ZKyZBbKEpmkFkpWV@ziepe.ca> <20230711042708.GA18658@lst.de>
 <20230710215906.49514550@kernel.org> <20230711050445.GA19323@lst.de>
 <ZK1FbjG+VP/zxfO1@ziepe.ca> <20230711090047.37d7fe06@kernel.org>
 <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org>
 <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230711133915.03482fdc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/11/23 2:39 PM, Jakub Kicinski wrote:
> On Tue, 11 Jul 2023 10:06:28 -0700 Mina Almasry wrote:
>>>> Any reason not to allow an alternative representation for skb frags than
>>>> struct page?  
>>>
>>> I don't think there's a hard technical reason. We can make it work.  
>>
>> I also think we can switch the representation for skb frags to
>> something else. However - please do correct me if I'm wrong - I don't
>> think that is sufficient for device memory TCP. My understanding is
>> that we also need to modify any NIC drivers that want to use device
>> memory TCP to understand a new memory type, and the page pool as well
>> if that's involved. I think in particular modifying the memory type in
>> all the NIC drivers that want to do device memory TCP is difficult. Do
>> you think this is feasible?
> 
> That's why I was thinking about adding an abstraction between 
> the page pool and the driver. Instead of feeding driver pages
> a new abstraction could feed the driver just an identifier and a PA.

skb frag is currently a bio_vec. Overloading the 'struct page' address
in that struct with another address is easy to do. Requiring a certain
alignment on the address gives you a few low bits to use a flags / magic
/ etc.

Overloading len and offset is not really possible - way too much code is
affected (e.g., iov walking and MSS / TSO segmenting).

ie., you could overload page address with a pointer to an object in your
new abstraction layer and the struct has the other meta data.

typedef struct skb_frag {
	union {
		struct bio_vec bvec;
		struct new_abstraction abs;
	};
} skb_frag_t;

where

struct new_abstraction {
	void *addr,
	unsigned int len;
	unsigned int offset;
};

I have been playing with a similar and it co-exists with the existing
code quite well with the constraint on location of len and offset.

> 
> Whether we want to support fragmentation in that model or not would 
> have to be decided.
> 
> We can take pages from the page pool and feed them to drivers via
> such an API, but drivers need to stop expecting pages.

yes, drivers would have to be updated to understand the new format. A
downside, but again relatively easy to manage.

> 
> That's for data buffers only, obviously. We can keep using pages 
> and raw page pool for headers.

yes.
