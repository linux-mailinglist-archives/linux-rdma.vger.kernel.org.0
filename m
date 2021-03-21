Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E5334323E
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 13:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCUMHo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 08:07:44 -0400
Received: from mail-eopbgr700050.outbound.protection.outlook.com ([40.107.70.50]:19456
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229834AbhCUMHa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Mar 2021 08:07:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrCkQk7sMSDoV1GRsg3pxuXhayeQsqbQY8y00mf5cKCK6dXuP/gMT5wwMj5IwmRiEVUy3O7ov+sHjRR4qXV5AlfHfOZhl8cCdv3aw6U/pA7HyUwz5lLTYfMu1vL6EmQ2xoWrqn3gQ01avKoPPC7xZSKxHDQfXmkgWcSe+LA27eDJzi1N++5Y/tAhjEMCHxe0pY5p3jdj0EzfSlrTzffl8PjrvxVg895bpJyCvmQb0JAtfKVh+AHlItqEYFZ/zRj4ijAL2NLguJNompS/eS+U4OstyBEanK1XHz1MwAWDaK8Tuzk3KGAkYakMF4r+vCAxqhBvOwe398wCwYfeNtBkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJCvcyIP6G12op5E2i++RqLPc3lbiWm02+nivEAB8+M=;
 b=fxV6IgMxHmmBQJTdqr2A77OxVGyiHrZqTmZoxgT00D3jM4vAy580QLUX4SWga9/O+M1pChi6C8WyyoG5HkR9OXBEHqtTnms2SyWSTGnH1RTRPXQQzbY1ehrcr5uE41mHvh1g9hWcUTwKf/VPvrlEyyMCR77shTjNKfF+HbucGL0Jxr6xOIEsAFmSI07C3j04pUOHzVcAyT8BFL0+GOwPqblLlADHiy0kUI1/KB8sQ0a9B6SCZs5CzNsOKBK/YupIHOlw/S3BalBIZSSTyJavgc3bojbZ0LdnJAudBzP232rkcYKygCzz35m8YZdPAYg2AWAjJCfCKInfdQmjq0bTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJCvcyIP6G12op5E2i++RqLPc3lbiWm02+nivEAB8+M=;
 b=jbCsiuhvsvy227E9TYhcH4PuCHoq+pLAg6atLNND3kMnsSIcVMgUWaEDja65+Cn7su85RJBIObaVZ9F+jxjWbNgl4d6tRdUqsYqGUW61PIjtPgXh9OhDhYcYN2yXNvLjJ1i/+cf8soil2ZlFn7KAOW8Ff/579CA8LMmoCdN/+7i+9aI4GZ3GRAHO54lNm4K9BO3VM5UVp0ld93HHkYmcEDBDeZYR4qTUg0pyxG9TFGiKwvuNhf2Frc1u57w4nmkb9QD6snJJIC6rlf6F+WhfNsEWtzXIo4dk8pdIQHFYxLQTotZd/R6cC9ZAwN9pwoG9bNvbbQm0MppwUu3T+IF4sA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sun, 21 Mar
 2021 12:07:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Sun, 21 Mar 2021
 12:07:28 +0000
Date:   Sun, 21 Mar 2021 09:07:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
Message-ID: <20210321120725.GK2356281@nvidia.com>
References: <CAD=hENdqu3v5_PJwQF2=zQ6ifGZD_DUJtUStoiCA5byru5phaA@mail.gmail.com>
 <CAD=hENf07aKBivP93tN9CAR4oZ9jEygmVKowpxGTdAAV9pjpEA@mail.gmail.com>
 <20210312140104.GX2356281@nvidia.com>
 <CAD=hENcNLNvX1isjUYutfsDrXzjpJZWBMaB4EkeBMTz7F4x=pw@mail.gmail.com>
 <20210319130059.GQ2356281@nvidia.com>
 <CAD=hENfH6CZ5AFZ4jVTguA75eLFk0w1JVMzu0od_XGQPfxHTtw@mail.gmail.com>
 <20210319134845.GR2356281@nvidia.com>
 <CAD=hENcN8dfD9ZGQ-2in2dUeJ9Wzd2+WFWFbhUgovxwCrETL1A@mail.gmail.com>
 <20210320203832.GJ2356281@nvidia.com>
 <CAD=hENf2mcmCk+22dt8H_O1FRFUQzcLqiknEzoOma=_VR0fz+g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENf2mcmCk+22dt8H_O1FRFUQzcLqiknEzoOma=_VR0fz+g@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:207:3c::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:207:3c::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sun, 21 Mar 2021 12:07:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNwrd-000V64-HC; Sun, 21 Mar 2021 09:07:25 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb547c63-a12e-4af8-a7b8-08d8ec61e4cb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3210C2BA2559AC976D6C272EC2669@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wi8uxQlyCFhbTo3vpO3PTJKS2ikXlIUp8k1DsP1utXbjm6d24sHQwHFUvzNoyUm/9pOWic3l14baUVJXHZPuWBnxB7cmgr152EowCCYO8u0Mg7JNcyGc+GpjBgkJnzgG20epOHjQD+50zNVHnJ2ejNcDJo2THWMjkFvoIjngSXd+snyNo+t/7kdPwlUkleE/mNXR/FNTJiJOr21rPJi0xxPQH/Pwhxiu8KeS8zQN8x3tlfwVhikM8ztC2RxnwRFHEcq+SCCRZ27ZHkOs96pANVQVPQ8wUgmWzlKHLga9yrn9W0Nf7DkTx0Ka+hahfi3fGbKFQNUO4OCJIt1v2hUmQTrYtYaB6iIFfGnnVhvuS4rhA8SE5lLeWNMTz+FgRmxFUA18GJaysGJ3mJ7l0fxarUVeC0GBSDBtbOyZ2t1GHqOWNhac+xNnbW9O/VEeFTvxG8H2ZFf3KBqGG1LK+uhnAnWKqNoE9NXNyXSLCcaSP3ZrRoouXouEQ/1JjeQb8KSqawwWk/nK7bynVxAjufE3MpO/+piWOlxo/5LClbQr/iWalJVJ3UVgToF3NZQ04a4IwGtsW9l3k51gneVcttPjxXiWa8zeDub1+lIDOMm/kpc6Venx4dH2x4eLYG9qyajJ1M5MncUATsXdWuuS6K2WrGkXFFJgkqU7uUZGHOfp4DQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(107886003)(186003)(6916009)(26005)(5660300002)(426003)(66946007)(66476007)(2906002)(66556008)(8936002)(478600001)(2616005)(86362001)(316002)(4326008)(8676002)(33656002)(1076003)(83380400001)(36756003)(9746002)(9786002)(38100700001)(54906003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MZeug9pn9evUH+aaBqWB8EEtS215CXzR89X8vEWH8ueNH/IGjcVCyKxF2ZMC?=
 =?us-ascii?Q?+xuXnO+uB+zidWIC+jVWN2GIBdjEIp3cEwOG7h8af97FKzfuZHBYVK5mqunU?=
 =?us-ascii?Q?WInVEqqpo7lvuQeinCcTOOzFgzM6AruTEgWhlnuSQGSRmviKXX/PqTsLGFIc?=
 =?us-ascii?Q?MZ6g8WXsnIxVVusraDt5XSrN/yWhIZ1a2Jsbg2yNq6onv7HQynekRzJiXAzg?=
 =?us-ascii?Q?Amds+FWoDDSP5MwoBlCwkLZRn5Zd4MLq2tYC9Z/5umbn9XAB0jOmGB42Lr/1?=
 =?us-ascii?Q?xRtrF3UdHfx/8U09hCxpLN5SOgqDOTatHmyCiBJqRhDsG36QPJthjlYcy/UO?=
 =?us-ascii?Q?+6HrPx9SaW/KTKEkpqwK5suL/5tSCEcDWcFDcbzrl59Gt2pLBResVHuSVLkT?=
 =?us-ascii?Q?TdtvI08gjZDyflIAWt5tL50cZa4AQdI7lGsz8BAoMmhtvPd2KF7030NqWkYI?=
 =?us-ascii?Q?RjC2rpgpDc1530dXLBwPWYqNp1Q1yGwf8KsWIkWGGm6OW+dXJ4tKuEpSTQB0?=
 =?us-ascii?Q?cKUOWZhsNKKALBx0vGdSfN0YLX05x9kOpbYKgllG1pHJqXMJUG9Bl3wOaHZu?=
 =?us-ascii?Q?TFrLTCT8frELARooR4tNpO8W9fWqLfLvxAQ0S0hqWNIB7tqiwvPSHlPqiJF/?=
 =?us-ascii?Q?RhxHxBda2dkROe3cickpVABueLTNA1W/P28++J+NF4VGvg+1WQtNsxui8vln?=
 =?us-ascii?Q?kQuqYsD1DAggM0hT4TkGtvO669wnbk4hq5jkMkh72oPllzOQIbA+cBEpiNU/?=
 =?us-ascii?Q?RI9lrzBsQr1+i6kqohxveMXNVd8mz1rely0UglxowlKXH3SXhs4uSES3HnNf?=
 =?us-ascii?Q?VQQPkeNV4NSyndA4XM5qJSrvTqYDeQ7MY3tOjepgE0LfN9fB0s/IPFTw68ej?=
 =?us-ascii?Q?8zu7cwBM+WrgUIeIIYGkEQB+5Rlz3luFB/djxsNzxM2ibYJoZKGRKxBAtLSA?=
 =?us-ascii?Q?60w+YRYarVorcUqZCylBWAwgeEJcsxx7nWOwK0P7ZFq7uCL3tU7myWZC8opm?=
 =?us-ascii?Q?KNuW77r2sD7CKESLmu9NRepXXwPeBXMTGXilEs7DSZ4kdOGDokvG9msUGQSY?=
 =?us-ascii?Q?H1L3bLB5LZ/X9V1y3zzuKqqMBbH5qqRl/CBmU9pl9K9/YmO83odUos3RiOXf?=
 =?us-ascii?Q?n2kR8Dfio4U3Xh+rtJYeRwLO0YShMQe0NpCBG1HMieZTdT7baXLimBEfejJa?=
 =?us-ascii?Q?GHt0CHPNY+K8rma7vuZVVHicvlk/g2RrzMxNHEsdKapTbbhPz/ZYB+djoxrM?=
 =?us-ascii?Q?p+PDMyEJ/SI6gH+KGmO5bez3sx6ZxbE71zkJrKnevTjS986sXzwV+KiWzSR2?=
 =?us-ascii?Q?tJtODpymmW+cirVUEpYBNim2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb547c63-a12e-4af8-a7b8-08d8ec61e4cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2021 12:07:28.1232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHKuDXj/EpyJo9iidxGVGSNBerheomAfL+01BWUn3ceKKqBJawAPB2E31uTApf7l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 21, 2021 at 04:06:07PM +0800, Zhu Yanjun wrote:
> > > > You are reporting 4k pages, if max_segment is larger than 4k there is
> > > > no such thing as "too big"
> > > >
> > > > I assume it is "too small" because of some maths overflow.
> > >
> > >  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
> > >  460                         if (prv->length + PAGE_SIZE >
> > > max_segment)  <--it max_segment is big, n_pages is zero.
> >
> > What does n_pages have to do with max_segment?
> 
> With the following snippet
> "
>         struct ib_umem *region;
>         region = ib_umem_get(pd->device, start, len, access);
> 
>         page_size = ib_umem_find_best_pgsz(region,
>                                            SZ_4K | SZ_2M | SZ_1G,
>                                            virt);
> "

Can you please stop posting random bits of code that do nothing to
answer the question?

> IMHO, you can reproduce this problem in your local host.

Uh, no, you need to communicate effectively or stop posting please.

Jason
