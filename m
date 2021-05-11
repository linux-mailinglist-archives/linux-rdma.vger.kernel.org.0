Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D837AFF0
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 22:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhEKUHj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 16:07:39 -0400
Received: from mail-dm3nam07on2082.outbound.protection.outlook.com ([40.107.95.82]:45409
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229548AbhEKUHj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 16:07:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLCsxzklZcYP9guTWKFCXZ2W+fEVV6tBnk3Km0yTQtqnElcCoLMl+XfHCwXUVMyTlHey1ZrYBM7cV4QlIRQAoDcasATjeRyQAwRpuOxnzUi7G4cn1hEcrJdxT7cKgquum/s6NbbMQkz5Rn7GcNSnPe6Apx4+CfhbIKi/CGS/fS36Z6kLu3XKwFyYN2fu1u9+HyUeLoJENZUMBo9GUaObbwQwdMI+nVc++Zd0BfScFtW/PPGRSVK70hUjtiA28PUUOwT3vPv7TjkqHx5kpLTkwyHIcdAGv7hZPMk49soP2vTApiR32z8yQeYHGkr62McPgdeYC0muqh6jB32WoH555g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3JpAoPtZAFwlUG4liogpnHdRhjtlAzdoTrhe7XgRDQ=;
 b=dcrpCV5NMwUmMSCRBGZz7bO8Dl72X/9TKq35tTad7gHCchTcG6iJpJwfooDEs15JmK9UFHtsKzHV9DbKF2J+yqtG3j2COeUrnIA4irEpPpiCsKgkDBrCe+qWwiFs5xIGEKGsMm8GMYxFjd53VHe/2nOP77uRjgvNT5WDxeW2NlgNa4TUeuUL+8kJ4/rDTPEkT1UI+2a3YWGiflLQEOfddxOvyAuTcemy9jai6wRUU8JIEs8q7bG80mRc+dhndiIvLCdoJkm22a02dUQJQfpMOuiVeHwv/I8YhMZ1g6NeTscoNcOTkwNI62T0F+Ok0I2UApRCVlqYCIjIR+V1MC+SOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3JpAoPtZAFwlUG4liogpnHdRhjtlAzdoTrhe7XgRDQ=;
 b=AuhzkNbN5SxvslqpxlbVb1G0zkBGBoFl1n4ZEy71btCjmZPCJwBH9oHYqXJHXfGewIrF23rQemcBVWl4ow8aXWusb4JKOLossx/8zINoTA2+AOuegXC8099IDze4jI4Dvj+ydj9JDmSRkfLB2mSqDO0xtZF6F0x7jR1lJ/Nzcu9oVhPgqLjIoRdubJoFLh93SBuIU6LM1HwC6Pec/XI9TkOBoItdkhvuP5r8uZbtvNA5oMRYhup+VZBWatbNxSirjjECspsB/QtBFG0i5QsQBIj++Otlzj2yOgs8tnvyqybcOi1EEdxNvhhUC0BrKA8PukWPAa/1gsGfXb3r33yOFg==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1547.namprd12.prod.outlook.com (2603:10b6:4:c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Tue, 11 May 2021 20:06:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 20:06:31 +0000
Date:   Tue, 11 May 2021 17:06:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/1] IB/hfi1: Delete an unneeded bool conversion
Message-ID: <20210511200629.GA1326059@nvidia.com>
References: <20210510120635.3636-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510120635.3636-1-thunder.leizhen@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:207:3d::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0058.namprd02.prod.outlook.com (2603:10b6:207:3d::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 20:06:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgYeD-005Yz4-OZ; Tue, 11 May 2021 17:06:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3c1047b-0903-4f68-0e2d-08d914b8448e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1547:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15473762656F5B39B1939BFEC2539@DM5PR12MB1547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArCVJGIuAE24+yOneoh3GPBASc4L0/Mz5ci7yEySVnbKfSu3wH/HZxY3TuHDLesoggUyMShdxxQaEWYydmeWpQudhIOjr1uvkYK2SPOgA9zTP4bQY6lC0y32lTiDpt2hdjWNRs8WnWemcUipzNIj2XX8KhzoAfWKwzI0C78SDv4ej4q/taHW44Q+tzTE6bCN7GDjakEDPmxFJKX7duWVvEPJFTLiB/k1JUsCPW4ohuJWv+iTocYBZo7uj/c2RRlbAWZJf5Ta9jOugRPTPiXnUOgRju9Sw1gedF+0B90ZEHAqnf09BiTAlFLt2+gLcfLFzP3uXxNSYz59dwXiyhS7/Z0zjWJKH12UzjEvmCYrRF90lUgXkqGveiP67wcMsDSytRwk6SiOybz/t57B0RCjVc3Ok45rXDxVhrMHIssqLNFmSZhj1nU1D5ZAHb4FWLb/SWQiROlPv2nSpotuiR4L11VE9mrvm/X+HQZo1xjMrRu6P2DX4OkgKrV6/azVsZqzZ0glvd+hkAqb5LCwYTwU5H6hQm7mUcsoE/Rv4+tQjILW0Z6Sma0tm48TQ0aKNTx9sMBkQ1MNeboolMsdC3IeWr22FGe0mpstj+Rn9kRgiPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(33656002)(478600001)(26005)(316002)(86362001)(36756003)(2616005)(5660300002)(8936002)(4744005)(426003)(38100700002)(6916009)(8676002)(66476007)(66946007)(66556008)(54906003)(4326008)(9786002)(9746002)(1076003)(186003)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qgYQ3jgk1U2F6SueqqarRIiKgtLawxLGlqnIu8MUH/g7TzUYDHyxvgSyxP5Y?=
 =?us-ascii?Q?Ddy0w0GITCyMYL1KOHc96/la0eRm0WzTcl0LPpwU2UByfizYS8VWm8AhrzWb?=
 =?us-ascii?Q?sxNpXF32XLDv/hiJqVke3WuZ4YuOwpMwfHQm3DcImJSCbcKVLDNOL+ipIj/x?=
 =?us-ascii?Q?zXfPx+GZo6iS0osNlkhVOzdV+4Rrj1DPCzAzCTpO8KNpq4KY3CC2XKEeioYm?=
 =?us-ascii?Q?a9D/Y9FPymAfFyhnZ3jUsNPvI8w4F5nRqSRIvKjQsvj37CTA97lx/2Z99fJM?=
 =?us-ascii?Q?N4NL+lYySDIRFh2xsBaY5Ks9vs9PZl+57Ock97skGlS0LkVMjDAeDW53tm3y?=
 =?us-ascii?Q?CU5lKliv2cFnnBsKNpQwv5OK+Tr/DcxNpMQFLvmyGh7+4beDPqMbv9K5r1oG?=
 =?us-ascii?Q?MJnG29QZ7hobfHeCbAgw0ZR16QS75MIq01do0JkB3JhBgZeGuA9X0Qta7K30?=
 =?us-ascii?Q?p5ipe6TdNHUyuBdUI3geegqnp0u2fD+cCG++HhbccHPequUqHX5hOXjWePSU?=
 =?us-ascii?Q?l2O6Kqroi9KP4tlsUnJ5MuRBqtEg9d8a9BLz2A0U5zEk4wt599EPrqpV/LX2?=
 =?us-ascii?Q?XB6WewQgvRryKXn8XJF/IZ1q0sgH6T5XmUZ2IfDn4FbiRSYDFklnkZAwz0LE?=
 =?us-ascii?Q?jy85PLrojK5wHpUP131CkOr9nlHxzBXw59bcGVySOg2iHDdswYrymiZoZJ7S?=
 =?us-ascii?Q?f9dBAy+H/U7mSz/mdXSbdVUShDsUzFOyNH0qpZyk/npoCfSfxlexcshezUza?=
 =?us-ascii?Q?TvVbLM89CUzwUjRq+TymHsycTBbrwf2tkO1YzUsRCfMsiQKuoQ2Gfqd+P6r/?=
 =?us-ascii?Q?YcDyrmh0dh0zkScwM2sHkIOMksMvaPsj8msKb0TF+BIJeV8aFyEXDXXgvc6s?=
 =?us-ascii?Q?2u78Peh87Q8ERDBvYjGOIYYKOohAHBBDdK1YOyTKHk3j0k+KSm8StIErynIb?=
 =?us-ascii?Q?+lVD0rzE1ONs7sf0LZ9qteAnUyMusGLK6JwTDQ2e1pxDfzW1JxGg9YCHeeZT?=
 =?us-ascii?Q?UwwP47WhNptbbnhtPS0Eqaav6peuJkBGf3Gui8Q++xr5qUOtwA/8Cdha8d1G?=
 =?us-ascii?Q?QHTgvx8fT4Xv8HRbXphtdw5adwo+F7u4iWjbeyfwzgnom5o7XwP0ZLbK7g3K?=
 =?us-ascii?Q?QVMC6dIiGwC3kPSr8ONKChbumetG9akJjijZ2565Yk/rOd8a0k5iyCk1z65T?=
 =?us-ascii?Q?AC16iVhhFuDZ2ArVdGwyFxEj/+8Jsd1W4O6e9M5c9kqRf3m3xVlgWlPgDZMN?=
 =?us-ascii?Q?8H0LqqunCWOBLkkW9T5jf+3guGDd95IXSKaimr2OVdFzvcqASfmk8oLgmmHo?=
 =?us-ascii?Q?lN0v8lu48ETurqkoihaQJln9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c1047b-0903-4f68-0e2d-08d914b8448e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 20:06:31.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1AwaqA6CkiqWrfRY0Mm6P3XGF3rGlnWgPVfDqksrPX/VrWWsDHOdvi4TH+L2Pap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1547
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 08:06:35PM +0800, Zhen Lei wrote:
> The result of an expression consisting of a single relational operator is
> already of the bool type and does not need to be evaluated explicitly.
> 
> No functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/infiniband/hw/hfi1/tid_rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
