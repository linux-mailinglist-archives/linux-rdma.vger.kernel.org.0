Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1573BC11E
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 17:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhGEPnF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jul 2021 11:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhGEPnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jul 2021 11:43:04 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C4BC061574
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jul 2021 08:40:26 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id h5so8560097vsg.12
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jul 2021 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XPlggIX2gmP+FYa4xNaEk+FyTYg9U+QcpsZKg2tvaZc=;
        b=vMpmE9LlK8/x4YObclbiDLaZbw/WUaLRQDDwlaiH1b7w+oa2qDLvEAIe+MxwOzZB8V
         9bL4HMxIv+rpXGK67W0PzM7t9uZBouxSCiMBP+S+O0PAiRla/v0UQFzHO0aYzs4osXhu
         n11qFFKbG2VjsYFfJZhtE6AYw1qvsUmWHI0WYWxWdCjkimCxGpAL5jfqLhP6s2FVMmP4
         fjOlxGS6luInHT6e3Hi3ravZE4yf2zd/6+J4jiaicqg65QS2QE35WDgyiw9qx8RdxdbY
         zjbTvyfJvMC/B/5SXmcIkajypx01beFA7nNjYF+TBw5ccLRptO6ohcx5LkzYvSNuxk7f
         bcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XPlggIX2gmP+FYa4xNaEk+FyTYg9U+QcpsZKg2tvaZc=;
        b=q5OOvzu+Q1r6WFMKgyr73nmd+QyKt4wyt0bW3EwCSpHbdn5Oq/WxmYjawbRrtmaf4F
         PxyjGCeffQiCSSYtBCJt8hPQ5wnJwkV6k/LomNqb9G42pkCFZVtyh4iNGXUkF9FvSYV2
         9W5Xrsd1cH8bzFrnnQoI+gp/Aj0uhQgC5JmLepdfxR3SqvOk5qjaUpn8YRtsd6USncIu
         /IsJDuGXj9+m75+ppr0Y0swKObBN77U1VUZZ6bxUFzEgwn1Jv8p8IjVdfrBQcJghQRsg
         WHpAd3i1TRWPCSELzZdVJcYpKqNbm2sCEQZ4dYuRCH6jOLT0kmO2m/JMhgSeGq/jM7uu
         XtzQ==
X-Gm-Message-State: AOAM530X09ugtn4GW6rTwIGjRERKP3XQyJsU+wm3VEii1F64K7gr05Uc
        U1ShtOkd4nr+zTZjYxswDUogTLMz39SniKJvBEg=
X-Google-Smtp-Source: ABdhPJxgF4J6bJV46RlRVBYQ1c6p4VhNKchWL2eu1MRLpNk1JdDaeUAtwUmx4N7i+QIYbclr/UjHujH0Tbd9AathvOM=
X-Received: by 2002:a67:f518:: with SMTP id u24mr9893036vsn.8.1625499625565;
 Mon, 05 Jul 2021 08:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210704223506.12795-1-rpearsonhpe@gmail.com> <CAD=hENeHRjL8YhjwWi-dnknFAJeDUyHK3s-TdQf2AF853MHCMw@mail.gmail.com>
 <E55ABD6F-18FB-44FE-B103-3403CFD21274@oracle.com> <CAD=hENfwA3xEuoQp0O4uxKqeG8-sJsUNOCpcCKNUtSgk_ezepg@mail.gmail.com>
In-Reply-To: <CAD=hENfwA3xEuoQp0O4uxKqeG8-sJsUNOCpcCKNUtSgk_ezepg@mail.gmail.com>
From:   Robert Pearson <rpearsonhpe@gmail.com>
Date:   Mon, 5 Jul 2021 10:40:14 -0500
Message-ID: <CAFc_bgagW37Z1dNw_3T7h4eQCKTwmJypAWdh5QhnzGNOLrEEZQ@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix memory leak in error path code
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "haakon.brugge@oracle.com" <haakon.brugge@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason has been asking for patches to pass clang-format-patch so I've
been cleaning up the code near functional changes since it doesn't
like extra spaces such as for vertical alignment.

If I could figure out how ib_umem_works there is a chance that it
would fail if it couldn't map all the user space virtual memory into
kernel virtual addresses. But so far I have failed. It's fairly
complex.

Bob

