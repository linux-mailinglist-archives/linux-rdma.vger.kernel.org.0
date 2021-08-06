Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57413E210F
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 03:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbhHFBe3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 21:34:29 -0400
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:62304
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243204AbhHFBe3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Aug 2021 21:34:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0A5h/MNhq6mycFdxwH/HYPkjo8JyE1EYbmgzSu50SBsynEn6LIzFssay3MVgi9zWdZRtt4S8V44g1QgyjNfbUG1MhOnD4YKKA7Fqo2w8aW+e/lQe4qd3eXG22McOA+kXnQ+sLjVQWJQUbcVi4+9E8t5poHwdLbG3K0qqgiI3tpEX2i1SmRfsBgpw8CUJrSB9gJR6fjLPgE6vk4BiUxzxZK09zwo/QN8ubVZ6VKyiJFPPlFxKxZJaUBGX15QB0acy/5+Ko6nMneNfddLx/eGzRwuJoIYbVnlnSa9EA4e//hJCaF6aUFNlQ03yQ8xdc73Y9fFXn2G64Xn6DF2bnHhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icb+QQmCOeANR+69foAWXEpPs0c/P5s7AbUUydc5Pjo=;
 b=AXCY7n3ImpC2HTi+HYWhfQBC/iH4poyPK7/j4DCwuEXnx2JppfKKB1MPbWqzjGhIBzysxqbcuAIx6Rguo8NfH7r7HByHbKsw7JACm5xJU/pDeZ+jOSubzEVp/dMEOqNQrTiFiBjy0QyyeVPAF23F2JlnyOpt9ywtrva4BL+sdQ961kdxG6DKdtS2HJdrqlUoudC/hjlJXKto0xDwcP3P44h/D7FNBrUM1/lDmnYyI0A881KzLQeBcWuqE844PfQCD1WOCDL6/zWtbE57qPfpy9lBHJ5nSehJ6Wq37qNj6cFSEiLlyHVXyLALLnbxBp8XYVVFAIXoZW9sJiF6RdjMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icb+QQmCOeANR+69foAWXEpPs0c/P5s7AbUUydc5Pjo=;
 b=iry1nS4ey/D7YpUGylOIWlKJHWqZnENmn5+RWCzPA/GyzGM98lgRh9F5EsxvtB+E8oseFQd75GLcvG9geK49N+eZjg8tIViDE4gKTTA1IEBVKrSJQ4tXAoSAPAjtL+3maotNfgII/yaj0pBMl3vZkzOQdtqq//Z+2Lg58LkT/GYTWR4Z3U9ylm8XjFIQjH3w9cSiUXE+KXTBS1rQCl618NNmCc77QzCa71HrjNBRCoQqCfJZvFFsfxilvCYbTxrwoICVNocMYWyzpTJLl3jdgI5nl82MRC0g7Oqba+TkIgIgbEpsmG0VIN1vHFfEl0p08IR3PL/wrw6TMrFv9N1V4Q==
Authentication-Results: chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 6 Aug
 2021 01:34:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%7]) with mapi id 15.20.4394.018; Fri, 6 Aug 2021
 01:34:13 +0000
Date:   Thu, 5 Aug 2021 22:34:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dakshaja Uppalapati <dakshaja@chelsio.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, bharat@chelsio.com
Subject: Re: [PATCH v1 for-rc] iw_cxgb4: Fix refcount underflow while
 destroying cqs.
