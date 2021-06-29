Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1473B7A93
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 01:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhF2XJA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 19:09:00 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:61025
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235456AbhF2XI5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Jun 2021 19:08:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+Ubbt2xTbb3cR0wxVkcxEmJxKGOx1hOsTasiZZt6HXmqUQ9Jny9rdhHOlItU4sTpzsONbcRT2L1GOJ7iauIL++pqbBUjvxZal4/B92AYKxa844mQBWCcx7zFu4D0oIPUd3qoA+ttfWiUPYAvb0APt2QevapewghDNY/pXQoVB1E0yz4wN457NiL9Og+4mvWSo7oM+Cb4y2kwKc1AmNqSS1E8gKnAi8fZDWxrNc5Uxuk04OHHBZgokdk5ZwUtyVtDS5seUma6RE2b7k7e2A5RDLzt+mcr17WJ3/cEa5regQHyRsp3pesuAH2hyMJsuJhdIXwAOZEZyt3Bn+UG4xqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUoxNGwBgK9PJN2AoOEagCCf23frumABwm+Rrqfuong=;
 b=j81KOenjqWeOvhWXzq1Fja4Ob33CCptV3nffOvdixZoM5iIgVhIqXWTCJCjrzcWX85BLyJGmapCBbI4l85k14mvjXxmjL0hbscV5MgAa6AUVBuAG8rTWZodTkUS/KmUFqrpBC1n1xV3GQwx1mTOs6SfrgrAGY4NAg/9rlt+GwIGfYSehuVaMI0xM7wkjc86TyGs1f1wbFTcz+Fifg0FEgGhaRno9YD5kEa6euVTXq+alCw1+vrDiobsRzkUJ/bb/xv1FpqIx8vKrcrxo4bAJYlofeB3R/iMsamg9VhrMIY5rZULyqMlr3M1HSss/0NH4csaObH3+39AlKjioXk5vLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUoxNGwBgK9PJN2AoOEagCCf23frumABwm+Rrqfuong=;
 b=iA5fr1tEk9mykoEFYPzgDJFYEdr9DRUqbme9B0vw95yOA3QtDjYdgOq+Iw5GEZ/D6ZVKFICuhhkekGniFD5FH+P1Dwj+JDsiLRDimBcMZeTKCMOvzBokLpwQ0HirnEDR2cJVrjkIDDk4b4Byr00Ae6+zQ9SjQo6w5ey/msmQmDv0z9x+1s1ML48EyM8cBblcbrvpur1kL1OF8N49yHaxE01IQVSwVacxOpFMhEjVSQhPKUCB76E8uLtyr3JTLJpOLU0fMfyjRIQXXJpRTVuGY9brAcQurYKnGyZWfJwhUnARiK8Dr9wH0RZlbwZJVb1AdMPApSIT5tSRUVXHXclJRA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 23:06:27 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.027; Tue, 29 Jun 2021
 23:06:27 +0000
Date:   Tue, 29 Jun 2021 20:06:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Don't access NULL-cleared mpi
 pointer
