Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BD8424C1D
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 05:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhJGDPD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 23:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhJGDPB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Oct 2021 23:15:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6243C061746
        for <linux-rdma@vger.kernel.org>; Wed,  6 Oct 2021 20:13:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y26so18893629lfa.11
        for <linux-rdma@vger.kernel.org>; Wed, 06 Oct 2021 20:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UDUQjYDLLaLfPBcysS2FOIEmq8Ykh9J/E9uIaZqfcOo=;
        b=KLuTp7XhMHpQjxmqXvVOXlNAjbTVLMWAqxKlyDgwigDmSDWWPVgdW4wwIb3ReMDahI
         YfIYTOJsRhJfrFQs/oKM2NAv0Pbzs+3zYWncLKn3fT5//vQGW3oFyEBVzGEjxvWbchEO
         Le/+4cJzlF7STTuoxze1PDeun+b+cAmdaOl0NZEkcMg0KYYE3BwKcqzMSJeye8rTYBEx
         QGjX9uFx619gA13fb/I4THmT7csERjSc9tfNJweffiS27LKwo0+7pfNNqAf7TOS89pHX
         WwAdjEp1+EuIcJOwrHBRZkkTp4tQQA5vkw4HDwUzplFOovFzTUdoF6a1eRCAtDd9/yfQ
         8HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UDUQjYDLLaLfPBcysS2FOIEmq8Ykh9J/E9uIaZqfcOo=;
        b=67fRFSSNzvkLL7x7VD3wsgfdq3nVXQ8LZOAkX0D3Aq27H6eHiZ7KdaBF4WzxwaT0fs
         YyAw/DE4ANoQavUrpr/omNcFzB8AboWA+Z+T23I8A5+Cc0DQvFLiwCH7flUSK7w9Dn3C
         ymJjy2Emyplz7Gj/Q4VAvTYpzaFayl8OJ8WZVr446jCbSGlLGzfspLRvf2FpwbAzw8MQ
         tWNToE8epfuZCgyjQjn5gbReotqpTGun85ASKsAYcERW/E1MqGhUCYrOBPZO6XD7WhJW
         HljhGsEF7zeHESZ28ut8KKndoaVKNwnDooRLEDBDHuL5MRqeKnw5xoGM3EWmLp2smgdA
         hRUA==
X-Gm-Message-State: AOAM532G2ENEIbJqO262TXzW8qfgi9n378kXXTUoW/+/uO0Ha3WGjFER
        lYFuoT3d3TsUQdBi2TDY/4E7Zb+EeVYO0ZTcsAQ=
X-Google-Smtp-Source: ABdhPJxNKF2GNeg8nM/R63XNDYlHSncM+obQKO5Vt6ArZhT8LG6BKgfQZ0Bla+x+xTbrMhwQ4vIE/I/S31YbLPte1xs=
X-Received: by 2002:a05:651c:1697:: with SMTP id bd23mr1786391ljb.442.1633576387150;
 Wed, 06 Oct 2021 20:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211006015815.28350-1-rpearsonhpe@gmail.com> <20211006015815.28350-6-rpearsonhpe@gmail.com>
 <CAD=hENda99c3wDoub39EedNrU7cmeMORnW=q6K9EVdFXZaTUsg@mail.gmail.com> <CS1PR8401MB1077B75B6233730E5AFB5601BCB09@CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <CS1PR8401MB1077B75B6233730E5AFB5601BCB09@CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 7 Oct 2021 11:12:55 +0800
Message-ID: <CAD=hENcYqKF-KCtWKmYaK-=TiXzkk9c2zp1tyX35rSqq8yV01w@mail.gmail.com>
Subject: Re: [PATCH for-next v5 5/6] RDMA/rxe: Lookup kernel AH from ah index
 in UD WQEs
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 6, 2021 at 10:42 PM Pearson, Robert B
<robert.pearson2@hpe.com> wrote:
>
> Zhu,
>
> It's a matter of preference. I find that for me always putting all the lo=
cal variables at the top of a subroutine saves time and reduces bugs. I kno=
w where to look. They're always there. And there are no tricky scope issues=
 to think about. If you can't see them because they are off the screen the =
subroutine is probably too big.
>

