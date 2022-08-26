Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0D75A2747
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 13:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbiHZL6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 07:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbiHZL6T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 07:58:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E5AA59B0
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 04:58:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id d21so2739936eje.3
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 04:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=1THcw+a8SwxA43ZD9QbjIVgiovkQji8vpJjzTsOyrL0=;
        b=KOBUL3rqBYieWU0O4wX5Agk+0YmkzjE5kdrm/Ufl9XZqub4HgXZ6QthWjKbr2B7H5r
         4HTSJZykvjwgOT4SaUxip6ICcBH2Sfoj6qnKQWmNfYtjggUnEWPN26X1wwom95VGk1BF
         psArnrWukl/AbUCHkkHVYPlIvipQf9rKOaNqWoFLtcT6e4+cfNkBNFrpSGBQEfp4PANm
         8rcwHrS0NJwoTnFF0RUYhRCfL/sZ9yuAv8PZB/brrk7713pbnQWEBAMCTXAiL609Hawu
         Esl2fg7wR9i774BwVNaftJEdntjM1lfBsR3RPyV9IcATOEyGn1N4l6CTS4ZJxmeWf1qv
         Q9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=1THcw+a8SwxA43ZD9QbjIVgiovkQji8vpJjzTsOyrL0=;
        b=j+6aISfuWDJ8ZeWREQqaCCiZ5/SPLBHNuJr08YrIAgLqY+0CIfOyDT7ELKY8tFdp8J
         m3On3LYK4tbl+PFof69VGaba630p0+Yy7N/OlN9y6D3LhmWlUhJycLpRc6viajxeq/gX
         B6A5LQYXRPZlCKpe6GO9zBkbccrDI9vBWkB8rt/WFPvfp+C9DvGUoWTjOSzCILzTAGke
         icV0OFkn0ez2b4q8pT6oVUMZELYvqGFCPPNuJ90667EqWh5DUq5c2+AcNh0h/zpjoZfj
         VV6jOmebVn/pTWrGSEdaM8oMhwdXxmJogQgy4H/BhQHcWIM5vfi4nxdm1WzybwW5NmaK
         yVJg==
X-Gm-Message-State: ACgBeo3rQUtxIb+QPtYKcwITJ4jI53Fv5nWCVDS3GnDJ9wXodHNonr3R
        OKcG3mek1LP3tOZQp7XlZ0wVke6boge2CNw2uiMCczJHfKI=
X-Google-Smtp-Source: AA6agR5kfuGiXz677+CDziuefQJMpoEK0XCUJK6UdUx2HhGyJb15ez0kqIofSmGOZe4/ogmQmuSHM4CrF9GW2d5Ps8g=
X-Received: by 2002:a17:907:8a0c:b0:73d:becd:b35c with SMTP id
 sc12-20020a1709078a0c00b0073dbecdb35cmr5326955ejc.204.1661515096833; Fri, 26
 Aug 2022 04:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220826081117.21687-1-guoqing.jiang@linux.dev>
 <CAMGffEku8H3RubkQGq1Cjy8pP8B+95coT+b2J6VxSAQx-kKmmg@mail.gmail.com>
 <aa3a4d50-2e71-a185-09ac-79bd34f9c8e6@linux.dev> <CAMGffEkRo104Cp6+KX8NtS0ud+DHM6ftjmHyxjiQa=zJ7tFzog@mail.gmail.com>
 <c4fb6007-91f9-6d2c-4888-d49a08dd297e@linux.dev>
In-Reply-To: <c4fb6007-91f9-6d2c-4888-d49a08dd297e@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 26 Aug 2022 13:58:06 +0200
Message-ID: <CAMGffEkAYOJPAPaHDspk-JfJNNF96pHWnrCwYzROFZxPBBO+Fw@mail.gmail.com>
Subject: Re: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, jgg@ziepe.ca,
        leon@kernel.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 26, 2022 at 1:38 PM Guoqing Jiang <guoqing.jiang@linux.dev> wro=
te:
>
>
>
> On 8/26/22 7:29 PM, Jinpu Wang wrote:
> > On Fri, Aug 26, 2022 at 1:26 PM Guoqing Jiang <guoqing.jiang@linux.dev>=
 wrote:
