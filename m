Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FA071F0D6
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 19:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjFARdL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 13:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjFARdK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 13:33:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5B7134;
        Thu,  1 Jun 2023 10:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcZVE0/j5rW172lYkaZYvlLsbObIbtNFUHRZPcockM7oVjJp8x8FyLoGck3l3IhmeLkmgCuy7LFzTtksPOMCALeAzFM/v8ZyFSuqdAYpH60fnO+QRWh1xkaLq1tgGoLCPJnuxAvcACkwPI+0H3n+EQ8OliIBX9hdJD4K017xT6l3m7kN6YvYe1Az5OnHxy6+4goxWancoWUxQWGVTfeRe/q+B5VGTag8BL0ycOoF4lvvhFE/6EToIFwsHPrrhGJxXMFt5MM/tSXdsHSNskz8mgS/tvsfsTmABDOiORWPS/ysvl1OxRa2kc4k9ekfD/4yGLpBhhu3tTzMIUPgixp68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1kYD0+rHW23MPEdimxsHzdxyle2+HxNGyw9SxMpee8=;
 b=hwFmHus/Cm7/QRGxHjc+E+Ahs7bMP6gru/nwmnNGTHwZTlCGPfnsScIVwmQof3+fvedvghsTCp38sDAp3E7lKdPjF6h22LoIbHRz8VlcjVQ5cuZ5/aZi0D/jZuCyuF1P3RWmyQPX/IEE265Zbel7hhqHmJvOz7RnUN4YPSCEP39mOv2RJYrZYK3H/NKTqMhMdU3DxE8NDMQsk62XmctfGJ+YrRnGMAhFp58H8OK6Ti938q48CWsr+lei4sM4U0MEKYfwOcgX+5VI3OyOxyHK/aaJfZsZ4NG7sfWOe3xPWKw5cxdt61l9ff0Gv57iwA40Mm3mSxfnygGtlNDlg8UNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1kYD0+rHW23MPEdimxsHzdxyle2+HxNGyw9SxMpee8=;
 b=MpeG1XhWrkdFDltBm6EpbfpzdlFI6UYAMpQ/rZT2ejhoOrZsaOucrlat3pE18uWjLyz5ztjWYUOChiT1Hq7dFSvDWDdyIxebAcobqZt/kS0Urs45lu2cXj+DJa7Z6OzwCb3agloUyLYh2Lqsn3AJsPi3L5Ne5FIqUHp1d+IuYQo/TsFjTbt5azRlMEEwGnMF6i87Oa1ATO1Os0KV3RzO5wrtt9ao+WVwmEKBDhm7LlbYoQ77gF+jwXzEYKyXevwJjPEIcTMm711thlZ/40lpRDEfjSAueyP3YOtTW6u2WC30AOM3TmZHclKs+RVhF1loQ9OOuw6YcJY9RX71VnnXsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 17:33:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 17:33:06 +0000
Date:   Thu, 1 Jun 2023 14:33:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        linux-rdma@vger.kernel.org, leon@kernel.org,
        guoqing.jiang@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next v3 3/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Message-ID: <ZHjWTyW3our+RTCw@nvidia.com>
References: <1682384563-2-1-git-send-email-lizhijian@fujitsu.com>
 <1682384563-2-4-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682384563-2-4-git-send-email-lizhijian@fujitsu.com>
