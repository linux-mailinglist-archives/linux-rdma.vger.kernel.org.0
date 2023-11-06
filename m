Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6847E1D4F
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 10:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjKFJfP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Nov 2023 04:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFJfO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Nov 2023 04:35:14 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4DCC6;
        Mon,  6 Nov 2023 01:35:11 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so2756454a12.1;
        Mon, 06 Nov 2023 01:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699263311; x=1699868111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUxIwNgYxYeAYjrDwbFkOd5K4zOkB6J+xXXt+plx3FU=;
        b=F+4R1ck3Fk5q7+AcL+C2voF0KAufCk3OImZPH11z4yPTl+nQlFpXZo7ZrrGagOxXj3
         dazPUC6sWG5kd0sWvfwFr069pOxk6xohpYaTESjFAVx7ea7ekB7EVFz3ll+Tgn4ecuhY
         a33iuvyOkH3WLVccODw8KOxxrN/WKLus/pAZEF4daTfVFXAqfgOhuaY7GaY/DyyryKVw
         x1r9yS49Yt4jQsSQVwhOrESOX23y+wHSezA7lkT5Y/eAT6VSMjfcYct7XHvslVeQdi+G
         bPyi2jLO/nXULxxyBV4xsuih646RniWYZto5pRxxyhwfVn3EhWsDLDwT5zMagcdX4uUr
         kB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699263311; x=1699868111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUxIwNgYxYeAYjrDwbFkOd5K4zOkB6J+xXXt+plx3FU=;
        b=JayRTy0RvyDzQGto3GRYQWqr+TGEfDTbBw9K6Lwkvha1XBfL5Pyb3NGtL9fRIax7tk
         FVVHZ7wm27bbfybVBucswOScARU11EzDnf0BQ2G0LEYECbs1fUmcBsxhTyegJGlnzE/H
         GmrnGSjXDbGcy+pq9Y4rSRzJ6wXJTB4xHhbsWHfGv4t50ROWcN0hNoNBpVSF4swc2q0S
         9pjaLboIbykUv+T6yMmrziR8Ze/aXX8T1OcegFIoCxd/D3jkUBQ7Phe5qsJyp0CAdq+S
         rHxSHzILmOePv3S6JHekfzEMFtMxwM9fOtvifzdk/nGXDvrSFnG/Olc2MakK0iFG7HmR
         UHYQ==
X-Gm-Message-State: AOJu0YxJbKP4jdosHQThjapu5adbwNzriPxYrrY/qB1suehFBFDwT2qw
        Bw1mnAB1psBq401yKzcn9ieyYcgACJJKdtEMsUo=
X-Google-Smtp-Source: AGHT+IGcqF0mvq2HxxKF5WD2nW+CXxzK7ANlIb5v4fqPN1ow+nYo65zMZ5Vul0wBo+F3heiLeIV/0sNRGIZSkxbtN2w=
X-Received: by 2002:a17:90a:7e8d:b0:280:ff37:8981 with SMTP id
 j13-20020a17090a7e8d00b00280ff378981mr1354704pjl.44.1699263311193; Mon, 06
 Nov 2023 01:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20231103095549.490744-1-lizhijian@fujitsu.com> <27a06d26-4443-4349-801e-c09da0d57884@fujitsu.com>
In-Reply-To: <27a06d26-4443-4349-801e-c09da0d57884@fujitsu.com>
From:   Greg Sword <gregsword0@gmail.com>
Date:   Mon, 6 Nov 2023 17:35:01 +0800
Message-ID: <CAEz=LcuKpkTfGZ44Kf3YamK=roa-OC=j47ZcHeLsuFe+FqOnaA@mail.gmail.com>
Subject: Re: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 6, 2023 at 4:01=E2=80=AFPM Zhijian Li (Fujitsu)
<lizhijian@fujitsu.com> wrote:
>
>
>
> Very thanks for all your feedback.
>
> On 03/11/2023 17:55, Li Zhijian wrote:
> > I don't collect the Reviewed-by to the patch1-2 this time, since i
> > think we can make it better.
> >
> > Patch1-2: Fix kernel panic[1] and benifit to make srp work again.
> >            Almost nothing change from V1.
>
> Quote from Jason:
> "
> > The concept was that the xarray could store anything larger than
> > PAGE_SIZE and the entry would point at the first struct page of the
> > contiguous chunk
> >
> > That looks like it is right, or at least close to right, so lets try
> > to keep it
> "
>
>
> It seems it's okay to access address/memory across pages on RXE even thou=
gh
> we only map the first page.

