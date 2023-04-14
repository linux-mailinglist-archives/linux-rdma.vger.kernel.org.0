Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924AD6E1C28
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Apr 2023 08:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjDNGDr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Apr 2023 02:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNGDq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Apr 2023 02:03:46 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071663C21
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 23:03:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-505035e3368so2199642a12.0
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 23:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1681452223; x=1684044223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWUsjd7WBjL1O7aHt1ExdEj3LHWTzVqxSmnjWMqg6h0=;
        b=G37T5iYP37Zhn9Y2lXwfUH+vh+H2kx+hG2ER9gFHNOfgZT0jIK/m5Gzlp3Dek3q313
         Qryf1UOvEII6lcYNH/5JMCTmaXSpSvPTPjjUN1Seu4neuM/ekAzRO+yO7Yw7aicps41Q
         u0+me9P3o4fodEFZnfvf4jjDs/8GESS9SAVbbr5X6b7TIyOmoCyu9a9T4bW2vnUKn1hD
         58uTHzuejITAjH9JIcPtnG94OaST2scEKFtdaiylq4x53z8+sRx43SbJhbdYhVMvzzH4
         nvmbzRs96p6z/NWmW1RsDOYB5X3oVgkRVhMM8dAwWQYzbKbXDS20QhakpSgqrM+d6k1j
         goug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681452223; x=1684044223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWUsjd7WBjL1O7aHt1ExdEj3LHWTzVqxSmnjWMqg6h0=;
        b=d8fDUQVajgKXPOOU94oux1cEji9UhQRO3qU/spreORb2IQL0eaCY7u8f1cGwbzCCOX
         eW6LZuG5DSv2GLlNmj/yEIhH4lm9Cs+Fz5g8BKNhXrigCc/8T3pwj8+jKft84/IVmKDg
         AccDZ/ynzZexl4hwvdbwNLY/esWKM2kOShZeNYTng72qmilTS2EkuPiPCzawe09x7em0
         OLrLI3Y5EXXhU3oOrnyVA4GTTXgWH5pK0UP6rGvDxg1LBHjkkz/MHgpfYv/L005829aO
         4PgXFhiaIJ41BzcGNlfxN/S63dyoNsd44i2GY0G909IPdDmPLUyWcpBOYkGS7KP9AjTr
         V6ZA==
X-Gm-Message-State: AAQBX9dKB27JliAiG0JgYlK96od8rRFVaZOQ9DvUYlmbQIDTI8I0S76f
        auO4M/V4YgloBDkzVHk/Jk6iJn4adC3aSv1klEAlpw==
X-Google-Smtp-Source: AKy350a+VyDeZwR6qau3QqD7W2MYUe7+sMJ6R6Iq9LgT/iTjGYHpcSKuo5AqOb6zxCwEjSFKYTo/5Xtn/ojU6G0YQgk=
X-Received: by 2002:a50:a40d:0:b0:505:98c2:1222 with SMTP id
 u13-20020a50a40d000000b0050598c21222mr2545761edb.0.1681452223377; Thu, 13 Apr
 2023 23:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
 <1681108984-2-3-git-send-email-lizhijian@fujitsu.com> <20230410120809.GN182481@unreal>
 <0d9c57db-bca3-adb4-71fd-7362e4842917@linux.dev> <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal> <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
 <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev> <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
 <230b310a-26ef-34f1-4c3b-c2360088ce04@linux.dev> <f71e67d8-119c-7ec5-fbc0-d37799ed82b6@fujitsu.com>
In-Reply-To: <f71e67d8-119c-7ec5-fbc0-d37799ed82b6@fujitsu.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 14 Apr 2023 08:03:32 +0200
Message-ID: <CAMGffEkdMcj5_R49U4Vb1KV+4zMBtjzZAGhi1kHRACrz6DKkhg@mail.gmail.com>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Leon Romanovsky <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Zhijian, Guoqing, Leon, Bob

First of all, thanks for the patch and discussion.

