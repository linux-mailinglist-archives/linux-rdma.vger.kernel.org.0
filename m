Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F3E3BC121
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhGEPnx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jul 2021 11:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbhGEPnx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jul 2021 11:43:53 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384D1C061574
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jul 2021 08:41:16 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id g24so2853572vsa.10
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jul 2021 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Okkbu66oIV4RbzckPg8cvj1/hvOO+8rAVG5bvjkfInU=;
        b=HRnORnht4kr4orp3q4hUSpZzy8Q5Z6smm3UjCcMEFcKsj80y7wpjQ6hLIqt1zZFwJZ
         7WOP56M6h+f5ESWFwWXf9LP6hrakKA9H76YCwd2Ozdm/ooH1zYdiRIBz/80o9XAsgCaB
         IPnRDRPh6Tx57QpLGHVvkUV6e1Lpn25T+PioZJliL0/Z1/tyqnRrbI4ylxNNCC9CjKPq
         Aofd0Hv9Y4nFPwUFzxM8Zs5pgFPh7bpiT+looQCJdiBl5/3L/qjWazqGWozUeOUgOMZw
         rdCtnAcfYL0bJgv2lbQL9kiK3vmz52EImCChyLvsiYvhgqVxqU7de0ywAqPKETZRVGGi
         4g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Okkbu66oIV4RbzckPg8cvj1/hvOO+8rAVG5bvjkfInU=;
        b=O5NbW57b5c+KFE4/kLwC7gFfjBXurQr3ZS3bjI9BY1PAudtYrCkdtyMN5XVHZglH+p
         hcmyVbpGGsIVPdgjLRb+7YsDanilFFS4DyJbTrRqTI1i372zHSx1x1pe2F3aZ+lQCs6B
         b9csCE5or29cMmfFV5enftbI3bq4SQ6URdzE6pqccWez0dYcUURX2kTe5HGE4739md4b
         cfugGjFkF6qlGjO4nGheHGn5XURT2I0Oy9bJ5nG8Z6jpu9dQ8CE8jP+bcVPx7XVJZLuP
         Mk6/eS2xdpXcrI+Nie6hKPvd3seNwMiVY/oVuyflQbOcIl/Ecwc1MUJYC4ul7nEW8cG2
         aLUQ==
X-Gm-Message-State: AOAM533duF32ecdgCgB/3XJE6R9flBeBenwcmGcRUpTzBkqfSNaL2blw
        n4flQsBkYINRBKS8WbAuT5GIWohpSKE0BvsCh3Q=
X-Google-Smtp-Source: ABdhPJzlWLPwumLMY4B1zk04/DuBY8UTCtCOkpPnACVCsA7XGk87crE/itdAvmR5/WcBmshiJWMN778PFyq+5iZlhiU=
X-Received: by 2002:a67:4385:: with SMTP id q127mr4782473vsa.39.1625499675467;
 Mon, 05 Jul 2021 08:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210704223506.12795-1-rpearsonhpe@gmail.com> <CAD=hENeHRjL8YhjwWi-dnknFAJeDUyHK3s-TdQf2AF853MHCMw@mail.gmail.com>
 <E55ABD6F-18FB-44FE-B103-3403CFD21274@oracle.com> <CAD=hENfwA3xEuoQp0O4uxKqeG8-sJsUNOCpcCKNUtSgk_ezepg@mail.gmail.com>
 <CAFc_bgagW37Z1dNw_3T7h4eQCKTwmJypAWdh5QhnzGNOLrEEZQ@mail.gmail.com>
In-Reply-To: <CAFc_bgagW37Z1dNw_3T7h4eQCKTwmJypAWdh5QhnzGNOLrEEZQ@mail.gmail.com>
From:   Robert Pearson <rpearsonhpe@gmail.com>
Date:   Mon, 5 Jul 2021 10:41:04 -0500
Message-ID: <CAFc_bgbxCaDQ1EbdOhKbNJ8z38YphzE3e6_CWtpz7o-hCeWoZA@mail.gmail.com>
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

Sorry that was ib_umem_get().

On Mon, Jul 5, 2021 at 10:40 AM Robert Pearson <rpearsonhpe@gmail.com> wrot=
e:
>
> Jason has been asking for patches to pass clang-format-patch so I've
> been cleaning up the code near functional changes since it doesn't
> like extra spaces such as for vertical alignment.
>
> If I could figure out how ib_umem_works there is a chance that it
> would fail if it couldn't map all the user space virtual memory into
> kernel virtual addresses. But so far I have failed. It's fairly
> complex.
>
> Bob
>
> On Mon, Jul 5, 2021 at 3:35 AM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> >
> > On Mon, Jul 5, 2021 at 4:16 PM Haakon Bugge <haakon.bugge@oracle.com> w=
rote:
> > >
> > >
> > >
> > > > On 5 Jul 2021, at 05:42, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> > > >
> > > > On Mon, Jul 5, 2021 at 6:37 AM Bob Pearson <rpearsonhpe@gmail.com> =
wrote:
> > > >>
> > > >> In rxe_mr_init_user() in rxe_mr.c at the third error the driver fa=
ils to
> > > >> free the memory at mr->map. This patch adds code to do that.
> > > >> This error only occurs if page_address() fails to return a non zer=
o address
> > > >> which should never happen for 64 bit architectures.
> > > >
> > > > If this will never happen for 64 bit architectures, is it possible =
to
> > > > exclude 64 bit architecture with some MACROs or others?
> > > >
> > > > Thanks,
> > > >
> > > > Zhu Yanjun
> > > >
> > > >>
> > > >> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > > >> Reported by: Haakon Bugge <haakon.bugge@oracle.com>
> > > >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > > >> ---
> > > >> drivers/infiniband/sw/rxe/rxe_mr.c | 41 +++++++++++++++++---------=
----
> > > >> 1 file changed, 24 insertions(+), 17 deletions(-)
> > > >>
> > > >> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniba=
nd/sw/rxe/rxe_mr.c
> > > >> index 6aabcb4de235..f49baff9ca3d 100644
> > > >> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > > >> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > > >> @@ -106,20 +106,21 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int =
access, struct rxe_mr *mr)
> > > >> int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64=
 iova,
