Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B01F2C663C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 14:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgK0NDS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 08:03:18 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17827 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729850AbgK0NDS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Nov 2020 08:03:18 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc0f9140001>; Fri, 27 Nov 2020 05:03:16 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Nov
 2020 13:03:18 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 27 Nov 2020 13:03:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJKbxJOfIxnMxllV8LOIya6zu2nCgSZh4JthTq1uhJVlc74f+dvK6Kwsz0F8VTjZ7oKh475FEANf/NHrIlSoGS4rhoN0hGtaIwnPCiyeDO+S//becxDCcKXX5ekOXG/COQOErDpD+dgdJ9etNFrVgrrcODwJJFp960Ray2wAsG+VSVEUI/OXWuWGam5y8efm3zpKG6dBZF3pL3AG4tgnhgi/ofMxfnin7UgcghUEKMySX2bycIA2kJaMJSwBYe+yJFA+B428QwAFzEd4n4tzRcWxdmJ1HQ65B9QBXKTtT+jriNUdjuwrXtIaB0+5srOx3hq/oyG2VxOnR758nXDIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjD9RJpOpB4UTIbz9NWWdj61nJcPwdRMJqeI69DoLQA=;
 b=BNc+FnzyEUtPtcCExaM0SoPE9QK8ZZpioaLh69iK39Fc19cmoo7eO6Npq8U/GNrAW4tGO8ii+txXds8UfnWr7L40QAjj3vFo2NnMacuYQ3VO28yDzRh/6xJz8ywOSxOETg/vKM6ZNlfNSNXxBVshGspqWl1Qk8RknKAYafJtbYFxyp1AX46oBT7vs0Lm0l4eQ9DA1ba+rAh0zU1jubnlL6i2zRFRdLzuqLpGbo98ggjtY1EE5F7Cd2EMQFJ5PS6NVHncAxpOI0iEId8oMDAXd3UTFkAa+ZsKBrq7YGHB/HF5e5Un52jIkPx0uDCosvkIQajixRoWYg7KxwhWEwOy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 27 Nov
 2020 13:03:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 13:03:16 +0000
Date:   Fri, 27 Nov 2020 09:03:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] IB/iser: Remove in_interrupt() usage.
Message-ID: <20201127130314.GE552508@nvidia.com>
References: <20201126202720.2304559-1-bigeasy@linutronix.de>
 <20201126205357.GU5487@ziepe.ca>
 <20201127123455.scnqc7xvuwwofdp2@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201127123455.scnqc7xvuwwofdp2@linutronix.de>