On Fri, Apr 14, 2023 at 7:37=E2=80=AFAM Zhijian Li (Fujitsu)
<lizhijian@fujitsu.com> wrote:
>
>
>
> On 14/04/2023 11:40, Guoqing Jiang wrote:
> >
> >
> > On 4/13/23 16:12, Zhijian Li (Fujitsu) wrote:
> >> On 13/04/2023 15:35, Guoqing Jiang wrote:
> >>> Hi,
> >>>
> >>> I take a closer look today.
> >>>
> >>> On 4/12/23 09:15, Zhijian Li (Fujitsu) wrote:
> >>>> On 11/04/2023 20:26, Leon Romanovsky wrote:
> >>>>> On Tue, Apr 11, 2023 at 02:43:46AM +0000, Zhijian Li (Fujitsu) wrot=
e:
> >>>>>> On 10/04/2023 21:10, Guoqing Jiang wrote:
> >>>>>>> On 4/10/23 20:08, Leon Romanovsky wrote:
> >>>>>>>> On Mon, Apr 10, 2023 at 06:43:03AM +0000, Li Zhijian wrote:
> >>>>>>>>> The warning occurs when destroying PD whose reference count is =
not zero.
> >>>>>>>>>
> >>>>>>>>> Precodition: clt_path->s.con_num is 2.
> >>>>>>>>> So 2 cm connection will be created as below:
> >>>>>>>>> CPU0                                              CPU1
> >>>>>>>>> init_conns {                              |
> >>>>>>>>>       create_cm() // a. con[0] created        |
> >>>>>>>>>                                               |  a'. rtrs_clt_r=
dma_cm_handler() {
> >>>>>>>>>                                               |    rtrs_rdma_ad=
dr_resolved()
> >>>>>>>>>                                               |      create_con=
_cq_qp(con); << con[0]
> >>>>>>>>>                                               |  }
> >>>>>>>>>                                               | in this moment,=
 refcnt of PD was increased to 2+
> >>> What do you mean "refcnt of PD"? usecnt in struct ib_pd or dev_ref.
> >> I mean usecnt in struct ib_pd
> >>
> >>
> >>
> >>>>>>>>>                                               |
> >>>>>>>>>       create_cm() // b. cid =3D 1, failed       |
> >>>>>>>>>         destroy_con_cq_qp()                   |
> >>>>>>>>>           rtrs_ib_dev_put()                   |
> >>>>>>>>>             dev_free()                        |
> >>>>>>>>>               ib_dealloc_pd(dev->ib_pd) << PD |
> >>>>>>>>>                is destroyed, but refcnt is    |
> >>>>>>>>>                still greater than 0           |
> >>> Assuming you mean "pd->usecnt". We only allocate pd in con[0] by rtrs=
_ib_dev_find_or_add,
> >>> if con[1] failed to create cm, then alloc_path_reqs -> ib_alloc_mr ->=
 atomic_inc(&pd->usecnt)
> >
> > The above can't be invoked, right?
> >
> >>> can't be triggered. Is there other places could increase the refcnt?
> >> Yes, when create a qp, it will also associate to this PD, that also me=
an refcnt of PD will be increased.
> >>
> >> When con[0](create_con_cq_qp) succeeded, refcnt of PD will be 2. and t=
hen when con[1] failed, since
> >> QP didn't create, refcnt of PD is still 2. con[1]'s cleanup will destr=
oy the PD(ib_dealloc_pd) since dev_ref =3D 1, after that its
> >> refcnt is still 1.
> >
> > I can see the path increase usecnt to 1.
> >
> > rtrs_cq_qp_create -> create_qp
> >                      -> rdma_create_qp
> >                          -> ib_create_qp
> >                              -> create_qp
> >                              -> ib_qp_usecnt_inc which increases pd->us=
ecnt
> >
> > Where is another place to increase usecnt to 2?
>
> It should be
> ib_create_qp=E3=80=80...
>    -> rxe_create_qp
>      -> rxe_qp_from_init
>         -> rxe_get(pd) <<< pd's refcnt will be increased.

IIUC, this problem is rxe specific, because rxe manipulate refcnt
itself? I checked mlx5/mlx4 they do not change the refcnt of pd when
create_kernel_qp.

So question is then if the bug is on rxe side or rtrs side?

Zhijian how do you reproduce the warning? do you inject error explictly?


Regards!

>
>
> >
> >>> Then what is the appropriate time to call destroy_con_cq_qp for this =
scenario?
> >>> Otherwise there could be memory leak.
> >> we must ensure QP in con[0] is closed before destroying the PD.
> >> Currently destroy_con_cq_qp() subroutine will close the opened QP firs=
t.
> >
> > Let me try another way, with below change, rtrs_ib_dev_put can't be cal=
led
> > from destroy_con_cq_qp, right?
>
> Not really, con[0]->has_dev is true, so con[0]'s cleanup will call rtrs_i=
b_dev_put()
>
> Without this patch, when con[1] failed, con[1]'s cleanup will be called f=
irst. then call con[0]'s cleanup.
> After this change, con[1]'s cleanup will not call rtrs_ib_dev_put, but it=
 will be called the later con[0]'s cleanup.
>
>
> Thanks
> Zhijian
>
> >
> > +    if (!con->has_dev)
> > +        return;
> >       if (clt_path->s.dev_ref && !--clt_path->s.dev_ref) {
> >           rtrs_ib_dev_put(clt_path->s.dev);
> >           clt_path->s.dev =3D NULL;
> >
> > Then when will you dealloc pd and free rtrs_ib_dev?
> >
> > Thanks,
> > Guoqing
