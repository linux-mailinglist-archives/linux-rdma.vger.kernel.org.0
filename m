Return-Path: <linux-rdma+bounces-2111-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D38B3D6B
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 19:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D881C226DC
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 17:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0C715A48A;
	Fri, 26 Apr 2024 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NnT2FbML"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C2158DB5;
	Fri, 26 Apr 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150693; cv=fail; b=ruBBJPomziS+euRiwSFfP59MFc0QmufpWyCZydHAuOicbNGcEzt/weP1Q9QMltvQqDHVXQ0f2NEQpaJFmnJJtuCyl5iSUZaTpUnrBoE0qr7LfTfgVf8FlFt8BH+lBlMn21c3gdKkFELRZQXP/8aGhhudOOUOhbyF+7rnm3gwdmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150693; c=relaxed/simple;
	bh=fuK+VbR4G7FQppsVg0TMyh1dcrEL28z6y4827tFjxvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ovn71WYddwwQ50Jrq3u9YCvLIh+l4rGUGB4wAhveOxRkQbY9IRg/VXmAokc699o7Uz3/e3PgLzLk2O0YoTUVx6LQ8Fy3PcqKAK557BSNZQ9SM3fGu2MvU1S7kR6Xy5TOneZw7gSEdIT6oG78TMCCgBAef0Mu5HJ/JNPjNAgt0So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NnT2FbML; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZdcVV/esKC+DrLoIAoUG/eoaMMvkd6cFQncBfULVGFQ6Z0pdCn8lpH1quB3bBYcsKVq10PAYfHE2u6PPV9kNAJwZ4jrk7iR2Hhd5zLJSnuhqV8rgZqcYNLFnYlszlIX2LRbGknnglAt94g7oIy3aiXZ7XiteNpJiCDxmuCIbcRam/cv0gbv0NX6Qcp75t0WsRhwnxatDaNze4uslDnHsx3H1hTruu8uZhpZRv2eOJfy8rXLQnq3rPf05cHLouAWhlPge3GTC8QzXOOrftHTPIblReQ0roNCQBJc+gGHJhq7yBiX13dxeqWDEpjGs/hlycsI5M7guncdBLqDCC0jlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91YFMfKdH4+PhBAPmNEa4T4drcjkBz8tmddLln3dYlI=;
 b=URiWS8gJsd2WEc9xaPBP1bJmrDD0W4LzYBAdsOWS5hhp6YZGumIEcyFdNnfLj79QjUiwfr/pil+t1s1dIj3VhMdOg2IV86PEKtO6lMAIwbPUJVPTLLi1rx7/AUGbU4l3sjK+B2tVmrInNF+K8b86021C/AlCLMdMYwhAXCfFV1usCTlPFCWOIjG5q7lHA1PBauiudbuskA+JDZc3607v99R4HiIdKoqkVrMn1TneWsuCHW4AbH5UExoTyTQPcEDvqN9rkPzyVUBURoHJghf9QgqpPT7gjzeNlX/CUa3RmIUbm4+AgzR49/i4BeJPOOCjcOzBBAhfHURh4Ubffe+USA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91YFMfKdH4+PhBAPmNEa4T4drcjkBz8tmddLln3dYlI=;
 b=NnT2FbMLAosVKvyTq+AtWdVbHx7SS2BtqwP3g/lAlEvelysDvdG8mpyYtCDAYsEBS7z2tx2l80K2g6sR470WCaQg2+Fou05/76GNJu8B+6CNZtAEycqKpxvcaCgoFaoc2qjfWMvL84cs5EBq0BPxqoVR3JPO9apcmjhu7OAuwO0dl6tJyGG1hscpRvaBeXhIjI3rcxObtReD9QedmwY4f8vyjcNhau2udSLy/oldfveBmHBntQFetutKH7nflKmroIwvJDpeMmwJhEWn/KYybdB2Rb+KLp3MxTj/kpxQkJTdr+afA1mczizkoTjfqeZuWmtXOOdXP9YvgIyxj/mG0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Fri, 26 Apr
 2024 16:58:09 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 16:58:09 +0000
Date: Fri, 26 Apr 2024 13:58:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [PATCH v1 1/1] RDMA/mana_ib: Fix compilation error
Message-ID: <20240426165808.GA941030@nvidia.com>
References: <20240423204258.3669706-1-andriy.shevchenko@linux.intel.com>
 <20240426163719.GA334984@nvidia.com>
 <ZivbYdt2HxDpMxC5@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZivbYdt2HxDpMxC5@smile.fi.intel.com>
