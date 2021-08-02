Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41AB3DDAF2
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 16:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhHBO0S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 10:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236707AbhHBOYb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Aug 2021 10:24:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C4C04986B
        for <linux-rdma@vger.kernel.org>; Mon,  2 Aug 2021 07:18:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p38so19062436lfa.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Aug 2021 07:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRBm0+UevPs0YU5RTOdmVbbXAy2pyV8IK/mATwhCgsA=;
        b=NUeEEidP+BWUlt7vv/PigFniB6EPnVkgMdfhd0kqXikjRjnai6hliFMwi/H89UsLca
         M19P7tPHn9DA4mPc+ZCCTyrkrR5i+PTo81B/lWQJVd5pmadkJMjB/RqS4QNtI/Q0tkYt
         MUI+Yqrah4WsdW8D0lsBqamGThP/aNWOE5Z4YVpDJIbD5rVgwd5RWAhFwp+frgjIbefb
         +HW1AVUSPTh8Dmxw3BYuq4gz8G0P/slii8o6+DcTKmZEpSrGYpZd6srbEnqMpCbynLEM
         6PwcgToPtvNoBXfeM6Icghxytx9tee4wvYIldvb/2vkTntCRWTevA911AHusOnZF6yAo
         irew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRBm0+UevPs0YU5RTOdmVbbXAy2pyV8IK/mATwhCgsA=;
        b=ZaktUpcFLwZASTOAhfWcv3jnYgmy83JLsB58IhiLY6OKzkFygQdX2OWpQb/1l0cHS+
         7oVoqNp6RLGVExcu81NhnhNUqYtQ9BgLaR19bHZojV4LpDIzKqOp1AusmvvzqTzekZJ4
         UFNoh3W6yxETUzd/LA2Yt0aPUlSyHM6fknRLvy+MuHE35UgmMfH5GxJRMQYwnpOAEi4v
         XNzTsJLc2o09sIrVY2EYgmzNTmef9zZK3k+dUL1rP56QoY44/E75rtOPqaeB7BaJUDlS
         KSLkJ/6lG3NGB4ams7zggyN3a0cjxPQQSZKrsZzQBnahCLatVjN0eP6Y2IkzKCUQXv3h
         BqaQ==
X-Gm-Message-State: AOAM530Rv1wDZd9+/PFcljGSWzunlxlm3GVCAD1r9mxFTuNxGpLmA3P7
        DAfW5CCqZLX1dcBw5NzYDrWF7+BuYZuMk/8aNyyYig==
X-Google-Smtp-Source: ABdhPJxaCpYRX7//h4BPnKF+umIQS+3IriCkJ85+JZEznh7hJD8FtbyQLb9M53Zag0MAghHEHjeiBZrvItNjQVlYPmg=
X-Received: by 2002:a05:6512:517:: with SMTP id o23mr2085060lfb.657.1627913920395;
 Mon, 02 Aug 2021 07:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210730131832.118865-1-jinpu.wang@ionos.com> <20210730131832.118865-4-jinpu.wang@ionos.com>
 <YQeWKlcIqvXVm8PO@unreal>
In-Reply-To: <YQeWKlcIqvXVm8PO@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 2 Aug 2021 16:18:29 +0200
Message-ID: <CAJpMwyiX0v4L4epeA8xmPfzw_5YYjCza5fZh5BinZnXJpdBCMg@mail.gmail.com>
Subject: Re: [PATCH for-next 03/10] RDMA/rtrs: Use sysfs_emit instead of
 s*printf function for sysfs show
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpu.wang@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 2, 2021 at 8:52 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Jul 30, 2021 at 03:18:25PM +0200, Jack Wang wrote:
> > From: Md Haris Iqbal <haris.iqbal@ionos.com>
> >
> > sysfs_emit function was added to be aware of the PAGE_SIZE maximum of
> > the temporary buffer used for outputting sysfs content, so there is no
> > possible overruns. So replace the uses of any s*printf functions for
> > the sysfs show functions with sysfs_emit.
> >
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 24 +++++++++-----------
> >  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  2 +-
> >  2 files changed, 12 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> > index 26bbe5d6dff5..c5c047aa45a4 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> > @@ -45,24 +45,23 @@ int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats,
> >       size_t used;
> >       int cpu;
> >
> > -     used = scnprintf(buf, len, "    ");
> > +     used = sysfs_emit(buf, "    ");
> >       for_each_possible_cpu(cpu)
> > -             used += scnprintf(buf + used, len - used, " CPU%u", cpu);
> > +             used += sysfs_emit_at(buf, used, " CPU%u", cpu);
> >
> > -     used += scnprintf(buf + used, len - used, "\nfrom:");
> > +     used += sysfs_emit_at(buf, used, "\nfrom:");
>
> "\nfrom" and "\nto" are abuse of sysfs rules.
> https://lore.kernel.org/kernelnewbies/7a353c64-a81f-a149-9541-ef328a197761@gmail.com/T/#m8bf898fcdb4a5371781bbc9646993a50fa950fbc
> https://lore.kernel.org/kernelnewbies/7a353c64-a81f-a149-9541-ef328a197761@gmail.com/T/#m9ce6f045a863597922012d71a6719d6d90c8e0a6

I see. We will discuss internally and see what can be done about this.

Thanks

>
> Thanks
