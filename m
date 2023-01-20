Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D84D675F1F
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 21:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjATUwd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Jan 2023 15:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjATUwc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Jan 2023 15:52:32 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71AC3B0E7
        for <linux-rdma@vger.kernel.org>; Fri, 20 Jan 2023 12:52:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAfaYywDIUjaHfXSGtxE/FDfhC1L4YaAS6iS0OX9Q3LaxImsvDlAR2Fuib2hhhzCdXh6bC85wdpCHIR/Mg9op278wTu2XlEP0eEt9qasf3EI/DKyfH492XIG39RcLsNH1RcyKJtbH7CETrpdfK8FQH1Fh/GXjcIZ9jTTPYW8TmmzvQyU/Px2qcs/uVOoZXSRshofRrA7ExoyxuMHR4ZoGMFrByKq5+i/cMob4wWaQ3fMHrxj/bpOoNehnv79hVILh7Pc7cyHMFuUpIU7YH4jDqvrP83d+bZ80uVVDsYlIdiNMItq8A+sLs665GnUp6x+L9m41cNe4oGyrUBAHkrqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0xUlmJLldx4EF+FH7c7lDzqhGq8yj/LcKy1Eva/5U4=;
 b=Wye0hArzOuTUQK0mtTK4cbA5Fa/jcxu6RepgNE+jNPQiDI6OliBAC/R6CmYTYXZsw4tYyMTnDt1d7hTdNUeuBGyfoTLdsglJBrgJIaIE8kufc1IQJ8FCFN1nOUuzox1X3js555c6ojHIuVN6zi2MFzKGsFBclMxPXmtmMroMPLZhYc4QqTD5BmC5kpouYJbtSzdmIHBJmlzNUPIF0j2p2FkgG1bodwdcgwd/mgrMqTP1akN5831G+z6P5sNIXarpLRQTaM6S8P+NxkMJkw4RLpbS7f2TxZE2vEgH0VhhTry5JnCQx4E9hQJcrNMSYUmG5MQscToeCK5zbw93PbKTFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0xUlmJLldx4EF+FH7c7lDzqhGq8yj/LcKy1Eva/5U4=;
 b=lZ/qSUAiaVuYSw9MRcHG1F10i2pIMQHRLgnzsB8rJDGfiW9Q4M9Fo7sRkyWPgbbDzImlHOeWrXpz43J9E01sSnyrlcrlnI6AITixLpruNgM4xSVSjeBYUE6vgASa6l2yRGxU9fIHFKDFArbHscHXOFo/a/CxMHdTZ83WL7ZQeIq0FX+WXPA0NGIoupPYsv/LnTpvAwk1Fmjm9SgkArNOfeI1c4MA9ud7nKz4C40bAj8bCN/ngIeD+64DdgxOXpoYHVicqgf2pmki4rNbaACkKSGlINXKuLdf8I+F9JdX4qmP5ncjs3ikyVcrd2/KccLHKqiVeat/5hPlHs8q6qWzmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 20:52:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Fri, 20 Jan 2023
 20:52:23 +0000
Date:   Fri, 20 Jan 2023 16:52:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>, linux-rdma@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-rc v1] IB/IPoIB: Fix legacy IPoIB due to wrong
 number of queues
