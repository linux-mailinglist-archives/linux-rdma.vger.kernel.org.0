Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87F7391384
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 11:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhEZJSe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 05:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhEZJSe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 05:18:34 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE98C061574
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 02:17:02 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id w15so685474ljo.10
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 02:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ko2UxlXFXsR8uDKA3n1q+PlE7RejPivDVfcksGNd8S0=;
        b=ZQip1zDixRJ5JT3Zj4zKGdiEHXdkJb1Qll/GD/LlxjtQx2ia4n8zDtCQFGUfvkPqjK
         QiAw/fROIx+573ERM0sJSGw7r/1RskE56GLstsxi7p46up+pe+LDQ1yfjsgHahxqDZ3l
         flqS5gM/bGUjn29kPYh4wSQh118YWfsWUVwuH4iKooo3VyuZHdQw2sH5cXC50761nFqF
         ar1AXYnrGmw7wsk7N0IUmkk8+PwvyZMfIDhfJ48BOaO5jdcelTPTJ20FI9xaSwZHGR9P
         cYVviaOuEPI2E7rbnpUYgLwO78Inlie9IloqAqVXg4SV0A0pykUHZExiJ6BRUPHPokxW
         plPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ko2UxlXFXsR8uDKA3n1q+PlE7RejPivDVfcksGNd8S0=;
        b=UhaeC51g1lmvwGm+xfKXr/xDYaSSdXRs6B5hF0z067HabBBMKkmtHOBwkfEgfuVH8J
         pvp7B7NBJiwk/QaZjHckeBfUS4YlfJk04pDNccEGKHp04jzfXScgr2yBeeqxYVRAPSJ5
         jjzLi9iwTuF2/uOOj3ga0kS5WUtULb6esvHcK25yFXTkj1rOMZeS5mWE438YRtPSGNl5
         q2Y+FpEEHjDXvO8AzRYLBA/ISwnMUEaDTUeSgX6boGPD0nCJ7KsHm7namJrN0lz99ksT
         Xe7YfjlvO5Sd2OzjcMe+yvPZhsvlOUgAS8SPVXkg0UxhAy5XOGAc264lkWFfGEbUTTDA
         6Clw==
X-Gm-Message-State: AOAM533RIMeOoI1yuqYf7uEkAu77YE7T6VFM5UO/YgYF5qYtZ1/ZONw+
        exk47sRxaW62T6oLO2aZaojuBVlKYPScPjT6THflYg==
X-Google-Smtp-Source: ABdhPJx3VMqKQvRy0/wI0ZOvD7TvM5fJ6RPQhvzydq7drAIOiWPdrOOUWMapid3IkcahxGAYZJs/OfoFtnMLcRHKUdE=
X-Received: by 2002:a05:651c:232:: with SMTP id z18mr1502764ljn.489.1622020620764;
 Wed, 26 May 2021 02:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210517091844.260810-1-gi-oh.kim@ionos.com> <20210517091844.260810-14-gi-oh.kim@ionos.com>
 <20210525201543.GA3482418@nvidia.com>
In-Reply-To: <20210525201543.GA3482418@nvidia.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 26 May 2021 11:16:49 +0200
Message-ID: <CAJpMwyh2Xw2CpWZBeVS3mTKOXFx6qQymZkxsUSA1oiGaohRJzg@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 13/19] RDMA/rtrs-srv: Replace atomic_t with
 percpu_ref for ids_inflight
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 10:15 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, May 17, 2021 at 11:18:37AM +0200, Gioh Kim wrote:
> > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> >
> > ids_inflight is used to track the inflight IOs. But the use of atomic_t
> > variable can cause performance drops and can also become a performance
> > bottleneck.
> >
> > This commit replaces the use of atomic_t with a percpu_ref structure. The
> > advantage it offers is, it doesn't check if the reference has fallen to 0,
> > until the user explicitly signals it to; and that is done by the
> > percpu_ref_kill() function call. After that, the percpu_ref structure
> > behaves like an atomic_t and for every put call, checks whether the
> > reference has fallen to 0 or not.
> >
> > rtrs_srv_stats_rdma_to_str shows the count of ids_inflight as 0
> > for user-mode tools not to be confused.
> >
> > Fixes: 9cb837480424e ("RDMA/rtrs: server: main functionality")
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 12 +++---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 43 +++++++++++++-------
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  4 +-
> >  3 files changed, 35 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> > index e102b1368d0c..df1d7d6b1884 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> > @@ -27,12 +27,10 @@ ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
> >                                   char *page, size_t len)
> >  {
> >       struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
> > -     struct rtrs_srv_sess *sess = stats->sess;
> >
> > -     return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
> > -                      (s64)atomic64_read(&r->dir[READ].cnt),
> > -                      (s64)atomic64_read(&r->dir[READ].size_total),
> > -                      (s64)atomic64_read(&r->dir[WRITE].cnt),
> > -                      (s64)atomic64_read(&r->dir[WRITE].size_total),
> > -                      atomic_read(&sess->ids_inflight));
> > +     return sysfs_emit(page, "%lld %lld %lld %lldn\n",
> > +                       (s64)atomic64_read(&r->dir[READ].cnt),
> > +                       (s64)atomic64_read(&r->dir[READ].size_total),
> > +                       (s64)atomic64_read(&r->dir[WRITE].cnt),
> > +                       (s64)atomic64_read(&r->dir[WRITE].size_total));
> >  }
>
> This seems like an unrelated hunk

Previous to the commit, ids_inflight was an atomic variable, and hence
was read and printed along with other rtrs_srv stats. With this
commit, since ids_inflight is changed to percpu_ref, we removed it
being printed in rtrs_srv stats. Its related to the commit.


>
> Jason
