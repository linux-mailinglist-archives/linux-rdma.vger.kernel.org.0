Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08754538DB
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Nov 2021 18:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbhKPRz1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Nov 2021 12:55:27 -0500
Received: from mail-bn1nam07on2056.outbound.protection.outlook.com ([40.107.212.56]:28222
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235838AbhKPRz0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Nov 2021 12:55:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZVI741n8mICXpIVBpIBDBaG5NnT17ydJ0H9CHFPun3ESGvEyqbKFtz2N3fJc9xVe5wS3dDkCZBZ7khDPsO/DJMSft8ugWJNvs0pbb3gMGLXdfBhMDIzg7C/ueiOxzSrXtphGKa9lblHwzhGz1A142EYt/aMH86uGR3+qRBxx0wEAl8EfgaY90IBhOY7BhcZCIWBdH0jkAUSGZIutOdxTFp6Tc751NEb60qIOsGXFta7cvAvis8o0Zpl6J6Nm0FZ/n2lg/+4xwDctgA4S573ww4paU+iE4Px1fL0VXe7fGZimDY8diFELvGiVm3JLjas+sJe4qtQzul26qJarjPEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoqn64U+3gBIxJqSJixyMDu5Okxg0gHVpcuzjCzvCV0=;
 b=jWzfpLu4ck9s58jA3CxhpqW2VaOAIz/6c3HLMbPb3p3W6x5urpjjYaCNR3FmKfDhRCwTC4a5b8rSzxNLFO3UpKUYlxAskTITWhSqXjvUw+N+nuSb5NBty2b/dPdx6mse8RrPoSqM9AlRyixmd/THlkTGQWkj3RciJ7QdKK4t/G/6618oZiI1yQdScbNV+zMuFt8JSiI9OpNUNTWLDdz+cMnqPj5DdDckBM5tdhOclMlGxgeRfDbqzPvx8jUmqZKxD7HLm1Zjk2HXOjRT1ftvf+bYwMpjU4JxCWrUik1b8eCGD1K+A8KKizViMVAGFDdeo98+IBd59N8pj+NymUEc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoqn64U+3gBIxJqSJixyMDu5Okxg0gHVpcuzjCzvCV0=;
 b=qPPL4f60i6c17YLXzX7AYCj034VXQcMKf2kI4/rRQtV7M5MYTti0KJxxBQCmCzwY8sehzYDFHm4LvzI/Db8cNjfNg1CCvYChl7Y9jr8DaXpcaxZiYSgelI5amHW/aYp4gSSCpro4rGpJn334kUtJS60at+gRC6xO38B8Md93ZtAUMAIhLDV+i4fIT07y0DR1GdeR2HxTky3R+DxQ1McGSxoV1QT7YdOuor32J99JCVeGb3sEyCzbRBrVaCYz/nEeEi8E73RJswqd/0FbeLfYoLbQb5PCIk4XX5yw4lTcBL0b6j42Y9s+80W83XzGnzTqsepNd5rl6v7zRAvMIDUrbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 17:52:27 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 17:52:27 +0000
Date:   Tue, 16 Nov 2021 13:52:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/core: Set send and receive CQ before
 forwarding to the driver
Message-ID: <20211116175225.GB2656760@nvidia.com>
References: <2dbb2e2cbb1efb188a500e5634be1d71956424ce.1636631035.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dbb2e2cbb1efb188a500e5634be1d71956424ce.1636631035.git.leonro@nvidia.com>
X-ClientProxiedBy: CH2PR05CA0034.namprd05.prod.outlook.com (2603:10b6:610::47)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR05CA0034.namprd05.prod.outlook.com (2603:10b6:610::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 16 Nov 2021 17:52:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mn2d7-00B9AB-U9; Tue, 16 Nov 2021 13:52:25 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72590d94-6890-47e7-5d1b-08d9a929da65
X-MS-TrafficTypeDiagnostic: BL1PR12MB5110:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51108C18461AB7AA40BDA3B2C2999@BL1PR12MB5110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vwv81l+B2K/eHv6xvooZC8Z53z/3sOG4luZ8GAjKbL816o0J95j5MEc9NIVjcsLMTn0RsjPULvi3D23CP9giHUxBLQZe/Hd59CKTUReXdT0096lDT6DwceogxI5YDD1vDoRD8UEaZ8LGQ8oy9417GOHgbG3ybhTO4vRKNe3nV4yM9Pq5zxf600E4ZfMF7BonXB/jj7X8kVyTqFtqilUZtu4GpuSQAX/DQpQsFHGIBelqddlu4YI+TLr7wwfzw1EDweTkfbRYNhQFtdYvzEGavvqkIEk8ijDhIKvSjvaSzTFyk+5TdIwIdp4i/XUS0ROXazI5C+ODm0SnBjj4Z+Zy2hClyL6cY8b4SIdW1KVjusAWKMWy/JMXyO3z7JjpwdLzdDdWC6rYtiET6Ps2VxF0LdFc5+clKeameX7TbvtSfb4H9qkLwz+Uoj0xNRrhTPEmd8Juo14ZiBn+Px4j2iubfvs0BtvnTLWaKy2k+hjFtsgVCzd3TTgIJCcWCLtA+6tBKD53dx8taM3fExiIrq606ACQxuMdxsoBDqY+3/fj4upPNZ0Billmp7IMTUKug4qXRcWLIe9xlsESahcr3fN8K7mdF1B7QWudKpHqfeonyKh7zGxwLPa4c/kGKPhYj1EuN8AbVGUi4BOXbndpmTCjceEPd98ayX5AzvLs+dgSduo/g0bMSHG7933PNIdwEuv45JZ3S+RPqypL69tOcOEmoDlQZRozO0yKzWgfu39H0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(66556008)(86362001)(83380400001)(38100700002)(54906003)(26005)(2616005)(1076003)(8936002)(9746002)(316002)(8676002)(9786002)(186003)(426003)(4326008)(33656002)(508600001)(2906002)(5660300002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qxesX872+VMViXhYRImq9hu4Ule3GMqI3d48NiZLe519fj6mrDdloyKMfoGj?=
 =?us-ascii?Q?kGwsHQC9ZlM2bEUHOuG9wsgwn+vJAaPObddLTXpw1RqeblSBNjmE/AYDvHBS?=
 =?us-ascii?Q?gDr71UvoHM0PWrvcLQhDr752+QygWuGiALqWu6j31CxoX+oQnC0DzC07BYsW?=
 =?us-ascii?Q?wsTZpUeXZ6l2Rh6jGtt+5mhAxNapYq6ngarJ55CimcgxQlOxnDTLKPN1gtpT?=
 =?us-ascii?Q?eLZfiQuGNnaTy+H0YeALgeGJXaZKTM1FCpHipVMC64mKs1jDQ2WHGLGP2WYi?=
 =?us-ascii?Q?DGMv/LbhsGFDqwkp5WH4QScFwKI89d5JXnrR57o17k0nD+SC8A5h+g0/CZXk?=
 =?us-ascii?Q?/jpQyhkj2k2FWKV/VAV2P0ShCQeiM8O7eTvcg+9MQo9r+Hgk7gbTpfyWUFQF?=
 =?us-ascii?Q?XpYXMXDXmH5jjv+9cAJCMoOFqO4WkGml/4I6jiMoarxeWqWUnv27+oTJAtis?=
 =?us-ascii?Q?EL8LMQIIbyK93x0q9rL775YVtBaFTeohOGWzTwWU727bHFwNdlG0iBir6dn6?=
 =?us-ascii?Q?CvT38XWqTxOagZ6jnDOCuwLMYyNeUFQ6Ov0nOKX0bBu6D8/spS6Hh+jhr6ZF?=
 =?us-ascii?Q?VuF5scQXcZZdYOImwhRFXL3lRKQmWXehFwflFPr0GBhWjg9UZVQiwRBi7bVr?=
 =?us-ascii?Q?UBgxsBeEGCu2V1VcGu9JdLm8aO05byY3mrFvFAn4jGY0l6wIElqzUkrpO+i2?=
 =?us-ascii?Q?Rsk0p6dfRKW7M5Ka1RayGfl1PgSXWNgLsXq4dtJtFgpciy4td40zrkpSYVTs?=
 =?us-ascii?Q?9IFXqjjtqs8azgduqBc7LY7SRRiI9VPHXJ3bjGPDt35cjH2+dJpeZq40EuEy?=
 =?us-ascii?Q?BSClvmKEOzIsm+kzpE3QseHo3B4iVwrMXI9TwRxPl83rHXljmo3KFspbN9db?=
 =?us-ascii?Q?WayMoRRCus2wMpzGRniROfbR4sbx8WKmJTEgTEsMJPe1p4Ic6jc3PawvsHwU?=
 =?us-ascii?Q?gIiK9R9wlmF+gT3dJ3D4tGAGmtnfgZvjEZ8Ndk+Ku2PYSsDt3WmlG5XBZpex?=
 =?us-ascii?Q?etL1XcWTKXLbj6rXzXb993hAtV9m5a/ouMatCpTxbYhM7PQVFhZmldGRUv2Y?=
 =?us-ascii?Q?88eOSt/82CdevsKmJEwT/9/Wy1RSEmOuQQJ4+Oz3sEtciAv7m+0beNDZ1Gdl?=
 =?us-ascii?Q?9Z/yRZpdh9X8/fb27kYzfe1wMl8VpGt0fwfFn7iFsb9zSdYwz3QKe7Mkud0C?=
 =?us-ascii?Q?jX57f/VwpYVQ91t+fxWrCfZELhvnWspuHfHWNU8IaElC4kvv8j2EvKUMDSMk?=
 =?us-ascii?Q?1kmDdonS+IPi8cb24R6mTRcZpAR+1EThwQQ67g1OLNjdtEk914aR8AnaDO0K?=
 =?us-ascii?Q?nGM+mwm9o+6kplBa/9gVBoI3/hZ8hdN+rmvFztew0YElubBEuEnrJN0bQ/vb?=
 =?us-ascii?Q?ZBJ6jfRs/hf9egLHV2TJ+DQClinPwz//eeUFSX3PbsVZrPuM8sn1ppfejyK/?=
 =?us-ascii?Q?IRT8JVx98nlRugPhK4ARk683NXaiV95tgLmvTbG20Discful689URr5gZ8W9?=
 =?us-ascii?Q?mJ01XIiJhk8+DMo3k92A3YkFGmzFtKgiu1mO7OcsuBB0zpR1eLiR7qbDQQrp?=
 =?us-ascii?Q?5Nr/NRsxptz3sfm2p7w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72590d94-6890-47e7-5d1b-08d9a929da65
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 17:52:27.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +f6GCJDZH/wwGgnB/CiNwhr10RnepikaO0/pGlFsgC2iXKnJ4tVo+1383mhn6leS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 11, 2021 at 01:45:00PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Preset both receive and send CQ pointers prior to call to the drivers and
> overwrite it later again till the mlx4 is going to be changed do not overwrite
> ibqp properties.
> 
> This change is needed for mlx5, because in case of QP creation failure,
> it will go to the path of QP destroy which relies on proper CQ pointers.
> 
>  ==================================================================
>  BUG: KASAN: use-after-free in create_qp.cold+0x164/0x16e [mlx5_ib]
>  Write of size 8 at addr ffff8880064c55c0 by task a.out/246
> 
>  CPU: 0 PID: 246 Comm: a.out Not tainted 5.15.0+ #291
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  Call Trace:
>   dump_stack_lvl+0x45/0x59
>   print_address_description.constprop.0+0x1f/0x140
>   ? create_qp.cold+0x164/0x16e [mlx5_ib]
>   kasan_report.cold+0x83/0xdf
>   ? create_qp.cold+0x164/0x16e [mlx5_ib]
>   create_qp.cold+0x164/0x16e [mlx5_ib]
>   ? lock_acquire+0x1a9/0x4a0
>   ? __might_fault+0x8f/0x160
>   ? lock_is_held_type+0x98/0x110
>   ? _create_user_qp.constprop.0+0x18a0/0x18a0 [mlx5_ib]
>   ? rcu_read_lock_sched_held+0x3f/0x70
>   ? __module_address.part.0+0x25/0x300
>   ? is_kernel_percpu_address+0x7d/0x100
>   ? static_obj+0x8a/0xc0
>   ? lockdep_init_map_type+0x2c3/0x780
>   ? __raw_spin_lock_init+0x3b/0x110
>   mlx5_ib_create_qp+0x358/0x28a0 [mlx5_ib]
>   ? create_qp+0xc210/0xc210 [mlx5_ib]
>   ? __module_address.part.0+0x25/0x300
>   create_qp.part.0+0x45b/0x6a0 [ib_core]
>   ib_create_qp_user+0x97/0x150 [ib_core]
>   ib_uverbs_handler_UVERBS_METHOD_QP_CREATE+0x92c/0x1250 [ib_uverbs]
>   ? _uverbs_copy_from+0x120/0x120 [ib_uverbs]
>   ? lock_downgrade+0x6d0/0x6d0
>   ? lock_acquire+0x1a9/0x4a0
>   ? __might_fault+0x8f/0x160
>   ? ib_uverbs_cq_event_handler+0x120/0x120 [ib_uverbs]
>   ? uverbs_fill_udata+0x103/0x510 [ib_uverbs]
>   ib_uverbs_cmd_verbs+0x1c38/0x3150 [ib_uverbs]
>   ? _uverbs_copy_from+0x120/0x120 [ib_uverbs]
>   ? __kernel_text_address+0xe/0x30
>   ? unwind_get_return_address+0x56/0xa0
>   ? xfer_to_guest_mode_handle_work+0xd0/0xd0
>   ? uverbs_fill_udata+0x510/0x510 [ib_uverbs]
>   ? __lock_acquire+0xbec/0x5a40
>   ? kmem_cache_free+0xb1/0x2e0
>   ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
>   ? kasan_save_stack+0x1b/0x40
>   ? lock_acquire+0x1a9/0x4a0
>   ? lock_acquire+0x1a9/0x4a0
>   ? ib_uverbs_ioctl+0x11e/0x260 [ib_uverbs]
>   ? __might_fault+0xba/0x160
>   ? lock_release+0x6c0/0x6c0
>   ? ib_uverbs_ioctl+0x19c/0x260 [ib_uverbs]
>   ib_uverbs_ioctl+0x169/0x260 [ib_uverbs]
>   ? ib_uverbs_ioctl+0x11e/0x260 [ib_uverbs]
>   ? ib_uverbs_cmd_verbs+0x3150/0x3150 [ib_uverbs]
>   ? kasan_quarantine_put+0x78/0x1b0
>   ? trace_hardirqs_on+0x32/0x120
>   ? kasan_quarantine_put+0x78/0x1b0
>   __x64_sys_ioctl+0x866/0x14d0
>   ? rcu_read_lock_sched_held+0x3f/0x70
>   ? do_sys_openat2+0x10a/0x400
>   ? vfs_fileattr_set+0x9f0/0x9f0
>   ? do_sys_openat2+0x10a/0x400
>   ? build_open_flags+0x450/0x450
>   ? vfs_write+0x470/0x8e0
>   ? __x64_sys_openat+0x11f/0x1d0
>   ? __x64_sys_open+0x1a0/0x1a0
>   ? lockdep_hardirqs_on_prepare+0x273/0x3e0
>   ? syscall_enter_from_user_mode+0x1d/0x50
>   do_syscall_64+0x3d/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7fdafc4f2e0d
>  Code: c8 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3b 80 0c 00 f7 d8 64 89 01 48
>  RSP: 002b:00007ffc1e7ee158 EFLAGS: 00000286 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 0000000000402b40 RCX: 00007fdafc4f2e0d
>  RDX: 0000000020000980 RSI: 00000000c0181b01 RDI: 0000000000000003
>  RBP: 00007ffc1e7ee170 R08: 00007ffc1e7ee260 R09: 00007ffc1e7ee260
>  R10: 00007ffc1e7ee260 R11: 0000000000000286 R12: 0000000000401050
>  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 
>  Allocated by task 246:
>   kasan_save_stack+0x1b/0x40
>   __kasan_kmalloc+0xa4/0xd0
>   create_qp.part.0+0x92/0x6a0 [ib_core]
>   ib_create_qp_user+0x97/0x150 [ib_core]
>   ib_uverbs_handler_UVERBS_METHOD_QP_CREATE+0x92c/0x1250 [ib_uverbs]
>   ib_uverbs_cmd_verbs+0x1c38/0x3150 [ib_uverbs]
>   ib_uverbs_ioctl+0x169/0x260 [ib_uverbs]
>   __x64_sys_ioctl+0x866/0x14d0
>   do_syscall_64+0x3d/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
>  Freed by task 246:
>   kasan_save_stack+0x1b/0x40
>   kasan_set_track+0x1c/0x30
>   kasan_set_free_info+0x20/0x30
>   __kasan_slab_free+0x10c/0x150
>   slab_free_freelist_hook+0xb4/0x1b0
>   kfree+0xe7/0x2a0
>   create_qp.part.0+0x52b/0x6a0 [ib_core]
>   ib_create_qp_user+0x97/0x150 [ib_core]
>   ib_uverbs_handler_UVERBS_METHOD_QP_CREATE+0x92c/0x1250 [ib_uverbs]
>   ib_uverbs_cmd_verbs+0x1c38/0x3150 [ib_uverbs]
>   ib_uverbs_ioctl+0x169/0x260 [ib_uverbs]
>   __x64_sys_ioctl+0x866/0x14d0
>   do_syscall_64+0x3d/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
>  Last potentially related work creation:
>   kasan_save_stack+0x1b/0x40
>   kasan_record_aux_stack+0xc7/0xd0
>   insert_work+0x44/0x280
>   __queue_work+0x4e3/0xd30
>   queue_work_on+0x69/0x80
>   tty_release_struct+0xa6/0xd0
>   tty_release+0x9bb/0xef0
>   __fput+0x1fe/0x8d0
>   task_work_run+0xc5/0x160
>   exit_to_user_mode_prepare+0x1d4/0x1e0
>   syscall_exit_to_user_mode+0x19/0x50
>   do_syscall_64+0x4a/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
>  Second to last potentially related work creation:
>   kasan_save_stack+0x1b/0x40
>   kasan_record_aux_stack+0xc7/0xd0
>   insert_work+0x44/0x280
>   __queue_work+0x4e3/0xd30
>   queue_work_on+0x69/0x80
>   tty_release_struct+0xa6/0xd0
>   tty_release+0x9bb/0xef0
>   __fput+0x1fe/0x8d0
>   task_work_run+0xc5/0x160
>   exit_to_user_mode_prepare+0x1d4/0x1e0
>   syscall_exit_to_user_mode+0x19/0x50
>   do_syscall_64+0x4a/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
>  The buggy address belongs to the object at ffff8880064c5000
>   which belongs to the cache kmalloc-2k of size 2048
>  The buggy address is located 1472 bytes inside of
>   2048-byte region [ffff8880064c5000, ffff8880064c5800)
>  The buggy address belongs to the page:
>  page:000000006ea34cf4 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x64c0
>  head:000000006ea34cf4 order:3 compound_mapcount:0 compound_pincount:0
>  flags: 0x4000000000010200(slab|head|zone=1)
>  raw: 4000000000010200 ffffea0000571c00 0000000200000002 ffff888005042f00
>  raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
>  page dumped because: kasan: bad access detected
> 
>  Memory state around the buggy address:
>   ffff8880064c5480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8880064c5500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  >ffff8880064c5580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                             ^
>   ffff8880064c5600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8880064c5680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ==================================================================
>  Disabling lock debugging due to kernel taint
> 
> Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/verbs.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to for-rc, thanks

Jason
