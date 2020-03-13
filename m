Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 345F6184995
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 15:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgCMOiZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 10:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgCMOiZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Mar 2020 10:38:25 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 292BF206B7;
        Fri, 13 Mar 2020 14:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584110305;
        bh=LAROUZH0ZdI47kfsza59B3j5jmqIhlWji0PKLZQ6sDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aM66vj1XybH6I7LOViYTlnJ3aUIh/jiOSEcmwMqLNgUWKpW6huYgw1iJSkUOlKW40
         Qn2VFCsYg8bTAOH68gOkAx0iP7+Z9NXtj1bKfxxecuZ9Nx2M+Rqs3g1NxwtB8qUoDn
         59y/UK8GU1ClIAj043wjn3Dx7T8fAhq+obgns1+c=
Date:   Fri, 13 Mar 2020 16:38:19 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 03/11] RDMA/efa: Use in-kernel offsetofend()
 to check field availability
Message-ID: <20200313143819.GK31504@unreal>
References: <20200310091438.248429-1-leon@kernel.org>
 <20200310091438.248429-4-leon@kernel.org>
 <20200313134456.GA24733@ziepe.ca>
 <20200313135714.GH31504@unreal>
 <20200313142602.GE31668@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313142602.GE31668@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 11:26:02AM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 13, 2020 at 03:57:14PM +0200, Leon Romanovsky wrote:
> > On Fri, Mar 13, 2020 at 10:44:56AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Mar 10, 2020 at 11:14:30AM +0200, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@mellanox.com>
> > > >
> > > > Remove custom and duplicated variant of offsetofend().
> > > >
> > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > >  drivers/infiniband/hw/efa/efa_verbs.c | 7 ++-----
> > > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> > > > index bf3120f140f7..5c57098a4aee 100644
> > > > +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> > > > @@ -144,9 +144,6 @@ static inline bool is_rdma_read_cap(struct efa_dev *dev)
> > > >  	return dev->dev_attr.device_caps & EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK;
> > > >  }
> > > >
> > > > -#define field_avail(x, fld, sz) (offsetof(typeof(x), fld) + \
> > > > -				 sizeof_field(typeof(x), fld) <= (sz))
> > > > -
> > > >  #define is_reserved_cleared(reserved) \
> > > >  	!memchr_inv(reserved, 0, sizeof(reserved))
> > > >
> > > > @@ -609,7 +606,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
> > > >  	if (err)
> > > >  		goto err_out;
> > > >
> > > > -	if (!field_avail(cmd, driver_qp_type, udata->inlen)) {
> > > > +	if (offsetofend(typeof(cmd), driver_qp_type) > udata->inlen) {
> > >
> > > The > needs to be >=, and generally we write compares as
> > >    'variable XX constant'
> >
> > Why ">="
> > The original code is
> > if (!field_avail(cmd, driver_qp_type, udata->inlen))
> > ==>
> > if (!(offsetof(typeof(cmd), driver_qp_type) + sizeof_field(typeof(cmd), driver_qp_type,) <= (udata->inlen))
> > ===>
> > if (!(offsetofend(typeof(cmd), driver_qp_type) <= (udata->inlen))
> > ===>
> > if (offsetofend(typeof(cmd), driver_qp_type) > (udata->inlen)
> >
> > like I wrote.
>
> Oh ok, I missed the !

So can you apply this patch too?

Thanks

>
> Jason
