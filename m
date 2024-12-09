Return-Path: <linux-rdma+bounces-6345-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB5D9E9F57
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 20:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CED32822DE
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 19:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B882157A6B;
	Mon,  9 Dec 2024 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hw77Drbv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4851140E5F;
	Mon,  9 Dec 2024 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772118; cv=fail; b=kbblcf44igDhj60zNeSLwsegtc4+Rd5D4lVYSAGx1VpMmZfy5qZ8yYw0hoZo1Wj+EQNBtfjwE2gESvveCoc8iZMYt1Ib1CCLFVPi8QKdbZv9KHTpYpITsXVeeY3Qi0w86f6a5PGzB12ybz0qqBM44Pvch/PBHgDnogfNO8WVC70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772118; c=relaxed/simple;
	bh=Kpz/bXOKuUKd66MvS4TVlmJR0oUYjxCLCkBUA79m3X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AxU95CTT/yKXuekm1iKKc1LKZrYRtJrz7SdHOV+QoDFI4cyEIlB6lmO+GmIE7p/kO8pZnFJzWUghc4WMDLOBc6fz+L74co9cNbn0bIOHURHxmRDOPp52A8O8lH7NytOMTd+uk+5D7KY3DkWd9UdzXt29pNFJlEZY8P+Y42Q1NnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hw77Drbv; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liMR+gf2rI55FYrlk1mQ0dJOI+JOrm4WfNiFYKeRs/FsjZNEBN7sLzqJ5rDbIO4afyWp3n7EKdnHHsoZwywpY4KQnCe+8Atsj63cxF7f/FiHVFH9YneWF+6Z2bTXAFxB8IqUjcWeWUf0hy79HEi/VY3L2JN2Ak4U7DkVrInhg9DoNYtSSe0sDQ9xDDSDXJ82hFfSgDm/MhTiT9UAkKLz/2Y+SiC6CEWC9al8oh4HdkvyFuo0KMwl3xQwzW8kDNmpKOw+YFCr827oONFHOb0nf8e6IU6oB/mMTdHahdfJYJjVepg4fpvdYQaDnd3hge11zHnlRc1W/SyjmKMHDZw8uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Hyc9/pHi+IPqKqtNirDMEZi7wbsEt6nF6r2QmONIl0=;
 b=nnMV3tZ21Ai+CeLhENVJDh2he7hOSPpMJ7GLzw50F3S7+dMVKzz/vXiW8JAsjxD8NuW+aoQd8IWs3bjYrbfS3n78bIKqv5HoFb3GX5DTSf9vTAU385cVeFIjYk0r8CoD+vVfdJes70PHA6H+aQCqKzg3/eOglOK+F/AtUMWe1VbnObor05STnEtMXgQtIYKN9PUFFOxFOSOXFHpyHQB4K4waqDVRfvNLha/pTwgH50yt/Lkcl8EukZ/j7g9QLPtes3gKqNdWlOESdYluDdeBcH/uKaZ+dbTzDlFW7oB4ExOhh3/rx3IYU/KLLnISfhxmqjnwSCiV1DDUiLh7RQdN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Hyc9/pHi+IPqKqtNirDMEZi7wbsEt6nF6r2QmONIl0=;
 b=Hw77Drbvo5CUdivZ6JvDV8IB8+e6YKgRrjFj1RthxSUgjtPqQ85ZC2PkFVT4fikHNibc84is90I+BMgEBW7XEBh+Dh+o78xJ+iQdf1FuFpMcRIIUdJS4DQsHNVyLJN7Ljuq0ATyWceJ3QqX/7WwXitLcGRdbaoZnHbG+J+YCP1rD3pAy+208WvO1KU8tnc+Zz2mvOMh1Lyjzldm3V1HlIrWV/5CyWzuhVXGGUFxOW1aANxf/FFdAOS+DoBulGH4nNJY13XeAwLmDCpzRyylTDQjUTxcZ2pc9S6++FsNlpxtyVAbqhfGpPFl04ZHaLnq3LvtkqSD7/yoOPQ4lIOkjVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Mon, 9 Dec 2024 19:21:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 19:21:53 +0000
Date: Mon, 9 Dec 2024 15:21:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
	linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com
