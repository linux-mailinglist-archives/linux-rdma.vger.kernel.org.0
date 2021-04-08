Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C198B35875D
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhDHOou (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 10:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhDHOou (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 10:44:50 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068BDC061760
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 07:44:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z1so2739690edb.8
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5HFRgTpxGtzWwoZEyMvP3ujXCvU0UI9F+3Ucm6wiRA=;
        b=Tx/lFlFkiPt3hgtZDBKANQBw+g5ChlP79FptfrWwS44ZKoW8p/IiEplQ7f0qNDNaNI
         mEPHYCZvqWOQZQVlsftn4gd/RTzp1SA9ATSW73iqjrAduLE/7k0TWOg2d1Vhaj05OMmi
         ul65KURMu6gFYOMhJQX+QuXVMYLAQC4m0emHJYsRq7tr3zzRQpcovggnK8rNm46V/9aY
         d8XpawO1lte501QRu/JJG1Z0mNjZPceN+W6VXJMW5lc2vjfiD7UORFSeuAzj5o9rvu3G
         OFeGot+VB1nzc2Phyh436f11Jvl64pbWVSkX/FxVA4yjDChcQMj3TQteHqnSQ4igzJWq
         /Hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5HFRgTpxGtzWwoZEyMvP3ujXCvU0UI9F+3Ucm6wiRA=;
        b=QJQoBZ7uJB6CjWPcY8Q8E+P+pbUGmQkstDuNb4DskDlYELEHF7j59CRem98aZlBqqt
         oq3AwnB51dEi16oGLECGyDun5E3dHmwLaxfNIURVQW4Ffu/Ucwzav5NOdKMfb03g5w5O
         CZv4NO2GI61V/YebdE2C6uG4lDvaswkdf5tGtWeP8DJMQ+Gmzanjmjb9UfaOpS4Eh382
         StP0XX8gOoakA2O1MtpqITISQg9IWlqd1FClMIlvDcs1lC3XIJghwqCCRddm5kvzDPpL
         +fle9OSugL9Nps0e3y22H09u3EirwRIBz38C8snBnxGp6ZYVoCByCfv9RTQo5EKUbP2J
         PNvg==
X-Gm-Message-State: AOAM531f60tZLiHKuEsuLhoVjBwViVgc556A92qSfq4e7kBew6MZcUfr
        z/0g/KZPV60WlLvplU0lUyOC3HGHVNbsX5UOM2vPwA==
X-Google-Smtp-Source: ABdhPJwOLTGl5tf7Qu2F8ItWbALRckSOcWHZ+VmhvJWadtQ85HR/LMJdc2OcwjV/y0PFtkc6UYxmpLSQXOxznKlzDyo=
X-Received: by 2002:a05:6402:518b:: with SMTP id q11mr11565401edd.151.1617893077729;
 Thu, 08 Apr 2021 07:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com> <20210325153308.1214057-13-gi-oh.kim@ionos.com>
 <20210401184448.GA1647065@nvidia.com> <CAJX1Ytao0LMYkGPy+E4XQzyxZFSytRDuwB2By2HQ6VBS7btCWg@mail.gmail.com>
 <20210408120418.GQ7405@nvidia.com> <CAMGffE=pu7uhmsBaYBuZB2w+YOogrK+W5yEKRPZxTanx5+f0Gg@mail.gmail.com>
 <20210408135033.GT7405@nvidia.com>
In-Reply-To: <20210408135033.GT7405@nvidia.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Thu, 8 Apr 2021 16:44:02 +0200
Message-ID: <CAJX1YtY2d6YHuDZ0Wbg+c33yoaoCa4_iO6_nT3Krb3uWZFfrag@mail.gmail.com>
Subject: Re: [PATCH for-next 12/22] RDMA/rtrs-clt: Check state of the
 rtrs_clt_sess before reading its stats
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jinpu Wang <jinpu.wang@ionos.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 8, 2021 at 3:50 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Apr 08, 2021 at 03:45:45PM +0200, Jinpu Wang wrote:
> > On Thu, Apr 8, 2021 at 2:04 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Tue, Apr 06, 2021 at 10:55:59AM +0200, Gioh Kim wrote:
> > > > On Thu, Apr 1, 2021 at 8:44 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > > >
> > > > > On Thu, Mar 25, 2021 at 04:32:58PM +0100, Gioh Kim wrote:
> > > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > > index 42f49208b8f7..1519191d7154 100644
> > > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > > @@ -808,6 +808,9 @@ static struct rtrs_clt_sess *get_next_path_min_inflight(struct path_it *it)
> > > > > >       int inflight;
> > > > > >
> > > > > >       list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {
> > > > > > +             if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
> > > > > > +                     continue;
> > > > >
> > > > > There is no way this could be right, a READ_ONCE can't guarentee that
> > > > > a following load is not going to happen without races.
> > > > >
> > > > > You need locking.
> > > >
> > > > Hi Jason,
> > > >
> > > > rtrs_clt_request() calls rcu_read_lock() before calling
> > > > get_next_path_min_inflight().
> > > > And rtrs_clt_change_state_from_to(), that changes the sess->state,
> > > > calls spin_lock_irq() before changing it.
> > > > I think that is enough, isn't it?
> > >
> > > Why would that be enough?
> > >
> > > Under RCU this check is racy and effetively does nothing.
> > >
> > > This is an OK usage of RCU:
> > >
> > >         list_del_rcu(&sess->s.entry);
> > >
> > >         /* Make sure everybody observes path removal. */
> > >         synchronize_rcu();
> > >
> > > And you could say that observing the sess in the list is required, but
> > > checking state is pointless.
> > >
> > > Jason
> > Hi Jason
> >
> > Sending IO via disconnected session is not a problem, it will just get
> > an error. It's only about if in the meantime user delete the path
> > while IO running, and session is freed.
>
> But the session can toggle to !connected immediately after the test
> above as well, so I still don't see what this is accomplishing.
>
> Jason

 The original problem was
- get_next_path_min_inflight() checks sess->state == CONNECTED
- rtrs_clt_remove_path_from_sysfs() set sess->state = RTRS_CLT_DEAD
- rtrs_clt_remove_path_from_sysfs() ->  rtrs_clt_destroy_sess_files()
-> kobject_put(sess->stats->kobj_stats) -> free sess->stats
- get_next_path_min_inflight() read sess->stats->inflight

So the patch adds checking sess->state in get_next_path_min_inflight().

I think the same problem happens after rtrs_clt_request().
- rtrs_clt_request() checks sess->state == CONNECTED
- rtrs_clt_remove_path_from_sysfs() set sess->state = RTRS_CLT_DEAD
- rtrs_clt_remove_path_from_sysfs() ->  rtrs_clt_destroy_sess_files()
-> kobject_put(sess->stats->kobj_stats) -> free sess->stats
- rtrs_clt_request()->rtrs_clt_read_req() reads sess->stats->inflight

I think it might be a solution to change the
rtrs_clt_remove_path_from_sysfs as below.
It changes the order: first remove the session from list and then
destroy sess->stat memory.

@@ -2900,8 +2900,8 @@ int rtrs_clt_remove_path_from_sysfs(struct
rtrs_clt_sess *sess,
        } while (!changed && old_state != RTRS_CLT_DEAD);

        if (likely(changed)) {
-               rtrs_clt_destroy_sess_files(sess, sysfs_self);
                rtrs_clt_remove_path_from_arr(sess);
+               rtrs_clt_destroy_sess_files(sess, sysfs_self);
                kobject_put(&sess->kobj);
        }
