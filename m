Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0863624AC3
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Nov 2022 20:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiKJThC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 14:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiKJThB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 14:37:01 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB74101FA
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 11:37:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRHgXA4uZHY+/G0Pn2wsHK6fiKYmp0hzvfZfCmsQj1F121nKuqrzJ4kIgt6Q7ftKsovMQq+W/yYGIIo+n7ntCjxbW/ftnUeHt9xM3pf7blvND9h7q/qX4IWPCzTUEYHTYKVKRSbj0Bf7qS5rQPMwiAVzpjmbelNmodxngL1mENc9aiugU9aiC26FHyzTIpZgUA4M7IrUq45Lv4/PW5HWkMfCjmy/jbVj8EuP58kSxnHyB9wVf86FAH4BsyEwb3b95E8pwTMKlAVzQQTtTyYnhVbV+S6tKfmy2buQzASYJffbxDOad9Br8eGs7j2dgh2whrxptrpoVd++dWqmvERWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jX2AMl/kWVUiYHtkUCkGltJhphx6fqxvsOYiRAVRgVo=;
 b=dYFII4CHV2LdiUx6t4cSZh47y7/X0vibDrOo9p7ew8W3Yc8OwTgZdnismkwe4gGuxhp6gz6SJI7VTjgrt8h6ErEsRXyPy26b/eNvNjaWGJROneBV/C7TXdZ+7wi9VvbdH5JQdIVnAAqBAjs7NdKXTWmM6VwupFLszaRpBCUBMN6Rl6Ld+bOVz77d+ZKcb7NdO1uovv4nTxAVcCdF5NynEMTVlKYRL7biLptPkJ94aOISJgjyv/No4Xk3YGv+qzLzd29LZjKEoL+QUQIItT5plBU7huPTwCnDQqE30bFePxJeA5JAcNmdiVnSucnXq3pyqqxJHgFZpZil/i3BN8KAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jX2AMl/kWVUiYHtkUCkGltJhphx6fqxvsOYiRAVRgVo=;
 b=AcgAbjx+8DxPBCV++RAOBBFvkr+hSoh9+F/lUYJhUDdSHPvxYqEmYwH3Dfo9HhLPSFH62Txi88QMLZDoNbPxk54UmFX9GV9S+KMTXJ/WqSYAjkDzXTIfib4HUHLq4R1stu9jnWhuHEQF1Lf8EWELM4IABPqc7fpbEH+wJbJl9mMVK1cWoQbYrB7/m52x1T1Oz3pAUa1NWueQgIMBqUVwST2nexRz4YrUY++NQz8sefLSYilT/gRi2O8vXE0aUcT7kNDMctC+gfeHgkM/kKRURE1fttg6xFZyH8EwUcPv7S6GF8tZrQl4gwjmcjijN/3RvonjuC7WS9LaH1LwJPkSAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 10 Nov
 2022 19:36:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 19:36:58 +0000
