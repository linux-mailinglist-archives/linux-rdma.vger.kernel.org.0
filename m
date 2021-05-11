Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D37837AFCA
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 22:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEKUBZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 16:01:25 -0400
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:20449
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229456AbhEKUBY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 16:01:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fl/JXF+mpWWPf4qzh/329ZwXqtKEq/akl+nD7m3EnZYFK087Prr/xvP2oA2T9ecwcpDNlcKMl5QQOPewEuns432GrTo2ED8I/ZD/1r6taQgBJ59XXU6aw6Feu/YJrKJX6qp0zGOOLmETNYnB4Y3e/mHwdbeGdlK27XedmlkDlxcGPXB3lqPF47AdYZmKjcO86XqHSjzXSKihBcmcGrXodlAqAFTCvAOoHC1RtSsQgq5VGo65IXLquesIQyWYGsSP+LVWmvANCgVHqa8xNL3GBYu3aAokixzz2/BGRptZekKAWl1pyxScPn0SAps50Wl66OTlJZe/plimgos5qNwX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/ySrbl4gK2iqPQwBUdoT4UonoEvhYSuQdiQX1YuBHs=;
 b=kROy3DKqZZrHPoeEqsWx16brEG2oDk/K6VmvVW4meHgSd4ZRyuFNVpk9FmKH19tXrxmB/umEIgfSzUiyHwVSSFgGEQ5uZqSV0UKj9HlO6jZEFCokzGc4Agmatri8i5H/flcHbdUVFT1QipjZmM+JRqihenvUxkKE/4vXjMkmISn3kGcU1VN7+OKsPRt/0U1K/YmAZDwwuzKrZ2HJqdfCucYJAs0LTxB9XQIKLwNpL3WYZi2EpeZHwI/1TEZPTWld56ybu/ztpZjPNfcm5z3jLhGRmmKSn7QeKvIDaH3VRZMZWgQj93ICd34qKIu4C5Sqz5EDeazjWVf3rGfL6C7Kvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/ySrbl4gK2iqPQwBUdoT4UonoEvhYSuQdiQX1YuBHs=;
 b=asC9cgbCFkeAoKCfL496DNTO9EcX4hLpQNqw+MlDiiPlmg8RMetAtnLkRB+LWQLPWf3k8yp9j60leaJ/HVUQy/Hd8zo13hI2oSouEdJfReMTHXGT3ZYga3F//fLTYfKVGnCSzrzjLu23oF8/PN6/Y8CHa7YgqnK50XQbga9HRBAIy8NG+SQS39Q0MLj8VzY7MXLmx6mDwkk8FYbUWRvHBNnOSVNykqdCXpo4ES8HImoxBjnBXNNBGcZL4XWW65uWZu9wOzWg2g3oT58i6YigzLEUo2joDqx25PvnzxOd7lRjw/gGh7XXC/J8VWobafZRzJRnkLPvKbTeEASlP8QXqQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 20:00:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 20:00:14 +0000
