Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C727A7249
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 07:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjITFql (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 01:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjITFqk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 01:46:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD6895
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 22:46:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52f9a45b4bdso7974117a12.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 22:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695188792; x=1695793592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqzJHVDYvuBEsBomOrQFuQcwumJapC4CuANEWVnA1Cg=;
        b=ChRrO29KI5RJoe1wOqxBXdvOn58jjJAp4nv58IQOhDp/gdVKJFDSgXTv0Y6Xs/80cd
         A05OI5HlF2ruz73J2gsCCStIt0SYw75UNKjM0IhnzVAI9tKJFOJP2IDeXJhG03mEaTTy
         3br0ONBsqLZC17zB2cD9+xIIQkqCOQwTnY7h6TuDdF2MuLVP7tYjCDzL5c2pgPyhjeG7
         e0CmzwhyCOzulYTKIgEV92cFXvdtdIGEPg0rxaeYN2C5bYf6xzQdMStT3+nFgi2xLzeP
         B+HBjXDwj/pNrfQNwL6sWm5bqkca0f0hemiAAt9t73/snEMhAXVyBXTRoW2IteMN/sk9
         Iaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695188792; x=1695793592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqzJHVDYvuBEsBomOrQFuQcwumJapC4CuANEWVnA1Cg=;
        b=d4bfqIboSiQjQZ6SrI31s7NqTjO5WFdWdzEvWZ8ovFzscrrFEDY39WKkC0UN6mtWYc
         WK3U6g3Dp1BXdh9Ki5I57jtXurW+NWDYgsIT67QX0WLks4e/40OCID8JZZ6hjfV8duzp
         YWUbUdEJ1q1AmIhPCWMIVPL2ffICRcargcmNUFX7eiAxjdHmR678wYr0Rg6SBTxjk4uY
         HuC5VYpLpAVzLh5Ca/HDQgWwIPsCqgoA1w1dQ1BxOiTHWi/axcFHoBw/WH5Ignha8ulo
         tTlKYyEXDW5TjUEhRE4V9tSwPBGsApYDZnWpfU7Bwzi3Kv/RRMlt/6GYQb9YPKYQ9+Ji
         FeeQ==
X-Gm-Message-State: AOJu0YxQ+1ZwOnGqLRRdfaGCDXIumoTHEDu5WTXagAA5O7WG8JKeSjiP
        vWQ/QU5YbHkqeXZjwoLgnfOCQVNjw1SSOrg6+pDXvw==
X-Google-Smtp-Source: AGHT+IHWtkoDrzvRnUTlRCMeZYGKuTz9CP/WOPsHw8EE79q5d3GaVhwF8v7dudXpgOGmD6nFa4rEzIhQEsGs+l316bs=
X-Received: by 2002:aa7:dcc1:0:b0:52c:92e3:1d12 with SMTP id
 w1-20020aa7dcc1000000b0052c92e31d12mr1255164edu.11.1695188792446; Tue, 19 Sep
 2023 22:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230919020806.534183-1-yanjun.zhu@intel.com> <20230919081712.GD4494@unreal>
 <01d9dd18-3d63-fabb-33d4-0de528f15a9a@linux.dev> <20230919093028.GG4494@unreal>
 <d07d0b22-d932-dc01-1f33-c07932856fbc@fujitsu.com>
In-Reply-To: <d07d0b22-d932-dc01-1f33-c07932856fbc@fujitsu.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 20 Sep 2023 07:46:21 +0200
Message-ID: <CAMGffEmfqCjVVA7MJgaqyYzCkryeJRrkwfQ451fQwL-OpQeHjA@mail.gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rtrs: Fix the problem of variable not
 initialized fully
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 4:16=E2=80=AFAM Zhijian Li (Fujitsu)
<lizhijian@fujitsu.com> wrote:
>
>
>
> On 19/09/2023 17:30, Leon Romanovsky wrote:
> > On Tue, Sep 19, 2023 at 04:26:54PM +0800, Zhu Yanjun wrote:
> >>
> >> =E5=9C=A8 2023/9/19 16:17, Leon Romanovsky =E5=86=99=E9=81=93:
> >>> On Tue, Sep 19, 2023 at 10:08:06AM +0800, Zhu Yanjun wrote:
> >>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> >>>>
> >>>> No functionality change. The variable which is not initialized fully
> >>>> will introduce potential risks.
> >>> Are you sure about not being initialized?
> >>
> >> About this problem, I think we discussed it previously in RDMA maillis=
t.
> >>
> >> And at that time, IIRC, you shared a link with me. The link is as belo=
w.
> >>
> >> https://www.ex-parrot.com/~chris/random/initialise.html
> >>
> >>  From what we discussed and the above link, I think it is not initiali=
zed
> >> fully.
> >
> > I remember that discussion and it was about slightly different thing:
> > {} vs {0} in Linux kernel.
>
>
> Well, in my mind, I thought they are the same. see: https://www.gnu.org/s=
oftware/gnu-c-manual/gnu-c-manual.html#Initializing-Structure-Members
>
> In current kernel, {NULL/0} is used in so many other places. beside {NULL=
}, another partial initializing form
> struct class {
>         int a, b, c, d, e;
> } instance =3D {
>    .a =3D x,
>    .b =3D y,
> };
>
> They are also used everywhere, it's definitely based on the truth instanc=
e.{c,d,e} to be "0".
I also think they are the same. oth it is harmless.

Thx
>
>
> Thanks
>
>
>
> >
> > However I don't think that I sent you that link.
> > Anyway, let's take this patch as it is harmless.
> >
> > Thanks
> >
> >>
> >>
> >> Zhu Yanjun
> >>
> >>>
> >>> Thanks
> >>>
> >>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> >>>> ---
> >>>>    drivers/infiniband/ulp/rtrs/rtrs.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband=
/ulp/rtrs/rtrs.c
> >>>> index 3696f367ff51..d80edfffd2e4 100644
> >>>> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> >>>> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> >>>> @@ -255,7 +255,7 @@ static int create_cq(struct rtrs_con *con, int c=
q_vector, int nr_cqe,
> >>>>    static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
> >>>>                         u32 max_send_wr, u32 max_recv_wr, u32 max_sg=
e)
> >>>>    {
> >>>> -  struct ib_qp_init_attr init_attr =3D {NULL};
> >>>> +  struct ib_qp_init_attr init_attr =3D {};
> >>>>            struct rdma_cm_id *cm_id =3D con->cm_id;
> >>>>            int ret;
> >>>> --
> >>>> 2.40.1
> >>>>
