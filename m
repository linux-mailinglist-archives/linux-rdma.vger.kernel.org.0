Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536154855F9
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 16:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241542AbiAEPg4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 10:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbiAEPg4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 10:36:56 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE621C061245
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 07:36:55 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j6so163510037edw.12
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jan 2022 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TlvMWgcituHXnFXYcgZUfOvoHAmOSIKAp66Pg0ITCeQ=;
        b=JPv1hHSynnNcuIY0WSnnZcpSAq09/ikTA5MX0FOhzyOH2sjVm1aYlfh9MuRb3q8aN/
         Ut7ItZeOyO7pqwElth1vTCdRolVPXPtQudQuvUN5gYvBL5mUrKFgaBog+YbWu2dA4mz2
         cE6vspk5F9nwvRmdKxMm76dPuLLxw1ccGTsllH4TYjMg6ifE9arHL+lyiOi6kdPVpuAv
         arcEAdUEOlGVNoY67RPebapSvUieVGW+wZ0Yr6ZTfMvJK1mQSfM77JBhxi742FZP+g9C
         y4Q1b00KaT4i9vOakMrBy69bo2ax60F3JEMTWkusGweAYwDfMmHAUlhzPxO8k4bz00BD
         oDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TlvMWgcituHXnFXYcgZUfOvoHAmOSIKAp66Pg0ITCeQ=;
        b=04Neneyq0/J0+LIy/+N7oALQxkDSagnbzaGLaNKM+Sb9Ja2xyXWzP9YaIr87QfjsJH
         8LOYmb8SPzNXYeZIJGqoPf1v6iZPQjdlreJysyN+ZIxHLkqR4Y1DtBOderhmIRpy2Ooi
         lh+frJ0GToDrUkU1zJ2bslS1Pr8QGD1qbUyH4VoMMeju6+mCgC2MyXJJGnANV8U03caZ
         tEneDsdmTPpDYzjKO9YbhCp1wUW4iDRWkYb+UKcJxy0Bamfl63N9w73q6qTh38y/DTHD
         ttwyp1ICLkGHpcr+GuMfQKXEcQ19qbuUOR54Z3kFlocoEMfMKWNb7axMQ+iyuLNUR29Z
         snXg==
X-Gm-Message-State: AOAM530c+vt0/qgpszi6qFJMYw9o6su//qI/H98ZwiCZouv2EE7+3ZlE
        x1LzKjZCxfrvcf7ZGuZWJvsf22QyQj8C3Zs9F6dhaA==
X-Google-Smtp-Source: ABdhPJzjUbEVDxL38PTp2mst1fflcJuOcIuBa0qmcW+Si16fm6TeD4Z2mcmyjB74BbyWroI0iIjbRRaOKcTMuJm+ynY=
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr54561379edd.266.1641397014195;
 Wed, 05 Jan 2022 07:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20220103133339.9483-1-jinpu.wang@ionos.com> <20220103133339.9483-6-jinpu.wang@ionos.com>
 <c6289d43-1593-39c8-2869-2098ec3defd0@linux.dev>
In-Reply-To: <c6289d43-1593-39c8-2869-2098ec3defd0@linux.dev>
From:   Vaishali Thakkar <vaishali.thakkar@ionos.com>
Date:   Wed, 5 Jan 2022 16:36:43 +0100
Message-ID: <CAKw44h6iaas5reffA5ntTk=gsHeakob4BgR9UOmtWM+piCRpig@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 5/5] RDMA/rtrs-clt: Rename rtrs_clt to rtrs_clt_sess
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Jack Wang <jinpu.wang@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 4, 2022 at 8:09 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrot=
e:
>
>
>
> On 1/3/22 9:33 PM, Jack Wang wrote:
> > From: Vaishali Thakkar<vaishali.thakkar@ionos.com>
> >
> > Structure rtrs_clt is used for sessions. So to
> > avoid confusions rename it to rtrs_clt_sess.
> >
> > Transformations are done with the help of
> > following coccinelle script.
> >
> > @@
> > @@
> > struct
> > - rtrs_clt
> > + rtrs_clt_sess
> >
> > Signed-off-by: Vaishali Thakkar<vaishali.thakkar@ionos.com>
> > Signed-off-by: Jack Wang<jinpu.wang@ionos.com>
> > ---
> >   drivers/block/rnbd/rnbd-clt.c                |  4 +-
> >   drivers/block/rnbd/rnbd-clt.h                |  2 +-
> >   drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 24 +++---
> >   drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 78 ++++++++++---------=
-
> >   drivers/infiniband/ulp/rtrs/rtrs-clt.h       | 19 ++---
> >   drivers/infiniband/ulp/rtrs/rtrs.h           | 21 +++---
> >   6 files changed, 77 insertions(+), 71 deletions(-)
> >
> > diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-cl=
t.c
> > index 2df0657cdf00..70bbbdb81db1 100644
> > --- a/drivers/block/rnbd/rnbd-clt.c
> > +++ b/drivers/block/rnbd/rnbd-clt.c
> > @@ -433,7 +433,7 @@ static void msg_conf(void *priv, int errno)
> >       schedule_work(&iu->work);
> >   }
> >
> > -static int send_usr_msg(struct rtrs_clt *rtrs, int dir,
> > +static int send_usr_msg(struct rtrs_clt_sess *rtrs, int dir,
> >                       struct rnbd_iu *iu, struct kvec *vec,
> >                       size_t len, struct scatterlist *sg, unsigned int =
sg_len,
> >                       void (*conf)(struct work_struct *work),
> > @@ -1010,7 +1010,7 @@ static int rnbd_client_xfer_request(struct rnbd_c=
lt_dev *dev,
> >                                    struct request *rq,
> >                                    struct rnbd_iu *iu)
> >   {
> > -     struct rtrs_clt *rtrs =3D dev->sess->rtrs;
> > +     struct rtrs_clt_sess *rtrs =3D dev->sess->rtrs;
> >       struct rtrs_permit *permit =3D iu->permit;
> >       struct rnbd_msg_io msg;
> >       struct rtrs_clt_req_ops req_ops;
> > diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-cl=
t.h
> > index 9ef8c4f306f2..0c2cae7f39b9 100644
> > --- a/drivers/block/rnbd/rnbd-clt.h
> > +++ b/drivers/block/rnbd/rnbd-clt.h
> > @@ -75,7 +75,7 @@ struct rnbd_cpu_qlist {
> >
> >   struct rnbd_clt_session {
> >       struct list_head        list;
> > -     struct rtrs_clt        *rtrs;
> > +     struct rtrs_clt_sess        *rtrs;
>
> While at it, how about change it to clt_sess? Otherwise there is symbol n=
ame
> pollution between rnbd_clt_session and rnbd_srv_session.
>
> [ ...]
>
> >               /*
> > @@ -743,7 +744,7 @@ static int post_recv_path(struct rtrs_clt_path *clt=
_path)
> >   struct path_it {
> >       int i;
> >       struct list_head skip_list;
> > -     struct rtrs_clt *clt;
> > +     struct rtrs_clt_sess *clt;
>
> To align with the change of type, s/clt/clt_sess? If so, it applies to
> others as well.
>
> [ ... ]
>
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> > @@ -126,7 +126,7 @@ struct rtrs_rbuf {
> >
> >   struct rtrs_clt_path {
> >       struct rtrs_path        s;
> > -     struct rtrs_clt *clt;
> > +     struct rtrs_clt_sess    **clt*;
>
> Ditto.
>
> [ ... ]
>
> > -struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
> > +struct rtrs_clt_sess *rtrs_clt_open(struct rtrs_clt_ops *ops,
> >                                const char *pathname,
> >                                const struct rtrs_addr *paths,
> >                                size_t path_cnt, u16 port,
> >                                size_t pdu_sz, u8 reconnect_delay_sec,
> >                                s16 max_reconnect_attempts, u32 nr_poll_=
queues);
> >
> > -void rtrs_clt_close(struct rtrs_clt *clt_path);
> > +void rtrs_clt_close(struct rtrs_clt_sess *clt_path);
>
> void rtrs_clt_close(struct rtrs_clt_sess *clt_sess);
>
> or
>
> void rtrs_clt_close(struct rtrs_clt_path *clt_path);

Good catch. Actually this should be

void rtrs_clt_close(struct rtrs_clt_sess *clt);

>
> Maybe rename those functions to rtrs_clt_session_{open,close} to resolve
> the ambiguous
> completely, or we can live with current name I am not sure.

For this series, I think we can live with the current name. :)

> BTW, I suppose the series deserve beer from Danil =F0=9F=98=89

:)

> Thanks,
> Guoqing
>
