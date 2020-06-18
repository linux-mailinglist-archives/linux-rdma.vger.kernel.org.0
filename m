Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE771FFAC0
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 20:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgFRSFu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 14:05:50 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19509 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgFRSFt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Jun 2020 14:05:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eebac980000>; Thu, 18 Jun 2020 11:04:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 18 Jun 2020 11:05:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 18 Jun 2020 11:05:48 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun
 2020 18:05:39 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 18 Jun 2020 18:05:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvFkj+Xxs2jjy8G82poUTh4PbQObZlsvQqHA5VnBKo1WmvWRoAVAAbxuwZAJEWGHnJaAMKjYM0Sp2P8/TcZ6eepcvspbRC+QFTyxNUxLOGhpeBvxLwOEtAYD+F7kzaGeHWL0yjT2S7Z+RNNN4sXtcRKSl487SF4/qHsNymXruIECg6tdIcdaxoDbGTsvFCdEsmqgyzgoLws8U6j6hywwDs2RmYh+ej/1VWY6PRuDGyQpZxjiKCzraGaoE6e4HFsmWWq2tJzzJprF3WNHBKYq2B5rc1nfLNfB4zpY+wNlAyZAcK2lJrDoNZU/XDGHjwHJ5MkonPO7SLMZoJMMd+wKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1LC5PAMCWYtiOB2znaiRCnkx/E+HXFTElyc74T8Qnk=;
 b=ZwH+5pvbNQe1hfKNMj5HLWxc9Blh4TrKETkQYolzG8bcUFiCqTEAG40qTZDIkyajSOk/OjVp52eLTr6/ht7IFq0Y9127iliOmHbUvYLVG3c/psACixjdvidONJYNJtoyuQVpCcrL9dAKY6ZA1IpDJiWKbbkVea/B3VDGIz9CVTIQ1RJ/24kE9B7UgP9aVvGG5AEbCF8xqSiqw6teNHCPOGWpnA84NCU/vqyqtK5RHlEEje1erBom4hUXBaQhT8U2lj+WF9BVZHdtJ82zB8EljYE428N/pYqe2QEHJZDZ9u8krwggovn2JZLTHoXooew0P9S140zxnAs8i7txNW4KhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Thu, 18 Jun
 2020 18:05:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 18:05:38 +0000
Date:   Thu, 18 Jun 2020 15:05:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Don't access ib_qp fields in internal
 destroy QP path
