Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9049622F324
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 16:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgG0O5W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 10:57:22 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15023 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgG0O5V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jul 2020 10:57:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1eeb440002>; Mon, 27 Jul 2020 07:57:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 27 Jul 2020 07:57:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 27 Jul 2020 07:57:21 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jul
 2020 14:57:13 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 27 Jul 2020 14:57:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+hmmxSIOAVLrKyHO+9jY1XVk43Fl3hJNOsNzQOy9ODQt0e5VGs/+2CBHKdosRwuRGKAIgns/vycHo3FYf3EfevNewLbmLfojt38XJKsxUYuPaIMhZCoMwd/IZEchvvv6RAQO5GTnbscgubq4jb9pwFbBMSgPtfESoqnu7d9EGxTib5OIjxb8AhYLsgVpn43jmjP8K1XetZ+G1itHAyqIbQqe/CCj0UWr8vnkCKX5ttwc17LnAVdT6wS+AyNh2wX+gW7TJF22ummsc3/9fcZfjrz4ZJYiNhl7DITwIgQXvc6AbSinm6i7drZlKWBcS66NhG9ZdHfqyZbMdUQ9hLHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwZ8GaBjxQ/nb9+2QIEwjV6yH5y/oSQ58jIZf5o9VkE=;
 b=Hve1b3BUs06CYT0/zrD7mIjtQAUc5i2snsdCfegb0OxkKS488NYPIX92yBQxHu2pIKgnO9aS2U6HDg90vdhXR1Vqjh5uhwg5Zdbf3ru+tI3IbXi6+5hgR7W4YjYSsQNYChgO5dJUjovaXR8C56my/kbasSfdpNs2BE344GZdjDjbRKfzYZ87B0GJQONdXdZCvE0A/ip8I9hX8HAo2wBLB2i23MG95uyb+EubAgBpSYwBPU5CyMBJSolHKdC/X/AyY7N83L0S8jLayJG19G5L5IBaFM7/w1K9C7dsZ9Ey2bUIgsN2uvvtV+S0l4tKniaobdwviv88o3CB4xwlOfbmVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1433.namprd12.prod.outlook.com (2603:10b6:3:73::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Mon, 27 Jul
 2020 14:57:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 14:57:11 +0000
Date:   Mon, 27 Jul 2020 11:57:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leonro@mellanox.com>, <linux-rdma@vger.kernel.org>
CC:     <syzbot+086ab5ca9eafd2379aa6@syzkaller.appspotmail.com>,
        <syzbot+7446526858b83c8828b2@syzkaller.appspotmail.com>
Subject: Re: [PATCH] RDMA/cm: Add min length checks to user structure copies
Message-ID: <20200727145709.GA48880@nvidia.com>
References: <0-v1-d5b86dab17dc+28c25-ucma_syz_min_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-d5b86dab17dc+28c25-ucma_syz_min_jgg@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:207:3d::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0047.namprd02.prod.outlook.com (2603:10b6:207:3d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Mon, 27 Jul 2020 14:57:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k04Yv-000CjC-Ru; Mon, 27 Jul 2020 11:57:09 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26012567-01d1-4305-dced-08d8323d574a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1433:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14337C8F4FF509D65A411C4AC2720@DM5PR12MB1433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DKkbVHO94NXdfXk0crnqDV80Dlxhx9i75VhZRBWMaSyReqrRSngpS/P5ZAzxlIJhQc1rDncy6uu4PdiC4Z+DHp91vXoxiJurSYjrAfnjbXn/AmEIoLrSlhxwbRIw+Yl+/6J8ZHWpc9V2lLhTtbYaepHS0QabDGn3UXtWA1YKMZuFsk9L8vAHqa9xSINUc3Dcnd1akZjN5O/bmDGS4gKpVpsLPBRtglkSGwI0CWW6z1xCaeN005WegztgE15+HKBqxtQop29NByl1qS6iI/ExLhx7EZW0v77OYyEJnU335iyG8ZVTQLPfrPHaSuzMM+J1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(33656002)(316002)(26005)(86362001)(186003)(5660300002)(1076003)(478600001)(8936002)(66476007)(66556008)(66946007)(36756003)(2906002)(9746002)(4326008)(9786002)(8676002)(426003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DEVFSo3cWFtxy+5IEJ2qodgnJd/PQ86CQaQcUuoY/DagMsOI5lB+pRKeIJB7t/lCHpoj4AIQ0jknICG1Rhw14cWjkCln9LU42/dwgUCkcaKkOS0UKY8QDH3bNUU6iaCGY272vIC9Vaw+O1K+gStkQDWmjCqm5aBHkCMBuaBdSAp8bCsI4M52i0KxTVmePIsPXbnmsuMAs9rS8I+wMjDPANZgdPiKE0Okkpy1xUyYNoC+HZN6+X5TcrEVNZyFPAoYECM0tdtEXO40L4JY4fVaWbac5KmD7kumICYjQPzwsCX59qQajkIhu6YMSAxX+Oc0n4VMCkrE36kp7nH54AcIPGfjyXG9ZvZs3f+AkWMyk/6mlfUfq/p+fXXSHraSw2499AeqD+nM/VKmft3N2NPR+gGJmSL5PUo7QYO1KvpCufjd/VwBXxK9umNaCS7pyMqb9AzvL/2Cp6nLRt3s90xhEzxeiTyI5vcaXU8fZYb/Kk8=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26012567-01d1-4305-dced-08d8323d574a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 14:57:11.3921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXIlFuLapQCHPcpHyJndQM+YqcQ0V5Q0QBUg6AqGznGvlVLfMvxjXJY5E2xsnX+D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1433
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595861828; bh=zwZ8GaBjxQ/nb9+2QIEwjV6yH5y/oSQ58jIZf5o9VkE=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=c3g64ulXR50ByfTTsrK0cME3cCk4Pw0lbSc74LfgYXNEBxDXwhHO99Uti5gNQQwrh
         KwHhJaD8OAjuX7BB06k+RfJDx2nsSgc4Jhfrh8KgFgev7m5rWGozrEWAD1RZzOau0e
         GFjK6U4LJ27tgzMUiBR4qZQoDJ+haMB5jHHs+dyikJleNYaIToiTwKi59t/CJhdtuL
         yRzyspiA/3GoKa922apyBU4K3jQ4Rg/rJFivCl+Q816rtum8V1MGeHLhVHAidj/fcv
         LOEBToC2AzBkL9wFI96kfW9v9c2VSRm9VVXksQUnOmBzjavMJRE4hO6S40VbmXMMnY
         soWpuzU5xx3VA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 24, 2020 at 10:19:29AM -0300, Jason Gunthorpe wrote:
> These are missing throughout ucma, it harmlessly copies garbage from
> userspace, but in this new code which uses min to compute the copy length
> it can result in uninitialized stack memory. Check for minimum length at
> the very start.
> 
>   BUG: KMSAN: uninit-value in ucma_connect+0x2aa/0xab0 drivers/infiniband/core/ucma.c:1091
>   CPU: 0 PID: 8457 Comm: syz-executor069 Not tainted 5.8.0-rc5-syzkaller #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>   Call Trace:
>    __dump_stack lib/dump_stack.c:77 [inline]
>    dump_stack+0x1df/0x240 lib/dump_stack.c:118
>    kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
>    __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
>    ucma_connect+0x2aa/0xab0 drivers/infiniband/core/ucma.c:1091
>    ucma_write+0x5c5/0x630 drivers/infiniband/core/ucma.c:1764
>    do_loop_readv_writev fs/read_write.c:737 [inline]
>    do_iter_write+0x710/0xdc0 fs/read_write.c:1020
>    vfs_writev fs/read_write.c:1091 [inline]
>    do_writev+0x42d/0x8f0 fs/read_write.c:1134
>    __do_sys_writev fs/read_write.c:1207 [inline]
>    __se_sys_writev+0x9b/0xb0 fs/read_write.c:1204
>    __x64_sys_writev+0x4a/0x70 fs/read_write.c:1204
>    do_syscall_64+0xb0/0x150 arch/x86/entry/common.c:386
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Fixes: 34e2ab57a911 ("RDMA/ucma: Extend ucma_connect to receive ECE parameters")
> Fixes: 0cb15372a615 ("RDMA/cma: Connect ECE to rdma_accept")
> Reported-by: syzbot+086ab5ca9eafd2379aa6@syzkaller.appspotmail.com
> Reported-by: syzbot+7446526858b83c8828b2@syzkaller.appspotmail.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/ucma.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to for-rc

Jason
