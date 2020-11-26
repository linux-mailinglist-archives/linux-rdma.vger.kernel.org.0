Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505D82C5D37
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 21:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbgKZUyF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 15:54:05 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12174 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729939AbgKZUyE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 15:54:04 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc015ea0000>; Thu, 26 Nov 2020 12:54:02 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 20:54:03 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 26 Nov 2020 20:54:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFZx/3xe0SxqAVs4sGAZWyvLfGIqEqTigH45jTnqfDRy3jZIoazxaHK6TwgLCcfFXZQ8izG8wsLDk89dFrzXg/nP8X+vjK6+2LQAvqqpur0Nsj9Q0W95t68D+G6lxFEW/d7fas7hS3QjwM3F1HKNo5G8r7SD1vVs1o6qQda5rrgp5023vaB1BVRBoW7b0PZE3PtCiArett23CL0z8C2mZT7W0Vy72sLaZ28c1ULKFuRI2g5yTtmXdA3tst7nwReWJZHHL65d2ECH0Ch1V9ROTiX2QrXsqmgdd52oz6wVFO/Iid+mbtran3YrYZ2H2cGhcq+P/uevPN/dJEhFAVR1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERLMU/Cw03trTQ0vkWn3Qj/jqmODC5qTp/Dg2H5Qf1g=;
 b=ShxNtetbqwFwLt409vq4sR97tpALt4Fy4/urrkxIyhXbtvskJ4p50a+2DQY6Bjp1wE+pSym9MFu+CxaGT8xxYr7uOlLT61ay3PSrqHcjGpWRzrLxPKdxY8rMysD2aZhv0TVg9/GsOUhUyToE2qBYXUFqayCZgcW0T2X9gbUqU77ww73DBLkinbwWwq2MTyoqytJKrj6oSLLjBqQfHrMMGMzCWg0TGPHkP6mV1wA1OgqZzuoDF4D07EWuNgI0ufBHbrtPb0Lam9mDy32eb0IpdzHW3d7UyJPA31cZVcBUvaBREb2Efz1u6qT+XHyNKyk+ADs6E8zXEhp1BK8ZlsRsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Thu, 26 Nov
 2020 20:54:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.024; Thu, 26 Nov 2020
 20:53:59 +0000
