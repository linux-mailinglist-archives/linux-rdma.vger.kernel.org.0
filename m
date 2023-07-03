Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94748746141
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jul 2023 19:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGCRQH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jul 2023 13:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjGCRQG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jul 2023 13:16:06 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20417E4C
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jul 2023 10:16:01 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4036bd4fff1so50371cf.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jul 2023 10:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688404560; x=1690996560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2iHJSmnnxF29Ro2K2lEBKDHBSEStuWZBVC+tagVTag=;
        b=47XOYlRJzFahe96ZqkfTmm/uIVH9PurvYcuJt2zic5EN3cnyH18zDOC2xCQbsXHg/L
         MBr2Jj89/s10fPaBK8ONh/qVH7j/ATWqW393YNi0265BIjkPPQxvp0lulXWG6lYjJqxC
         pfOCD5aZyBHRVyZZI92JMrnVt0yKXjXbRkEMQhxo2ndkUYajECq2IgK3/Yeev3o88h4B
         24jQ5T4PDeaC4UtHsgrlhTBPZhU3OyR0pIvCwYtTELkRIwrF6BeyujE8LAs0acdbgI10
         eF2YyczJpJLr4KQdLu9GkOkIA7zyBQifyhaI4Rcvmthi7Yoz5I+Z6u6bhZvZL5cOaCNq
         g4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688404560; x=1690996560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2iHJSmnnxF29Ro2K2lEBKDHBSEStuWZBVC+tagVTag=;
        b=ZVAnIzFhGY9lWbRZ6XoMv0+Hn79SNciwktsOAOG5RjZl8ljL4YQo9BKn4tTa/MA+3M
         ssE9Lhe7t8H3n9NufpEcSDvaWUuo7cJnBcTkRrYj+pFjfVs9wDvhWfIj3znF8STD/Elx
         B/pAY1RltrlTOT03wKDuiUeS7o/VSnrXIwTsQGLzr3Yekpc6697M/AESbttXHNuEgr0C
         Dcst9aUgHfnnT4MoKgNUmMTTMKJTwhCIoPTipzxjnjnfqT3V0isQll3ce4HteM+i0iWw
         E2TCzzD2Lnqc+3bygsVB0ldYhZ3zNLSDaxycI5bGZtT/hM+AcXOi4NXnrn9ScDTesJvu
         UxFw==
X-Gm-Message-State: ABy/qLYKI9WgDJrGPROP8gQeS5/qPsU0bpR6sVPI3UAOP/069YbdNUSp
        nFFd+KbDxOjJkgaGCunKDOwT4AzeL8jhVTM0ZYwqtQ==
X-Google-Smtp-Source: APBJJlEAkEot4YdZ7WBMguqh2+qizaqMNrvnDRoFX8TWve6Wd/8zmhq/dGKscf1MYzgs71C4RNIb3wdeASZ6Vhyhjvc=
X-Received: by 2002:a05:622a:1705:b0:3fa:45ab:22a5 with SMTP id
 h5-20020a05622a170500b003fa45ab22a5mr298105qtk.27.1688404559885; Mon, 03 Jul
 2023 10:15:59 -0700 (PDT)
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
Date:   Mon, 3 Jul 2023 19:15:48 +0200
Message-ID: <CANn89iJLAnnvFfkmJbQ=ZFMwaqiYDOTD3-P+NpkEMzP9aKV-ig@mail.gmail.com>
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

> That is my expectation. The tcpdump is just an easy example of accessing
> the skb page frags. skb_copy_and_csum_bits used by icmp is another
> example that can walk frags wanting access to device memory. You did not
> cause a panic or trip a WARN_ON for example with the tcpdump?
>

ICMP packets do not land on the queues having devmem buffers, for
obvious reasons.

Only chosen TCP flows are steered to these queues.