Do you really make tests in your test environment? Do you have test environ=
ment?
Do you really reproduce this problem in your test environment?
Your patches do not work actually. Please do not send these rubbish patches=
 out.

>
> That also means PAGE_SIZE aligned MR is already supported, so only check
> `if (IS_ALIGNED(page_size, PAGE_SIZE))` is sufficient, right?
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/r=
xe/rxe_mr.c
> index f54042e9aeb2..3755e530e6dc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -234,6 +234,12 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatter=
list *sgl,
>          struct rxe_mr *mr =3D to_rmr(ibmr);
>          unsigned int page_size =3D mr_page_size(mr);
>
> +       if (!IS_ALIGNED(page_size, PAGE_SIZE)) {
> +               rxe_err_mr(mr, "FIXME...\n")
> +               return -EINVAL;
> +       }
> +
>          mr->nbuf =3D 0;
>          mr->page_shift =3D ilog2(page_size);
>          mr->page_mask =3D ~((u64)page_size - 1);
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/s=
w/rxe/rxe_param.h
> index d2f57ead78ad..b1cf1e1c0ce1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -38,7 +38,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int mtu)
>   /* default/initial rxe device parameter settings */
>   enum rxe_device_param {
>          RXE_MAX_MR_SIZE                 =3D -1ull,
> -       RXE_PAGE_SIZE_CAP               =3D 0xfffff000,
> +       RXE_PAGE_SIZE_CAP               =3D 0xffffffff - (PAGE_SIZE - 1),
>          RXE_MAX_QP_WR                   =3D DEFAULT_MAX_VALUE,
>          RXE_DEVICE_CAP_FLAGS            =3D IB_DEVICE_BAD_PKEY_CNTR
>                                          | IB_DEVICE_BAD_QKEY_CNTR
>
>
> * minor cleanup will be done after this.
>
> Thanks
> Zhijian
>
> > Patch3-5: cleanups # newly add
> > Patch6: make RXE support PAGE_SIZE aligned mr # newly add, but not full=
y tested
> >
> > My bad arm64 mechine offten hangs when doing blktests even though i use=
 the
> > default siw driver.
> >
> > - nvme and ULPs(rtrs, iser) always registers 4K mr still don't supporte=
d yet.
> >
> > [1] https://lore.kernel.org/all/CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=3D1zna=
BEnu1usLOciD+g@mail.gmail.com/T/
> >
> > Li Zhijian (6):
> >    RDMA/rxe: RDMA/rxe: don't allow registering !PAGE_SIZE mr
> >    RDMA/rxe: set RXE_PAGE_SIZE_CAP to PAGE_SIZE
> >    RDMA/rxe: remove unused rxe_mr.page_shift
> >    RDMA/rxe: Use PAGE_SIZE and PAGE_SHIFT to extract address from
> >      page_list
> >    RDMA/rxe: cleanup rxe_mr.{page_size,page_shift}
> >    RDMA/rxe: Support PAGE_SIZE aligned MR
> >
> >   drivers/infiniband/sw/rxe/rxe_mr.c    | 80 ++++++++++++++++----------=
-
> >   drivers/infiniband/sw/rxe/rxe_param.h |  2 +-
> >   drivers/infiniband/sw/rxe/rxe_verbs.h |  9 ---
> >   3 files changed, 48 insertions(+), 43 deletions(-)
> >
