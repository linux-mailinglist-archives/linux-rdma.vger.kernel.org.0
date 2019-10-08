Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57AAACF44E
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 09:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfJHHwP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 03:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730177AbfJHHwP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Oct 2019 03:52:15 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF30206BB;
        Tue,  8 Oct 2019 07:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570521134;
        bh=eqQUq8n+2nr36mfjdnaJJaHrzFs7zZEI9uDV4qBzThQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u1XdiLey5Ait7LPtRfT0L8gvyWqDSC1tEswTh/bcjpfkyXfhtN/n4eBZghUmGCAQW
         ARBPb8wp/ZdPAJ6P6Tn3MhRfO98ZFi58AUmxLzPV82WX1WgM7A7wdnuj4PkkSyAWru
         xmotTfywrS9k6Wfn1avfFvebuwD4CVBuIncA4rdY=
Date:   Tue, 8 Oct 2019 10:52:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 2/2] RDMA/core: Check that process is still
 alive before sending it to the users
Message-ID: <20191008075210.GF5855@unreal>
References: <20191002123245.18153-1-leon@kernel.org>
 <20191002123245.18153-3-leon@kernel.org>
 <AM0PR05MB4866CB24D8105C83B31988A3D19B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB4866CB24D8105C83B31988A3D19B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 07, 2019 at 06:58:13PM +0000, Parav Pandit wrote:
>
>
> > -----Original Message-----
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Leon Romanovsky
> > Sent: Wednesday, October 2, 2019 7:33 AM
> > To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe
> > <jgg@mellanox.com>
> > Cc: Leon Romanovsky <leonro@mellanox.com>; RDMA mailing list <linux-
> > rdma@vger.kernel.org>
> > Subject: [PATCH rdma-next 2/2] RDMA/core: Check that process is still alive
> > before sending it to the users
> >
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > The PID information can disappear asynchronically because task can be killed
> > and moved to zombie state. In such case, PID will be zero in similar way to the
> > kernel tasks. Recognize such situation where we are asking to return orphaned
> > object and simply skip filling PID attribute.
> >
> > As part of this change, document the same scenario in counter.c code.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/counters.c | 14 ++++++++++++--
> >  drivers/infiniband/core/nldev.c    | 31 ++++++++++++++++++++++--------
> >  2 files changed, 35 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/counters.c
> > b/drivers/infiniband/core/counters.c
> > index 12ba2685abcf..47c551a0bcb0 100644
> > --- a/drivers/infiniband/core/counters.c
> > +++ b/drivers/infiniband/core/counters.c
> > @@ -149,8 +149,18 @@ static bool auto_mode_match(struct ib_qp *qp, struct
> > rdma_counter *counter,
> >  	struct auto_mode_param *param = &counter->mode.param;
> >  	bool match = true;
> >
> > -	/* Ensure that counter belongs to the right PID */
> > -	if (task_pid_nr(counter->res.task) != task_pid_nr(qp->res.task))
> > +	/*
> > +	 * Ensure that counter belongs to the right PID.
> > +	 * This operation can race with user space which kills
> > +	 * the process and leaves QP and counters orphans.
> > +	 *
> > +	 * It is not a big deal because exitted task will leave both
> > +	 * QP and counter in the same bucket of zombie process. Just ensure
> > +	 * that process is still alive before procedding.
> > +	 *
> > +	 */
> > +	if (task_pid_nr(counter->res.task) != task_pid_nr(qp->res.task) ||
> > +	    !task_pid_nr(qp->res.task))
> >  		return false;
> >
> >  	if (auto_mask & RDMA_COUNTER_MASK_QP_TYPE) diff --git
> > a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c index
> > 71bc08510064..c6fe0c52f6dc 100644
> > --- a/drivers/infiniband/core/nldev.c
> > +++ b/drivers/infiniband/core/nldev.c
> > @@ -399,20 +399,35 @@ static int fill_res_info(struct sk_buff *msg, struct
> > ib_device *device)  static int fill_res_name_pid(struct sk_buff *msg,
> >  			     struct rdma_restrack_entry *res)  {
> > +	int err = 0;
> > +	pid_t pid;
> > +
> >  	/*
> >  	 * For user resources, user is should read /proc/PID/comm to get the
> >  	 * name of the task file.
> >  	 */
> >  	if (rdma_is_kernel_res(res)) {
> > -		if (nla_put_string(msg,
> > RDMA_NLDEV_ATTR_RES_KERN_NAME,
> > -		    res->kern_name))
> > -			return -EMSGSIZE;
> > -	} else {
> > -		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PID,
> > -		    task_pid_vnr(res->task)))
> > -			return -EMSGSIZE;
> > +		err = nla_put_string(msg,
> > RDMA_NLDEV_ATTR_RES_KERN_NAME,
> > +				     res->kern_name);
> > +		goto out;
> >  	}
> > -	return 0;
> > +
> > +	pid = task_pid_vnr(res->task);
> > +	/*
> > +	 * PID == 0 returns in two scenarios:
> > +	 * 1. It is kernel task, but because we checked above, it won't be
> > possible.
> Please drop above comment point 1. See more below.
>
> > +	 * 2. Task is dead and in zombie state. There is no need to print PID
> > anymore.
> > +	 */
> > +	if (pid)
> > +		/*
> > +		 * This part is racy, task can be killed and PID will be zero right
> > +		 * here but it is ok, next query won't return PID. We don't
> > promise
> > +		 * real-time reflection of SW objects.
> > +		 */
> > +		err = nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PID, pid);
> > +
> > +out:
> > +	return err ? -EMSGSIZE : 0;
> >  }
>
> Below code reads better along with rest of the comments in the patch.
>
> if (kern_resource) {
> 	err = nla_put_string(msg, RDMA_NLDEV_ATTR_RES_KERN_NAME,
> 			     res->kern_name);
> } else {
> 	pid_t pid;
>
> 	pid = task_pid_vnr(res->task);
> 	if (pid)
> 		err = nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PID, pid);
> }

Why do you think that nested "if" reads better?

Thanks

>
> >
> >  static bool fill_res_entry(struct ib_device *dev, struct sk_buff *msg,
> > --
> > 2.20.1
>
