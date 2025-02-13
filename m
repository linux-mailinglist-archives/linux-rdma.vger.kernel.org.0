Return-Path: <linux-rdma+bounces-7733-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442AA34C2B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141211886EF1
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDB82222D6;
	Thu, 13 Feb 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j0+6lRmy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392D2222A6
	for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468449; cv=fail; b=non6v6qOPdvPRnOFkSF9Exk1e4EzQ4+W1HOxjb/AhiK2M/zlkbZ9kInI22W5166PsYIJOBdijthYnd3veMJAB7mcLpoL40UTgbo+OvzXBS0vhTAcO6av1V/I0wtq/m/+4jDOZ4aVzHpvI84wM6WXfNc+nULvD1yG+Tn6g7z3MOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468449; c=relaxed/simple;
	bh=aZHaxtIxYeTJ8zVz4pd88ViLwwmSDZR8vxKK8UmheSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X/gy69Fv7nRJDCv2GkjjD5qvHU3MzLSd6PLm9qjyNQMBE0dJb3qapkfIwAnH70DQwtlQxIOBy3o44fR50PRi47ZGG7upWmnqAzII9/5qg6ZXGBS2uHvlRQaDcGc7QhHUHhmD2gZqj3HU/iRnLVOutzGuu5qDBDR5DPg5fZiRz1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j0+6lRmy; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTE2S5sC88Uj7q4ycFsRGOyVagPsa6JIPjPCUclOTorNa+Sa4VSo+mRCHiUkBGMyA2jF1GcXqkB+wBXl6pHjXZEt9GDcZODNRbQL/Q282UVg+d4QWl2Bif7FPSB2F46VY+pUN5n7aCoKciw/WChCwMwOq0X4NKjHm+fHctyah9Tfyu/14q3Rav6xs0y+gXvyv07tSm4CBLcU9k7seyTbDnclKsjw5qPNSyDCuvL+jAiCmkbuzmwajKMyYqwz213xH+ACxTeztxjwkoiBp0DsSPIMTwQjasORXuw/6SImQxvSlpu3Rz/UOf5lLVSgbu7tvlqt9+6SgR3iPiA4T3g0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWxKiFzUY963B85F3W87J1fcEyRLGS6PoN15H5V3lkw=;
 b=miZ15eQXix35644Z4EqTp/Y4OoF8FpO+0+BavUkI3JyVR6KzokIbUDLbSz1+5x1pggbDtpowdEmIImfxc6oo4MJunFdcLfN8YnXP51kcles3QEYz38Avmu4QbZ5Xh2frZgROqu6sa3MHtGe/6b3iR88MEcQAFM/TfVj3l63GfGQBPd9iRr38cnLVlijPR+whJa3u3NoUrL8m98/9iTkHMRzGC6YqEHQUvBoieVYfmk7V3EnjWW9wbxLlhxOOHZpgnspsUU2jdViry9gV9SHcuHx4gK5TRzNIJhQMh9rTgAF3wulPSwGe4I9TBeuqsnq25vZzZLBdPnJ4SwDVY4I3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWxKiFzUY963B85F3W87J1fcEyRLGS6PoN15H5V3lkw=;
 b=j0+6lRmyLjfNH68I9gvUGRZ2E4W8GWb6IxuvqjiUwMNkICbgTudH3TzM3IeLgO9ajiVgEyML7ImH6KBpblVdpAtnXTQdQumWG7zBPA8U48B26PI6tlfBaNFtQxdj37TT+9jHL6pzWt/Lh7jIpQXXtHSxKAXR3Yt9ciui/42VVzm7aLQ2iRsTDyccq/xG6qs0nGzXDGdcQk2lHpxuwax2LTKSgoD4SUpEhF3a0ZSExq46OG+DIcEbTEsnZiqwaZ4Q6bVVJaQgB76oOQBht1uiLOowoijBmgBASRetgXuLt1uaFh+/tZh2Uyu8M0Oi46v1lQQaK7C8YEAM57wJR1INvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 17:40:44 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 17:40:44 +0000
Date: Thu, 13 Feb 2025 13:40:43 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Margolin, Michael" <mrgolin@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it
 can cross SG entries
Message-ID: <20250213174043.GG3754072@nvidia.com>
References: <20250209142608.21230-1-mrgolin@amazon.com>
 <20250213125126.GK17863@unreal>
 <20250213140421.GZ3754072@nvidia.com>
 <777e5518-3f0a-43e8-b80b-0a3ba4ecf5da@amazon.com>
 <20250213144219.GB3754072@nvidia.com>
 <20250213173510.GO17863@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213173510.GO17863@unreal>
