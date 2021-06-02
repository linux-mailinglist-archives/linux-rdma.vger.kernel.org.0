Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D553992A5
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 20:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhFBShG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 14:37:06 -0400
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com ([40.107.223.87]:53856
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229468AbhFBShF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 14:37:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7xytipjBkOU2NE5c4T0tlv8+lfLbLJowWnITSEwdYc8Otz35VaW7Dw9p5ytp0ORV0L/rv5AJgK0KpI+v6Z/AaUj0yr9AE6WwAS8SFhDuT9fAOvX/MBl37Jg5j4N+awBm6SgIpINLamFXippnAOaAIKBAxADhN0oHegLmEzZYYEwKeEYmOYMSWJWBG8j+ro01LSa2dhAFHElT96lKY/xSc3bjTKsTJI37+JiTAYGJzsWmDetojiSmiKzVbRGoKiMG8o6wIkHaUPCF9S1grOtOUadXSiwc2pR1aJacVN8xz2gGm31uulUNWPUY/G8nDP6oS3An8Z/0iihRcX2hj1y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUphzbwtDvwxh5p+U1jHF6eZ5FBP+sITJwd6OgspNXM=;
 b=PtITQbGeUrG7tbUTrTKR3W0YWBmM5uu8/OWeZDhCsiTYyaQg8ps8RKszMJ3CBHEciYMl8UyM9yLhbOD2w1KKhX10BsKA0dwrL3UVEwIRN1A+pTIl3f7ICCLowfXHg5iPeHar/W+TTgufRzRWC8UUxxcyE/bVOTkKGy8ozs85/oMtLxFZwAyWUSRuHma8ti+1OSpVnpJFqu1RD1WzQ11VneEma805gppPI+XLL/D2Zztqpq1275kBlQ/Ei1wGpWM6MOCXYQoPkitELnKONWmjnqhxXvKL1oghdufXHro24LIsSTlYoFQgwQSeGIDe93VKn14kWvbxvn2P3Y46cECP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUphzbwtDvwxh5p+U1jHF6eZ5FBP+sITJwd6OgspNXM=;
 b=aIvKDncdxj3/OcVXDcHxBt+a2DNEjINhYFicWQS2RAXbZlog5QCME8FEVYMxHi615RieAEarWxm1EMXxi6xgWmTv1p7RQTwf4lRCr98E8t5JKmCzIVhA6bt93IkPa1ZeiGjBvOyAVYRzpV2+X4Yk6pLoEvLTCxgpTza5qy4dIPKhfG/zkFsMFVY1WZMvwmZTyDFEbFguCFi5lVRnndGLJ6qft0IgOrPEOsQ3zoqqtnM3tjaCXo7lg3/wZ3H2UORVVqesAitQ/UG6HKRNkRxp+vnCkcqY1lz1Pyp3PJWla5CbI5pUQiIYxT9mFx0PIjmwFhLY7POskDDzPJ2cyToLgQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Wed, 2 Jun
 2021 18:35:21 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.020; Wed, 2 Jun 2021
 18:35:21 +0000
Date:   Wed, 2 Jun 2021 15:35:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/ipoib: Fix warning caused by destroying
 non-initial netns
Message-ID: <20210602183520.GA120702@nvidia.com>
References: <20210525150134.139342-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525150134.139342-1-kamalheib1@gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:208:fc::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR02CA0007.namprd02.prod.outlook.com (2603:10b6:208:fc::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend Transport; Wed, 2 Jun 2021 18:35:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1loVi4-000VPI-8C; Wed, 02 Jun 2021 15:35:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c24321c-4ae5-47fa-77c0-08d925f52d91
X-MS-TrafficTypeDiagnostic: BL1PR12MB5159:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5159FA9824FD020382D920E0C23D9@BL1PR12MB5159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmLiCfiRo/jQJxj7/LIBuYXCAF+5iPUorCu9Fpjb1PqZq7sOCjqqGF3yrb607wAspDAekW+SjW9hPk2+FCn7rq8/o9ViyNgjcQwA44I8l+3UQfJwzIGR+cQXdE5ukTZjVwF2cRhDG7H/oUPm2yKn4VDoDGk5Rng4xAwHzc277T1T08FStOJusBWQgth8AzmhzBreX4xNU6MLIZkgGExxuNE3ydV6zuOON52GlcXSrxoqaO6KxhOHdRYyAU6siQq/Xinb3jtWdfBhi9U3IEYgef30hIbibk3F08bTxWpDaO7pVzrZFM63Usg41axt6ANoonuS6nkDjMdwabhC9ZdrVMv2d5SLq8m8bLYX5B7oYOfdP1eBXGbt5kdsuiTihkJZcWEoJwob+AXDNcqXyt0DWgRs+HVAKSEr8HVo0IXvimFfsA7haktYgOkd0Hu2fEubjjAOyou5RfCuzwxsv4M32/B/8lQ647II5cyye08mQhSNf8lFS33ILsILmV2nyxd6QPMmy+8Ead2C0louiuYMt09t4koFnQq2MPGWaR2iEUExONxAJX+MNfIKwJa8KvWp1Yq3RJw76bOk+MnK0yMGU+WpVxw8eVbd9fnoSEN2wV6Nb7s/DGpjdQc0TKr0bXQaE4xVywQaeBZwInhIYznHPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39850400004)(346002)(136003)(396003)(186003)(6916009)(316002)(4326008)(86362001)(426003)(26005)(45080400002)(33656002)(36756003)(2616005)(8676002)(478600001)(83380400001)(8936002)(5660300002)(38100700002)(2906002)(66946007)(66476007)(66556008)(9786002)(9746002)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zbFsopr7KRnN++0Z9kHXeU1mD3lYCYhtbY/K23Kq3mFkHCMYuGFG5us2Ie4iLY2lXxWgs32tKd3vrmg1eUs0NZQwNlDE/ZJprhQ+j3VERAnlzwc17MU2QoMbDuqZnAtSr4sfXFQKJAPvJNzGfmRj7bWvu4kyZz0K8YaMIN6XRgXTdb9PHtiYkN/VpUL5brWJj7sZ0sK/wA3u2S8fXeZ5P+cxDGw2JUs+Mhi3PO/Q6kBnNJ5oaPj5ukmVUfwKpGPtZrFq2PQZKF9z8s4RddbXeEyC0S+QILB3awx/PISSt+8NtchIZT8DRaoRGr1JOcaQSzvVnmDDOFpnL2oz5LI+C7m6dkWunVrW4MhuXcZn9Q1A9QISD/5+RPojXneu9leYN2Ps7AKoB1iIrsSVrktwpsFigpb2JiCjInrVYuHldTePHBk5HuXaY0sBvFtNRP+CkatA2P8ug9J52DjfPQNl0Uo2mnSJRiSLs9DmtVDY21bcaZEBedyC6NiQxXxh613//1K0wHBVegCU9BDtggB0oswHSzBcaIBtav6qaWo0aiKBiR+F2MxFOnfH9zpXOxAgfs0WU4TV/TKou+ep3CIwnzVqSXBLPtEPu642Yjy/1Qzo0qsslP6Nfx/yDGkV1Aej577d9b07DdVRcRsQ0nzmpH7HRJhernFEhEoJjBN4LzntbIcy9BOOCWggWLDoTmwmL0uamxaxtEEBbjlpEBAGgKIB6SppLi7Np/t4ttt1iFxhy/CvEMtQCfnONKi/O1HW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c24321c-4ae5-47fa-77c0-08d925f52d91
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 18:35:21.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLaR8lzFX/V47dzuUzA+DWqqi0X+dbNdMjOFrM+5iXF7uMksqijLUS9mvn0x4dar
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 06:01:34PM +0300, Kamal Heib wrote:
> After the introduce of 5ce2dced8e95 ("RDMA/ipoib: Set rtnl_link_ops for
> ipoib interfaces"), If the IPoIB device is moved to non-initial netns,
> destroying that netns lets the device vanish instead of moving it back
> to the initial netns, This is happening because default_device_exit()
> skips the interfaces due to having rtnl_link_ops set.
> 
> Steps to reporoduce:
>   ip netns add foo
>   ip link set mlx5_ib0 netns foo
>   ip netns delete foo
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 704 at net/core/dev.c:11435 netdev_exit+0x3f/0x50
> Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
> nf_reject_ipv4 nft_compat nft_counter nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun d
>  fuse
> CPU: 1 PID: 704 Comm: kworker/u64:3 Tainted: G S      W  5.13.0-rc1+ #1
> Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.1.5 04/11/2016
> Workqueue: netns cleanup_net
> RIP: 0010:netdev_exit+0x3f/0x50
> Code: 48 8b bb 30 01 00 00 e8 ef 81 b1 ff 48 81 fb c0 3a 54 a1 74 13 48
> 8b 83 90 00 00 00 48 81 c3 90 00 00 00 48 39 d8 75 02 5b c3 <0f> 0b 5b
> c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00
> RSP: 0018:ffffb297079d7e08 EFLAGS: 00010206
> RAX: ffff8eb542c00040 RBX: ffff8eb541333150 RCX: 000000008010000d
> RDX: 000000008010000e RSI: 000000008010000d RDI: ffff8eb440042c00
> RBP: ffffb297079d7e48 R08: 0000000000000001 R09: ffffffff9fdeac00
> R10: ffff8eb5003be000 R11: 0000000000000001 R12: ffffffffa1545620
> R13: ffffffffa1545628 R14: 0000000000000000 R15: ffffffffa1543b20
> FS:  0000000000000000(0000) GS:ffff8ed37fa00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005601b5f4c2e8 CR3: 0000001fc8c10002 CR4: 00000000003706e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ops_exit_list.isra.9+0x36/0x70
>  cleanup_net+0x234/0x390
>  process_one_work+0x1cb/0x360
>  ? process_one_work+0x360/0x360
>  worker_thread+0x30/0x370
>  ? process_one_work+0x360/0x360
>  kthread+0x116/0x130
>  ? kthread_park+0x80/0x80
>  ret_from_fork+0x22/0x30
> ---[ end trace 74b40f8fbd65a323 ]---
> 
> To avoid the above warning and later on the kernel panic that could
> happen on shutdown due to a null pointer dereference, Make sure to set
> the netns_refund flag that was introduced by [1] to properly restore
> the IPoIB interfaces to the initial netns.
> 
> [1] - 3a5ca857079e ("can: dev: Move device back to init netns on owning
> netns delete").
> 
> Fixes: 5ce2dced8e95 ("RDMA/ipoib: Set rtnl_link_ops for ipoib interfaces")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason
