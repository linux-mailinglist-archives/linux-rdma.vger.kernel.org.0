Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56143946FD
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 20:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhE1S3Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 14:29:24 -0400
Received: from mail-bn7nam10on2062.outbound.protection.outlook.com ([40.107.92.62]:30817
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229463AbhE1S3Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 May 2021 14:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSpFz2K6/mDBcrwTAZBO6Laq2qeNckZ520mXzCdgPBAjWW4/li0eCl/hzCCWbU0+dmbJVeOS82wnwQAyCurSujmGC6hdPueuG01STASJhnQBu+auTMIGpSLfLcQ6IM+R+UdkgGuRvNeVM6GCM0SMP39/aFK9ChiJZij2zALJC4sCP2ukcWsITA49uBDpDTGNVOsh3XaMaPhpXmJS8nu1hodNnSR0WxLJkvn/9bm+yvjJJokbn54lRRUVPOiD6auHUfD0WWFX6Z3qW+DtKVZJ31QjgMJMTu85mO30BYk0oCjEY0BYbA99lLG/A9tH4gBLeV4L67MB9A/OvhooNzN0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ycKJpo2LWrL5b4AYEXtvONQzoHUcbO8G2FftWGohaU=;
 b=cybCaFHBkMaxXeTD2lo/DW7mMKqZh6fZ7EbctTjeiZqD2CJx0b11UrOgnzF1WLGna2LHSK2z+Zss/OLVxGicSbtmXB9xtFDzFGCXQXTmW9iZYTJo7QuSuWULJ/CtTpFB6h6l9bKgEcnmAYqdWKXL55tZNf6rIFnvWl6vkWrRTjOlVkGDoahRLYrbpx26rn8R91+VAxsdb5YhV4257YSlEFKu2+KA1vDg9Bt5JZbUyGmlxlzlipa+MFDyEZXjbcw4stSzuEV7zsiPDpbm0skP/INH2wfoHYvrKYg13b9Z/kIMWloX7MMeNEkSLyvqpVwQfshzk7khwpzfgZ9ccZNKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ycKJpo2LWrL5b4AYEXtvONQzoHUcbO8G2FftWGohaU=;
 b=d+2m/f5hCCVztQ9X5QLdUUxuYrN4Z1LLuwCe64rkuBxZ1ayLCfBEF7/0LR06SRczs/7EDNgmrwjpYZLlUlSyv1u4hrHDBkdTYP0Z9xspzUOloKwbLM3Wbl7xKkgXjcuMjFDNLlzcHeBa47Bf95Ra14CFOUXBb3hDkKrUfCTyTpiK4xx99HMlCoBvWRUW5hB4PK1h14kYPeqCaO5D79MVczgGgqO6+eEJpOys9aMGwNQBXDEs6+Oy0OmpA+Aod1/1GNz2KNHUzS4ShcQVx8HNm+IQaJluOOHb3T1RWpJzGsN9VExguM8rbuxpHdLDoXvjdKjMv1//C7MRCQ7zRh3ZtA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5524.namprd12.prod.outlook.com (2603:10b6:208:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 18:27:48 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Fri, 28 May 2021
 18:27:47 +0000
Date:   Fri, 28 May 2021 15:27:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 1/2] RDMA: Enable Relaxed Ordering by
 default for kernel ULPs