Message-ID: <20200618180537.GA2449048@mellanox.com>
References: <20200617130148.2846643-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200617130148.2846643-1-leon@kernel.org>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:208:178::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0002.namprd19.prod.outlook.com (2603:10b6:208:178::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 18:05:37 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jlyuv-00AH7J-1A; Thu, 18 Jun 2020 15:05:37 -0300
X-NVConfidentiality: public
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c51e6e1-5b42-422d-03c6-08d813b23491
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440D01CE5ECD4D3C7B14DD9C29B0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPzq8hrARaNypH8sEK9uDCwsgd5RPdQ0qYSO8iS6M7MWXni1KCWq0+Dw1Ml+XEwp50pleVB/29f1DZUGSqXs05K7BA8rwS3BVeDSDY8ExWJWK+AixYLDGKQa86GWNv5HspJp2UEVV502pizeaUGjVAOwl7RMSmTE2daPSIzFWKFpwSfxKMfSoinN4CNlYTjD9b+goePg4rC6Z+6Gfyh6dk9VqRF8e5yP+zEN6HBVxMwOGVZwi2J4UAfdpu+9PRrHs89wA3G/WPnvOvWFQZpOgZpUAGjhawtRilVwatN5uk9qcWInikGaXQNxmFjvRxaAff0e5p2ZSSbTGA81asVL1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(316002)(186003)(8676002)(33656002)(426003)(9786002)(83380400001)(4326008)(9746002)(6916009)(5660300002)(1076003)(8936002)(9686003)(54906003)(478600001)(66476007)(66946007)(66556008)(86362001)(26005)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hRHJoGLEpmBzT6YUHlJgTrtHVJIE9Jj1xua3Ft3BD9JOtjLrRNAHEgZM64ciCoM2zZmzoVmoMXA/443oRwZjmUhaR91HqBo8BWXC/VGyh0gNTHNEI/tZEGRP4I5XE+BmGJX52sNGi9P4FXjLtYV3dHvpAQSCGUnkaLmyOzbotqIUPerulfn3UUyWhE9Ozh8wgIPTrK/J4klQysmLAOuuT6VZsOEOO4YDBe8xERzdosehC94hPh9/H1uGIC8DPJOlrvCKuHuajhkjMvpe9dJIPpaRtOqftBzuIta6vhpHKkphLcj8RZ2aSIfRASig2qpSzRDnC5VI+JdLFY5hQq3mK3d5FuMtXpoDEf8pv2lVChGTNAmH9vG31i91w7D3JLCQcRnMPNL314ikRJDtNOm+iiuplejucH7P5+RcZUa1uRqJdugLlgw1Gw+wK+7bPWW77P7I9QlcLq3N72/K+85bz1r4Ch2OmLCHdt/Lgv7lVWE=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c51e6e1-5b42-422d-03c6-08d813b23491
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 18:05:38.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+xqxsg1ggczWucKLjpq+wbXjpSAhjI0dLXJBVipqrylPqEYtOH4R+N/qD+kM9k7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592503448; bh=s1LC5PAMCWYtiOB2znaiRCnkx/E+HXFTElyc74T8Qnk=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=j1kYRtMrs50/ij25as7h2nEMUyvrGfFURN3sbYepG7FXntMzaJMhQNbC8WnGWA+kU
         5R6AnTJyijc4hk9/zVuDOhucg7FNTVrLvgBQr/Tq1B77tBQg7gLBF5wawyXKvrqQ+r
         zj5TzvRkyh4wldn8V/0lKXe+LCvqJeCsWS/Xju5nOPEHp+NiZtudCgEAxTN9zt9rJt
         iW/DfvW/Rh2YbRuaj0g1PDhG9XeipU981z/JdR1Z5s0Bt+bAixd2j1BQB5FBShwMiM
         rnbu6qgCPdSQV8MxF3aihw0SPCM/FU8DlNiz/Plk/23vdysZmt9nO+DqY+UONFFeJp
         83PRDsfHEKOEw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 04:01:48PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> destroy_qp_common is called for flows where QP is already created
> by HW. While it is called from IB/core, the ibqp.* fields will be
> fully initialized, but it is not the case if this function is called
> during QP creation.
> 
> Don't rely on ibqp fields as much as possible and initialize
> send_cq/recv_cq as temporal solution till all drivers will be
> converted to IB/core QP allocation scheme.
> 
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 1 PID: 5372 at lib/refcount.c:28 refcount_warn_saturate+0xfe/0x1a0
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 5372 Comm: syz-executor.2 Not tainted 5.5.0-rc5 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  dump_stack+0x94/0xce
>  panic+0x234/0x56f
>  __warn+0x1cc/0x1e1
>  ? refcount_warn_saturate+0xfe/mlx: ERR-GENERAL [mlx5/mlx5_cmdif_cq.c:213] mlx5/mlx5_cmdif_cq.c:213:mlx5_opcode_CREATE_CQ: assertion failed (MLX5_ST_SZ_BYTES(create_cq_in) + (npas * MLX5_PHYSICAL_ADDRESS_SIZE) == in_size): (0x00000118 == 0x00000120)
>  report_bug+0x200/0x310
>  fixup_bug.part.11+0x32/0x80
>  do_error_trap+0xd3/0x100
>  do_invalid_op+0x31/0x40
>  invalid_op+0mlx: ERR-GENERAL [mlx5/mlx5_cmdif_cq.c:213] mlx5/mlx5_cmdif_cq.c:213:mlx5_opcode_CREATE_CQ: assertion failed (MLX5_ST_SZ_BYTES(create_cq_in) + (npas * MLX5_PHYSICAL_ADDRESS_SIZE) == in_size): (0x00000118 == 0x00000120)
> RIP: 0010:refcount_warn_saturate+0xfe/0x1a0
> Code: 0f 0b eb 9b e8 53 e2 6d ff 80 3d 8c c6 39 03 00 75 8d e8 45 e2 6d ff 48 c7 c7 80 07 15 84 c6 05 77 c6 39 03 01 e8 b2 44 49 ff <0f> 0b e9 6e ff ff ff e8 26 e2 6d ff 80 3d 62 c6 39 03 00 0f 85 5c
> RSP: 0018:ffffc9000b5976f0 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff88811478f134 RCX: ffffffff81248f69
> RDX: 0000000000015258 RSI: ffffc900022b1000 RDI: ffff88811b1283cc
> RBP: 0000000000000003 R08: ffffed10236260e3 R09: ffffed10236260e3
> R13: 0000000000000246 R14: 0000000000000000 R15: 0000000000000000
>  mlx5_core_put_rsc+0x70/0x80
>  destroy_resource_common+0x8e/0xb0
>  mlx5_core_destroy_qp+0xaf/0x1d0
>  mlx5_ib_destroy_qp+0xeb0/0x1460
>  ib_destroy_qp_user+0x2d5/0x7d0
>  create_qp+0xed3/0x2130
>  ib_uverbs_create_qp+0x13e/0x190
>  ? ib_uverbs_ex_create_qp+0mlx: ERR-GENERAL [mlx5/mlx5_cmdif_cq.c:213] mlx5/mlx5_cmdif_cq.c:213:mlx5_opcode_CREATE_CQ: assertion failed (MLX5_ST_SZ_BYTES(create_cq_in) + (npas * MLX5_PHYSICAL_ADDRESS_SIZE) == in_size): (0x00000118 == 0x00000120)
>  ib_uverbs_write+0xaa5/0xdf0
>  __vfs_write+0x7c/0x100
>  ksys_write+0xc8/0x200
>  do_syscall_64+0x9c/0x390
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x465b49
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 mlx: ERR-GENERAL [mlx5/mlx5_cmdif_cq.c:213] mlx5/mlx5_cmdif_cq.c:213:mlx5_opcode_CREATE_CQ: assertion failed (MLX5_ST_SZ_BYTES(create_cq_in) + (npas * MLX5_PHYSICAL_ADDRESS_SIZE) == in_size): (0x00000118 == 0x00000120)
> RSP: 002b:00007f0984e16c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000465b49
> RDX: 0000000000000068 RSI: 0000000020000380 RDI: 0000000000000004
> RBP: 00007f0984e16c70 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0984e176bc
> R13: 00000000004ca2ec R14: 000000000070ded0 R15: 0000000000000008
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> 
> Fixes: 08d53976609a ("RDMA/mlx5: Copy response to the user in one place")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)

applied to for-rc

Thanks,
Jason
