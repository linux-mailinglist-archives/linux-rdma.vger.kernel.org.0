Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E4F41A4F1
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 03:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbhI1Bsb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 21:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238481AbhI1Bsb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Sep 2021 21:48:31 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527EFC061575
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 18:46:52 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so27021413ota.6
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 18:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKjO8hw7E19jI4Du54qaL21EF3PUglKxxqEjuLa+jCM=;
        b=JyuTuOaalIHRK9yeivGJiJ4ioPaYl3SuMzspB7wzpc6lJX/MKIPKC4tyUJQEsN/TZ0
         +3IIdmd6gkP6W9ckZS+i+5pNxn38PnK3cdwXrbUwK0BUh+kePabhK5j5WFHibiolUWCy
         GEEX31W8StXT04Q1yLuayNWH72H+d4yqNoz46aSApL4X9ealA8f8ReQxIw/ES5qAgTuO
         VomZpkyRBa4acPywRIzrcChMkJ15y3jY2Z0CHdk6cQcHTfArVnp6xyggbHFwmoHtzS3f
         FOM1UHqe6TJaTnUxA8uHenZDrome0LGwioOlEdQFamwasMqe7GV9YHTeRZ5PbGhdW80q
         AENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKjO8hw7E19jI4Du54qaL21EF3PUglKxxqEjuLa+jCM=;
        b=wnJq7dYeZBkvIv+EJHiokocQPFr+UsGF1I4mHvhE7ABbrLmUVAm34yx5msC/RFKU/P
         KUU0ZYSZAXvekJRQqwEoEEnLeoHyQOVolzt988cUTgIZofnISSnf0tTyGWoGaoBbFOk2
         rNC/278cC/56o0YnIVPgMvNQxwg92NqgpThDRxXo5wKs8kAyfDm1wFVcbb/6BVeFMrlO
         KrDRTJM2zODISpCuNCrnF4rR7nkS/yxWeeeAzyHDwDZSfKRtad/rg0g72rlvwMYLakRX
         FPlsIRXEdd6SpFuOFqn5QIbY/V7WivIPU8tXFN3sv9Pt4AaiXsQmAbzFNM+fVVZtGUpk
         MW+w==
X-Gm-Message-State: AOAM532sYm2D3pEmJCN6o0UzrPUKfdYtNyPZ6IR0uHPK+Oqm1BQvv1Fa
        wi0J15NqpQd2me5p0hGX7wxZXeK8N/QOXEcwLwE=
X-Google-Smtp-Source: ABdhPJwvAoufxk2GBvd5+mDjmmL4kigNFxiRP0/zip3jL6bWAfQgJ5k6xWO8Qro3SHUy+NHdiqxkt1YUMZdRF0o0sp4=
X-Received: by 2002:a9d:4e91:: with SMTP id v17mr2837919otk.297.1632793611747;
 Mon, 27 Sep 2021 18:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210915011220.307585-1-Rao.Shoaib@oracle.com> <20210927191907.GA1582097@nvidia.com>
In-Reply-To: <20210927191907.GA1582097@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 28 Sep 2021 09:46:40 +0800
Message-ID: <CAD=hENd0BDMS6BL_M2rDT7N8sZySQHLbzDEfWZ0AvSd6nmFmoQ@mail.gmail.com>
Subject: Re: [PATCH v1] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Rao Shoaib <Rao.Shoaib@oracle.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 28, 2021 at 3:19 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Sep 14, 2021 at 06:12:20PM -0700, Rao Shoaib wrote:
> > In our internal testing we have found that
> > default maximum values are too small.
> > Ideally there should be no limits, but since
> > maximum values are reported via ibv_query_device,
> > we have to return some value. So, the default
> > maximums have been changed to large values.
> >
> > Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
> > ---
> >
> > Resubmitting the patch after applying Bob's latest patches and testing
> > using via rping.
> >
> >  drivers/infiniband/sw/rxe/rxe_param.h | 30 ++++++++++++++-------------
> >  1 file changed, 16 insertions(+), 14 deletions(-)
>
> So are we good with this? Bob? Zhu?

I have already checked this commit. And I have found 2 problems with
this commit.
This commit changes many MAXs.
And now rxe is not stable enough. Not sure this commit will cause the
new problems.

Zhu Yanjun

>
> > -     RXE_MAX_MR_INDEX                = 0x00010000,
> > +     RXE_MAX_MR_INDEX                = DEFAULT_MAX_VALUE,
> > +     RXE_MAX_MR                      = DEFAULT_MAX_VALUE - RXE_MIN_MR_INDEX,
>
> Bob, were you saying this was what needed to be bigger to pass
> blktests??
>
> Jason