> > > >>                     int access, struct rxe_mr *mr)
> > > >> {
> > > >> -       struct rxe_map          **map;
> > > >> -       struct rxe_phys_buf     *buf =3D NULL;
> > > >> -       struct ib_umem          *umem;
> > > >> -       struct sg_page_iter     sg_iter;
> > > >> -       int                     num_buf;
> > > >> -       void                    *vaddr;
> > > >> +       struct rxe_map **map;
> > > >> +       struct rxe_phys_buf *buf =3D NULL;
> > > >> +       struct ib_umem *umem;
> > > >> +       struct sg_page_iter sg_iter;
> > > >> +       int num_buf;
> > > >> +       void *vaddr;
> > >
> > > This white-space stripping must be another issue, not related to the =
memleak?
> > >
> > > >>        int err;
> > > >> +       int i;
> > > >>
> > > >>        umem =3D ib_umem_get(pd->ibpd.device, start, length, access=
);
> > > >>        if (IS_ERR(umem)) {
> > > >> -               pr_warn("err %d from rxe_umem_get\n",
> > > >> -                       (int)PTR_ERR(umem));
> > > >> +               pr_warn("%s: Unable to pin memory region err =3D %=
d\n",
> > > >> +                       __func__, (int)PTR_ERR(umem));
> > > >>                err =3D PTR_ERR(umem);
> > > >> -               goto err1;
> > > >> +               goto err_out;
> > > >>        }
> > > >>
> > > >>        mr->umem =3D umem;
> > > >> @@ -129,15 +130,15 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 =
start, u64 length, u64 iova,
> > > >>
> > > >>        err =3D rxe_mr_alloc(mr, num_buf);
> > > >>        if (err) {
> > > >> -               pr_warn("err %d from rxe_mr_alloc\n", err);
> > > >> -               ib_umem_release(umem);
> > > >> -               goto err1;
> > > >> +               pr_warn("%s: Unable to allocate memory for map\n",
> > > >> +                               __func__);
> > > >> +               goto err_release_umem;
> > > >>        }
> > > >>
> > > >>        mr->page_shift =3D PAGE_SHIFT;
> > > >>        mr->page_mask =3D PAGE_SIZE - 1;
> > > >>
> > > >> -       num_buf                 =3D 0;
> > > >> +       num_buf =3D 0;
> > >
> > > White-space change.
> >
> > Yeah. It seems that some white-space changes in this commit.
> >
> > Zhu Yanjun
> >
> > >
> > > Otherwise:
> > >
> > > Reviewed-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> > >
> > >
> > > Thxs, H=C3=A5kon
> > >
> > >
> > >
> > > >>        map =3D mr->map;
> > > >>        if (length > 0) {
> > > >>                buf =3D map[0]->buf;
> > > >> @@ -151,10 +152,10 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 =
start, u64 length, u64 iova,
> > > >>
> > > >>                        vaddr =3D page_address(sg_page_iter_page(&s=
g_iter));
> > > >>                        if (!vaddr) {
> > > >> -                               pr_warn("null vaddr\n");
> > > >> -                               ib_umem_release(umem);
> > > >> +                               pr_warn("%s: Unable to get virtual=
 address\n",
> > > >> +                                               __func__);
> > > >>                                err =3D -ENOMEM;
> > > >> -                               goto err1;
> > > >> +                               goto err_cleanup_map;
> > > >>                        }
> > > >>
> > > >>                        buf->addr =3D (uintptr_t)vaddr;
> > > >> @@ -177,7 +178,13 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 s=
tart, u64 length, u64 iova,
> > > >>
> > > >>        return 0;
> > > >>
> > > >> -err1:
> > > >> +err_cleanup_map:
> > > >> +       for (i =3D 0; i < mr->num_map; i++)
> > > >> +               kfree(mr->map[i]);
> > > >> +       kfree(mr->map);
> > > >> +err_release_umem:
> > > >> +       ib_umem_release(umem);
> > > >> +err_out:
> > > >>        return err;
> > > >> }
> > > >>
> > > >> --
> > > >> 2.30.2
> > > >>
> > >
