Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1901F874C
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2020 08:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgFNGmC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Jun 2020 02:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbgFNGmB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 14 Jun 2020 02:42:01 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94558206D7;
        Sun, 14 Jun 2020 06:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592116920;
        bh=mnAFWP4PsuyztgglwUiPObo4Mp168az8uOclib+Sb7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0wPmcK1cvU6iJL0V/3BSt6DRWJaTfO0mallMz09wGX+4nNv3I/69dGxl3BMRJrWD
         XB7VZlbdlqSPmhh9EXAqbq+tCMW4yGQ2MBCpNsiRCjo7TkCr4CPldJk2LncBL0io9Q
         FoLpwOaaPynbIf/CAZxf+ZPiRb9LWEunzR/WrZUQ=
Date:   Sun, 14 Jun 2020 09:41:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH v3] IB/sa: Resolving use-after-free in ib_nl_send_msg
Message-ID: <20200614064156.GB2132762@unreal>
References: <1591627576-920-1-git-send-email-divya.indi@oracle.com>
 <1591627576-920-2-git-send-email-divya.indi@oracle.com>
 <20200609070026.GJ164174@unreal>
 <ee7139ff-465e-6c43-1b55-eab502044e0f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee7139ff-465e-6c43-1b55-eab502044e0f@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 09, 2020 at 07:45:21AM -0700, Divya Indi wrote:
> Hi Leon,
>
> Thanks for taking the time to review.
>
> Please find my comments inline -
>
> On 6/9/20 12:00 AM, Leon Romanovsky wrote:
> > On Mon, Jun 08, 2020 at 07:46:16AM -0700, Divya Indi wrote:
> >> Commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list before sending")'
> >> -
> >> 1. Adds the query to the request list before ib_nl_snd_msg.
> >> 2. Removes ib_nl_send_msg from within the spinlock which also makes it
> >> possible to allocate memory with GFP_KERNEL.
> >>
> >> However, if there is a delay in sending out the request (For
> >> eg: Delay due to low memory situation) the timer to handle request timeout
> >> might kick in before the request is sent out to ibacm via netlink.
> >> ib_nl_request_timeout may release the query causing a use after free situation
> >> while accessing the query in ib_nl_send_msg.
> >>
> >> Call Trace for the above race:
> >>
> >> [<ffffffffa02f43cb>] ? ib_pack+0x17b/0x240 [ib_core]
> >> [<ffffffffa032aef1>] ib_sa_path_rec_get+0x181/0x200 [ib_sa]
> >> [<ffffffffa0379db0>] rdma_resolve_route+0x3c0/0x8d0 [rdma_cm]
> >> [<ffffffffa0374450>] ? cma_bind_port+0xa0/0xa0 [rdma_cm]
> >> [<ffffffffa040f850>] ? rds_rdma_cm_event_handler_cmn+0x850/0x850
> >> [rds_rdma]
> >> [<ffffffffa040f22c>] rds_rdma_cm_event_handler_cmn+0x22c/0x850
> >> [rds_rdma]
> >> [<ffffffffa040f860>] rds_rdma_cm_event_handler+0x10/0x20 [rds_rdma]
> >> [<ffffffffa037778e>] addr_handler+0x9e/0x140 [rdma_cm]
> >> [<ffffffffa026cdb4>] process_req+0x134/0x190 [ib_addr]
> >> [<ffffffff810a02f9>] process_one_work+0x169/0x4a0
> >> [<ffffffff810a0b2b>] worker_thread+0x5b/0x560
> >> [<ffffffff810a0ad0>] ? flush_delayed_work+0x50/0x50
> >> [<ffffffff810a68fb>] kthread+0xcb/0xf0
> >> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810
> >> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810
> >> [<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
> >> [<ffffffff816f25a7>] ret_from_fork+0x47/0x90
> >> [<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
> >> ....
> >> RIP  [<ffffffffa03296cd>] send_mad+0x33d/0x5d0 [ib_sa]
> >>
> >> To resolve the above issue -
> >> 1. Add the req to the request list only after the request has been sent out.
> >> 2. To handle the race where response comes in before adding request to
> >> the request list, send(rdma_nl_multicast) and add to list while holding the
> >> spinlock - request_lock.
> >> 3. Use GFP_NOWAIT for rdma_nl_multicast since it is called while holding
> >> a spinlock. In case of memory allocation failure, request will go out to SA.
> >>
> >> Signed-off-by: Divya Indi <divya.indi@oracle.com>
> >> Fixes: 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list
> >> before sending")
> > Author SOB should be after "Fixes" line.
>
> My bad. Noted.
>
> >
> >> ---
> >>  drivers/infiniband/core/sa_query.c | 34 +++++++++++++++++-----------------
> >>  1 file changed, 17 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
> >> index 74e0058..042c99b 100644
> >> --- a/drivers/infiniband/core/sa_query.c
> >> +++ b/drivers/infiniband/core/sa_query.c
> >> @@ -836,6 +836,9 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
> >>  	void *data;
> >>  	struct ib_sa_mad *mad;
> >>  	int len;
> >> +	unsigned long flags;
> >> +	unsigned long delay;
> >> +	int ret;
> >>
> >>  	mad = query->mad_buf->mad;
> >>  	len = ib_nl_get_path_rec_attrs_len(mad->sa_hdr.comp_mask);
> >> @@ -860,35 +863,32 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
> >>  	/* Repair the nlmsg header length */
> >>  	nlmsg_end(skb, nlh);
> >>
> >> -	return rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, gfp_mask);
> >> +	spin_lock_irqsave(&ib_nl_request_lock, flags);
> >> +	ret =  rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, GFP_NOWAIT);
> > It is hard to be convinced that this is correct solution. The mix of
> > gfp_flags and GFP_NOWAIT at the same time and usage of
> > ib_nl_request_lock to protect lists and suddenly rdma_nl_multicast() too
> > makes this code unreadable/non-maintainable.
>
> Prior to 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list
> before sending"), we had ib_nl_send_msg under the spinlock ib_nl_request_lock.
>
> ie we had -
>
> 1. Get spinlock - ib_nl_request_lock
> 2. ib_nl_send_msg
> 	2.a) rdma_nl_multicast
> 3. Add request to the req list
> 4. Arm the timer if needed.
> 5. Release spinlock
>
> However, ib_nl_send_msg involved a memory allocation using GFP_KERNEL.
> hence, was moved out of the spinlock. In addition, req was now being
> added prior to ib_nl_send_msg [To handle the race where response can
> come in before we get a chance to add the request back to the list].
>
> This introduced another race resulting in use-after-free.[Described in the commit.]
>
> To resolve this, sending out the request and adding it to list need to
> happen while holding the request_lock.
> To ensure minimum allocations while holding the lock, instead of having
> the entire ib_nl_send_msg under the lock, we only have rdma_nl_multicast
> under this spinlock.
>
> However, do you think it would be a good idea to split ib_nl_send_msg
> into 2 functions -
> 1. Prepare the req/query [Outside the spinlock]
> 2. Sending the req - rdma_nl_multicast [while holding spinlock]
>
> Would this be more intuitive?

