Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9133C454EC6
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 21:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhKQUyC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 15:54:02 -0500
Received: from mail-co1nam11on2062.outbound.protection.outlook.com ([40.107.220.62]:56576
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238636AbhKQUxx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Nov 2021 15:53:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxbuLMagrWSR/g7oExpRwsWDdxGUguIieJPFN9Xqyzeihn9nTF5Igi/yfZJH6dCxPqakuCgYMKgDrbC2sEhd/9557aqFubz52v1+4nTAg/ZW7Dc7jp2fyQxGLMywENVC0uTMX4PTzw92BSBo7Mz3cO8MYiMIcTpwrX+3cAywWWz3GW/ZBjoslqRqv+joKqKjJrw4m07izsoKSDrERHUcLAeCPxYoUKyit7MPo1iT/DafMD1JEFdtduyBBV8co+qfpzolQWckrYTukrlXBFyMsuxfaZbL/4tZ1AmmjUGpmEnkON09pvRh0nBxEyWYTyQx6UBn4kfI/mLHnhQlxG+gOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCwB3dCf5XOjePa7ueRFay2SNiJIPAexDccriYxbPiY=;
 b=bHOzyXY7RezKy9yvPBYmuGKxu6P3QTHMvaYhDPOkJdAXPuTzEl33PiiRHoOLfb7ancOawdHnCO7rDmFoClDjv9jY3MiG7ljY660SskqMRPiBxaxxgjDHI3fcxsxA+rHo8038TXrXD/IrlabSADWYy5E5AP5r/NcVFei3JphGMy3Sf5at05Exf3naHdiu7oNyRGoAyWOaL9Rw2gvDVkVhpVymak385OdCcBMCK7DgYJT2XsBo5xj35qEo0QSoz+YkXDw7u2QLESI+pEYro8wUJNPBtfQn9DX1LfpZ/WuRkOIPfYMZU+6ZxBJTSeumqJ5fOoT72+4sQQtEv2gpwC0pDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCwB3dCf5XOjePa7ueRFay2SNiJIPAexDccriYxbPiY=;
 b=rsDvQuX0/MX+iJez4UEFq4SrAXVDVbOjxPGMGxxIqYiUqHe9LMi57xTOamLfZNVj1rIwXQQYd+m4vPninJpBoo57NcJ6bYc60TOi5FYxiNw9fbxgX1j29qYvzpCE9vwKc+1mb7E+m+9/B2cIg+Y5ZkTsZ1FuiAnh1CdPxCtGdr3HBlafOcNC69slM1lr0IecVI3xLkKQtGqoIhpFLHa97SdA8iti+fqTEkIrWyq3EMtaYwuHOpTa2JTkZmuc6j7XZUaKEAAIQvsaqc2L3c47VOVRtAHjPBWVfVXDCfE8BkNLhdxUCftPIajuE8mkN+KmIgREwBlBrAzK47/jiR0+5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 20:50:52 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.021; Wed, 17 Nov 2021
 20:50:52 +0000
Date:   Wed, 17 Nov 2021 16:50:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>,
        syzbot+9111d2255a9710e87562@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/nldev: Check stat attribute before
 accessing it
Message-ID: <20211117205051.GB2762130@nvidia.com>
References: <b21967c366f076ff1988862f9c8a1aa0244c599f.1637151999.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b21967c366f076ff1988862f9c8a1aa0244c599f.1637151999.git.leonro@nvidia.com>
X-ClientProxiedBy: MN2PR19CA0055.namprd19.prod.outlook.com
 (2603:10b6:208:19b::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR19CA0055.namprd19.prod.outlook.com (2603:10b6:208:19b::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend Transport; Wed, 17 Nov 2021 20:50:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mnRtL-00Baa7-8M; Wed, 17 Nov 2021 16:50:51 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13c369f1-3156-4f77-64ca-08d9aa0bf17e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5141:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51416C8EB7EA4196ABBE2437C29A9@BL1PR12MB5141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGOb8Vhbydu9ZrpBgzRBedzAxRv/A0dMBRtSC+wgrFUGMDjmMwLxNhswMIEYIDauaxh+Clw0fn4X32HLzBBPa1hG2sWqw7lhaViVQPrL8SEr/bTWNbJfyGojjpJkjtScoo0DxtkaIafrJfeCW2DTSA6is0YY2xTLkctPGmZmiBz0BnoV+EEFrDruABFqtn+H93RbRQ9AkV8eBVs+wugclUPwE42usIJhBOsLudZ3ZFUD+U2CQ+dyaA8an3kDHK3SRVNv+8BKwcMSG1d/xVNXQWTJ/qNOms2+JIpBec/XLfzX1R0dw1QV1r+JAOjADuM6qEJ0joyfx2ejRHErgnm40Wo6uTicE/gZAl8mE3BAgvceJKbrcLUakZLKJQ21Hf7jWvBOaU59CbEFzVuwkNhW3vK671VHENo6lXIxRHJ1CGMspe0CXjXpWpTdDpVt/i8ntUASzy6kPXkWdeh9Q1c9h/zUPPU4G64MCEw6KWauVmVJFzOlLKVKCd4fJuil8Ahl6+vL5GYuy9R27L7UfA+Z6GpckB7kZ9VZsri8QNYtNk65vVwb3+LUHQ1JDWjk852K8WW7npoBt+R9RUr8sIhUBU9n83vgOGu4CHLxWVzQHR1FIwPt0lcHgF3aWvpCkDbHyQBrt4/jc9IU4SaBZSFVIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(9746002)(9786002)(1076003)(83380400001)(86362001)(54906003)(316002)(66476007)(66556008)(2616005)(8936002)(5660300002)(2906002)(66946007)(8676002)(33656002)(186003)(508600001)(6916009)(4326008)(45080400002)(36756003)(426003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wtp8RgCcbQAlptrDvdxdmCT/lKH5Y6fniHfal/PwRpuVKwS/DO2qdfVOEJKN?=
 =?us-ascii?Q?nYIFzCcR++sI0FkzcuzvQaeUgas3FGT5W1M2f18N7ZAnJDKNrY+CYb74TSPf?=
 =?us-ascii?Q?63cGHF8b04iga+rnNE4lxmC0CCd2o7khxHTxuyvL5woteGD0yp8/mVaF1bpJ?=
 =?us-ascii?Q?3Yu6GRhJcvb31qLy3bdXixg4ytIKsuzOb3uBZoZCwxVvFZG/4OTwO83Z/VcD?=
 =?us-ascii?Q?5KKC9CR4ImAV4/x6JftMJXEEkDAPDYFK1/X91v84rhFQXoDbgGBXlKsyU1BX?=
 =?us-ascii?Q?WmPbAF2+Mbh6eFxqi0ujerQBm2+zosDhdOYVjgQ7JGlvk15VP+N3KPd4mEbW?=
 =?us-ascii?Q?13cja7jKGgKzBuCRqVcvMnMSec2Dx4Og1M3NQgv3rUzPe2NTdbc9HhFYyhQ7?=
 =?us-ascii?Q?im3A0lRtZMRRYNbhLYPKvw8MvVhmpPiblOMtsGqPcSK0P410H0SxEeiEM6/b?=
 =?us-ascii?Q?YGAZ4CB4cch33oljCB/Rd7jXexWIsEt02nG8DpLQ2r/D8J16w7iqV6uED/tE?=
 =?us-ascii?Q?lReYPDHDIvysXPDVcApVezTNX2KQx0fz/i8e6nTMUqDz93VfxTjUwyGAvcSX?=
 =?us-ascii?Q?RkF76Q4E6eShzkAqcv2Oeq4c2BgHnlzmi2/7W9gksEMNlLwgpNeMNVUA4T75?=
 =?us-ascii?Q?svutmSqSKlFlrXjPetWgj/H+3ab0LEwqP3nvKJYHOPV/969hes6C3Yyud+tx?=
 =?us-ascii?Q?KhW77izZv8IvOnE8V+/qc+fXHWz7OXzBjdWaED9dB3iF15mFTpbQBTuL3x0x?=
 =?us-ascii?Q?j0KLVpHNP2LfkUXehew3bkndP+j/yOjg0kowaBdnn4a/8gehLR69tvPt83hO?=
 =?us-ascii?Q?TSCbd2iOLNyivC8d4tFvzzKnlyBtwnzp0xWfv1CqkSmtIZA9pn/dHFiNJQi5?=
 =?us-ascii?Q?5d44tbiyBFzSjUyLKFOEmUPkHKCYbc/LG5E2MV8xkLTK+OwkIYdzTwHN9biO?=
 =?us-ascii?Q?Qtk5nKyRvMyN7hc1Fq6QhpK8hz8KkzoCzRa4YYVrqkqW5dqTYtzVqDgqIOLF?=
 =?us-ascii?Q?wqC67UCRdTx2EHWCOiUE2WjKubhug5Dwo+UTA5wyBdGgwGVMS4qcvsuDRVS7?=
 =?us-ascii?Q?5eePF29qupPoL97dBLvAFgpTDfdM3kKQMEedt7rwTtwSjcirC9ZvRSl+h8wV?=
 =?us-ascii?Q?hx0GEWnVjgMrSJtCEXuUamRdkzILNoJJpQBjQqnI68+PCz8gSWbxPb/SYr6N?=
 =?us-ascii?Q?gWl9ihMgmwcPc7JEvGokJn4waIkICuI99z4pokrHfLOBEA6KdsA1fjWOb4ko?=
 =?us-ascii?Q?wJw+QgbJLwbGnwrERt8pZoc3yFycVRAZ3Jpo0UR52J/EXcadthw/RUxeScBc?=
 =?us-ascii?Q?ejhII5Jyaa6WegdqQ1lEW5Tm8DJt2K3PAzhR5vl0yRW3jRB8iB88qUm4klN3?=
 =?us-ascii?Q?Z0QTlhZB7womnoOGih12pJu7x/nEQXG47doYZ+JYbNxPXKaAzcufgTKM/3Ab?=
 =?us-ascii?Q?KH6DyPkTLk7sEGPUv67KD00o8XcXV54c2i+7+WuL9mTDPXGTle6mxI+5uadw?=
 =?us-ascii?Q?j8LwDDsTffRILVNDGMEU6plPhzgG0ek3agXPrkQWI3xMSoBM9ILtg9g558jc?=
 =?us-ascii?Q?r1TuKxiLbxudANpMTzo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c369f1-3156-4f77-64ca-08d9aa0bf17e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 20:50:52.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKspVTPwCcMDGFTWHKope4YzXV45yJpN8SRP2xkAC9ufwmkW5dS9Nfweayg1c6TI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 17, 2021 at 02:27:04PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The access to non-existent netlink attribute causes to the following
> kernel panic. Fix it by checking existence before trying to read it.
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 6744 Comm: syz-executor.0 Not tainted 5.15.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:nla_get_u32 include/net/netlink.h:1554 [inline]
> RIP: 0010:nldev_stat_set_mode_doit drivers/infiniband/core/nldev.c:1909 [inline]
> RIP: 0010:nldev_stat_set_doit+0x578/0x10d0 drivers/infiniband/core/nldev.c:2040
> Code: fa 4c 8b a4 24 f8 02 00 00 48 b8 00 00 00 00 00 fc ff df c7 84 24 80 00 00 00 00 00 00 00 49 8d 7c 24 04 48 89
> fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 02
> RSP: 0018:ffffc90004acf2e8 EFLAGS: 00010247
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90002b94000
> RDX: 0000000000000000 RSI: ffffffff8684c5ff RDI: 0000000000000004
> RBP: ffff88807cda4000 R08: 0000000000000000 R09: ffff888023fb8027
> R10: ffffffff8684c5d7 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000001 R14: ffff888041024280 R15: ffff888031ade780
> FS:  00007eff9dddd700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2ef24000 CR3: 0000000036902000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  rdma_nl_rcv_msg+0x36d/0x690 drivers/infiniband/core/netlink.c:195
>  rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>  rdma_nl_rcv+0x2ee/0x430 drivers/infiniband/core/netlink.c:259
>  netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>  netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1345
>  netlink_sendmsg+0x86d/0xda0 net/netlink/af_netlink.c:1916
>  sock_sendmsg_nosec net/socket.c:704 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:724
>  ____sys_sendmsg+0x6e8/0x810 net/socket.c:2409
>  ___sys_sendmsg+0xf3/0x170 net/socket.c:2463
>  __sys_sendmsg+0xe5/0x1b0 net/socket.c:2492
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7effa0867ae9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
> 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007eff9dddd188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007effa097af60 RCX: 00007effa0867ae9
> RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000003
> RBP: 00007effa08c1f6d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc008a753f R14: 00007eff9dddd300 R15: 0000000000022000
>  </TASK>
> Modules linked in:
> ---[ end trace bacb470dc6c820de ]---
> RIP: 0010:nla_get_u32 include/net/netlink.h:1554 [inline]
> RIP: 0010:nldev_stat_set_mode_doit drivers/infiniband/core/nldev.c:1909 [inline]
> RIP: 0010:nldev_stat_set_doit+0x578/0x10d0 drivers/infiniband/core/nldev.c:2040
> Code: fa 4c 8b a4 24 f8 02 00 00 48 b8 00 00 00 00 00 fc ff df c7 84 24 80 00 00 00 00 00 00 00 49 8d 7c 24 04 48 89
> fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 02
> RSP: 0018:ffffc90004acf2e8 EFLAGS: 00010247
> RIP: 0010:nldev_stat_set_mode_doit drivers/infiniband/core/nldev.c:1909 [inline]
> RIP: 0010:nldev_stat_set_doit+0x578/0x10d0 drivers/infiniband/core/nldev.c:2040
> Code: fa 4c 8b a4 24 f8 02 00 00 48 b8 00 00 00 00 00 fc ff df c7 84 24 80 00 00 00 00 00 00 00 49 8d 7c 24 04 48 89
> fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 02
> RSP: 0018:ffffc90004acf2e8 EFLAGS: 00010247
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90002b94000
> RDX: 0000000000000000 RSI: ffffffff8684c5ff RDI: 0000000000000004
> RBP: ffff88807cda4000 R08: 0000000000000000 R09: ffff888023fb8027
> R10: ffffffff8684c5d7 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000001 R14: ffff888041024280 R15: ffff888031ade780
> FS:  00007eff9dddd700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2ef24000 CR3: 0000000036902000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> Fixes: 822cf785ac6d ("RDMA/nldev: Split nldev_stat_set_mode_doit out of nldev_stat_set_doit")
> Reported-by: syzbot+9111d2255a9710e87562@syzkaller.appspotmail.com
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/nldev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
