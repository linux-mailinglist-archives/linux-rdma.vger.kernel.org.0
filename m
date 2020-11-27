Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD62D2C67F4
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 15:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbgK0Obp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 09:31:45 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:30117 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730827AbgK0Obp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Nov 2020 09:31:45 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc10dd00000>; Fri, 27 Nov 2020 22:31:44 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Nov
 2020 14:31:43 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 27 Nov 2020 14:31:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M05avY5QrT04km/vdN62ri+hOAwXsxuBXQ6I4WoMsx2L0GxLo/x3RDMUFst1TLirfhnqgNy51Dlrz9N6nUpakpEmCbzDJBTqq80tGdYjYSY9v9rF2OHolaDnM/DVyL04eL01bJO5uYFuae6ozKlzM6hkhtxtE4e7UBF39TKu0nmaTXlEz3EB4zmEWGsFt8VfBspEQ68YR086fAJIYIjZuwuDwkKhpPWHR6jn0Jr1NRRhZolJN1aPIbtaoUHes4OS0yR7aVl1DSUUumD8hO8C3S7VLKr87uXU/4macbBU1aCbAj0tmJ9Wno9EAbnEdtBbubwjnTMsqWbUyJy9cH03Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFctz9jWPU1g6fW6ZcqDnZRypO4lvb/9gLq4M5JZYHQ=;
 b=H7SDZyJbMIMA219vlnmqqUXwXvtsC50Wk8HPWuk7Sud9r1MDXwQnbRLJdhpTX+d+et+Wxo8/2YOE/HfglJ7KEyIYad4TyXh3eTCtLwOtDZtb12lY7CwlbRPSjjsEkwpUPT7ZPDpFfJxmN1u3hjh1MJCRfIqscxK14WNu8cjux1juzVcvzGex7tMpffqeqjOUa+BAgucWWk6UuyMCJDh9vIUMgf7fwjxmqTdKTqqxG7GG/4Z4EjGUptSFfS1m2Ufy9iWDSR/DCccYScGS3xjlPlfqtf+qCiqdW9rAs7MGEdAO4YuslRUO86wo1m8WTcJ1uYNK+6i7LRS993Nyy05i1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 27 Nov
 2020 14:31:40 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 14:31:40 +0000
Date:   Fri, 27 Nov 2020 10:31:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] IB/iser: Remove in_interrupt() usage.
Message-ID: <20201127143138.GG552508@nvidia.com>
References: <20201126202720.2304559-1-bigeasy@linutronix.de>
 <20201126205357.GU5487@ziepe.ca>
 <20201127123455.scnqc7xvuwwofdp2@linutronix.de>
 <20201127130314.GE552508@nvidia.com>
 <20201127141432.z5hqxosugi6uu6i7@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201127141432.z5hqxosugi6uu6i7@linutronix.de>
X-ClientProxiedBy: MN2PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:208:d4::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR04CA0018.namprd04.prod.outlook.com (2603:10b6:208:d4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 14:31:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kiemh-002ibI-0a; Fri, 27 Nov 2020 10:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606487504; bh=wFctz9jWPU1g6fW6ZcqDnZRypO4lvb/9gLq4M5JZYHQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=a61oN/xrRgaui1qjThGjRPdzAsFvfhaXhjfyRCr5cH8TR4+yijh0vFH4233mg9mr0
         k9sQg2y++NCVcVQMLL/DiF/5NlYJsPCqu0mHkYXfJZ+GM3onkgqiSiLcEGMCpePAuk
         zLQTcu9xVTS9f0JnjuPxe8uftNjI+Lm8Mhe23PKujFJ+AGb93axFS68PgT28NhrW8j
         d8lhyRhOHJ5Ri52apcQPKYsS4OyhYlSXIrjEcWTtMNi3wXEbWa2cEA0YwcAVFQJRkL
         MTw/JXM8xV3QDA0ShF7OZdB/fkqIf8oNpQDW8mcrWWPZadidBcim9qtb/NF0oDP856
         4N0J8nDPPtebw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 27, 2020 at 03:14:32PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-11-27 09:03:14 [-0400], Jason Gunthorpe wrote:
> > I was able to get the internal bug report that caused the
> > 7414dde0a6c3a commit.
> > 
> > The issue here is that the state_mutex is protecting 
> > 
> > This:
> > 
> > 	if (unlikely(iser_conn->state != ISER_CONN_UP)) {
> > 
> > Which indicates that this:
> > 
> >         dma_addr = ib_dma_map_single(device->ib_device, (void *)tx_desc,
> > 
> > Won't crash because iser_con->ib_con is invalid. The notes say that
> > the iSCSI stack is in some state where data traffic won't flow but
> > management traffic is still possible. I suppose this is some fast path
> > so it was "optimized" to eliminate the lock for data traffic.
> > 
> > A call chain of interest for the lock at least is:
> > 
> > Nov  3 12:24:37 rsws10 BUG: unable to handle kernel 
> > Nov  3 12:24:37 NULL pointer dereference
> > Nov  3 12:24:37 rsws10 Pid: 5245, comm: scsi_eh_5 Tainted: GF          O 3.8.13-16.2.1.el6uek.x86_64 #1 IBM System x3550 M3 -[7944KEG]-/90Y4784
> > [..]
> > Nov  3 12:24:37 rsws10  [<ffffffffa069d628>] iscsi_iser_task_init+0x28/0x70 [ib_iser]
> > Nov  3 12:24:37 rsws10  [<ffffffffa0610029>] iscsi_prep_mgmt_task+0x129/0x150 [libiscsi]
> > Nov  3 12:24:37 rsws10  [<ffffffffa061354c>] __iscsi_conn_send_pdu+0x23c/0x310 [libiscsi]
> > Nov  3 12:24:37 rsws10  [<ffffffffa0614277>] iscsi_exec_task_mgmt_fn+0x37/0x290 [libiscsi]
> > Nov  3 12:24:37 rsws10  [<ffffffffa061497b>] iscsi_eh_device_reset+0x1bb/0x2d0 [libiscsi]
> 
> preemptible until here and this function has:
> 
> |	mutex_lock(&session->eh_mutex);
> |	spin_lock_bh(&session->frwd_lock);
> 
> I don't see the lock dropped between here and iscsi_iser_task_init().

Hmm, nor do I

This whole thing does look broken.

So.. it looks like the "fix" in 7414dde0a6c3a was adding the:

+       if (unlikely(iser_conn->state != ISER_CONN_UP)) {

Without any locking. Which is a pretty typical mistake :\

> Sure, I would do that but as noted above, it the `frwd_lock' is acquired
> so you can't acquire the mutex here.

Ok, well, I'm thinking this patch is OK as is. Lets wait for Max and Sagi

Jason