Subject: Re: [PATCH for-next v8 3/6] RDMA/rxe: Add page invalidation support
Message-ID: <20241209192152.GC2368570@nvidia.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241009015903.801987-4-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009015903.801987-4-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BLAPR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:32b::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3a515f-2e09-422a-9109-08dd1886bcc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vb6esbYmgQ7QXxuXLE6DbIfD6NQzk9HoXDdlU8WvNI2BF01g9le+EXnCUHX4?=
 =?us-ascii?Q?so6M6Rv+g/AfO8dDKmrxEQK41RN2ELie9QE5MLM0obsEHJvX17Rm7ZyR78ie?=
 =?us-ascii?Q?8SnQsh5hR0px/DFrlJASlW2X+FuMINWZ9BF0WYMp70K7XTeAucpBt5BlkjOr?=
 =?us-ascii?Q?aBS5Q3nQOeU6FkJM+/kePraokngWd8E52q0WYDiZsVJxw4c6J5dYrBpqAJF+?=
 =?us-ascii?Q?yYWH5Fw7pSyJmkFwvPv8/d8JhFsBYhkxjQ7EWtP42EEkaYxOysAtJa5VGqFe?=
 =?us-ascii?Q?UHnmSzP4mbhkovyv1EMvTnBHPxT8qqoYi/tu6qsSwZ465Zl8Tuo5+g8dWiyl?=
 =?us-ascii?Q?B3Kub50rPQpuCjBcwmqLg2xNvF5yZfieX+I8fK9mDJg+z+3dRbmsUrfFTiDX?=
 =?us-ascii?Q?tmXiLmsCJ/znYEUYrJE2Wr6YcMkYeyQuRESvkRuQO5okHkYOXpxh0BQrGxKg?=
 =?us-ascii?Q?3lu9737yEhhjoWNqdXLEFiB4K6QWqanAPfZosQthhYUhoxPEN5Xun607wXKx?=
 =?us-ascii?Q?ppU/T4JuPaUMAYcLutdkw6Cl4VEKiPiPHoxH1xNSjZTk/ZPOISYgx9J6pgMk?=
 =?us-ascii?Q?8Svxs4dOSK9pydkV2dpEodaI9Q5p9zdRWqAXAzA/GVHiE8zy+z0YWPeQFOKU?=
 =?us-ascii?Q?t3qqNMRhn6ZAqrNeMyGQNsc2aWk9NTEDDxQI84A1RJR+2u3HnGEJ8cWUZUFJ?=
 =?us-ascii?Q?p35JniZfmu+Sifs1TqUY3vtdkMm+1qSSTR0HGgstF6zqdYEpTEQ4B61a5X3y?=
 =?us-ascii?Q?ZG5EHZxewMnSIthx4vp5xT0V3/l0TAgLhrsukiB331C6lH8G/i2p6DYVhtpW?=
 =?us-ascii?Q?GgfZBTJYl7VTCVN73Nj15cBrT0FDJ+aPudwHnx8uu5ZP/25f2uCZzdcEyM+W?=
 =?us-ascii?Q?2c0ZxS3tit5oiQsh0Ct76jkQhOPc8guYnXwmGwFOAPVIsg3ynBjP6ARWnGmQ?=
 =?us-ascii?Q?zgS+0QvkypHG6NTfdwxZtKM+o9fH9uaQDGWi+hMB760n1W9r3UkXGpiJ62Fn?=
 =?us-ascii?Q?abarQVoCuMFV2RVkvvwRexryijJH+uwE86a6l3qEF88bfpwiPJNtgE0UL9rJ?=
 =?us-ascii?Q?YJ/VY8NWrf2RZ5Wa4gaFkravXYigpOeORVKzDPT8Hc4pJrLNiz78U3yZpMAo?=
 =?us-ascii?Q?SYVx8cVjQ9lQDAIqoe/g5iKaEWz8EhBbgPvoypgr4+Ce2NnjbwSHkcjyFYUp?=
 =?us-ascii?Q?oXT7V1YUvygAZLPH4yVH1RyZfP7NalqWeHGb+0DfLmadwQkK5Pg4u48F9u3g?=
 =?us-ascii?Q?hAEUmbJCHEazAZfNYI/az59Sus/dE4G3r24PnBmjQFUcq46JpCY5utD0Eah5?=
 =?us-ascii?Q?KyQuovJjVKg9LN6LUsJVNBV05TMMOGpGcpoVQzy0MiQOhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v6e2WVywlTUrNVvS4l6msKDcN2DZrie26clMSNhEKw6zpUMpEHYPRFlzOTaI?=
 =?us-ascii?Q?Ucqmtdm8d5eUlekMh2QgqMM0FYq3DN4EwmjvuM/j7SbQgAyYoVcE8nwxN/T7?=
 =?us-ascii?Q?m+lDekB4O9cSILQUZjVxcdbVItLXX3ZH4BzV1+CJU/CGhU5MFqu3wBktZ8Gb?=
 =?us-ascii?Q?X9P4RuejxJ6YM0+UTTpndQU46+TPXZS9fDtYStVzhyMjotu9/wxWll8ALNDf?=
 =?us-ascii?Q?zaryMVYWjjmNj/kCo/DOc2Lf9rD//e8ZDWKCjuyzg0p0XOf3c8Z19MLlzvJU?=
 =?us-ascii?Q?w+I4B9/7dOAyrSEl17qNZSgTb2f1sBoYLpGJvshvmSdR/QQAWSwNp+G/Rdnt?=
 =?us-ascii?Q?ehrtKL/+4Pyf9D1ALeGmQdnCnCuBzn6DuUySn01HTOFrNdn+0I5njEpb0zcI?=
 =?us-ascii?Q?Ixak7e5IlXNpDVtYP+vLonWw+asAdArNe5L0k2eA/vg6CDref2C9b1SFeJru?=
 =?us-ascii?Q?C1HY+NbWA4ppWhEUD0bbCE1VP9eC918bUEQlubvt/Qd807nboWC4q3lPlYN5?=
 =?us-ascii?Q?owMMd0MdIZrNp+n2ZK6Z448zSKWJsQhGvMEkQReiSL32cfGMz8Jd8N4HhKX5?=
 =?us-ascii?Q?CiKRtBw2eLrJCYQ/3PFpt90f+XEdJI81vCd97sQpiDXYfOKSXjbtEcN1udsu?=
 =?us-ascii?Q?Eiw+omnK7v7agJlKYllwsIoofhnkFaYjt3/NK0JTqYxGuQi8jHvh3sB0JroZ?=
 =?us-ascii?Q?BY4MuMi6TbUsiCMH3XAbBCUlJSkTvtA/Rb6bPzkfhSVhXbdjk4QeL2GqBmEc?=
 =?us-ascii?Q?HekAAeAe6DEhkuee7Xwi7iUHiHGiDXKEg3O4vNcsCHZHMX6IY8BDdxsSALSv?=
 =?us-ascii?Q?yVR8l9QoHzMHRXDOri7miFODsQhYJzIoyFoAEaw57mYV1gHRQe7yLEyBMDaa?=
 =?us-ascii?Q?MYQ+rX1DKQgmi8JI06/FL6f7h4NJP1TPBD1oXiUxMvIx6lq7f0zbt7BrCCAf?=
 =?us-ascii?Q?W/tGWcxiIflvlI8V2JO1paybsM9sW+dOvLmSdhbgjo/laTKAe2xscFEy2i90?=
 =?us-ascii?Q?COwXUqiPT6LP3nhVMzYnUQqYBJH9TkR2AOQismZE8UrgOq+MQItdUlVLLteL?=
 =?us-ascii?Q?NMat+VOHGldXlE/24XzUEjFFiViplfQZ3RH+LehhJ3Menfcts1LAs3YHIR2S?=
 =?us-ascii?Q?Dj0ugMYgVYhcNLtblz44veex6dLHPa+ZzMF58rxicImEAHehIr5VBkL+Itz6?=
 =?us-ascii?Q?371QlUW/1m3yIjszgohzUTRR9aVMzM985ys6CZHzsJ9m9/vMbOz9VUPJFODU?=
 =?us-ascii?Q?ROv5iugZoqJdKQwNtGwSIMcF7HX1xoJZGcJNlTIf52iRuVDxl6S7a5Gaza63?=
 =?us-ascii?Q?JQmaR6L7/ukY0p4baZTtLlFrgNTOk8lU9aIgl3ipntI/acMVdC/zWI//Nd61?=
 =?us-ascii?Q?VLRZlnizzyDSUzUWx5oCYzQpStKSiix6dMufi972aqpa4u4SHENqgr8csU0A?=
 =?us-ascii?Q?dyaNAdmeQo9WaHyPOXLSEBnWZvtsEKR9vQEtTE8ctFq4h6vIjuunK0Q4hWKg?=
 =?us-ascii?Q?ohCR6Gw36HusoCwuM7Xl9nuAwc4O0jP7tZViwMcXv4BeSZSMeTspSmjrdcGA?=
 =?us-ascii?Q?dm0IyTGVtVb0AbZKU2mG3aBKgw4eSOjaXe23zsy1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3a515f-2e09-422a-9109-08dd1886bcc2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 19:21:52.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fm0MKHkdLN9otfSdOwD5ZQ+Z00ck7SJOFsCVtqhMrpk47oKvaUXXr9zDxRMFLFZM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324

On Wed, Oct 09, 2024 at 10:59:00AM +0900, Daisuke Matsuda wrote:

> +const struct mmu_interval_notifier_ops rxe_mn_ops = {
> +	.invalidate = rxe_ib_invalidate_range,
> +};

I think you'll get a W=1 warning here because there is no prototype
for this in a header?

Jason