X-ClientProxiedBy: BN9PR03CA0877.namprd03.prod.outlook.com
 (2603:10b6:408:13c::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f779bc-0e17-4eda-ce9a-08dd4c558ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/+QiDf81dlJsYyzSLGygvtCp+MsbJVyjmJjC3ywrE9rpY5oXAmFTblMkEEeR?=
 =?us-ascii?Q?s8vZ8rB8Fmq9grT8w3hgHh3s9ttu/CWfdHFZNso+wsGhNnz2vq8sY7g7o/WS?=
 =?us-ascii?Q?kSiQex9QHFz4kmbBxiUenTAtX5T+uU8zcS+2lr3s3oDdX7Hw7WAnt7OMcE2C?=
 =?us-ascii?Q?TlLBPmmA6F9n3GQNE9RM4SSt7jxdFfjHzxNIRS9jJgGEoYQhupCwFtfKFlav?=
 =?us-ascii?Q?1dscH2MrIu8AAKVIYStwtUGjKEMQxcHEJF6v3Oamws3uNIbCutYr5MaXrBUj?=
 =?us-ascii?Q?uupWzHRatifNGEkCZUfCJ77csxRaTFHGcFwudHRNpibuFrUk/EwZ2+GJhIcB?=
 =?us-ascii?Q?K5+Dvg341prbtKciGkrHyUUsIt7UiJobKT1qS6DobHX1C4OlN39biDLPJ5sM?=
 =?us-ascii?Q?thpvMiDwxpKsX6LCcx9SdIKBPZAl44tO8StJvkT+YvGh+jM5eKljERct4CEV?=
 =?us-ascii?Q?J5D8k49RPN+8ZKp7chIjwWsyxDWVG4jdPIkuVnwPBDK80ld+9PW/I+0X4Lbr?=
 =?us-ascii?Q?AH0y1hAZiz8T+gqL2YcZBd6KIjhwlvawkicMHHXJFjZzdC6MjjN9nol59nzh?=
 =?us-ascii?Q?oUBQY3Oye0IretYq9/CHjHmPTHZpDlth3gq6sPZCjGL+hbH09zFWKBkGZPqL?=
 =?us-ascii?Q?kvyk+VrdH0Rym1ZeVZZwTNioJzNFKrEHtpZCGoTeS6lDlQFdENiLPx9iqnJy?=
 =?us-ascii?Q?FdN2/DpoRzs+qlXwrVu+4r0Ddv0oNL0y6RmljYygW1c/hhpIUWdUPDw/rYV8?=
 =?us-ascii?Q?+zz5f0NYA8rQ2T0/MScRguEuewoBTHddLpzGMpYbIXNDqnEmymsSpAJLmJcM?=
 =?us-ascii?Q?ipr2nnLxRqed5HXllS2i8wS5+swh5Y7YOBqg/g4JbFlE72n0lo8Y6qUg/shC?=
 =?us-ascii?Q?fXcRDnNN1jdvYFfass1pafmOp7k33GyVqh3CcYRtsrn/mIAbV1LBaI3nNQID?=
 =?us-ascii?Q?hINKL+JbibBPzjvfFuDEUFCtBx+jTlPpJoU2WS77f60scIHRrDFj4+nHG/Ct?=
 =?us-ascii?Q?7jQ2bQ08yV6ptD71VakdLAnd4f4WNT9A+6KrJmTCtMIzDvHWiZ40ReAjkGxE?=
 =?us-ascii?Q?oT4lrR0MuLNKLq50qPh6cbmea1ZhExYVeFFRHbPUY7zPT0zxjzboXAOs/Rqi?=
 =?us-ascii?Q?+J2/L736lUEjqiqJz8U2Rq7jav6WDzTCcgIeUJJrV0GnXMqpk6ilMF2AqeSn?=
 =?us-ascii?Q?ywPi1MmQXbVe2/yHJl9DNeAhX/5GYvCFX+NJy5pDzKKxHK/hkTjgn4PTmlB8?=
 =?us-ascii?Q?0CbEgrnYzuicFa5xnuK1JHjLijytJInHs6Ky0uC11QGBhzkrIQc+a5uG5y8L?=
 =?us-ascii?Q?K6A/sZGJ9iTo9HTMRyCvMdIq5SUVhnw7IfBZWadaxtF+n6mNFgHCn22FBfU+?=
 =?us-ascii?Q?PmIf/S/sd9bhBi35rj2Jrq7iw6tn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hkb4tp0aUI6LEZQpb6WoNBcBoAenGGQeWbYkz23q6/P/j3fAhixVW/lPjmLg?=
 =?us-ascii?Q?co/vTzlsnJoruZ8Ry/VDhKTAyvSU5Upg01VycfCx6CzNgNwsl2CLJD5ZHze2?=
 =?us-ascii?Q?e4UvH1sCkv5lOw1c+BlNJ3x3UTvvjLaDfPJRljJf39D2BSkPqqWQgPV73KIf?=
 =?us-ascii?Q?/XfVwOt09J0zvG7Y3azPZWpceLnZdXKTVP1Y10258HjdHkoGVt77A45+5Tof?=
 =?us-ascii?Q?Vf7agwr8gi35pvov2R+Hf5KHfZVcOvLZAre1AgQuBnyNpty+WuEjNUDRr2yS?=
 =?us-ascii?Q?Ik5S2IhP7ywYRHzYir3PlJFsHwJ2KpeTRn9CKJdJbmw8NfdXdpCI3ZI9Mwb1?=
 =?us-ascii?Q?yna8q3DDqKyl+MKes1GgO8V0d93TDDytMKZieU2T4ZWwsGd2/ImBEEVLl0yk?=
 =?us-ascii?Q?jRVJNS1FbeXl95HgA/O0rispdh/1mml7/CmbxKCMUipddLF+X1cwoEWdGc1r?=
 =?us-ascii?Q?3+ggjRlOzF3PR5xTWbwRZWVXmKWDLX6LUEge5Jmkia1Nok90TUGbMuC08dYL?=
 =?us-ascii?Q?Q3YKL2p8X+cSn/+C8ARcoiN8kwR9hPPugb2OTXaAiP052f5e8JK/VYsxV8n7?=
 =?us-ascii?Q?O4qZFiG+b4cGWxluBDLtalj3u0Lefg7bmp6gQjqLFuFug858Mw8sYO42CRZZ?=
 =?us-ascii?Q?hXNsSZhMl4JSX5OnVmqQPRlFL8OaIiJGRTDQOvxnu5/rVINriWZSWU6wYB5V?=
 =?us-ascii?Q?x7wXgySoh55kzSX6yluALYJpX6UkVIFMoKpSQmVrTDmUM6lCsj/Ytq7v4uLs?=
 =?us-ascii?Q?u8IlUW7kdkb9nlZmBcI6fmYkA1tnbeN9E6ZhaqcOhi31G82yJicWTd3FwCP3?=
 =?us-ascii?Q?plz3Ptk5AYYp4nhzbCJLQy353QQ51T8+4nd4Xf0/rszrZ98y5anXf0fyescA?=
 =?us-ascii?Q?4wy8FKL/gcpXWQ2Ij5u0vcc8v2ykQwHeNByUzvruhFm8m5gZlE88sZfzOUgS?=
 =?us-ascii?Q?Lzr1Z/xv7PgNsHqHhpyQ6l5hi0rLmi1zGRBhNvG/BoEhYZlDQykNi7Mgmd0r?=
 =?us-ascii?Q?EiWduo/k9lkRZ6cuK7M3KUXZARx5vTDaXusukKtMQUWzWmEvPN9tHYQjaWMW?=
 =?us-ascii?Q?eOFeVHIbNDiaCtZw7611UOKdwto2KrgOXRkhbg6ouVRt95iL1mRPgI09GNVc?=
 =?us-ascii?Q?rZicZwSyz6HDHug7lZ7L9vUB7g37Dc/engeE8l+lXuMt/TMIO6/t2QQ6xPa9?=
 =?us-ascii?Q?8SBTnQIulDG2Ik3Aoszff5jF/EqNXsgdvD5o97+LeZoo8Hwtg1YWAWi4voPc?=
 =?us-ascii?Q?dM2wCMHV2W7ZPg0w9/+cc8qGFrbpbmG2W3bFVxlXk5MZM0DhMkUpSCvqcq7j?=
 =?us-ascii?Q?AO76XiT8DeIVsr5nvHmbqHo53uf4KE5yqry2sip+YhDlLWoOVTp+OyE6WnRx?=
 =?us-ascii?Q?sIYcjJCkAiK2Y3xP1Hn5Ldzu4glnHpMwsfzUF20HYvT+Hl35C/LsS1hoPxeP?=
 =?us-ascii?Q?cp0hODSFzl74dGdkqiok48cY0TD1B+q/+yR1NZodloAFKdMGm9GL27pK+xAw?=
 =?us-ascii?Q?zBbtCNJUUCJNnBnvEnOcWDsBN4dFp9ZPqwgZF35w9O9qGNbks6t8uogu+TCD?=
 =?us-ascii?Q?iJcq/0BiXv1nNOdkf2bFfb5ZSRwkwf+4LsGq/DwF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f779bc-0e17-4eda-ce9a-08dd4c558ada
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 17:40:44.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnoYLGdLiL+bm7GHi1EugNlQFa3NpDK/DLKAqqkyhWdkA4EsHvJKWnqwLBDYu0cD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148

On Thu, Feb 13, 2025 at 07:35:10PM +0200, Leon Romanovsky wrote:
 
> Initially curr_base is 0xFF.....FF and curr_len is 0.

curr base can't be so unaligned can it?

> So if this "if ..." is skipped (not possible but static checkers don't know),
> we will advance curr_len and curr_base + curr_len will overflow.
> 
> I don't want to take original patch.

Subtracting is no better, it will just randomly fail for low dma addrs
instead of high.

You need to call check_add_overflow()

Jason