Message-ID: <Y8r/BUdb7XMxwVN+@nvidia.com>
References: <752143b0eef72a966662ce94526b1ceb5ba4bbb3.1674234106.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <752143b0eef72a966662ce94526b1ceb5ba4bbb3.1674234106.git.leon@kernel.org>
X-ClientProxiedBy: SA9PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:806:23::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 418795ea-79fa-43bf-20ab-08dafb283ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Idahde1gh1VEmxjlIcbmLmFeEzocqQVhd5ZTRZxDQ8Tid2cnsL68Anfv6O/Mu21Qcn5asnZtxaYSYWePegkJ9dYcCoHCdqWoA9Me3O0qnERHHMyF6IdwMECScy+3AZk5fCw2x7rsMppo7Oj3eMlNKHlMwIJ3k2/Qypf4Dr2fQPLLa308FyH/GBxL6z2jEH1dpMZhhORzEvQRg3fm2NYcEOJaa0s64QAIpAUdhJObBj3AH5dkbf/X9RDuxJ28H7t4ub/jPTB9hNh4faPmIWrz62MhEF/bTOykQRBeumJxbaWvZ0i9oTUh+ZbuJvCx2hHaNkm0Jv3gZ1LO1aEk1ZjoaUgJcad/gGDu+Inf4V9pM5JRAj8oT2dZAx0xzseFR1J9B1XXRy+HNhZUWYnBt1L8iKxUq/DfsNXtYWapO7pNnzqE3nTrXxGEgSXBinkD4XJruiKW1kBrRm3L3EPdQobYSLfjzJxxviEzCRgmpBbNpWAEWh0BaSxAq7g8PsNGEov2PDeJIbj00hD2QUyJO4IPMiBagaw50t25CkVNaba77qkQLTBzQGUiTJvLGrtLAbQgMIs6X/zT4MFNAMBD505m5JtUEUwOfAX52ABplfItmkxd4izw3Oh54xjbORdBN7T3FvvugWdP3cpWNh/TTox894ITBIUsnrtwVabgX5Vo8a2y+IMz6SrUbRYQ55hj8Ld+aU6lGG7DX5+W8m7Ddz2gn6X2E2x893PsyNIbV+WgQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(5660300002)(8936002)(4326008)(66899015)(66476007)(66556008)(8676002)(66946007)(6916009)(38100700002)(107886003)(6506007)(186003)(6512007)(2906002)(26005)(54906003)(6486002)(966005)(478600001)(36756003)(2616005)(316002)(83380400001)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QPTwqAijzc9R2s0enJIBLUe2cls2jbgog89FhlraPmz0ZhhvtVIFmLRu4C9k?=
 =?us-ascii?Q?vE1MCTsaAuz/91CeO7EXIF9xbsJodmxvP1O+uznV+XUJ+LbQSPCOLuB6H/Xj?=
 =?us-ascii?Q?7Z3E5zBJOizsdFOMbOElFjcqA9U1dyr2MOpMOZSvL25SrlnR/gqW8bdPHbsI?=
 =?us-ascii?Q?u6S0n4Koq4PMk0pzTJW8VGN1q+1SJcLcQyqjL23gPqHPpy4YHEPhGKM91zVB?=
 =?us-ascii?Q?/2cy3PDr/z4itf0p/1TVcxBOqMtx4wCf3xRr0FPA/tpeu2tjucbdq6iqQ+GD?=
 =?us-ascii?Q?zPNAHT4h135hY7WrN45qjQpIDDc/nNb3dh+bwl1SDq/b+HLMdJVONpMrYGbG?=
 =?us-ascii?Q?MUFiWTEpT8tA4FEUXF3s+G0FN12VyHbtuNw3RNxuU8jdQDQpWxdhCbnD0fXP?=
 =?us-ascii?Q?DndXrU4hByToChIbIc6JxDZgNdKye7LrDafYUTYvh7FcZqie4oFhORFx/J6s?=
 =?us-ascii?Q?Md5zBOOCfro3MOad4Y/ZqcK8mXYIDMLtTTpHzw562VMdUmalCXEpRtEmFpNA?=
 =?us-ascii?Q?mfxsllk1u0xGjsnG3M79Br+knJVoW6CwXhZuhbT1rI4RMni/X6jDcKXj+0gi?=
 =?us-ascii?Q?Yo4K4SXHqFenLO6DuCeMQC9UGnmsxri1z04T7hZM23gqUa0nIyIC6SSG2A+k?=
 =?us-ascii?Q?1IwHAzEwX9b+Wcu8MjlujDVqApQ4mE3T7Zik0vgm6TFa3qXySGIaxxpwNjMs?=
 =?us-ascii?Q?K4+KlvlsnDQPQRi0HiqLD0iiETb3zNMIgFd5qLge7aLre/uLHavlgsDK6UnQ?=
 =?us-ascii?Q?LBl0tsEABc0dIwkAttc8tW8igHh+Ec/RDxNVjAf14nUZ6Eat+pAa3gZEB+Or?=
 =?us-ascii?Q?5t/IlX5Vx2r1ceGCxX0C72ZwEPzW46/7JxNUSkV5FvKhIrktzPlRWFHro72c?=
 =?us-ascii?Q?vYu9CWtFQiae8/XHg9c4x+M9Zo6IhjKcRP5JXe/EQJOAXGqEIez8Ougv07iB?=
 =?us-ascii?Q?ROiMw9ZjE17JDB1DfKhxo5UIVCCRSBxeJOI1fH5gIQA4PkqhsfMHsSn/Sm+u?=
 =?us-ascii?Q?cIA7mgi7Qtanh7hH4ALapTP5/MtQF3I4yg5nLzQq/wuUpCQg7bvnTKmTcqyI?=
 =?us-ascii?Q?qU0pvT2vvSq62w1jr+4bZM9rMLjKiN88b7HOjBSQBCyHJ6hO75FKBXulkobv?=
 =?us-ascii?Q?j1kyRVrDQAcbSjHWSHWFbqvH8RG31+tJU5SGFn42dhAp4eSXHNPVJK5RDjHf?=
 =?us-ascii?Q?uDQRNDbT1mB5JmAzhmLPSS3ULkTjvroeS2/LUJzbF4FaI4swu91eSvPGuU8F?=
 =?us-ascii?Q?u0kENYQgy8BNXvvlSj8CNNcBcVTS0SaQM0klOr+EBkMv80goH7kveC5kLGi7?=
 =?us-ascii?Q?NpteJYMe1Dokq3KGzFNUQjCUrSKD0WQR5YF4fotNa1D6HnbiCjj9GEFgO82a?=
 =?us-ascii?Q?CLsNzSk19ZdQNu0TR23Zp7hW6uBg55AqnNW3QJ/IrlUt34VaR9Ir6hZH4BGJ?=
 =?us-ascii?Q?KQmfSezgy3CpDhYujsyUWW+g/juo4oePc/hScVAOpPIqdN5pKjhx9wL5hW/l?=
 =?us-ascii?Q?dQ0xjOSq1hTeV7nxOaZ8Zctv/9c8SrVPJ6J/25iWLYrdxOh4cR4k7PI3it6H?=
 =?us-ascii?Q?tFSlQnvH7zdiIaXA0JIyu4P3Bw/A/wDwyoDtiXqJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418795ea-79fa-43bf-20ab-08dafb283ad6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 20:52:23.2440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jZZJyp5+672ZSjI3/sdWxcfZD4Y0fkK4PQQ3lsacizIbxwhbsv6nWMOfD7jcjZN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 20, 2023 at 07:02:48PM +0200, Leon Romanovsky wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> The cited commit creates child PKEY interfaces over netlink will multiple
