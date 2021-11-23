Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE1045A4F8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Nov 2021 15:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhKWOQT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Nov 2021 09:16:19 -0500
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com ([40.107.237.40]:39898
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236057AbhKWOQT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Nov 2021 09:16:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNZ5AtZTnsgyv7+Li2Si0Ln2dLK5+Fz3QdV6VNrDCWCXP78N9t7IeM8dl3VAMXbx6wqEzwzyu8wm8HMcG8ypq68IwxBHPrv+73JRqG446uXYO559/rJIiww+VRS9zROa9q5R2d2DDN2U5G3di08mv7ulBsvCBck2OpZAdIACL2pWTXewfiYuPPonZPJwVitxlfCl9LtMx8TumzJRn1mrq7ANVLhIuri1xg/7jRoAwNI0do+LWMHtU+hsDOHBdOzQP8C6DIFPGxxwt8GwG8E/yUbGTZnoH9UKUJhuBc0X4pxUKOZ6+Jy2hHepx9Pozm5gQIYrn0sl6e7Cv5Z+Wt92Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3/SqFFPqo2LKX3i6uljQezdSVjZmm/92er8tw2PrHo=;
 b=A2+cwmrto4l56RI+JiSTBl9NLPXnS20BzN0QKPTwUyGIv0XXr2l2mTcyDqt7X+JLgw2TE5Dp0oWEmUWNIYAeA16pBG4vFCqeuulZ3fEMtbAcmVzh1hmJBXyxUPFiTPVijcZrfTsWj+bjyp3zuRF7H70wGKaR7Y0l4JzKoNRY7pW+yxEUMetyxglH4R6Sbm4/PhEQpbtI1wQY0eGloLLHDUgw6/A1tekanfveyOuPXN7imuaDtxfkkcrKYXHtRvnyNlnHtG1V+RtADZfi5QVP5DQdiUO8ryvyUEZt77oQtu+pbz5Yi7Egu7VG/jFwnu2NOAMthaACWvdgIjAXw1VWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3/SqFFPqo2LKX3i6uljQezdSVjZmm/92er8tw2PrHo=;
 b=qGv+iD3xObcyywsPpO720qZcHfwmaZNhVl284Kw8hm1MCHoLjxNxyyOJ/Y6f/5he/QMdJZkS+Be34KvKfstbD595/BDvBp1+6M/u44Y8MZO/GXIZ9xB7Y/Ca4+tmxInVB0MZ+RyXXnkFKiL+igCELHzFQwdSZBSOezvl9wI35tcR1XqSMP+76pp+fd2EUlYj6RDD0LexH+AD1uGruvA42gKDZoaDvihRfva+PA3Lvy73Yywrjv1gYb4nwUTtiJJCJFmAsNSdDdYg5PhhMXn/rQq7yNSpi7dKJrwwtzD3tahCEFqjHWzYtAckhiHM4MfeuUxkcZgENd0P0Tnr5+0cCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 14:13:10 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 14:13:09 +0000
Date:   Tue, 23 Nov 2021 10:13:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH rdma-core 5/7] libhns: Fix wrong type of variables and
 fields
