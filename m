Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6E03913DF
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhEZJkR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 05:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhEZJkQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 05:40:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC5FC061574
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 02:38:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id c20so1400877ejm.3
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 02:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLHx+yN+NcA8pZ3fuZkAfmUPBqod1IBuoaflPXzNM/E=;
        b=PPEjYedCXI7Bqm3w6kXOOOAAFh1eeDIO+AjI3cYthI93VJGg09cZNZ3EcJSKvJmSVm
         twQJ4B4WQwRTp4GHEyj0+9lCGc1Yu/yI20E+2RTHdxFJu9W5cqPrO8q1mHSRxTM8rwsA
         XBsj4X6B9ajUUHuoCaLpMqAbQteme9eWI+X9l0OPTsCd1kRSzhLG+6YnwNTxiwgdD6FC
         DAYjScMDQ2b73jsQokSuw5WWDerK1Irhr2NEhWsp84Ql0vSlrP32RJCNL8MRDOlOE0Y3
         cKUT6knrksiYCGGzfMAPrMHzzygUBsdoaaRVLYJ1NU0JdvXwM7CphgujFPcNc2aAzTci
         By/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLHx+yN+NcA8pZ3fuZkAfmUPBqod1IBuoaflPXzNM/E=;
        b=Ig08fjxxdzSyj/3psEYN05xD7dsQhQ0FGMX9D084n2G3pJ46//z9iYtuFW+JI9ny59
         8v5+JCkukIQzjTq5dZmjnHzfQymK9YJCgB0eqwB9zU9yiRRgzNaRatxwAWZ1XUqfMpNw
         ajijSZnLx1yrw8aBzQSVm+E+WJ9dA2jJtlBjSPARMUmzkeSGMyLB+PqGJTJlRVHUfpOR
         GPfwYygJZKr2c+9JlI0jCeC9w8wtOFplb8ZnFjLQ2Fjzgu7hNOmamDtmjVNWzJH+bM2t
         IH9J/cmuvaZGHwJlau0RLwZd/fMkMA1URUWn1Z9gwWyqnvS1g2MgijdonX/yWAl1jr2z
         N4bQ==
X-Gm-Message-State: AOAM533JHZVqcY6yPunfnoL97tzX3tFeCfEZtfbhHIR6SnittCbsUOdw
        VmmgVpEwjUmMiv9KLRN4suH0XYv15Oh0AAqxC1stoQ==
X-Google-Smtp-Source: ABdhPJxkpsb2bRs2xgoezQJDNgzeYqz7QEf8+P6BWkZhYbT7fkBk5NsuIOtIg/E7rilH1pQrLuhl6656MCO3TpylFPg=
X-Received: by 2002:a17:906:ccde:: with SMTP id ot30mr33718349ejb.353.1622021924092;
 Wed, 26 May 2021 02:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210517091844.260810-1-gi-oh.kim@ionos.com> <20210517091844.260810-14-gi-oh.kim@ionos.com>
 <20210525201543.GA3482418@nvidia.com> <CAJpMwyh2Xw2CpWZBeVS3mTKOXFx6qQymZkxsUSA1oiGaohRJzg@mail.gmail.com>
In-Reply-To: <CAJpMwyh2Xw2CpWZBeVS3mTKOXFx6qQymZkxsUSA1oiGaohRJzg@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 26 May 2021 11:38:33 +0200
Message-ID: <CAMGffEnX4OQnmqrK4AaDQ=dSE1e4LrHWNUQQSiL_viL_emQYyw@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 13/19] RDMA/rtrs-srv: Replace atomic_t with
 percpu_ref for ids_inflight
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Gioh Kim <gi-oh.kim@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 26, 2021 at 11:17 AM Haris Iqbal <haris.iqbal@ionos.com> wrote:
>
> On Tue, May 25, 2021 at 10:15 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Mon, May 17, 2021 at 11:18:37AM +0200, Gioh Kim wrote:
> > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > >
> > > ids_inflight is used to track the inflight IOs. But the use of atomic_t
> > > variable can cause performance drops and can also become a performance
> > > bottleneck.
> > >
> > > This commit replaces the use of atomic_t with a percpu_ref structure. The
> > > advantage it offers is, it doesn't check if the reference has fallen to 0,
> > > until the user explicitly signals it to; and that is done by the
> > > percpu_ref_kill() function call. After that, the percpu_ref structure
> > > behaves like an atomic_t and for every put call, checks whether the
> > > reference has fallen to 0 or not.
> > >
> > > rtrs_srv_stats_rdma_to_str shows the count of ids_inflight as 0
> > > for user-mode tools not to be confused.
> > >
> > > Fixes: 9cb837480424e ("RDMA/rtrs: server: main functionality")
> > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 12 +++---
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 43 +++++++++++++-------
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  4 +-
> > >  3 files changed, 35 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> > > index e102b1368d0c..df1d7d6b1884 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> > > @@ -27,12 +27,10 @@ ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
> > >                                   char *page, size_t len)
> > >  {
> > >       struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
> > > -     struct rtrs_srv_sess *sess = stats->sess;
> > >
> > > -     return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
> > > -                      (s64)atomic64_read(&r->dir[READ].cnt),
> > > -                      (s64)atomic64_read(&r->dir[READ].size_total),
> > > -                      (s64)atomic64_read(&r->dir[WRITE].cnt),
> > > -                      (s64)atomic64_read(&r->dir[WRITE].size_total),
> > > -                      atomic_read(&sess->ids_inflight));
> > > +     return sysfs_emit(page, "%lld %lld %lld %lldn\n",
> > > +                       (s64)atomic64_read(&r->dir[READ].cnt),
> > > +                       (s64)atomic64_read(&r->dir[READ].size_total),
> > > +                       (s64)atomic64_read(&r->dir[WRITE].cnt),
> > > +                       (s64)atomic64_read(&r->dir[WRITE].size_total));
> > >  }
> >
> > This seems like an unrelated hunk
>
> Previous to the commit, ids_inflight was an atomic variable, and hence
> was read and printed along with other rtrs_srv stats. With this
> commit, since ids_inflight is changed to percpu_ref, we removed it
> being printed in rtrs_srv stats. Its related to the commit.
I think Jason meant the sysfs_emit conversion should be in a separate patch.
>
>
> >
> > Jason