> >>
> >>
> >> On 8/26/22 6:48 PM, Jinpu Wang wrote:
> >>> On Fri, Aug 26, 2022 at 10:11 AM Guoqing Jiang <guoqing.jiang@linux.d=
ev> wrote:
> >>>> Since all callers (process_{read,write}) set id->dir, no need to
> >>>> pass 'dir' again.
> >>>>
> >>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> >>>> ---
> >>>>    drivers/block/rnbd/rnbd-srv.c          | 9 ++++-----
> >>>>    drivers/block/rnbd/rnbd-srv.h          | 1 +
> >>>>    drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
> >>>>    drivers/infiniband/ulp/rtrs/rtrs.h     | 3 +--
> >>>>    4 files changed, 8 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd=
-srv.c
> >>>> index 3f6c268e04ef..9600715f1029 100644
> >>>> --- a/drivers/block/rnbd/rnbd-srv.c
> >>>> +++ b/drivers/block/rnbd/rnbd-srv.c
> >>>> @@ -368,10 +368,9 @@ static int process_msg_sess_info(struct rnbd_sr=
v_session *srv_sess,
> >>>>                                    const void *msg, size_t len,
> >>>>                                    void *data, size_t datalen);
> >>>>
> >>>> -static int rnbd_srv_rdma_ev(void *priv,
> >>>> -                           struct rtrs_srv_op *id, int dir,
> >>>> -                           void *data, size_t datalen, const void *=
usr,
> >>>> -                           size_t usrlen)
> >>>> +static int rnbd_srv_rdma_ev(void *priv, struct rtrs_srv_op *id,
> >>>> +                           void *data, size_t datalen,
> >>>> +                           const void *usr, size_t usrlen)
> >>>>    {
> >>>>           struct rnbd_srv_session *srv_sess =3D priv;
> >>>>           const struct rnbd_msg_hdr *hdr =3D usr;
> >>>> @@ -398,7 +397,7 @@ static int rnbd_srv_rdma_ev(void *priv,
> >>>>                   break;
> >>>>           default:
> >>>>                   pr_warn("Received unexpected message type %d with =
dir %d from session %s\n",
> >>>> -                       type, dir, srv_sess->sessname);
> >>>> +                       type, id->dir, srv_sess->sessname);
> >>>>                   return -EINVAL;
> >>>>           }
> >>>>
> >>>> diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd=
-srv.h
> >>>> index 081bceaf4ae9..5a0ef6c2b5c7 100644
> >>>> --- a/drivers/block/rnbd/rnbd-srv.h
> >>>> +++ b/drivers/block/rnbd/rnbd-srv.h
> >>>> @@ -14,6 +14,7 @@
> >>>>    #include <linux/kref.h>
> >>>>
> >>>>    #include <rtrs.h>
> >>>> +#include <rtrs-srv.h>
> >>> why do we need this?
> >> Otherwise, compiler complains
> >>
> >> drivers/block/rnbd/rnbd-srv.c: In function =E2=80=98rnbd_srv_rdma_ev=
=E2=80=99:
> >> drivers/block/rnbd/rnbd-srv.c:400:33: error: invalid use of undefined
> >> type =E2=80=98struct rtrs_srv_op=E2=80=99
> >>     400 |                         type, id->dir, srv_sess->sessname);
> >>
> >> Thanks,
> >> Guoqing
> > ah, okay, this reminds me, why we have dir there, we don't want to
> > export too much detail regarding the rtrs_srv_op to
> > rnbd-server, it is supposed to be transparent  to rnbd-srv.
>
> What is the issue with more details are exported from rtrs-srv? Both of
> the modules
> are run in the same machine.
with including rtrs-srv.h, the code size is bigger, not to mention
many unnecessary
info are exported to rnbd-srv module, ideally we want to have
rnbd/rtrs layered properly
with clear separation.

>
> And I guess we can just pass parameters with register after remove an
> argument,
> otherwise need to push/pop stack with more than six parameters for x64.
I doubt it makes any notable performance change.
>
> Thanks,
> Guoqing
Thx!
