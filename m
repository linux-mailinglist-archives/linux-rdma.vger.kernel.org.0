Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4775A1E1290
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 18:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbgEYQXb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 12:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730015AbgEYQXa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 12:23:30 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F2F120776;
        Mon, 25 May 2020 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590423810;
        bh=X9InZHg6KUj4lKOKmKwxr3q1kuaZJXiBw4Vf76pyMBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnGqF7l06avYAYMPOw5vZDlUGo8WYTt7/78e//N00Q5P/AjYxwnWqiA3RCJoMOj6v
         nHFzEC5hUduNVrt/fHzD3UGQRPofRS32GAhB3T6z0LpUH8Pz3LGl0UsRYrLvB5ekYZ
         PW/8f7qio3RxBgeEwHbQfJK5aQH4cCIbUW9+IQaY=
Date:   Mon, 25 May 2020 19:23:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 06/14] RDMA/core: Add restrack dummy ops
Message-ID: <20200525162326.GC10591@unreal>
References: <20200513095034.208385-1-leon@kernel.org>
 <20200513095034.208385-7-leon@kernel.org>
 <20200525143650.GA21729@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525143650.GA21729@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 11:36:50AM -0300, Jason Gunthorpe wrote:
> On Wed, May 13, 2020 at 12:50:26PM +0300, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@mellanox.com>
> >
> > When fill_res_entry is not implemented by the vendor, then we just
> > need to return 0. Reduce some code and make it more clear by
> > set dummy ops.
> >
> > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/nldev.c    | 46 ++++--------------------------
> >  drivers/infiniband/core/restrack.c | 13 +++++++++
> >  2 files changed, 19 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > index 8548f09746ab..8b4115bc26b2 100644
> > --- a/drivers/infiniband/core/nldev.c
> > +++ b/drivers/infiniband/core/nldev.c
> > @@ -446,22 +446,6 @@ static int fill_res_name_pid(struct sk_buff *msg,
> >  	return err ? -EMSGSIZE : 0;
> >  }
> >
> > -static bool fill_res_entry(struct ib_device *dev, struct sk_buff *msg,
> > -			   struct rdma_restrack_entry *res)
> > -{
> > -	if (!dev->ops.fill_res_entry)
> > -		return false;
> > -	return dev->ops.fill_res_entry(msg, res);
> > -}
> > -
> > -static bool fill_stat_entry(struct ib_device *dev, struct sk_buff *msg,
> > -			    struct rdma_restrack_entry *res)
> > -{
> > -	if (!dev->ops.fill_stat_entry)
> > -		return false;
> > -	return dev->ops.fill_stat_entry(msg, res);
> > -}
> > -
> >  static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
> >  			     struct rdma_restrack_entry *res, uint32_t port)
> >  {
> > @@ -515,10 +499,7 @@ static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
> >  	if (fill_res_name_pid(msg, res))
> >  		goto err;
> >
> > -	if (fill_res_entry(dev, msg, res))
> > -		goto err;
> > -
> > -	return 0;
> > +	return dev->ops.fill_res_entry(msg, res);
> >
> >  err:	return -EMSGSIZE;
> >  }
> > @@ -568,10 +549,7 @@ static int fill_res_cm_id_entry(struct sk_buff *msg, bool has_cap_net_admin,
> >  	if (fill_res_name_pid(msg, res))
> >  		goto err;
> >
> > -	if (fill_res_entry(dev, msg, res))
> > -		goto err;
> > -
> > -	return 0;
> > +	return dev->ops.fill_res_entry(msg, res);
> >
> >  err: return -EMSGSIZE;
> >  }
> > @@ -606,10 +584,7 @@ static int fill_res_cq_entry(struct sk_buff *msg, bool has_cap_net_admin,
> >  	if (fill_res_name_pid(msg, res))
> >  		goto err;
> >
> > -	if (fill_res_entry(dev, msg, res))
> > -		goto err;
> > -
> > -	return 0;
> > +	return dev->ops.fill_res_entry(msg, res);
> >
> >  err:	return -EMSGSIZE;
> >  }
> > @@ -641,10 +616,7 @@ static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
> >  	if (fill_res_name_pid(msg, res))
> >  		goto err;
> >
> > -	if (fill_res_entry(dev, msg, res))
> > -		goto err;
> > -
> > -	return 0;
> > +	return dev->ops.fill_res_entry(msg, res);
> >
> >  err:	return -EMSGSIZE;
> >  }
> > @@ -784,15 +756,9 @@ static int fill_stat_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
> >  	struct ib_device *dev = mr->pd->device;
> >
> >  	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_MRN, res->id))
> > -		goto err;
> > -
> > -	if (fill_stat_entry(dev, msg, res))
> > -		goto err;
> > -
> > -	return 0;
> > +		return -EMSGSIZE;
> >
> > -err:
> > -	return -EMSGSIZE;
> > +	return dev->ops.fill_stat_entry(msg, res);
> >  }
> >
> >  static int fill_stat_counter_hwcounters(struct sk_buff *msg,
> > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > index 62fbb0ae9cb4..093b27c0bbe6 100644
> > --- a/drivers/infiniband/core/restrack.c
> > +++ b/drivers/infiniband/core/restrack.c
> > @@ -14,6 +14,17 @@
> >  #include "cma_priv.h"
> >  #include "restrack.h"
> >
> > +static int fill_res_dummy(struct sk_buff *msg,
> > +			  struct rdma_restrack_entry *entry)
> > +{
> > +	return 0;
> > +}
> > +
> > +static const struct ib_device_ops restrack_dummy_ops = {
> > +	.fill_res_entry = fill_res_dummy,
> > +	.fill_stat_entry = fill_res_dummy,
> > +};
>
> If you are going to do this then you should do it for substantially
> everything, as we did in rdma-core. I don't want to see easy stuff
> like this half done..
>
> And this should be a broken out series or two as it really has nothing
> to do with 'raw format dumps'

Maor will be committed to do it. Can we merge this series because I see it is
an independent task?

Thanks

>
> Jason
