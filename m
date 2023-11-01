Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E67C7DDA6D
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Nov 2023 01:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347108AbjKAA6m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Oct 2023 20:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345029AbjKAA6l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Oct 2023 20:58:41 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D28EA;
        Tue, 31 Oct 2023 17:58:39 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7af20c488so62205647b3.1;
        Tue, 31 Oct 2023 17:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698800318; x=1699405118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uj554YOjyGP71pf67W1im7zL3DTNLKFkfwkK7w8hWs=;
        b=Ck3j7Aj8QNdJgZCK1uGaDbzvROTctwaV4Rc1lFhRE/e5SAWT8p4CRYd6NhS1HT3gfO
         NIwyHJjfmAEcZdan5IG8pvXolr8FoNA0rnTjZTloI+qjgJ7sZBFyuiNQ48r6xyiEfMiR
         ia7RDoom6ppOqExloqXRyaN2zLXiwwwUsgnj1uaDqq3bYflOyDW+2iwlCIw0ZJiAbJl6
         95U2IPVTBteYBs34ZRBWc19XkqL8ymwsrIjBqx6wtxAPskbXqmHwnTW/2wsRnOgT1fb3
         /IUL+MgJ+6bQT1zj/AtsGrAL2SfN/GMUz75CMQVMq63gBlJtrQJWeP7zaQCmet9oa6oL
         x8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698800318; x=1699405118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uj554YOjyGP71pf67W1im7zL3DTNLKFkfwkK7w8hWs=;
        b=GpX9jnijTbfgLFX5LJNODqisVX+ajqAQlNDRIVuvlc7oPGnLZV4PkJ7SSmVH9hxWH6
         A1vn3O42v/AkO55xePj/JWQX3GURvEHjqHRvsl2py0chYrV/GyXWlkoERzKq5vqD6TeB
         NYedc95Q58OhD2RQ4yhnt/MkV9EsaYOeX19Aq2RnlVBUKt94DY3HkZJpup3bgkBKu56k
         AWmI0x55UlP8qtrgbYP7a1dER3aF0q3NxOKPNSqDmWSJfEygvWVLj8VkzJm/9bXMb+GC
         slfsGDieQHWqkx/J8iX+R3Nzjp7bCLIcvpOKbk+KTf9rk9rgIh3pvX/7utjjDQJrW7hg
         eFcw==
X-Gm-Message-State: AOJu0YxKsxQMtNpytyg1ZMm8ruxn/rwwxlFMJQ5Wn6Z/HqMetQKDFnso
        D7YR9zwlSLm5F7gCVrz491ckCmC0JG295QFEKsY=
X-Google-Smtp-Source: AGHT+IH5oH4R944TROmJCQC1AZaczdyUL1KEFb5zeDyn1AKEeiyYMbYdFhE1sqG+JaWtgwiQPzUL+33K28ZbYLV3e8A=
X-Received: by 2002:a0d:ca93:0:b0:5af:b0ca:6951 with SMTP id
 m141-20020a0dca93000000b005afb0ca6951mr14812485ywd.40.1698800318627; Tue, 31
 Oct 2023 17:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
 <4da48f85-a72f-4f6b-900f-fc293d63b5ae@fujitsu.com> <20231030124041.GE691768@ziepe.ca>
 <7c5dd149-395a-46a2-96a0-89c182105eaf@linux.dev> <20231031131928.GH691768@ziepe.ca>
In-Reply-To: <20231031131928.GH691768@ziepe.ca>
From:   Greg Sword <gregsword0@gmail.com>
Date:   Wed, 1 Nov 2023 08:58:27 +0800
Message-ID: <CAEz=LcsoDbGmTmVmGyPbcoFjahyf-ruuddjbSXE2W5EH9KDtmA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 31, 2023 at 9:19=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Oct 31, 2023 at 04:52:23PM +0800, Zhu Yanjun wrote:
> > =E5=9C=A8 2023/10/30 20:40, Jason Gunthorpe =E5=86=99=E9=81=93:
> > > On Mon, Oct 30, 2023 at 07:51:41AM +0000, Zhijian Li (Fujitsu) wrote:
> > > >
> > > >
> > > > On 27/10/2023 13:41, Li Zhijian wrote:
> > > > > mr->page_list only encodes *page without page offset, when
> > > > > page_size !=3D PAGE_SIZE, we cannot restore the address with a wr=
ong
> > > > > page_offset.
> > > > >
> > > > > Note that this patch will break some ULPs that try to register 4K
> > > > > MR when PAGE_SIZE is not 4K.
> > > > > SRP and nvme over RXE is known to be impacted.
> > > > >
> > > > > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > > > > ---
> > > > >    drivers/infiniband/sw/rxe/rxe_mr.c | 6 ++++++
> > > > >    1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infinib=
and/sw/rxe/rxe_mr.c
> > > > > index f54042e9aeb2..61a136ea1d91 100644
> > > > > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > > > > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > > > > @@ -234,6 +234,12 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct=
 scatterlist *sgl,
> > > > >         struct rxe_mr *mr =3D to_rmr(ibmr);
> > > > >         unsigned int page_size =3D mr_page_size(mr);
> > > > > +       if (page_size !=3D PAGE_SIZE) {
> > > >
> > > > It seems this condition is too strict, it should be:
> > > >   if (!IS_ALIGNED(page_size, PAGE_SIZE))
> > > >
> > > > So that, page_size with (N * PAGE_SIZE) can work as previously.
> > > > Because the offset(mr.iova & page_mask) will get lost only when !IS=
_ALIGNED(page_size, PAGE_SIZE)
> > >
> > > That makes sense
> >
> > I read all the discussions very carefully.
> >
> > Thanks, Greg.
> >
> > Because RXE only supports PAGE_SIZE, when CONFIG_ARM64_64K_PAGES is ena=
bled,
> > the PAGE_SIZE is 64K, when CONFIG_ARM64_64K_PAGES is disabled, PAGE_SIZ=
E is
> > 4K.
> >
> > But NVMe calls ib_map_mr_sg with a fixed size SZ_4K. When
> > CONFIG_ARM64_64K_PAGES is enabled, it is still 4K. This is not a proble=
m in
> > RXE. This problem is in NVMe.
>
> Maybe, but no real RDMA devices don't support 4K.
>
> The xarray conversion may need revision to use physical addresses
> instead of storing struct pages so it can handle this kind of
> segmentation.

This problem can not be fixed until rxe supports multiple page sizes
including 4K page size.
Now it is not fixed. It is an intermediate way.

>
> Certainly in the mean time it should be rejected.
>
> Jason
