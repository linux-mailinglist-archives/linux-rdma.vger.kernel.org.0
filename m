Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0874E6EAE04
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Apr 2023 17:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjDUP1p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Apr 2023 11:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjDUP1o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Apr 2023 11:27:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604745B88
        for <linux-rdma@vger.kernel.org>; Fri, 21 Apr 2023 08:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/khN6hbexSpbhjYDgTJii9pXnohgXRmolUZy6EWhiZgLwZCGHjegMM6RED3HLGB6rBM6j6JIw4NnGjQqUsL6d/Z3DBAmrcLz+Nacs5yux55ADPhjIDd4xH+z1AT83jIx/488gfsmQoUVDub/crhs9GBwa4qfLl36oBROJiBZgRK3oYvg5NvMCUG2+waKo68SlktnhI/dmOtAkL9cCNy+P/b/uR0PIYuKic89tg9q2PfN6MEkltSgceFcvRNnq/uti/9NgCw7whaAW/YHXWWEwt83BT4TRbprglKgXsxlqSV4LT6UcXBnBn8NhzpnzD9UZfGQimRZDrt49La8q4fBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiNFpAYvfnkx5tm56dsser8+ABEvOOAal64LkHmUPxM=;
 b=MNvorI0xE3/FXqUZRF2yzEG0f19oB0H3NcEF2V/K/C2sztvcRhD1DePP0iZtwBSCUfAAnbZzxA9bA18dCnv61oYQtgD9L5V92x2+1QLQu3yx5ssdR66q1lgpxL309b4kqjgMZFEMObecQ/9y2gO4NxVUT3c5zGDViaFZTBCsAtC1kKWgFxpBIUOVbmVixnwSn7of8I7aNe0k/WhrXDiypAtDgGJO34zhaSUy20hB3wRMfcPCIJxRu456ut5YoiYhBg8OMQgj/aQAOYU2ecFA8N3RH84X212sOp2Jmdda4ONT9WPiU4ldvaAUxumuggbuw6XOTcyuWqV9BrLNihgo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiNFpAYvfnkx5tm56dsser8+ABEvOOAal64LkHmUPxM=;
 b=cWUO5HOG51UGdPdiFPXwEZDw66egLCIBJgjdbKLwgj2AMA1eTodcR/rWsBZe5B63Y4nUacp0D8cdasiTLvKLrZBPfiW0Caizn9/kCbltUVgCz1sN9hrnCANNfmiFJatLy2sG4a88Q/Ihx2LrkkfKnR65rx4p90uaAySvUqQ9b5lUnME9PZqh8HWAfrt//pED3oTJLUz8zjHiZEQozT3LNGDp5UJ6BR8HQLBLGFhS5C7i2BFeOM9kwGkRV5F3nW24H0LIZnemnafPFuPEvTjCtibkj/NTUiroCzBbXYUdEkptKp04wlNaW3ZgAKWuJcFMUxzaGUg/2Vgk116huXU9ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 15:27:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Fri, 21 Apr 2023
 15:27:38 +0000
