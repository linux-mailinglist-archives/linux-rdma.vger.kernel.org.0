Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8705755940
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jul 2023 03:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGQBx7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Jul 2023 21:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGQBx6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Jul 2023 21:53:58 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D39E56
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jul 2023 18:53:56 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-440bc794fcdso1071513137.3
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jul 2023 18:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689558836; x=1692150836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/6R0t0MHhqco+8UDZucjwl/aaBXGVqtQLdiuoDLwso=;
        b=RWXeODKevMU++AlYxd4ioslmKJzbf68u3bThrYPVbGcxKhv8otUEa6+hbfY96qiER5
         yG9zwdlkb9SErmueuzE9OXzmhX3XF70Uh3CVUci1zN7irgoJZCY2yTYuHF04CTbC5fHt
         Pc/GRORNx+QAvX5IXD+KIh2mW27JSn+VxVyXd0luS3z0aDbDsFyEF2foCzIfOmSLv/te
         9EWKMbfGQPjZ9PahTM7UMRyEhmKjXqzwcSvdyiudRatiEGgs4vByaTvCQ6gTCn0Erf+H
         sZWZqUW06jMRXBDzX3FIu9FV3ztdZxqBBPUjYsdjVsyS3aku/QgvFp1ej+qjjR7UmkpC
         B8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689558836; x=1692150836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/6R0t0MHhqco+8UDZucjwl/aaBXGVqtQLdiuoDLwso=;
        b=V0i1pYA6xjjM8W1JPKsHkdcXVWc+fhpZxb0SF2vkhN5TseN9L/o+GizNQ65xuAdg+p
         vrPpWt5V8+4vQCVWxyeaFzdpZZ5uXgR3ciakrEWJC4wozKHm9yZEwM21JlTCpXI1/h3q
         1fHRjGG3EU/ul4vZppjQVQSQsjTQ/Ri9zlipBkt8WZD5HmL7L3jFPzm5dyvRzlQRfvPK
         Pn3b111JGSOr9kNJlSWcest844cLnyJGvG6nS3tyVYa8uEYvjfw6XCK8F3GFKv6pSj64
         /MKhtNxyGNRw8P4zY4h92CJ4VVyOOpAfcNWyDnaO14PVLTi7PElfJUidfSiv/v+UMVRc
         8fjw==
X-Gm-Message-State: ABy/qLYHLWa7MYWnIhA5G9h9aNgdxIRMulxl+c5RDldDmBkrvV85HTuh
        RSMM85Blbel0oZeJp2f9dV59w3/zhApqsikQo1QXMQ==
X-Google-Smtp-Source: APBJJlHOY0MW/V+rSssn0OLz1o8iaRG702aGGIi4O1JDsrONa/dX0S7xy3vLhP7gJGg8cZEpP6lhwBKtRsOeg7xpLmQ=
X-Received: by 2002:a05:6102:a37:b0:445:209:cac7 with SMTP id
 23-20020a0561020a3700b004450209cac7mr4642927vsb.27.1689558835901; Sun, 16 Jul
 2023 18:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org> <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org> <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
 <ZK6kOBl4EgyYPtaD@ziepe.ca> <CAHS8izNuda2DXKTFAov64F7J2_BbMPaqJg1NuMpWpqGA20+S_Q@mail.gmail.com>
 <143a7ca4-e695-db98-9488-84cf8b78cf86@amd.com> <CAHS8izPm6XRS54LdCDZVd0C75tA1zHSu6jLVO8nzTLXCc=H7Nw@mail.gmail.com>
 <ZLFv2PIgdeH8gKmh@ziepe.ca>
In-Reply-To: <ZLFv2PIgdeH8gKmh@ziepe.ca>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sun, 16 Jul 2023 18:53:44 -0700
Message-ID: <CAHS8izNMB-H3w0CE9kj6hT5q_F6_XJy_X_HtZwmisOEDhp31yg@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hari Ramakrishnan <rharix@google.com>,
        David Ahern <dsahern@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 14, 2023 at 8:55=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Jul 14, 2023 at 07:55:15AM -0700, Mina Almasry wrote:
>
> > Once the skb frags with struct new_abstraction are in the TCP stack,
> > they will need some special handling in code accessing the frags. But
> > my RFC already addressed that somewhat because the frags were
> > inaccessible in that case. In this case the frags will be both
> > inaccessible and will not be struct pages at all (things like
> > get_page() will not work), so more special handling will be required,
> > maybe.
>
> It seems sort of reasonable, though there will be interesting concerns
> about coherence and synchronization with generial purpose DMABUFs that
> will need tackling.
>
> Still it is such a lot of churn and weridness in the netdev side, I
> think you'd do well to present an actual full application as
> justification.
>
> Yes, you showed you can stick unordered TCP data frags into GPU memory
> sort of quickly, but have you gone further with this to actually show
> it is useful for a real world GPU centric application?
>
> BTW your cover letter said 96% utilization, the usual server
> configuation is one NIC per GPU, so you were able to hit 1500Gb/sec of
> TCP BW with this?
>

I do notice that the number of NICs is missing from our public
documentation so far, so I will refrain from specifying how many NICs
are on those A3 VMs until the information is public. But I think I can
confirm that your general thinking is correct, the perf that we're
getting is 96.6% line rate of each GPU/NIC pair, and scales linearly
for each NIC/GPU pair we've tested with so far. Line rate of each
NIC/GPU pair is 200 Gb/sec.

So if we have 8 NIC/GPU pairs we'd be hitting 96.6% * 200 * 8 =3D 1545 GB/s=
ec.
If we have, say, 2 NIC/GPU pairs, we'd be hitting 96.6% * 200 * 2 =3D 384 G=
B/sec
...
etc.

--=20
Thanks,
Mina
