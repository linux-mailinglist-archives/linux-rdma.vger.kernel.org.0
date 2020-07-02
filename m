Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F528212CC6
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 21:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgGBTHv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 15:07:51 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14215 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGBTHu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jul 2020 15:07:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efe30530000>; Thu, 02 Jul 2020 12:06:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 Jul 2020 12:07:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 Jul 2020 12:07:50 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jul
 2020 19:07:45 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.56) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 2 Jul 2020 19:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AndpIFn/5YDVY2pXIVcQQwgzDIJ6ZZh6D2q3Q9sCyEe2xVWOvtUOpONLnKkY6Hlz5272kryENzBMN6FyW9QXHW5elSpXTNfYpjgJzOI1+6hpN/uXFzaCNpV1WYcc7/oRb+bcsjXUT9uO2YcTQcLl39XYOmiH7R/yw30FJYHFdwF/7Td/GFNH5gL6O7vz5tAnpL5vnP9OWbP1CF+oO0uIOt9cZFmo6tp/3lXL980+NKVmYNyhADqZF2DwCd5sFy6fjsiJHgSW0e77hcrb5bWeb657+i6UvBgNe7Lzh6TWQqzR0c5kHjpYE9puGKvO9Cg3Wdym1DV/81vlHIiBQguqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJcIV0H/7sLJnyzq/5mftK6dzrpUhm/WeBEm6WHN+TU=;
 b=Ye9xsNEi6WukUoKKRQR/Jhk+ylE1yTucM5rybccCnxAXQoD3G2TsFUC4K7NdC7luIAW0Wjq2P55wWNRqRd15xtzAlT0xNNpBWS51owgrOGGV/b7hN852HxC/Ku8eAyRon/iJGJ7WUzx48+/hi6KSuoDoigJSUCFwBIYRKzph4qIk/+puYefNOAWLFaQhIAA6BKvZ+9WehY0YTGdAEoQPyRpjDUN3kZs25d13vOA4QsMtkovSa2dnpVq7NWObBY9tAX530JceXtRq6I5WYKzmJM6d5z+I/uem/Jk3skemeaJBvdbR6ENlh2bDL+jkD//EymQjq6jLvPsa5tuORnLXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1436.namprd12.prod.outlook.com (2603:10b6:3:78::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Thu, 2 Jul 2020 19:07:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 19:07:43 +0000
Date:   Thu, 2 Jul 2020 16:07:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Divya Indi <divya.indi@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v4] IB/sa: Resolving use-after-free in ib_nl_send_msg
Message-ID: <20200702190738.GA759483@nvidia.com>
References: <1592964789-14533-1-git-send-email-divya.indi@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1592964789-14533-1-git-send-email-divya.indi@oracle.com>
X-ClientProxiedBy: MN2PR15CA0018.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR15CA0018.namprd15.prod.outlook.com (2603:10b6:208:1b4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22 via Frontend Transport; Thu, 2 Jul 2020 19:07:43 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jr4Yc-003Bay-PI; Thu, 02 Jul 2020 16:07:38 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ad86ae0-f029-4e53-dbff-08d81ebb3300
X-MS-TrafficTypeDiagnostic: DM5PR12MB1436:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14367DE9ED18D1EAB01316E3C26D0@DM5PR12MB1436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGi98CJRmdF61g2kkqIoQNK4ISz1wEWeK/RALd1tMXwfRUqgFGoIvJpgx1wYynUbokU0gPWQc14s0qVORygzybNV6jJDZ4zoFDRGOjgoVEOYHOHjPr4VubdtUJFCxnE/m8TrIzOI16yVYDk4qEWzKqo/fKCwGewMJW8VH9cR5Q9zEeA8YmMk31KEcSSd7bOfwx7qas4t9PiVI323bRyXDAZQFgqCdrpyo3CpDIpSjk4nTJq3gXG0IPSviBj+8RxB4leA0zs93ciqHJ52zgHz+ehxOQYrDRe5MiwT+Jq9bzEa3taG+dTcAOOlHRTb/CpoPl6qA/HB6oPr3x770E46xSHsapVWPGnkOtwGnKbOYG4feiMYNJhZR7atGM+KlCcr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(5660300002)(478600001)(186003)(66556008)(66476007)(66946007)(8936002)(8676002)(33656002)(7416002)(4326008)(2616005)(26005)(6916009)(83380400001)(316002)(2906002)(1076003)(9746002)(9786002)(86362001)(36756003)(54906003)(426003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jxELYGLdgdiTVaApIslGEeNtao5NaTH1cFH2rRJtTt55FJQYTzDTvZ+ow2Vij9oNQOFeBJT5syxqGbpgwRyzfXUOhUOffm/thfm7MYv9/7dEA9gY556qpcaPNP2rS0OyrQ1z9I/wP/bO8QvuNWKkdtQxxHTfHy9yGa0AgioAOa4r9ak6VLL0hBHxDnWsm1d/TjQnuVejmLMRTd44QHM4mJlMEwtFBDoaMf9CLa4VnoMJUwXMSKUt56x8PErwTHftX/54k/EMUylXPerKJRqjADFV6ra+vDFR9JYyJS1/irBwQKhU7lGjo7/Ux5PO+jf9BJgshSPg6Q9T0STUyTXjjE1PhipkGjEcNGk0s7GdhStjKFPcMLdQT5RP92IAbIei0sSTpnWLDYlKxdVRS/oDXOgo61S5lmxOstNhMxiO7X7rNT6GNiDQ1Vortx32OSk1oKvDYDCXwgyBOPSmEEVjjtPAXN7vDSI+5CGnYbnR61vQv6ZL1tGDhl+IsvP/WWWA
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad86ae0-f029-4e53-dbff-08d81ebb3300
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 19:07:43.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZP7BnaFwKmIrFRqwV46eChYTbb6Bv39gqacbMT1NIxSeAzh8LJWwQhiOIH/zOWUO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1436
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593716819; bh=qJcIV0H/7sLJnyzq/5mftK6dzrpUhm/WeBEm6WHN+TU=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=o6Tn63Jt006KD2uWppZknmN9DFFYH0MCv9da8QNZbwH7+/54Kgqd3aY4T0HVRjoWC
         DltQM5KgdhRVSy6RGP29xJIAwbNlFIPMIQrw8Q2U9UXFX+peXtvAIdcOivhF0/BlJV
         yaiWYPklLFJ42A03HeSfIQOxZreYY2QUB2aDMFbTdDBp7nBlOJFX0c0ul1SiA1FWjI
         SnXWslK74bq+ugRu/DbHAmPTkxhQMYRYwIUzJLJw/Kx5EMcSzT/c/AQBdRf3IS3yW1
         PXmSQiro5SFB41SVPZvsJ6yqQR+C9VKHJR5NHix2/CXGbPRpVISM8WL8I/XQ6nV/Vz
         nNwtgpVTt8RUA==
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

I made a few edits, and applied to for-rc

Thanks,
Jason
