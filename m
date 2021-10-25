Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3A0439CDD
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 19:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhJYRHG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 13:07:06 -0400
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:43808
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234934AbhJYRFI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 13:05:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGXZ4LvZ7C/33lGD3SeJno+Fy7okLDRX9UBMSk7mb9UxPs72TvpHb2WWla6vumfG+4bsqroOxfUX6Kei6KvbjFPQ3j29cWK+T3lbMGwoNj5JNitQeFbQpgE9w4+xV0QMTQmw0YNAdSOlCEbZIhlMu2Uw5AjIK8GmblS5575IW4IrKQunaMLkFkGpFfmsJFoaNoMO27ztQif0lFXOJ/6nC1mD8XdOg89aYba5YT70jWYFLKaWIgGSCANQJ/mCh6WN0pkj+zZzL0oJ9Yo/at1bkKkTgwkd8xpF2beN2VA5tclxGzvyFVX83tDrmZbF63oDm5LJRrhlxe1Xb2uhLyjo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCXoaSN+TVzxoySHKLM/ir1sJPrcnDMTb4npq68WK54=;
 b=DHMH6lO70RDN8N1KUftqhly8/7n7sAa13ey+QBtXRH6GEzL8FGwbJPhzNwJSjdfjMRqGfnbZpNbuzY1uOVmgC3yMNnDBhD20KzMOE0kLz68GNHKCTWzOBrRY3hwkmm9sbRvIMXFjBtssa3h2zK7G5j7ABU7xIdxXxzmreuwGgbzessavnNIUryVarhCjryG3eUlIrZV5m45YJb3x6jLqukxoGeWx0cTt8iMYhlV08DwHd4Nw0SFeZ1KnUcEwS7/U5C8FM9ksXCY0HsoxZPAwq3z/vF26/6aQxPnMGmXcjOONbCU+tEYzOVnHpOr5N7PKt+/WpHLLzphjc9t5YR1D3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCXoaSN+TVzxoySHKLM/ir1sJPrcnDMTb4npq68WK54=;
 b=PfUEuOYFaXtfr1s5WRu6+kcT2XeWk99wsubEvGShgOpd/9Z75u9Xt/0/ev18xbIuDA6SieEJRI2c+jvlwWtCLtJU1N1OOAn36rpMSRPjc/i6I9l+eYxn8UP18L9htFH0Q4pzE1Fm50t8rT/4vxqu1PP2uFfxRhpcY8y7w9iVbFKw9i0VPJanwxbBl3JsZuSRK7TgeUflxxF7UmzGrd9UH9pzI9KluVQaDtN56Ai4xzzM79Z5e0czZIue6F2ZxYVsYF5k9xiCRHWNgRyfGN1gE/9TEvFSZ7xeF3g9ZoqfAyfh+Pf+iXiEAM2qKeYah5CDDH3+Ggnvad6G8V/KILARXg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 17:02:44 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 17:02:44 +0000
Date:   Mon, 25 Oct 2021 14:02:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Fleck <john.fleck@intel.com>,
        Kaike Wan <kaike.wan@intel.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Bloch <markb@mellanox.com>,
        Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH rdma-rc 1/2] RDMA/sa_query: Use strscpy_pad instead of
 memcpy to copy a string
Message-ID: <20211025170242.GA395634@nvidia.com>
References: <cover.1635055496.git.leonro@nvidia.com>
 <72ede0f6dab61f7f23df9ac7a70666e07ef314b0.1635055496.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72ede0f6dab61f7f23df9ac7a70666e07ef314b0.1635055496.git.leonro@nvidia.com>
