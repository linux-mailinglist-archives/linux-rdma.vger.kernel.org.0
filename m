Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCBA209C7F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2020 12:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389692AbgFYKJM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jun 2020 06:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389646AbgFYKJL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jun 2020 06:09:11 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BC8B206B7;
        Thu, 25 Jun 2020 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593079751;
        bh=Cy92y6r1Yt4owgPFibHkzccd1AOEkO6XEi4ayppYCCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZ6fYWNYg6SfIp71nyrsySnIhunLbGo3B9SAH0j3nve41SNS1iWhOEvk5s3RlI+ON
         8aBbEimSATKaTBLlFiTEeSo201Wg+hyeT13TZ27+7m6dqcRM2QqjgJvint/xey6ehi
         /w5D+eUGeXov+93v1kKmCIiAnh6wkJqibg9TLv/s=
Date:   Thu, 25 Jun 2020 13:09:04 +0300
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
Subject: Re: [PATCH v4] IB/sa: Resolving use-after-free in ib_nl_send_msg
Message-ID: <20200625100904.GE1446285@unreal>
References: <1592964789-14533-1-git-send-email-divya.indi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592964789-14533-1-git-send-email-divya.indi@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 07:13:09PM -0700, Divya Indi wrote:
> Commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list before sending")'
> -
> 1. Adds the query to the request list before ib_nl_snd_msg.
> 2. Moves ib_nl_send_msg out of spinlock, hence safe to use gfp_mask as is.
>
> However, if there is a delay in sending out the request (For
> eg: Delay due to low memory situation) the timer to handle request timeout
> might kick in before the request is sent out to ibacm via netlink.
> ib_nl_request_timeout may release the query causing a use after free situation
> while accessing the query in ib_nl_send_msg.
>
> Call Trace for the above race:
>
> [<ffffffffa02f43cb>] ? ib_pack+0x17b/0x240 [ib_core]
> [<ffffffffa032aef1>] ib_sa_path_rec_get+0x181/0x200 [ib_sa]
> [<ffffffffa0379db0>] rdma_resolve_route+0x3c0/0x8d0 [rdma_cm]
> [<ffffffffa0374450>] ? cma_bind_port+0xa0/0xa0 [rdma_cm]
> [<ffffffffa040f850>] ? rds_rdma_cm_event_handler_cmn+0x850/0x850
> [rds_rdma]
> [<ffffffffa040f22c>] rds_rdma_cm_event_handler_cmn+0x22c/0x850
> [rds_rdma]
> [<ffffffffa040f860>] rds_rdma_cm_event_handler+0x10/0x20 [rds_rdma]
> [<ffffffffa037778e>] addr_handler+0x9e/0x140 [rdma_cm]
> [<ffffffffa026cdb4>] process_req+0x134/0x190 [ib_addr]
> [<ffffffff810a02f9>] process_one_work+0x169/0x4a0
> [<ffffffff810a0b2b>] worker_thread+0x5b/0x560
> [<ffffffff810a0ad0>] ? flush_delayed_work+0x50/0x50
> [<ffffffff810a68fb>] kthread+0xcb/0xf0
> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810
> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810
> [<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
> [<ffffffff816f25a7>] ret_from_fork+0x47/0x90
> [<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
> ....
> RIP  [<ffffffffa03296cd>] send_mad+0x33d/0x5d0 [ib_sa]
>
> To resolve the above issue -
> 1. Add the req to the request list only after the request has been sent out.
> 2. To handle the race where response comes in before adding request to
> the request list, send(rdma_nl_multicast) and add to list while holding the
> spinlock - request_lock.
> 3. Use non blocking memory allocation flags for rdma_nl_multicast since it is
> called while holding a spinlock.
>
> Fixes: 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list
> before sending")
>
> Signed-off-by: Divya Indi <divya.indi@oracle.com>
> ---
> v1:
> - Use flag IB_SA_NL_QUERY_SENT to prevent the use-after-free.
>
> v2:
> - Use atomic bit ops for setting and testing IB_SA_NL_QUERY_SENT.
> - Rewording and adding comments.
>
> v3:
> - Change approach and remove usage of IB_SA_NL_QUERY_SENT.
> - Add req to request list only after the request has been sent out.
> - Send and add to list while holding the spinlock (request_lock).
> - Overide gfp_mask and use GFP_NOWAIT for rdma_nl_multicast since we
>   need non blocking memory allocation while holding spinlock.
>
> v4:
> - Formatting changes.
> - Use GFP_NOWAIT conditionally - Only when GFP_ATOMIC is not provided by caller.
> ---
>  drivers/infiniband/core/sa_query.c | 41 ++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
> index 74e0058..9066d48 100644
> --- a/drivers/infiniband/core/sa_query.c
> +++ b/drivers/infiniband/core/sa_query.c
> @@ -836,6 +836,10 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
>  	void *data;
>  	struct ib_sa_mad *mad;
>  	int len;
> +	unsigned long flags;
> +	unsigned long delay;
> +	gfp_t gfp_flag;
> +	int ret;
>
>  	mad = query->mad_buf->mad;
>  	len = ib_nl_get_path_rec_attrs_len(mad->sa_hdr.comp_mask);
> @@ -860,36 +864,39 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
>  	/* Repair the nlmsg header length */
>  	nlmsg_end(skb, nlh);
>
> -	return rdma_nl_multicast(&init_net, skb, RDMA_NL_GROUP_LS, gfp_mask);
> -}
> +	gfp_flag = ((gfp_mask & GFP_ATOMIC) == GFP_ATOMIC) ? GFP_ATOMIC :
> +		GFP_NOWAIT;

I would say that the better way will be to write something like this:
gfp_flag |= GFP_NOWAIT;

Thanks
