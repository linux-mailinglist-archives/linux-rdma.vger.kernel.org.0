Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F076EAE2C
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Apr 2023 17:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDUPjh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Apr 2023 11:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjDUPjg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Apr 2023 11:39:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763AD19B2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Apr 2023 08:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ModB5FeYCxYYNU8ch5PxrQfbP35cokr55ZO/7Px00E4XgyHa1OHlKo0tb0WwiDTHMm0tCFYdfc/UlZ81YUKb1wpRcoivNFXogliQECruVdCyhRGyrca1PWFv3jiOssbBRfVsT/8hhKNC2Lod45eoIekp90MgWeUNkQGhQfNrZVBZgz3DBz/A2dBfJCPm1w254h5ghLQSN90r514sJCSeiTVFz880sUrhG7Or6wGUXPH+RLV/8PpAMNEv2LHABIOMJ7KOxBmyZcw2duMykBA3KjhmvwFWNw9osqpdmZJtuTpONItHGQ83lDCE9fMiNfe8J1PBroCrYgPgPO9MZHYZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLJaMLNoPMTw0uPf922JzaRLG7gAgyXpxr+5LVN+Ht8=;
 b=oC3WC85TUVDO6BVY8c19DkfQ+ODd7jRltuUrueD4YkcFmwzE20UPAPZURMhpOGI6UON9IdB/6uew08dGqNMMkNp6F9JNFjPwAzbwlqv9WpV7Daimt706e5A2Bild/HhNVVeVGj+in3Z17c5HIOBVqXCfkMg+iNh3LB5iSgLbRYyA3S3eZLHjZMbj6lUeatvTR9aVh5Z2BqhzGdb+rcE+TG94cs8kEMW8JIaM/v889t7gTHjejGdJJlgiVKVxlq9Rfq4DlY/h3O1peZ+qyOM16osqvYv5yBHbesX9pf82O+qIyrOJSc7C+xLiWxtIkb2fzvrESDlHibuLYugeaZajtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLJaMLNoPMTw0uPf922JzaRLG7gAgyXpxr+5LVN+Ht8=;
 b=gdpPZGcnoPV02EocQMEpPGfJ14PTrNVdE7E/YWeNmCQc5CvKM1DDhnmusD1rU/T9/BgVM+lN5VIhghvQJvMc3WdQFbGZRlrGVgF2RZfssLUteQkSRErk+r36p2WIbjHA7oLTzfeQVlFt95HTUGxaum/VClEtdz/yf3YzbAsVqy7hW4st65PMTDU56WSnwiJoD1JTINq8IZApCizhPSifwrHpPM5cMNt7SKGYZf4OPtqU71rkjRyaGkPToV5YnqupjiQSNdBx4gamH510wJA/saYYsNQgitw7KJpM0A0h5yHWFxJSxPply3igS9JfzyKao7f4er3n09B+uHCmzYzV7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 15:39:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Fri, 21 Apr 2023
 15:39:31 +0000
Date:   Fri, 21 Apr 2023 12:39:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com,
        leonro@nvidia.com, zyjzyj2000@gmail.com
Subject: Re: [PATCH jgg-for-next] RDMA/rxe: Fix spinlock recursion deadlock
 on requester
