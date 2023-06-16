Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB836733B1F
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jun 2023 22:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjFPUnb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jun 2023 16:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjFPUn3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Jun 2023 16:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B133A3AA9
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jun 2023 13:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686948160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NSJLIyj9LMYS53Im9VxxQ75KAnWRMymE9tH9+QGjBNs=;
        b=c2RjwrsRtZ2UodpnaZbHhL1TvE4NnmjHTU8PAXlk+MDxCNF+4KMo8woWaasYPRG/isZm2b
        Jx5UtHLQT7DEuy/lPpUq4RKPj20J2xI8rQp5bsbqbNlITqygBs9z1wkpjNZ/IIQX4JCcPk
        6ACfiwSoN9+sO9psN1htuoJt7FqQyYg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-i7f9PeZtPQO-7F-Cmy8yZQ-1; Fri, 16 Jun 2023 16:42:39 -0400
X-MC-Unique: i7f9PeZtPQO-7F-Cmy8yZQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9875b53be57so300166b.0
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jun 2023 13:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686948158; x=1689540158;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSJLIyj9LMYS53Im9VxxQ75KAnWRMymE9tH9+QGjBNs=;
        b=M5DH5+IRUQrjI9JnsJwvrJO5JI5Et6As/84y1XlEpFIDPeOcCVxzgM6RN8H8opkRBV
         t9HlbBLAkzysw6OZcUnzLjhEc1uWUtz5It/On4gCawa2PJs93gK2KDU8/7LhO1Ey1Ar5
         8rySZDxkoq4pQ7roVwDLJS8RDGXOWQidMNrAxgI0YGfPBEIBXCcKjSs17XcgpNhgR3DU
         bZpZAamJFKOrE8PEckmlJrtrQc0iaJVp6WSno3XGpMei6LaAmEE1mYIuYZUicyzyaf2t
         NqmYR0JJkROy+dlpWmws/E1E1AzCQowehCWnfP2LnY48Kb1N1/YrF+4odj0rcGydT64W
         cH4Q==
X-Gm-Message-State: AC+VfDz7QH6ZrQbmLoKAnRSFeLhsHhB7ha4QyTc3pJ5OBs018L0CNuPJ
        hQRgA9VLfQZL6j8gt4lX9koWtEhto9rpZBD8kVaDevPysqrzfdzxYn0X67jZGHORdWazcQLzlMz
        yzBUsPD97LVyJdWugzfGmlw==
X-Received: by 2002:a17:907:97cb:b0:969:f9e8:a77c with SMTP id js11-20020a17090797cb00b00969f9e8a77cmr2710814ejc.64.1686948158070;
        Fri, 16 Jun 2023 13:42:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ehYaK04S4/TY2b/iTlXKHTkxro6SsSNCPMtcO8/kHNHdFogckXjJZEm+Tpaj5nWU8CSFc3g==
X-Received: by 2002:a17:907:97cb:b0:969:f9e8:a77c with SMTP id js11-20020a17090797cb00b00969f9e8a77cmr2710788ejc.64.1686948157766;
        Fri, 16 Jun 2023 13:42:37 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id b19-20020a170906491300b00985036aced0sm1439806ejq.163.2023.06.16.13.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 13:42:37 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com>
Date:   Fri, 16 Jun 2023 22:42:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
Subject: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
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
In-Reply-To: <20230616122140.6e889357@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 16/06/2023 21.21, Jakub Kicinski wrote:
> On Fri, 16 Jun 2023 20:59:12 +0200 Jesper Dangaard Brouer wrote:
>> +       if (mem_type == MEM_TYPE_PP_NETMEM)
>> +               pp_netmem_put_page(pp, page, allow_direct);
>> +       else
>> +               page_pool_put_full_page(pp, page, allow_direct);
> 
> Interesting, what is the netmem type? I was thinking about extending
> page pool for other mem providers and what came to mind was either
> optionally replacing the free / alloc with a function pointer:
> 
> https://github.com/torvalds/linux/commit/578ebda5607781c0abb26c1feae7ec8b83840768
> 
> or wrapping the PP calls with static inlines which can direct to
> a different implementation completely (like zctap / io_uring zc).
> 

I *LOVE* this idea!!!
It have been my master plan since day-1 to have other mem providers.
Notice how ZC xsk/AF_XDP have it's own memory allocator implementation.

The page_pool was never meant to be the final and best solution, I want
to see other, better and faster solutions competing with page_pool and
maybe some day replacing page_pool (I even see it as a success if PP get
depreciated and remove from the kernel due to a better solution).

See[1] how net/core/xdp.c simply have a switch statement
(is fast, because ASM wise it becomes a jump table):

  [1] 
https://github.com/torvalds/linux/blob/v6.4-rc6/net/core/xdp.c#L382-L402

> Former is better for huge pages, latter is better for IO mem
> (peer-to-peer DMA). I wonder if you have different use case which
> requires a different model :(
> 

I want for the network stack SKBs (and XDP) to support different memory
types for the "head" frame and "data-frags". Eric have described this
idea before, that hardware will do header-split, and we/he can get TCP
data part is another page/frag, making it faster for TCP-streams, but
this can be used for much more.

My proposed use-cases involves more that TCP.  We can easily imagine
NVMe protocol header-split, and the data-frag could be a mem_type that
actually belongs to the harddisk (maybe CPU cannot even read this).  The
same scenario goes for GPU memory, which is for the AI use-case.  IIRC
then Jonathan have previously send patches for the GPU use-case.

I really hope we can work in this direction together,
--Jesper

