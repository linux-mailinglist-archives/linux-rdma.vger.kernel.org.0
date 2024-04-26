Return-Path: <linux-rdma+bounces-2107-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99AA8B3CF4
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 18:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612BE1F225DD
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465EE12C493;
	Fri, 26 Apr 2024 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UiFLjjx2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4216BFB1;
	Fri, 26 Apr 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149451; cv=fail; b=X96bN+h6gbw2WsDTQAZHhaizDAwWEXAGiTFtJC1EIhNh3mnCK0PA8CyTVmGiXQQpYSHT66ORNLlqLz/eckbvEATg7CUNygtxgXzvhZ7ZoEZsV7h+dDLr/kewUq+ofG9T5fgdOnhvgAge278WxRvgHCz48rUcy7uE6kdrrQeio3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149451; c=relaxed/simple;
	bh=0DYKmP4Xe9WzWW8D9nBRfGME8K7/w2Y9OXitZevDTBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YUJD0w1VmysNlvAFQYyQ4TaVDTDpmWAN7ucl7ImAaU/3h9uk9dTiryB/PzpLROW6y0Qvw44EBV+tl8OJAtxrJZPv2ammteVlfeFQErV/XVdd40ZaGV6QPEuld5ccCFiU4vilcsSPWX5f/3e8r10MhviJESziQp/LirwJqKjU9CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UiFLjjx2; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6/mv0GPMYd4WoxGhrXdQ4NX4rxbLtyziP/LUh3SrWO6JGS8rGC4ORPNv5tUCRQO7ZzuqRXHL6Wpp7c28Ey+rGdBlNLwhb9DwKkXaeGEbK4vG+M9cFFkQRLnuDfy5KK2zQHfaNsS6ekLT2WW44Dzwawtz/nt2HNw5LAfk2Oy2VQci9VFIwHT7a5KvXjG7tNcUR6nKLTMsz8/tvVwqpE1f+MTyjtKcsJ4Nglj2D96Z6WvNVgsZnmMMHPGhkrTUHwW/ME/HFaAqZVH60XMSnYUGltWC/vhjR1dOuSXqt4Km50mNNywhS1OES43wwlhed15JboBCUWCqFIt75Tw5v5fmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoMfgcy+xomVdSf5llFwa1Xt1+ck6ibFNG5cCAUDxfI=;
 b=Qp6q9VRSEIKseu6Vpd7GQsuaKL0L9ZuF2I1UaM0vkMCgErvjovK5rJ1NW47evoO6gke+WXvHzDO5TXfUUYyZ6ei3psT5Is9izWpP0Pf56LsOeUrxfVt1n4GbMHkU83NcTjMmUeTx6ZejPYjJw6orCmOzuKkxVsbaHqjazWvgT3pFJKDECGn65bEjNmBG6bD+bKeRSggpB9VmchZK2cpzXwWKgwjup7BNTYIzGvBz8nldHRHuTkVFGLY2h698WeDgiNgqPDgVvLetSk69Y4cjXKQspR9L3t/w0cEGWXkuuyzr81nlTFajIiuTNaESfh4TcCw5YEyKdn83B1EOikf1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoMfgcy+xomVdSf5llFwa1Xt1+ck6ibFNG5cCAUDxfI=;
 b=UiFLjjx23wh2JxMDaxo9gXXqbo8LJXjBRewvNHIbSJFDpyee8HJyhgbA8SkHx0ctPX6WkpYJs3O3szUMPsLH3n2xufC7CA+4NSm/XQbeCATQCilDlxSw1G0lTFntnWXYLIVWhr8DpuYyuWX/3FiCpT2UwdSYrC0HBl34ooZQ/x4l2tpCcDDbt0cSSeI8AP+Gg2Cps6Bz3jVxP+gUKss404hXHFO57z5RDOLyrxjNUAPf4Op0yP5SkFu5ZbiCUkzQCN2qrzVpjiFcE1WTlHUI0gtTDqidENkZvTpCaVFHlM4bVCU2GsM90GiiwPpXcYmXtw7oaAOkKvU+L7Ax+y8VCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 16:37:21 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 16:37:21 +0000
