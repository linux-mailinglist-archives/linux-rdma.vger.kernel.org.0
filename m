Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69B241C440
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Sep 2021 14:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245225AbhI2MGb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 08:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245211AbhI2MGb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Sep 2021 08:06:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7141D61406;
        Wed, 29 Sep 2021 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632917090;
        bh=OmNdazFoMZCKQ8r4ReuRZKLs38PLrawSuhZV6i5Gql0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFbvC0gwC5XJG2wnE8cftn0JFyJh++cnHSw5Y0bfFsBCEz1UoB7O4xQqBpHSn+oMZ
         a9rc1Uppa/Q4K+hjr2UlPkIBHz/eHvynhVtf9Lv6v89aNyaRZF99csS+wRzppomGMf
         TQRHK4ts55in7YWK3QhatMqKddMXFK0ympW9bkr5tUc0BJVwP2mkhIDJT3PYRClUam
         AqvAzvwuUBUI6ecs8hz2n4U5T6lOGG3TNAUFtF7JEbjaUKNwZsaFlQhWC1rn2j7bCf
         /ojKUxMnsuJ9m2PgAQpvBef2QT+I/XIrdVLSWaKNoCUswd4WTFaZdu++Ujjgpi+1KC
         djxg3Cqa6tb8A==
Date:   Wed, 29 Sep 2021 15:04:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <xjtuwjp@gmail.com>
Cc:     Md Haris Iqbal <haris.iqbal@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jack Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Subject: Re: [PATCH for-next 6/7] RDMA/rtrs: Do not allow sessname to contain
 special symbols / and .
Message-ID: <YVRWXim7T0mReBu/@unreal>
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
 <20210922125333.351454-7-haris.iqbal@ionos.com>
 <YVG3cme0KX9CD4oh@unreal>
 <CAD+HZHWTZY=6W4MNEGwVi=e64MJtntVE1Hwm6Lt_m=UaAW2W-A@mail.gmail.com>
 <YVLEIVz1mCV0cZlC@unreal>
 <CAD+HZHW5u1MiB-+C784yYXZc9Q-F0yB+1EvRKb4sAQJe4p2Yeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD+HZHW5u1MiB-+C784yYXZc9Q-F0yB+1EvRKb4sAQJe4p2Yeg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 29, 2021 at 09:00:56AM +0200, Jack Wang wrote:
> Leon Romanovsky <leon@kernel.org> 于2021年9月28日周二 上午9:28写道：
> >
> > On Tue, Sep 28, 2021 at 09:08:26AM +0200, Jack Wang wrote:
> > > Leon Romanovsky <leon@kernel.org> 于2021年9月27日周一 下午2:23写道：
> > > >
> > > > On Wed, Sep 22, 2021 at 02:53:32PM +0200, Md Haris Iqbal wrote:
> > > > > Allowing these characters in sessname can lead to unexpected results,
> > > > > particularly because / is used as a separator between files in a path,
> > > > > and . points to the current directory.
> > > > >
> > > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > > > Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > > Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
> > > > > ---
> > > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
> > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++++
> > > > >  2 files changed, 11 insertions(+)
> > > >
> > > > It will be safer if you check for only allowed symbols and disallow
> > > > everything else. Check for: a-Z, 0-9 and "-".
> > > >
> > > Hi Leon,
> > >
> > > Thanks for your suggestions.
> > > The reasons we choose to do disallow only '/' and '.':
> > > 1 more flexible, most UNIX filenames allow any 8-bit set, except '/' and null.
> >
> > So you need to add all possible protections and checks that VFS has to allow "random" name.
> It's only about sysfs here, as we use sessname to create dir in sysfs,
> and I checked the code, it allows any 8-bit set, and convert '/' to
> '!', see https://elixir.bootlin.com/linux/latest/source/lib/kobject.c#L299
> >
> > > 2 matching for 2 characters is faster than checking all the allowed
> > > symbols during session establishment.
> >
> > Extra CPU cycles won't make any difference here.
> As we can have hundreds of sessions, in the end, it matters.

Your rtrs_clt_open() function is far from being optimized for
performance. It allocates memory, iterates over all paths, creates
sysfs and kobject.

So no, it doesn't matter here.

Thanks

> 
> Thanks
> >
> > > 3 we do use hostnameA@hostnameB for production usage right now, we
> > > don't want to break the user space.
> >
> > You can add "@" into the list of accepted symbols.
> >
> > >
> > > I hope this makes sense to you.
> > >
> > > Regards!
> > >
> > > >
> > > > >
> > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > index bc8824b4ee0d..15c0077dd27e 100644
> > > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > @@ -2788,6 +2788,12 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
> > > > >       struct rtrs_clt *clt;
> > > > >       int err, i;
> > > > >
> > > > > +     if (strchr(sessname, '/') || strchr(sessname, '.')) {
> > > > > +             pr_err("sessname cannot contain / and .\n");
> > > > > +             err = -EINVAL;
> > > > > +             goto out;
> > > > > +     }
> > > > > +
> > > > >       clt = alloc_clt(sessname, paths_num, port, pdu_sz, ops->priv,
> > > > >                       ops->link_ev,
> > > > >                       reconnect_delay_sec,
> > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > index 078a1cbac90c..7df71f8cf149 100644
> > > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > @@ -803,6 +803,11 @@ static int process_info_req(struct rtrs_srv_con *con,
> > > > >               return err;
> > > > >       }
> > > > >
> > > > > +     if (strchr(msg->sessname, '/') || strchr(msg->sessname, '.')) {
> > > > > +             rtrs_err(s, "sessname cannot contain / and .\n");
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +
> > > > >       if (exist_sessname(sess->srv->ctx,
> > > > >                          msg->sessname, &sess->srv->paths_uuid)) {
> > > > >               rtrs_err(s, "sessname is duplicated: %s\n", msg->sessname);
> > > > > --
> > > > > 2.25.1
> > > > >
