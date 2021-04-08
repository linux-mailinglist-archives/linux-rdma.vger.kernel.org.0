Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96F3358514
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 15:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhDHNqJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 09:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhDHNqI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 09:46:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DC8C061761
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 06:45:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id mh7so3120910ejb.12
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 06:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2udXZfHYItdmnYFneWtCfKYRnX1qViGmu0HKbVcM0g=;
        b=C3gm+lKPmpSoIxFjkzYtewVTyo/FZBDRqHVeOIdLjCjKPGDlg5v7H1y5gIcmj2Ks9v
         lmIFg9SfOcndRKkFGx9eEl0f1S85SDg1ofYVnmPo6nkLiYbW/Jy2R87yLmugakbksqXS
         1ykK211Sm3MYQ1yVdquFLZXC27re3Ld2xHxCB+I5xcTdr1sj6bePtTK1BpnuoA3OYnGT
         RJDNLHVZZTgBm1TboW6QQ8+230EjRfwpyzmi5Olg8hUHvw8P9JwrAcWP3GVIuMRwZ5G8
         fSHjKqh9xBGRrSBjciDXn5UpOB0m2OkoJEpVyeqNPLv+GJ+OJO1dT+4m9Ab23PaUvf3o
         MKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2udXZfHYItdmnYFneWtCfKYRnX1qViGmu0HKbVcM0g=;
        b=ahM0++3aPeAFjDtVbygvZF3H23fc7SFd0Mr7ZDoMGVuVjppZquK7i5RoOnJpm5oKiw
         DyZJ+OfdmPH9M8FR9/gMpmrlF4YIwwjLJxkU0cwe9vqmyA5T/IeB/0chR6RAy010YT60
         G+wxcPd+xYA/DJqNsB+wLdRO1wsRK6jJS3Puft8rOaqaJKh+BcbKTz6Oq/TrzRu6MsXh
         Dsn01otS/24kv76MhI/FePrpOUSNKtK2ODvdxIrP1gVwwLYPeVg7FbWvCj5fLtiqnIcH
         ybBLDWBCWVrW1PRlb8Kjsf4d3Cza0pHff0cqmSlpb5PjMh1pegOkq9SryKxvd6wLxXby
         v66Q==
X-Gm-Message-State: AOAM530OGflRYvxNmknj37OkQTvPbiK5ZDkr3+A+y5n2ez/C/rarwMF4
        4ZfQq1LQcmY3xTdZkY4SQPjFaCnul+zLRfU3hkPjsQ==
X-Google-Smtp-Source: ABdhPJxRkMCq8f7TVwgGLFUlOZs7+xJoQKOy3ZFqbTSWdV4T92sX/eHTUIskM/S7GmWN87BXKMlkm2JVwrhem8QK/8w=
X-Received: by 2002:a17:906:46c8:: with SMTP id k8mr8265403ejs.389.1617889556231;
 Thu, 08 Apr 2021 06:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com> <20210325153308.1214057-13-gi-oh.kim@ionos.com>
 <20210401184448.GA1647065@nvidia.com> <CAJX1Ytao0LMYkGPy+E4XQzyxZFSytRDuwB2By2HQ6VBS7btCWg@mail.gmail.com>
 <20210408120418.GQ7405@nvidia.com>
In-Reply-To: <20210408120418.GQ7405@nvidia.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 8 Apr 2021 15:45:45 +0200
Message-ID: <CAMGffE=pu7uhmsBaYBuZB2w+YOogrK+W5yEKRPZxTanx5+f0Gg@mail.gmail.com>
Subject: Re: [PATCH for-next 12/22] RDMA/rtrs-clt: Check state of the
 rtrs_clt_sess before reading its stats
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 8, 2021 at 2:04 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Apr 06, 2021 at 10:55:59AM +0200, Gioh Kim wrote:
> > On Thu, Apr 1, 2021 at 8:44 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Thu, Mar 25, 2021 at 04:32:58PM +0100, Gioh Kim wrote:
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > index 42f49208b8f7..1519191d7154 100644
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > @@ -808,6 +808,9 @@ static struct rtrs_clt_sess *get_next_path_min_inflight(struct path_it *it)
> > > >       int inflight;
> > > >
> > > >       list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {
> > > > +             if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
> > > > +                     continue;
> > >
> > > There is no way this could be right, a READ_ONCE can't guarentee that
> > > a following load is not going to happen without races.
> > >
> > > You need locking.
> >
> > Hi Jason,
> >
> > rtrs_clt_request() calls rcu_read_lock() before calling
> > get_next_path_min_inflight().
> > And rtrs_clt_change_state_from_to(), that changes the sess->state,
> > calls spin_lock_irq() before changing it.
> > I think that is enough, isn't it?
>
> Why would that be enough?
>
> Under RCU this check is racy and effetively does nothing.
>
> This is an OK usage of RCU:
>
>         list_del_rcu(&sess->s.entry);
>
>         /* Make sure everybody observes path removal. */
>         synchronize_rcu();
>
> And you could say that observing the sess in the list is required, but
> checking state is pointless.
>
> Jason
Hi Jason

Sending IO via disconnected session is not a problem, it will just get
an error. It's only about if in the meantime user delete the path
while IO running, and session is freed.

There is session state machine it will go CONNECTED to CLOSED will be
a few steps, disconnect, drain QP/etc,  the cpu will get the latest
state sooner or later.
We don't really care if there's a few cycles sess->state is no up to date.

Regards!
