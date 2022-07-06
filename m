Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26359568913
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 15:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiGFNMM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 09:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiGFNML (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 09:12:11 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5841D20191
        for <linux-rdma@vger.kernel.org>; Wed,  6 Jul 2022 06:12:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j21so25898189lfe.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 Jul 2022 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VIA8sZfufk07yf1JS3pAZRhoqVvjY0JOKH93DsVsKzU=;
        b=AvCuDjn1NNF+BGUrKyxILJ29Y0u1tCsKAsWx5l0VOpHJc/xJHlJrTQuEVWmIqvgwql
         wDqhwAqmm7q5rj+LcmKJ1laewwRWS6RTme3a2mF7uENkcXGnGQrGf7nykts8NBWoV+Ji
         DfKTLpuDcnrZlbB4pqMv1CIVKuk50bczrR1w8999CN3PQLMW/S8p+RRXcOHkEuZSZ//M
         uvKUiip50i8hLG92Tj6wCVJg+/9gDpB+R5UdRysb0dY7okB2OVhtXCjgfoKjHVs8xdRl
         3ZNzFJSzbzkWfZCeDSon3K2z/bDVuuc5HGx8wveOvME75CqRU/dC0PoZR1SBKQ1irgOk
         z1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VIA8sZfufk07yf1JS3pAZRhoqVvjY0JOKH93DsVsKzU=;
        b=wyoPuIjMHmszKvxReCT6GYPy61/anhOE4YGKOeZbTziBw23KpkxDHV7sggHDsfQ2Qu
         ICS8+eV2FMp8ZR0nPmWx9XoP2rwp+ntRvTwwgdIJ4EdYGmWWa5ZZ6EzY+Z1Z5wdeF9Of
         1v9uMMtzb9k5et0V/+PH/UWPXGPOhfmxJwex3C3cSRStFnxu9/0pkf8udDY1MULdrZxU
         BKAEIV7XKv/blTwRLXJGOvWxzpzKH9jE9R6Mr4OCxe3gtvVsocVm3pC9GMiq8aT7f4aQ
         r399MSIuXQeos8MlwRB5JJPz1My/nyUuseBrEoJ40eH1j8KwaTlPuXCYjiMB5lnHjyEe
         xPmg==
X-Gm-Message-State: AJIora/GH81O5gYz0MumMHJVDjira2nC85oZOcX7I2QQCeqq2ZY2BoLf
        ijc67v7NpZENAu59S1YphrEeEZcXf6w8+fNzzGi7a3ZDfYo=
X-Google-Smtp-Source: AGRyM1u6Zt0NyBGoCwBKsyVs86m0Aq1qPI6SXPXa8nJgvpSAK7XONM/2ABzLRQB7oxSe59inHkxTGrkvgy4x0kpYn3E=
X-Received: by 2002:a05:6512:169b:b0:47f:6567:c196 with SMTP id
 bu27-20020a056512169b00b0047f6567c196mr25280172lfb.589.1657113128448; Wed, 06
 Jul 2022 06:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220705225414.315478-1-yanjun.zhu@linux.dev> <CAJpMwyg8YF30W_43oKD=cQ8b9pWaSh-aPON4u50b2VG==WXBwQ@mail.gmail.com>
 <1a57273c-0427-959d-8ed4-9be1e1c7b9bd@linux.dev>
In-Reply-To: <1a57273c-0427-959d-8ed4-9be1e1c7b9bd@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 6 Jul 2022 15:11:57 +0200
Message-ID: <CAJpMwyh7LCdaejvymwxvoSJWTjL=sHEmVb65Khz-aXEhBn+fjg@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix BUG: KASAN: null-ptr-deref in rxe_qp_do_cleanup
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 6, 2022 at 3:10 PM Yanjun Zhu <yanjun.zhu@linux.dev> wrote:
>
> =E5=9C=A8 2022/7/5 18:35, Haris Iqbal =E5=86=99=E9=81=93:
> > On Tue, Jul 5, 2022 at 8:28 AM <yanjun.zhu@linux.dev> wrote:
> >>
> >> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> >>
> >> The function rxe_create_qp calls rxe_qp_from_init. If some error
> >> occurs, the error handler of function rxe_qp_from_init will set
> >> both scq and rcq to NULL.
> >>
> >> Then rxe_create_qp calls rxe_put to handle qp. In the end,
> >> rxe_qp_do_cleanup is called by rxe_put. rxe_qp_do_cleanup directly
> >> accesses scq and rcq before checking them. This will cause
> >> null-ptr-deref error.
> >>
> >> The call graph is as below:
> >>
> >> rxe_create_qp {
> >>    ...
> >>    rxe_qp_from_init {
> >>      ...
> >>    err1:
> >>      ...
> >>      qp->rcq =3D NULL;  <---rcq is set to NULL
> >>      qp->scq =3D NULL;  <---scq is set to NULL
> >>      ...
> >>    }
> >>
> >> qp_init:
> >>    rxe_put{
> >>      ...
> >>      rxe_qp_do_cleanup {
> >>        ...
> >>        atomic_dec(&qp->scq->num_wq); <--- scq is accessed
> >>        ...
> >>        atomic_dec(&qp->rcq->num_wq); <--- rcq is accessed
> >>      }
> >> }
> >>
> >> Fixes: 4703b4f0d94a ("RDMA/rxe: Enforce IBA C11-17")
> >> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> >> ---
> >> V1->V2: Describe the error flows.
> >> ---
> >>   drivers/infiniband/sw/rxe/rxe_qp.c | 10 ++++++----
> >>   1 file changed, 6 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/s=
w/rxe/rxe_qp.c
> >> index 22e9b85344c3..b79e1b43454e 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> >> @@ -804,13 +804,15 @@ static void rxe_qp_do_cleanup(struct work_struct=
 *work)
> >>          if (qp->rq.queue)
> >>                  rxe_queue_cleanup(qp->rq.queue);
> >>
> >> -       atomic_dec(&qp->scq->num_wq);
> >> -       if (qp->scq)
> >> +       if (qp->scq) {
> >> +               atomic_dec(&qp->scq->num_wq);
> >>                  rxe_put(qp->scq);
> >> +       }
> >>
> >> -       atomic_dec(&qp->rcq->num_wq);
> >> -       if (qp->rcq)
> >> +       if (qp->rcq) {
> >> +               atomic_dec(&qp->rcq->num_wq);
> >>                  rxe_put(qp->rcq);
> >> +       }
> >>
> >>          if (qp->pd)
> >>                  rxe_put(qp->pd);
> >> --
> >> 2.34.1
> >
> > Looks good.
> >
> > Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> >
> > Should the check for "rxe_cleanup_task(&qp->comp.task);" also happen
> > in this commit? or would it be covered in a different one?
>
> It is in a different commit. I will send it out very soon.

Okay. Thank you!

>
> Zhu Yanjun
>
> >
> >>
>
