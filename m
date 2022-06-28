Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E377955EDC4
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 21:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiF1TRi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jun 2022 15:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbiF1TRU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jun 2022 15:17:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D5537AAC
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jun 2022 12:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4IComUv/a78q7Uhr/IT2e4nlMdPOMaXsAGZgS5WYpQ1wij6fHpw1QWuMBMk5XMWji2tS/9hyQw9BRhsKCoCTWAGgQ8wRkAl9dPt00UiuUMFUyNREnbS6Se11CzPoqCmMrR76Cxx8SBkjdRzbalLwXp6bkaAux/ZG4bHD6oZVggqbGb6ZFhk0ihCRR1PwCVqraPda0RD8JN/MP54Xesy3tYboSg8jAKgenIPFaJiRLswqniE45x6SqWpPxd7PVvHyQZBosv+fnsPzJgBK8oZC9Hjhx7Is8vht4wnfEZh3L5U1SU3kJdW9/qiT7T8Z5FUgzmF579h9B9/AkGmTrVAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf9ArfbJercW/2HnvAEl6IvQC2x2Pi+awH423WUfTyo=;
 b=IltenuSPjD8aU7B0TMhOpnRaDPmRPF8KFGnIt2E4AWREFDvBsVtMdg/nWcX9TqCCKAbLLa/xelCOR+p5aK0Kl+4WZUB9wnBZcAISGIYxDTveInqMHqZrusmLbIuU3tfdv0P0TdADQ09MVwEK+svM77eDUfJNWOG3+Qo0WSzJhgnH2ZN7glrgQ1MxWgDGmj2WXy7otqUgC5If7vyjC7ykgTrZFdDN6UPZIlFwJanU3KkcvKeroT6XBf+g5UlmCxWo4RdMtHI8Hp/mZgTrtFZ+QLuNpMR6ZOm3VNeWqmJr3tCjWg8fd7LmbQ9aeTzPnDwe9LLhOKgjpvYowPUZSHyHww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf9ArfbJercW/2HnvAEl6IvQC2x2Pi+awH423WUfTyo=;
 b=A4uLEczodCrp0vmr6fEjClcT86AwRf/HA5tV9gxH7y+IhdSkiXU1KHI3lPRFLBxTlQTPkMfhjjhcSDJOC0wDb1GpIfyMLWiS8/4xnjb9H0I4LitleGr1hHeZu66UJPTUovybTHozMI0iG0pje8CWtcBqq0ngcihC3Ial5EF+xo2z0Y/4EX4tkUhHWYPCeP6iTK4G5bahsfhEOwEDM8Wl54t8jmq6zZkMcdJian4IRobPaxRXbphnbYuJxnkTym+jSqNG+q3QIlKe94LQtLb7guhE/2hGQIBXoxqA/8tcZjgLd0CcGdCAmaEuY3F+bMBj3yaX+JQnSubuv3XoMAVOAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB5513.namprd12.prod.outlook.com (2603:10b6:610:68::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 19:16:19 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.022; Tue, 28 Jun 2022
 19:16:19 +0000
Date:   Tue, 28 Jun 2022 16:16:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tao Liu <thomas.liu@ucloud.cn>
Cc:     linux-rdma@vger.kernel.org, saeedm@nvidia.com, talgi@nvidia.com,
        leonro@nvidia.com, mgurtovoy@nvidia.com, yaminf@nvidia.com
Subject: Re: [PATCH v3] linux/dim: Fix divide 0 in RDMA DIM.
Message-ID: <20220628191617.GA739557@nvidia.com>
References: <20220627140004.3099-1-thomas.liu@ucloud.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627140004.3099-1-thomas.liu@ucloud.cn>
X-ClientProxiedBy: MN2PR19CA0039.namprd19.prod.outlook.com
 (2603:10b6:208:19b::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b102160-e6a3-4383-f85d-08da593aadf0
X-MS-TrafficTypeDiagnostic: CH2PR12MB5513:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQkBUlXC+J9Seahk3kl8HqDsQ822P/t9xSMONkyQQcvH+hIAmE9Mz+mtCg6oO1Rcrfz1VMGY70eMcIZV7zjQny0weQL9F94CkFV1qKeNQoIKzEKopk42CbMnY3EQ761u1zut4MpnbMoH4fta7hhfs8FwIhn8Y4vzBEtAG/fWYi3UMCOSPcEK/8TdXcsfWdl3dgTJMs3l0y1ujOc4y4xXtp1jVhdPsb30OnSQsa5zqo3x1PGNiopeGiSF7z5xTfbQOLSDSWW3Kh7NGSOf0z1iobCVZ0RWaofLYo6CJwRdbMpethB3XhC/FBqMxqZgYQStkq9C7X5ZH1P36vPS0ZcpD2FA+k7ie4DdUr3+mGTEWTP9Gswn/EQsY7zHOqPGj9bcBlPvV01lYzWxbNpz/vx4zXYDHGzDe75NdzdQGKhECPUCf+KuihNPVjCyOQY0RWFGinTtIEDvNUPy7XaFcdX+Yv0mhYL+2jU/yWEEaZP1VWahJPhiBJ3YW/ZFzgu2saASwhBJsE5JI2hpCBOy1mJZ+68qhNgQAj5tjO3mbuMHsOQ9EQSsfqdBV+cG+CrouGrHzaa9PJQ0rKUeV+OaOsPkmZdOEHMJECB9Y9hhtXuv0FjEUlyTM5s/53NWYMTUUCVqys0sPi1jBLsWvwEBJiOj6SFZlQtBhiYDWvHdZUI1eu3FHObYOaU07XE89IfKAvJwvDtAx3I7vOmbMqWDe8zEqT/jPPSKxCQCPDc54oV0uF/0C0wbplT/xmLrsCxq63+/e2Nl3rzYUDlz3KH84HZhQqRPOtmiB+gyJl7ppQLhvBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(2616005)(38100700002)(33656002)(41300700001)(6512007)(26005)(5660300002)(83380400001)(1076003)(86362001)(8676002)(66556008)(316002)(36756003)(8936002)(478600001)(2906002)(4326008)(66476007)(107886003)(6486002)(6506007)(66946007)(6916009)(186003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LDPdDTPma1lz+x8B1AONg+2Iq555UEqSdrfboLQGe4zSXym0lAN2Yhbh3NYs?=
 =?us-ascii?Q?wTk1Vpzkemkmdz5BcaWlKGfJzPPgCH0m34zwAwisTsc3/0LxeHO+L2d5NJto?=
 =?us-ascii?Q?DA9Ttalyg3uiTGMiXmpK5kQnmvGOCtQGWtqs1GZJl1CVOQg7Mn846PxhkONO?=
 =?us-ascii?Q?kAnQBhrD1kRrxREmAoQV//470plPQzzmai9ZsUKs6QPGMAXfAKCrZ+gr0xfk?=
 =?us-ascii?Q?XmIRzKp13kKOHCLJ75GfX5ts54ye1XSoO1/Ufy8NBfKdG4SCprNSu4ygnE+L?=
 =?us-ascii?Q?gGNGbWiYfCAU7Ik+tPT9VShkQoMj/5gyXgROiDQhG9I9CxZxbBveKM0IT0gT?=
 =?us-ascii?Q?TfNBsUPmNO+EKPSVPk8N4kW9Q1nh7QYoH8OlwOAZPyhuUOigfWJmtGY8ftof?=
 =?us-ascii?Q?8dHYwAP+zjD90SCMLX7iNsO19GpgS/S4yEnREfKFcBCzfHzRtfWg72x0Rw8q?=
 =?us-ascii?Q?GK4PzUR9SNKyCjGxfwSFsHtlRh8UJpSsWx/6MquyU3Ti358NAJf1XWq/LN1a?=
 =?us-ascii?Q?bTisNKtix8Q3iZCXIp2KEjd8RPVOKWbuk9o7rVGaIpDVXdXhKPmlWaTetKwm?=
 =?us-ascii?Q?n1kdG6jedf3FAe36moE0Dq2KzT4ieSPAYW0+Gl6iFHP3DKscU/6Y6XTY0Bg0?=
 =?us-ascii?Q?z9litt2H2bJbdrAIKj8aJ0MG9EBZRDs4rgmtvg5GX5LWqqt2KcbvuJ/k2gPx?=
 =?us-ascii?Q?CGicmdWRMGrR2v7+o5HhAsrgU6psSaoQ+hR6A/4/h/ysWzqQY9SFE64DclM1?=
 =?us-ascii?Q?3M2g1pZYDwoPKfEcCQeFbZ1cNnPu0p3BDvDyL0KHOVFO5QfK0ArHxO3awtfp?=
 =?us-ascii?Q?iTXeec7xn13UKkDcIJOR46w0uyjPzld3r6xyXbR+oWs4NUGyPTHCCXvC0QTS?=
 =?us-ascii?Q?4Z8qYxZaTlXfjGNSR7lJ0+g7lWZOz36HIzfoM7MgzgKCkjo2+8mpYjZYz6pD?=
 =?us-ascii?Q?BIPgUTnnozS+4e9Z4gknr4X8OAcK1a558UKUZ1oBrnwwRxE/TGjTFyC1kqC0?=
 =?us-ascii?Q?EujRzFOqwx6Fnu8dy0bdtsh3oP8G0/Vs2FEdliz0OhAuKYoXdj3jC3rNIezW?=
 =?us-ascii?Q?Q/TbIkPxAjom55IH+OvKfQCEDyUAbFnizqQpCnoWYNDi4bDGgY/oa64ZFY2y?=
 =?us-ascii?Q?O9YdmfLxRxGGB4aA788MqOAhfSdUw5d9eTuGVDajS69rij7Y1JRTWpgHAZ31?=
 =?us-ascii?Q?a0D73lgYZ/nPjoVaa298nS4qZXxL89KSTIQNDQnx32aarX3TMjHrerLMLYw8?=
 =?us-ascii?Q?8ylML1uyklRt02ETAtkFkGiDLq/52KNBTWA/HJM3eVLEsRwFcE94shm3UyXv?=
 =?us-ascii?Q?/nH3QtMvN3IL1UzLKzf/IBPqBbu32tMe+GDKgAZaxNZIsQFJ90n+ptcW6jln?=
 =?us-ascii?Q?f2Q0wf+E73Y55MkbJW5K2PmhyUziqS8YtZxuW1nt9Y16N5Pk2UpKq4/BFyqC?=
 =?us-ascii?Q?AfQ7fpuaSlxPHW7ypcK1gZYoYfKk+u7g2jaAv5KywBb0QmJlPVyJMcnPZac6?=
 =?us-ascii?Q?f0f0IQcM+ubO13gR7RWDTzvnEHBhgpE5ZROf11UqRHng8Uo+BOF9UnKPlATH?=
 =?us-ascii?Q?cVwksdV3gfFjuBmQQb9T5QNabQgcOWykyrGAPLEe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b102160-e6a3-4383-f85d-08da593aadf0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 19:16:18.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: an+UwQykZJ3wa1q25TfD/ydWRYdDghjl57xlkuLk52UuyYZMhtnp/HXhcPSke5aH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5513
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 27, 2022 at 10:00:04PM +0800, Tao Liu wrote:
> Fix a divide 0 error in rdma_dim_stats_compare() when prev->cpe_ratio == 0.
> 
> CallTrace:
>   Hardware name: H3C R4900 G3/RS33M2C9S, BIOS 2.00.37P21 03/12/2020
>   task: ffff880194b78000 task.stack: ffffc90006714000
>   RIP: 0010:backport_rdma_dim+0x10e/0x240 [mlx_compat]
>   RSP: 0018:ffff880c10e83ec0 EFLAGS: 00010202
>   RAX: 0000000000002710 RBX: ffff88096cd7f780 RCX: 0000000000000064
>   RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
>   RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000000 R12: 000000001d7c6c09
>   R13: ffff88096cd7f780 R14: ffff880b174fe800 R15: 0000000000000000
>   FS:  0000000000000000(0000) GS:ffff880c10e80000(0000)
>   knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00000000a0965b00 CR3: 000000000200a003 CR4: 00000000007606e0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   PKRU: 55555554
>   Call Trace:
>    <IRQ>
>    ib_poll_handler+0x43/0x80 [ib_core]
>    irq_poll_softirq+0xae/0x110
>    __do_softirq+0xd1/0x28c
>    irq_exit+0xde/0xf0
>    do_IRQ+0x54/0xe0
>    common_interrupt+0x8f/0x8f
>    </IRQ>
>    ? cpuidle_enter_state+0xd9/0x2a0
>    ? cpuidle_enter_state+0xc7/0x2a0
>    ? do_idle+0x170/0x1d0
>    ? cpu_startup_entry+0x6f/0x80
>    ? start_secondary+0x1b9/0x210
>    ? secondary_startup_64+0xa5/0xb0
>   Code: 0f 87 e1 00 00 00 8b 4c 24 14 44 8b 43 14 89 c8 4d 63 c8 44 29 c0 99 31 d0 29 d0 31 d2 48 98 48 8d 04 80 48 8d 04 80 48 c1 e0 02 <49> f7 f1 48 83 f8 0a 0f 86 c1 00 00 00 44 39 c1 7f 10 48 89 df
>   RIP: backport_rdma_dim+0x10e/0x240 [mlx_compat] RSP: ffff880c10e83ec0
> 
> Fixes: f4915455dcf0 ("linux/dim: Implement RDMA adaptive moderation (DIM)")
> Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Acked-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/linux/dim.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc

Thanks,
Jason