Message-ID: <20210528182746.GA3645229@nvidia.com>
References: <cover.1621505111.git.leonro@nvidia.com>
 <73af770234656d5f884ead5b8d40132d9ed289d6.1621505111.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73af770234656d5f884ead5b8d40132d9ed289d6.1621505111.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0055.prod.exchangelabs.com (2603:10b6:208:23f::24)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0055.prod.exchangelabs.com (2603:10b6:208:23f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 18:27:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmhD0-00G2Re-J9; Fri, 28 May 2021 15:27:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb5f382c-1662-4668-1278-08d922064b19
X-MS-TrafficTypeDiagnostic: BL0PR12MB5524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5524E0BB12CA6A0C4DD43637C2229@BL0PR12MB5524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YB9e3ulMwHhwDXJ0wEe8hUuFfX6dmbL2Yx9duN6M81MNRO+F3OpkY43DOWibcfe9dNWSJPLiSbFBHAcdaXCrepqOOYrpLLcfAeAJKyAXHLj4D0NxM7S4aIHjG7AI1wl0X7K7kha8dhExXBMojd7X+b12HNWgYCB2Ima8KZ2mM49WhILgEkjYTgo3HC8hLzjSzzTJ8Jjxvizjh68ldiBC6Dt2jvlEdNCAnhYYiltObpLRqzCju83jTukenAnQAE42nMhX4eCeBi9ctYUWHzCjf/B3p+8ccUrsA6mRhMcZx1srQIMOBHO99FwMIveZ0wpWui/z9H4mFD7KsEAFZXfah3Lqugaxu/3cO8QbSpv4jM4nKNWttmJ3e7SjV5l/nrnj67IhNqcL7evz64NpWCx/XE/ZHM7kuyF1a/aJVBX+sAekeUzb4Yw7GPglZlW/0SO/xu68RpHhTIgUqCdKek9hnogPd8og/TKtEXZjvWvve0UTWGoFFjO1x1zgHsG/oHeBQwATXRHnsAMOnCg8V6Noa4tSlfj81eUdqEMtnNfPfiBnutVGNY8+mjwePOddqRymP7KVcJlv9M49Lvu8UEcfDEGJGKnr7aq06Kxz67aGjmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(83380400001)(316002)(54906003)(426003)(38100700002)(2616005)(186003)(1076003)(5660300002)(66476007)(2906002)(66556008)(6916009)(8936002)(478600001)(86362001)(66946007)(36756003)(8676002)(4326008)(26005)(33656002)(9786002)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Jh5CAWeMY+DwAO3QliU8QdZWN51WnAu9PJKVbDUnKZB948+1ee6nezoJpJ/6?=
 =?us-ascii?Q?opIVDuHBxpfRrrSdZAY/rYGldDGgrbA/RYq2gJyNDsqc4gr/Mc5WCyAeSpcC?=
 =?us-ascii?Q?9UBFXuj96uIpgtrILnOTDKVukn9siNCiq0p1Ubeepk33mhZc9Fuv1K/pEdS/?=
 =?us-ascii?Q?Z5WRMjMz95cC+pJ9V2V2Ky6EWJveBUIlO7Ax1XZ9qX7bO8guhDf6F7Zy6JYI?=
 =?us-ascii?Q?DkRTs3RyCG4cTV1ybpd4RyfiozGqNVmX2E10fis3HxSV7GEH97WiCtp8+hIC?=
 =?us-ascii?Q?VGHhxDH4DERyxiu7832PMtSdLZmtiI80Sfz9hF+Sh0VegUBqvUL9tD3psVlb?=
 =?us-ascii?Q?7OxAdJSfrpAbA++Hz+Ep69YmFGXYC06RaWeE5EOWkxIp/bvvS1G6OSqwdtyo?=
 =?us-ascii?Q?Mehhx+uqIF1fGvuBLbtvpQKVd0i+12OG/e2qDR4D2Fa94AUNAV3pck18Dsxl?=
 =?us-ascii?Q?VFTyqgILrwQ6BJAcXTwFH4MnkQTAwb8qQCHw0Vey83unMfAmAanfXymnib5T?=
 =?us-ascii?Q?2zpX5P46qT1lcL9bJkTX6BXW8BZfoqv5XwPqSJoKgEbSTSHe47gsQBKrqf6r?=
 =?us-ascii?Q?P7bMUrO6Ml/WfaJiLD8/IWkFwLD5Ik281rU4dm/Edz69eQ/cdz2EZS3mChkE?=
 =?us-ascii?Q?FavrRdsxn0j0Q5bYr1rPYasXD+gsazmjxS+hHSEsm7qOCAAKHi24NjgOlF5u?=
 =?us-ascii?Q?bzUQLOL4n2jXQRRg8tHHJ76rEdhHZGwF7l45RhoDCpv2fhDEvEXfHUMwg7+9?=
 =?us-ascii?Q?NPZ/9IjfmECCLwsQAhdRYL9rAT9tA856dDfne5TLfM+2q0UpruZ3vXGSefhz?=
 =?us-ascii?Q?MsAPf2U6prhEkQYC1VSFaS9W+82YO7BHy8XMnfHLbRbO931++tF4IjrH8C4m?=
 =?us-ascii?Q?BDU3PmGkt+pFacw6c5jETFCAw/jSlxJuICzHlJx1x6OcsbQ6OH2HrtyS8Vcg?=
 =?us-ascii?Q?+YClhSw++RvBIlr1fy6QRxYYntfocKqkWruCcFj67L6cF4BHqO+hIE77oxQg?=
 =?us-ascii?Q?XKswCD2mk6q3o+ngsrhwzjuBr74PKh2IrUZo0+Za5z/KogWX7oqfzDrgW/SC?=
 =?us-ascii?Q?jbrb1VZPnUGu0VQ1wQnVk91A9kX2wWZHYjqNLo3C6WKTk5fFJ/O8cUorBsWM?=
 =?us-ascii?Q?ugJehBDVvRqYVdzoh0ckx0bTD2FTj1H5Lv3fqJ5OGS8HrwfGtxuapevQlwce?=
 =?us-ascii?Q?L8i31urzINpZ2c9ub6UhlzR2074shswnlVJjAYfIFp4CLrWu1UCBgReD26Nh?=
 =?us-ascii?Q?6U17jYgfVSgRDMPA2u4KjsvN5IOizHZ4x7qrOGEHk3CgESqeLmplKh11zTAW?=
 =?us-ascii?Q?qqKbRfsbXPnisAnRC/qFsmAL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5f382c-1662-4668-1278-08d922064b19
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 18:27:47.6550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WalINwsSWrkGRtN8WpoS7GHlVvdEZJ6hRQzJsuHVTnSdtTZl0PBiuC67b8dRiNhD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5524
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 20, 2021 at 01:13:35PM +0300, Leon Romanovsky wrote:
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 05dbc216eb64..b7bda44e9189 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -1440,7 +1440,7 @@ enum ib_access_flags {
>  	IB_ZERO_BASED = IB_UVERBS_ACCESS_ZERO_BASED,
>  	IB_ACCESS_ON_DEMAND = IB_UVERBS_ACCESS_ON_DEMAND,
>  	IB_ACCESS_HUGETLB = IB_UVERBS_ACCESS_HUGETLB,
> -	IB_ACCESS_RELAXED_ORDERING = IB_UVERBS_ACCESS_RELAXED_ORDERING,
> +	IB_ACCESS_DISABLE_RELAXED_ORDERING = IB_UVERBS_ACCESS_OPTIONAL_FIRST,
>  
>  	IB_ACCESS_OPTIONAL = IB_UVERBS_ACCESS_OPTIONAL_RANGE,
>  	IB_ACCESS_SUPPORTED =

IB_ACCESS_SUPPORTED should be deleted too

> -				 IB_ACCESS_SUPPORTED);
> +				 ((IB_UVERBS_ACCESS_HUGETLB << 1) - 1) |
> +					 IB_UVERBS_ACCESS_OPTIONAL_RANGE);

