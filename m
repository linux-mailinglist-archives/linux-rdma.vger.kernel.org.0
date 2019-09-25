Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 058CEBD833
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 08:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfIYGQY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 02:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390491AbfIYGQX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Sep 2019 02:16:23 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A8D2054F;
        Wed, 25 Sep 2019 06:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569392182;
        bh=TMgy5szIW+DPZ1xRKChK67Z3kr+ZTD64reyMuMfxd40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCJ5qArBB5mFpS3DT8JFKgQlMJAzsm8fOeTMYR5VwKvOtbCa3nDdhdKGCS5sVtgGF
         4zUGsskGCH2yKuq8jFfjA2kfTYl4zRs9mOJ9x+QKsMxz6o9dH70Dp3gGaAPADISCs1
         oWNXQUJqiuclL4Bn8RznUb5YckobGMjLgHgebOWY=
Date:   Wed, 25 Sep 2019 09:16:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH 1/4] RDMA/cm: Fix memory leak in cm_add/remove_one
Message-ID: <20190925061617.GV14368@unreal>
References: <20190916071154.20383-1-leon@kernel.org>
 <20190916071154.20383-2-leon@kernel.org>
 <20190916184544.GG2585@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916184544.GG2585@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 16, 2019 at 06:45:48PM +0000, Jason Gunthorpe wrote:
> On Mon, Sep 16, 2019 at 10:11:51AM +0300, Leon Romanovsky wrote:
> > From: Jack Morgenstein <jackm@dev.mellanox.co.il>
> >
> > In the process of moving the debug counters sysfs entries, the commit
> > mentioned below eliminated the cm_infiniband sysfs directory.
> >
> > This sysfs directory was tied to the cm_port object allocated in procedure
> > cm_add_one().
> >
> > Before the commit below, this cm_port object was freed via a call to
> > kobject_put(port->kobj) in procedure cm_remove_port_fs().
> >
> > Since port no longer uses its kobj, kobject_put(port->kobj) was eliminated.
> > This, however, meant that kfree was never called for the cm_port buffers.
> >
> > Fix this by adding explicit kfree(port) calls to functions cm_add_one()
> > and cm_remove_one().
> >
> > Note: the kfree call in the first chunk below (in the cm_add_one error
> > flow) fixes an old, undetected memory leak.
> >
> > Fixes: c87e65cfb97c ("RDMA/cm: Move debug counters to be under relevant IB device")
> > Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/cm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> > index da10e6ccb43c..5920c0085d35 100644
> > +++ b/drivers/infiniband/core/cm.c
> > @@ -4399,6 +4399,7 @@ static void cm_add_one(struct ib_device *ib_device)
> >  error1:
> >  	port_modify.set_port_cap_mask = 0;
> >  	port_modify.clr_port_cap_mask = IB_PORT_CM_SUP;
> > +	kfree(port);
> >  	while (--i) {
> >  		if (!rdma_cap_ib_cm(ib_device, i))
> >  			continue;
> > @@ -4407,6 +4408,7 @@ static void cm_add_one(struct ib_device *ib_device)
> >  		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
> >  		ib_unregister_mad_agent(port->mad_agent);
> >  		cm_remove_port_fs(port);
> > +		kfree(port);
> >  	}
> >  free:
> >  	kfree(cm_dev);
> > @@ -4460,6 +4462,7 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
> >  		spin_unlock_irq(&cm.state_lock);
> >  		ib_unregister_mad_agent(cur_mad_agent);
> >  		cm_remove_port_fs(port);
> > +		kfree(port);
> >  	}
>
> This whole thing is looking pretty goofy now, and I suspect there are
> more error unwind bugs here.
>
> How about this instead:
>
> From e8dad20c7b69436e63b18f16cd9457ea27da5bc1 Mon Sep 17 00:00:00 2001
> From: Jack Morgenstein <jackm@dev.mellanox.co.il>
> Date: Mon, 16 Sep 2019 10:11:51 +0300
> Subject: [PATCH] RDMA/cm: Fix memory leak in cm_add/remove_one
>
> In the process of moving the debug counters sysfs entries, the commit
> mentioned below eliminated the cm_infiniband sysfs directory, and created
> some missing cases where the port pointers were not being freed as the
> kobject_put was also eliminated.
>
> Rework this to not allocate port pointers and consolidate all the error
> unwind into one sequence.
>
> This also fixes unlikely racey bugs where error-unwind after unregistering
> the MAD handler would miss flushing the WQ and other clean up that is
> necessary once concurrency starts.
>
> Fixes: c87e65cfb97c ("RDMA/cm: Move debug counters to be under relevant IB device")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/cm.c | 187 ++++++++++++++++++-----------------
>  1 file changed, 94 insertions(+), 93 deletions(-)

The proposed patch doesn't pass sanity check and unfortunately, I don't
have time now to debug it.

$ ./rping -V -S 256 -C 100 -p 19663 -P -a 192.168.0.1 -s &
$ ./rping -V -S 256 -C 100 -p 19663 -a 192.168.0.1 -c -I 192.168.0.1
   rdma_connect: Invalid argument
   connect error -1
   <hang>

Thanks
