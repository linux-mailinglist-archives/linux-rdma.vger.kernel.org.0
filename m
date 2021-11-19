Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BE9457642
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 19:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhKSSVf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 13:21:35 -0500
Received: from mail-dm6nam08on2081.outbound.protection.outlook.com ([40.107.102.81]:28000
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232853AbhKSSVe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Nov 2021 13:21:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKZvyuDiMpqJKZa0eA681ZPE7VLZqYsbJcJc3YaMetGFHMCdfdL2oidigjm6AGqeKF9j+oYsUdET7ZHmRHwr29/ci9Yji4+BHY6/ClfeOZpJ3yo4wl9YPa7wwcvrPKX/o4ZMmcbzYbjsOAb8DCKl1B9IX7TIoXgIlkuD/sRuTqLHU5wRLORqfTHYnd8P+g5o04W2QTAFWolUlbB6kWBgtpjI7mB3H1QYtTKUic8yAg6u027twmYndFdnCrEtb9w7oCsZrb+mMPssMJwAx6xucnaLJGr5X7Y8CjgSO08tPveamRM18xkQoyYi1Q9x4j8Ba6xuWpIXAPV9wLhyJ7vWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgKT8PHIVxuGO3916SFQaO+GkLdkCNDIY4JBllFI1TE=;
 b=hx2KLTtLHfQx7MjajvYViC9D4GNlpY7EyGxhdwPimoH/2mE3PDy1K96ZYB+9VFouklNh5ejeVH4vySxaxLHDyJkie3O1PgazPQFvBXCI5vkM8hQjZMhmvtSbLHGv78tvxPcLz0DJbU2pMIMRPzmZZdpiwjKWqpjDhJY8lNhRLRbQ7n/P2dSW7vP3X3CNFZ+CPg7YEGMeVZWW6wYKBwhSmfjxU5B4YdvUQhhvN6NSxwU4H8AgaaBTxHj2SGvc8FhpVpyWROJt5SWL4ZJYyB+1Jr3Pfbga9mMX6iIgYWJ3Y0JjJOOanhKbEgg36gE3OmyHzqFTmN3PDQalofxnWUQ1fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgKT8PHIVxuGO3916SFQaO+GkLdkCNDIY4JBllFI1TE=;
 b=Z2omVDk12Dy/4z7c3UyhHwdWlZaOcnnCDM7D5TZHJKubz7pXWPi7VnFjaiJYk370OhigC68VhAJONr+fsUoiakyANxhUMErMa9w2gerPXWc1sQIJXNjhusMU+SYRlTozBoEZNf3Cdz0D+nl8eg+7VEWfkMmHK7j7MJfQfHXB+3vyHYz6TagzB4Ylf5RtiKrrQAo7wHQEIwuH8xime7gr9oEC3o/GVyzaWy4VVdgw+sxk3GJ1boy1afcl5s7e0LMr3eE5vgV/bB5iEhH9pV6Ak8t5ib++b1vzLeq2/w1t/fjPvWvWdIQXVDEPWKu2ZY5qSihHPptBEshEjtaIu6Zynw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5029.namprd12.prod.outlook.com (2603:10b6:208:310::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Fri, 19 Nov
 2021 18:18:31 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 18:18:31 +0000
Date:   Fri, 19 Nov 2021 14:18:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/9] RDMA/hns: Cleanup for clearing static
 warnings
Message-ID: <20211119181829.GA3000824@nvidia.com>
References: <20211119140208.40416-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119140208.40416-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL0PR01CA0024.prod.exchangelabs.com (2603:10b6:208:71::37)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR01CA0024.prod.exchangelabs.com (2603:10b6:208:71::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 18:18:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mo8Sz-00Cafq-R9; Fri, 19 Nov 2021 14:18:29 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d498a2e8-6619-48c2-224d-08d9ab88fdc7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5029:
X-Microsoft-Antispam-PRVS: <BL1PR12MB502945EF98C23D023F17B809C29C9@BL1PR12MB5029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rM3Q7HyYV42vKacOSip8L9MG3s6LLmc+cWUGCiQn8HMVGKJnW73G2d+eF+nqvT+8umxRKAwF5ccgDKWJcE19Fw6TVg3R89UZibSwF8JgACJKMtboVgnMMsL7PUuSwHEpZsUdyJ9QNOOuhxvdkGGaG7A6DGr5o/9bj0qDr6znbUfPQskOip8jN+SoEw/tKRKi/U9uoSpked7dDh4P/rAttOp65bdU3b/RmM19sDcrDVbSqINtxJ/DchM8UGDQImN3tNmzDA+Ft2sXxUh80Eh+UIvthMFvaiQf0SMr3uS9ValoLN5Xxo4iRJ3InlCxRACzpLylKwb44Iedzab+Ub8EDHkwxoOsYm1HRLHw5Y8Z+Bx4VVvjGOgt8WRKDuKKPmwebznT9+OZ8W9fMHi6ILHLw2ZNX5p73/lOBvtj4C/UYPqjqSaM4KNVKLi8C8x5d1i7wfVs/p786a5WNRb1VXDEJwWlYsyDknKoLO7/RKeaXOZpI4HyFz1DbVFC0rTlNC4n4jT9XTdd80YVPMPapTIZHwq8Bbgh5tq7C5Qa/cOMdHRNTVTyroq6cIM8Tit9c2uYZCATBOPCFEG9SiNfADvaRgXc5Cpiu548gCGfxozBXi1kUlw7WWPwiKNCIklBzT76tiUAkyfSwu9Eu3CHsoQm7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(4744005)(8676002)(9746002)(6916009)(33656002)(86362001)(8936002)(2906002)(9786002)(36756003)(26005)(508600001)(38100700002)(5660300002)(66476007)(426003)(66946007)(316002)(186003)(66556008)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LBpCNanruyZkCaKJU2bKeztA8nHF+uasXLh13n7gNSUU/errHEzLiby4kVu/?=
 =?us-ascii?Q?+pzXkHCtbRplfGjkLPDQvkLg9yL+stpQ/984kM4rT3Lr8+75ryUOMYVOKukp?=
 =?us-ascii?Q?4tD6JrSzgYjTnJt5MNnNRrCDguGbMDO5oonLbSXPntZjSVwSufX+6ymMJpE6?=
 =?us-ascii?Q?PP6IBoTiaoxFXsxzG5cdSsT6KdHL53dk2bvVEOBB1a3amF57IZ8yZECNUqv3?=
 =?us-ascii?Q?letnKDUTgtDliXRkULwBZBTD+jBdQiR9fVshgFuyc1Yx+sb05GI3RkLHLbED?=
 =?us-ascii?Q?jS6DVVadAA2n043OoPjLk0tITFG2fSqo8M/7phpGWxJ1cZMNlFxdIwP9nRKF?=
 =?us-ascii?Q?C5Wn8MM0x3RQ1/FSnwnRftV5zPlMGUiMBVMODG2AOU/8HF5Q3OFd0fBpjT8b?=
 =?us-ascii?Q?tX9Q7mhK0pwoh23lSH3HF6Xjl8jDuDXFtg1CpiuloeYFVHWGPZjpfW/5hlWu?=
 =?us-ascii?Q?WBnpCpQwl4N89AuWeriHq6TVMSKkcsmPl/cO9lCrYX4GpUQknzXSrpqKE+6D?=
 =?us-ascii?Q?/XkYFMJrQsV9RO0qsKa0skWo7w83SM4mxvl0YRCg96JamLRqILpUvO8pFxqJ?=
 =?us-ascii?Q?1LJF+yxvqaqYNtWPpfeSbL++20F7e5YmMpsSdhe6WTdndr2DD7iyfTf5Pl6s?=
 =?us-ascii?Q?iEwGubwnBBMW9dflfVSfw13qW08QPuTSwec5s+dPwxJBgzG29XPJwLw/GZ8P?=
 =?us-ascii?Q?q2sZKj+pzFErzNCRlrN9zUW3g7zUoaIBcGRZPc5DAx43oCKv/yB5DbHsE9PT?=
 =?us-ascii?Q?4+orCWyLGsBKyuk/YLsOedIwLT3fcoVX6wKs2djiWztBpzZ90M3dnkeQOZJ6?=
 =?us-ascii?Q?6C81VGyzdGKgudniL33bu8byffu5trzTuwLnb8M2MnILev0JT7KhvEbvYaa2?=
 =?us-ascii?Q?AiAVF8lwwszSibKjXXfnCMo4OTzD8jStr21YjhI8GueNcb1cPreGtNpi0d7W?=
 =?us-ascii?Q?MUR3xDgOxIkPDO4QssbR/MTLzeAhib/FwYUVgg5G2pQeOW/g0tzkBwhO01Z8?=
 =?us-ascii?Q?cFEXZaz2fu5gUy/tEdDZObC/F17doGcv6JGQ6O8JnJ1ZCGZZzKkDQJEyVuIL?=
 =?us-ascii?Q?i3oRo6V172JRUsjwRqb22yFUBOhtjsKppFHhJZF+At6Q7pM2Ob3NEtx7lshl?=
 =?us-ascii?Q?Bs6I3Rl1RIXvspcWR7JWVxuH/6AbuinvFzLnB2trbqc1xgXvT6Bul/VZIcxH?=
 =?us-ascii?Q?KTL9ZcAnSrmwcfnxHWkOedvYpMffOJmUA0ztQbrqhmhA9wEyWDcCYuoqbGtB?=
 =?us-ascii?Q?KkNhBCo/jugGXFtn8Emyg8Si3mm9skMXFns6wRRH6mWsRJuQY3P28zi7e6pv?=
 =?us-ascii?Q?n7PrGrXfSrrBDvYr6e08a29vJYv7ViTbbKQdTq9utPz9Is+kn6VapGTm8U7u?=
 =?us-ascii?Q?6j15DtbuJwxK5E4SYzNCW/mja+1wedw7fc3igrJDYMhDeRUBgwMOejV+qsmi?=
 =?us-ascii?Q?e5CeQ3IX9axsM2mhF1sb/dQIeJ16aQYafvDdkM34lEnxkFAGy2Mfa96fmK/K?=
 =?us-ascii?Q?L3YX7d/uEXAtYCBVmwdsCyEuB4TvKlMohuhGeXoLLLnF1rM1UxCm8f8PHpU8?=
 =?us-ascii?Q?JnNNR1y7HSpXNBuVIdg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d498a2e8-6619-48c2-224d-08d9ab88fdc7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 18:18:31.3115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caAwEkQ1asUJiugSY1yaJN/mo/jcx4NeukHLw28nYArKe2OygWaO03D0ID+QJHWX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 19, 2021 at 10:01:59PM +0800, Wenpeng Liang wrote:

>   RDMA/hns: Correct the hex print format
>   RDMA/hns: Correct the print format to be consistent with the variable
>     type
>   RDMA/hns: Replace tab with space in the right-side comments
>   RDMA/hns: Correct the type of variables participating in the shift
>     operation
>   RDMA/hns: Correctly initialize the members of Array[][]
>   RDMA/hns: Remove magic number

I took these patches to for-next

>   RDMA/hns: Initialize variable in the right place
>   RDMA/hns: Add void conversion for function whose return value is not
>     used

Not keen on these

Thanks,
Jason
