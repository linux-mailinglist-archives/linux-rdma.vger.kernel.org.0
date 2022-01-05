Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB534852F6
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 13:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiAEMmY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 07:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiAEMmW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 07:42:22 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A06CC061761
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 04:42:21 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id g13so53583467ljj.10
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jan 2022 04:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVbIHfS9osfg6n9/oA8sqwHZ/xBLiGNTAp3HFvW2yzs=;
        b=iUfGcfDROFDFSBIhxLdtzDKdX2F+weOODL6Hi/sTSr4JzgFGDyqTjB8Xnyfq5ALQ59
         PH+nBKDUHevdyh/j85o6ZbnJXF72+4ekGE1a7l2/5lKlSAu/Z/Bq1dRx8tK+d2AAG/T0
         +VkZicW2VW4YoUac+2Y3d8vRJTdUF34iKbVl/64m+2ruE+LBSjtrA8NbSmtDxYPU2jEp
         uK1o/Swd4u3lv7FfrfHs2hhf6wX3KQ6zZfQWJzjXinuE4b2eetQirU5GFwNrdJ+Og0G0
         H49rN5ZBkSfl7n+bFXpdMcsBBfxmFnEhmAqqfOphw6E4cqZvyhPx9BSoBjmyKeRIhRGW
         m/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVbIHfS9osfg6n9/oA8sqwHZ/xBLiGNTAp3HFvW2yzs=;
        b=bNb2zT+HPvLNyyUC6QjBUNhWJUmI41PnXg1dUk1Su5hjVuItUpXUOR+FZwM30ecNVP
         FjuydZDXB2jc5mKDQQO/KicbQPwihzfJhzNP6lZfLJ/95UUtgozL1JcQkXd0vdSjuBiy
         LS5cuiaeoOoQrpxPTa6npE3I8fhcb19aFwgG7cJuDCI7Msn7QZCDrdjKQ0SPTBBmDPYp
         GJLte1mqbX3bnr+8NrTXY5ue/a5zf0apYoVv4HnMex2BfyvWjnGfAMXoQ/pvNeZBbgB6
         MzqbxVzweOZ78sAS/98NP8+XF0nD3/U55om7fYSj0tfawHVuX1VEai0hF+xyyLflDM2G
         SGFw==
X-Gm-Message-State: AOAM530GfvCj4zF50jSxO/LPvcaJvzGOtu5ww4hlxPfGXK3FIkJpg+uO
        ZIJgyhdbUSTTcNEQm88Js7DJ73QnWBu0kA3Po70=
X-Google-Smtp-Source: ABdhPJwWSkMcEfai28axsRXBxc+NfOvhff7aX/DHf52Ofs8aVRIxnBQZpCpD5r8PFoAahj4zVRezMz/nOdwJHclCQrc=
X-Received: by 2002:a2e:9b9a:: with SMTP id z26mr13375705lji.384.1641386539808;
 Wed, 05 Jan 2022 04:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
 <20220105221237.2659462-5-yanjun.zhu@linux.dev> <YdVONs32Ue7R0kk1@unreal>
 <CAD=hENeUv_7GjgDrZWr5wUmECtGY8=a=sPmbRanmh4zxLWzecA@mail.gmail.com> <YdVc5BMAaOh2aO2C@unreal>
In-Reply-To: <YdVc5BMAaOh2aO2C@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 5 Jan 2022 20:42:08 +0800
Message-ID: <CAD=hENcxzNjynR9nAs8QS8hoZmkWRtZ0eZd3DRQKcyf=NzXKQQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] RDMA/rxe: Use the standard method to produce udp
 source port
To:     Leon Romanovsky <leon@kernel.org>
Cc:     yanjun.zhu@linux.dev, liangwenpeng@huawei.com,
        Jason Gunthorpe <jgg@ziepe.ca>, mustafa.ismail@intel.com,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 5, 2022 at 4:55 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Jan 05, 2022 at 04:27:38PM +0800, Zhu Yanjun wrote:
> > On Wed, Jan 5, 2022 at 3:52 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Wed, Jan 05, 2022 at 05:12:36PM -0500, yanjun.zhu@linux.dev wrote:
> > > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > >
> > > > Use the standard method to produce udp source port.
> > > >
> > > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > > ---
> > > >  drivers/infiniband/sw/rxe/rxe_verbs.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > > > index 0aa0d7e52773..42fa81b455de 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > > > @@ -469,6 +469,12 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
> > > >       if (err)
> > > >               goto err1;
> > > >
> > > > +     if ((mask & IB_QP_AV) && (attr->ah_attr.ah_flags & IB_AH_GRH))
> > >
> > > You are leaving src_port default and wired to same port as other QPs
> > > without any randomization.
> >
> > Hi,
> >
> > I do not get you. Why do you think I am leaving src_pport default?
>
> Because in original code, you randomized src_port without any relation
> to mask flags.
>
>        qp->src_port = RXE_ROCE_V2_SPORT +
>                (hash_32_generic(qp_num(qp), 14) & 0x3fff);
>
> After patch #5, if user doesn't pass "proper" mask, you will leave
> qp->src_port to be equal to RXE_ROCE_V2_SPORT, which is different from
> the current behaviour.

Hi, Leon Romanovsky

I read your comments again and checked the source code.
And I found this https://lkml.org/lkml/2015/12/15/566, Jason commented:
"
...
The GRH is optional for in-subnet communications.
...
"
I agree with you. When in-subnet communications, GRH is optional.
It is possible that qp->src_port is set to RXE_ROCE_V2_SPORT.

So I will remove patch #5 and send the patch series again.
Thanks.
Zhu Yanjun

>
> Thanks
>
>
> > Thanks.
> >
> > Zhu Yanjun
> >
> > >
> > > Thanks
> > >
> > > > +             qp->src_port = rdma_get_udp_sport(attr->ah_attr.grh.flow_label,
> > > > +                                               qp->ibqp.qp_num,
> > > > +                                               qp->attr.dest_qp_num);
> > > > +
> > > > +
> > > >       return 0;
> > > >
> > > >  err1:
> > > > --
> > > > 2.27.0
> > > >
