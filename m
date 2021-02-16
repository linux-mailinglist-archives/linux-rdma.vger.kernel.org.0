Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA6531C73F
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Feb 2021 09:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBPITr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Feb 2021 03:19:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhBPISg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Feb 2021 03:18:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5E3064DC3;
        Tue, 16 Feb 2021 08:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613463475;
        bh=74xis2DdtmOor5q/2VVhqj1F8qr9Aixa7yrXciYUGc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTOC4D11Z/d+tmet7gr55ZlPdUV64NVFUqy19PM7w8HYLfmennou1W/3lk+RvW6O4
         4L4fMh2C/XyiVkCviP265hSZkiPmQwD9B7t69RaD7f2yf/pTOyb0xyVWQRwFq/FsMI
         smH1ba/fmOqsraWn6iYAoPzXiAXDWT0Z4T8BJfojdwRp1abetGd3QcP0rkN4UlRz50
         BJEiJei/Nac5ov7kOvVjbmM9HxeIuedrXCcMTTARrEZDXntrX+dnxPTXzeQlYFd4eF
         Diz8gx6gx/Es7jaPnoJSA3Hqmq+yXe0A9bd4vbEgxX4EnOEW8o40/onbo2PNhONFHF
         xALJLdNVJfr3g==
Date:   Tue, 16 Feb 2021 10:17:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] RDMA/rtrs-srv: suppress warnings passing zero to
 'PTR_ERR'
Message-ID: <YCt/r3oyOmvXVORn@unreal>
References: <20210216073958.13957-1-jinpu.wang@cloud.ionos.com>
 <YCt5Nv+czQtYqQL9@unreal>
 <CAMGffEmKu4mfWMLUaJeOrkV526rh=FSSns0zfbDvwii33HLAhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmKu4mfWMLUaJeOrkV526rh=FSSns0zfbDvwii33HLAhw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 16, 2021 at 09:02:03AM +0100, Jinpu Wang wrote:
> Hi Leon,
> On Tue, Feb 16, 2021 at 8:50 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Feb 16, 2021 at 08:39:58AM +0100, Jack Wang wrote:
> > > smatch warnings:
> > > drivers/infiniband/ulp/rtrs/rtrs-srv.c:1805 rtrs_rdma_connect() warn: passing zero to 'PTR_ERR'
> > >
> > > Smatch seems confused by the refcount_read condition, so just
> > > treat it seperately.
> > >
> > > Fixes: f0751419d3a1 ("RDMA/rtrs: Only allow addition of path to an already established session")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > index eb17c3a08810..2f6d665bea90 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > @@ -1799,12 +1799,16 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> > >       }
> > >       recon_cnt = le16_to_cpu(msg->recon_cnt);
> > >       srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
> > > +     if (IS_ERR(srv)) {
> > > +             err = PTR_ERR(srv);
> > > +             goto reject_w_err;
> > > +     }
> > >       /*
> > >        * "refcount == 0" happens if a previous thread calls get_or_create_srv
> > >        * allocate srv, but chunks of srv are not allocated yet.
> > >        */
> > > -     if (IS_ERR(srv) || refcount_read(&srv->refcount) == 0) {
> > > -             err = PTR_ERR(srv);
> > > +     if (refcount_read(&srv->refcount) == 0) {
> >
> > I would say that "list_add(&srv->ctx_list, &ctx->srv_list);" line in the
> > get_or_create_srv() is performed too early,
> Moving list_add down to the end was the initial code, but we noticed
> the memory allocation could take quite
> some time when system under memory pressure, hence we  changed it in
> d715ff8acbd5 ("RDMA/rtrs-srv: Don't guard the whole __alloc_srv with
> srv_mutex")

You don't need to hold lock during allocation, only during search in the list.

Thanks

>
> Thanks for the comment.
