Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A0C32F25B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Mar 2021 19:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhCESVA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Mar 2021 13:21:00 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7576 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCESUj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Mar 2021 13:20:39 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60427677000a>; Fri, 05 Mar 2021 10:20:39 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 5 Mar
 2021 18:20:38 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 5 Mar
 2021 18:20:37 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 5 Mar 2021 18:20:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD2qSeNcLZtkMVOSDf+Hxst1VMxr51+PqbIzbOSb5NjRBpEb0F1aART2FROTWsff1c0E11VKOpSj+4p2dOqhfgwnZKN8mwmhY1S1AY94qooBKoQ3pXkwZJZEIvqdZQqDME7LzX8W+bQPdURXscXdDa1yZ39i2VyyqOlheVXAR9bwlIKaDgaIHW1vYcSNe7SSFUps416gSVl7FpBIfuXenipQ/wn+SXQND2XXE42r+I8GU6ix09Bhm1m4XniUQdyowIWz7bxKiKiRksNJWxHUIYTXvifRwiJZDv5aJFL8mXMJz1Qhr7wWRSAi1ic44PX5jpdsRw+qpI9bCmVdA0WtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/pC7HgRIeWppPgFW1HiiuD8v2SEflBU5jS3+tSL3ek=;
 b=Md629r90owussjunKS6y2/FYmVhbOAQA8tT/tYpFxoAUYslUc97mtpxwIbQv8fPdVXvUSFGepdxJA+XqJ+axn6GpT+IwVQaTaHnrhEuZ9QnY+cg3izx2aoMYMlzRanrtFV69W/IcEEL0cbP9UbgYyCGrEdJ2z2mho5XhLnlb+Y2t3MtHtryBNr8vxPWLVd+HabvjA5pgWT/Yhw/YkY+04gFHsW5LoJNwsGytwVuvi3AYFKodFU3EY4fZRKNLj3zVlg7K0l76WtYZCxPYfTiX9KrQuomKOTYK6Xkm+BPvGqzxz4xY343f+HKyP1RiuZSqU5bNhbx2IbXRvEHGs8xL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/pC7HgRIeWppPgFW1HiiuD8v2SEflBU5jS3+tSL3ek=;
 b=L+yzeJ03pbjHbm6zfxv1wcZlHIQPbYDVxaw4/bi1pVuZfnYVn3wgsSamk5gvThXIFtVh0r3bf5KtBr7v+qzJVV4IwuzYhQLSmvT3ulAR6uicVMM7S8WMruD77xtuIUAU4ZAjuq25qx/Qr5i/MaMEQ03+Y1ScNXH82TAf6A+Z8SY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Fri, 5 Mar
 2021 18:20:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.024; Fri, 5 Mar 2021
 18:20:34 +0000
Date:   Fri, 5 Mar 2021 14:20:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v3] RDMA/rxe: Fix ib_device reference counting
 (again)
