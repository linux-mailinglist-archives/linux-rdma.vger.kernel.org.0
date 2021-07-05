Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D06B3BB96C
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 10:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhGEIiO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jul 2021 04:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhGEIiL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jul 2021 04:38:11 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA28C061764
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jul 2021 01:35:34 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 11so20002878oid.3
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jul 2021 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bE2TwyBg816PUwNgOjl18KBHrEiD+EQhA38EIdbPWAk=;
        b=IRmBVl7GWsciqHIECFmzGWZ6NRnVqyCA7TgtSfHhpBFEK+8VSebmJb9ZFw5+NYr6e2
         7WMkSWDNZu2EO8I6YLi9XgLG55hE4srbWeYLntZgWU5cGdfzBOnOF6UXUhvZxxky280F
         6he7q0sBE8LQu01A9ld06cMeLNfNxnW8eqThGL6kkV8d+4NGh0Ut0yan0dz5YHxbhp3b
         0XhHo86VS+VIUyFKT4xDdjA7fKFqiNdLyynS8F+YfauOdbEhdHJWjDJtFyDkGTUc2KZ6
         fAUErU+ALgR1NO6IbMs9tDpVb/ypXRjwryDz9oi27YYFHow+qM+oBKI9jIQeBtgW1Sq4
         cJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bE2TwyBg816PUwNgOjl18KBHrEiD+EQhA38EIdbPWAk=;
        b=LBzyUr9Sf49AyLPd+jDarkHhlnSWCJ6EYvh1pncHGCB+j3P5rk2UgbkvADSaycyLeL
         us23xzIzZ+lllJUOTuoEt0Z517MAu43zwRKiBahxWv6AXI7SZObHHAmLv/7Xgphb9ayb
         z3tUSg517FsyUqzUvSa4budBlhetHM4/lKx5baYPhmeVtrLb6daFl7bbkKltRh/T6IFg
         bGcRQFWOMYq0K7t2x1mbgfUDWgm2szaBFVlUaHLy2g5n28e2gLXCcK+zUqIQHJAQFm0e
         Kao8s0oO1xFQH9y73sIW2Ep82MGk3HzzkTAsf0lewszDEksqRWmKEGuqEWlHjDlOXCtl
         3zvw==
X-Gm-Message-State: AOAM530fgEDjN49D0XA+OqDiF8+jIIXrRNIrbSj1K5Lc67nyK5aV8I/5
        kHbTxLenB/Qd0zxWnQlXZSovWoJWyhbs7doXDfw=
X-Google-Smtp-Source: ABdhPJzzgztxAZW0E21pTkRp4fC4lKChE/tn+iH8Aut780ifKno+XHJImIpyIY0LjQapuaTGvPhB9f4FgXt1yYijY5w=
X-Received: by 2002:a05:6808:10ca:: with SMTP id s10mr4440665ois.163.1625474133727;
 Mon, 05 Jul 2021 01:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210704223506.12795-1-rpearsonhpe@gmail.com> <CAD=hENeHRjL8YhjwWi-dnknFAJeDUyHK3s-TdQf2AF853MHCMw@mail.gmail.com>
 <E55ABD6F-18FB-44FE-B103-3403CFD21274@oracle.com>
