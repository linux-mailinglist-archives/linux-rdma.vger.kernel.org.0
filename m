Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094EE4538DE
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Nov 2021 18:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbhKPR4A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Nov 2021 12:56:00 -0500
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:18337
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235838AbhKPRz5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Nov 2021 12:55:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0OVhgidPcPQnfuyUZKBmsgNxq15wxr0MwuJjJGjdJ0M/AZPsp9ByA+i9JOCoHCGwOBYZF/dY9PpT38TnSmdaCrDYP9gmNu/wWHttpaanB6zxgMBgzH8viJjI298BSqGms31DzJs1z0J4b37pihP7iD5auyYNkzvd0QiPWDNZbK7YDyvwM5x+F1k5dcfKWvRGbTgOVOWV9GV+DdPAALov5d76FGo7lya9icx0YFTL1dM/HAlIVv+wK6pjLQvnrZvN4+qKR6+SFgru3o7ssffKLqi9eVDyQDIV47uJx99ce6jHIUmu1v3/PpDNkM5odqiDeboo2zpQ3zk+jzgN6ni9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSYiYtM9umOOzpt/psr6hFo8+AZKI3YV9rvXNV33vdM=;
 b=ikrA/ubDW8lbByE/IgdaLtdFsWOcYsYJbagTDLbo8JiWcb9apv7kFCJk6r/9C6s2tqIBLDf23yOYN3oR1aGo00ShGHBTMCsdmvvkViSZBy+He5ezFyECDxwC+asr1t+4y+/L1hFYQN/OOhFsxHIwXVUU9cSopsfyiAIus9cnbG+rCStjIubN19ufG3h1j7knb3NrkHDK8x2S1fMEalfOQ/+p5aaWPPHDbzJ94MMO+7xoZ6fJVvHSfBaizPeP5s5tWydEjDzzl1D2WVd9uuw5PvqOjdB3uCA8ZRx5AIRsF8khicPK6g0UuhLFJcTG5QZ0Irb7ZXjRomnNhBNlvP+0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSYiYtM9umOOzpt/psr6hFo8+AZKI3YV9rvXNV33vdM=;
 b=oLnuT5z/syybyFsbNF6XIsHjuiPnV46WUyNLxPXk+3rFwrEr0RmIzujO5FCI37FWagAS4scvjju/QJYUb15+N+F4HWnpH2nDAtIWoAdX82thXoSThYMqGyruOz8ac/WJ0hmJnFvhhtM8TozxzX0M/VlpOmibd30iUaGJrBUspagDFonMJaaKhV8RUWVFbFCkPRWFAZ6K0aa7Y1XAAg45mvEGlKOOgRZBWspluj0kXdQnqsTqqzc758bZLRHn0fGBmLLhvRSDiiYUJHJsPNFh0OTJst+nofKzIoF0ZOHeD/mWVvFOXs39Vl5Z28QcrzOzjpefqgyoQ+n3bLMsdzHT8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5256.namprd12.prod.outlook.com (2603:10b6:208:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 17:52:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 17:52:59 +0000
Date:   Tue, 16 Nov 2021 13:52:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: [PATCH for-rc] IB/hfi1: Properly allocate rdma counter desc
 memory
Message-ID: <20211116175257.GC2656760@nvidia.com>
References: <20211115200913.124104.47770.stgit@awfm-01.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115200913.124104.47770.stgit@awfm-01.cornelisnetworks.com>
X-ClientProxiedBy: CH0PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:610:32::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:610:32::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Tue, 16 Nov 2021 17:52:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mn2dd-00B9BH-Nw; Tue, 16 Nov 2021 13:52:57 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c298134b-2271-4268-b3b8-08d9a929ed32
X-MS-TrafficTypeDiagnostic: BL1PR12MB5256:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5256D469F42FD09FB8EDC5ECC2999@BL1PR12MB5256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OoHanfxUMpR89XGOuLIXt/xuS6A97yTYs15OUJIpLI/L5su2tw5ViV9YRTmo0eVUCJn9tNHP0hc5HzIC0JfEaWgC98y7nLaDXl8EcWCQ9LQUmi24BeLoU9u+kef5vm/KyMU5TF8fHCL/S2i8voaYLgJiQb3yP1GIsBpXVp6iNFis9VL4C49iwTaw7h1RVQ6QrFgMepQxTUAQzNr6a8dZy6JKKt/ZugtIzEuZSSkbLJ9EtCes6Sfnv1jvmEllkC5sZ5YCaji42LSzENasvvoMoGm01UJjQU+0hJAGdhbXkwmMgM5n8WWWI0TFMAuC3MljNLdEXn9wSWZoaabqFYfsWYLGfqOA+R1Ebf4mKsoVAzgpqF14oDBedftiLyHTg7HCzg5hSyMqMdY0MCaAiSe3Fj5ii82AD3Bb3hOBjaiTMvdHenK79rA4iwHLj7iFU8X8JGl1je/r434Hr+dBbVnS4FEXsQrnyurWVOLj5AS6f9dVtIJAqLxBN5TdDcgxwIac6BChN0zGOTObQiaEp2xwLwtVhuY+JSNe2e2EPBHN0psl/yA7NeN670IPTGA894Lu8OvuAjx9XtLeivnFyT62Zp1IK7Y4WVjgQxYZA/92VrS2blWzupB16r399A/2aqjdbZvVmN9TX0W5kyX9nSxy3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66476007)(36756003)(2616005)(66556008)(186003)(26005)(1076003)(5660300002)(8676002)(86362001)(508600001)(45080400002)(4326008)(9746002)(316002)(9786002)(33656002)(38100700002)(83380400001)(426003)(2906002)(8936002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gfMoAsdFwjx2IwKWMAi4p44raupjwSEd9fMBLxTg/1gye3U2mYORRjOY8N2N?=
 =?us-ascii?Q?d7tXi+mHpL1qcisbIvVdhIemVx+Qi5oqE8JlK4RtLND4GvMo9BwnZpuw+RNh?=
 =?us-ascii?Q?QIfXX0cVUJprSFwxjlVBrWu5eB70HLjDk0/++8UkbXjWE4c6Sf8Rr/erZUPN?=
 =?us-ascii?Q?qMwMOSC9ED6bNENbarcNs/DSSvDHRW8XGn8xmWMYrp59d4WJsmTyIVdMA0qN?=
 =?us-ascii?Q?PycvmjJMiPusnuFSkhsqXp/OBdXonSQYgVA7zTXCA+RqdV5PDlkIPej694EH?=
 =?us-ascii?Q?6cHxQdCyJaLLO/EPELjpi6OJK8hKXNFvQdv0O+7BWGZYR7uq3niSC9YbvGUl?=
 =?us-ascii?Q?TwL4KHoawhtD65WOOf9mHJLxZb+/U+HKH+wNdtXPXPfmqDrrSRSDzzbxLYGY?=
 =?us-ascii?Q?u7GZi1TBNJpqqK7aBAOxByLW6B/v4GUJmUk7T3HfIls7rIHyOFa3BespnVQC?=
 =?us-ascii?Q?ii0fI99DTcQ+/XPz3d+pQ7fhQWAZLkLlQ3pMHxTMJ6SrzF6H7eUJrem5soJs?=
 =?us-ascii?Q?i0pBvra6uEIFlNgcKNBOtGZmctmpQb+ay898WpjXdYKCCtiG2FRzvmxRqeNI?=
 =?us-ascii?Q?ubbWy2MBSvZ5FQh6frQAmqjviB36c3RIPEYB+xfGbEZdN8ARkHHWfLhuOiBr?=
 =?us-ascii?Q?VD/1fHYFQ4D9JdCFfVTA0TyLzXCbI4eZ3eZahCl1sUswN4Uj4Fyvzec01oqw?=
 =?us-ascii?Q?ZZJgxafddK9bHx6wF70e64ZpTtG++mam+qWZAmkG9MhEa1M7l86Xof/qmTwX?=
 =?us-ascii?Q?8npVP8Fg+LJgCgQCKgVo/Enwf4dQu/zvjoZavBIVQm6zlLUad4iatHwkzR8v?=
 =?us-ascii?Q?F1JjjfSXC7AHpF4c+EEtvpZvoI5pe5Ypvhx0GOWBeqPYN6EyxRS+vPLi6iSV?=
 =?us-ascii?Q?lvhD5aXwxfvTenniFpjmqeK9j+MNYeJtg4ZGEgZzd87MU/vYlYZb2vSuKP0R?=
 =?us-ascii?Q?QjFizDUlLSg8dj8WDsgRRzfTeHT1AafPJ6uH5tK6EnPpKpXPoR44VBUNqx7b?=
 =?us-ascii?Q?qyHRRvoXDcv5hn9DpZ015yGf6r0THtC53t4U1pvFmKEEUs5r4cCgWBmIkPiw?=
 =?us-ascii?Q?nzsym6kUw71Jly8QxtVSp+8AffS8AZvkeAKAWpJrCaXTkDy6z23pMzVF2hoT?=
 =?us-ascii?Q?wYs8pf60f7HNug8GgTCn9915emU1kur2HHk19CLD9cJ+POKLnlu/JJs+kQax?=
 =?us-ascii?Q?7nTJHN9OrqarsBMvDjJtrsKYkif16NdSEAvyqLZSd/k5k9jQF+VtgkZP5IMH?=
 =?us-ascii?Q?quGJTWCs1yOdhoO80qZrdDUSUQsaeHvPTy1LkgZosgDJ388ilxxZDjBljMOl?=
 =?us-ascii?Q?/Zfnk+ZjO5LnKjd9fzDTAwZdpC2DDU97/0sqtKV8GI/bZmoAkwYXPSQnqaaK?=
 =?us-ascii?Q?LsdvCiEk1FFJPkrPtgrI/cW9fkwRS+Z9GA9bItJud28dNYzLNSHNBuARfZi6?=
 =?us-ascii?Q?VEiyxyMuRGSol/TGIFCqWGG1rdu6XIMIL6p7sEL6v8/aTJu6e8HcTPg06Xui?=
 =?us-ascii?Q?QNkxIn896sQY6bBfSnCZfkT8SZsqO4GeMIIHHgKt+mtJO8ihBO8bJXy17abr?=
 =?us-ascii?Q?4NDqblwRz+K+qic3yMw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c298134b-2271-4268-b3b8-08d9a929ed32
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 17:52:59.1327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29JQGl6mBaBWpZqJL4wpz78gwB05hwo2FE5h+gDUfwcAcXV5LXpv3tesMUxklmjS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5256
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 15, 2021 at 03:09:13PM -0500, Dennis Dalessandro wrote:
> When optional counter support was added the allocation of the memory holding the
> counter descriptors was not cleared properly. This caused massive WARN_ON()s in
> IB/sysfs code to be hit. There is an assumption made that optional counters must
> not come before required counters. This is determiend by the flags field which
> was not zeroed.
> 
> The result is the console is flooded with WARN_ON for over 3 minutes on driver
> load. We can fix by simply using kzalloc vs kmalloc. While here change the
> sizeof() calls to use the pointer rather than the name of the type.
> 
> [77952.529518] ------------[ cut here ]------------
> [77952.535428] WARNING: CPU: 0 PID: 32644 at
> drivers/infiniband/core/sysfs.c:1064 ib_setup_port_attrs+0x7e1/0x890 [ib_core]
> [77952.548374] Modules linked in: hfi1(+) rdmavt ib_ipoib ib_isert ib_iser
> ib_umad rdma_ucm ib_uverbs rpcrdma ib_srpt ib_srp rdma_cm iw_cm ib_cm ib_core
> nfsd nfs_acl scsi_transport_srp rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver
> nfs lockd grace fscache netfs rfkill sunrpc iscsi_target_mod target_core_mod
> libiscsi scsi_transport_iscsi vfat fat iTCO_wdt iTCO_vendor_support mxm_wmi
> sb_edac x86_pkg_temp_thermal intel_powerclamp mgag200 coretemp crct10dif_pclmul
> drm_kms_helper crc32_pclmul syscopyarea ghash_clmulni_intel sysfillrect ipmi_si
> sysimgblt fb_sys_fops aesni_intel mei_me i2c_i801 ipmi_devintf crypto_simd
> i2c_algo_bit drm i2c_smbus lpc_ich cryptd pcspkr ipmi_msghandler mfd_core mei
> i2c_core ioatdma wmi acpi_power_meter acpi_pad sch_fq_codel ip_tables xfs
> libcrc32c sd_mod t10_pi sg ixgbe ahci mdio libahci ptp crc32c_intel pps_core
> libata dca [last unloaded: ib_core]
> [77952.640387] CPU: 0 PID: 32644 Comm: kworker/0:2 Tainted: G S      W
> 5.15.0+ #36
> [77952.650229] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS
> SE5C610.86B.01.01.0018.C4.072020161249 07/20/2016
> [77952.663077] Workqueue: events work_for_cpu_fn
> [77952.668831] RIP: 0010:ib_setup_port_attrs+0x7e1/0x890 [ib_core]
> [77952.676337] Code: 48 83 7b 70 00 0f 84 e4 f9 ff ff e9 17 fe ff ff 31 c0 e9 4b
> fb ff ff 48 89 ef 89 04 24 e8 67 d0 a8 e0 8b 04 24 e9 1a fb ff ff <0f> 0b 49 8b
> 10 e9 de fe ff ff ba 34 00 00 00 be c0 0d 00 00 44 89
> [77952.699056] RSP: 0018:ffffc90006ea3c40 EFLAGS: 00010202
> [77952.705749] RAX: 0000000000000068 RBX: ffff888106ad8000 RCX: 0000000000000138
> [77952.714567] RDX: ffff888126c84c00 RSI: ffff888103c41000 RDI: 0000000000000124
> [77952.723370] RBP: ffff88810f63a801 R08: ffff888126c8a000 R09: 0000000000000001
> [77952.732156] R10: ffffffffa09acf20 R11: 0000000000000065 R12: ffff88810f63a800
> [77952.740943] R13: ffff88810f63a800 R14: ffff88810f63a8e0 R15: 0000000000000001
> [77952.749717] FS:  0000000000000000(0000) GS:ffff888667a00000(0000)
> knlGS:0000000000000000
> [77952.759556] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [77952.766765] CR2: 00005590102cb078 CR3: 000000000240a003 CR4: 00000000001706f0
> [77952.775527] Call Trace:
> [77952.779051]  ib_register_device.cold.44+0x23e/0x2d0 [ib_core]
> [77952.786298]  ? __vmalloc_node_range+0x1fb/0x320
> [77952.792158]  ? __vmalloc_node+0x44/0x70
> [77952.797234]  rvt_register_device+0xfa/0x230 [rdmavt]
> [77952.803568]  hfi1_register_ib_device+0x623/0x690 [hfi1]
> [77952.810238]  init_one.cold.36+0x2d1/0x49b [hfi1]
> [77952.816236]  local_pci_probe+0x45/0x80
> [77952.821189]  work_for_cpu_fn+0x16/0x20
> [77952.826132]  process_one_work+0x1b1/0x360
> [77952.831368]  worker_thread+0x1d4/0x3a0
> [77952.836310]  ? process_one_work+0x360/0x360
> [77952.841741]  kthread+0x11a/0x140
> [77952.846098]  ? set_kthread_struct+0x40/0x40
> [77952.851521]  ret_from_fork+0x22/0x30
> [77952.856257] ---[ end trace eadcb3e247decd87 ]---
> [77952.862174] ------------[ cut here ]------------
> 
> 
> Fixes: 5e2ddd1e5982 ("RDMA/counter: Add optional counter support")
> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi1/verbs.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to for-rc, thanks

Jason
