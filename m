Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415103A0762
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 01:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhFHXGp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 19:06:45 -0400
Received: from mail-bn8nam08on2049.outbound.protection.outlook.com ([40.107.100.49]:39649
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235062AbhFHXGo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 19:06:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nj4pxgK4HbhSq0D/7je7coHcRsGRAsyn3dCN/UsQsgs9UihV2JQ3qjLB9dHC2ShR11dhXEwwxeE6fowsvFopEs8uQJ884pEabTaKWDQ4fRD0eN82GpcN/VuEK0PT8HnZFPxCO7xX2EfY1EJTVp4L6WQX9n/pvoiBYaTMbOln8aFBZ+Y5VqKGl9Mb8UqQvkWjESrnq4+NK3PA4o6O/Hwzy09Me/+Ish5+pNjq00RhZeZ6FKPu7DZxXWB/mz0D+632aEEX5jVtnaExDxbKvETofvUqTE52/K4/0ZmwOyb/iNCPd5e58tsb2aDgZmRhkooG8fmnMMvU5COQFcR2APZSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cUpCqbRZe77vyLzhSSB+iMHudhQGQWXKPCUZ1KxiAw=;
 b=DnpJurGmo0qj3Yw9XrN8rTIwhq/tk5nXEKMCcrcojRC+7F0KWIaP8EOYc4Powvo2um7l9NeyigpkuhBVdkPpzE2Wt27T6TBiIw8EXaxLU6OxaqWtZOyZ0mpbzUbk4MEKShV8oRvF8VUYSMmL1bWyAHQZ1qTXp2YFidBtA8mn/ukDKyhT2yVnbUIBNT8gP04X2n+vcTyxSwlZEvSb9AMH9J1AhO0SnJ92/R4llfCKIKObFAjLDiT/wcjGvgEwA3jK9QkA+d4SAGrr3d42q26zpJHEANZgR8iAf+hT5ApmAOroKev7eVk+7h6lmKpT+gyRj4jMqQoFUZGZ8H3F5m7BHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cUpCqbRZe77vyLzhSSB+iMHudhQGQWXKPCUZ1KxiAw=;
 b=hmJjBwnugSF61SjYzq2ogCmIPFB4sCZBS1sEHZgdb8Wa1sl/wdRgOXLfmzC22sYlvQfJoeB5jYB+I7mCtj0NL5omqbwPXmDtZtkMshFiNOe3h6MM7GQLpwBI+WVXuFlqO6Nv5hsJG+ewqzD4gOd/UjHJyJ7+5kfK11BzBpSmdRV/0WFe21YOM1Yx+Ca12m1kDKJKllaLzQkvtGeeMJ+gMTm9dAVFe/uTnP0UmAivqoloyhMhn+SE+k3kPiTYtjQuvVhqEEiflDf2aNwBpMu3/Uje3IAilFUXVlvhUoP5RSjrEIACJX2d19ic/rIXN0VHCJ0PgilP9OKGHE3Pu1l+WQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 8 Jun
 2021 23:04:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 23:04:49 +0000
Date:   Tue, 8 Jun 2021 20:04:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH rdma-next v1] irdma: Use list_last_entry/list_first_entry
Message-ID: <20210608230448.GS1002214@nvidia.com>
References: <20210608211415.680-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608211415.680-1-shiraz.saleem@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:208:23e::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR14CA0018.namprd14.prod.outlook.com (2603:10b6:208:23e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 23:04:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqkm8-004EL3-6a; Tue, 08 Jun 2021 20:04:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00482d76-78dd-4466-b18d-08d92ad1d10c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5351:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5351660DFCCE8BA1A7830B7EC2379@BL1PR12MB5351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1F8F1o/SAxwwLpf7U/jVb3bl96vZgLEQSsVhgxyQdrs1dM1GC3zWp5WGmeb4sxqAmHe9hp0rH4m9mtd5PLaVHkEomRaFc/KA1MnTU2oEA8pQTsi329e33eZk3hg/5g42BsTyWz0v+yB+SIWgXC/jtzyf2UeUghNYZQMia1OXCJVulJMlN5YzdAntOmsQrdxpnKUbx3Cd1ZPhH78g77Diu0oW8MAK8ckpDN2HvseWSBmYAxh/gAr67VfCeb9XREelR8sPeukJq0dn0NuVn/Os8WUF2CBHbDbpjj3PN7OCt1Px1Gzqup4D4Vpk8ANWhrIWMdDQirxRv0kH0uforW2wnzB/eeD7P7vpN701UArIzxlR+H015ASfoXrMNNUOhVCyVku3t5Tmw7Wm87+eoUvLIQzxilQ7xg6bhSCfk2ttoRvyk5mVCMa7mxHbz5z4eQh2sCzB3We2IJlpxnchbT8u8ad9xCuz9NVkryD+dvciwbZEbhs9xmUP5/MnKWRD2ilgwvI399ptSuDqG/vEfOHxh649rIK0IoQw1j57WgNPrDs6dyypH7wqM6SSUSgSuAoUmCOPjCVC3IkqcLDjc37kkFsiwaPjHxi3dBQULL4MrlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(4326008)(83380400001)(9786002)(4744005)(6916009)(316002)(8676002)(9746002)(478600001)(86362001)(426003)(2616005)(2906002)(33656002)(8936002)(26005)(38100700002)(1076003)(66476007)(66556008)(66946007)(36756003)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x+39wZh6eWrWdeBAyuSvUgInA4EKUFOJ/YcH9VgEDnKolcKDc5yfaPqvSgWL?=
 =?us-ascii?Q?P1Jc/H1joUp3hWd36TX7Wds6mnqcAncgYSA6uPOa9z8uXiI+wulr/36e+5YD?=
 =?us-ascii?Q?nRI9ZjY0RItyLWfoMmlkbDBpJ3CgktxNDECoRNTxhImrlR53EHuvn35sDvEu?=
 =?us-ascii?Q?zSwqqrhtVMB7m7IZ6bwJ0tp9RpTY/uh3EsLDCm4VST6Rp8WCvyFR+qmihFik?=
 =?us-ascii?Q?+4N7ygQW6VchYXVHkno4iDqolKReh6DQ0WOmUjultz4fMqA/uphF7176kaj0?=
 =?us-ascii?Q?LCYeF4ucB7s0TcSFlxoE1O/YbgEVrSlY5TdAJdX7V9MlyLNSnUnpz4+xRM1Q?=
 =?us-ascii?Q?t0RUMSqpne0OpHBG3Evxc/HIQkHxc9Yghwov90fnlPeJQ4d7NXCS5cnNJhYk?=
 =?us-ascii?Q?s74Q168aytEsowFcLg+k20wudFdJDutUbtHMAakoXZxfwqfNoROVnTp7dvae?=
 =?us-ascii?Q?X+Yxp5XJBRsCipDXz4NlPP9F0muuoiivLgPwDIpI9TvA2DxqCvjZdkcOUIwa?=
 =?us-ascii?Q?3Mm9+uGr0kBQInbMTO3rlzNq6aGjNDHWuZo4X1Uf8T7+2BH6VXUueigdp52G?=
 =?us-ascii?Q?QoxcaSi3vh5DhTxglMwe5NdZOqU/RYOB03BocnsQDjAuQt1nv9fXDaHIgBDw?=
 =?us-ascii?Q?IR/5VZDGXzviD4T+D8qsTPshXMPhsv+K/coVmc+GtnfDOji+8A9JWX3zY7Nd?=
 =?us-ascii?Q?rnVoL1g2ptXC1rlCuAQvpOFi6chCVsgj6u8vg296UvmFHCX+bHQe3+xDeWZC?=
 =?us-ascii?Q?dbuXcJdGLlbEQ3PLUwAS1xrhz/rM6zXD19QQrzrp2BxumrrDa4XKKnjmbyqs?=
 =?us-ascii?Q?SJGNuPozbHqlZzjznqj6Q95KHM7umFfwHM3XPFPSPJluvhknOORVFfqAaKcM?=
 =?us-ascii?Q?dxFAkWE9u6/6YfPi5baiX7+TtWkOdGU/7pXxgX8whM8K9QpxmX5fsitA7ahi?=
 =?us-ascii?Q?m5l5seB3xglvYzXCE+IhCTjzWVSIRICyMeJENpOxQ19bqEStaUJGVKVTx8ic?=
 =?us-ascii?Q?yPhD4n7JWRWEpsOuGq6t7VuB8OhFM2nb4SmqHOlGcW7cT7D+qALbXmFfOVs7?=
 =?us-ascii?Q?97pUkVuiHWdl9nZnxB8WlLon0WOx/gSleUon+vOE/aC5h3Q2ylUBbpyTcwEc?=
 =?us-ascii?Q?F2DFBAKwnA9VfNlp1L/aihLCAwPcYqDuWlPqiz5/Yc8+wNPds1P5xKjXLCnV?=
 =?us-ascii?Q?cCe8TwwDahzXuOvLs1jssRiFfgupqFfnNrvzCR2HITLOunlFvxS21egn4V+J?=
 =?us-ascii?Q?zcupXSmN3snPTUl398GYdDKwqEqmxm/mKLs3+4QRA0IlGgciAiSA4p+dymk4?=
 =?us-ascii?Q?AZK/cwX30jMFx7ixXU/iTld3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00482d76-78dd-4466-b18d-08d92ad1d10c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 23:04:49.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRfrhN4LeV8ldaPSQdJQ0mhhuvHjQkpvgHaTEclXnkqH8FAvYyT0cvJIL54GwCxb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 08, 2021 at 04:14:16PM -0500, Shiraz Saleem wrote:
> Use list_last_entry and list_first_entry instead of using prev and next
> pointers.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
> v0->v1: create patch on more recent git version
> 
>  drivers/infiniband/hw/irdma/puda.c  | 2 +-
>  drivers/infiniband/hw/irdma/utils.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

This still doesn't apply to the rdma tree.. You need to use the exact
rdma tree, not wherever this came from.

Anyhow I fixed it up by hand.

Jason