Message-ID: <20210806013412.GA3319081@nvidia.com>
References: <1628167412-12114-1-git-send-email-dakshaja@chelsio.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628167412-12114-1-git-send-email-dakshaja@chelsio.com>
X-ClientProxiedBy: MN2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:208:1a0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Fri, 6 Aug 2021 01:34:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mBokW-00DvSU-A4; Thu, 05 Aug 2021 22:34:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4588e30-83db-4475-eb46-08d9587a4bde
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5174EDE318EB5128A1848D6AC2F39@BL1PR12MB5174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pjd4yO+69R1GSXtO2mIcTeN0GrsRcHxLaEMlYKMnH/UyfI8LMrblDSsZz7GM7ah7nm94zuMFKqTi8Wi3wA3pCQcgiC61t2s0PQDv/GeF9HrthWUjdPjJmXxaI4LhXmOsH3TY4fyEnrB1eB+NHIfL/63E2e0fYyOXbTH91uIHphPF3KIXIfPLY4Y3duiMkl7+WsrJRbZahSij0gNkxep8+G8ornEm0SzNVDV8+kWCNFnzew31wzjGPkDCDGWn5oilvlAC0CEXWD/xgMLCXg+aFVq7S3aMVQ+3qdWsgSnBSzYwBC3YkQ8rJ24Dyg8RXloKuTZFc2cu7cXayzGXtVV49OjRJWQfwokatQeOe1Mh8gQMW7n7Jd8faNTEIbAstxHX9kqOHuPJFAuMxk64U340T7AcE/GD6aKS63qxCjSVvV0U2KLDTPascCnw6xJvOU3YNwkm+KUvFS2gKa8hHEFK5zMpDEw9uByHmVynDWanH5Odiu38kTljY5MRZyc5SgZbohT4wgFHhih1HH/kIzl0D+hAmjcT74IrtGyGDxfB3tG+Sg64CBkMRgemN3q9BojwC8CAp+jC9vgBrGzYoWqXNYwd+NBYRZrf5h3ES/nHsXE2Uiu17ieVBZwO3JL6hZMvkyTxK+J/GWgUWFbWv0pZoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39850400004)(396003)(376002)(1076003)(4326008)(33656002)(36756003)(9746002)(38100700002)(86362001)(9786002)(478600001)(5660300002)(66946007)(2616005)(2906002)(316002)(26005)(186003)(66556008)(6916009)(8936002)(66476007)(83380400001)(8676002)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DYmTlAaGY53eHtLg6myfNrels/K0RNThp5lin2GmIXgM7K4Mun1tnpJnV7Vr?=
 =?us-ascii?Q?Xme81TDSde+9OHB5ZXO/lt6NAvIuAAjEdUFvEKNDhLeCSJiDnp3WoPSMo/BQ?=
 =?us-ascii?Q?DzOnOafxyS55g/kBy1q7o/c64TpHco7M40R3SWQwbRotGV3l40MnwOW6tpHf?=
 =?us-ascii?Q?G8Apb0/vWHUhodWrWByNHXvKp06VEIYQRwSk8px9ZfaEZ2btdsYlmL4ZTm3N?=
 =?us-ascii?Q?a4IL7Jy5g3+UXPpG9+vjWf6LT0pX7bOx9I44mLEpiXqjb4DWro6F7XqyGyXA?=
 =?us-ascii?Q?aFdsV987b4oVcJJSZS/b2qxGoPtim2b5LID0n/j8AC6HaXbZuQuiB+1PCJdY?=
 =?us-ascii?Q?SoOrvpQBdWtYNuLsaF6fdYfPN98AZqK+E5KQYkbgrd1PYyf2CHQ73sfhGyEg?=
 =?us-ascii?Q?jiTRSHJZ4QPKnSFypQReyKaum8rpQqRnA8lzJv2xyepSr2EhLthg0QGl6WKQ?=
 =?us-ascii?Q?SMTmM6Vu8nG5VzK8o+IKoDqyIScbt09w8NASGpWKH4rH5Yk+ErimRVkP5Otc?=
 =?us-ascii?Q?MI3yoVaiYsBahwjV/GiKfCQIALMBcJX8wSpuRl8Y9DoCUJIbVPDUEoOQ8tzo?=
 =?us-ascii?Q?95JYNYBqzqaUeHSw1nSLI2217li1UmugyPCFlh3q+byzR75rbpMPwCAhtsfy?=
 =?us-ascii?Q?j3mw05fLlU4DPC8YvvUHtqh6rqrPN4v6ZOLFIij2VpsNitENmYzYv1Yv090u?=
 =?us-ascii?Q?eFipfi1RiQd4phgJbqNyBORkOvmNNyjdmRYs4h3N9Zalf2XbJ3j1YXc/qBBy?=
 =?us-ascii?Q?xsxW1qZMoKKm5ljcvMMF5wyjHwds0VefZ849wbNVDGH5tb/r+sPma9HHhXTJ?=
 =?us-ascii?Q?A+tjZ6hFHdiV8LEVTrBhjeSZE7uWhIKx2ma0odAXLkTXqxcs5jhL7UNXtM4u?=
 =?us-ascii?Q?Kp/ySfN/th4ukwMfNhbyKpijTl3/jHO8RnaLSyjB5FX2h7UG/XIwtkwEjqcp?=
 =?us-ascii?Q?4K+g49XyxXLM+mzgNo9eD3bd189al+du8sIXMOaM/rbZRFbrRAIG192gpIRH?=
 =?us-ascii?Q?MicLZFyUxsuWuBp2yXi6cob5vjLatVDy0KzTNya6CiuXtLDJs2AOB+Jns37i?=
 =?us-ascii?Q?S/b+5cV6ucIInpoWggKPUfHe1+rrMR4nuB8JvG0lRu3SB5WRzHcw1wsEwxNG?=
 =?us-ascii?Q?CPxNi/ztRP9bSlhh4l4tzE2NeMJaCQVdHpsNuSKN8G8TGA1pzAx0br3b+chi?=
 =?us-ascii?Q?WGtun8nBeexL+wgMA2pPdUuV0PLHFXEQFSKigJMNKY4M/JwaUui/bfZAkRKF?=
 =?us-ascii?Q?SQmH7G7F3Te7knVkG0KBeKa5ar1LNfI9o6+OlIhHphL2f9dCct8zu0RJlFvi?=
 =?us-ascii?Q?6L4739vbqw8FjBHBsAb28kFb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4588e30-83db-4475-eb46-08d9587a4bde
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 01:34:13.3582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ok51J2j/CpAgFcZodD/r3ZdQkmEDdzVUJbpHV6Bf/2jcKFOfd90aluj26GEqnotp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 05, 2021 at 06:13:32PM +0530, Dakshaja Uppalapati wrote:
> Previous atomic increment decrement logic expects the atomic count
> to be '0' after the final decrement. Replacing atomic count with
> refcount does not allow that, as refcount_dec() considers count of 1
> as underflow. Therefore fix the current refcount logic by decrementing
> the refcount and test if it is '0' on the final deref in
> c4iw_destroy_cq(). Use wait_for_completion() instead of wait_event().
> 
> Fixes: 7183451f846d (RDMA/cxgb4: Use refcount_t instead of atomic_t for reference counting")
> Signed-off-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
> Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
> changelog:
> v0->v1: used wait for completion instead of wait_event.
> ---
>  drivers/infiniband/hw/cxgb4/cq.c       | 12 +++++++++---
>  drivers/infiniband/hw/cxgb4/ev.c       |  6 ++----
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  3 ++-
>  3 files changed, 13 insertions(+), 8 deletions(-)

There were several errors in the patch, damaged white space, bad fixes
line. Please be more careful in future. I corrected them and applied
to for-rc, thanks
 
Jason
