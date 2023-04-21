Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B1B6EA443
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Apr 2023 09:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjDUHGD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Apr 2023 03:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDUHGC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Apr 2023 03:06:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6A01FE7
        for <linux-rdma@vger.kernel.org>; Fri, 21 Apr 2023 00:06:00 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94eff00bcdaso205996066b.1
        for <linux-rdma@vger.kernel.org>; Fri, 21 Apr 2023 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1682060759; x=1684652759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6YRJ4Pqo2etpRODwwn3zLnwFzxlFB/dGfOqJw+A8Sg=;
        b=dc1GCcQy3i4v8A2vy1cJ1GY82u1abasiNC9WlPOI+7gS1PehjHlO6nTOwDK6hwZ2hT
         ihLoshQOkLK9Jp2ZEfa1+iUNfknI1rqCy+z1Rt4tjE9Wu6xWYbAeMcwXl1YTHCFE8RUB
         OU9w8Ax4zZdsvET8CKLb7so5fIKed/Y1DwTpx/oPbaDyxysuDraZiGfav3vG3+qVws4O
         /0yPlplNxGb02QW2uv9JZVmE/64JVTeq2yk2PLdrHedU6GG//NiqBK0u0dvR/zwiZkJC
         EUYbOSpHIuKvkhfoc80hd822sCh8w1g8QYmW5uEQmV99Y4KDgJ/LQtyWlI0yzXf/97qY
         tPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682060759; x=1684652759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6YRJ4Pqo2etpRODwwn3zLnwFzxlFB/dGfOqJw+A8Sg=;
        b=k7aQ72X45C8xRls8Ebn4vobSh6/JFDKb/W2udWWVrEVh3vUXKNwQl7nsg3wP/kQHpG
         HQXrmS4SWtSglXFkvIROpmNJ22GYtoI6xRNpoPnavpBSJVOxyEmPtC1XxkL7brtKJUsn
         ZJMANM+tFCH1c2YI9dI4P0io/Tt5Mx28V0f2480+nZuStd8pBH5kZ6LJyaRsH04aZlYG
         inpqQfw8fFCbBOeSwNiTD8prLzrQTBcoWSkr48xD4MfyZnLt1qH7x68Phrl+MPPJ5/KM
         gvJIA/KlpWp/J8IbZ941ipBjcQdr3hn0OAbYUlA9vaBcfpkB4G8rXuvDVI6PK2hmgHkg
         o/8g==
X-Gm-Message-State: AAQBX9ddAxLl0Kmxx7urjs3Z7OqNCiNRboHZoqnuWVyLfnODjPB0nJlu
        GcDEM8esWVyQcZ1wMAf7boUH+LIb849Bdtm2bsnolA==
X-Google-Smtp-Source: AKy350b/JDpso5+xBxvv0rNwDbMfwJumU/jwkE26ITnDc1EmrxPwo7SuX3xuLk/SkUJae0rZup7izjlZ78gSR7C1IsQ=
X-Received: by 2002:a17:907:6e12:b0:947:80a4:5cce with SMTP id
 sd18-20020a1709076e1200b0094780a45ccemr1699804ejc.65.1682060759122; Fri, 21
 Apr 2023 00:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal> <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
 <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev> <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
 <20230413132418.GR17993@unreal> <4d1cacbf-f9b2-07c7-75bf-61f34abc1841@linux.dev>
 <7656e04c-1adc-6621-0e45-e2b282e6c143@fujitsu.com> <20230417180452.GG15386@unreal>
 <0985e0a9-fe19-1c07-0da7-48ec88eb77c6@fujitsu.com> <20230418075706.GB9740@unreal>
 <65860af3-7d48-5a26-f916-50450633a893@fujitsu.com> <CAMGffEkyNnSXDfwuzCQ_ERZ-53OnoJ7gOF4eL1MAPYc74V43iQ@mail.gmail.com>
 <51b9e74d-70e0-3d76-ade9-93d960074ef9@fujitsu.com> <00202749-1b0d-91c8-9a52-cf8a66d8d340@fujitsu.com>