X-ClientProxiedBy: SJ0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 977373ee-6855-45b1-e2b0-08db62c64278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhEW8Z3uyX7iBbbuk/AI2WeFIUd/SwdEMrqrW4TpIAoELdAqgo2j+nGVb2CWgiNocfa/BDZ6888IK7gp8glarPR9mu3wZjxyzC3Zi9cWSObfTgvceJlG89hWSb6VEFBjYbNyUMERpfzL3zxz7Crbj6kUsj0kEzgStW4P44xrfUKt88A4vo09w0MIPPyHipKIfBx0RSo4OyP/WzmNsOcSU8Oei+NRMSSr/3ENwRRlnAH3jspoKzjyTPhwcl7YJo+zXOWDiN+S8QIcbDBJfQvfzE+UpT4UUewCTekvLwPQPcq33P0XodT0hx6MkSCchZ/lEGJ9jAcHKpEaFNQs0uRNtnfzgowNDKDDGMXRZh30HOomeMxxXIE75rn/HD2GZODkKhEpH1e+KkKUIvmyRvrr93T8wD90zxWQk1Fah2/EZt4hY3+ufhRyhy0WqI4doUaGvyWhHo3c3OTHqC6jqCl3+wdBqTXlJK7Y+JEz4el7esLRnZ8qmS71k5D6PJiN1JiSSsBsv5/clTGMaDqyBdNLv6OJ7ay92oSaP+u94aquPv4LmiYv8imVN1jjbL1Rg74R5J2rL6ng8c1v1Kt3OuP1OaVhMGpeLAr6IfjS0cZRAiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(45080400002)(316002)(66556008)(478600001)(6666004)(66946007)(66899021)(6916009)(4326008)(66476007)(6512007)(26005)(6506007)(2616005)(8676002)(41300700001)(8936002)(2906002)(5660300002)(186003)(83380400001)(86362001)(38100700002)(36756003)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mWXurYmlaKFZ5nur14KfaAXlZANx2nEqJAF91CDQwQs87t2m3us83FrcXWNy?=
 =?us-ascii?Q?9+b2v+V1cHdb/qwaZ7giOnWQ9jBA8wSq+9zX8IhOBqPFNsbN1VvId+X54OND?=
 =?us-ascii?Q?R0pDPL7gARhIP8WfrQgseG1vEVV9zTaYNGHQp6syg3A8zvdHLzqhy5tPBGaD?=
 =?us-ascii?Q?2JzzVc0hIID3Q2DOxK3NiK3bad25UVeM7aHVm94TV26HYcT0Pv+JrpcqYkZq?=
 =?us-ascii?Q?raJiLpcmsS7CZnUwALOSKYYQd/7Ob81Y1ksLYV2yEQ7o/kn4WsjooTJmLTMt?=
 =?us-ascii?Q?AmRn8mCgePsyRr7U4VcMNMnKLxaDl4J38wKJfZmx/A9Py2qwmY4J0sSHwLkW?=
 =?us-ascii?Q?OIYGN3jqXD1scHtf8dpT3Hsu7hTUOIvHzUvulaICh4sZOG5U3FjzRvUCkgBA?=
 =?us-ascii?Q?BqmRW6tS0JekLsuQC1G2vgjVfqDzPdEscLEgmzJ2CuzkfiwK3MNL9z+TnUu5?=
 =?us-ascii?Q?xryjKkWHgsP18FctfY6w3BGpd6GX4fiVX5brYai9Mmg9N1lf9GmN8v41WC0p?=
 =?us-ascii?Q?edsh0sSqpc6tLyCCkw4kakFW9UWxD5QZ0OsWGO+TiTUPLql8gh2RBroUPmCK?=
 =?us-ascii?Q?pqB/9go5Oz6PtKErOgLxuWzPbZIfLNdN535n4hyMR8MLytOxmdeim62XkNAm?=
 =?us-ascii?Q?cYdzJtU4OweAHAnm3gXGv6xZoqp6p18iM4s8f9eofqkOsMIpuVH6XAy51sgh?=
 =?us-ascii?Q?aJqwR2JXul9tcTZLHGjCIjIbjdIE8es0/rfX+juJ+huwF2QeYWJlSY1UDKou?=
 =?us-ascii?Q?HpSLra04Qm9VrFhJbowAVcxtnvTlrQy6W7W7Jnf8mEL/7k6GCdoGTyWYamFr?=
 =?us-ascii?Q?3YTdzIGsVIOnQMNqlBlb6rHRqFkA4ONrP8n1aKcRObrbUk6cwS4qYOUgvGpo?=
 =?us-ascii?Q?VV1Rl/9b7Y77bZnG7uihMWNVnm5mAMC9sv9ojU/YtoUTsYOFdMXCZHKeTp39?=
 =?us-ascii?Q?uzmOx/xIEoIZ5Ecu36C53U1nOQVgPwclqHBPmlUwEY+3+TtnxkjeQ+68L6az?=
 =?us-ascii?Q?8TfdYwXgPIQQy25TAr+F4VHQydK00P8dahHVgPVzpBK2OkG5VLECBiuaR3cX?=
 =?us-ascii?Q?gp9YDGJG4RrpOcVN3d48qI/9iCxGHCU8xFhFTLjpDj5mbkpFHajrUr/D+cWg?=
 =?us-ascii?Q?oslFXUcqi+usyYj5PtVUlHZO4y7F8AGilytBwF0UXYDm3FbfNWzA8quNFQNg?=
 =?us-ascii?Q?Tw48caqsLBCtNsqUOGI0v/2k9Dd7zY0vCaiR6UAdTAM1wnjYd1Cl9bhmmlmM?=
 =?us-ascii?Q?jTZ9nATAwKciY/RW9vExHrbUoYJV3B+4emZoM8lx6p2ZF+Y63cDGhyitbOPM?=
 =?us-ascii?Q?W416mGaAO+Yd46Av0niznz0Wu9h97iqL8PzMHoWJqHC3Z/FsgmR1Z2Q8ll/s?=
 =?us-ascii?Q?ZezLJfdvTgp/RuUVaemGWherd+xWd9EqCZt/xpW7WD1E1JtDVfKUbSHn6fLw?=
 =?us-ascii?Q?jzh5aDej2a7NNT75AS63OIF8KyJLyepuzHL4Tb33oOWurVo3MFUknVoKggMq?=
 =?us-ascii?Q?Yp6G5OgKDH7nTJ7VTJHU9bJKMs+NOWzilD7df5Er0gYrgnSd8k82gJxGZNVD?=
 =?us-ascii?Q?LueJH0kNVNnowbGueEquSPI6DzxmarwqHdIlFff7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977373ee-6855-45b1-e2b0-08db62c64278
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:33:06.3529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBvmIk2pv9f7EQP+TVB8HthSxQRslCYK9fo4oISddUaXJhrMVXNuABQGQyClYD1e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 25, 2023 at 01:02:43AM +0000, Li Zhijian wrote:
> In current design:
> 1. PD and clt_path->s.dev are shared among connections.
> 2. every con[n]'s cleanup phase will call destroy_con_cq_qp()
> 3. clt_path->s.dev will be always decreased in destroy_con_cq_qp(), and
>    when clt_path->s.dev become zero, it will destroy PD.
> 4. when con[1] failed to create, con[1] will not take clt_path->s.dev,
>    but it try to decreased clt_path->s.dev
> 
> So, in case create_cm(con[0]) succeeds but create_cm(con[1])
> fails, destroy_con_cq_qp(con[1]) will be called first which will destory
> the PD while this PD is still taken by con[0].
> 
> Here, we refactor the error path of create_cm() and init_conns(), so that
> we do the cleanup in the order they are created.
> 
> The warning occurs when destroying RXE PD whose reference count is not
> zero.
> -----------------------------------------------
>  rnbd_client L597: Mapping device /dev/nvme0n1 on session client, (access_mode: rw, nr_poll_queues: 0)
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 26407 at drivers/infiniband/sw/rxe/rxe_pool.c:256 __rxe_cleanup+0x13a/0x170 [rdma_rxe]
>  Modules linked in: rpcrdma rdma_ucm ib_iser rnbd_client libiscsi rtrs_client scsi_transport_iscsi rtrs_core rdma_cm iw_cm ib_cm crc32_generic rdma_rxe udp_tunnel ib_uverbs ib_core kmem device_dax nd_pmem dax_pmem nd_
> vme crc32c_intel fuse nvme_core nfit libnvdimm dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_mod
>  CPU: 0 PID: 26407 Comm: rnbd-client.sh Kdump: loaded Not tainted 6.2.0-rc6-roce-flush+ #53
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:__rxe_cleanup+0x13a/0x170 [rdma_rxe]
>  Code: 45 84 e4 0f 84 5a ff ff ff 48 89 ef e8 5f 18 71 f9 84 c0 75 90 be c8 00 00 00 48 89 ef e8 be 89 1f fa 85 c0 0f 85 7b ff ff ff <0f> 0b 41 bc ea ff ff ff e9 71 ff ff ff e8 84 7f 1f fa e9 d0 fe ff
>  RSP: 0018:ffffb09880b6f5f0 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: ffff99401f15d6a8 RCX: 0000000000000000
>  RDX: 0000000000000001 RSI: ffffffffbac8234b RDI: 00000000ffffffff
>  RBP: ffff99401f15d6d0 R08: 0000000000000001 R09: 0000000000000001
>  R10: 0000000000002d82 R11: 0000000000000000 R12: 0000000000000001
>  R13: ffff994101eff208 R14: ffffb09880b6f6a0 R15: 00000000fffffe00
>  FS:  00007fe113904740(0000) GS:ffff99413bc00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007ff6cde656c8 CR3: 000000001f108004 CR4: 00000000001706f0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   rxe_dealloc_pd+0x16/0x20 [rdma_rxe]
>   ib_dealloc_pd_user+0x4b/0x80 [ib_core]
>   rtrs_ib_dev_put+0x79/0xd0 [rtrs_core]
>   destroy_con_cq_qp+0x8a/0xa0 [rtrs_client]
>   init_path+0x1e7/0x9a0 [rtrs_client]
>   ? __pfx_autoremove_wake_function+0x10/0x10
>   ? lock_is_held_type+0xd7/0x130
>   ? rcu_read_lock_sched_held+0x43/0x80
>   ? pcpu_alloc+0x3dd/0x7d0
>   ? rtrs_clt_init_stats+0x18/0x40 [rtrs_client]
>   rtrs_clt_open+0x24f/0x5a0 [rtrs_client]
>   ? __pfx_rnbd_clt_link_ev+0x10/0x10 [rnbd_client]
>   rnbd_clt_map_device+0x6a5/0xe10 [rnbd_client]
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Acked-by: Jack Wang <jinpu.wang@ionos.com>
> Tested-by: Jack Wang <jinpu.wang@ionos.com>

It would be good to have a fixes line for this?

Jason
