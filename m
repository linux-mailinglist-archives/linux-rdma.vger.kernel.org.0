Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325704AA4B0
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Feb 2022 00:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378408AbiBDX4D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Feb 2022 18:56:03 -0500
Received: from mail-mw2nam10on2089.outbound.protection.outlook.com ([40.107.94.89]:11360
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1359219AbiBDX4D (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMJWmW/j3zxxMQtk4Ysd8KnC4mWQtVBP+nt2qqzPSkNL+v3ezNXSQE/5fxnDaEEfoqk9SeY/ygyrSg/LiGGMgPR5p0s1fF6mdwezJNZ4qlU26TGeUj/+jyxayJpuZLYomKIddZcw7xOie0/pEhLCbVXtBa12jeC0We9vuVzEyzqma7OD0mn1Pfi0RfnBiQDC8tEX6RaYvzDP/mDEi7GPIqV85NAvDnoam3GzgVJb4FK4JSQea0VHijFdg/AGq68gPbaFxUD75aChzYzIIY9zlhaeLll2/sThd0bvWNK6GUQ3rxCVCvL6Kr8f3EiV2UrKPCH9y+X/yGqAvaLkDsXiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So6MFm/M9PkAz0riZ5fmwatX9HpJVHVzXlrnNQzlKCU=;
 b=HLMXTXsZFI2K7tMfzlOhfdw40BzCztKtb+EFq6+zpX8FPERGHOdNXFyDci/QfO0+CCH4hCKyclhMeL+7/2fswXurRveI103krLi+fZm7hVp1tBVBT0VIcgDdxTspnmKzGKRHPMszHCpSHobr5kywcrmgcssARJ+R/dlSe5U2Ca8VsgNBGofv8bFkJL4Ki06RkACJk4lcgd134+yu1VaiXGX3dDdyyC5ZvDAfSdqN+jro2M0s2eAvtIIbTC019FA0DwWfD+8cUxHX7Z3c8YZLp0lLR3/HAtcOvyevkS69YbFRl3fp8lTadnqaqS26lZxcvF91ziV93/IB4bZCRppvbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So6MFm/M9PkAz0riZ5fmwatX9HpJVHVzXlrnNQzlKCU=;
 b=uObWNFZRr2viik6NEu6c+ow3DJm9IN9F04FCXTVEzT7VVkKMd2MA830eeEdMJBIH8yQ8E3u3eEYZ4qAIjuOiVTG2KmKqm5GpB0ppK1eY+rKxiPyYtH86+LfxoSXve73jP57MxI+VSH1bHrVmT6faVV03qRq2fsUAawZMiKAqGD7DJplX7xb9JesiogGKZQDKCQhdJTGaiE2c1BFfb0MMIg46Lm0OnFv5zjd8/lcqTdA7y7MJjbVpu0NPSdBDCq9xhAFEobIQwnKvD2ux9/VN3nHi7TjRin8pkX65NcEwDjtxtpNLRVTUQ7yZC1ySFb/JTpiEqC0vdejj4EAG9OHPQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 23:56:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 23:56:01 +0000
Date:   Fri, 4 Feb 2022 19:55:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Haimin Zhang <tcs.kernel@gmail.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Leon Romanovsky <leon@kernel.org>,
        Weihang Li <liweihang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Dasaratharaman Chandramouli 
        <dasaratharaman.chandramouli@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-rdma@vger.kernel.org,
        security@kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] RDMA/ucma: RDMA/ucma: fix a kernel-infoleak in
 ucma_init_qp_attr()
Message-ID: <20220204235559.GA2794860@nvidia.com>
References: <20220204100036.GA12348@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204100036.GA12348@kili>
X-ClientProxiedBy: MN2PR19CA0030.namprd19.prod.outlook.com
 (2603:10b6:208:178::43) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bee1138f-1dd8-4247-06af-08d9e839e571
X-MS-TrafficTypeDiagnostic: SA1PR12MB5671:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB56712CFEF6ABD57D9FC3762FC2299@SA1PR12MB5671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7YBadGhClMfVY+OHByPiEw11VCx96VemAoOjLd4SRXVmvEhKpXjNOMJiqW39U0MsXG6ZA4ZXU9dh7d4o+5BY57hF4eaLYZ3vHk5DmLNZLXNN9G4vA2Xs0Bn1i1T90I2LZXN44X4cpMNPiC7tjVfMkR5tCJ6mTeydfKC6ZcwLODGdPbXw4NtwP6FP0LzIBoh2Afyi3eaWDrtHoDIY+btVj7d1hdMCelwXwOdcpy4P5wuD1uu+N9D0kXgSHThf07B74P2Jl3IKJk/cxqzBdq97bB57hQ5gcN79dx4HfCm3RHbWEIrGr5EdAoO+Zx9xWAuEf67+wl0HNVqNa4rNFSMYg3Xer79kPm2Y/nkQuH7twTkuw2c6opCOO644aaAAdg+B1MFCwKGTovusz3iBlzErK1+EEMBiEGyA2vJ86JdKnII7bl0ZkU0q1tSmkHKlQQo7YLgfNG6JXZhfkoWIXnbV9mN7tv0OcOA1bxmPtScAt2D/vV71sotrFzU8bzxzLW5jB2nRcyYXbU+8th6Mvi3wRvX1vFlCYd0yms10sXh1M+dImw0ViKHjqoVi9kLaP9Dmg5u09ewpzlHOObO81F9QSqoM+Fz3SX41mdEjG/EQ6u8e7x6YTxM7mcaUDdg7PY4GeogzlMs5N6SQyhBv78C9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(4326008)(2906002)(4744005)(33656002)(5660300002)(8936002)(36756003)(6916009)(54906003)(86362001)(6486002)(316002)(66946007)(26005)(6506007)(2616005)(8676002)(6512007)(66476007)(7416002)(508600001)(1076003)(66556008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IfzET1BnAO8XGzvqxmwvq22U43RBMkGftuUKiQDfAhP9ad7iJzKFrO94EfJG?=
 =?us-ascii?Q?IerkRp0qSpsSrhuqY0jwFcqerO6diQEOmhlLkKkP6gTLaM7FLk8p3aY7i6fh?=
 =?us-ascii?Q?JPci8PfLzax4GEQBWZzFO/9X7KNB/cdloK81uteJiJiDPlkh3vFWPt99rly5?=
 =?us-ascii?Q?+IjI9pUHejFzikWPpOjiR2Ct2tIUwGt9DrqsGefICZhbzcFVYCP1jzpuEU4u?=
 =?us-ascii?Q?kNkPUBhNEPzZWde6ZgGB8J3mwc/X3/bfCSzkNYjf+lLB4LNB+HwXVTrILmJx?=
 =?us-ascii?Q?q4ly4eVNfSqe8HDAioCGUDSivphUniH8+bTGjE0OrXPq0pQ5mcMApy4ZH7pt?=
 =?us-ascii?Q?MU7+I91MRl6RwAvoC6dDP9esiMAYSqTCBGBhlROC3ZEdcum/A/LhBkmppjdP?=
 =?us-ascii?Q?Nmb5YGg1mxSF+gGSE1PufucCfD6On2oA0yymRIRDeq3tFO9V+JJd5CpJgPJp?=
 =?us-ascii?Q?3Ke2d53TnRkWw821VVGVo8pr6vOC3X1teRMokMu4LyQbAjcCTB+9yak/HAk2?=
 =?us-ascii?Q?O/QB/L8GvNa0gF21ixumu516NAUO0rIz7aCkhxpOyqxDeyvRwROrAxCRiX8z?=
 =?us-ascii?Q?2VS3a9msF3HZmdytTz02zQDq5qHyH58eiCQMyAjwMh/WJ4fY/9GbbDZcF3bR?=
 =?us-ascii?Q?tso+b2xpdqMjR4bXodzLfIQSIe9v7NZF6McRMBXB15RGKyoyJ71sdQw8BGFr?=
 =?us-ascii?Q?bcyeAcGkOXQN1I3wt0Z417iGW+yYVBxXKhxri85xxSEkr6fK2GcdamYc+baG?=
 =?us-ascii?Q?IsQuaZGFBXcSFy3V3O1eS80p7lCbMHdGba7Xo3UJLjZQRNoxG+zn8IPJofHn?=
 =?us-ascii?Q?QchbH1KRjhXTTHBUU8j6+W9QIsWC3BQIivOhcdONaZzT1Ioa4P4J+uzmLOeX?=
 =?us-ascii?Q?EMqONvFGzJP5lKd1WD7bYoZgmz3V0BGA7JiG+myshAD1wqPToDAjmnr6bes5?=
 =?us-ascii?Q?dSdE2dQpJ+jampmcFhZCEsE5nSVg5Po2mjDZXiP1DohGwWqb1WrS+9rmsneM?=
 =?us-ascii?Q?bM1KSV2ijYQIr9jo6wVtpT6keI3pToVSz9Ms8rgCl1fGBFKED06xNgf80WUm?=
 =?us-ascii?Q?ED6dl/zUDA/ROpvWSI7KLcamHqH4OP9X5l7HccdiaWDUgQz0p1PuCGQi0qzh?=
 =?us-ascii?Q?+nFfzQ35et7KngNw3DhBzdJPSc/t6SFbCUNDjH0P2sPERuScCqCZrCeV0h6+?=
 =?us-ascii?Q?5zKJaWNd9si3qR5c5vbAvzpHgszjso28nUk46Pz/OJ9wltGYo7PUfXYwDCDa?=
 =?us-ascii?Q?B64GtyqyoaIsYmMeZIFWImFUnJBhZFB61VckQjxB4oFHRatXits7Mxv2Wo1F?=
 =?us-ascii?Q?W9y+E5AbD0Z6wgSV/Sa4R6w1OSCyfUrHTe8w2NxVAmoNWlITjIj/5cRd+59Z?=
 =?us-ascii?Q?2Una7RoMH1bd1TorR7jgj11zXv9eWVoFiFqP3n4ax1AhzFH7b+pYob+JLeul?=
 =?us-ascii?Q?3fSjfYmtSO4GiVDKqGRqev09EOZrkFwFD9TntfInIWxsyE/Y6z+mehF/M/7G?=
 =?us-ascii?Q?Ac/iiO7NKWe3IkecWi6C7Tt5M1dvxI3Cy6mN6EhZydlf8o0PhYJkJ76/IPkm?=
 =?us-ascii?Q?+kV157bs5lrNQajIioE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee1138f-1dd8-4247-06af-08d9e839e571
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 23:56:01.2473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uaxpA5xjNs7goSxpiIRVK7zcHs4RsaIn3R7jEmXtojnC3xkyJ9+n5pEqD0dZ/Ga
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 04, 2022 at 01:00:36PM +0300, Dan Carpenter wrote:
> From: Haimin Zhang <tcs.kernel@gmail.com>
> 
> The ib_copy_ah_attr_to_user() function only initializes "resp.grh" if
> the "resp.is_global" flag is set.  Unfortunately, this data is copied to
> the user and copying uninitialized stack data to the user is an
> information leak.  Zero out the whole "resp" struct to be safe.

Hasn't this already been fixed, and more comprehensively too?

commit b35a0f4dd544eaa6162b6d2f13a2557a121ae5fd
Author: Leon Romanovsky <leon@kernel.org>
Date:   Tue Jan 4 14:21:52 2022 +0200

    RDMA/core: Don't infoleak GRH fields
    
    If dst->is_global field is not set, the GRH fields are not cleared
    and the following infoleak is reported.

Jason
