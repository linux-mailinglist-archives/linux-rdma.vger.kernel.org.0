Return-Path: <linux-rdma+bounces-15059-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E829FCC9D0A
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 00:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 997A53049D34
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 23:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89BE330656;
	Wed, 17 Dec 2025 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ksh8Qdob"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50422311C16;
	Wed, 17 Dec 2025 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766014656; cv=fail; b=YBYm2u0geywUyM9jHSPSPbTPex4ap2ynn5LYbKKtDHsMGBuKINkARdjWxyDAxF5/44S/GDX/mpZU+ud1fpHATPXCKTZnGor2JWd/w8In08LvYAmqwTzT9s0zDlG67WMRafWGKaGJD4ZaBFKXdsZXQglH7Wmt3S+W29CMHurGd8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766014656; c=relaxed/simple;
	bh=saJL+hWgn/HX7ZgW6i0ylgkq2yzxoxoQPXj3n/Zd9Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YOAUkLxZqxgyR/GvGPPvgI/x4oyLbqLcuygoXowotGRZK4DDc9wWCIWd2Jn1zCvsoZI73rJr/AesJ40geBxky25n32fbc/9EQkboKHsFBnRoiv6cetYnTRsa96jFjZn5wDJPwkiIfRcsSW8ca8o59zP6eAURNODu5xCIcvJPrBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ksh8Qdob; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKoRg6mKrgL35up62A3wsTAJ3WKDl3MbxXruSBlMCbAZSAabWDgfulyq95nL04bjoiv8CsCEzXKGruz4zljShk+SQoHm4ixUFtJnpDmnefr6URt5pg79sNn7mZE+5udDlDw+R/WgKyqIPt9EZNiB38ooPMGIjhDxiIRzLUb+UoNnci26RB5DV5VocvN04sduqmca6XvHtTZlgmat/RfqZZv+T5f0Lh3IX1k3EF+F0gMC5K/Ic0aKKyXbfMVpLPGXH5P5OW5uIyNozcnub4oGBM/uHob4RP8ifrfT3UnGH/MieQWHZwhtMIYKYolNe4mQUhyYJc+jyUSklnkclCnllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gx3Cvm1QxsHOSn+CW2igxGyyK8/4stNqw1efPsV9Ilo=;
 b=yGCzPIfeZ6YIK/631fOD8qjCu79yb8Rhi55qUC+Jz2TOya86O/MB8aq4HkR5VrI2ImNzzknx4l67Uj6G96Dc4vSXLEMAKIiIT/irfz93Jn6deQ7FBTLtjEA0iVmkN7Q5qcoSfEfmoaFD12vROWnm8LfFOJ6KVf1oxw0VkxNLqI/+7g81lW25W4IsUhrx/RFJ0Uq2pvawLR7b37jxkL7/hemCtanNgN4zuWE0kSLUMJ85nLBBIy1bfkhLq6QLMJ3RIixgNslc2Ig8i27OSPlznzrrMGZlpBEP4u2RzYHxMl/Q1yEjSS1WePLJ7DE+8Ed5C7wS5eYWxNoRAOU2L6+EJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx3Cvm1QxsHOSn+CW2igxGyyK8/4stNqw1efPsV9Ilo=;
 b=ksh8QdobUjLQYxj1GWVIyzLKRuYKs5zITcmSEMJDfyT05J3FOMXBYHXcnzIW7t3tqCuA1dzGMd+zpD9kmoLHzbS8FWOSGKckbFVsXyTH13aBAI9Oi0cxQ5FsEygKnJaVTjgYe1/7qF5BABPJ5AbFeoBQq0BJpuhREm5YQ+NZlOr8Y5SI8aCoMnR6arGwX/DJeUf36ueu0mo+jn1UjLdb66Z/AMQ4oqsRe9ktJJX1xTpJkn4El+ieL17WXBgkaxRjB+6uTxkbc75LpqZxXl8Y4aeoiN1AQIZUFhx8EQ+uSugi/SXrmIYkgBuucMMGVE3DF7Uu6llFcU+B9dEW8cVWcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 18:03:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 18:03:52 +0000