In-Reply-To: <00202749-1b0d-91c8-9a52-cf8a66d8d340@fujitsu.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 21 Apr 2023 09:05:47 +0200
Message-ID: <CAMGffEmqp+hcszxDDU-1jpZDFmGM9_FTmyifPLT+0T4FQo10FA@mail.gmail.com>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 21, 2023 at 3:38=E2=80=AFAM Zhijian Li (Fujitsu)
<lizhijian@fujitsu.com> wrote:
>
> Jinpu
>
> I updated the changes as below, and tested for thousand rounds.
>
>  From d441c0e2496c1795b5af2b6b8ae4672203d6af3c Mon Sep 17 00:00:00 2001
> From: Li Zhijian <lizhijian@fujitsu.com>
> Date: Thu, 20 Apr 2023 17:28:28 +0800
> Subject: [PATCH] RDMA/rtrs: Fix rxe_dealloc_pd warning
>
> In current design:
> 1. PD and clt_path->s.dev are shared among connections.
> 2. every con[n]'s cleanup phase will call destroy_con_cq_qp()
> 3. clt_path->s.dev will be always decreased in destroy_con_cq_qp(), and
>     when clt_path->s.dev become zero, it will destroy PD.
> 4. when con[1] failed to create, con[1] will not take clt_path->s.dev,
>     but it try to decreased clt_path->s.dev
>
> So, in case create_cm(con[0]) succeeds but create_cm(con[1])
> fails, destroy_con_cq_qp(con[1]) will be called first which will destory
> the PD while this PD is still taken by con[0].
>
> Here, we refactor the error path of create_cm() and init_conns(), so that
> we do the cleanup in the order they are created.
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/ulp/rtrs/rtrs-clt.c | 47 +++++++++++---------------
>   1 file changed, 19 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/=
ulp/rtrs/rtrs-clt.c
> index 80abf45a197a..5faf0ecb726b 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -2040,6 +2040,7 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_=
id *cm_id,
>         return 0;
>   }
>
> +/* The caller should the do the cleanup in case of error */
>   static int create_cm(struct rtrs_clt_con *con)
>   {
>         struct rtrs_path *s =3D con->c.path;
> @@ -2062,14 +2063,14 @@ static int create_cm(struct rtrs_clt_con *con)
>         err =3D rdma_set_reuseaddr(cm_id, 1);
>         if (err !=3D 0) {
>                 rtrs_err(s, "Set address reuse failed, err: %d\n", err);
> -               goto destroy_cm;
> +               return err;
>         }
>         err =3D rdma_resolve_addr(cm_id, (struct sockaddr *)&clt_path->s.=
src_addr,
>                                 (struct sockaddr *)&clt_path->s.dst_addr,
>                                 RTRS_CONNECT_TIMEOUT_MS);
>         if (err) {
>                 rtrs_err(s, "Failed to resolve address, err: %d\n", err);
> -               goto destroy_cm;
> +               return err;
>         }
>         /*
>          * Combine connection status and session events. This is needed
> @@ -2084,29 +2085,17 @@ static int create_cm(struct rtrs_clt_con *con)
>                 if (err =3D=3D 0)
>                         err =3D -ETIMEDOUT;
>                 /* Timedout or interrupted */
> -               goto errr;
> +               return err;
>         }
>         if (con->cm_err < 0) {
> -               err =3D con->cm_err;
> -               goto errr;
> +               return con->cm_err;
>         }
The bracket can be removed too
>         if (READ_ONCE(clt_path->state) !=3D RTRS_CLT_CONNECTING) {
>                 /* Device removal */
> -               err =3D -ECONNABORTED;
> -               goto errr;
> +               return -ECONNABORTED;
>         }
same here.
>
>         return 0;
> -
> -errr:
> -       stop_cm(con);
> -       mutex_lock(&con->con_mutex);
> -       destroy_con_cq_qp(con);
> -       mutex_unlock(&con->con_mutex);
> -destroy_cm:
> -       destroy_cm(con);
> -
> -       return err;
>   }
>
>   static void rtrs_clt_path_up(struct rtrs_clt_path *clt_path)
> @@ -2334,7 +2323,7 @@ static void rtrs_clt_close_work(struct work_struct =
*work)
>   static int init_conns(struct rtrs_clt_path *clt_path)
>   {
>         unsigned int cid;
> -       int err;
> +       int err, i;
>
>         /*
>          * On every new session connections increase reconnect counter
> @@ -2350,10 +2339,8 @@ static int init_conns(struct rtrs_clt_path *clt_pa=
th)
>                         goto destroy;
>
>                 err =3D create_cm(to_clt_con(clt_path->s.con[cid]));
> -               if (err) {
> -                       destroy_con(to_clt_con(clt_path->s.con[cid]));
> +               if (err)
>                         goto destroy;
> -               }
>         }
>         err =3D alloc_path_reqs(clt_path);
>         if (err)
> @@ -2364,15 +2351,19 @@ static int init_conns(struct rtrs_clt_path *clt_p=
ath)
>         return 0;
>
>   destroy:
> -       while (cid--) {
> +       /* Make sure we do the cleanup in the order they are created */
> +       for (i =3D 0; i <=3D cid; i++) {
>                 struct rtrs_clt_con *con =3D to_clt_con(clt_path->s.con[c=
id]);
Yes, this line has to be adapted.
                   struct rtrs_clt_con *con =3D to_clt_con(clt_path->s.con[=
i]);
>
> -               stop_cm(con);
> -
> -               mutex_lock(&con->con_mutex);
> -               destroy_con_cq_qp(con);
> -               mutex_unlock(&con->con_mutex);
> -               destroy_cm(con);
> +               if (!con)
> +                       break;
> +               if (con->c.cm_id) {
> +                       stop_cm(con);
> +                       mutex_lock(&con->con_mutex);
> +                       destroy_con_cq_qp(con);
> +                       mutex_unlock(&con->con_mutex);
> +                       destroy_cm(con);
> +               }
>                 destroy_con(con);
>         }
>         /*
> --
> 2.29.2
>
This version looks fine. I will run some tests.

Thx!
>
>
> On 20/04/2023 10:00, Li Zhijian wrote:
> > On 19/04/2023 21:20, Jinpu Wang wrote:
> >> On Wed, Apr 19, 2023 at 11:53=E2=80=AFAM Zhijian Li (Fujitsu)
> >> <lizhijian@fujitsu.com> wrote:
> >>>
> >>> Leon, Guoqing
> >>>
> >>>
> >>> On 18/04/2023 15:57, Leon Romanovsky wrote:
> >>>>>>> Currently, without this patch:
> >>>>>>> 1. PD and clt_path->s.dev are shared among connections.
> >>>>>>> 2. every con[n]'s cleanup phase will call destroy_con_cq_qp()
> >>>>>>> 3. clt_path->s.dev will be always decreased in destroy_con_cq_qp(=
), and when
> >>>>>>>        clt_path->s.dev become zero, it will destroy PD.
> >>>>>>> 4. when con[1] failed to create, con[1] will not take clt_path->s=
.dev, but it try to decreased clt_path->s.dev <<< it's wrong to do that.
> >>>>>> So please fix it by making sure that failure to create con[1] will
> >>>>>> release resources which were allocated. If con[1] didn't increase
> >>>>>> s.dev_ref, it shouldn't decrease it either.
> >>>>> You are right, the current patch did exactly that.
> >>>>> It introduced a con owning flag 'has_dev' to indicate whether this =
con has taken s.dev.
> >>>>> so that its cleanup phase will only decrease its s.dev properly.
> >>>> The has_dev is a workaround and not a solution. In proper error unwi=
nd
> >>>> sequence, you won't need extra flag.