While it is always good idea to minimize the locked period. It still
doesn't answer concern about mixing gfp_flags and direct GFP_NOWAIT.
For example if user provides GFP_ATOMIC, the GFP_NOWAIT allocation will
cause a trouble because latter is more lax than first one.

Thanks

>
> >> +	if (!ret) {
> > Please use kernel coding style.
> >
> > if (ret) {
> >   spin_unlock_irqrestore(&ib_nl_request_lock, flags);
> >   return ret;
> >   }
> >
> >  ....
>
> Noted. Will make this change.
>
> >
> >> +		/* Put the request on the list.*/
> >> +		delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
> >> +		query->timeout = delay + jiffies;
> >> +		list_add_tail(&query->list, &ib_nl_request_list);
> >> +		/* Start the timeout if this is the only request */
> >> +		if (ib_nl_request_list.next == &query->list)
> >> +			queue_delayed_work(ib_nl_wq, &ib_nl_timed_work, delay);
> >> +	}
> >> +	spin_unlock_irqrestore(&ib_nl_request_lock, flags);
> >> +
> >> +	return ret;
> >>  }
> >>
> >>  static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
> >>  {
> >> -	unsigned long flags;
> >> -	unsigned long delay;
> >>  	int ret;
> >>
> >>  	INIT_LIST_HEAD(&query->list);
> >>  	query->seq = (u32)atomic_inc_return(&ib_nl_sa_request_seq);
> >>
> >> -	/* Put the request on the list first.*/
> >> -	spin_lock_irqsave(&ib_nl_request_lock, flags);
> >> -	delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
> >> -	query->timeout = delay + jiffies;
> >> -	list_add_tail(&query->list, &ib_nl_request_list);
> >> -	/* Start the timeout if this is the only request */
> >> -	if (ib_nl_request_list.next == &query->list)
> >> -		queue_delayed_work(ib_nl_wq, &ib_nl_timed_work, delay);
> >> -	spin_unlock_irqrestore(&ib_nl_request_lock, flags);
> >> -
> >>  	ret = ib_nl_send_msg(query, gfp_mask);
> >>  	if (ret) {
> >>  		ret = -EIO;
> >> -		/* Remove the request */
> >> -		spin_lock_irqsave(&ib_nl_request_lock, flags);
> >> -		list_del(&query->list);
> >> -		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
> >>  	}
> > Brackets should be removed too.
> Noted.
> >>  	return ret;
> >> --
> >> 1.8.3.1
> >>
