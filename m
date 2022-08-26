Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AC05A26DB
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 13:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiHZL3m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 07:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHZL3m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 07:29:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA34D91CA
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 04:29:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w19so2586554ejc.7
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 04:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=nCogQkFdgMRII8nuJzfjD9UajonRT3Wt9QH9x4uZ3gA=;
        b=EF//LKUxXKcKhfHgg3xHNqfZOHJWcv1pVfY2pOKnaglBeDgGyNUEhzEwHjsb5a9/XH
         e7Uv41IU2pMT2Fns9YRf0tR3QuOi4vormdyjt9AGX0Jws4T/PxplBRN668dondOtBbE9
         7xdzXFAJwacoACrV7fBcurmJlYrrxSBxMQpWgBgVydpQB6DSEbchxztf8hTAyY5HdQbs
         GEPCa5j+QwroeogRSpMBEXV6PvCy0ttZKnhOVZWz5VpWSxaX0WRNSAa0Ew1WcR4qyMh5
         yZYiCiIsse21vx3rsJUuziP9vD40GArp/CxRz8zrH7N2TaehEnCWZoMCL2wbvzzIfiAa
         ISTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=nCogQkFdgMRII8nuJzfjD9UajonRT3Wt9QH9x4uZ3gA=;
        b=qTu0AGD8Um0Q0NVVEj8OgKNzvX/yZygpk5yKmqESEFvZcTl+IMpMEXeDIwxA0VaZuJ
         /KQWv9gXRswniSDly86ljrK7f45FVNodyynrVHBv/iJcwfIqyxMvkh4hLZE36wp6jIBt
         6bKcZbJZvhJ2wisdcfNDUlP8FGJhaBtQhz8djp0fi/OCcKFdjd+Mmw9Ubn6/oesc90e/
         F35BbNpVIi0sOVACb995ADEku/vmt42mtHReO9OylFg8LANieqGPu4Hw2b6DuY5krwfE
         71no6ZvTdWeJcXhXPMnk/bXBU9VxrZ5S0xAAQCDKlAjpFYPutOl2BYZt2bldjY3Cr+Oi
         tg4w==
X-Gm-Message-State: ACgBeo23P2wwXfkk3mdIH4alkSrsdqu+hUnnJDDLC1Qv3pCx8TKmczGk
        J/lLifsDJbaD2vuiOCBXEsndrVIcc4xiccW3s00gf9sNM5Y=
X-Google-Smtp-Source: AA6agR4Ot7LVwIvCuqu6/NXIEbV/ki10z2yoLhBrzswf79SHIPbWuS5NqB3kcIIfUikp7xKNx7w3yhWPesC3tzrpKOc=
X-Received: by 2002:a17:907:6890:b0:73d:a567:568c with SMTP id
 qy16-20020a170907689000b0073da567568cmr5215163ejc.521.1661513379485; Fri, 26
 Aug 2022 04:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220826081117.21687-1-guoqing.jiang@linux.dev>
 <CAMGffEku8H3RubkQGq1Cjy8pP8B+95coT+b2J6VxSAQx-kKmmg@mail.gmail.com> <aa3a4d50-2e71-a185-09ac-79bd34f9c8e6@linux.dev>
In-Reply-To: <aa3a4d50-2e71-a185-09ac-79bd34f9c8e6@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 26 Aug 2022 13:29:28 +0200
Message-ID: <CAMGffEkRo104Cp6+KX8NtS0ud+DHM6ftjmHyxjiQa=zJ7tFzog@mail.gmail.com>
Subject: Re: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, jgg@ziepe.ca,
        leon@kernel.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
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

On Fri, Aug 26, 2022 at 1:26 PM Guoqing Jiang <guoqing.jiang@linux.dev> wro=
te:
>
>
>
> On 8/26/22 6:48 PM, Jinpu Wang wrote:
> > On Fri, Aug 26, 2022 at 10:11 AM Guoqing Jiang <guoqing.jiang@linux.dev=
> wrote:
> >> Since all callers (process_{read,write}) set id->dir, no need to
> >> pass 'dir' again.
> >>
> >> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> >> ---
> >>   drivers/block/rnbd/rnbd-srv.c          | 9 ++++-----
> >>   drivers/block/rnbd/rnbd-srv.h          | 1 +
> >>   drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
> >>   drivers/infiniband/ulp/rtrs/rtrs.h     | 3 +--
> >>   4 files changed, 8 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-s=
rv.c
> >> index 3f6c268e04ef..9600715f1029 100644
> >> --- a/drivers/block/rnbd/rnbd-srv.c
> >> +++ b/drivers/block/rnbd/rnbd-srv.c
> >> @@ -368,10 +368,9 @@ static int process_msg_sess_info(struct rnbd_srv_=
session *srv_sess,
> >>                                   const void *msg, size_t len,
> >>                                   void *data, size_t datalen);
> >>
> >> -static int rnbd_srv_rdma_ev(void *priv,
> >> -                           struct rtrs_srv_op *id, int dir,
> >> -                           void *data, size_t datalen, const void *us=
r,
> >> -                           size_t usrlen)
> >> +static int rnbd_srv_rdma_ev(void *priv, struct rtrs_srv_op *id,
> >> +                           void *data, size_t datalen,
> >> +                           const void *usr, size_t usrlen)
> >>   {
> >>          struct rnbd_srv_session *srv_sess =3D priv;
> >>          const struct rnbd_msg_hdr *hdr =3D usr;
> >> @@ -398,7 +397,7 @@ static int rnbd_srv_rdma_ev(void *priv,
> >>                  break;
> >>          default:
> >>                  pr_warn("Received unexpected message type %d with dir=
 %d from session %s\n",
> >> -                       type, dir, srv_sess->sessname);
> >> +                       type, id->dir, srv_sess->sessname);
> >>                  return -EINVAL;
> >>          }
> >>
> >> diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-s=
rv.h
> >> index 081bceaf4ae9..5a0ef6c2b5c7 100644
> >> --- a/drivers/block/rnbd/rnbd-srv.h
> >> +++ b/drivers/block/rnbd/rnbd-srv.h
> >> @@ -14,6 +14,7 @@
> >>   #include <linux/kref.h>
> >>
> >>   #include <rtrs.h>
> >> +#include <rtrs-srv.h>
> > why do we need this?
>
> Otherwise, compiler complains
>
> drivers/block/rnbd/rnbd-srv.c: In function =E2=80=98rnbd_srv_rdma_ev=E2=
=80=99:
> drivers/block/rnbd/rnbd-srv.c:400:33: error: invalid use of undefined
> type =E2=80=98struct rtrs_srv_op=E2=80=99
>    400 |                         type, id->dir, srv_sess->sessname);
>
> Thanks,
> Guoqing
ah, okay, this reminds me, why we have dir there, we don't want to
export too much detail regarding the rtrs_srv_op to
rnbd-server, it is supposed to be transparent  to rnbd-srv.
