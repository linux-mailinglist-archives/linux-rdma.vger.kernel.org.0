Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB9146AEAA
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 00:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377690AbhLFX6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 18:58:20 -0500
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:32309
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238015AbhLFX6T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Dec 2021 18:58:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb39G6/6IGOF0fchulzpdr/26VsrRcsvwh75lB2/DjLIkkjnUWzaCJUUkzU9O6urn5qOtQV0SmK6LprWgu73EuotD6vanv9Jt3UlCx9Bx/Tvxqefth5dhXJxBde5GOYh7omlZaqRflt5r5Gq0Jpu91P6Sev5+/zXJdtcLrjJie+i27m0AtDjxFhnnPi+kJMw5tTRO/F4ffBC6QVQM0QTMdHt9y7mwb6IWriwDLrcppzJHds7O5+FGcgCvNCQsFFIs+5kd6DL5eDw6VJZuhM4kxGrXkqeex+RSyC89GrVpqZnGHbm/F5XPTC7pVcGrwqvzhTUhC1RV5DNMWERy8M/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUCYsuIOLY4G2zAiDQxVuhv8LVUQmXK7zVt2JhA5S8U=;
 b=VzL5u2Q6ww/V7sRvwHnjKLtIHCTHHDOQQJu5ynwp5l2EHbV608nG8+t1B8WlE8EMtJ36Qf1xNEtXI4rzcUSiessLASbqLaGcfdFS+rZ35Fmv2HG/F6WCNIxxWgKWbOErtUJcQt1mjQKnElrSRYUBUMgx/v5vJpkLUqAm7TjY2G8E1JVWjO4K09ckpUWVjh5gsw6shcj3d905jyEI7LvLgh/f0SSd53YvaYt/PMkni7cTekHD5F5WKuScisXlY+arxnfDskgpHct8LfO1SgSKtkv7f0L/qQIJO76uuB0/J/ZFMRMO2dhViCQkeAcyBgExKzJfb3almGvbBNW/W/DYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUCYsuIOLY4G2zAiDQxVuhv8LVUQmXK7zVt2JhA5S8U=;
 b=psKtazISVWIVfDi3hkRO3bchcCDkMesITbIYXc3tEwCxSYgoANcIzt69m9d0eYa675enwlfZJ4LZKbF9CDijdJ30R7yBicfH+wEchRIQCjw/xtRURJBlXgdWZUySgY2Jb0Mb42mCxswjbo21zDoG/2k2LoGBsXgG9v4EWETFpuZSODbvIKwp6k7BxwhwVLsgQ+IW/NlSEoVLCth2hOtIL0Ojtl6TFSt3ounJnLFRc8dzg+xKKfqLDXbbnOFY+1cIGrJdrjYxP6wBa5pKnvqGXBMvup7qvTEfgBmXdoqscR1QBMOl5UG3jkJe69UnFNMBBT8SVvX1jtqnQE6RcG7nyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 23:54:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 23:54:49 +0000
