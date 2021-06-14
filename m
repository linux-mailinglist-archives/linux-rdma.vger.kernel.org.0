Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471463A5CBA
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jun 2021 08:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhFNGJP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Jun 2021 02:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhFNGJM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Jun 2021 02:09:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06D0C061574
        for <linux-rdma@vger.kernel.org>; Sun, 13 Jun 2021 23:07:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r7so30452640edv.12
        for <linux-rdma@vger.kernel.org>; Sun, 13 Jun 2021 23:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1h4TYpPMMObiC8cdwoWcjYut6ndBoHW97lNHs9UZqYI=;
        b=eTO1N02D81gJXNE+P7muJx2317CyE8QiYX1+vd1H/Xt11vv0Xp4bYQmvGmLb31RpDg
         z413jQZFQwxeE+RZ/cM3d4SCfU2RDb5MvxuAevPKPR3ruqeVuzRSele1cdifl8S9fTL1
         xHBklq17EDWZdS+YrH2vZqxsbAc/+znJWlH12AgOzrX6UBFIbBPqxviIl0xePtKAamii
         +EXJ6G7Brk2sjAXaLgYjAgRlb6p0QIkuteYQ/gKIfREi9FSg0+4ckDTMzErWCh2kBCQe
         z4d39CJ+G9Oe6KqCW8vLx51Pmo1GcaFh0kwIwRZV/UR1/KHhTSHMnS2R7JQfNhoY1bE7
         qH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1h4TYpPMMObiC8cdwoWcjYut6ndBoHW97lNHs9UZqYI=;
        b=UVeVFrcJ2oA2r/8bBjZB8pva60xWTbmsUvqKQOwJA4TOgMr0lw8Tqfh5V9hb6HIePD
         hLlAM86XPsZKexeDpB8JwYyRF0lnWbN920KWh/LD/eLcIvAyzL8NNterkd+Jmz70EzdL
         bfGNTTK4AmDL70JmW1e0d+rQNmqjCcScGhx68mrQE4kVwcXUtS1Ot+7NiQtLXFg+BKY5
         xnxT7sw4kHYmTLtgvFuPttd4AorD2xM7a2tSzxnr8qKhMm7mXkywMoMfY2Xq3TWltymq
         f599vHORfX4y0Ya1DA84pFmDCOfD82qdV4CJXt3PC1GQR0fK+LTPX1b9JewYAIll3Y1A
         Ctzw==
X-Gm-Message-State: AOAM531Re69BQZ6Ii6whOJfub4BMgKekkaeWoJhURGuWB8NlgAKeUexx
        OzkzO7xAIeWqtXJGuOJRcufHHW5XLO6YnYUMwR+VgA==
X-Google-Smtp-Source: ABdhPJwaJ0wQe9j1OvA1CFQ0p0mrxLXWrQcpkLZnwiDZI6JdLhqf8LyEI1933pPq5RDnm291FkAv/zubtnSZo4Ubrz0=
X-Received: by 2002:a05:6402:48f:: with SMTP id k15mr15117538edv.262.1623650828333;
 Sun, 13 Jun 2021 23:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210611121034.48837-1-jinpu.wang@ionos.com> <20210611121034.48837-4-jinpu.wang@ionos.com>
 <YMWkvJmA3rjfUjoK@unreal>
In-Reply-To: <YMWkvJmA3rjfUjoK@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 14 Jun 2021 08:06:57 +0200
Message-ID: <CAMGffEkB0gkt=_ZsgVnR1aYMKB=PsJdW=-9tFCPJSDXCVwZZpA@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 3/5] RDMA/rtrs: RDMA_RXE requires more number
 of WR
To:     Leon Romanovsky <leon@kernel.org>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 13, 2021 at 12:12 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Jun 11, 2021 at 02:10:32PM +0200, Jack Wang wrote:
> > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> >
> > When using rdma_rxe, post_one_recv() returns
> > NOMEM error due to the full recv queue.
> > This patch increase the number of WR for receive queue
> > to support all devices.
> >
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 ++++---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> >
>
> NOMEM -> ENOMEM
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Thanks for the review, I will address all the comments in the next round.

Regards!
