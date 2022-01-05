Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B07484F50
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 09:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiAEI1w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 03:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiAEI1v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 03:27:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71027C061761
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 00:27:51 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g11so87584729lfu.2
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jan 2022 00:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HnMqrJ8+G7op9/PV0Z3ZbYZiNYSBbvnC+myTdu9aCo=;
        b=ALkJpW1sgp/R/ZNynfEGpxd09ow3742pJW55AqCMWwdpdI0T0UIcxeG/IMxn2UgKzX
         Qhhl2PfTRCD2YnOiWTYpRa1nBbcGJknVQq5sdtfSEHQgmqAAxB0gzPS1CbgocLwVKiiR
         hTVWCl3VqijVUJe1nHdLz9YPND9CllcYYrz4fUfJ9L2ucSJhl1zqJk5RZ7gr0EkoVQ/C
         LFRwfMtQb5A9ObMvjyeLP71FzVl+hsxd3REHc1gkXBt7x80C4cA65lDSlgVrZgNL5RNX
         ozEG+hV6GZnPpsAQ/j+4GhEqAtmqWDeJnyNVegoHwpgPVB+FAUc0ADuOOUkGzI79SjHY
         uR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HnMqrJ8+G7op9/PV0Z3ZbYZiNYSBbvnC+myTdu9aCo=;
        b=qineUoh/Ehl84tl+IwyVh4oIzp0P4b9/ZZHh/UvYWvTWMu1KUpRwilcMFw5x4OgmRd
         W29Gwox49ffavSUzVM3OWXl2Bu2radKYSGSXlYJWRceiBlPSZEX6d/9g8EUnRPkDjCOZ
         MhvXPH7/6Fgq14NvxyG/WLxIjIZHtoZb5svAGzpttJagqPV23CgBKXZoR/aoume0svtV
         Om/k+lQSZI+bPUq6mJcA4EbPOzugle/t6K6O54xrx6C16+ooZv1nXJeSp/nMPDwPFPMI
         PmZi01uSN5TFTVLzD957/Dl2vP5jyhhcZ9TyPVrJ/4JhBwzB4O46nZaTIldTgqCU3pyJ
         F+pQ==
X-Gm-Message-State: AOAM531XlOhFBBoXdlqOr3Kr18bxCihLm5TWNkJ48b7KC+HqBK8C4BvQ
        /Q2GBNSphg9uAC0n+RA1vtopM5/namAMQyZSkks=
X-Google-Smtp-Source: ABdhPJx4x9coVigiDEH8ub9gtrMWljgioSsR3Qapk8JSWOT2qTRTgFPOxOWfO6GlFSI1Ih2iAXzlu+NtsGVm9XJW8KU=
X-Received: by 2002:a05:6512:374f:: with SMTP id a15mr44367705lfs.571.1641371269768;
 Wed, 05 Jan 2022 00:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
 <20220105221237.2659462-5-yanjun.zhu@linux.dev> <YdVONs32Ue7R0kk1@unreal>
In-Reply-To: <YdVONs32Ue7R0kk1@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 5 Jan 2022 16:27:38 +0800
Message-ID: <CAD=hENeUv_7GjgDrZWr5wUmECtGY8=a=sPmbRanmh4zxLWzecA@mail.gmail.com>
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

On Wed, Jan 5, 2022 at 3:52 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Jan 05, 2022 at 05:12:36PM -0500, yanjun.zhu@linux.dev wrote:
> > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> >
> > Use the standard method to produce udp source port.
> >
> > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_verbs.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > index 0aa0d7e52773..42fa81b455de 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > @@ -469,6 +469,12 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
> >       if (err)
> >               goto err1;
> >
> > +     if ((mask & IB_QP_AV) && (attr->ah_attr.ah_flags & IB_AH_GRH))
>
> You are leaving src_port default and wired to same port as other QPs
> without any randomization.

Hi,

I do not get you. Why do you think I am leaving src_pport default?
Thanks.

Zhu Yanjun

>
> Thanks
>
> > +             qp->src_port = rdma_get_udp_sport(attr->ah_attr.grh.flow_label,
> > +                                               qp->ibqp.qp_num,
> > +                                               qp->attr.dest_qp_num);
> > +
> > +
> >       return 0;
> >
> >  err1:
> > --
> > 2.27.0
> >