> tx and rx queues, but some devices doesn't support more than 1 tx and 1 rx
> queues. This causes to a crash when traffic is sent over the PKEY interface
> due to the parent having a single queue but the child having multiple queues.
> 
> This patch inherits the real_num_tx/rx_queues from the parent netdev.
> 
> BUG: kernel NULL pointer dereference, address: 000000000000036b
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP
> CPU: 4 PID: 209665 Comm: python3 Not tainted 6.1.0_for_upstream_min_debug_2022_12_12_17_02 #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:kmem_cache_alloc+0xcb/0x450
> Code: ce 7e 49 8b 50 08 49 83 78 10 00 4d 8b 28 0f 84 cb 02 00 00 4d 85 ed 0f 84 c2 02 00 00 41 8b 44 24 28 48 8d 4a 01 49 8b 3c 24 <49> 8b 5c 05 00 4c 89 e8 65 48 0f c7 0f 0f 94 c0 84 c0 74 b8 41 8b
> RSP: 0018:ffff88822acbbab8 EFLAGS: 00010202
> RAX: 0000000000000070 RBX: ffff8881c28e3e00 RCX: 00000000064f8dae
> RDX: 00000000064f8dad RSI: 0000000000000a20 RDI: 0000000000030d00
> RBP: 0000000000000a20 R08: ffff8882f5d30d00 R09: ffff888104032f40
> R10: ffff88810fade828 R11: 736f6d6570736575 R12: ffff88810081c000
> R13: 00000000000002fb R14: ffffffff817fc865 R15: 0000000000000000
> FS:  00007f9324ff9700(0000) GS:ffff8882f5d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000000036b CR3: 00000001125af004 CR4: 0000000000370ea0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  skb_clone+0x55/0xd0
>  ip6_finish_output2+0x3fe/0x690
>  ip6_finish_output+0xfa/0x310
>  ip6_send_skb+0x1e/0x60
>  udp_v6_send_skb+0x1e5/0x420
>  udpv6_sendmsg+0xb3c/0xe60
>  ? ip_mc_finish_output+0x180/0x180
>  ? __switch_to_asm+0x3a/0x60
>  ? __switch_to_asm+0x34/0x60
>  sock_sendmsg+0x33/0x40
>  __sys_sendto+0x103/0x160
>  ? _copy_to_user+0x21/0x30
>  ? kvm_clock_get_cycles+0xd/0x10
>  ? ktime_get_ts64+0x49/0xe0
>  __x64_sys_sendto+0x25/0x30
>  do_syscall_64+0x3d/0x90
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f9374f1ed14
> Code: 42 41 f8 ff 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 68 41 f8 ff 48 8b
> RSP: 002b:00007f9324ff7bd0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 00007f9324ff7cc8 RCX: 00007f9374f1ed14
> RDX: 00000000000002fb RSI: 00007f93000052f0 RDI: 0000000000000030
> RBP: 0000000000000000 R08: 00007f9324ff7d40 R09: 000000000000001c
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> R13: 000000012a05f200 R14: 0000000000000001 R15: 00007f9374d57bdc
>  </TASK>
> 
> Fixes: dbc94a0fb817 ("IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v1:
>  * Fixed typo in warning print.
> v0: https://lore.kernel.org/all/4a7ecec08ee30ad8004019818fadf1e58057e945.1674137153.git.leon@kernel.org
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
> index 9ad8d9856275..0548735a15b5 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
> @@ -126,6 +126,18 @@ static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
>  	} else
>  		child_pkey  = nla_get_u16(data[IFLA_IPOIB_PKEY]);
>  
> +	err = netif_set_real_num_tx_queues(dev, pdev->real_num_tx_queues);
> +	if (err) {
> +		ipoib_warn(ppriv, "failed setting the child tx queue count based on parent\n");
> +		return err;
> +	}
> +
> +	err = netif_set_real_num_rx_queues(dev, pdev->real_num_rx_queues);
> +	if (err) {
> +		ipoib_warn(ppriv, "failed setting the child rx queue count based on parent\n");
> +		return err;
> +	}

This still seems flawed.. Netlink does this:

	unsigned int num_rx_queues = 1;

	if (tb[IFLA_NUM_RX_QUEUES])
		num_rx_queues = nla_get_u32(tb[IFLA_NUM_RX_QUEUES]);
	else if (ops->get_num_rx_queues)
		num_rx_queues = ops->get_num_rx_queues();

So num_rx_queues can really be any value that userspaces cares to
provide.

If pdev->real_num_rx_queues is > the user provided value then
netif_set_real_num_rx_queues() just fails.

So at a minimum this should min the actual number of queues requested
against the maximum number of queues the driver can provide and use
that to set the real queues.

And the return of a really big number from ops->get_num_rx_queues is
pretty ugly too, ideally that would be fixed to pass in some function
arguments and obtain the ppriv so it can return the actual maximum
number of queues and we don't waste a bunch of memory..

Jason