On Mon, Jul 5, 2021 at 3:35 AM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> On Mon, Jul 5, 2021 at 4:16 PM Haakon Bugge <haakon.bugge@oracle.com> wro=
te:
> >
> >
> >
> > > On 5 Jul 2021, at 05:42, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> > >
> > > On Mon, Jul 5, 2021 at 6:37 AM Bob Pearson <rpearsonhpe@gmail.com> wr=
ote:
> > >>
> > >> In rxe_mr_init_user() in rxe_mr.c at the third error the driver fail=
s to
> > >> free the memory at mr->map. This patch adds code to do that.
> > >> This error only occurs if page_address() fails to return a non zero =
address
> > >> which should never happen for 64 bit architectures.
> > >
> > > If this will never happen for 64 bit architectures, is it possible to
> > > exclude 64 bit architecture with some MACROs or others?
> > >
> > > Thanks,
> > >
> > > Zhu Yanjun
> > >
> > >>
> > >> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > >> Reported by: Haakon Bugge <haakon.bugge@oracle.com>
> > >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > >> ---
> > >> drivers/infiniband/sw/rxe/rxe_mr.c | 41 +++++++++++++++++-----------=
--
> > >> 1 file changed, 24 insertions(+), 17 deletions(-)
> > >>
> > >> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband=
/sw/rxe/rxe_mr.c
> > >> index 6aabcb4de235..f49baff9ca3d 100644
> > >> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > >> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > >> @@ -106,20 +106,21 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int ac=
cess, struct rxe_mr *mr)
> > >> int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 i=
ova,
> > >>                     int access, struct rxe_mr *mr)
> > >> {
> > >> -       struct rxe_map          **map;
> > >> -       struct rxe_phys_buf     *buf =3D NULL;
> > >> -       struct ib_umem          *umem;
> > >> -       struct sg_page_iter     sg_iter;
> > >> -       int                     num_buf;
> > >> -       void                    *vaddr;
> > >> +       struct rxe_map **map;
> > >> +       struct rxe_phys_buf *buf =3D NULL;
> > >> +       struct ib_umem *umem;
> > >> +       struct sg_page_iter sg_iter;
> > >> +       int num_buf;
> > >> +       void *vaddr;
> >
> > This white-space stripping must be another issue, not related to the me=
mleak?
> >
> > >>        int err;
> > >> +       int i;
> > >>
> > >>        umem =3D ib_umem_get(pd->ibpd.device, start, length, access);
> > >>        if (IS_ERR(umem)) {
> > >> -               pr_warn("err %d from rxe_umem_get\n",
> > >> -                       (int)PTR_ERR(umem));
> > >> +               pr_warn("%s: Unable to pin memory region err =3D %d\=
n",
> > >> +                       __func__, (int)PTR_ERR(umem));
> > >>                err =3D PTR_ERR(umem);
> > >> -               goto err1;
> > >> +               goto err_out;
> > >>        }
> > >>
> > >>        mr->umem =3D umem;
> > >> @@ -129,15 +130,15 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 st=
art, u64 length, u64 iova,
> > >>
> > >>        err =3D rxe_mr_alloc(mr, num_buf);
> > >>        if (err) {
> > >> -               pr_warn("err %d from rxe_mr_alloc\n", err);
> > >> -               ib_umem_release(umem);
> > >> -               goto err1;
> > >> +               pr_warn("%s: Unable to allocate memory for map\n",
> > >> +                               __func__);
> > >> +               goto err_release_umem;
> > >>        }
> > >>
> > >>        mr->page_shift =3D PAGE_SHIFT;
> > >>        mr->page_mask =3D PAGE_SIZE - 1;
> > >>
> > >> -       num_buf                 =3D 0;
> > >> +       num_buf =3D 0;
> >
> > White-space change.
>
> Yeah. It seems that some white-space changes in this commit.
>
> Zhu Yanjun
>
> >
> > Otherwise:
> >
> > Reviewed-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> >
> >
> > Thxs, H=C3=A5kon
> >
> >
> >
> > >>        map =3D mr->map;
> > >>        if (length > 0) {
> > >>                buf =3D map[0]->buf;
> > >> @@ -151,10 +152,10 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 st=
art, u64 length, u64 iova,
> > >>
> > >>                        vaddr =3D page_address(sg_page_iter_page(&sg_=
iter));
> > >>                        if (!vaddr) {
> > >> -                               pr_warn("null vaddr\n");
> > >> -                               ib_umem_release(umem);
> > >> +                               pr_warn("%s: Unable to get virtual a=
ddress\n",
> > >> +                                               __func__);
> > >>                                err =3D -ENOMEM;
> > >> -                               goto err1;
> > >> +                               goto err_cleanup_map;
> > >>                        }
> > >>
> > >>                        buf->addr =3D (uintptr_t)vaddr;
> > >> @@ -177,7 +178,13 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 sta=
rt, u64 length, u64 iova,
> > >>
> > >>        return 0;
> > >>
> > >> -err1:
> > >> +err_cleanup_map:
> > >> +       for (i =3D 0; i < mr->num_map; i++)
> > >> +               kfree(mr->map[i]);
> > >> +       kfree(mr->map);
> > >> +err_release_umem:
> > >> +       ib_umem_release(umem);
> > >> +err_out:
> > >>        return err;
> > >> }
> > >>
> > >> --
> > >> 2.30.2
> > >>
> >
