Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EE3746157
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jul 2023 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjGCRX4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jul 2023 13:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGCRXz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jul 2023 13:23:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D68E5D;
        Mon,  3 Jul 2023 10:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 864F360FD8;
        Mon,  3 Jul 2023 17:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9880BC433C7;
        Mon,  3 Jul 2023 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688405033;
        bh=HqoN+ykT6mcx6CD/Ub4vmYOWlAUj2Sw0KQddslJPPDs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dqWzK3zrOi4s/PD7nVSHt10ysL9pI4UiMx8ZhJMul+Wf8QpZZ7azO7KoaO37KGPnQ
         35M/lCZY9wt2iu31FiNlO2x52ufOgZBw969Ge6Fr4NymYTs10AfFn64i823I6ZSCzU
         ztMgHEeDbyK0BmjQupnqFLgy5+8OAp+k/HM3pFyUEZ0+KmI8c06n2kkSWKQ1VRBlSn
         6KYo0ZBSf7Z6+kMT3VPw9GJ+yOwubUywRMHJA+7aXZRfmlFFtSWHk2liHgoiMqQ3FZ
         IfBKRbp1pVA+AEW2zOdecKTwPEGqJ8PD+mVLsR8d7DfG3pdZzTW+sE6dwAFXLdpRLp
         vKVdtwwgK4mDw==
Message-ID: <011d3204-5c33-782c-41d1-53bf9bd2e095@kernel.org>
Date:   Mon, 3 Jul 2023 11:23:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        brouer@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
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
 <20230619110705.106ec599@kernel.org>
 <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
 <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
 <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <47b79e77-461b-8fe9-41fb-b69a6b205ef2@kernel.org>
 <CANn89iKAvrf92Fy8a_M+V9eya6OHokey2_yxQ3JiCT87fKND_w@mail.gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iKAvrf92Fy8a_M+V9eya6OHokey2_yxQ3JiCT87fKND_w@mail.gmail.com>
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

On 7/3/23 11:13 AM, Eric Dumazet wrote:
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index a2dbeb264f260e5b8923ece9aac99fe19ddfeb62..aa4133d1b1e0676e408499ea4534b51262394432
> 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2152,7 +2152,7 @@ static int packet_rcv(struct sk_buff *skb,
> struct net_device *dev,
>                 }
>         }
> 
> -       snaplen = skb->len;
> +       snaplen = skb->devmem ? skb_headlen(skb) : skb->len;
> 

Ok, so you expect a flag on the skb noting the use of 'untouchable'
memory. That aligns with my expectations based on POCs.

Based on the above: 1) skb->head is expected to be host memory, and 2)
the flag is a global for all frags, so no mix and match.
