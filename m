Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C45203E50
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 19:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbgFVRs3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 13:48:29 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:34012 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729886AbgFVRs2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jun 2020 13:48:28 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef0eee80000>; Tue, 23 Jun 2020 01:48:24 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 10:48:24 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 22 Jun 2020 10:48:24 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 17:48:15 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 22 Jun 2020 17:48:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTJPFQVZNLIRrbs3Z2Jw+VZ+gjXy5QG+veiMBjQF6AkzPm9/uGvcoR+oBY2E7nJxco1ZDenlzITWM5TMgJ+v7dRHbfaIAj6WfX34w/LzbDYA3hpCS91AO7i54u2fUiN1bOXPcrpJGQs8PCV9QlNLSE/fNRCuSx3yyHjS1X8PhEiInDE0VfY17CwsPZQqZI6ET3SsFJkqiVvfzeVJARNtA3rZN44doaoDd0TQDvC218lMMOFUybCwaLeZ6wiHNq0WKcS0Lc4x7lLKGgLbQanumg2XJoOYabnBGDrt+LFi8ZsJ7g6QpUvjMhJxWJWBPvOMQ1pG75m5KVQV9hKNtI7oNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GRn024UEzQBP01HM2wi+p3UUFYwx/Tzp4xwEJl9+k4=;
 b=Wq2MGX/WPKC6KGDf2ZVAo9yVGjzKkWVdQZj/zk1n0BLs+jpmRDP1ugm2kIIjBCy+e+qaZ/fZIr0yIv78ilqyy2xIqYCu+FCJdQNOpT8XI26CohPkRZ5WUEDdP3VlNUGobfkFkYWi3CDEOn5dPxDgLWVKdU4Uw1wvUZnyyOagdR8z+XkGcQo1vVBt69F2wn4oKLuFByYfYzfVEP+ILj7uYuCaQLijsFkT9Kw0djltn9hNDYsEXh/3BFY1Vif/NcT6JcAavelxON8leseRJS3U7Qtv+ieNPBOe3VZs3JlvFmRoRUfX6AyredvbkgT1vkjGM4r1hyLLYUnDKs27GzqDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3254.namprd12.prod.outlook.com (2603:10b6:a03:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 17:48:13 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::e1bb:1f91:bd87:9c6b]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::e1bb:1f91:bd87:9c6b%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 17:48:13 +0000
Date:   Mon, 22 Jun 2020 14:48:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Protect from kernel crash if XRC_TGT
 doesn't have udata