Message-ID: <20211123141308.GA42666@nvidia.com>
References: <20211109124103.54326-1-liangwenpeng@huawei.com>
 <20211109124103.54326-6-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109124103.54326-6-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL0PR02CA0133.namprd02.prod.outlook.com
 (2603:10b6:208:35::38) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0133.namprd02.prod.outlook.com (2603:10b6:208:35::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Tue, 23 Nov 2021 14:13:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mpWXk-000B72-Fq; Tue, 23 Nov 2021 10:13:08 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37a2bfa4-c2f5-43f9-cc30-08d9ae8b60bf
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53492BD113F926D2470104C7C2609@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQ+J6GDgJJgIo41lrpOpOsho3j4fpjgowB8EKvuRAvAtrrqm5vKFjT9PubpuQeIAD5LVjsZuUqody49EgsIiG5P86NEK4L2qcmCk/Ow7biqA14QwBqlEtSCwCGcttpX608GPh5ca14gc4hWzJICGqf0xeYowqi7tzmWtN5nM1BxPOxIsi/rvkaUvgb02HWiIrfxqOaC/9GWH2d4bAMfXxb4QZXhy5og3xdyoC2EOaeqHaoBB6//GP8iyTVxLKzOTQ2QZvFb9ebbZmKFe+Yr91AN3CNIWCDWZnsrYRYiYaC6Por5Vu0bsD3yKvHLUEIRiY9HxOlzwj+kb8lh3NS17pmKfvblOGInCJe1H2KQll3qTNHQOF6Wpp0OOkN61nrJVmLhK//LUxxoB8NEp4eJR84EmMqqNRoQW/4p3fXYWTk9xjH61jPNFCMqUyh8zo3+qRicP0DPjnDt+iDrUtjeFloHUQMMfE+U6eoKoY/B7yJr0/+cnOOHn/8M+VERbz9WEmkv/ZO1t7we/NwfpiXRK+uamj6xaSiTBfrJ349LyJEAePe3uj2liV8FSJVhXk1Rb26hyyKYr0P4gRtMUqlDO+2FtTAp82wab7epIfTNxkf4zJdnomNHNHQwwX+hQa89tKpD8JeMh842rqvhgEQC0xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(83380400001)(4326008)(9746002)(316002)(33656002)(1076003)(2906002)(36756003)(426003)(8676002)(8936002)(66556008)(38100700002)(9786002)(66476007)(2616005)(508600001)(6916009)(86362001)(5660300002)(26005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?abE9kp/9gdvY5rReffxwxkbgsHLoAAdipAClUsjyjVAE3pqLvHNC+eS2KPWw?=
 =?us-ascii?Q?kTB0HfqJrmnFiGwkHSs45Dq45/foD7tGPoMts0DGVkI48gpidJ0jFQ3X0smI?=
 =?us-ascii?Q?uXtwm7fxa8096fwUJzbDrlIm90JdQy8Yny7vevRuZS7h4L+it4tuzEKXdIWR?=
 =?us-ascii?Q?kaRdk0q/i7SStKx7yg7d3XST7iIq7CiAsDBEM5En2Sz+13hIRFNvFI2nUkom?=
 =?us-ascii?Q?dF21gRgobjxfQFptPAO+ehM/PBEPkukSf8JZP8JSjiRVLPy0WY5jn+PvIeam?=
 =?us-ascii?Q?HmLboAoSIQ6z02dTLVRx9TvjJz4J2lvJBm18IkqW6Kxnw69NGIh8l39lUi4H?=
 =?us-ascii?Q?qv+UGbJ68i8UjeqcUAeDKn4M1ucgUe0D3/lTzJgV+siZCiyq3RUtMpKn4n39?=
 =?us-ascii?Q?g+keyYl6tLOjSvfXa9o4AKls/oUQYADa5vUcXxBno5dLT+Z2iWVByDaweu64?=
 =?us-ascii?Q?8dTCebbvJcONvkgv67Kik3aoRWLy5DUYaP++/PO1TgpmfypQulFYEO6RsgC+?=
 =?us-ascii?Q?fJmGinlcF824MWnJIZcnPfQcy5qfXKNVpWWfz3nO+/X6h5/RxQVMAA2ljFd7?=
 =?us-ascii?Q?qc1vYA8MRFFZmpladJge5t5AsZWAf+wkAm83IoIY8N/WRO2WWHi/oWNFaXdt?=
 =?us-ascii?Q?6BR3e2T/dy8vfn4oLPqXFO4a1FRSEJrWc1KP1Ll9Tw/fHhx/0y4FkIpY73b0?=
 =?us-ascii?Q?qfkLd7RARqJrHmX3V98tphU9F4sVp5Jk1f8y4KX6S2fyrIY/XKBN+Xm492f9?=
 =?us-ascii?Q?4iYQO6E7Fsj2NKE5pOuRliykX7EMJSo8nm4tfdZiCxD+cZOLWp7w/L2/6kK3?=
 =?us-ascii?Q?W+y8W2J8h60KQGmxWzsDcjF8HdYeEnFlfboOC2AIjfqy8nSiPnMWF5qH/2RS?=
 =?us-ascii?Q?v0L5/y8ZTZ+qpoM0BUnVDjq3t290OYAIlH32MKTcY+eWz60806P/Jlc+D0s/?=
 =?us-ascii?Q?Ev2k3M1QJOEVCBdjQckOE49kSRmher6M/R3p0KBDQ7STut3JBd+gVoE+DFIS?=
 =?us-ascii?Q?wKYGoXAuOQ3Uo7ocmP4Ja3ARD/cIxPGYngXWwYxrvI0Vu5nkO+n67Fg+A+OD?=
 =?us-ascii?Q?5U4qD6hLP9OgeEsFE/sRvSAAs+1n7cHnJlr1bQcxPCKeqoJDw7jceBIVWtZi?=
 =?us-ascii?Q?dEojfiYPayzZpUSJGyE9TveAJGd1FmPRmum7S1FLSx3dw4Ab4d09+kb3jTxE?=
 =?us-ascii?Q?paEtS8vQS7ZLiEN7hHgetm0ZqsTrN6WZiDxEGjXNihFu40dlGYz6XcRLIt/f?=
 =?us-ascii?Q?YPRzz2v+GGvRY5/+NE6Dr5JP7aB2E0amj/l5iCTRhEdG+uJCAutY6hEK8NYb?=
 =?us-ascii?Q?KZmjgzbWf35ZrEvaMW8xKac1KnmQsmaRAGJnRFMcaQF4ypcl6L3Vba377ZEZ?=
 =?us-ascii?Q?cxJvDNb9eXD8yFiorel9ZkNAOGN/4xCsMBkzgodSG2YUVS3B3Ozzm5TF6vBe?=
 =?us-ascii?Q?X4sS01TkR0+0NmCFQDYqgpzSEPqypUPK8PVgpDNwp73zdTHscvFke4dXweAs?=
 =?us-ascii?Q?igQHUORs+s/lV52idvWyz3TGBMxDDdsJrq0EdlH0HiwOsE0H7HRLyYLDplzv?=
 =?us-ascii?Q?wrBXYc44Wm8cofOchAI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a2bfa4-c2f5-43f9-cc30-08d9ae8b60bf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 14:13:09.7919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KY+MXMcIgvRUm+Dvantp6W3FbCtgWCXyv8kvSCmOOeGr1eWhiMTqthHjeUyswbE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 09, 2021 at 08:41:01PM +0800, Wenpeng Liang wrote:
> From: Xinhao Liu <liuxinhao5@hisilicon.com>
> 
> Some variables and fields should be in type of unsigned instead of signed.
> 
> Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>  providers/hns/hns_roce_u.h       |  6 +++---
>  providers/hns/hns_roce_u_hw_v1.c |  6 +++---
>  providers/hns/hns_roce_u_hw_v2.c | 11 +++++------
>  3 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
> index 0d7abd81..d5963941 100644
> +++ b/providers/hns/hns_roce_u.h
> @@ -99,7 +99,7 @@
>  #define roce_set_bit(origin, shift, val) \
>  	roce_set_field((origin), (1ul << (shift)), (shift), (val))
>  
> -#define hr_ilog32(n)		ilog32((n) - 1)
> +#define hr_ilog32(n)		ilog32((unsigned int)(n) - 1)

This should be a static inline function not a macro, then it can have
the correct type.

Also please send this series as a PR on the github

Thanks,
Jason