Date:   Mon, 6 Dec 2021 19:54:47 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core: Remove redundant pointer mm
Message-ID: <20211206235447.GA2174558@nvidia.com>
References: <20211204234904.105026-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204234904.105026-1-colin.i.king@gmail.com>
X-ClientProxiedBy: MN2PR19CA0012.namprd19.prod.outlook.com
 (2603:10b6:208:178::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR19CA0012.namprd19.prod.outlook.com (2603:10b6:208:178::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Mon, 6 Dec 2021 23:54:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muNol-0097ie-H2; Mon, 06 Dec 2021 19:54:47 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 722386f3-dfb2-47d1-dcdd-08d9b913c9ad
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55386F1001521E4C8F85FD4CC26D9@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L9N+KuUr2o1cJm7a2aRS51GZg1U9bG9x+8BaO8Z6bRuIwIJNFncNLGf2kmM5rt59OEqdIr54eweALvPBb7naFpwbZhUHYMy1/T5SPalaFv/icgIne6r9YBgB7jkE5W7smTPXCN2sOSnsUB0OHQlfkNaoRdFxZjPz1zJR1+D/KrfbxN+OOkpEyhz1dARTTVA2Z+D7/ub3D5F6Mouz3neStgfgPsxGudLYrfwUNDq3jKzMKoglRzzOHV0TpqTTP6KjCzFwAQx+kzJakg09fLjUw9h5SiM70KcaVN3aB+ru3GlhZ+u+k8fBGQGRah1FevxNL6P5LlEJGWdFc7OScW6H4rdK5NSroyeUQhbFBo/xN8DBV5l894k9+OiO0uNeott/kIoEE0HKCDtidogciUAkPXXzvNSVjhWFIMcq1TCelGV3gNfG3vsiE9nEnOHFbzifb9bUm3n7/GGCQ2Zf+sYIusuFMI1A2DdwRdxZna9NJf6m68oWo0jLdzxy2koB7n7nOqQ7QrMJfFM5ZOhPugbo4Gp07HmoRo4jKiFN7VR0QNfwE+SB93AkEzeThPo95jIfYoPd1IseSOLrH1dj+Dt874nYBLDk+y3pblnP8d55D13NxCd8ow13G+Nk1AdkrAI0F+AHcP4+QgdsHIg95dYVrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(426003)(38100700002)(186003)(5660300002)(6916009)(83380400001)(2616005)(33656002)(4326008)(8676002)(26005)(36756003)(86362001)(316002)(66556008)(66476007)(66946007)(9746002)(508600001)(4744005)(9786002)(2906002)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NIZ/ZJgHmNXoYg2xpuZ3a4x+B62Z9/azTlBiE0naJenm/XQ2h820OseCZXxk?=
 =?us-ascii?Q?LcCTl9swL8r6Z2p7og/xVlwkemxhsDb/tGXaGPkKLlK30Wbllf4uO6RWtak0?=
 =?us-ascii?Q?kN4Wfd3zV0VIS+i71p7VJ3ben8zOsRDUEP7megdooKZv1yU2jmv+vsSehyYA?=
 =?us-ascii?Q?+NV7Z8MpmqeDeqfGalp8JM7PZyb2/XwXqQ6u9Sw3nGv0m5/KXavf/YXRDZiA?=
 =?us-ascii?Q?m1q4Pz/EOQKCcB5iZBPtZpO5SSGGjwBY9Qnh5uRxrvvPwQSHBxKNnpqCHRjR?=
 =?us-ascii?Q?Q/DJQbetrkSqvBpAYaVP1vQriLQImMc0Zfe0TeSsnekahkPNXM2dNKThoGBN?=
 =?us-ascii?Q?EaKyntrSciSg/+8SkV6rNRN/kBcJyPGI54NPloyvyP3W5yHHaI7wwMC+85s7?=
 =?us-ascii?Q?1JuaQyVhc0x8ufgr9MpuurJBK7RH+zRY9szV60l0FW82yiDrwnY1n/S5Wj1M?=
 =?us-ascii?Q?wiKa1iOa4/Gx3J07ED+fGjjHyVLFiJZyvx03RKyJ+E1LtOoxDoSMkuypgrHV?=
 =?us-ascii?Q?hplfvGlGD4xbAmjd0SL5Tu+1wkF/swAYaGAcavGVZ3wjPjJSECLB8ZkjJtD1?=
 =?us-ascii?Q?3D9TBcf4jl+Y8A3HX35vsmQgS+0y/ChYK2hK3+XwTDhKN/1x+uKk0w5teTk2?=
 =?us-ascii?Q?SbsauErHWaqhEvblDnIFAmd/8h/jjrqFnRKrZrTMaXKkf4NH7Z94UgfnFUwR?=
 =?us-ascii?Q?hawoGeuwl289qaKJbzZnayQ1K4nGRfT3qzsPK5Vhlg7D0OBqkOZ5W++p2J4X?=
 =?us-ascii?Q?U9vSho9xinnT1BmLslgewME24tnSGGfBuwGbCyr7gtw0tk1jhZaJpPazWp8C?=
 =?us-ascii?Q?+POSzLLVNr359zXDH2ECFRrhVh2brOLZ3CwjfNN0UTFh6qi1ly15c2+Yrx/d?=
 =?us-ascii?Q?sFGlVexlwJRPaFDj3hRgxRviNOrTVwyoqmLN2bvMZl/6IBN/GrGVq6XXzKJI?=
 =?us-ascii?Q?Cnl3C3c81tAFz9hRAB1a2ThWXF53pMz0Cy6chSu05mK6DY6zxxa6cyPUMt5S?=
 =?us-ascii?Q?1MzrF2+yufePghp16F6NM7IqsdzmDpTDvzbOdDxZ9JIjzqaQfXxOSb5MNK3B?=
 =?us-ascii?Q?WjDyZRHL5p3jpc0egg6GQy9xLE6Hamc/3UBEzAkLwKmYiDN1VWHzwNhDzwSR?=
 =?us-ascii?Q?JpuM6P1OTvhpO8QKSpLSviVC1GiY2qyxI2EEt5dhYXxB8FcRiWlKR7Rmx4MW?=
 =?us-ascii?Q?V4QlB3jxqe+Dqh2VR9al87Pqey6IbIu8eBaHQyeP8E6ANElDRhGusuZWRdHs?=
 =?us-ascii?Q?VjGU8ottlRGdgKP0XdnJOC8VsiHcRd37gRk5NIb/yx93fiB9YvVPed0VNqv2?=
 =?us-ascii?Q?VfdCtKwJGBexUBr3AQc21wSrHO5zHxuuFy8YnV9BqSj812ZHJ3roOCjCkvNs?=
 =?us-ascii?Q?ZnuhlRXr2/g0NJ5nSGr1OFlMdvzO9MMc+fzp/G3w3qz2oEjhTl0ePhzw7lzi?=
 =?us-ascii?Q?RHgC+81FIwe86DTqTIb10OcreU22gBp6zQNwP2FmYKIcomy7d4V1jECoz+UX?=
 =?us-ascii?Q?JLd0z9c9/DQHWsmf5KgEk0/GZhLF4D5Ora5kGOXO/G/pVTRZwv/FM6xAL1mb?=
 =?us-ascii?Q?dSpXG70KLI06YJQ+T/8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722386f3-dfb2-47d1-dcdd-08d9b913c9ad
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 23:54:49.2059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dG0v8yLKP7dj/Dt7esrOz9wGYIqMQBOYuIAsdqBRmGnRx4lI+O7mHYI88Tdb/w2b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Dec 04, 2021 at 11:49:04PM +0000, Colin Ian King wrote:
> The pointer mm is assigned a value but it is never used. The pointer
> is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
