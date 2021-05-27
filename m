Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CFD392AB0
	for <lists+linux-rdma@lfdr.de>; Thu, 27 May 2021 11:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhE0J1O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 May 2021 05:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbhE0J1N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 May 2021 05:27:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B35C061574
        for <linux-rdma@vger.kernel.org>; Thu, 27 May 2021 02:25:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a5so6262303lfm.0
        for <linux-rdma@vger.kernel.org>; Thu, 27 May 2021 02:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJWDG0x5hmvmBul/Q3qGakGO8DJLQhwz2E01+5Exm7k=;
        b=dH/IKjJWTcwp35AbFPn7IKpMT+5X4msQfmFK5ZLHZpCYVxg2leOoN7E9OsyDeurWqs
         U21mmv8bErXBkmW8syeEl4K5xAr4wTGmy2exAUJ832O61AwV3Xc4PlnQeX1l9j6oDxZ+
         V1DmK3RnvXReon70po7T8uLXwFCwkSVZJFiRX2/R/knZ6IfJG4cuCK4DEiNEA4Z2WBKW
         sYaRirkn+DlgGiYDRasTa48ag/MPaLuioAbK92VsrOjqZc2gqOJO9/M/1JPb95+lVXOO
         ximWDivxeQMyeaFxsUBtzTAbGSHAEWFxGjhwcSBc7rLpqZdk0SsOpwDSvMizLmvQ/P7E
         eUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJWDG0x5hmvmBul/Q3qGakGO8DJLQhwz2E01+5Exm7k=;
        b=CsK1pFaPYe8NCsRBOUethcFHWSZhFewvLOJl620rWgmR0tgDYlBWBTp61A9RMbn7kk
         kiFLS3lafHP5dz9qz2ipNcHZWxbv/g8glEJlFK3DEpp6T0+6w7ZmSHJGdgvmENT3nnAB
         a4tmr0GjB+5CgKS87POVdBidi3zSpyqCTeMCv1ZMEiwM80BKyF0jZjtPCnx26i6I0yaz
         qertdwUvz5t8Q8X9oOQfSuabL6V2Yj84m0QlM/1xU8nMqtOFd9M1lfBn0elYEeyfZHqx
         Vxs6r9rbPJV2WwV7cZg4pth/t2bcBzDh4ir1qoDVg6VfQb0bY49vgfb46gCBV2MV53AC
         hWWQ==
X-Gm-Message-State: AOAM531GzvqLvxN09vbDQHYmSxrdzUDUT5rsduR47l2ye/FZ54Vb6V/5
        gga4Qq7FykHCsBnHKR7WAa18S5gP97+8JBsHCN6urQ==
X-Google-Smtp-Source: ABdhPJy6DALJLqq20ZlHPVDyws3t/62gscoQZTSXd+bINyIE2meIm7E9tjTAgoCf+EhEOL9A+OjhK9lkgsIsi2GwCB0=
X-Received: by 2002:a05:6512:2192:: with SMTP id b18mr1792033lft.422.1622107538761;
 Thu, 27 May 2021 02:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210517091844.260810-1-gi-oh.kim@ionos.com> <20210517091844.260810-14-gi-oh.kim@ionos.com>
 <20210525201543.GA3482418@nvidia.com> <CAJpMwyh2Xw2CpWZBeVS3mTKOXFx6qQymZkxsUSA1oiGaohRJzg@mail.gmail.com>
 <CAMGffEnX4OQnmqrK4AaDQ=dSE1e4LrHWNUQQSiL_viL_emQYyw@mail.gmail.com>
In-Reply-To: <CAMGffEnX4OQnmqrK4AaDQ=dSE1e4LrHWNUQQSiL_viL_emQYyw@mail.gmail.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Thu, 27 May 2021 11:25:27 +0200
Message-ID: <CAJpMwyg3HpEvfapLGFLUnB8FJo6yY6OLUErS+=6oyo4L5Y543A@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 13/19] RDMA/rtrs-srv: Replace atomic_t with
 percpu_ref for ids_inflight
To:     Jinpu Wang <jinpu.wang@ionos.com>
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

On Wed, May 26, 2021 at 11:38 AM Jinpu Wang <jinpu.wang@ionos.com> wrote:
>
> On Wed, May 26, 2021 at 11:17 AM Haris Iqbal <haris.iqbal@ionos.com> wrote:
> >
> > On Tue, May 25, 2021 at 10:15 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Mon, May 17, 2021 at 11:18:37AM +0200, Gioh Kim wrote:
> > > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > >
> > > > ids_inflight is used to track the inflight IOs. But the use of atomic_t
> > > > variable can cause performance drops and can also become a performance
> > > > bottleneck.
> > > >
> > > > This commit replaces the use of atomic_t with a percpu_ref structure. The
> > > > advantage it offers is, it doesn't check if the reference has fallen to 0,
> > > > until the user explicitly signals it to; and that is done by the
> > > > percpu_ref_kill() function call. After that, the percpu_ref structure
> > > > behaves like an atomic_t and for every put call, checks whether the
> > > > reference has fallen to 0 or not.
> > > >
> > > > rtrs_srv_stats_rdma_to_str shows the count of ids_inflight as 0
> > > > for user-mode tools not to be confused.
> > > >
> > > > Fixes: 9cb837480424e ("RDMA/rtrs: server: main functionality")
> > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 12 +++---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 43 +++++++++++++-------
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  4 +-
> > > >  3 files changed, 35 insertions(+), 24 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> > > > index e102b1368d0c..df1d7d6b1884 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> > > > @@ -27,12 +27,10 @@ ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
> > > >                                   char *page, size_t len)
> > > >  {
> > > >       struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
> > > > -     struct rtrs_srv_sess *sess = stats->sess;
> > > >
> > > > -     return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
> > > > -                      (s64)atomic64_read(&r->dir[READ].cnt),
> > > > -                      (s64)atomic64_read(&r->dir[READ].size_total),
> > > > -                      (s64)atomic64_read(&r->dir[WRITE].cnt),
> > > > -                      (s64)atomic64_read(&r->dir[WRITE].size_total),
> > > > -                      atomic_read(&sess->ids_inflight));
> > > > +     return sysfs_emit(page, "%lld %lld %lld %lldn\n",
> > > > +                       (s64)atomic64_read(&r->dir[READ].cnt),
> > > > +                       (s64)atomic64_read(&r->dir[READ].size_total),
> > > > +                       (s64)atomic64_read(&r->dir[WRITE].cnt),
> > > > +                       (s64)atomic64_read(&r->dir[WRITE].size_total));
> > > >  }
> > >
> > > This seems like an unrelated hunk
> >
> > Previous to the commit, ids_inflight was an atomic variable, and hence
> > was read and printed along with other rtrs_srv stats. With this
> > commit, since ids_inflight is changed to percpu_ref, we removed it
> > being printed in rtrs_srv stats. Its related to the commit.
> I think Jason meant the sysfs_emit conversion should be in a separate patch.

Okay. I missed that.

Thanks; will send the updated patches.

> >
> >
> > >
> > > Jason