Date:   Thu, 10 Nov 2022 15:36:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 00/16] Use ibdev_dbg instead of pr_xxx
Message-ID: <Y21S2V8Q2i66zElc@nvidia.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAPR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:208:329::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 5affb66c-2e1b-4fd3-61c7-08dac352ee88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqR8yvfb8d0y/SXQ/4K7ReLAAuUIWF7RGe1950wL5T3GymkrKTL+sWivUSD89M8jBb33tyxLR5/hVrIudm3IAd5p/NYwzeT8ZG8aneGWKT7b6n/P2luI5bbOgOmWxRsx5LqR+/Uyt2jzLJovniznJ9Xe04kdcIHcw8ZUG0s5ctL9AfMcYPrgJI6qgtfHEUWxNyJEMIxzAdnewE2d81B3zh6vdh5GWgapVe/1bu7j8jLjALglk4Y4Ei0GZbvuCNpZIXK5IdUULlozzzytB9VY3pq1iKt8JiVn2xuAs3d6eGip/jqvjVab9n9xZVwfZ6qMmObe48xZDcZilLi1cvpZtTuY8yn2dxH2Fq1K7OCgqgMOfgHzECEuXnbQzEi/cyfov2obeV+WUxagj4hOLuByPxDesYOaLooJQGzDxmfrmzoeC4FA5BDItbtm/LG2oKW4xNOAEc/+LaLIrmWmBC8bLCIvBBhiYJoItUDBybXqbgMno5TvPX2ao3SmzOTRNRfqpZwVSX3ozqBHb5hXGEbio9sJTokHLu8dvzEwQOmnwWXsKBKeS4Bqtz3NGij0yW9b5E/g8ZE/YQFWWX6nM5TiAcW15s0m2XMUYhulBjzX6SaYQSjY+G5IwkM5F9dC7jXjyzhqa5eM0mvY+eorMoz+mfUXZvJPKPIaXqhCIHz4bCY4BB0w/RzzRhQk/2glPrsMwyik3PvIvzsWmf+1hKop7itsJAkzV51TPVK4Xx8HYF44ehhSpsSfp+Yp3qvwv2aH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199015)(26005)(66946007)(66476007)(66556008)(5660300002)(316002)(8936002)(2906002)(8676002)(41300700001)(4326008)(6506007)(38100700002)(86362001)(186003)(2616005)(6512007)(478600001)(6486002)(83380400001)(6916009)(36756003)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rng+0UqwuR9ejF/FiJOEjNoUUNcOAoW7QQpatQbZLw5UmfqQ8rznvw1oe5Rl?=
 =?us-ascii?Q?0ZQK5MdkP9oQRBAYZWMcFfNq1BKEum14mfMrYamfjSAaoW6aGPn2fVwRy0hz?=
 =?us-ascii?Q?7aoINsdTwWH6s8b4L05LsIOAXaa8KJA+Gw0646kK3EKwrwSnuQAisC3T/wm5?=
 =?us-ascii?Q?VBIzvHUMKTu6T/ttIu8gJbPj74+JzVV4T2srg+whx9dZJ7/LBgum0VclLEf1?=
 =?us-ascii?Q?WnXDphIjO/4HsuLJNgdizr9GPC8oK6NxMkAWaljGK8nOKl/LZ9EKNt8HOKqf?=
 =?us-ascii?Q?C/ROeTUbUs4bZgY2SYPvM/JENiUdpayz3v/UiHz+ge6wUYGY/Sr4ApoZPF5n?=
 =?us-ascii?Q?ZUOlKt9fWQl8JrDsDEidlHkVRT6q1AeEEsUw4KLlJehO9+kIXNTbsCs/3x5g?=
 =?us-ascii?Q?lXgOzbuJP8fu0/hnFM/uk0V+R5NGSh3T+saR0cmJIl7yHlLr+MGAlrWevXiu?=
 =?us-ascii?Q?fX+pQLBDL7LP/tYXYRpwxEhQIAEsXmUDPiaGPlt6vzZ7jRtdRxOwiuIWALLF?=
 =?us-ascii?Q?0vW+B2RDVsKJ5pkwVkvabiAs6NQUkGtI7od+cHrFi23CPko8ecou636UYBW5?=
 =?us-ascii?Q?o9wavOzt1L4zWdId+yaKrk6FfUjXLJ1M01PPwJ4ZIJoWBdshLlBBFEyEYIEr?=
 =?us-ascii?Q?iBDOWqNH6d/TXJW/KScIINLfyUchrBlCWZQHBq+ao2C78jvCQFZvSaKcq2Oh?=
 =?us-ascii?Q?ol11dbm7OaEgCXteNNeRYqOAKbo2da4svUqq+scFp7BK3pdTyzoLZFZVRyDx?=
 =?us-ascii?Q?m36Wl2bV+yifyh7xDq3L3Uv8v+DX5JftXoICNYb1hXiSMutKiOTmM2u2tREA?=
 =?us-ascii?Q?Lua1iQaAoyjqPhzZtxDA+Bu2uKCB8qgdvvEWNZzqCZiJUi8StlGtMZ5eRdjO?=
 =?us-ascii?Q?ujUpldfdFtPrHKz9+mIKGp+GFhlt1gHgX+paoS2vU65mZ3qqH+oJ56Cnf8IG?=
 =?us-ascii?Q?sCQShEH/T2zSybl1NqaDxZ6Bqibv5Wc8J+t/uZPdLqEkvqlllQ6dBZn4bImv?=
 =?us-ascii?Q?sB7ZHLzetFY+e2fia40ygFWf9OI9nGF/zBWndgqoMe/dBuRDVp6bUeoAMlBb?=
 =?us-ascii?Q?KfMlLS8M7N+8czbA3JPYRwDZhF1gLa1plHs0CxnjJUmuXRWoq6PzOgS5HwrA?=
 =?us-ascii?Q?q91VsvLtxiK3TYIcUlyFo/P30f9wBipdA1kNIjP2d2xdf0s98nqy9ZdNKEns?=
 =?us-ascii?Q?gYKTpwp6pq5wkYjr0GLPHnZLAqY7q/QLqaZX9Zs/mVP0367N76JbV8Os/CMn?=
 =?us-ascii?Q?ZtlKFKHto5o+mz3kvVbgaUMnnVxZH6BNFO6mgr0T63fNVDCy1Zryqauh4vcl?=
 =?us-ascii?Q?jhL17AlL++7DoOCVA/JUsY1bRCe/AtqecBYiFrkRh6vjBcDagJiQICSVFejJ?=
 =?us-ascii?Q?VHl21OABxg/olLhUgc2hDuMLE6i/NyxDc9OxuHZCfyJKAQwFs07RMaDmwVrl?=
 =?us-ascii?Q?Sw0LxfBWln1SW++d4P5i48Nh7A3XOe61Q9TjLX6u8N1un4b/xPZMGy/ULVov?=
 =?us-ascii?Q?uKDqGKyuAyuKV9Yl8ycCN8WxarnZapaA9NPErAa7qIYGeVOvajBRf5l3d5L5?=
 =?us-ascii?Q?ppZF9vUKbui+OdjSZys=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5affb66c-2e1b-4fd3-61c7-08dac352ee88
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 19:36:58.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ms9ShlExhOpyJKW5a1R3oQhRlwDAgoIrQYe4A9/ik7ctoe5L42dtMy9nu1vMxb5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 03, 2022 at 12:09:58PM -0500, Bob Pearson wrote:
> This patch series replaces calls to pr_xxx with calls to ibdev_dbg
> using macros for rxe objects adapted from similar macros from siw,
> except in situations where the rdma device is not in scope.
> 
> This patch series is based on the current for-next branch.
> 
> v2:
>   Fixed a typo in 01/16 in rxe_dbg_uc().
>   Made fixes to 01/16 from a comment by Jason Gunthorp to enclose
>   macro parameters in parentheses.
>   Fixed an error in 06/16 caught by the kernel test robot <lkp@intel.com> 
> 
> Bob Pearson (16):
>   RDMA/rxe: Add ibdev_dbg macros for rxe
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_comp.c
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_cq.c
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mr.c
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mw.c
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_net.c
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_qp.c
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_req.c
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_resp.c
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_srq.c
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_verbs.c
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_av.c
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_task.c
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe.c
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_icrc.c
>   RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mmap.c

Applied to for-next, thanks

Jason
