Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A96330F748
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 17:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbhBDQJ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 11:09:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237830AbhBDQJE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Feb 2021 11:09:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4084964E2C;
        Thu,  4 Feb 2021 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612454903;
        bh=txPXBIGmiwT7IeAwhnGxF2Tlruhb37UE8hGf5GjDxZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AWbaHneKOcayoWmdkWD7imt9Ar0yjQ+0NSqDzdLtkPu16P7sJ0/Q8SGj3SR05Cu5T
         QT9SN96Raj6U4Abibr0THqtrn3Mrcf92O34ezRPxUlz16aEJVVoBPuu2GghaS0bzUj
         +bDvwx19Z5TAcGNqAX9lH1Iw1Yaw4PXSP559oM07MIea+V0smFk5K+4odXvnI0p39w
         3FRgFlUGlf3W9ye0ZFpmYydJc3s4Ti5dwDqaiQETNPfRUj7rcNOpSCmAb0RNBLhJlo
         gklPTSuIURl6ojLtUubojQwjdCeoU5hfzKKefVRcLWT3IIX0TubClUJ6wQeaLdpiKT
         /SdpzTKNKJH3Q==
Date:   Thu, 4 Feb 2021 18:08:20 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Amit Matityahu <mitm@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1] RDMA/ucma: Fix use-after-free bug in
 ucma_create_uevent
Message-ID: <20210204160820.GD93433@unreal>
References: <20210125121556.838290-1-leon@kernel.org>
 <20210203200116.GA740542@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203200116.GA740542@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 03, 2021 at 04:01:16PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 25, 2021 at 02:15:56PM +0200, Leon Romanovsky wrote:
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index e17ba841e204..7ce4d9dea826 100644
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -352,7 +352,13 @@ struct ib_device *cma_get_ib_dev(struct cma_device *cma_dev)
> >
> >  struct cma_multicast {
> >  	struct rdma_id_private *id_priv;
> > -	struct ib_sa_multicast *sa_mc;
> > +	union {
> > +		struct ib_sa_multicast *sa_mc;
> > +		struct {
> > +			struct work_struct work;
> > +			struct rdma_cm_event event;
> > +		} iboe_join;
> > +	};
> >  	struct list_head	list;
> >  	void			*context;
> >  	struct sockaddr_storage	addr;
> > @@ -1839,6 +1845,12 @@ static void destroy_mc(struct rdma_id_private *id_priv,
> >  			cma_igmp_send(ndev, &mgid, false);
> >  			dev_put(ndev);
> >  		}
> > +
> > +		if (cancel_work_sync(&mc->iboe_join.work))
> > +			/* Compensate for cma_iboe_join_work_handler that
> > +			 * didn't run.
> > +			 */
> > +			cma_id_put(mc->id_priv);
>
> Just get rid of the cma_id_get in cma_iboe_join_multicast() and don't
> have this if

Why do you think that it is safe to queue work without refcount?

Thanks