Message-ID: <20210629230626.GB278274@nvidia.com>
References: <899ac1b33a995be5ec0e16a4765c4e43c2b1ba5b.1624956444.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <899ac1b33a995be5ec0e16a4765c4e43c2b1ba5b.1624956444.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:208:234::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR16CA0045.namprd16.prod.outlook.com (2603:10b6:208:234::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Tue, 29 Jun 2021 23:06:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lyMoE-001APL-4I; Tue, 29 Jun 2021 20:06:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49a468a1-81f0-40d7-a6de-08d93b528606
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52089B593230A47C59159A35C2029@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHrRiVNMJ8WdfcJW2hM810ikkS37qcGsqbBdsI2Bg652JWK/1ExPuj06iLbrsFOY/xa0atZ+Cd5XtaLbH9LTpaSZ/Vdbe1YHi4HL4HiYK01OTE7zG7ZTzBaKnT+oNDTnD5pa28d61CDnjO4zXP8TbSnv+IeLQLfGreBC9/1CYWVFay/4N9YxxkFrMGHFWh0GFVzESxjqO++WEQcLeqI7RlugvSm+hplQL0mnpDMFhNU9CVDUnMv1wwAdHBzBOyYoxcPNRrdbduXOYypflnZdjvaLnDWt565O21A0lDVudGdFrjM93sI/CiraPIlc07p76R9qLj66JWKFLJigpqpQMIaL0q/3kQy+1pqAen4FEfH9WJXGckOQnDMMJttm2ubalFdwMUSSv+mjNise8kphXkPlFNkVTkPSVCx6udrvooz/a7VLhH+e61wC/WSXqocEpe+KS0OuvNDexSNGS+G9nnejen3htz82HTitG9667+WtHp7kLfZng//rcjiwZ65sga7/zD16l9+UX32x81wAJ2cACe9PQ+nDrV9rP0nQcD/3ZwG82QDgIcbc2OkeTLX6JwuL2AjudYj4dlAph1kvrtlih7rfBFVp0hMmtFklDMRkdqWDLn3pvFyvSogzY2wpTXcjdo9wXr0L9fxyyc9ksFgFJ3Z1djDEa58J2ZYCSvevT3oYrgumf60ZNcYGiZJlnE78NRJpsYLPaNx4OWs/yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(36756003)(2616005)(1076003)(38100700002)(316002)(426003)(86362001)(9746002)(9786002)(8676002)(26005)(6916009)(83380400001)(5660300002)(107886003)(45080400002)(4326008)(186003)(66476007)(66556008)(66946007)(2906002)(8936002)(478600001)(54906003)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q6wY0tuBHotfYuqKGi64x8MSYGUCJBK+setWcNk6mDF+hgWTuh7p7/PZ6qyI?=
 =?us-ascii?Q?NetqTRBWi6OgSE8BKAjtnV1316emy9ACoJp7ACXrAj7jr42Qzm8spGrrS7il?=
 =?us-ascii?Q?5pdyIxb3Ods6iaQdR89qsXA8lnKv7wwv1TmN03YtqnT28t6P4jYGO4BwZ7QX?=
 =?us-ascii?Q?l3TfJSNbb9YZ/6pwVR8Lum4IeUHoSpiSXz7KE0PSP7XCPrOGecm4GyyIFSB5?=
 =?us-ascii?Q?/Dv/mGUFLzJ6j60KkJsta9IgPLHrICtiY0zmgw2dk8iZ97NlD6SWVW0ehlxD?=
 =?us-ascii?Q?qypcGeXft0d1fuyTOI8iLUF3qrD2S5cQZlMPqRWE08FHOnsKNXcqO6aSWRcm?=
 =?us-ascii?Q?OAwYt6z+hH1lwXbIN2hP9feC3T4ULVVTJO2L/lsCnhcrADLdvbeqnN93xqPy?=
 =?us-ascii?Q?0stWCLPhTV+kHsi/EmQWvqoE8Hehm9cEKZ9e9IO7hruwoo7bs+qHix/O8JL3?=
 =?us-ascii?Q?1cN3QZxsoJdCuWERazTKLGCw8n+DKJNfuBqTOMpZzoEYg23eCTmxW+z9sM88?=
 =?us-ascii?Q?wj4K2rfdwUbIYNjvWbyEv1gtOAN3qqY7NAFt8CbtlPaDkzVajcruItKIyWCv?=
 =?us-ascii?Q?ld4yJNLXxUC38MXz3SwZgHnqOWJPv5CYmucjDaoCAJfJN5K+QjxkkY4P2iqB?=
 =?us-ascii?Q?JcMXUHtkKAdCESDRzuhM9K/Xa2waQX0jzi872SMHEPcBWNaJNmnzqQhi5jXj?=
 =?us-ascii?Q?uQdsn/IuwPVkicGNMUSL2LP59kMGCp9Os4ehW099GKUr+MV/202rA96xZlW5?=
 =?us-ascii?Q?/din2JqgABxc9P18U5OeilKUPsg1WbIvDovxjtnfjBqVPEAcRI18LGLCQip6?=
 =?us-ascii?Q?b1ADBf1GRkhYEj73gWXRXfilBVsyVpU7FevkNHpSWhz9+If3CkJjoQ983Cct?=
 =?us-ascii?Q?EXiWduVP+T9wOQr6MkP3J1A3nHsPjzubO3uvAmtSUYaZophodHv1oxoU/DLW?=
 =?us-ascii?Q?5mp1xrp/Kgl0boDECo+Jou8lXkMwYopJpp8ENF3RKIBdvLXBoKWNrDh7jZz9?=
 =?us-ascii?Q?DnfysNnTTI/V3MTydMq0L0piLgBWUCZnmk2Ki4OlfSNNtpcoqtMfFzmetA8Y?=
 =?us-ascii?Q?7kCB4MDl+Vec+Z1weMc/LZtscDyV8IGOThCL7r7dIzqQrcRubSTeAJwlKoOt?=
 =?us-ascii?Q?1SgkSJSROk18HRa3s4WbfqyzbpmEY1MSYcpe1/eglLQS5tUr0MP/YpoDXKMX?=
 =?us-ascii?Q?aUjP9uwXQ0M/JORBZ7geWbooLJcyw46be9PhqS0OVc1S6jkSptb3Ryzxj/vN?=
 =?us-ascii?Q?gkMpj4nypBDDPCuZ0WkNbOagQG08E38+gkvoG3JL5X48x/zdx+IyWh7zGhJg?=
 =?us-ascii?Q?be150UdCm9v0qfpvEy4eWT27?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a468a1-81f0-40d7-a6de-08d93b528606
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 23:06:27.2959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3p2/R0nwNKbPLe05ZiT3ZMhlK1t9v6IDV05ZfBR2WHzCRSxdBEq/cbzteUyXLA4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 29, 2021 at 11:51:38AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The "dev->port[i].mp.mpi" is set to NULL during mlx5_ib_unbind_slave_port()
> execution, however that field is needed to add device to unaffiliated list.
> 
> Such flow causes to the following kernel panic while unloading mlx5_ib
> module in multi-port mode, hence the device should be added to the list
> prior to unbind call.
> 
>  RPC: Unregistered rdma transport module.
>  RPC: Unregistered rdma backchannel transport module.
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page
>  PGD 0 P4D 0
>  Oops: 0002 [#1] SMP NOPTI
>  CPU: 4 PID: 1904 Comm: modprobe Not tainted 5.13.0-rc7_for_upstream_min_debug_2021_06_24_12_08 #1
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:mlx5_ib_cleanup_multiport_master+0x18b/0x2d0 [mlx5_ib]
>  Code: 00 04 0f 85 c4 00 00 00 48 89 df e8 ef fa ff ff 48 8b 83 40 0d 00 00 48 8b 15 b9 e8 05 00 4a 8b 44 28 20 48 89 05 ad e8 05 00 <48> c7 00 d0 57 c5 a0 48 89 50 08 48 89 02 39 ab 88 0a 00 00 0f 86
>  RSP: 0018:ffff888116ee3df8 EFLAGS: 00010296
>  RAX: 0000000000000000 RBX: ffff8881154f6000 RCX: 0000000000000080
>  RDX: ffffffffa0c557d0 RSI: ffff88810b69d200 RDI: 000000000002d8a0
>  RBP: 0000000000000002 R08: ffff888110780408 R09: 0000000000000000
>  R10: ffff88812452e1c0 R11: fffffffffff7e028 R12: 0000000000000000
>  R13: 0000000000000080 R14: ffff888102c58000 R15: 0000000000000000
>  FS:  00007f884393a740(0000) GS:ffff8882f5a00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 00000001249f6004 CR4: 0000000000370ea0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   mlx5_ib_stage_init_cleanup+0x16/0xd0 [mlx5_ib]
>   __mlx5_ib_remove+0x33/0x90 [mlx5_ib]
>   mlx5r_remove+0x22/0x30 [mlx5_ib]
>   auxiliary_bus_remove+0x18/0x30
>   __device_release_driver+0x177/0x220
>   driver_detach+0xc4/0x100
>   bus_remove_driver+0x58/0xd0
>   auxiliary_driver_unregister+0x12/0x20
>   mlx5_ib_cleanup+0x13/0x897 [mlx5_ib]
>   __x64_sys_delete_module+0x154/0x230
>   ? exit_to_user_mode_prepare+0x104/0x140
>   do_syscall_64+0x3f/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7f8842e095c7
>  Code: 73 01 c3 48 8b 0d d9 48 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a9 48 2c 00 f7 d8 64 89 01 48
>  RSP: 002b:00007ffc68f6e758 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
>  RAX: ffffffffffffffda RBX: 00005638207929c0 RCX: 00007f8842e095c7
>  RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000563820792a28
>  RBP: 00005638207929c0 R08: 00007ffc68f6d701 R09: 0000000000000000
>  R10: 00007f8842e82880 R11: 0000000000000206 R12: 0000563820792a28
>  R13: 0000000000000001 R14: 0000563820792a28 R15: 00007ffc68f6fb40
>  Modules linked in: xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat xt_addrtype xt_conntrack nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter overlay rdma_ucm ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_ipoib ib_cm ib_umad mlx5_ib(-) mlx4_ib ib_uverbs ib_core mlx4_en mlx4_core mlx5_core ptp pps_core [last unloaded: rpcrdma]
>  CR2: 0000000000000000
>  ---[ end trace a0bb7e20804e9e9b ]---
> 
> Fixes: 7ce6095e3bff ("RDMA/mlx5: Don't add slave port to unaffiliated list")
> Reviewed-by: Itay Aveksis <itayav@nvidia.com>
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> This is fix the patch in the for-next.
> ---
>  drivers/infiniband/hw/mlx5/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