X-ClientProxiedBy: BL0PR01CA0009.prod.exchangelabs.com (2603:10b6:208:71::22)
 To DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd7b3c2-b069-4bc2-fc11-08dc66120d03
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?18b2fwRD5YbvskzXc/v0TQMWfcWu5Q55enBfowgCbffGsKN+Tee700JBoR+5?=
 =?us-ascii?Q?yett0dnnX7tIK+U7q24U424rNI/QGmJuecqRnFPhCYzdUIXa8fcQObehGg8w?=
 =?us-ascii?Q?2JwRF50pf8ZkpXGmhYAjAdSkrMOC3c/LNeV1RZEGPCcRSWDxtVMBzkizEmdW?=
 =?us-ascii?Q?7HXOCm4cy7DhuEThiGJcpOl+vg+B/NBdcKIDWQO4Bmfg8JLF5DEDXNFriVPw?=
 =?us-ascii?Q?FUoumWK5TBGvyuieS8muJwGN9mh2eEZHRE9popa5XyXbUePi/salRdX4RUbr?=
 =?us-ascii?Q?WZTe2FlIQk096aB6S3HSEJcka93FFHW7/zqm1x8kIPDAvidpmSkVZSVlevwR?=
 =?us-ascii?Q?hUlQYsO07yjeMqb0epumnfQJtCxiJKZyBaKItlOfiex4jahpgb4cLWPL3FnH?=
 =?us-ascii?Q?B9UYZz2eBILt4Hq01UvcUQzysNQNjklgeWnUK3F6UUCWV7QUSzkWLXAHu5xA?=
 =?us-ascii?Q?a0BMOJYa94MveAhY7nXztvZZNDW12UCbJ9C6h45NUAuisHdkLyPeWivh66X9?=
 =?us-ascii?Q?YDsGascoPPZdSbEuQIW3KHtDiLkOnrp/VsazICV1YNLgIuTWwTeNyD9ijpi+?=
 =?us-ascii?Q?W0zCkDvpXobWesB2IhMxwwzWs9Kf9R2QELqKzKF3MXVwO0kfmEYONy0xiB/m?=
 =?us-ascii?Q?ahTtyjakicfSlGEWmER/NzYljB3Kc6jPFt2/DGPHzfU/pLCl6iLosLVHEek9?=
 =?us-ascii?Q?vA9OKxA9SuvtjyNJQDWb8C/dfrrBTcULi6LLbKZOu4iQD+qSgC/zlaLgPGAY?=
 =?us-ascii?Q?0l/X7EX3gptnTa+ZlDL66HbCMKshZaCYmIloF+zCorWHx7HVOWY1nHI+My2c?=
 =?us-ascii?Q?ssSPGIN4ho0ZPbio8MIaEqNFi2YsSux6M7ZlL68cLEGgOClwZ1lNKcQ6jHIV?=
 =?us-ascii?Q?bZAt/g7sPZ5NSu9Z1F011ebvuDJ7VjsIwnEk1cSWnUx8AEaN3TLVP5xmeHF0?=
 =?us-ascii?Q?WsLfolY9D1oE7jBbO4i2AqVR4gU6MuybbilOcts0QgwEP4oCdHsD5ymtoqOf?=
 =?us-ascii?Q?6ejeOodJZx2C4GNRsUNZ+FQ6bhWPkidJdx1JBDeAWGdPDBCTbMODm1TBtnuN?=
 =?us-ascii?Q?Oir/747izZAV69jcJZFNRBPaNObbYhkvGFyc2AtJV/zRYiGAn28QQx3GuGjq?=
 =?us-ascii?Q?0Bw0fTXCLIIYrvm7ND2PDQIWJsrtvOb3Rf5gCFUNNQ3LzS0RvZTZL+RkON1o?=
 =?us-ascii?Q?l/3Ka+r3DS+3G0zU34IQH9/X/pWZoCaPVtiD4Ji8ae7AtkOEju0CgvGSDwV8?=
 =?us-ascii?Q?2pCcevgGOCizsJHfJ8ayNKyEzkxp720Hq+uOCJo5RQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2vPOHyhMKQDO1VtalKtmrZqeohm1OXjQ1/3oYLNF6YWZYHcIL/1gmWSIXBlw?=
 =?us-ascii?Q?78kPlhFZNCye160pwolJT9Y18C83p8lHwYGTsY52uULms1pAH+zfj81r65zK?=
 =?us-ascii?Q?0k1w0hRTyDbArktffpetHeO5wKxiEecX/DjUaIn63gTCPUfeIdPmS49zaoSm?=
 =?us-ascii?Q?V77Gp6nHh706IdB85H4tOzSZjGFhcjKzI9Sf/Gw5CETt/t2Si0PcT+UR7W9I?=
 =?us-ascii?Q?4SojPo6889zLf5f5oB2Kr0pSezHGbCqseYKXuvlu+muDynsifVfSoXdmmcW2?=
 =?us-ascii?Q?q11Ar9M1ECrWUFjiIN/wgoWtkMK3EKwiv7rVNwOzbBJswJpnOsd/OXMvwgfr?=
 =?us-ascii?Q?Ujrt8+OZ3STc0x5qdtn1+Vwfa/qGYPGmTFrLG6XACMHRa8hCq5fTtLSDUJfG?=
 =?us-ascii?Q?qzY0MRHusEgQ7j2dozpCF73sWPuSq6kyJ0J5FCJOLEQpDRdb7eYEQeL/+2K4?=
 =?us-ascii?Q?U1At3zdnCsElp3rZUucRQmflnMauzu8xvHXTTCfaK12dqX98hmh1ajAuWB+/?=
 =?us-ascii?Q?RDvDgik9KJNVZd9dX9Ha4Jr4DNWpMyJ/snZvy+Nw24mbK7GZunZ9RLiAUxSw?=
 =?us-ascii?Q?bbPpPGqv0OraZgXVbn2CNL4rpnxWMgiBscqb+wqPIcMD42yJlxwwJY4vVBgR?=
 =?us-ascii?Q?bWZ4aa8rBIxnxwdtmALWs+wSGGycNKLY6G3vUZsRbHIvwzzAQCEjWgPKpSEE?=
 =?us-ascii?Q?m/rszsXgDqlp8w8pw5B9CPfZLQPHp6j1vjqvgF42hCtYAoygbSyc8Jky8qrq?=
 =?us-ascii?Q?BrWxz6mz3OpHNJT3Ldj/SMogReB5eb2gSxzx66kwnNp/h+K78x53sbZDSjS9?=
 =?us-ascii?Q?z+HuNmjrEYwtps0CxIQ10HaKSN6ymNcEn91dNSPkxv2o+0SQzYds6Sgio2eE?=
 =?us-ascii?Q?agmvRDRPR4UJuZwmjGTK8Bn6O9qzmYwOjdflxUAfNgYSjknkto/XNU8mnepE?=
 =?us-ascii?Q?omnSejQnXqQgW/8UtJ+CSLTjNyzocJlrz9dPDgeZq7hAQ3BEh2dB0rHNV0Lq?=
 =?us-ascii?Q?V4m5OSRVvwLUmlKQnAil/PZBMOxzULylt5cQtUNCZofZYwM5iICMCqiWzEHN?=
 =?us-ascii?Q?EjVcuOBmr2vtZkimhKttrSTgv/pwPtdPrQKPgqconSooiFB7hCSIwwiVIsWE?=
 =?us-ascii?Q?U11oHhlc4HbmYtGSiL51mLIi+0MtDkJMRfbcDWjVyT4FB5KI2cO2HxVZdeUK?=
 =?us-ascii?Q?Q1gcaBhwfuSL2amzrH8BMlnRLKd7ZHnT1KRATO9BAZCtalC1vqfsINeryLPs?=
 =?us-ascii?Q?JINUCZ2Pj2MfgkUL8SqVIGT524IMNnRGuPaw5T4H6i3Kn75VXUxWMih+YtUl?=
 =?us-ascii?Q?KcPsDe2xuAZ8zc8Pwk501TkihRfUxFR6yHyHK5XmgDENrYs+x2iLp4rXcSul?=
 =?us-ascii?Q?mJ9UEIhZrSiuA1+WfuaQ0rGwxDDZhbw4dKMP+fdZZzBlzf6b+XmUqgAlW74y?=
 =?us-ascii?Q?7jqEbFJJnEuXvghM/RpnsD8PMs1WFT+u44VbFAPSFRsl3jsL31yTAi6buFKK?=
 =?us-ascii?Q?Dk2II45Ns4cbKlzzkn5AcBXEO04Xa6JYzkkXHHXk262pMw4s/ds8H3hTWulb?=
 =?us-ascii?Q?fLYgoda/WOmGBNY5Ccw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd7b3c2-b069-4bc2-fc11-08dc66120d03
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 16:58:09.4713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: my0Tu1nQXZawcq+gl0zhGzl8CQ6JVPIhv/C+06C+0wrj1CJXDjximqrJFn3m30dg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181

On Fri, Apr 26, 2024 at 07:50:41PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 26, 2024 at 01:37:19PM -0300, Jason Gunthorpe wrote:
> > On Tue, Apr 23, 2024 at 11:42:58PM +0300, Andy Shevchenko wrote:
> > > The compilation with CONFIG_WERROR=y is broken:
> > > 
> > > .../hw/mana/device.c:88:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> > > 	if (!upper_ndev) {
> > > 	    ^~~~~~~~~~~
> > > 
> > > Fix this by assigning the ret to -ENODEV in respective condition.
> > > 
> > > Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/infiniband/hw/mana/device.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > This was fixed in
> 
> Hmm... The below patch had been sent _after_ mine. What's wrong with
> mine patch?

It wasn't

Your's:
Date: Tue, 23 Apr 2024 23:42:58 +0300	[thread overview]

Konstantin's:
Date: Tue, 23 Apr 2024 07:15:51 -0700	[thread overview]

He beat you by 6 hours, which is why I took his, yours didn't exist at
the time I took it.

Jason