X-ClientProxiedBy: CH0PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:610:e5::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0259.namprd03.prod.outlook.com (2603:10b6:610:e5::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 17:02:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mf3Mw-001evz-3m; Mon, 25 Oct 2021 14:02:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6682f63a-63e2-488a-8879-08d997d942fe
X-MS-TrafficTypeDiagnostic: BL1PR12MB5064:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50641AA5B2707C38BD7CA955C2839@BL1PR12MB5064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3T0X/4Wf6PE8hDrcSRoBuJjDXmLn7w3P1K37W7STQ5oz0tBIZHiOqUFaZ+KEd4EPejUiOBLed3UeO4xClKmMBhH0k106XoqqMW4lHaXRrUScWxjAnFLjfYJWhg2L3oJVglHq8lnXlicLH8KyeeV+hxL5ud3rM072JMBZdnp4EcHJAx5eeVMytH139b6r0mmcFjUh1oC5EDMDOghEudn3B9H+7hccl8FSDw5nqnYCMVOzulZqvO2OfCZKpA45gJB5EWdbmVtjT38ry8DFa/w1IKO/Sl6qZ7QInImM61BJOPS4RLiH/1QA+s+QwGc2CkL0+N0Dksny0GPUx93+oj9Zc753gBsG9IxZPovRK5aVE1hyFzxpuillRM0TUvdUMp6zoP4xgsb8w55G/6IVV2ZFGoATEHAXKxjKwgYu8mU9xfapeaRDdlJcglk415KRiq44ZlhfyA3yVUtLUEkqSBHLTrVm89R2DTLJcgz5hB1CTSe0ni5H+Ihgwf8dhWz1qetFXZPFxMNjnDJl2Ne0Pbxxe+N9oqf9O77V/j1f6sF4dbWjdXen3vhF4O0qI0WKK77foJe24a5uXRN0LFJDMKCNkbtbx2Gbw9Afkmi+MCD03ZhV4DkcOY+I3fHVhkRHm6P1OILwhX03TVeszwoEHkbCLeIC4tZnBRT0tRMHtwtygOOItBHmP9Lti/ltertwqwk0/78bX/nuxOWgD7r1keQ1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(426003)(26005)(36756003)(186003)(9786002)(9746002)(66556008)(508600001)(66946007)(2906002)(107886003)(1076003)(316002)(33656002)(66476007)(83380400001)(54906003)(2616005)(6916009)(8676002)(38100700002)(8936002)(4326008)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BaTSALWhUduHU5VdWkOEnJ78U1XpvwDjCQyMoBA/Mr0/Gl0g9eQrvTlABSSS?=
 =?us-ascii?Q?ZWRMce7Urr0vCoA8NmAczTo541gUgffDpXEVz64WN5DoYqawdgUWCTklXSLv?=
 =?us-ascii?Q?LTVuwrPBYY1MwI+5JXp1PQ+90YS9x+wdjKsJpNvrfVzAcZjwiCsrzHbLt/Sq?=
 =?us-ascii?Q?tYB8IRH8IcjKcyTdugVSmtH6QFiNgLFVoSknLtn9QH+ELqGeJMgnmpZzaUTY?=
 =?us-ascii?Q?mSCGVCFmeVXzGiNSVdoSgjxFW3+YwYHAEDRa9YnwIVBLjpfDGGr/Yd98UIfB?=
 =?us-ascii?Q?BK586UjG2amQl0rfvmX+KZUD5HW8KYhtFqs381zySvRM1gTeash1B6aOPA2J?=
 =?us-ascii?Q?Ql+M+CD6dIwcpUM9Zt5SpatMMOpcW27e0dqrefTq/b7RtVBs2uVVVDODe4Xz?=
 =?us-ascii?Q?LM7Roe+QD6hLuBORRcfCUyWfujXx+InTJDEzC2Wd7/zvq2+q1sjweDxMLVM1?=
 =?us-ascii?Q?q5dRNO882yKT/sXTo8SIa4erII03IivZ4eVEFdZIOajCj1j/kSbvqQzCjiOu?=
 =?us-ascii?Q?5aq9BOAzdG8sFFmmgI4bVbpWTrhW3oZuIEhSR0QGm/BFBIfjvHZQjLqSH4s1?=
 =?us-ascii?Q?gQYP92kDSCWbcLh7NUobeBZsC70xm9SMy3D1YplrXLRtC4LcC3n6t7g79Wip?=
 =?us-ascii?Q?ze4Dtuu8ph6P2VUVazj3x3x0iDu2v4DD8sQAvvtPv02aYBLADAZ7BPGUPmNT?=
 =?us-ascii?Q?6q6zY6FRvx2FkRAawva4LljMgudukN1P/yUvuf7s1xHLHhbuRGu9kkHiDNvN?=
 =?us-ascii?Q?d1FO4MjcgcViA4IkqQV1954YdOvKT+87uJwq+QgNqPSw9bK9CxnC+zs5WMfV?=
 =?us-ascii?Q?urT8mA6AJ3sRvME8a6g2HQQGG+XfYeaR2FVPgTYEgLSY+ErvczpvjriyBBmF?=
 =?us-ascii?Q?GrPOY6NjPQx/mqedCV0H0uJMYIP7mWtj3U4WQac19xl+OFQfkPB3+DDAEzJF?=
 =?us-ascii?Q?oUq8gXCE0IPxAif+SJFcRBbB3GGN0YEmDMNYKy6Hc8JrxJ31FC5B2mlOsM9I?=
 =?us-ascii?Q?xzHhoyVzJ72BSVU/JsbLhf+D3vGU5rjfL6ejhTcfGq2aNQLdfwq6Fkp0zuwq?=
 =?us-ascii?Q?DjQs372oItV72Sp/bWiTc9dnC3VKS+SnY6lMs3dA/93B+fgL+zyZHysRy8XH?=
 =?us-ascii?Q?SACdJmDTIUSdM59pcBnlcf/fnj6k08YBwOyJ43KZfXwi0zOd0p0bctNeVZJF?=
 =?us-ascii?Q?v8y2qG/9VzpzsdrYCphwVRpCoDRBApTwu+IJnF3lAJbZqJR6+UrU42dc/Zo/?=
 =?us-ascii?Q?KWQ4hGbzjwrjQB4Z0YZli+MlDH6WzL8IrcZNJhPw9Tp+1r+sgF+yWjw6FOOw?=
 =?us-ascii?Q?HyzT44clw6u0reLmi2Hmlzo++tGJA4uJr/rntGw0XtB95b3+q3lE7UPQcyAN?=
 =?us-ascii?Q?VSmTHkzH0nFN2wPFvrSqBXrLTkXeMUAE2GTFEAP1cNEcgzV5v0vpptu7gqSh?=
 =?us-ascii?Q?mOpo88Wiz9puedIi/3GQLPYSnuv4WEDMMogYzySCGggOexgIRybFBRMSztbK?=
 =?us-ascii?Q?oFLXQOQay1VtG0kN0MIH1syDFL/kPU2OPuzkPZXl1t+xfCHOd0D2fAiLj4B0?=
 =?us-ascii?Q?wWNSy/+zZhmgQZK8/Jk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6682f63a-63e2-488a-8879-08d997d942fe
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:02:43.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 354MUGifvPUP/Iucye/iRfeQstVfQi+WPzhnhyiGlDCNm8u/5WP6rvEwgQa2wPBz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 24, 2021 at 09:08:20AM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> When copy the device name, the length of data memcpy copied exceeds
> the length of the source buffer, which cause the KASAN issue below.
> Use strscpy_pad instead.
> 
>  BUG: KASAN: slab-out-of-bounds in ib_nl_set_path_rec_attrs+0x136/0x320 [ib_core]
>  Read of size 64 at addr ffff88811a10f5e0 by task rping/140263
>  CPU: 3 PID: 140263 Comm: rping Not tainted 5.15.0-rc1+ #1
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  Call Trace:
>  dump_stack_lvl+0x57/0x7d
>  print_address_description.constprop.0+0x1d/0xa0
>  kasan_report+0xcb/0x110
>  ? lock_downgrade+0xb0/0xc0
>  ? ib_nl_set_path_rec_attrs+0x136/0x320 [ib_core]
>  kasan_check_range+0x13d/0x180
>  memcpy+0x20/0x60
>  ib_nl_set_path_rec_attrs+0x136/0x320 [ib_core]
>  ? init_mad+0xf0/0xf0 [ib_core]
>  ? __nlmsg_put+0x9a/0xb0
>  ? ibnl_put_msg+0x90/0xd0 [ib_core]
>  ib_nl_make_request+0x1c6/0x380 [ib_core]
>  ? ib_nl_set_path_rec_attrs+0x320/0x320 [ib_core]
>  ? netlink_has_listeners+0x114/0x210
>  send_mad+0x20a/0x220 [ib_core]
>  ? ib_nl_make_request+0x380/0x380 [ib_core]
>  ? memcpy+0x39/0x60
>  ? value_read+0x20/0x80 [ib_core]
>  ? ib_pack+0x140/0x2a0 [ib_core]
>  ib_sa_path_rec_get+0x3e3/0x800 [ib_core]
>  ? alloc_mad+0x390/0x390 [ib_core]
>  ? __kasan_kmalloc+0x7c/0x90
>  ? rdma_resolve_route+0x37b/0x3e0 [rdma_cm]
>  ? ucma_resolve_route+0xe1/0x150 [rdma_ucm]
>  ? ucma_write+0x17b/0x1f0 [rdma_ucm]
>  ? vfs_write+0x142/0x4d0
>  ? ksys_write+0x133/0x160
>  ? do_syscall_64+0x43/0x90
>  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
>  ? print_usage_bug+0x50/0x50
>  ? lock_downgrade+0xc0/0xc0
>  cma_query_ib_route+0x29b/0x390 [rdma_cm]
>  ? rdma_set_ib_path+0x150/0x150 [rdma_cm]
>  ? lockdep_hardirqs_on_prepare+0x12e/0x200
>  ? rdma_create_user_id+0x80/0x80 [rdma_cm]
>  ? rdma_resolve_route+0x37b/0x3e0 [rdma_cm]
>  ? rdma_resolve_route+0x308/0x3e0 [rdma_cm]
>  rdma_resolve_route+0x308/0x3e0 [rdma_cm]
>  ucma_resolve_route+0xe1/0x150 [rdma_ucm]
>  ? ucma_disconnect+0x140/0x140 [rdma_ucm]
>  ucma_write+0x17b/0x1f0 [rdma_ucm]
>  ? ucma_copy_ib_route+0x1a0/0x1a0 [rdma_ucm]
>  ? __fget_files+0x146/0x240
>  vfs_write+0x142/0x4d0
>  ksys_write+0x133/0x160
>  ? __ia32_sys_read+0x50/0x50
>  ? lockdep_hardirqs_on_prepare+0x12e/0x200
>  ? syscall_enter_from_user_mode+0x1d/0x50
>  do_syscall_64+0x43/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7f26499aa90f
>  Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 29 fd ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 5c fd ff ff 48
>  RSP: 002b:00007f26495f2dc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
>  RAX: ffffffffffffffda RBX: 00000000000007d0 RCX: 00007f26499aa90f
>  RDX: 0000000000000010 RSI: 00007f26495f2e00 RDI: 0000000000000003
>  RBP: 00005632a8315440 R08: 0000000000000000 R09: 0000000000000001
>  R10: 0000000000000000 R11: 0000000000000293 R12: 00007f26495f2e00
>  R13: 00005632a83154e0 R14: 00005632a8315440 R15: 00005632a830a810
> 
>  Allocated by task 131419:
>  kasan_save_stack+0x1b/0x40
>  __kasan_kmalloc+0x7c/0x90
>  proc_self_get_link+0x8b/0x100
>  pick_link+0x4f1/0x5c0
>  step_into+0x2eb/0x3d0
>  walk_component+0xc8/0x2c0
>  link_path_walk+0x3b8/0x580
>  path_openat+0x101/0x230
>  do_filp_open+0x12e/0x240
>  do_sys_openat2+0x115/0x280
>  __x64_sys_openat+0xce/0x140
>  do_syscall_64+0x43/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
>  The buggy address belongs to the object at ffff88811a10f5e0
>  kmalloc-16 of size 16
>  The buggy address is located 0 bytes inside of
> 10f5e0, ffff88811a10f5f0)
>  The buggy address belongs to the page:
>  page:000000007b6da7b1 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88811a10f1e0 pfn:0x11a10f
>  flags: 0x8000000000000200(slab|zone=2)
>  raw: 8000000000000200 ffffea0004463040 0000001200000012 ffff8881000423c0
>  raw: ffff88811a10f1e0 000000008080007f 00000001ffffffff 0000000000000000
>  page dumped because: kasan: bad access detected
> 
>  Memory state around the buggy address:
>  ffff88811a10f480: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>  ffff88811a10f500: fa fb fc fc fa fb fc fc 00 00 fc fc 00 00 fc fc
>  >ffff88811a10f580: 00 00 fc fc fa fb fc fc 00 00 fc fc 00 00 fc fc
>  ^
>  ffff88811a10f600: 00 00 fc fc fa fb fc fc fa fb fc fc 00 00 fc fc
>  ffff88811a10f680: 00 00 fc fc 00 00 fc fc fa fb fc fc 00 00 fc fc
> 
> Fixes: 2ca546b92a02 ("IB/sa: Route SA pathrecord query through netlink")
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/sa_query.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