In-Reply-To: <E55ABD6F-18FB-44FE-B103-3403CFD21274@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 5 Jul 2021 16:35:22 +0800
Message-ID: <CAD=hENfwA3xEuoQp0O4uxKqeG8-sJsUNOCpcCKNUtSgk_ezepg@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix memory leak in error path code
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "haakon.brugge@oracle.com" <haakon.brugge@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 5, 2021 at 4:16 PM Haakon Bugge <haakon.bugge@oracle.com> wrote=
:
>
>
>
> > On 5 Jul 2021, at 05:42, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> >
> > On Mon, Jul 5, 2021 at 6:37 AM Bob Pearson <rpearsonhpe@gmail.com> wrot=
e:
> >>
> >> In rxe_mr_init_user() in rxe_mr.c at the third error the driver fails =
to
> >> free the memory at mr->map. This patch adds code to do that.
> >> This error only occurs if page_address() fails to return a non zero ad=
dress
> >> which should never happen for 64 bit architectures.
> >
> > If this will never happen for 64 bit architectures, is it possible to
> > exclude 64 bit architecture with some MACROs or others?
> >
> > Thanks,
> >
> > Zhu Yanjun
> >
> >>
> >> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> >> Reported by: Haakon Bugge <haakon.bugge@oracle.com>
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >> ---
> >> drivers/infiniband/sw/rxe/rxe_mr.c | 41 +++++++++++++++++-------------
> >> 1 file changed, 24 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/s=
w/rxe/rxe_mr.c
> >> index 6aabcb4de235..f49baff9ca3d 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> >> @@ -106,20 +106,21 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int acce=
ss, struct rxe_mr *mr)
> >> int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iov=
a,
> >>                     int access, struct rxe_mr *mr)
> >> {
> >> -       struct rxe_map          **map;
> >> -       struct rxe_phys_buf     *buf =3D NULL;
> >> -       struct ib_umem          *umem;
> >> -       struct sg_page_iter     sg_iter;
> >> -       int                     num_buf;
> >> -       void                    *vaddr;
> >> +       struct rxe_map **map;
> >> +       struct rxe_phys_buf *buf =3D NULL;
> >> +       struct ib_umem *umem;
> >> +       struct sg_page_iter sg_iter;
> >> +       int num_buf;
> >> +       void *vaddr;
>
> This white-space stripping must be another issue, not related to the meml=
eak?
>
> >>        int err;
> >> +       int i;
> >>
> >>        umem =3D ib_umem_get(pd->ibpd.device, start, length, access);
> >>        if (IS_ERR(umem)) {
> >> -               pr_warn("err %d from rxe_umem_get\n",
> >> -                       (int)PTR_ERR(umem));
> >> +               pr_warn("%s: Unable to pin memory region err =3D %d\n"=
,
> >> +                       __func__, (int)PTR_ERR(umem));
> >>                err =3D PTR_ERR(umem);
> >> -               goto err1;
> >> +               goto err_out;
> >>        }
> >>
> >>        mr->umem =3D umem;
> >> @@ -129,15 +130,15 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 star=
t, u64 length, u64 iova,
> >>
> >>        err =3D rxe_mr_alloc(mr, num_buf);
> >>        if (err) {
> >> -               pr_warn("err %d from rxe_mr_alloc\n", err);
> >> -               ib_umem_release(umem);
> >> -               goto err1;
> >> +               pr_warn("%s: Unable to allocate memory for map\n",
> >> +                               __func__);
> >> +               goto err_release_umem;
> >>        }
> >>
> >>        mr->page_shift =3D PAGE_SHIFT;
> >>        mr->page_mask =3D PAGE_SIZE - 1;
> >>
> >> -       num_buf                 =3D 0;
> >> +       num_buf =3D 0;
>
> White-space change.

Yeah. It seems that some white-space changes in this commit.

Zhu Yanjun

>
> Otherwise:
>
> Reviewed-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>
>
> Thxs, H=C3=A5kon
>
>
>
> >>        map =3D mr->map;
> >>        if (length > 0) {
> >>                buf =3D map[0]->buf;
> >> @@ -151,10 +152,10 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 star=
t, u64 length, u64 iova,
> >>
> >>                        vaddr =3D page_address(sg_page_iter_page(&sg_it=
er));
> >>                        if (!vaddr) {
> >> -                               pr_warn("null vaddr\n");
> >> -                               ib_umem_release(umem);
> >> +                               pr_warn("%s: Unable to get virtual add=
ress\n",
> >> +                                               __func__);
> >>                                err =3D -ENOMEM;
> >> -                               goto err1;
> >> +                               goto err_cleanup_map;
> >>                        }
> >>
> >>                        buf->addr =3D (uintptr_t)vaddr;
> >> @@ -177,7 +178,13 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start=
, u64 length, u64 iova,
> >>
> >>        return 0;
> >>
> >> -err1:
> >> +err_cleanup_map:
> >> +       for (i =3D 0; i < mr->num_map; i++)
> >> +               kfree(mr->map[i]);
> >> +       kfree(mr->map);
> >> +err_release_umem:
> >> +       ib_umem_release(umem);
> >> +err_out:
> >>        return err;
> >> }
> >>
> >> --
> >> 2.30.2
> >>
>
