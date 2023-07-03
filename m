Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7942746135
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jul 2023 19:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGCRNe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jul 2023 13:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGCRNc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jul 2023 13:13:32 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA580B2
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jul 2023 10:13:31 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-401f4408955so407721cf.1
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jul 2023 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688404411; x=1690996411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHhUcDMJ3GqqYqX8PUUmG05Gp9eg0kW+H85LcvU0FfM=;
        b=pcu1plunE/NwYXd0zKabq0kXC4lBKk8tohnsKuaUuvE/HlEsyL08J8Rrncb6tdHXMG
         cmz9bCoXUDR/JwJsqsmr71QjeYmcARqtrt1DQSYI9zPV/Sf5pJYJl6xLdKaxJCKOgvFr
         tnh9hlLbsw7q44xoXUaYM2Dl0zsM+CLmFGB60IzLiGOE4Gp49zPEcLGoPRuAw7HPala5
         LXBec5FoBaHgoeX5sfQUdYjUsvGaUbSYJ1wRZy1H8aMdOztF5ksEydpAKeoXbOIbsEEp
         30O8WuSAIYDTIkOI+/A0q8zA+SIzSI2JSocnTIfxpIswqs5WknnfbaYV8cHM0P31259d
         HXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688404411; x=1690996411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHhUcDMJ3GqqYqX8PUUmG05Gp9eg0kW+H85LcvU0FfM=;
        b=dKcDpGNq8cMygE7kNyRCLTSf8wFtDfnTMKoNuDf7hjKIICoI4beF1316Fsfp66c6l1
         F4FmX4OdPEueGy2nfMY80/IBIFz1Qo/cImruUvTbGqXQ7qEXKTEf1c8IJDfTsnkofOq/
         W4FMj4LutU3a8CBwwy57cQ+ByaRy9Qgw57tnZlw03f+ZrtPSQS9QQL8rHrBdpJPdTPRM
         oGPF+VgIATUXJ7KZzyVzgL/9YBI8EvGjXm3rQebSTSp5U1YpuECQ+BQSLlK1HDqNWvTY
         VMOUM/zqQ3MXzhUA7Rv/YRMF9WacZWJEOZnc7R6mLQqbYxPR3MOcKJKNMB95Yra7paVD
         TSNQ==
X-Gm-Message-State: ABy/qLa1oiyOkh7vZKdoHk1JSr03mhXGjmgzTf/CX2CsXQJ7aB0kdHyD
        fX09WVCQnLEM31AkJWTLNefamryTO/T1+d7QL0GG+g==
X-Google-Smtp-Source: APBJJlGYc95qxttE9/8PAmxKfxDwWHEqgj+xMhW5O9ooJIFZZ/PHyQ6aNbFx0eU2JgiJSidSG/eG84BaW6wvypRKK3A=
X-Received: by 2002:ac8:574c:0:b0:3e8:684b:195d with SMTP id
 12-20020ac8574c000000b003e8684b195dmr44qtx.10.1688404410592; Mon, 03 Jul 2023
 10:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230612130256.4572-1-linyunsheng@huawei.com> <20230612130256.4572-5-linyunsheng@huawei.com>
 <20230614101954.30112d6e@kernel.org> <8c544cd9-00a3-2f17-bd04-13ca99136750@huawei.com>
 <20230615095100.35c5eb10@kernel.org> <CAKgT0Uc6Xoyh3Edgt+83b+HTM5j4JDr3fuxcyL9qDk+Wwt9APg@mail.gmail.com>
 <908b8b17-f942-f909-61e6-276df52a5ad5@huawei.com> <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
 <72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com> <20230616122140.6e889357@kernel.org>
 <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com> <20230619110705.106ec599@kernel.org>
 <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
 <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org> <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <47b79e77-461b-8fe9-41fb-b69a6b205ef2@kernel.org>
In-Reply-To: <47b79e77-461b-8fe9-41fb-b69a6b205ef2@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 3 Jul 2023 19:13:19 +0200
Message-ID: <CANn89iKAvrf92Fy8a_M+V9eya6OHokey2_yxQ3JiCT87fKND_w@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To:     David Ahern <dsahern@kernel.org>
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

On Mon, Jul 3, 2023 at 4:45=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 7/3/23 12:22 AM, Mina Almasry wrote:
> > tcpdump is able to access the header of these skbs which is in host
> > memory, but not the payload in device memory. Here is an example
> > session with my netcat-like test for device memory TCP:
> > https://pastebin.com/raw/FRjKf0kv
> >
> > tcpdump seems to work, and the length of the packets above is correct.
> > tcpdump -A however isn't able to print the payload of the packets:
> > https://pastebin.com/raw/2PcNxaZV
>
> That is my expectation. The tcpdump is just an easy example of accessing
> the skb page frags. skb_copy_and_csum_bits used by icmp is another
> example that can walk frags wanting access to device memory. You did not
> cause a panic or trip a WARN_ON for example with the tcpdump?
>

Change for af_packet was not too hard :)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a2dbeb264f260e5b8923ece9aac99fe19ddfeb62..aa4133d1b1e0676e408499ea453=
4b51262394432
100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2152,7 +2152,7 @@ static int packet_rcv(struct sk_buff *skb,
struct net_device *dev,
                }
        }

-       snaplen =3D skb->len;
+       snaplen =3D skb->devmem ? skb_headlen(skb) : skb->len;

        res =3D run_filter(skb, sk, snaplen);
        if (!res)
@@ -2275,7 +2275,7 @@ static int tpacket_rcv(struct sk_buff *skb,
struct net_device *dev,
                }
        }

-       snaplen =3D skb->len;
+       snaplen =3D skb->devmem ? skb_headlen(skb) : skb->len;

        res =3D run_filter(skb, sk, snaplen);
        if (!res)


And a generic change in pskb_may_pull() ( __pskb_pull_tail() more
exactly) was enough to cover most other cases.
