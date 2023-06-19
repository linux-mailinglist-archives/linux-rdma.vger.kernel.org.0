Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F8C735D42
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jun 2023 20:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjFSSHK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jun 2023 14:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjFSSHK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jun 2023 14:07:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD9D120;
        Mon, 19 Jun 2023 11:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45EB360DF4;
        Mon, 19 Jun 2023 18:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85C3C433C8;
        Mon, 19 Jun 2023 18:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687198027;
        bh=XNrWx0e+VFb0jaH8wmeXcZNg0osk8eDrh+qYB5nAfyk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hnq0AOiprtBC3qrex4NKnoSCrfoj8sJY8nyfDOYmMWS+LAdWlLROaAKj8NrHdAqKV
         gVhM8EURFdB3wFLNb5+cKug0R7eGHAYnxKLQtws1cQD1w4jy4qo3Hb7J1+QEk+tsBU
         CwaUfd+n40I3VQBfJ115llahzE5XrSWAEPqImjrhQ0Q9+4yBUo9WuCwv+e9Jgp1nFc
         JK4Y6V1bPN+wKsKswtz5r475G3cj3+O1jsBSXMG326is1pnTd64o/YSXvOjdb2TDxy
         /MScaTumbH45kNF4b2HPmMzPaXxYXkmbDyTzbrZl34qcyt4Si2iWxAdohcw8Fn2wxj
         eAVJ5xQrBneyw==
Date:   Mon, 19 Jun 2023 11:07:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     brouer@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
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
Message-ID: <20230619110705.106ec599@kernel.org>
In-Reply-To: <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com>
References: <20230612130256.4572-1-linyunsheng@huawei.com>
        <20230612130256.4572-5-linyunsheng@huawei.com>
        <20230614101954.30112d6e@kernel.org>
        <8c544cd9-00a3-2f17-bd04-13ca99136750@huawei.com>
        <20230615095100.35c5eb10@kernel.org>
        <CAKgT0Uc6Xoyh3Edgt+83b+HTM5j4JDr3fuxcyL9qDk+Wwt9APg@mail.gmail.com>
        <908b8b17-f942-f909-61e6-276df52a5ad5@huawei.com>
        <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
        <72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com>
        <20230616122140.6e889357@kernel.org>
        <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 16 Jun 2023 22:42:35 +0200 Jesper Dangaard Brouer wrote:
> > Former is better for huge pages, latter is better for IO mem
> > (peer-to-peer DMA). I wonder if you have different use case which
> > requires a different model :(
> 
> I want for the network stack SKBs (and XDP) to support different memory
> types for the "head" frame and "data-frags". Eric have described this
> idea before, that hardware will do header-split, and we/he can get TCP
> data part is another page/frag, making it faster for TCP-streams, but
> this can be used for much more.
> 
> My proposed use-cases involves more that TCP.  We can easily imagine
> NVMe protocol header-split, and the data-frag could be a mem_type that
> actually belongs to the harddisk (maybe CPU cannot even read this).  The
> same scenario goes for GPU memory, which is for the AI use-case.  IIRC
> then Jonathan have previously send patches for the GPU use-case.
> 
> I really hope we can work in this direction together,

Perfect, that's also the use case I had in mind. The huge page thing
was just a quick thing to implement as a PoC (although useful in its
own right, one day I'll find the time to finish it, sigh).

That said I couldn't convince myself that for a peer-to-peer setup we
have enough space in struct page to store all the information we need.
Or that we'd get a struct page at all, and not just a region of memory
with no struct page * allocated :S

That'd require serious surgery on the page pool's fast paths to work
around.

I haven't dug into the details, tho. If you think we can use page pool
as a frontend for iouring and/or p2p memory that'd be awesome!

The workaround solution I had in mind would be to create a narrower API
for just data pages. Since we'd need to sprinkle ifs anyway, pull them
up close to the call site. Allowing to switch page pool for a
completely different implementation, like the one Jonathan coded up for
iouring. Basically

$name_alloc_page(queue)
{
	if (queue->pp)
		return page_pool_dev_alloc_pages(queue->pp);
	else if (queue->iouring..)
		...
}
