Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25169749301
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jul 2023 03:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjGFBTP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 21:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjGFBTO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 21:19:14 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8661B6
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jul 2023 18:19:12 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-784f7f7deddso70910241.3
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jul 2023 18:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688606351; x=1691198351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG5qEwxagC4+ySUQRGnCqzQVgx8YJDmgKYEwBwBbHi8=;
        b=WMb9JUkj68NIqA151cJeWq+K4uPDzjvVMzwUNQ7V4uLik7F/mwPqb/9E7uaaVRzJL0
         0M3W+l5Wpg0NYKNut4knANvMOjAKPnUYPjvDyDIHQFnFHedjDJQwlvzVdCtfTKIXcA0G
         cFwY++6voTGFWrrbQDYteX0eT/EnnSZjfyyd3g6fjfrkkXoYRonL+Da3UeqGgWhFXHYg
         oW1v42NaF0AE5lnAh7MhvFF9ChNcLvl9h2zEoae33BSI4GvprdIhWxlQzumISRkjVFJ3
         kugXVSyaSsJBiJzwPFA2NFjjIoo85T3VCqcRJB1qMAYJ6Py2B6ZA5ytZTNSXX4WAKvsA
         +KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688606351; x=1691198351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG5qEwxagC4+ySUQRGnCqzQVgx8YJDmgKYEwBwBbHi8=;
        b=aDFFZSz32d0BIfN7sTJkpq0Erezg7OW2eKGssFk0duGVN/18w5whBOztciZ4VfmGSo
         nF61A2+NOMX8zDUe+u55vF6NhKJfszkgUKmrkJDzgTzzfPvhMXbyCY5w/ZYTzH753naL
         CXAzoIcFBYuCqv4gZFvwxJK2lP9bl7pfeS60KodsxZ3/MprlwN1bvB6P1WDgkhM5+a3F
         2Ulb9CeueOUe+vZT0PFVytlMrLskRlftE2E+fHO5F1XG2hRULdqbkI2W+HVGGk7pph9C
         D8ksyVPetO9sp6iidqIwNosJsTSVZMJCI9XkmRSwXdsblw2VJQafqfQ4wPt8L3IGBqq7
         mNlw==
X-Gm-Message-State: ABy/qLYF+xeTNKCkPE4FqZeRP49lufAqSJ19kP/jWGp+sr7ZKAelEmbu
        ZeH+Etl+LOecCHNqAKClywq2nvPIFBkZWp5MmpEamA==
X-Google-Smtp-Source: APBJJlHTpxzJQ8qMkls8/kIG3QOBs1ceFkXZ5NSrihcQZjqbTz7tGm96dN/xChDtfBDJkv3zbfLFcn2Iuq8tSQKFcC4=
X-Received: by 2002:a67:e989:0:b0:443:90ff:c691 with SMTP id
 b9-20020a67e989000000b0044390ffc691mr600930vso.13.1688606351586; Wed, 05 Jul
 2023 18:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230612130256.4572-1-linyunsheng@huawei.com> <20230612130256.4572-5-linyunsheng@huawei.com>
 <20230614101954.30112d6e@kernel.org> <8c544cd9-00a3-2f17-bd04-13ca99136750@huawei.com>
 <20230615095100.35c5eb10@kernel.org> <CAKgT0Uc6Xoyh3Edgt+83b+HTM5j4JDr3fuxcyL9qDk+Wwt9APg@mail.gmail.com>
 <908b8b17-f942-f909-61e6-276df52a5ad5@huawei.com> <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
 <72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com> <20230616122140.6e889357@kernel.org>
 <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com> <20230619110705.106ec599@kernel.org>
 <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
 <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org> <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <47b79e77-461b-8fe9-41fb-b69a6b205ef2@kernel.org> <CANn89iKAvrf92Fy8a_M+V9eya6OHokey2_yxQ3JiCT87fKND_w@mail.gmail.com>
 <011d3204-5c33-782c-41d1-53bf9bd2e095@kernel.org>
In-Reply-To: <011d3204-5c33-782c-41d1-53bf9bd2e095@kernel.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 5 Jul 2023 18:19:00 -0700
Message-ID: <CAHS8izPF7WjMKLA82fy5LjE9XzUWNVMgs9tD7JM5UY3xfw93Yw@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To:     David Ahern <dsahern@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
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

On Mon, Jul 3, 2023 at 10:23=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 7/3/23 11:13 AM, Eric Dumazet wrote:
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index a2dbeb264f260e5b8923ece9aac99fe19ddfeb62..aa4133d1b1e0676e408499e=
a4534b51262394432
> > 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -2152,7 +2152,7 @@ static int packet_rcv(struct sk_buff *skb,
> > struct net_device *dev,
> >                 }
> >         }
> >
> > -       snaplen =3D skb->len;
> > +       snaplen =3D skb->devmem ? skb_headlen(skb) : skb->len;
> >
>
> Ok, so you expect a flag on the skb noting the use of 'untouchable'
> memory. That aligns with my expectations based on POCs.
>
> Based on the above: 1) skb->head is expected to be host memory, and 2)
> the flag is a global for all frags, so no mix and match.

Yes, both are correct (i.e. what I plan to propose).

--=20
Thanks,
Mina