Message-ID: <20200622174807.GB2884277@mellanox.com>
References: <20200621115959.60126-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200621115959.60126-1-leon@kernel.org>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:208:23c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 17:48:12 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jnQYB-00C6Ly-CN; Mon, 22 Jun 2020 14:48:07 -0300
X-NVConfidentiality: public
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee2aeecc-b24a-4717-428f-08d816d46f3a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3254:
X-Microsoft-Antispam-PRVS: <BYAPR12MB32548AED10D66006D5ECAEAAC2970@BYAPR12MB3254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRIAeJcDoQ3xL458oL8ZWwd8G0rSYWuHtFpQYjON5fZoBqXmj7HJCsjiZUlatgGlaqipM/FVb3tnC7nFIXwykGwKfo0vlaEU7P2nA+bLIXfOHfhax+3fOkBMrRB1LP5R4eV6m1wv+eLUFEr/pZzsTR2uQ1Mx1gO6/oJJbTj1n8qoPYBtgHFCScIHfEoBHWBhFChAYRqpI+hK/NfgFNqoEpQ0bp8+6WnQmkcNufh1Yja25vPSOmX3VNWEJNMHjtzc7xMRECzxAETF9JwWnwwHoaiOMQkJLF+l7SJeF2xmrrfY3PMqPL9+Ba4CFzv4Q7ioru9hATXDAec4QtGcIVZoqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(366004)(346002)(376002)(136003)(54906003)(45080400002)(186003)(478600001)(2906002)(33656002)(26005)(83380400001)(8676002)(9746002)(86362001)(5660300002)(9786002)(316002)(66946007)(66556008)(66476007)(9686003)(4326008)(1076003)(36756003)(426003)(8936002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HCzovFKZEA+MGvhKgSTHR1jmJEkZMT6nLegEd4+AgtzC2bMu7OG0AKErq/RVO4OdFnj9BsrPKZNZt8lJF7z3UzxksenWWCBSi5n4yONQ42lumY+qdWG8Xn7FjtDm+JkkZOFDb5p6Hw2hTyZdD53xm5X4r93nk7Rhr/WM8YCqNu9ixxb1Qxfhf4FwQBIxi0c+dEFDN5SjbVDg2x4F9W9+QJ1v4MSKvehy0NnlvndYmCE9dA8azSh7pyOSpvz2OkeL9hj80vFE1wFow4vrdln0RFD8ZcUkbbtsvMGmymia6MV9XjYIM1MSB3yPpqAFlEjxd0Re3NAsmrNS0041Qz4ed0mE4zFVWs4DLj6BsY1T7IW6CxD2EnzMb9ps9EqEptZzLm20Js5s4oLRKAWjvVi1nhLk8jWqA8dwo44zRuCzEWGa1KfTa9FqM+rtlKn5xCUV0BNQ4VXfDKYyfrknNQrYshDL7w+cX1wg73gZ+jzSrDM=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2aeecc-b24a-4717-428f-08d816d46f3a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 17:48:13.2239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkTYGO3AFJ9xtrHkYW+iqrdbO7gfCAMyIpwclq+N3f/pPN7mQqJUDIRVLuq92RTB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3254
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592848104; bh=8GRn024UEzQBP01HM2wi+p3UUFYwx/Tzp4xwEJl9+k4=;
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
        b=ovfRtZE9sbCepUQj5r5wt1e9BOS5Wh6ohddR964M1wjbYHRFb0Y6H+8h8QMFYPm1m
         VajPM8FbiZP/6pSeSZegVT8mLgLu9qcUoN5GU7pu0Ak4TCBX5xKbj9HzqeyB1dzxu/
         ddvfArMLqdvE0lVukLlKe8hz3tp05NUcAb51mPsddpRbdMWAPti+2c1A9qPLIa4YRa
         Vh4MEFzx8jggH8oWq7bmHEq28irxDX5lCSEs7LbCZA7JeqsPEr4lK9iToMhqe66rQ1
         b/olCQB9h975K4XKMlmnzv1klYb7zP/KnSKjTw0SY2I2jZRihEQG71H53JsIObhh0+
         ecK3i8RC1adfw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 21, 2020 at 02:59:59PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> [  316.938373] BUG: kernel NULL pointer dereference, address: 0000000000000030
> [  316.941956] #PF: supervisor read access in kernel mode
> [  316.942692] #PF: error_code(0x0000) - not-present page
> [  316.943415] PGD 0 P4D 0
> [  316.943820] Oops: 0000 [#1] SMP PTI
> [  316.944338] CPU: 2 PID: 1592 Comm: python3 Not tainted 5.7.0-rc6+ #1
> [  316.945214] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 0
> 4/01/2014
> [  316.946732] RIP: 0010:create_qp+0x39e/0xae0 [mlx5_ib]
> [  316.947443] Code: c0 0d 00 00 bf 10 01 00 00 e8 be a9 e4 e0 48 85 c0 49 89 c2 0f 84 0c 07 00 00 41 8b 85 74 63 01 0
> 0 0f c8 a9 00 00 00 10 74 0a <41> 8b 46 30 0f c8 41 89 42 14 41 8b 52 18 41 0f b6 4a 1c 0f ca 89
> [  316.949880] RSP: 0018:ffffc9000067f8b0 EFLAGS: 00010206
> [  316.950681] RAX: 0000000010170000 RBX: ffff888441313000 RCX: 0000000000000000
> [  316.951750] RDX: 0000000000000200 RSI: 0000000000000000 RDI: ffff88845b1d4400
> [  316.952857] RBP: ffffc9000067fa60 R08: 0000000000000200 R09: ffff88845b1d4200
> [  316.953970] R10: ffff88845b1d4200 R11: ffff888441313000 R12: ffffc9000067f950
> [  316.955054] R13: ffff88846ac00140 R14: 0000000000000000 R15: ffff88846c2bc000
> [  316.956189] FS:  00007faa1a3c0540(0000) GS:ffff88846fd00000(0000) knlGS:0000000000000000
> [  316.957478] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  316.958378] CR2: 0000000000000030 CR3: 0000000446dca003 CR4: 0000000000760ea0
> [  316.959497] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  316.960609] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  316.961721] PKRU: 55555554
> [  316.962221] Call Trace:
> [  316.962686]  ? __switch_to_asm+0x40/0x70
> [  316.963352]  ? __switch_to_asm+0x34/0x70
> [  316.964018]  mlx5_ib_create_qp+0x897/0xfa0 [mlx5_ib]
> [  316.964875]  ib_create_qp+0x9e/0x300 [ib_core]
> [  316.965657]  create_qp+0x92d/0xb20 [ib_uverbs]
> [  316.966397]  ? ib_uverbs_cq_event_handler+0x30/0x30 [ib_uverbs]
> [  316.967325]  ? release_resource+0x30/0x30
> [  316.968002]  ib_uverbs_create_qp+0xc4/0xe0 [ib_uverbs]
> [  316.968834]  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xc8/0xf0 [ib_uverbs]
> [  316.970049]  ib_uverbs_run_method+0x223/0x770 [ib_uverbs]
> [  316.970925]  ? track_pfn_remap+0xa7/0x100
> [  316.971635]  ? uverbs_disassociate_api+0xd0/0xd0 [ib_uverbs]
> [  316.972542]  ? remap_pfn_range+0x358/0x490
> [  316.973248]  ib_uverbs_cmd_verbs.isra.6+0x19b/0x370 [ib_uverbs]
> [  316.974188]  ? rdma_umap_priv_init+0x82/0xe0 [ib_core]
> [  316.975035]  ? vm_mmap_pgoff+0xec/0x120
> [  316.975695]  ib_uverbs_ioctl+0xc0/0x120 [ib_uverbs]
> [  316.976489]  ksys_ioctl+0x92/0xb0
> [  316.977098]  __x64_sys_ioctl+0x16/0x20
> [  316.977746]  do_syscall_64+0x48/0x130
> [  316.978377]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  316.979187] RIP: 0033:0x7faa19012267
> [  316.979803] Code: b3 66 90 48 8b 05 19 3c 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 3b 2c 00 f7 d8 64 89 01 48
> [  316.982520] RSP: 002b:00007ffc43961e18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  316.983771] RAX: ffffffffffffffda RBX: 00007ffc43961e98 RCX: 00007faa19012267
> [  316.984905] RDX: 00007ffc43961e80 RSI: 00000000c0181b01 RDI: 0000000000000003
> [  316.986037] RBP: 00007ffc43961e60 R08: 0000000000000005 R09: 000055e723996840
> [  316.987148] R10: 0000000000001000 R11: 0000000000000246 R12: 000055e723996980
> [  316.988277] R13: 00007ffc43961e60 R14: 00007ffc43962158 R15: 00007faa11da3e00
> [  316.989396] Modules linked in: ib_srp scsi_transport_srp rpcrdma rdma_ucm ib_iser libiscsi scsi_transport_iscsi rdm
> a_cm iw_cm ib_umad ib_ipoib ib_cm mlx5_ib ib_uverbs ib_core mlx5_core mlxfw
> [  316.991910] CR2: 0000000000000030
> [  316.992511] ---[ end trace 56565abe20776836 ]---
> 
> Fixes: e383085c2425 ("RDMA/mlx5: Set ECE options during QP create")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
