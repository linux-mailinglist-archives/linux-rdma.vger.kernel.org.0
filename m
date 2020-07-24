Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A56122CEE1
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 21:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgGXTvb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 15:51:31 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7026 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgGXTva (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jul 2020 15:51:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1b3b460000>; Fri, 24 Jul 2020 12:49:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 Jul 2020 12:51:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 24 Jul 2020 12:51:30 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jul
 2020 19:51:23 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 24 Jul 2020 19:51:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF1pn+ros4icGqIfhexZe4olNzrE9N7Hh81brCU5+BB9xbdQXAOsvUlu+l0eMTHNxL9OunBlduRTHm8dr+6K6e5Kw2SJIMUmJPSkpqZ2IHho/yd+M2Z+fkpMvKzAF18CxmO7X+qOSbbPOlFxM8ZVvwqP9C2Fst5BYINn0WevLn4HbdHh4IzPjdSh0czc9essOpAd32MbDLg3A7Gz0EPIPfZMrhoQBiseVYG6/b++y7tsro7ArVv6p7baX2+BwSC9fuKLJ7+33nbPxQJYQrakWzFMhE+QMt523MmLpFUNzZZpivcWKVnhHVkp+z/ZkBNOBVa6dgVD6YW9VWoMdPZiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WLdTQzI4cru2l8KwS9IzlluGbX5mrNinV0g2balMUk=;
 b=eK7TS4OEWd9D4WwyDxUbpEBW84cnlEZpRcJ7i0VL2GE7vtyiYfG2eFhgVIU7Ga69KTEd3jiseYMKouim+oku4lU6AejOmJdkYefDKwRMEB6+Y2ePK5NYzut6vMgtOjZTf4ES7y1phpiiOflKlsHeNoBCMmwAc6RCL5H3we/Yg8+9od+Y0euuu608Moy3ufFFOwjUIyrrP6emWBez4dYxuc3vqY3bbnH8LiVTtL1epol6dJuCgCJNUH1JKaA94XX22jCHl+oc9wzt9MJVoPBj8CLEaVbJbjB6KqAoA4DsgcNM48Xk6982dSlM7b2HtqkRG5t7tf1fEcaDDcsqxKwTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Fri, 24 Jul
 2020 19:51:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 19:51:22 +0000
Date:   Fri, 24 Jul 2020 16:51:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Add missing srcu_read_lock in ODP
 implicit flow
Message-ID: <20200724195120.GA3662274@nvidia.com>
References: <20200719065747.131157-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200719065747.131157-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:91::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:91::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.10 via Frontend Transport; Fri, 24 Jul 2020 19:51:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jz3iy-00FMjn-Mg; Fri, 24 Jul 2020 16:51:20 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c03f6c3f-2bf2-43e6-aee9-08d8300af0b0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4137:
X-Microsoft-Antispam-PRVS: <DM6PR12MB413740935BDF77D6594F9F00C2770@DM6PR12MB4137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5m9wLMZ47TSdO4iWuyTwEo0DFfuzNeIDgUrHSd2PCSiuABCBHOqD9ZaMJ3/yXKOtm3TD45zYqvLMTYtaU2hDFcUHVmGlfn3vzN8jqFFZAbhiVF6U+3+R9J3V4fsSFO7VHwx7HkJnf92CDlVZMSOQ0pcq0JY8AfI11x3tdskbZik+LTnDg9S2x9JPkqXIyDVzAa/ztDDvPObVjO3xYqGqGoF8frlChHrKHKWb5zKYKMRHni70cw1z0aMLb6bsVvKzxpJLlcaCIDiDmzenBJ+jr/fflddIqMRakTs0rJitvJgRWq54i+jtDq0ukuHiQHxdIAWydLZT1BnwFTUR79h4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(8676002)(66556008)(316002)(2906002)(66946007)(66476007)(33656002)(54906003)(478600001)(186003)(5660300002)(36756003)(86362001)(45080400002)(426003)(9786002)(6916009)(8936002)(83380400001)(4326008)(9746002)(1076003)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: I0aFL5AQk/j47LUf/3eq8DIn5PvRCywyaX91ztp94TmwlZRds1r0zfM4f63FpnVPeeH2mI7gTKWxm1TMHMWEcOLnm+oWm8ALkbVqIB2kFdTWv5q1LkB0oB3Yh9FeLPEJjgyY2jtnIofpUkVhGkLKPssN0LB+/4Se63sDkqmbs94vXuZ4uZMOqD90bpXAVVUXckLUnrAXX2k0SUJAF+dwE5Py++Nnc2gArAtTAncWekxPDd7k+4VIrSioYaq7Zh1ot+pIZqnrjo+4+iOx8vD5kEMOfu69HrLs6LEedLEoDoxL/4369Ntrt5rKoZGwpfFoz1+GCLO1MKwuTiJDu5QQcOBRx1fpZPdMy7XDrL18B2JxFPXUUihZtqGkd2YjgwPDBkEvwiZIwFMt9jORdroI6asD/0jBg2WwQr/rzdR/kqNl+tGu3kC5HaZOb3cEOKblg4Ti8AWh51A831+8puOuJh7l7z4ZXHZxjWWD3+TXPjM=
X-MS-Exchange-CrossTenant-Network-Message-Id: c03f6c3f-2bf2-43e6-aee9-08d8300af0b0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 19:51:22.2550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrNWUO7l4b66lFMK10ScPYHnnpzDxfxxkx6x/oLFSAT2I61YhfSi/lz6E76XcaL3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595620166; bh=/WLdTQzI4cru2l8KwS9IzlluGbX5mrNinV0g2balMUk=;
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
        b=GVuYnQVxUcp5NSjiP9DP+/ymqOxoWSPlJ5KJfSSM/L85BB+ghgHVxSVDGkkA1yHBW
         tYHccviieIFrShz+kfR2anVfgP2PlzbDYaz9OEdJxG6A5ui17uwMPwJ3UGcajvy0Ru
         2pwzTaTA+jDNdY29UmNuSPSzo1/fc+mhsiYPk5ziPtaD/XojOr6xB+yFuok2XV/u+M
         smf0RF6g9/v9wGjTfyHUeCv14cmrDqBeICup7xi/oEcpXxriG1M6wNlf77ebuSvCec
         vtrk1HXUh2aRYrOhfuTk7DkyB367Wp6rEwuRvDJ4wKkXqzEN+hsY1dk9WjHOs+kZ09
         RKSAjrSNzhZSg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 19, 2020 at 09:57:47AM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> According to the locking scheme, mlx5_ib_update_xlt should be called
> with srcu_read_lock().
> This fixes the below LOCKDEP trace.
> 
> [  861.917222] WARNING: CPU: 1 PID: 1130 at
> drivers/infiniband/hw/mlx5/odp.c:132 mlx5_odp_populate_xlt+0x175/0x180
> [mlx5_ib]
> [  861.921080] Modules linked in: xt_conntrack xt_MASQUERADE
> nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter overlay ib_srp
> scsi_transport_srp rpcrdma rdma_ucm ib_iser libiscsi
> scsi_transport_iscsi rdma_cm iw_cm ib_umad ib_ipoib ib_cm mlx5_ib
> ib_uverbs ib_core mlx5_core mlxfw ptp pps_core
> [  861.930133] CPU: 1 PID: 1130 Comm: kworker/u16:11 Tainted: G        W
> 5.8.0-rc5_for_upstream_debug_2020_07_13_11_04 #1
> [  861.932034] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [  861.933801] Workqueue: events_unbound mlx5_ib_prefetch_mr_work
> [mlx5_ib]
> [  861.934933] RIP: 0010:mlx5_odp_populate_xlt+0x175/0x180 [mlx5_ib]
> [  861.935954] Code: 08 e2 85 c0 0f 84 65 ff ff ff 49 8b 87 60 01 00 00
> be ff ff ff ff 48 8d b8 b0 39 00 00 e8 93 e0 50 e1 85 c0 0f 85 45 ff ff
> ff <0f> 0b e9 3e ff ff ff 0f 0b eb c7 0f 1f 44 00 00 48 8b 87 98 0f 00
> [  861.938855] RSP: 0018:ffff88840f44fc68 EFLAGS: 00010246
> [  861.939707] RAX: 0000000000000000 RBX: ffff88840cc9d000 RCX:
> ffff88840efcd940
> [  861.940788] RDX: 0000000000000000 RSI: ffff88844871b9b0 RDI:
> ffff88840efce100
> [  861.941880] RBP: ffff88840cc9d040 R08: 0000000000000040 R09:
> 0000000000000001
> [  861.943020] R10: ffff88846ced3068 R11: 0000000000000000 R12:
> 00000000000156ec
> [  861.944133] R13: 0000000000000004 R14: 0000000000000004 R15:
> ffff888439941000
> [  861.945228] FS:  0000000000000000(0000) GS:ffff88846fa80000(0000)
> knlGS:0000000000000000
> [  861.946557] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  861.947512] CR2: 00007f8536d12430 CR3: 0000000437a5e006 CR4:
> 0000000000360ea0
> [  861.948609] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [  861.949684] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [  861.950804] Call Trace:
> [  861.951300]  mlx5_ib_update_xlt+0x37c/0x7c0 [mlx5_ib]
> [  861.952145]  pagefault_mr+0x315/0x440 [mlx5_ib]
> [  861.952895]  mlx5_ib_prefetch_mr_work+0x56/0xa0 [mlx5_ib]
> [  861.953763]  process_one_work+0x215/0x5c0
> [  861.954477]  worker_thread+0x3c/0x380
> [  861.955127]  ? process_one_work+0x5c0/0x5c0
> [  861.955851]  kthread+0x133/0x150
> [  861.956426]  ? kthread_park+0x90/0x90
> [  861.957061]  ret_from_fork+0x1f/0x30
> [  861.957686] irq event stamp: 199569
> [  861.958318] hardirqs last  enabled at (199577): [<ffffffff8119bf39>]
> console_unlock+0x439/0x590
> [  861.959720] hardirqs last disabled at (199584): [<ffffffff8119bb81>]
> console_unlock+0x81/0x590
> [  861.961080] softirqs last  enabled at (199600): [<ffffffff81e00293>]
> __do_softirq+0x293/0x47e
> [  861.971725] softirqs last disabled at (199613): [<ffffffff81c00f0f>]
> asm_call_on_stack+0xf/0x20
> [  861.973142] ---[ end trace e6f026aa6012c21e ]---
> 
> Fixes: 5256edcb98a1 ("RDMA/mlx5: Rework implicit ODP destroy")
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> It is not really need to go to -rc, not urgent.
> ---
>  drivers/infiniband/core/uverbs_std_types_mr.c | 2 +-
>  drivers/infiniband/core/verbs.c               | 3 +++
>  drivers/infiniband/hw/mlx5/odp.c              | 9 +++++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> --
> 2.26.2

Applied to for-next, thanks

Jason
