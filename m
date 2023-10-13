Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BAB7C871A
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjJMNoJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Oct 2023 09:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjJMNoI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Oct 2023 09:44:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF858BE
        for <linux-rdma@vger.kernel.org>; Fri, 13 Oct 2023 06:44:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32799639a2aso1940104f8f.3
        for <linux-rdma@vger.kernel.org>; Fri, 13 Oct 2023 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697204645; x=1697809445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uN4YAkYDkkuCC6532BFDX0YQ/wROQtcx9CvVYbkuRV4=;
        b=Il0wSjFY5xa6K34MzBAVybcKMghDf/NbsoQULB7RzU6abr3yMnkrUgxcngBwu8Ghq7
         QLGhuxD0V3G82bMs/YLQGJTE4J5o509iSQSRzGJ9T3nWdLuh0/Kch7oNlvNDB5gE4xGj
         MGj5TKVyJxZcTSeRyhB19nKKC9api4wV43MUr0EhPM41lYf41w586JeGOrPX/Rhtka6m
         0mxqa17J4crysIMU+IxCPwe/g5cSiNxfB0InjO4wbhJmEd6BjIbEvN3zoEL8UxX+4ZnX
         F5qe8euHi6YV1nplTSYJNpqouP8fsd1ghk4jcsQbxvo9TbxU8XJHNEkbfXkgQVaTucGU
         FiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697204645; x=1697809445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN4YAkYDkkuCC6532BFDX0YQ/wROQtcx9CvVYbkuRV4=;
        b=QeLqXoYUAKCjU8TWqiuDkxX1dJhk/a4sSLCZ3L1J8Ql0dKheZevl2kj0lkqIgdycPR
         E383yCX/n6otqxfNCji+T1MJhE5pWhs5bqZt8x5oXope7orZFRFrhZj91rQtFtF2RrKl
         l9xrnVe8jwl/QQFHANtRVKFPADNPNOypuL4cRkzbOhPz7DQx6DFroFSr/BqXhM3Q4MdU
         zK8h03zvI0wwhX+kBvWrHC/VL7d8xZQJ/Xi5BEiun7mN20xKrLjRhQV778PZYnIuMl3b
         Ds7zgIvznhBbwabLGkzCkPlJfD8SIfSeQ5NqmuBHgJB5PjIjVCZ3tVA2Hi9xmWdvuSTz
         /s0w==
X-Gm-Message-State: AOJu0YyKKS5zaT0o4qSDv2d/cHsLSg2oFJeCRX7UuZls2ud0FsBBUOvT
        KWooNMjY4YP8j2WqXEzvfCwVkcnlYDxBq8zeTok=
X-Google-Smtp-Source: AGHT+IHJpoNsRMaKDK6oO/qSP5n8bJbHr4zfPe0lpqGWbs+6103ppXLuKdVyS28QqrauuP9pbesv7RUQ9fLq4W18Ltc=
X-Received: by 2002:a5d:558c:0:b0:32d:a042:3b49 with SMTP id
 i12-20020a5d558c000000b0032da0423b49mr830368wrv.56.1697204644912; Fri, 13 Oct
 2023 06:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231013011803.70474-1-yanjun.zhu@intel.com> <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <6f155aa3-8e75-40c5-9686-cad9f9ac0d81@linux.dev> <OS3PR01MB986557755D5DE20BB7BD60ECE5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
In-Reply-To: <OS3PR01MB986557755D5DE20BB7BD60ECE5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
From:   Rain River <rain.1986.08.12@gmail.com>
Date:   Fri, 13 Oct 2023 09:44:07 -0400
Message-ID: <CAJr_XRD+3Hk66OSoS_HfGe4Z7B1oVK6JbXj1qb5h4vXg1ah5Qg@mail.gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 13, 2023 at 9:01=E2=80=AFAM Daisuke Matsuda (Fujitsu)
<matsuda-daisuke@fujitsu.com> wrote:
>
> On Friday, October 13, 2023 9:29 PM Zhu Yanjun:
> > =E5=9C=A8 2023/10/13 20:01, Daisuke Matsuda (Fujitsu) =E5=86=99=E9=81=
=93:
> > > On Fri, Oct 13, 2023 10:18 AM Zhu Yanjun wrote:
> > >> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > >>
> > >> The page_size of mr is set in infiniband core originally. In the com=
mit
> > >> 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c"), the
> > >> page_size is also set. Sometime this will cause conflict.
> > >
> > > I appreciate your prompt action, but I do not think this commit deals=
 with
> > > the root cause. I agree that the problem lies in rxe driver, but what=
 is wrong
> > > with assigning actual page size to ibmr.page_size?
> >
> > Please check the source code. ibmr.page_size is assigned in
> > infiniband/core. And then it is assigned in rxe.
> > When the 2 are different, the problem will occur.
>
> In the first place, the two must always be equal.
> Is there any situation there are two different page sizes for a MR?
> I think I have explained the value assigned in the core layer is wrong
> when the PAGE_SIZE is bigger than 4k, and that is why they are inconsiste=
nt.
>
> As I have no environment to test the kernel panic, it remains speculative=
,
> but I have provided enough information for everyone to rebut my argument.
> It is possible I am wrong. I hope someone will tell me specifically where
> my guess is wrong, or Yi would kindly take the trouble to verify it.

I made a quick test.

With Zhu's patch, the problem fixed.
With your patch, this problem exists. And other problems occur. I do
not know why.
Will continue to make tests.

>
> Thanks,
> Daisuke Matsuda
>
> > Please add logs to infiniband/core and rxe to check them.
> >
> > Zhu Yanjun
> >
> > >
> > > IMO, the problem comes from the device attribute of rxe driver, which=
 is used
> > > in ulp/srp layer to calculate the page_size.
> > > =3D=3D=3D=3D=3D
> > > static int srp_add_one(struct ib_device *device)
> > > {
> > >          struct srp_device *srp_dev;
> > >          struct ib_device_attr *attr =3D &device->attrs;
> > > <...>
> > >          /*
> > >           * Use the smallest page size supported by the HCA, down to =
a
> > >           * minimum of 4096 bytes. We're unlikely to build large sgli=
sts
> > >           * out of smaller entries.
> > >           */
> > >          mr_page_shift           =3D max(12, ffs(attr->page_size_cap)=
 - 1);
> > >          srp_dev->mr_page_size   =3D 1 << mr_page_shift;
> > > =3D=3D=3D=3D=3D
> > > On initialization of srp driver, mr_page_size is calculated here.
> > > Note that the device attribute is used to calculate the value of page=
 shift
> > > when the device is trying to use a page size larger than 4096. Since =
Yi specified
> > > CONFIG_ARM64_64K_PAGES, the system naturally met the condition.
> > >
> > > =3D=3D=3D=3D=3D
> > > static int srp_map_finish_fr(struct srp_map_state *state,
> > >                               struct srp_request *req,
> > >                               struct srp_rdma_ch *ch, int sg_nents,
> > >                               unsigned int *sg_offset_p)
> > > {
> > >          struct srp_target_port *target =3D ch->target;
> > >          struct srp_device *dev =3D target->srp_host->srp_dev;
> > > <...>
> > >          n =3D ib_map_mr_sg(desc->mr, state->sg, sg_nents, sg_offset_=
p,
> > >                           dev->mr_page_size);
> > > =3D=3D=3D=3D=3D
> > > After that, mr_page_size is presumably passed to ib_core layer.
> > >
> > > =3D=3D=3D=3D=3D
> > > int ib_map_mr_sg(struct ib_mr *mr, struct scatterlist *sg, int sg_nen=
ts,
> > >                   unsigned int *sg_offset, unsigned int page_size)
> > > {
> > >          if (unlikely(!mr->device->ops.map_mr_sg))
> > >                  return -EOPNOTSUPP;
> > >
> > >          mr->page_size =3D page_size;
> > >
> > >          return mr->device->ops.map_mr_sg(mr, sg, sg_nents, sg_offset=
);
> > > }
> > > EXPORT_SYMBOL(ib_map_mr_sg);
> > > =3D=3D=3D=3D=3D
> > > Consequently, the page size calculated in srp driver is set to ibmr.p=
age_size.
> > >
> > > Coming back to rxe, the device attribute is set here:
> > > =3D=3D=3D=3D=3D
> > > rxe.c
> > > <...>
> > > /* initialize rxe device parameters */
> > > static void rxe_init_device_param(struct rxe_dev *rxe)
> > > {
> > >          rxe->max_inline_data                    =3D RXE_MAX_INLINE_D=
ATA;
> > >
> > >          rxe->attr.vendor_id                     =3D RXE_VENDOR_ID;
> > >          rxe->attr.max_mr_size                   =3D RXE_MAX_MR_SIZE;
> > >          rxe->attr.page_size_cap                 =3D RXE_PAGE_SIZE_CA=
P;
> > >          rxe->attr.max_qp                        =3D RXE_MAX_QP;
> > > ---
> > > rxe_param.h
> > > <...>
> > > /* default/initial rxe device parameter settings */
> > > enum rxe_device_param {
> > >          RXE_MAX_MR_SIZE                 =3D -1ull,
> > >          RXE_PAGE_SIZE_CAP               =3D 0xfffff000,
> > >          RXE_MAX_QP_WR                   =3D DEFAULT_MAX_VALUE,
> > > =3D=3D=3D=3D=3D
> > > rxe_init_device_param() sets the attributes to rxe_dev->attr, and it =
is later copied
> > > to ib_device->attrs in setup_device()@core/device.c.
> > > See that the page size cap is hardcoded to 4096 bytes. I suspect this=
 led to
> > > incorrect page_size being set to ibmr.page_size, resulting in the ker=
nel crash.
> > >
> > > I think rxe driver is made to be able to handle arbitrary page sizes.
> > > Probably, we can just modify RXE_PAGE_SIZE_CAP to fix the issue.
> > > What do you guys think?
> > >
> > > Thanks,
> > > Daisuke Matsuda
> > >
>
