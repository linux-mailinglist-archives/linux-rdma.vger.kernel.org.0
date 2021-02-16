Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A962631C837
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Feb 2021 10:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhBPJlh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Feb 2021 04:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhBPJlg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Feb 2021 04:41:36 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DACEC061756
        for <linux-rdma@vger.kernel.org>; Tue, 16 Feb 2021 01:40:56 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id lu16so626752ejb.9
        for <linux-rdma@vger.kernel.org>; Tue, 16 Feb 2021 01:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hf+TqxG+BeZ0zpEr8rwyPa4dylBZgTcbuPaZ1LOp5ms=;
        b=IxgSkQmfYtzxnaFJVVyCtoAMF9siiAXUCJKMyoMtz50q4FXPy9VUmojEG2RfBy4uzy
         esHb3sOk5uKcFQXvnpthrFhonWDL09rYsEJYDdSW59L4uPYwuzRWB4YnHCYUbNAUQws1
         dWUKWd7RqBZeBWcCGe/AulrBbILIGDJBXeFmpcxUMkEhtQzKJ8pIusItFdR4bY/O/Wzu
         IRr+nt7VFXN70IAMIPTmxQDJoAOX3g0yEvFK928yWdcmA49UsnXjdym/1WKqBX3w5Uq9
         1G3JF8Ae0mgemhEp0F3jnhIpRzCWHTWLP2kXVGH1qJt/mT0u9Hm2e5SyQ7a8jdMCt7od
         Mp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hf+TqxG+BeZ0zpEr8rwyPa4dylBZgTcbuPaZ1LOp5ms=;
        b=ODZgayEf9Kjny/NcCyclsFbUIj3Ani2fmZTAAEELIXC7sWA5bzwK9IVxU/BY81RYrh
         SYpGmwspgw/srYkvRtyVp4xKLzDglL4UB+zPaAg72sXYtYuVhMKcrf5PDyaB1px5r5Om
         TPzkOkMW1VVNQBSzEsdaGuxnTXh1QeFVg6n6/tyt5NMMfhZfVzPEkdvqPjUnRdvxDEJQ
         jthWwvLSMeoQznxli2mWKjO6piilpEfvhcQUdz7NIHHlZ9PgEH/JQAAKcJttFo19Ze6c
         ei6W+KpRDqONpQMqH0TDKumDSmZP+T4GaE3SP4SlAb+g2fMqTUb3OFOW6uuOW8x8BDg9
         a1oQ==
X-Gm-Message-State: AOAM530RNsXFLDTTkj1Ih6fJttf+jPWQ06yhvEFDECKSfdOOOOmMrlst
        0u60VHSB9m9JBonw+Vfwg503qM7aXomPFpwz+/mApQ==
X-Google-Smtp-Source: ABdhPJzTsmgW3MdISpN2Qz47D1xOpcIrq7eEr6zGeAiIyI/sF18DfVwd1bgQ/hI/OoE9CkCdOiEpOXJLDZWMzju1s7E=
X-Received: by 2002:a17:906:d8b5:: with SMTP id qc21mr18927677ejb.62.1613468454669;
 Tue, 16 Feb 2021 01:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20210216073958.13957-1-jinpu.wang@cloud.ionos.com>
 <YCt5Nv+czQtYqQL9@unreal> <CAMGffEmKu4mfWMLUaJeOrkV526rh=FSSns0zfbDvwii33HLAhw@mail.gmail.com>
 <YCt/r3oyOmvXVORn@unreal>
In-Reply-To: <YCt/r3oyOmvXVORn@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 16 Feb 2021 10:40:44 +0100
Message-ID: <CAMGffE=r=Q4qUbyqW_PQDiFqraJ4WFtRbipbaeALjGLixi_A=A@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs-srv: suppress warnings passing zero to 'PTR_ERR'
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 16, 2021 at 9:17 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Feb 16, 2021 at 09:02:03AM +0100, Jinpu Wang wrote:
> > Hi Leon,
> > On Tue, Feb 16, 2021 at 8:50 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Tue, Feb 16, 2021 at 08:39:58AM +0100, Jack Wang wrote:
> > > > smatch warnings:
> > > > drivers/infiniband/ulp/rtrs/rtrs-srv.c:1805 rtrs_rdma_connect() warn: passing zero to 'PTR_ERR'
> > > >
> > > > Smatch seems confused by the refcount_read condition, so just
> > > > treat it seperately.
> > > >
> > > > Fixes: f0751419d3a1 ("RDMA/rtrs: Only allow addition of path to an already established session")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > index eb17c3a08810..2f6d665bea90 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > @@ -1799,12 +1799,16 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> > > >       }
> > > >       recon_cnt = le16_to_cpu(msg->recon_cnt);
> > > >       srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
> > > > +     if (IS_ERR(srv)) {
> > > > +             err = PTR_ERR(srv);
> > > > +             goto reject_w_err;
> > > > +     }
> > > >       /*
> > > >        * "refcount == 0" happens if a previous thread calls get_or_create_srv
> > > >        * allocate srv, but chunks of srv are not allocated yet.
> > > >        */
> > > > -     if (IS_ERR(srv) || refcount_read(&srv->refcount) == 0) {
> > > > -             err = PTR_ERR(srv);
> > > > +     if (refcount_read(&srv->refcount) == 0) {
> > >
> > > I would say that "list_add(&srv->ctx_list, &ctx->srv_list);" line in the
> > > get_or_create_srv() is performed too early,
> > Moving list_add down to the end was the initial code, but we noticed
> > the memory allocation could take quite
> > some time when system under memory pressure, hence we  changed it in
> > d715ff8acbd5 ("RDMA/rtrs-srv: Don't guard the whole __alloc_srv with
> > srv_mutex")
>
> You don't need to hold lock during allocation, only during search in the list.
Thanks, I will try and test.

>
> Thanks
>
> >
> > Thanks for the comment.