This would do well as a IB_UVERBS_ACCESS_MR_SUPPORTED constant

> @@ -4679,4 +4679,70 @@ static inline u32 rdma_calc_flow_label(u32 lqpn, u32 rqpn)
>  
>  const struct ib_port_immutable*
>  ib_port_immutable_read(struct ib_device *dev, unsigned int port);
> +
> +static inline void process_access_flag(unsigned int *dest_flags,
> +				       unsigned int out_flag,
> +				       unsigned int *src_flags,
> +				       unsigned int in_flag)
> +{
> +	if (!(*src_flags & in_flag))
> +		return;
> +
> +	*dest_flags |= out_flag;
> +	*src_flags &= ~in_flag;
> +}
> +
> +static inline void process_access_flag_inv(unsigned int *dest_flags,
> +					   unsigned int out_flag,
> +					   unsigned int *src_flags,
> +					   unsigned int in_flag)
> +{
> +	if (*src_flags & in_flag) {
> +		*dest_flags &= ~out_flag;
> +		*src_flags &= ~in_flag;
> +		return;
> +	}
> +
> +	*dest_flags |= out_flag;
> +}
> +
> +static inline int copy_mr_access_flags(unsigned int *dest_flags,
> +				       unsigned int src_flags)
> +{
> +	*dest_flags = 0;
> +
> +	process_access_flag(dest_flags, IB_ACCESS_LOCAL_WRITE, &src_flags,
> +			    IB_UVERBS_ACCESS_LOCAL_WRITE);
> +
> +	process_access_flag(dest_flags, IB_ACCESS_REMOTE_WRITE, &src_flags,
> +			    IB_UVERBS_ACCESS_REMOTE_WRITE);
> +
> +	process_access_flag(dest_flags, IB_ACCESS_REMOTE_READ, &src_flags,
> +			    IB_UVERBS_ACCESS_REMOTE_READ);
> +
> +	process_access_flag(dest_flags, IB_ACCESS_REMOTE_ATOMIC, &src_flags,
> +			    IB_UVERBS_ACCESS_REMOTE_ATOMIC);
> +
> +	process_access_flag(dest_flags, IB_ACCESS_MW_BIND, &src_flags,
> +			    IB_UVERBS_ACCESS_MW_BIND);
> +
> +	process_access_flag(dest_flags, IB_ZERO_BASED, &src_flags,
> +			    IB_UVERBS_ACCESS_ZERO_BASED);
> +
> +	process_access_flag(dest_flags, IB_ACCESS_ON_DEMAND, &src_flags,
> +			    IB_UVERBS_ACCESS_ON_DEMAND);
> +
> +	process_access_flag(dest_flags, IB_ACCESS_HUGETLB, &src_flags,
> +			    IB_UVERBS_ACCESS_HUGETLB);
> +
> +	process_access_flag_inv(dest_flags, IB_ACCESS_DISABLE_RELAXED_ORDERING,
> +				&src_flags, IB_UVERBS_ACCESS_RELAXED_ORDERING);

This seems over complicated, why not just:

dst_flags = IB_ACCESS_DISABLE_RELAXED_ORDERING
if (src_flags & IB_UVERBS_ACCESS_LOCAL_WRITE)
    dst_flags |= IB_ACCESS_LOCAL_WRITE;
if (src_flags & IB_UVERBS_ACCESS_RELAXED_ORDERING)
    dst_flags &= ~IB_ACCESS_DISABLE_RELAXED_ORDERING;

if (src_flags & ~IB_UVERBS_ACCESS_MR_SUPPORTED)
  return -EINVAL;

And the QP version is the same as the MR, just with a different
supported flags check

Jason