Date:   Fri, 21 Apr 2023 12:27:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/rxe: Add function name to the logs
Message-ID: <ZEKraDHuNAltduzU@nvidia.com>
References: <20230418122611.1436836-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418122611.1436836-1-yanjun.zhu@intel.com>
X-ClientProxiedBy: BLAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:36e::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 6243a3c2-92ff-48cb-78f4-08db427cf095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOMpCfwxjS4qV0TWCQduUhGhJ88r5oL5AFvpkIjsgLAgI75XTEntwYVRUNVAO49PsCvnCAa9XokU5hG83uTXOHMCORdNXaVbp9arP+tIvt9OkevWnAtcMQ4Y6JylhHJ/6e3HdqFn8myl8l4kpNx06PSu3awSdq7JZk6G2QZsWZprpZEQVcOSbvr0Pn7o7in/sNdBTpqqfCTfnh5K5kZRjvcUP7B6DzzmIMZZoKUl6CkFqfCUHtd6XCjngZpeEJX16HtGE4wFED5fM6t62raiGdHk9uLgTZIvhrEaNg48fWCx/zbsq/P+PH9vzgr8vXXara9yrzht/SmPSxOGpHpwY9KuT6LBYXk7V4GiONUKx8lAH0mmOiGidktm6KwFfTYSuamASRNdZQyk8HhQdkLGSVJfRXdtzx5ypUzJAl4kdrlBPtLHXEKcxZ3SP7bROt4kY+Oy6peyvXagWibfox4KCregFvOPQAFKV1dMG62+sGDdCUx03CTJBRaSGocezwVopfQe7BJBz2MLr2GxJCQaaF4z94pKqD/Xi3ydxbq1+GK/uMqo/jsp0DHMOTnV7XIV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(83380400001)(41300700001)(2906002)(316002)(4326008)(478600001)(66946007)(86362001)(6916009)(38100700002)(66476007)(6486002)(66556008)(36756003)(5660300002)(186003)(6506007)(8936002)(26005)(6512007)(8676002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Si7zHI9vAb5HehZu63xyN01TzPSzBSWyxQjXsbzAIVfihwtijiBFiVU4QIrd?=
 =?us-ascii?Q?8PQ0ioy3plJV2KDojo2M6R1RZ10Qkocgq/lhqB9GMgsjX74jLgFsuNV/AOFE?=
 =?us-ascii?Q?Lz3EegdowhsVRzAAxVVlHyQkQM0XqMdpTd2JGLMFdN2IvSj2o3cntAcXHBot?=
 =?us-ascii?Q?S6pg0z1/NyidnDJE7MP9hQMOMfwBHeFiCJV35OznN5YNEMQFtJp3lRO1ot0Q?=
 =?us-ascii?Q?T6CWsdFHKmekgeGxfRMu+JqYnhaFgbdgLhTpkC+pAfgxrQfd8vAA9V2XM1zd?=
 =?us-ascii?Q?fAnRXBNxtE/cE+l6Q9JAVBJrmChoAk28Hemmw0/vMcjJe6gHWGHHgTg8L2iq?=
 =?us-ascii?Q?s5hlTXPfeNpLO3MqK7OpLZJI0KE/UJrYg63dm42DaOFLVHNH/V2LCwZBJw90?=
 =?us-ascii?Q?bCV7fybHemGR3qVGSx/E5Doc+yQ099PaPZO9kjLxH95EoiPhZ8N0DXV11CxP?=
 =?us-ascii?Q?PVxx85GBa8vZM/E7D/D/UfQmvhCMR1gCDvD2gfQyx7gz7T6s+33AYLyb6hpd?=
 =?us-ascii?Q?q1OW63gTCe4nx2EpRhctv2aZtXAhoNEG7OeA11V8+tcJGs5+HNT7a3L6jlx3?=
 =?us-ascii?Q?z2G1Z887n0r+2rBFf7/EKmgVE2moUWTTqkIjAUqcPNrVHtDdiLo/RuppDkYF?=
 =?us-ascii?Q?PKtog0zkpGkK9QFjoHv1M+XddbPQnrEJNnHoY/+iHPWNQxVw5MyuTh3oBzex?=
 =?us-ascii?Q?duie42Uaz9LiKyBie8CCN/ob6lYk9QEwLyPd8ABc44iXzcMQXpVRjL5zDq/g?=
 =?us-ascii?Q?z7k1DVVeQYZlnr6zvddlbqGZtxcXe6Gbn4Lz7rWCbbI2PtPEl1d0rEni7O5p?=
 =?us-ascii?Q?unROeaDMIvmV9VbI6Uw8jaChhp8Fty3i13oubd565noKrNZkRIC173Y+iAWK?=
 =?us-ascii?Q?szhxR+g5oJGacAU15Ia7e95cf7hD8YZ+O8jLi61daHun0b17tRBYSKqYiB9i?=
 =?us-ascii?Q?8JLJ1zphVt08emdWJfW6B78orVQ3BYC3aOm/xoF14P50QjpKgS4a5mV6AZWy?=
 =?us-ascii?Q?ZsrBd6QpVx5Radfv0xZciDWA1HuYL0JoRXgvFUOlsz9Few9WnlyZQymyW768?=
 =?us-ascii?Q?o9cXjqO1BJZA0wDYcuO6qYRzDX6Wf74OvdG9lyWlIW7C7qq/EDL4AyzxvlPO?=
 =?us-ascii?Q?hZ01k8OLNqx3rT2bwn2VmjfiE4bz1SNjI08w9InTcc+YBvC0JDTLHXjApgjQ?=
 =?us-ascii?Q?kvUvG5CIOfXO6XJmi87bIEafmUcf4dp02O1CVuIzuDPxh3y+J6vhuB6kOj/s?=
 =?us-ascii?Q?Xt0QaltxZFzYSYMPpPIwXkeqlgYiEwFCyGFtrHdeWP899MgajlB9gFr/3NX5?=
 =?us-ascii?Q?35CJX+U3hLlO/tJl+FB8yCAcVEF/QwCKDevOyfe6KN5ILl+icYAKnCYmcHwf?=
 =?us-ascii?Q?LtNcmOLwRyVUQXDbjILpGKdapoulJfXWo6na0cmNcbk+klE4xRvbvxpWpRNC?=
 =?us-ascii?Q?efU6TTu0PJRUB+25gjK/QNVKiapATXwAQhbEqaL1WRxn5HaWgEwDW4JJQZZu?=
 =?us-ascii?Q?32MKH3TjU9mVluUaZGg7FTyfIVpSOT02LkS8Vux/7dMw6jGMf/EB1yFlBB11?=
 =?us-ascii?Q?OiYXs66M4Fslxw/tcfoWZpmg4w9Y1NCjWcZnuqVb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6243a3c2-92ff-48cb-78f4-08db427cf095
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 15:27:38.5011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjhDvfiwooj4T0/2FOW7m1tMOqeJuKLNdMIgxIQiVx5iB79Wqa6Xt1OsSvoXNEAz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 18, 2023 at 08:26:11PM +0800, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Add the function names to the pr_ logs. As such, if some bugs occur,
> with function names, it is easy to locate the bugs.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe.h       |  2 +-
>  drivers/infiniband/sw/rxe/rxe_queue.h | 16 ++++------------
>  2 files changed, 5 insertions(+), 13 deletions(-)

After you delete the warn_on's there is very little left:

rivers/infiniband/sw/rxe/rxe.c:                pr_err("rxe creation allowed on top of a real device only\n");
drivers/infiniband/sw/rxe/rxe.c:        pr_info("loaded\n");
drivers/infiniband/sw/rxe/rxe.c:        pr_info("unloaded\n");
drivers/infiniband/sw/rxe/rxe_net.c:            pr_err("Failed to create IPv4 UDP tunnel\n");
drivers/infiniband/sw/rxe/rxe_net.c:            pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
drivers/infiniband/sw/rxe/rxe_net.c:            pr_err("Failed to create IPv6 UDP tunnel\n");
drivers/infiniband/sw/rxe/rxe_net.c:            pr_err("Failed to register netdev notifier\n");

It is not exactly mysterious where these come from?

Why do we need the function name?

Jason