Message-ID: <ZEKuMc3o4hA6KPBL@nvidia.com>
References: <20230418090642.1849358-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418090642.1849358-1-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BL0PR0102CA0058.prod.exchangelabs.com
 (2603:10b6:208:25::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b93d9f2-d2e7-419e-fdba-08db427e99b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ohkH1FJp42MIy4h8GgFRyGp9wpjgvXQ4bqVTm2712GyAePk/j1Nlf094NJSHigIO0kTaIjWBZ1atQ6a5JmqwwOoKkawkAWtDiBastg1nqrgExdbobMUMovz5hncVP3Il1O/+xTdtyMD6fyIP+7Rpqz0M2AV8l8JQI6JXJzjwLeAwoY50D8hNeWyu+8T+qemA1dToEMHHYfnZHurmtypZ5hssOUTtc5k+wz7FRpRAURgmjh4sYUsDMrsM1XzApbOqyYp3r738QIJxdYp3q2k4vACkBOhpDi1uQY9YdqTG7a/jVsbrZrQbnJjWT/OYW34//eG13u9tfcBO0tOCJa20S32VjEhJ8FcrJWbh6aOLOYvOnR5BgG1B3Rz6TMscbixIQDoJ0rUJn2j1EjrB1ns4jMBQ/QvRBCvxo/6VxbOhbRNHU/Uhx/l2BLOnnSrJKJdi5rxFPBp9CLoULtXn9zVOcCIlJ1lcvKsjn8mbPJWm9e51x8e1kO+r4QtakIQ9LMvxMuNYGOJgSaY6/N/SI7WSfnCXmdO1B5OXC12WpNiH4YE255Jdc4Rtu8xxv6ZSd2nY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199021)(2616005)(2906002)(38100700002)(86362001)(478600001)(316002)(41300700001)(66476007)(66946007)(66556008)(4326008)(6916009)(26005)(6512007)(6506007)(6486002)(186003)(36756003)(8676002)(8936002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kPu41YB6GpPS/2ZXl+P2qjHDqs+nQm46VqYYS9gpQIDyoYYtMDqG89KZfPUE?=
 =?us-ascii?Q?o3qdCuGBdcYatT1MyPHYc7YOXwpDB6PopYcfG75omHsnE4YTSuOP7EiegAju?=
 =?us-ascii?Q?ad5z9v+UtaPU0bAC3lSOTMyGy5w9yGRbCYHlJ3QpKQIcUz8dMvs6NTMwPHj7?=
 =?us-ascii?Q?kJ+Wc1T9JOikzab/N5ugNbH0EUEtH5oTV/9ly/W1onUhubA4Q0DwLttXC69D?=
 =?us-ascii?Q?fUn+WO9PSOoNl1XSc5yjcm31ebSZDyoNmmgKpD3RQJM39nQRnLp8snZWJ/dV?=
 =?us-ascii?Q?v6tqMoXx79eJxHx8yg2ihy6/ZT9tHOSIR1aPFUZBIYqJq09ruNSj21cYH72q?=
 =?us-ascii?Q?9xwCLCLzF4vf8YgRcXdrqUzAlzr+82lKdO4B6Ouu5SGSop0TpUDkVAAZNQbB?=
 =?us-ascii?Q?uHOoVQMHj107D66zKWGUH+kCYYIgv74cH2kbikKJM00J43a9b/mUeyg42FnQ?=
 =?us-ascii?Q?Xlcbjd1cDwrN1qnI6J0CY6TyuaPAwIfIsirU5WV4KE6Dxxil3I02DDUJvjsa?=
 =?us-ascii?Q?holT2HX2Huwsac6tOtXjBe1MGbPd9mi5+mr0l0JBwjMp6WUfurmHr9YeVxLG?=
 =?us-ascii?Q?5xj7FKELF/4j7H0NPV7utqKJFPu3lo+X1D5vPPeTMcHCqDYfDW9NsYbUNjTX?=
 =?us-ascii?Q?VeIXoDWXGpzXlggVeQh4RsBitI6+Je3Y+o2AfqEA4Wm2JxyWSsqND/XuUJqy?=
 =?us-ascii?Q?vt4N4wq47/CC55tRfOI46eGEdZ2sOSN9JaJoe2qVSRBjcB/zu4ggpSINXrW0?=
 =?us-ascii?Q?zhKlsEPS1f2qPcImIKp5HRskoGPRYvOlWNugZQx2Tgj2pRhhAw6dBQvKlVPR?=
 =?us-ascii?Q?4/H+ipUl4CZRPxG5mnTVekuq+M39X/qc6vIHEeprEwqOUIuktAMBOBsToocW?=
 =?us-ascii?Q?pk7Wf4XzDsCA5ZPRMe9T9BWc/vXXhNFHOhZ46IKWtQeUWs25IOjMSZtxcLZi?=
 =?us-ascii?Q?SctcadfA6qjIyfC253g91alab6hgw6Fi69r4xIN3VqQQQkDmj4VAdlvPiKVJ?=
 =?us-ascii?Q?SY2HE9hE/pye6JnUqYw3oRX/T5y06AtenQVlUrCiz4+Ym7dWY+KAbk4kmfBQ?=
 =?us-ascii?Q?1UKulhDCLCt/p27/NhofzzmppvvnJFw/tEBkhunmRuBcWCXmostvVB+ZE7SD?=
 =?us-ascii?Q?h/pJrIsdTyCU1q/JwfSTfI/P6YzGStnbMJYYXiZHsFuRjkZaisKl9ISfj1Gi?=
 =?us-ascii?Q?ywOX4aXAeZP3+oN3Pg21AMhUSENDBU7zK/Yx/4bCYxQZYzZNNinIDsCahDEb?=
 =?us-ascii?Q?VoeDHqDeQBUIfm5yUUycLt1NV9EulDQBcUk7mGr9j+ThoeFtEZjNFTm+UKxd?=
 =?us-ascii?Q?FvkNbQGOS8/2XRZyNhuwU2d0zG1Ljt1DXMzFOsDtccLpwDo4NmH3rQySpAm7?=
 =?us-ascii?Q?umxcri1FAOGA3be7Y2aHzkz31oFB6kl5/NyNU8hT81Z78dyULjXSG3VqUcJ4?=
 =?us-ascii?Q?cw6jYVegMvpx9lIA+cBk7oRun/xEu3sOVl6wHnT6X5g5swwUEDoPMose/77y?=
 =?us-ascii?Q?dHaqBIOM1/Gbe+S+HYewyP1jUi6GBU4Io88ZsX9HmByNHzXb60bWXJM9wlPQ?=
 =?us-ascii?Q?f0KIQbY5tScgrnZ77oh3UgVBnYoZeWxWcHedmB0Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b93d9f2-d2e7-419e-fdba-08db427e99b4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 15:39:31.6837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgrtM4tpHtHo+RaF/SsnpGIAsY3zZOh7n0irydgG6P3DwRAUALA/Efd9I9sDt0qp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 18, 2023 at 06:06:42PM +0900, Daisuke Matsuda wrote:
> After applying commit f605f26ea196, the following deadlock is observed:
>  Call Trace:
>   <IRQ>
>   _raw_spin_lock_bh+0x29/0x30
>   check_type_state.constprop.0+0x4e/0xc0 [rdma_rxe]
>   rxe_rcv+0x173/0x3d0 [rdma_rxe]
>   rxe_udp_encap_recv+0x69/0xd0 [rdma_rxe]
>   ? __pfx_rxe_udp_encap_recv+0x10/0x10 [rdma_rxe]
>   udp_queue_rcv_one_skb+0x258/0x520
>   udp_unicast_rcv_skb+0x75/0x90
>   __udp4_lib_rcv+0x364/0x5c0
>   ip_protocol_deliver_rcu+0xa7/0x160
>   ip_local_deliver_finish+0x73/0xa0
>   ip_sublist_rcv_finish+0x80/0x90
>   ip_sublist_rcv+0x191/0x220
>   ip_list_rcv+0x132/0x160
>   __netif_receive_skb_list_core+0x297/0x2c0
>   netif_receive_skb_list_internal+0x1c5/0x300
>   napi_complete_done+0x6f/0x1b0
>   virtnet_poll+0x1f4/0x2d0 [virtio_net]
>   __napi_poll+0x2c/0x1b0
>   net_rx_action+0x293/0x350
>   ? __napi_schedule+0x79/0x90
>   __do_softirq+0xcb/0x2ab
>   __irq_exit_rcu+0xb9/0xf0
>   common_interrupt+0x80/0xa0
>   </IRQ>
>   <TASK>
>   asm_common_interrupt+0x22/0x40
>   RIP: 0010:_raw_spin_lock+0x17/0x30
>   rxe_requester+0xe4/0x8f0 [rdma_rxe]
>   ? xas_load+0x9/0xa0
>   ? xa_load+0x70/0xb0
>   do_task+0x64/0x1f0 [rdma_rxe]
>   rxe_post_send+0x54/0x110 [rdma_rxe]
>   ib_uverbs_post_send+0x5f8/0x680 [ib_uverbs]
>   ? netif_receive_skb_list_internal+0x1e3/0x300
>   ib_uverbs_write+0x3c8/0x500 [ib_uverbs]
>   vfs_write+0xc5/0x3b0
>   ksys_write+0xab/0xe0
>   ? syscall_trace_enter.constprop.0+0x126/0x1a0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x72/0xdc
>   </TASK>
> 
> The deadlock is easily reproducible with perftest. Fix it by disabling
> softirq when acquiring the lock in process context.
> 
> Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