Date:   Tue, 11 May 2021 17:00:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Moni Shoua <monis@mellanox.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        syzbot+36a7f280de4e11c6f04e@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/rxe: Clear all QP fields if creation failed
Message-ID: <20210511200012.GA1325448@nvidia.com>
References: <7bf8d548764d406dbbbaf4b574960ebfd5af8387.1620717918.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf8d548764d406dbbbaf4b574960ebfd5af8387.1620717918.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:208:15e::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR17CA0029.namprd17.prod.outlook.com (2603:10b6:208:15e::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 20:00:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgYY8-005Yoj-GW; Tue, 11 May 2021 17:00:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a015fda-25e9-4fb2-53ea-08d914b7641c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4041119A9F512865D1E48C64C2539@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:198;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8etZEPAK/kP1K/nIYuXhyLqjJT28ukxUoy1gznB/4WlnF7QDbT2IxpoAfb0TcO4uB2Gfmx9vnNVIk8nTwgy0njgLNKVp97DUuYPFlYP0j7HgIzbnfUjB6dlpFR0g27VC2bBwtwlwJVpLWyPQVQa41MecIV5/Y5t/E9E+N5JvZigCfZmS8n4/nJIWAB0Uxb0bElukbMl1Qvxox+GRQubIjlbWLpHgLow2mL+0rfR8dHw/PD3FVTUJVRiCZj9dty3reuiNjYbD+5F0pXVwvOJq6Z1399pWoR64NCyK/9RAHmYUZsR2qt4FtWgnB3UQh6hBgiKnSdi04Y2d9sjHS94RR6GEszCTgQKozilFhe7ytwwaSxH5DCKySkcN5NaL7gAhTXdX+kBvyu7bMd26bhtF/yL4L+K0fbSH5oSDtfcP3jR+eLbdbqH2ji4TH7ea/Ybkd/eo7T/B9iw7Rp6EVDKCKexWNUjCnIXTzTjefX1mo/B3Ux5aW9KqErlDGUaG6H2iJ0NOZodfOEDqnhvHD96z/jpI9dlnLZj0HGnA6FjoQgZqi3uY9sIPQwmwOTzHUKmN2ScU8uFbmvXZ6E/E1reP3UAfwQXV/DDcHl2j46gfe38=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(33656002)(186003)(5660300002)(86362001)(426003)(83380400001)(8936002)(316002)(2906002)(36756003)(26005)(2616005)(4326008)(38100700002)(66946007)(6916009)(66476007)(66556008)(8676002)(54906003)(45080400002)(1076003)(9746002)(9786002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?e8c2F5AkXeJM5T91BNtVKD38ZBLc4m1JzAynLFjj/hpfH99WVX4CpsCPknhW?=
 =?us-ascii?Q?58Qv+2roO2qkeTvIlCG8zC/h99K1b6i994SWN97VcoSTbJMmbEGfp0y/u1Bk?=
 =?us-ascii?Q?vAKyN7HJ5pJuWKIbzijlVU99gW3BMLnlRePoX10DzT3tiOWn1jkwwjmInk9g?=
 =?us-ascii?Q?QpuEUyA2EVtc1FUMF0COxmzRQBqMjQkcmrNhJieqYyYRIECWmHVUhXThjIRZ?=
 =?us-ascii?Q?I6Z0CK05xzxFX/gVD7laWZUUTs8SLceeUZd1tg4orZjKYj0hA9xWHMsuEJWX?=
 =?us-ascii?Q?/qs9v4pEEDv/6CxT4wR+kTgbUot+oU5FKJ1QqhsL1dLEBVWHQvQrXIJJtHQM?=
 =?us-ascii?Q?f8k2BbPMTqjj87GjOo/VnDp7P5zQyqnjeCo4oGxM9XGQvteuRSoEWuO+YdDP?=
 =?us-ascii?Q?rLQ8WlXCfE0zBOy2TmMqr22QI9eaPAKXtbRo5vNbQI9iGH+EFEabVZ5WjXkA?=
 =?us-ascii?Q?2Yr8dk8yM9x/e4HHzaAy03h9aLMZGyXC4Aybgdwt5r10XiEuNzyQjNP7fAkb?=
 =?us-ascii?Q?EA7cXYRor5ito1I5A8lZ7VndURFMo32sr8H5PvGL/OByWvGNAg4AnyjIVL88?=
 =?us-ascii?Q?UI24RVt4Vnj0N/3+cx28oolLKSUTC0IVkfWqCTm+rwD2/K4Wj/ez7zDkdrrm?=
 =?us-ascii?Q?B4h/XQIR+QouKnEVNx/gzlzBkTDx7EfXnLClqhWHZL9H+IjqN+tb7lazdYI2?=
 =?us-ascii?Q?JRnL/aXa2SjtZZkr+vQvvEhu0r0Oqh3GayO1zz+0WO4d01hP26NaRmx04Jz+?=
 =?us-ascii?Q?Iw6hm4xZBdqnJrqlylxYx4VHhy0M7dhF9NwEAmo0W1bBGqwCMUiqEKIsCwCV?=
 =?us-ascii?Q?US79ze5si6IN9CALLi2ArzYGzMKXLD1opoPw8kANNOEHGcHpGyR27MT5tXoe?=
 =?us-ascii?Q?g9gZ7xXuuy+nueNN6dfr0tCrQ/+ne1lQz5KKK3UyfhaytH7ziLf1bYmFbI9k?=
 =?us-ascii?Q?BPF+XH8oxAp3XYkv/ji32wjgqjBWJZ+3F0mxf76sx2/A2eniwxrAYzQYXXSc?=
 =?us-ascii?Q?NjPsuQjE48/K+4GK7q6Hev1rOhElb3tbYW8m+81Gx/8lq2X36q/wXrlp/i74?=
 =?us-ascii?Q?MpgmDkBHVKasRbRSm4s/ecHdrtg8TXM+4YWAeDSyZdU+OI5nNDFerW6U+o9+?=
 =?us-ascii?Q?MgEbrKrK6vCTq3rNo7GTdoxBM3r7+e5h+d2A1yfuxeQFHHZq8E2jtZCZQ7+8?=
 =?us-ascii?Q?9nCAtbUgf6aXufnyxk4a6GU++wgm47JBw0JN2EBDAx6cmsH+z9GhFuWic3t8?=
 =?us-ascii?Q?fl4RwCy4X/nDy14A2wflhAh4n1RxDHVr7IM00ZfnacOY8uUJBhnXxG4dvBV7?=
 =?us-ascii?Q?clmiNSrG623U1BnspcufvExq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a015fda-25e9-4fb2-53ea-08d914b7641c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 20:00:14.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJmY+dN+YkDpaWZjIUjOOPWsqvZxQR+m03jUpw4dI7rM2yfOMvnZjSLcDUdOt7xI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 11, 2021 at 10:26:03AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> rxe_qp_do_cleanup() relies on valid pointer values in QP for the
> properly created ones, but in case rxe_qp_from_init() failed it was
> filled with garbage and caused tot the following error.
> 
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 1 PID: 12560 at lib/refcount.c:28 refcount_warn_saturate+0x1d1/0x1e0 lib/refcount.c:28
> Modules linked in:
> CPU: 1 PID: 12560 Comm: syz-executor.4 Not tainted 5.12.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:refcount_warn_saturate+0x1d1/0x1e0 lib/refcount.c:28
> Code: e9 db fe ff ff 48 89 df e8 2c c2 ea fd e9 8a fe ff ff e8 72 6a a7 fd 48 c7 c7 e0 b2 c1 89 c6 05 dc 3a e6 09 01 e8 ee 74 fb 04 <0f> 0b e9 af fe ff ff 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 55
> RSP: 0018:ffffc900097ceba8 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000040000 RSI: ffffffff815bb075 RDI: fffff520012f9d67
> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff815b4eae R11: 0000000000000000 R12: ffff8880322a4800
> R13: ffff8880322a4940 R14: ffff888033044e00 R15: 0000000000000000
> FS:  00007f6eb2be3700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdbe5d41000 CR3: 000000001d181000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __refcount_sub_and_test include/linux/refcount.h:283 [inline]
>  __refcount_dec_and_test include/linux/refcount.h:315 [inline]
>  refcount_dec_and_test include/linux/refcount.h:333 [inline]
>  kref_put include/linux/kref.h:64 [inline]
>  rxe_qp_do_cleanup+0x96f/0xaf0 drivers/infiniband/sw/rxe/rxe_qp.c:805
>  execute_in_process_context+0x37/0x150 kernel/workqueue.c:3327
>  rxe_elem_release+0x9f/0x180 drivers/infiniband/sw/rxe/rxe_pool.c:391
>  kref_put include/linux/kref.h:65 [inline]
>  rxe_create_qp+0x2cd/0x310 drivers/infiniband/sw/rxe/rxe_verbs.c:425
>  _ib_create_qp drivers/infiniband/core/core_priv.h:331 [inline]
>  ib_create_named_qp+0x2ad/0x1370 drivers/infiniband/core/verbs.c:1231
>  ib_create_qp include/rdma/ib_verbs.h:3644 [inline]
>  create_mad_qp+0x177/0x2d0 drivers/infiniband/core/mad.c:2920
>  ib_mad_port_open drivers/infiniband/core/mad.c:3001 [inline]
>  ib_mad_init_device+0xd6f/0x1400 drivers/infiniband/core/mad.c:3092
>  add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:717
>  enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1331
>  ib_register_device drivers/infiniband/core/device.c:1413 [inline]
>  ib_register_device+0x7c7/0xa50 drivers/infiniband/core/device.c:1365
>  rxe_register_device+0x3d5/0x4a0 drivers/infiniband/sw/rxe/rxe_verbs.c:1147
>  rxe_add+0x12fe/0x16d0 drivers/infiniband/sw/rxe/rxe.c:247
>  rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:503
>  rxe_newlink drivers/infiniband/sw/rxe/rxe.c:269 [inline]
>  rxe_newlink+0xb7/0xe0 drivers/infiniband/sw/rxe/rxe.c:250
>  nldev_newlink+0x30e/0x550 drivers/infiniband/core/nldev.c:1555
>  rdma_nl_rcv_msg+0x36d/0x690 drivers/infiniband/core/netlink.c:195
>  rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>  rdma_nl_rcv+0x2ee/0x430 drivers/infiniband/core/netlink.c:259
>  netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
>  netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1338
>  netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1927
>  sock_sendmsg_nosec net/socket.c:654 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:674
>  ____sys_sendmsg+0x6e8/0x810 net/socket.c:2350
>  ___sys_sendmsg+0xf3/0x170 net/socket.c:2404
>  __sys_sendmsg+0xe5/0x1b0 net/socket.c:2433
>  do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4665f9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f6eb2be3188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 00000000004665f9
> RDX: 0000000000000000 RSI: 0000000020000600 RDI: 0000000000000003
> RBP: 00000000004bfce1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
> R13: 00007ffc54e34f4f R14: 00007f6eb2be3300 R15: 0000000000022000
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Reported-by: syzbot+36a7f280de4e11c6f04e@syzkaller.appspotmail.com
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied to for-rc, thanks

Jason