Date: Fri, 26 Apr 2024 13:37:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [PATCH v1 1/1] RDMA/mana_ib: Fix compilation error
Message-ID: <20240426163719.GA334984@nvidia.com>
References: <20240423204258.3669706-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423204258.3669706-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0428.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::13) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 99935da3-243d-445f-4ed0-08dc660f24f1
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RxNCOPjPDXOnL6oDXYoNZ2/Aq7etCKtsbx30jir7E2+nnbsVP1g3/v7xglDy?=
 =?us-ascii?Q?fMbwrV8mgXEmLrHQRFIYh7N+XOSSj58cleMzyP/P3GlEpkjHd/kuRj37qWnU?=
 =?us-ascii?Q?BQG5IXq+OaqGtj1wLwwKixzQ9BY5rWFDldx5O73GCXdqRMZCj7Pnxfhf28ol?=
 =?us-ascii?Q?aMlvSaDSkTJqvu/g/GRABW2lcPG+yWjRBWOhawoZisq1HpQypHDd4ZA7bR3b?=
 =?us-ascii?Q?h36cEo/yOtodEnttYWAG1NjsWadlwbf8bjP/X6gDpRhgv6M43Rt4YmHXs4Ig?=
 =?us-ascii?Q?TIkPtzIxk1HpqEsFrpsJB7yo5Q8iEpVw1MHV6qaQXc7JYlc6PZFjmj1fA7Tz?=
 =?us-ascii?Q?RNwjP/cTZqY3z2rugMVPkpS1op92oCUJXy6tgUxePZk6jGgOgMdupx3QLZsG?=
 =?us-ascii?Q?CJbXcQSJvCWruI4WZQvcyITAjHRidGajNsDDSu4teEsPOlROqmhSb+Ooryo1?=
 =?us-ascii?Q?P0Up0eG38ypSdnlGbKo26Km6ON1jDa2ORuCX16ntYtBwlNU7+r+VThc2z+p5?=
 =?us-ascii?Q?tUV6u7BZKxmVfE5ap0DgI8KKAl0naxUHY2Wokuj2UDozcxGTXGNf3jYg/OyB?=
 =?us-ascii?Q?/XO8vu02sfIB+qPpKmAAdE4mN0bY+nnMRj4BgQ52/CW/U0B5L5KuI6f8hytS?=
 =?us-ascii?Q?vcDuctfW3617V/vuEdJH+8+mjzW6s1SAvzSiOQ6E+2f+8C9ykiMo3M+uEAja?=
 =?us-ascii?Q?HoX77ykWcL5m6pmRib4YUf7gdVFjMlevaU0clXfAktSgX8NxT6hPtMBC52YR?=
 =?us-ascii?Q?coWZoas7jovFCC7/JVJVm2gtYDxCu3xUD6kZGRfxAb4TuQ40o8zN8GVRHP8a?=
 =?us-ascii?Q?dFdwL96w42IXBDFD0HT1RfTnZPNEDrXcldiMb2Ujwcq1FZZEPgCCS6RL4FpQ?=
 =?us-ascii?Q?qzrWuYIfOZBAoUtG+p7u1etXzzZ3nWWqdxTMrkd6032uZALudE1Mc5nAK1zK?=
 =?us-ascii?Q?qJGCwXpBrjx2hyQJfSdGiLBSVWf8aJoi3z9kp/sB4ODGg2abC9nU/R2V8iKc?=
 =?us-ascii?Q?a1KwraBnFrTTaRJzsJSOzfd07H8YJRpiz0MM2Z/0JwavZJTYgrHcvFRg+YL7?=
 =?us-ascii?Q?4UezZP/MMwrUsOJbPKuoWt9+ZnK+QwyoeKZJVJysnFzTOxI5uuQlCZ2PZFEr?=
 =?us-ascii?Q?wiPn+e+TsE1/nGw26ANQBsHZZI84VeNbYu6oVCpkS1XkjIbqmbgugXMyYQj7?=
 =?us-ascii?Q?sZ1/5MzyuDgPxVCfovWQeJpYn+uxAV7qRFLKO6k4e3DqHkXRrfsIr1br1eO/?=
 =?us-ascii?Q?sFBMzqK+Kca/2zu6D+MPuvHHXLw/VSz4yZUeqSL5Zg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v8rx8DxRNu/huE4AlyY9nOF2ruwEUgoMr/fGMRqxe83OE5CxmfyyvEvevLNp?=
 =?us-ascii?Q?M/yWonWPANsDnslGW4febj4Iu0wxbuhlgQi9EDYa/hsqr165TN+G6VNGQKYg?=
 =?us-ascii?Q?ljorh2D+VmEuY54H10uMo77NX9idgHd4wKIv/GCWiDxpsi44BW1CF52SqUqp?=
 =?us-ascii?Q?+Y/vDebakOHZ+TeVNufVQmdil7Lx4hrzjddhDeGyek7e9bAQhbL/4LgtlgjL?=
 =?us-ascii?Q?g/W1qAph3SJA/BkWR3X1UWAGiWKMNhYE8ZxZQdXYYHmhb7uX36yd6VnxNq9+?=
 =?us-ascii?Q?rcyyybiPuzLj4U84StBjPSthbCqvELNq227x8zl1w6Kvng+q6yf1u5lNPRXF?=
 =?us-ascii?Q?8usl4j2iZVOoVr7fjaCObC8Xs3mSAn2Eh7N/R7UFm+YoGO/s2LkCtb4nVVBH?=
 =?us-ascii?Q?KAJsESiX97UqzjNQSf2MqtiqlatCEdpzQiXaBxfBMN0Zu09n2i+SfgE/Wz9O?=
 =?us-ascii?Q?QVMIXKQRzP9Y3qqN0ytHAiiCjx23i7cyP0wbC1qPtRSzByin7TY+ptpB5MD+?=
 =?us-ascii?Q?MFjLUB3TOSz4hkDfY7v+gJoDUavzZIzJTgc9Yq6kyOXUCHD0OxdIqirR5hT8?=
 =?us-ascii?Q?EHV3HReTcbJWf9WokmosfQoi8gwR6cm48R9QrTqhl4CylAss22FRtFvMusU5?=
 =?us-ascii?Q?4QEXLn2W/2+ZOXhM2078+LDNTfPkmkk3hb3IWGP8/nnzr1Y9W02tknQlJRpN?=
 =?us-ascii?Q?em8SEkGdhxBAxdFoeGSEGTtG5JmTKiUoClHDAhEce3qONJxqGD2kk0ekIT5u?=
 =?us-ascii?Q?MMQEHqwv+JDHq/XvGGoVaCnuW1m9R8hSIiX589z2Z77gRDbubXef821TG5V1?=
 =?us-ascii?Q?F/9X6T2zM66wYpHJxJQzwR4CHF7a5HgdlegCLG00K4cKdibEcvKc9ov7nvbb?=
 =?us-ascii?Q?tAqposb9L484FZYxJ1fYk+Z+Hq6JmIQmEd5jabG4XYnTWFZwdaG0qEHkC0b4?=
 =?us-ascii?Q?3Z+IxOs7M0ljakwhP0Nf6l+w63aN5vQitQqaQuqSQS7Qtuc3o+EKUrazIGs2?=
 =?us-ascii?Q?/sG5aVZGeOe+nrX0ShoyaAuL88U4NQgD/fXxjSTW/rdWpdVLdcGbqXeJHdsx?=
 =?us-ascii?Q?W8ueYr1rcwhvd3davPiNQfwk4fQzyJS7dPMQMiil2VognKTy1hUaDQPdojGZ?=
 =?us-ascii?Q?Gf+M29NFlsckr2ghMmFR5HmuVbMCNqC9ewB26ln8rjhCxukjY5neIRO73L+I?=
 =?us-ascii?Q?qUnrsAZyAG6eAd84x4S0jFKmR2NTjaUjcx8U9tpFm04QZJa1AT/pYUag1lga?=
 =?us-ascii?Q?UoZ9clVTc3TR1VUjQpX4xAt+TeWSgUebrRLTD+5OrUq4rHQsRUucWpJEZ0/N?=
 =?us-ascii?Q?SjTOc2U9kEbY+aYdM/wpUeQV637FwtIgwLeIK86PHWy40QnyHV4puCvjGhKP?=
 =?us-ascii?Q?1Rrq3++dxgPAvPf8HPNtzvJ3//eIEYz6IwGZTTahaxdRbaeADoHEikPEZ36R?=
 =?us-ascii?Q?5jOGviOmOOYa77k5Idkzqtz3ZDzgK5UbObG6LgARrKAXcylLIkkAWa3UDM1r?=
 =?us-ascii?Q?O/6gNUSBuA5odZFj1/DgRiQnE4uu2Okxi4UeanxLrfYlN1F5g3z1NREGThY+?=
 =?us-ascii?Q?dqlKnTayMxPEoGSCk8jUys/CrnAZbPj9VoCCPo7w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99935da3-243d-445f-4ed0-08dc660f24f1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 16:37:21.2833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5cewU1pbvpbQZSzuXF/BShqkj9ELz7Jfldgq1a6bVdAcaFXUiweVqIKutW1sV/S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142

On Tue, Apr 23, 2024 at 11:42:58PM +0300, Andy Shevchenko wrote:
> The compilation with CONFIG_WERROR=y is broken:
> 
> .../hw/mana/device.c:88:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> 	if (!upper_ndev) {
> 	    ^~~~~~~~~~~
> 
> Fix this by assigning the ret to -ENODEV in respective condition.
> 
> Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/infiniband/hw/mana/device.c | 1 +
>  1 file changed, 1 insertion(+)

This was fixed in

commit f88320b698ad099a2f742adfb9f87177bfffe0c5
Author: Konstantin Taranov <kotaranov@microsoft.com>
Date:   Tue Apr 23 07:15:51 2024 -0700

    RDMA/mana_ib: Fix missing ret value
    
Thanks,
Jason

