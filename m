Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264C741A9AD
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 09:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbhI1HaQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Sep 2021 03:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239083AbhI1HaQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Sep 2021 03:30:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 841DD60FC0;
        Tue, 28 Sep 2021 07:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632814117;
        bh=ldzNzVRsHf4OCPhUO2CCMizY6pdOlBEXalIuU4Lfuq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dophtF1PeUqWFIRu6FZd7t41oSxJxeXozL3ggzakdBeZoS57AAgF/WI8NSmpPdpKl
         zS60xBq2A8D0qKGSfTX8QTC1yrDXhi/cfDt5CLfQV8Z3R+frkkKt2+6wOvDBYJcoRx
         6ERBOZUlQgArUVscJjZDgvRulMe5gY2D2H5VzRhsV9A8T2GEqWint2JXNGmlFnwHsb
         3eAKD8En6eHBhqo6q4tvWxHNwIpxmz6raMO/5SmD5Ir2hwTEeeMHY8fMpIBSZLR1ns
         zKvHNM/AsIJqrdZNuGcIsz67ar8JSpI3jIznmNndfH3gM2z9EpQsqs3EHXPO0Bx6BF
         NgN11XGXgG8fA==
Date:   Tue, 28 Sep 2021 10:28:33 +0300
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
Message-ID: <YVLEIVz1mCV0cZlC@unreal>
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
 <20210922125333.351454-7-haris.iqbal@ionos.com>
 <YVG3cme0KX9CD4oh@unreal>
 <CAD+HZHWTZY=6W4MNEGwVi=e64MJtntVE1Hwm6Lt_m=UaAW2W-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD+HZHWTZY=6W4MNEGwVi=e64MJtntVE1Hwm6Lt_m=UaAW2W-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 28, 2021 at 09:08:26AM +0200, Jack Wang wrote:
> Leon Romanovsky <leon@kernel.org> 于2021年9月27日周一 下午2:23写道：
> >
> > On Wed, Sep 22, 2021 at 02:53:32PM +0200, Md Haris Iqbal wrote:
> > > Allowing these characters in sessname can lead to unexpected results,
> > > particularly because / is used as a separator between files in a path,
> > > and . points to the current directory.
> > >
> > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++++
> > >  2 files changed, 11 insertions(+)
> >
> > It will be safer if you check for only allowed symbols and disallow
> > everything else. Check for: a-Z, 0-9 and "-".
> >
> Hi Leon,
> 
> Thanks for your suggestions.
> The reasons we choose to do disallow only '/' and '.':
> 1 more flexible, most UNIX filenames allow any 8-bit set, except '/' and null.

So you need to add all possible protections and checks that VFS has to allow "random" name.

> 2 matching for 2 characters is faster than checking all the allowed
> symbols during session establishment.

Extra CPU cycles won't make any difference here.

> 3 we do use hostnameA@hostnameB for production usage right now, we
> don't want to break the user space.

You can add "@" into the list of accepted symbols.

> 
> I hope this makes sense to you.
> 
> Regards!
> 
> >
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > index bc8824b4ee0d..15c0077dd27e 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > @@ -2788,6 +2788,12 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
> > >       struct rtrs_clt *clt;
> > >       int err, i;
> > >
> > > +     if (strchr(sessname, '/') || strchr(sessname, '.')) {
> > > +             pr_err("sessname cannot contain / and .\n");
> > > +             err = -EINVAL;
> > > +             goto out;
> > > +     }
> > > +
> > >       clt = alloc_clt(sessname, paths_num, port, pdu_sz, ops->priv,
> > >                       ops->link_ev,
> > >                       reconnect_delay_sec,
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > index 078a1cbac90c..7df71f8cf149 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > @@ -803,6 +803,11 @@ static int process_info_req(struct rtrs_srv_con *con,
> > >               return err;
> > >       }
> > >
> > > +     if (strchr(msg->sessname, '/') || strchr(msg->sessname, '.')) {
> > > +             rtrs_err(s, "sessname cannot contain / and .\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > >       if (exist_sessname(sess->srv->ctx,
> > >                          msg->sessname, &sess->srv->paths_uuid)) {
> > >               rtrs_err(s, "sessname is duplicated: %s\n", msg->sessname);
> > > --
> > > 2.25.1
> > >
