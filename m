Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7948D26E4B1
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 20:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgIQQU3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 12:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbgIQQUQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 12:20:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 761492137B;
        Thu, 17 Sep 2020 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600359595;
        bh=gYe5DyvwAgt5wykW+r3mFKkfVURkDP3rpA0dZzlhz2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSx7ArgPxMWw7Xapjiatmgqc45fZS6AhLmgLT2nmVupO0wF6xKwSphMaJONULzMco
         2x573l26ZEF1EArpsB/enRqB2xQkowhE7mApmeNzXqBHzln7r/tfPdz13JCSTZx2fP
         K63iq1j6bASABzWOZE3Aqzw6z0Y1rr3LyeRrr9OE=
Date:   Thu, 17 Sep 2020 19:19:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 01/14] RDMA/cma: Delete from restrack DB
 after successful destroy
Message-ID: <20200917161950.GF869610@unreal>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-2-leon@kernel.org>
 <20200917120636.GA103244@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917120636.GA103244@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 17, 2020 at 09:06:36AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 07, 2020 at 03:21:43PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Update the code to have similar destroy pattern like other IB objects.
> >
> > This change create asymmetry to the rdma_id_private create flow to make
> > sure that memory is managed by restrack.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/cma.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index f9ff8b7f05e7..24e09416de4f 100644
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -1821,7 +1821,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,
> >  {
> >  	cma_cancel_operation(id_priv, state);
> >
> > -	rdma_restrack_del(&id_priv->res);
> >  	if (id_priv->cma_dev) {
> >  		if (rdma_cap_ib_cm(id_priv->id.device, 1)) {
> >  			if (id_priv->cm_id.ib)
> > @@ -1847,6 +1846,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
> >  		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
> >
> >  	put_net(id_priv->id.route.addr.dev_addr.net);
> > +	rdma_restrack_del(&id_priv->res);
> >  	kfree(id_priv);
> >  }
>
> This is wrong, rdma_restrack_del() has to be called before
> ib_destroy_cm_id() because restrack reaches into the cm_id and touches
> that memory:
>
> 	case RDMA_RESTRACK_CM_ID:
> 		return container_of(res, struct rdma_id_private,
> 				    res)->id.device;
>
> Which will now be freed after this change.

We access "id" which is struct rdma_cm_id, while ib_destroy_cm_id()
releases something different struct ib_cm_id cm_id.ib.

"id" is embedded into id_priv released later in _destroy_id() function.

Thanks

>
> Jason