X-ClientProxiedBy: BL0PR1501CA0008.namprd15.prod.outlook.com
 (2603:10b6:207:17::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR1501CA0008.namprd15.prod.outlook.com (2603:10b6:207:17::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 13:03:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kidP8-002XVh-K6; Fri, 27 Nov 2020 09:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606482196; bh=WjD9RJpOpB4UTIbz9NWWdj61nJcPwdRMJqeI69DoLQA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=hMIueCrrFP+WHoyLICJd6JeJYfnzppb6Ri7aJm7Gn9rKtfqtIQsauONdArypEcXMR
         nepSdM1/iPG8B2Mu+tJUqdE6p73vaB8PD34CM6bTyKHj+BEdj1SFTsBKigwLNawRJn
         +QnkJFivXQKvrrTKLs0FgWRWc50oTkVw2+ni+ukDb0kVkh+wEj3V3fNuH9H+jW+CUZ
         wlHxA8sNeS9bpk5sYanBe8L7NDVFKxGEYMO1yvl4xRuhPTPKQTRZl6cxQT8bo0fdAI
         5WrKPjXIIAQgJvH9wIcCCFhqrL1aHHnJRzI81DZuoaMkA5rgH71V2yC9m5nJCrnaPc
         0ik6F0U+OXJ5w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 27, 2020 at 01:34:55PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-11-26 16:53:57 [-0400], Jason Gunthorpe wrote:
> > > +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> > > @@ -187,12 +187,8 @@ iser_initialize_task_headers(struct iscsi_task *task,
> > >  	struct iser_device *device = iser_conn->ib_conn.device;
> > >  	struct iscsi_iser_task *iser_task = task->dd_data;
> > >  	u64 dma_addr;
> > > -	const bool mgmt_task = !task->sc && !in_interrupt();
> > >  	int ret = 0;
> > 
> > Why do you think the task->sc doesn't matter?
> 
> Based on the call paths I checked, there was no evidence that
> state_mutex can be acquired. If I remove locking here then `mgmt_task'
> is no longer needed.

That only says there is no recursive deadlock..

> How should task->sc matter?

I was able to get the internal bug report that caused the
7414dde0a6c3a commit.

The issue here is that the state_mutex is protecting 

This:

	if (unlikely(iser_conn->state != ISER_CONN_UP)) {

Which indicates that this:

        dma_addr = ib_dma_map_single(device->ib_device, (void *)tx_desc,

Won't crash because iser_con->ib_con is invalid. The notes say that
the iSCSI stack is in some state where data traffic won't flow but
management traffic is still possible. I suppose this is some fast path
so it was "optimized" to eliminate the lock for data traffic.

A call chain of interest for the lock at least is:

Nov  3 12:24:37 rsws10 BUG: unable to handle kernel 
Nov  3 12:24:37 NULL pointer dereference
Nov  3 12:24:37 rsws10 Pid: 5245, comm: scsi_eh_5 Tainted: GF          O 3.8.13-16.2.1.el6uek.x86_64 #1 IBM System x3550 M3 -[7944KEG]-/90Y4784
[..]
Nov  3 12:24:37 rsws10  [<ffffffffa069d628>] iscsi_iser_task_init+0x28/0x70 [ib_iser]
Nov  3 12:24:37 rsws10  [<ffffffffa0610029>] iscsi_prep_mgmt_task+0x129/0x150 [libiscsi]
Nov  3 12:24:37 rsws10  [<ffffffffa061354c>] __iscsi_conn_send_pdu+0x23c/0x310 [libiscsi]
Nov  3 12:24:37 rsws10  [<ffffffffa0614277>] iscsi_exec_task_mgmt_fn+0x37/0x290 [libiscsi]
Nov  3 12:24:37 rsws10  [<ffffffff813c2694>] ? scsi_send_eh_cmnd+0xd4/0x3a0
Nov  3 12:24:37 rsws10  [<ffffffff810c39df>] ? module_refcount+0x9f/0xc0
Nov  3 12:24:37 rsws10  [<ffffffffa061497b>] iscsi_eh_device_reset+0x1bb/0x2d0 [libiscsi]
Nov  3 12:24:37 rsws10  [<ffffffff813c3119>] scsi_eh_bus_device_reset+0xb9/0x1e0
Nov  3 12:24:37 rsws10  [<ffffffff813c3f60>] ? scsi_unjam_host+0x1f0/0x1f0
Nov  3 12:24:37 rsws10  [<ffffffff813c3cbe>] scsi_eh_ready_devs+0x5e/0x110
Nov  3 12:24:37 rsws10  [<ffffffff813c3f60>] ? scsi_unjam_host+0x1f0/0x1f0
Nov  3 12:24:37 rsws10  [<ffffffff813c3e5d>] scsi_unjam_host+0xed/0x1f0
Nov  3 12:24:37 rsws10  [<ffffffff813c3f60>] ? scsi_unjam_host+0x1f0/0x1f0
Nov  3 12:24:37 rsws10  [<ffffffff813c40c8>] scsi_error_handler+0x168/0x1c0
Nov  3 12:24:37 rsws10  [<ffffffff813c3f60>] ? scsi_unjam_host+0x1f0/0x1f0
Nov  3 12:24:37 rsws10  [<ffffffff81082a6e>] kthread+0xce/0xe0
Nov  3 12:24:37 rsws10  [<ffffffff810829a0>] ? kthread_freezable_should_stop+0x70/0x70
Nov  3 12:24:37 rsws10  [<ffffffff8159b66c>] ret_from_fork+0x7c/0xb0
Nov  3 12:24:37 rsws10  [<ffffffff810829a0>] ? kthread_freezable_should_stop+0x70/0x70

So, I think the usual 'pass in atomic context flag' is really needed
here

Jason