Date:   Thu, 26 Nov 2020 16:53:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] IB/iser: Remove in_interrupt() usage.
Message-ID: <20201126205357.GU5487@ziepe.ca>
References: <20201126202720.2304559-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201126202720.2304559-1-bigeasy@linutronix.de>
X-ClientProxiedBy: BL0PR0102CA0005.prod.exchangelabs.com
 (2603:10b6:207:18::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0005.prod.exchangelabs.com (2603:10b6:207:18::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 20:53:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kiOH7-002LvB-Hv; Thu, 26 Nov 2020 16:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606424042; bh=ERLMU/Cw03trTQ0vkWn3Qj/jqmODC5qTp/Dg2H5Qf1g=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=HkalK3GgkTHedlgwee+ggJpS1qcFTjcl+CB+uDbyg6lok1cAalO/8ZDPtPfwoRHZ/
         bzaJk/DNQwVKV4uCtgUDftBspeiZsPve6vzapo+IMOoWDCuRJhY9dhV7GfCbZ9deTQ
         LiHuAvL4acq303PqQ5hwYzCSPpOxBSrXm7ION2MbR2/GhO5mNSk+YuiEZSWHcdEJ8D
         CJhXMHClcbZNenmIiG98EUW8ktW1bT97ZGZ7xrovKS1oHf2SfiWTYhXp5cDAEC0RLC
         bdEyd1NWEotLoVfNw6GBvl+RImwINlJIFVkH2msuJoLOEb56xo7hOtMoZKJKw/VZsz
         who3BhDqYvpng==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 26, 2020 at 09:27:20PM +0100, Sebastian Andrzej Siewior wrote:
> iser_initialize_task_headers() uses in_interrupt() to find out if it is
> safe to acquire a mutex.
> 
> in_interrupt() is deprecated as it is ill defined and does not provide what
> it suggests. Aside of that it covers only parts of the contexts in which
> a mutex may not be acquired.
> 
> The following callchains exist:
> 
> iscsi_queuecommand() *locks* iscsi_session::frwd_lock
> -> iscsi_prep_scsi_cmd_pdu()
>    -> session->tt->init_task() (iscsi_iser_task_init())
>       -> iser_initialize_task_headers()
> -> iscsi_iser_task_xmit() (iscsi_transport::xmit_task)
>   -> iscsi_iser_task_xmit_unsol_data()
>     -> iser_send_data_out()
>       -> iser_initialize_task_headers()
> 
> iscsi_data_xmit() *locks* iscsi_session::frwd_lock
> -> iscsi_prep_mgmt_task()
>    -> session->tt->init_task() (iscsi_iser_task_init())
>       -> iser_initialize_task_headers()
> -> iscsi_prep_scsi_cmd_pdu()
>    -> session->tt->init_task() (iscsi_iser_task_init())
>       -> iser_initialize_task_headers()
> 
> __iscsi_conn_send_pdu() caller has iscsi_session::frwd_lock
>   -> iscsi_prep_mgmt_task()
>      -> session->tt->init_task() (iscsi_iser_task_init())
>         -> iser_initialize_task_headers()
>   -> session->tt->xmit_task() (
> 
> The only callchain that is close to be invoked in preemptible context:
> iscsi_xmitworker() worker
> -> iscsi_data_xmit()
>    -> iscsi_xmit_task()
>       -> conn->session->tt->xmit_task() (iscsi_iser_task_xmit()
> 
> In iscsi_iser_task_xmit() there is this check:
>    if (!task->sc)
>       return iscsi_iser_mtask_xmit(conn, task);
> 
> so it does end up in iser_initialize_task_headers() and
> iser_initialize_task_headers() relies on iscsi_task::sc == NULL.
> 
> Remove conditional locking of iser_conn::state_mutex because there is no
> call chain to do so.

AFAIK, there is no way to get into a hard IRQ from
drivers/infiniband/ulp/*

The closest it gets to real HW is a soft IRQ from the CQ handler,
starting at these functions:

drivers/infiniband/ulp/iser/iser_initiator.c:   tx_desc->cqe.done = iser_cmd_comp;
drivers/infiniband/ulp/iser/iser_initiator.c:   tx_desc->cqe.done = iser_dataout_comp;
drivers/infiniband/ulp/iser/iser_initiator.c:   mdesc->cqe.done = iser_ctrl_comp;
drivers/infiniband/ulp/iser/iser_verbs.c:       desc->cqe.done = iser_login_rsp;
drivers/infiniband/ulp/iser/iser_verbs.c:               rx_desc->cqe.done = iser_task_rsp;

So, I can't see any way in_interrupt() was ever detecting actual
interrupts. I wonder if it is was some hacky way to detect
non-preemption from a softirq or something?

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Max Gurtovoy <maxg@nvidia.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> ---
>  drivers/infiniband/ulp/iser/iscsi_iser.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
> index 3690e28cc7ea2..b34a1881c4cad 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> @@ -187,12 +187,8 @@ iser_initialize_task_headers(struct iscsi_task *task,
>  	struct iser_device *device = iser_conn->ib_conn.device;
>  	struct iscsi_iser_task *iser_task = task->dd_data;
>  	u64 dma_addr;
> -	const bool mgmt_task = !task->sc && !in_interrupt();
>  	int ret = 0;

Why do you think the task->sc doesn't matter?

> -	if (unlikely(mgmt_task))
> -		mutex_lock(&iser_conn->state_mutex);
> -
>  	if (unlikely(iser_conn->state != ISER_CONN_UP)) {
>  		ret = -ENODEV;
>  		goto out;
> @@ -215,9 +211,6 @@ iser_initialize_task_headers(struct iscsi_task *task,
>  
>  	iser_task->iser_conn = iser_conn;
>  out:
> -	if (unlikely(mgmt_task))
> -		mutex_unlock(&iser_conn->state_mutex);
> -
>  	return ret;
>  }

Sagi, you added this code, any rememberance of what it is for?

commit 7414dde0a6c3a958e26141991bf5c75dc58d28b2
Author: Sagi Grimberg <sagig@mellanox.com>
Date:   Sun Dec 7 16:09:59 2014 +0200

    IB/iser: Fix race between iser connection teardown and scsi TMFs
    
    In certain scenarios (target kill with live IO) scsi TMFs may race
    with iser RDMA teardown, which might cause NULL dereference on iser IB
    device handle (which might have been freed). In this case we take a
    conditional lock for TMFs and check the connection state (avoid
    introducing lock contention in the IO path). This is indeed best
    effort approach, but sufficient to survive multi targets sudden death
    while heavy IO is inflight.
    
    While we are on it, add a nice kernel-doc style documentation.

Max, can you do a test with this patch and we might luck into a
lockdep splat that will be informative?

Jason