Message-ID: <20210305182031.GA1884080@nvidia.com>
References: <20210304192048.2958-1-rpearson@hpe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304192048.2958-1-rpearson@hpe.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0382.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0382.namprd13.prod.outlook.com (2603:10b6:208:2c0::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.11 via Frontend Transport; Fri, 5 Mar 2021 18:20:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lIF3v-007u9g-RQ; Fri, 05 Mar 2021 14:20:31 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c629de2-45e1-4cfb-77d1-08d8e0035d86
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3737F679AAC5D0BD4E073683C2969@DM6PR12MB3737.namprd12.prod.outlook.com>
X-Header: ProcessedBy-CMR-outbound
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqBbnH+QK/pFXO8zvMekxTyOri0L1TmGgY6tcswE+RLV3ZxrRWx/HCdgBAmhDBLg75duajz5pUjy2p2MXD3cxXOr2IJVBeNDjGrRca+mMqIWisbGAnSFsRGvCcdzoR4KFKQcjuKIIgv/RZOUnIL+nREwXMi56FPWJdy7vdL48cVXTc8jqK8Z5E/VS5B1JPUC+6zo1HDkxmzneTdY5XxqUX6jh55yDZzoD4VI/jg6lU8e2m066m2Kzn8cxukjMgxNaOEwN0h/pq4AQ0XflxWzaqlbe4FddCu3jJFt+3nnVymExECW11fWgnlS7D/57RQBERlGeVXQ/TLNZf1oOYpTUx+E6R0piSGhHmFVLA6w7uv3QAHoyJBRjCq5GUhTpD6Ju/JKXpBMhJawSizmN50yFhh6yt34aTQj8SrooMmes+z7MhuyWC2OGTizYijDtTlhx5o0u1yMwTYfG9UCntFawZ3kCv+4qUCeDOu+FhjaRbS7fUjri9LV1YmILwRWNu7PPmbDeM++rktIxA2DTG6XDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(83380400001)(8936002)(9786002)(2906002)(26005)(2616005)(9746002)(66556008)(66476007)(5660300002)(1076003)(478600001)(6916009)(66946007)(33656002)(86362001)(186003)(316002)(4326008)(8676002)(426003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dbA+b84oAaqsZsEb7n/Ia3KK1yj8QyQrzLwpUkjgMYxq9+a2NLJr+Ht5Ohmx?=
 =?us-ascii?Q?bWHLTv/6gEcWkHZS/tTXs9OR9QFZIItucsT3eXK6VJbZAZ7DOzWsvwuOltfC?=
 =?us-ascii?Q?j0uEPjcpQnkYSZqwQo4vKRbLX0CRgi/uZF3W/5D1mYJQ5YTHhdFF/6FSE6Ox?=
 =?us-ascii?Q?htUyWVD4dd5b6914DBj+ONf39/zU0m/pw35XCfnN14Ogp25L8W9m1Lftp2H8?=
 =?us-ascii?Q?dWkCo2HXVzC8+ONm0NzMhp6c42mnC8YI2ak0/yciZDDqrmDBs7LzhSGk2dWU?=
 =?us-ascii?Q?oGulx8UPMsFXfuanXB9y+AzGUJb8FqAsmdYJo5wEURHONAwlpel5a3+gEUpK?=
 =?us-ascii?Q?xh3ZhKFdXkf373Z4a0wuf/KiuyBOurCYnvx4FO4NUcnc0JFJf/DmDbI+PAPF?=
 =?us-ascii?Q?H4lDyQGgaygR59VD59O3JM48OLUzGLDKXKiELwNqqYvZb/4CCKIMX8ksdoLw?=
 =?us-ascii?Q?mqd+N2A+8blOdZERf2YLzvfnxBEGHwqUZDq2QLpMtTafHb7EDAf8cJfSJBeg?=
 =?us-ascii?Q?22sT77tk++WUH6KCEDqBoibHNCTG1T3gLdX4SeTmpkvjSG2scLpMtsMpNWCk?=
 =?us-ascii?Q?7d2KbVX3CNdnn826vRDMVnXrKdmOwNJXTliQtSwD/3F/FiM9Ed5lAKPRDNJ/?=
 =?us-ascii?Q?LwR0s/8SermteyjU+lanQPLUumslggsPO0U7yjrzttn4nfEptScp161NMMr8?=
 =?us-ascii?Q?O8iC4qnm0HZSY6woPw1HunkN+mxJXOXdz2PRvSXV/G/0HlSnSxlip4wpHloi?=
 =?us-ascii?Q?Drq/QJnEntjUml5pij3lcIE3nYLzNTxefFc1E6hAj5NR3ThxHvXYcjPpGJiK?=
 =?us-ascii?Q?qB0BZNyeA8wZym2ljGf9W0o0UC0cuCZf3Mx9+8UIHi99aZwBe+S/TuoLLhTh?=
 =?us-ascii?Q?7CRX5EjpZzBllCuJooM4o4Dy4zqXUJGhHnoe26LPX9Gt67a2MBg9+WyCFsBi?=
 =?us-ascii?Q?RX6UUc0BsHRVwdCWDXSXCoyg5b6sio7OsOdlRbL5RaQaicoQlEO2/D42x7WF?=
 =?us-ascii?Q?SIbktmHcnfCOUzl/JAG//mF1jI5sfQrzzwCTRzxq8uze/IuvQ6QDUYdAn9MJ?=
 =?us-ascii?Q?XQz7QJGAUH8czZiPKMiFqt6qoN8JDxtqCoUFA4gP2+BYpDZ88y/3YtaFa0Qb?=
 =?us-ascii?Q?oaT+5peqFuvMnhhRWhaH4t/NGVoktB+IusFJzVokTQJOQSlWaXSmVRyUR0Am?=
 =?us-ascii?Q?cVd7/Oi9kTEXmdWHObbDQ8HK1rsCBm1wGCvIs92bI8+rvwMobmO2dWK/Omzx?=
 =?us-ascii?Q?LS0vklyeuYZdy154FXaeNV0JaXnq1OYCTLsQK3ndQJkX7tITW1aOfLwcXrhn?=
 =?us-ascii?Q?G8PwiKvFuVzDGgH33GENVLUh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c629de2-45e1-4cfb-77d1-08d8e0035d86
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 18:20:34.0397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZX/eYxG+JQ4HrBnVuIH1hY4Z8zSy4YGG/nFdXKZcpD+F2MUXhri3G1X6rDtDrMI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
X-OriginatorOrg: Nvidia.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 04, 2021 at 01:20:49PM -0600, Bob Pearson wrote:
> From: Bob Pearson <rpearsonhpe@gmail.com>
> 
> Three errors occurred in the fix referenced below.
> 
> 1) rxe_rcv_mcast_pkt() dropped a reference to ib_device when
> no error occurred causing an underflow on the reference counter.
> This code is cleaned up to be clearer and easier to read.
> 
> 2) Extending the reference taken by rxe_get_dev_from_net() in
> rxe_udp_encap_recv() until each skb is freed was not matched by
> a reference in the loopback path resulting in underflows.
> 
> 3) In rxe_comp.c in rxe_completer() the function free_pkt() did
> not clear skb which triggered a warning at done: and could possibly
> at exit: . The WARN_ONCE() calls are not actually needed.
> The call to free_pkt() is moved to the end to clearly show that
> all skbs are freed.
> 
> This patch fixes these errors.
> 
> Fixes: 899aba891cab ("RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> Version 3:
> V2 of this patch had spelling errors and style issues which are
> fixed in this version.
> 
> Version 2:
> v1 of this patch incorrectly added a WARN_ON_ONCE in rxe_completer
> where it could be triggered for normal traffic. This version
> replaced that with a pr_warn located correctly.
> 
> v1 of this patch placed a call to kfree_skb in an if statement
> that could trigger style warnings. This version cleans that up.
> 
>  drivers/infiniband/sw/rxe/rxe_comp.c | 55 +++++++++++---------------
>  drivers/infiniband/sw/rxe/rxe_net.c  | 10 ++++-
>  drivers/infiniband/sw/rxe/rxe_recv.c | 59 +++++++++++++++++-----------
>  3 files changed, 67 insertions(+), 57 deletions(-)

I split this into three patches for-rc as is required by Linus.

It looks reasonable to me and the reorganizing make sense

Thanks,
Jason