Date: Wed, 17 Dec 2025 14:03:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: avoid invalid read in irdma_net_event
Message-ID: <20251217180351.GB211693@nvidia.com>
References: <20251127143150.121099-1-mschmidt@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127143150.121099-1-mschmidt@redhat.com>
X-ClientProxiedBy: MN2PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:208:d4::36) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe3788b-faa8-4979-34be-08de3d96a343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?+Z5gEdlHnP64A2/x0bIhXACiPVG1bj2LOPFOog6wx5nejLA0LymGFIjOkl1H?=
 =?us-ascii?Q?5AR7HfKSNyR5DY4P3CrFFq+6Z+p/AiQBDnmYFphn+JcDrUTDxtMww5ttQqu1?=
 =?us-ascii?Q?jfEyoAyPY9cqTqhdIAzhmcU8JAnXBaQV7EzzDj80ZfI5ISJfWHI0ixD6gOwG?=
 =?us-ascii?Q?ZJBrAwysxL1vGg8cFPimPh6vYzpIe3RBn0Xo3/zdgt0tzzgm9GDVmUyOdpD6?=
 =?us-ascii?Q?NP779jG2dVgG7cnsKKjtarafiXHziCso0qPsKh72jgIVsg7MdePUihYlviJ+?=
 =?us-ascii?Q?c1s33T7gZ1fey1MJiLjsRW6qS9451ZsG1KlBrCrX9WEUQYKVOGrfWIU38u+n?=
 =?us-ascii?Q?rndfk2QqJ05ISMKXAAqyPeFgJtQHVs65g/R79whoEhI0fm41czoZN2uhKQtG?=
 =?us-ascii?Q?EpFJA+qUFwJidPdrSyQ9znp16lyjeGPsGwO3Gq0sSjEBbeYhFhzTlBxVymw7?=
 =?us-ascii?Q?OFrYRix6iNZdH4qC/i92obuwutMuSJyAJIpf64b33yz49k93Cym0dxpe1Qbo?=
 =?us-ascii?Q?8ILG4gHOpstr/3jTLO6bmrgP8TfgpxNCyKRZ6zEyQNbeQ82SsohCoZfrf/mV?=
 =?us-ascii?Q?Uy4H4HBaC9bhG3Kzz8mN5kWcMHNExm27jFP+BVFrOMGv14K7Pja1rPQlKfQI?=
 =?us-ascii?Q?ADXYUTVKq1c/hsuiKLkmTsIpu0y+w+WgJwseDlxh4YkcsHXwXC+6Zllnb+hk?=
 =?us-ascii?Q?1XqtrHE+NhBmVQjl3oSZ3uIjEyNkD3iBxvhawdmANYFnBoQdaE8KPes9JtOw?=
 =?us-ascii?Q?tNuoNYcX1BT9SQYdOh5tuer96qPZgq3PEBININYgZu1Rcb0qxN174YFAgRGF?=
 =?us-ascii?Q?k5ffPjYJ/mvDjTsWbVG44RvVQW3SJhBRwjFPSp7ParVJkZueVjUPE0y2PHrI?=
 =?us-ascii?Q?vvmKm3AmuRBNBqjq77Uy7QWJm0r+fIDBJM0y+lAZl6dFpwQjwGMnJbPAzzlP?=
 =?us-ascii?Q?sObPGDp1D09cSzO5tqw+uKSxnj1Xy1zQGOYpR4ztNqaHg6UTV0oKQ2R0lcAF?=
 =?us-ascii?Q?G5W5cwgEVdokN6nHOSqmacRBqhWmh4iIfNszXYiv1IuzwUoTwplejHReE0nc?=
 =?us-ascii?Q?RFTd87xeNwhWIRyMoC5uhetSSmdUkT91l9hYg3wl1treHgXGxAcotE50IePm?=
 =?us-ascii?Q?+l42EDN6IQ5h/wXMDnZTKGWien8WCWqgY0SVV6DbCkxF/SbLhB9sRuIc0yfl?=
 =?us-ascii?Q?Snk8qyEpcdriitcLzqaE+blpZBPft0BEsEW6xRFpptFzRs3i310KqZeKUqBB?=
 =?us-ascii?Q?cdu9X8c0ehM5kcFuiBuHzpWYljIt7az61buC3OtzX1QttaS7vLhWMg6jyDQ6?=
 =?us-ascii?Q?yZkK3bW10RLTAGLejAigtdKwYnMaXGXW/kh9rdw9Hq3uw7LBEYOfpztg7Z65?=
 =?us-ascii?Q?y5d8XJ/6fBS3acPzvhAgWhM0kKeJtDdw6myYVe1eRI7IZRIL2abAT/yKnyc+?=
 =?us-ascii?Q?Di+iizuiIuUq9xVWPginbuYs0/4J/hyp?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?xrLbp1eOXhAo/28UtD9lN6zl2HulbOztcgy4ClLJgcB95MbK7W5F11IAf4pk?=
 =?us-ascii?Q?S1c+Ixue9lKatcluVvDgKL8BOyDFSWEbXkkAmtq51rWEoHc+qr5DMYvu0kXO?=
 =?us-ascii?Q?27Z8DDAQIyX4HuoRvqXrqjNiqFlrXGAkvwA59afp4UCGagTnTr7IysX5xEYV?=
 =?us-ascii?Q?uT/OjIZZIrhLJNG4vFBqxqs1kaaYtNkAuqZ1oDhMGUJ9WWvsZ61/zlZ9ZfeQ?=
 =?us-ascii?Q?RThh5UbY3DBLftR9UsNZem0PLm7/4cJdRzoMLQGr0MaMsfaIKo315uHD2WL/?=
 =?us-ascii?Q?spqoAxIdVcPDKoMSdERcb6Xi6Wpv3hHkww/dgtnugf5kpdTSn5vDp1HA5lw+?=
 =?us-ascii?Q?LflRR3uByc6EqNGlcbur0cokIQJxAGnUQIAvd2iVnA0G22NTYRBinkHWpGTH?=
 =?us-ascii?Q?Jciv3gJHKjtbGmLIQHgryK3FPphYK7UoaD8n8kEIG9dQh98Ybx22EbVVvAIU?=
 =?us-ascii?Q?GpKUo4rlAz8cJFRBdxypvN4BIti0vtDGEJnazKpnYB0w2Gg6JZGaVvR/zXod?=
 =?us-ascii?Q?vrguyB0HuxWWC0EQNMWQ2IPqIHhMot1MMo3uEYdDv14C02GlpYhMp4p6PhHB?=
 =?us-ascii?Q?SBEVNiubQ8JSQ9fLs5WAPNNGECfuQXzTskYQNKshWHeJxRBxv52rh44Qoti2?=
 =?us-ascii?Q?jbggxTqrhlwLbxjTYoMMYjj7uTRD+omVbwIyeoaswLlWC8bFchY8X2TqFyyj?=
 =?us-ascii?Q?IAMDODm+XYKxzDZ/vxqHS4lkO8cBLhmskEiM/0j3dslrN4GH4apps/OcY74j?=
 =?us-ascii?Q?KeNiKV5znKn3+pU7UDlccWUctWbwPSW+l4LlX0LMPTmL4RCi6Kb2enQLrrnC?=
 =?us-ascii?Q?bHEDaUD3rmGrOY0NEWORXzQgRb0QukO8IHdbynl8uMP0zLPIev0D5eAgNIcB?=
 =?us-ascii?Q?YsLfZiC/KO16uUoN5PDxYjw/TheygJRl0ruHOzQQKIiiDM+h17KpGpeplqfC?=
 =?us-ascii?Q?o7i7ElLW7S+48EgCfAocLdUd/SRL+4bG/Oa69tIDjeeT90OtgfHWp4mgIWE2?=
 =?us-ascii?Q?M2EzVC7NC1iOUFhDyKj6UNgSTDAFOty7AmYAGy5WWNey6jaGvPucE+yOilAv?=
 =?us-ascii?Q?OPBx085twhbvGpYScTrigR1hQmkREoChn7irEJbIXLv0eDw/bJngfwPw+E0C?=
 =?us-ascii?Q?GLP3EE0bJ8S2TumqjiqaTGCMgEzxyEWbn3MDkBUVJB3aS3BIVVacYAVxtR1n?=
 =?us-ascii?Q?fcr26y5Mz29/xOsEgKmU3C211TQTFYYv5dAsfgY2JKpeI+BZQqCEfWGHx3To?=
 =?us-ascii?Q?U8bjGiz+m3JUwZWOBf4TMUGYl82jSST9KUssG0NzTQUtaPWo5fccHlQE/b02?=
 =?us-ascii?Q?LoB+7fBlYPum7Fj4mS6p+Pa0QIIZ21C6LO93w1fLWoPFrgJkIVI3CUH2nSuA?=
 =?us-ascii?Q?5p+7sxhU8m7IVbnrUSnb7hTcvxrzEWubQPxtqWFT1TAEt3cfEPPAaRelq7nL?=
 =?us-ascii?Q?GG92fMGwn6P9d4WTxrt4Y+FPtO74PnuoNelpDMyD5HkE2CQHH+Uai3MsekvM?=
 =?us-ascii?Q?yuA+Fo8MI3SstrncFUs2wutcANRbc+am7WOpIiDMaX4FioBdptzOqn29OKVL?=
 =?us-ascii?Q?y1/EvPRyxcoxwbmbbYA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe3788b-faa8-4979-34be-08de3d96a343
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:03:52.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXWOHBbulExQ/MefehvScePN0opS+feOUvPrDbaGbLPEu2wY0Xbt1SIoNe1y8d9n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819

On Thu, Nov 27, 2025 at 03:31:50PM +0100, Michal Schmidt wrote:
> irdma_net_event() should not dereference anything from "neigh" (alias
> "ptr") until it has checked that the event is NETEVENT_NEIGH_UPDATE.
> Other events come with different structures pointed to by "ptr" and they
> may be smaller than struct neighbour.
> 
> Move the read of neigh->dev under the NETEVENT_NEIGH_UPDATE case.
> 
> The bug is mostly harmless, but it triggers KASAN on debug kernels:
> 
> Fixes: 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>  drivers/infiniband/hw/irdma/utils.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason

