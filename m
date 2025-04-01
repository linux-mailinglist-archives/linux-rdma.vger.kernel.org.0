Return-Path: <linux-rdma+bounces-9092-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35532A780A9
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 18:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E83A18884E8
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 16:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E424B20B7E1;
	Tue,  1 Apr 2025 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UhH8dyTB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEB320D4F4
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525572; cv=fail; b=iASAS0f2IQWyhfj3BgNO9kW5zG58fGCGndSTwX74MTQ5g8eSndo1lgZUHNK58Ig8N3wVCJEEqJCZQ20IniTp+Itudwc6DOO+mCxY/RSH8ZUssftqg20TzYUhB6Dew0GjxvuvRJfiS8pJG6Y9Bkm4KL90jTBPyWUbkKBlEUPlyts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525572; c=relaxed/simple;
	bh=u9zVPGlWmR+fA94EaF0Z+8bgB44GjYsvfEINc29ezLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RjjQPV35imvdSIMfWT0Ra0eqaX7tKw5Xc+cR1brEqQLEXluDlZKqRf2Dk6EjUjnp2rFY+grLsAYX5Ags6o9onfSjSnLrNqMY/Ou3elQKFuxUWu3bKmmpZZr+fwXroRZkhKVZZBlgyJuM/JNPYcujwe/ijpgKWeV7VykOBjvG/I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UhH8dyTB; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FscztiOdLk92gfnVWCd0yIkBVbJrrfYxnQKjHaXo0GdmsAMZHAdRiAwvNd4cKfnuhShyhBlMcg/axeIOANMLGd8Z79TYXzYgBaD8LfRPVfgc+IU0Xzil3Dz/uvdjtiBuJepBBM8N3mCXhC4VRxjCN0cKrEkVm7p+KDHw7Rf2TqomajmMKXk2af+KmJJ/pP/YpjQevz2vqRKBsWZNm/YYBlXBPMEWFZTgTydsSK36b6PmOQWX0zAB3PUAAecgCmPkIihp7UX5g2DaLDJ4ExOMpUZBv3HSXejcGSbI40VPAdJx1kKbg8sKZ0ueclt6HJLqOSWxgrd8nGyxljqst8fltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICON9AkqZv5rcpBKJo1qhRbU9Ov1LMsT87OTmUxiYIQ=;
 b=reOn+h7n34phBNutqJ5Pi+iQrqrsuV9KV6PaRMpfpqzjTgpBoCVUryXAe14Cnc5Q3SuTCyklE+u9uRsbdhj0EINU1jXqsNa7j6OEz4BHm253jwh2oyO7kavi2YdP/UBZzkecavNutzMPWVu1YyCeuN389f3bUqoHw5dR/3+eZ/xjni1ozjvva7s8HUjr/6ZOv92HpCwKUlegV+g72lwevXi1jOVlkdvfwu5IcJjzch0c7M6t7X6RlVRMSptVHPwceZzZxF2zaTnMxNjhypalqFdv0FL5I4tDOgJejqu6DFl9/bjVNzBWyCgBStMs86XBotXo+6cSHfTpnJ51dAtAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICON9AkqZv5rcpBKJo1qhRbU9Ov1LMsT87OTmUxiYIQ=;
 b=UhH8dyTB0nbcvTr6yC1cdfI2iGFEn2nijideRWaeI+kN6FThZzSsPivQSLS9vq93quP+7Hi6zwGpeJUsw8hhzPG+f1jNdw3vWV+7ac9xccffwKSIORy4gByHEftYwHQvUvlEUlgUA21+EulteJ2nyLkss5tKG8SQaXMGuXyYasnLg6DN1/noZmTBwJMS8GVZfQIGZrv2duFcomRl8Ms/nYlX1oTAw+swPhvbmb0xXgqxdZlYrUYwxJD29y6kwUn42lowLnmQY3Yw1VuW18sUdyDnipt22Ryy4/7N3oqzy6LQ/MSYp0CfhYftuuHtcA0cMtvPZZOLnIaydxUAKluynQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 16:39:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 16:39:27 +0000
Date: Tue, 1 Apr 2025 13:39:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 2/2] RDMA/hns: Fix wrong maximum DMA segment size
Message-ID: <20250401163926.GA325474@nvidia.com>
References: <20250327114724.3454268-1-huangjunxian6@hisilicon.com>
 <20250327114724.3454268-3-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327114724.3454268-3-huangjunxian6@hisilicon.com>
X-ClientProxiedBy: BN8PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:408:d4::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 110714df-4f86-492b-3855-08dd713bc4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SM4LHlrLR8gkJEumc3m4kdwFtayFy6TowimOTTTUqr+SUDN6Dvg+KSVhUtb+?=
 =?us-ascii?Q?pp6gt6n+vhKOMdP1lZCLrlLtmPagWp+XBKUXZyfMjkjKcimgi46sXYgS9r/w?=
 =?us-ascii?Q?15sni4ZcS7SsOjFc/CTOszlLu8i9JByIv5yT/M/f+5/i0T8tr7JLzvfCSz8f?=
 =?us-ascii?Q?ct9A+atwd6juu50KFhtgNf6hcGHkQhOYYMbTksOCrDM311MN6HFBpkW5z63g?=
 =?us-ascii?Q?q7/5ZgbtqfaIOZ6JZqc+gjwnOFND0P/dEj7uteBQFlmj7VXXczmgpmOAhgo7?=
 =?us-ascii?Q?oVorL08d4jsusazgWRSUPxLaHLwaQy87K9bg1SoNk6TumrZ0Ioja5orakakr?=
 =?us-ascii?Q?LQ3eeLA1hE3FiZ7PPgV+jhCZeaP9+WgEyAmmyGMaPsAb6T/gOFc4w5Ssd8+C?=
 =?us-ascii?Q?CiJ8PO6+92EfOEdaJNR8SldxRQGhNTN3kqT0ymJBQQ6kbcTTIXCAywD+xedz?=
 =?us-ascii?Q?lOm8meGQ5ShpgKflIBe+TrrtAsee6YCZ5lNET/Cs3LBki8rYikKIaBo+HLiW?=
 =?us-ascii?Q?jgkgZZaePokEg3Itpyj0eO50DeiTFNyie+4obZbe3izKb9nkY0kAlm+1nDce?=
 =?us-ascii?Q?5r9mtpXxTW7dGr7SiWIa+63SMhSgmnVy11Q74St4N7YpzARK80PNzDcPY/gl?=
 =?us-ascii?Q?4cC0qRl26isllO2aM5iQ9Jut18a1wtGAnUI89zGHiW0T5akobcURngGHW55f?=
 =?us-ascii?Q?+bBNskydFqkzuS/r6He0mlRdok6ve9nQsYGdZHZFbje7A0qNeCHCvwWgtI4k?=
 =?us-ascii?Q?uK/Hvav9wtofFjhbYEaJJ/hmXyHUtq8wfG85eVpHCWCcgCFg4a3GqyHYHzyQ?=
 =?us-ascii?Q?hoOOYeQ2oQN2Y+ICsCPLoCE0V8hHdSfhY/9c6rhvw4zEwu5ShqF4y8MOCDuO?=
 =?us-ascii?Q?qMGsHKKSXe29twoQ1pPxFOSBKbbb9tM4YpqP+Syaj9ZBUz+v5KQNoHgiWM91?=
 =?us-ascii?Q?g7/AnCMjJAFlkFLaOgtOZRnEGX7wBzL0kO3sqFWAKfcJJJ2GrOBGph0K1NnU?=
 =?us-ascii?Q?aFNZW96Apn3Y19EJnY+e9EDIL2iiEpZfftbMjwlUAFRh5cjUjblvVhJfyXsA?=
 =?us-ascii?Q?sFP1MbpnsXRJFOESusjF0aqLreH050tXAoS65+KJbDJ4CZmmG5tURH6IjcQ+?=
 =?us-ascii?Q?WZOGAIoYDaO4TKzK2tiJaSw37XnYYTVGJ9SN2qu+HNxu6pHF/QkLeBrzWUd0?=
 =?us-ascii?Q?a6ogohUmaL6bsXfxR8JLlH6CsKz7jKAGFGpUzuhddHJ/4KrxL0sW3km20aY2?=
 =?us-ascii?Q?lC5xgS5R7IScCeKVV2T3J+9UcUAyhMj/qw2AYw24PMjdsWAGX7pyF5L/cC66?=
 =?us-ascii?Q?AnG+u+EOC1DTbXYmZ72DC1lBRYhZ7zNGRJSM5muH0K1DasBwpIG3Ujq5ZpMl?=
 =?us-ascii?Q?lqpAvhEObY5/KuWLGFKouZH/ZmwJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+tshJ8AYXQQGMVeUMq8VWG5UVhrfqspIsXA7UafMsds4WFA5cHDNrsPJbkFV?=
 =?us-ascii?Q?CoHL2+avnu+YH84AclOdOd+gh+fQGgfDxwtmEZokv72fZqz8TP9KlWvcZ2XW?=
 =?us-ascii?Q?M7VvtPyyASCgVg04RfvTjssqj//iJhvuIRfplxFwqGNccb5ZruQ75e0j5s4C?=
 =?us-ascii?Q?Nk2qjBbp6VDaYnBEjDajKOMBMuZ+a/OuS1os+PnwTs+Y2htKkAaW9uH/flxR?=
 =?us-ascii?Q?2dArKKKZntiecPIqYzsLvcVKnuYsaEmqp2rkdLq6XUz60DI+rpj2Uz+0JuNd?=
 =?us-ascii?Q?EHGIrs7ySimuLzaJhx3WXvv4IoAbu6iwVoa9mf8Ve98KkvhYw8cVH0fMjbWc?=
 =?us-ascii?Q?WxDZWTYEV8M4e7muxu5Ys5Hnh0pj8sxM4sB0d2u0RDuaBDj/53bqTpF7e3M/?=
 =?us-ascii?Q?IJsq1OBi0Q+k55hHNq94sJn06utaRvdEsp6K4qsG4gNsi+MjucuoBuOiTTkG?=
 =?us-ascii?Q?+ZwkEIqeA+QFSnctP2BjqsatKKlR4zDdJW9BdxbZUzuEzWda4nQgbo6fRfhm?=
 =?us-ascii?Q?zKeS77wLK9zbc1E3/f4C8ohfGi23VA5NGAGD5BeQak85jAprOkbn3sRzIhCv?=
 =?us-ascii?Q?FiRM/Rr4wQ/Tv9RSjXBJNedUFazhbqZvkOyeBbbgagRDYDkevP1lRwBUpjjn?=
 =?us-ascii?Q?ijIIx8rKywk/21lY8DldBR/mwTF53FKMvUpH7rR8LU4ytaWjZtTldZaCJJGu?=
 =?us-ascii?Q?URy8vEcfX+bv7K2bP196x3E7jwmCJPgBDBe+0HkBH23gcbuInOK+NpsAboOg?=
 =?us-ascii?Q?m3J/nJm79m7IvrusI+PwSsZVlNoiYz8wm4i+FWw9b12wAUxRcibHRRFd3N3e?=
 =?us-ascii?Q?XipT1Njh6reCWxhv5df0XYaWQWxzGsoHXZQhimMkTzFV7cKXVpKB8UGmGuzG?=
 =?us-ascii?Q?RejWo/3ribtU9xYCVLvfIkeLbc8xvWhF0x5/6VRxvNdQ5XjgqsYrfyj/+52T?=
 =?us-ascii?Q?M0svEKsa59Ogx6w3zJavTmscoZjMXbOtgK+MFsWhinURuzZGrbeOG6f8GPJ/?=
 =?us-ascii?Q?FeB8FuzYRkNQ+R0THTtTX+X8l19i3t1qiQkvLtdgYkO/0pw2Y32bkZJnZJRJ?=
 =?us-ascii?Q?fztR3MhalX7vxdnDYLbvgMG7jJT1d8WGNT78pHSGf6STBNDSz5L2QecQY6Z/?=
 =?us-ascii?Q?mEIHnpPv29s3/Joq2lRSRTaHf2ZmSuhtwQZgL0TINV5N0ABVoAKq9QYcje5g?=
 =?us-ascii?Q?Be5/B2Wq7iezSUgbsDP1aL5JLe/9gLciES/H+3l1xT1blVHnxoSUnJdn2Z0r?=
 =?us-ascii?Q?8/im/JWPgHRT+BVM+tG+XvQHBHlAVdSyFu6WGCN13fx0HEug3wespgJdYznZ?=
 =?us-ascii?Q?8WZ99H72jL+mAg6MgxAXm98AqTXmvInKLQsUWyhZS+Sn3eLDFtezAg0fweAz?=
 =?us-ascii?Q?mXJ76LmfCmf1ROgy6Z5OLtvgC0cAqwapdtL+7liDP77gvNVOIQ35en5sVRjm?=
 =?us-ascii?Q?5xqkBL8C8M5UMJz0CK4PHROEbL8yUOYEHK6XOSCODdt/UTW3HIIqz8dbvqbf?=
 =?us-ascii?Q?5CIfTI0zYm4xJmlYRPZIAmijpv0W+F8MlDhc74iIuXfS9zeFVBprdb0BQEvd?=
 =?us-ascii?Q?XM/22o/gGhOctXqDlXB1MehTi8sdxz+KhzSQ3LGB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110714df-4f86-492b-3855-08dd713bc4c5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 16:39:27.7439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dk5qM8F5306YxhbcuObadB9pPNtphrvZb5RgJzHYXcNL/zgk9eV8wBOrpbvby7Xl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176

On Thu, Mar 27, 2025 at 07:47:24PM +0800, Junxian Huang wrote:
> @@ -763,7 +763,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
>  		if (ret)
>  			return ret;
>  	}
> -	dma_set_max_seg_size(dev, UINT_MAX);
> +	dma_set_max_seg_size(dev, SZ_2G);

Are you sure? What do you think this does in the RDMA stack?

Jason