Yeah. It is a matter of preference. I like to put all the variables
near where they are used.
Do not worry. I am fine with your preference.

Zhu Yanjun
> BTW do you have a new email address? I just saw one go by.
>
> Bob
>
> -----Original Message-----
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> Sent: Wednesday, October 6, 2021 6:56 AM
> To: Bob Pearson <rpearsonhpe@gmail.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>; RDMA mailing list <linux-rdma@vger.=
kernel.org>
> Subject: Re: [PATCH for-next v5 5/6] RDMA/rxe: Lookup kernel AH from ah i=
ndex in UD WQEs
>
> On Wed, Oct 6, 2021 at 9:58 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >
> > Add code to rxe_get_av in rxe_av.c to use the AH index in UD send WQEs
> > to lookup the kernel AH. For old user providers continue to use the AV
> > passed in WQEs. Move setting pkt->rxe to before the call to
> > rxe_get_av() to get access to the AH pool.
> >
> > Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_av.c  | 20 +++++++++++++++++++-
> > drivers/infiniband/sw/rxe/rxe_req.c |  8 +++++---
> >  2 files changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_av.c
> > b/drivers/infiniband/sw/rxe/rxe_av.c
> > index 85580ea5eed0..38c7b6fb39d7 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_av.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_av.c
> > @@ -101,11 +101,29 @@ void rxe_av_fill_ip_info(struct rxe_av *av,
> > struct rdma_ah_attr *attr)
> >
> >  struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)  {
> > +       struct rxe_ah *ah;
> > +       u32 ah_num;
> > +
> >         if (!pkt || !pkt->qp)
> >                 return NULL;
> >
> >         if (qp_type(pkt->qp) =3D=3D IB_QPT_RC || qp_type(pkt->qp) =3D=
=3D IB_QPT_UC)
> >                 return &pkt->qp->pri_av;
> >
> > -       return (pkt->wqe) ? &pkt->wqe->wr.wr.ud.av : NULL;
> > +       if (!pkt->wqe)
> > +               return NULL;
> > +
> > +       ah_num =3D pkt->wqe->wr.wr.ud.ah_num;
> > +       if (ah_num) {
> > +               /* only new user provider or kernel client */
>
> struct rxe_ah *ah;
> ah is only used in this snippet. Is it better to move to here?
> It is only a trivial problem.
>
> Zhu Yanjun
> > +               ah =3D rxe_pool_get_index(&pkt->rxe->ah_pool, ah_num);
> > +               if (!ah || ah->ah_num !=3D ah_num || rxe_ah_pd(ah) !=3D=
 pkt->qp->pd) {
> > +                       pr_warn("Unable to find AH matching ah_num\n");
> > +                       return NULL;
> > +               }
> > +               return &ah->av;
> > +       }
> > +
> > +       /* only old user provider for UD sends*/
> > +       return &pkt->wqe->wr.wr.ud.av;
> >  }
> > diff --git a/drivers/infiniband/sw/rxe/rxe_req.c
> > b/drivers/infiniband/sw/rxe/rxe_req.c
> > index fe275fcaffbd..0c9d2af15f3d 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_req.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> > @@ -379,9 +379,8 @@ static struct sk_buff *init_req_packet(struct rxe_q=
p *qp,
> >         /* length from start of bth to end of icrc */
> >         paylen =3D rxe_opcode[opcode].length + payload + pad +
> > RXE_ICRC_SIZE;
> >
> > -       /* pkt->hdr, rxe, port_num and mask are initialized in ifc
> > -        * layer
> > -        */
> > +       /* pkt->hdr, port_num and mask are initialized in ifc layer */
> > +       pkt->rxe        =3D rxe;
> >         pkt->opcode     =3D opcode;
> >         pkt->qp         =3D qp;
> >         pkt->psn        =3D qp->req.psn;
> > @@ -391,6 +390,9 @@ static struct sk_buff *init_req_packet(struct
> > rxe_qp *qp,
> >
> >         /* init skb */
> >         av =3D rxe_get_av(pkt);
> > +       if (!av)
> > +               return NULL;
> > +
> >         skb =3D rxe_init_packet(rxe, av, paylen, pkt);
> >         if (unlikely(!skb))
> >                 return NULL;
> > --
> > 2.30.2
> >
