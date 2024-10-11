Return-Path: <linux-rdma+bounces-5388-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0630599AF7E
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Oct 2024 01:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886A71F231AA
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 23:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6191E47BE;
	Fri, 11 Oct 2024 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hosuo2wS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7717D19FA9D;
	Fri, 11 Oct 2024 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728690182; cv=fail; b=PbsFsFax6DQRNgYb0ImdirECHlKuZwyMMCiqfT+ZIuEXCFziN8NxMp91J/PBE9CXZVJ+HXRnSzoyB58hQSAmk5y/37UJiMdNnTxmhThiZswe9FRqUclrluCCrX1IxoWlRhTnd+vwSrVRkVf9fEmfHLWOS2p3BAO2wv0zcdHb7Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728690182; c=relaxed/simple;
	bh=UvPJu7yuGt8eCZpChQ2AyZuiMnZkCr4tJvseERelBog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qg3ZTQVsoA3JHYvrOOxmUCmsUyNCeCG4TODFz4xV0XdqPBZqSxFdpOPIZx0kSAejhqhge7Mc/o6lS+JplwFTG5DZH7S6F0W4SP2PtPfHrEeo85FxIoE8S6G8U7+vdwfTqTbl+wzLI2eXL2Ve1QSI/96Nlm598sbId/TLJdH9uqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hosuo2wS; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYGrGvHPAI3xc9RJcxUkzQDdFYwpcpYiarLUCdWH9lpvWrYlvY9GxnBZlVaIKas2O8ID75wqL3ghes2Q7lczizDxNbLRXVqAlX+DM4bb4bcg65yWqL9iL+hgpjOQmk1SlXprniSdC96FM2O7g0+Sf+Zr3RkD/AgrXt7W5SgVm4tCcLS78PKIPoS91Sovr+pbfaqd9E6d23EkSXzpMqG8+abzL6GQJXSQSec9gNkYIxaWvj/kt/vwznHh4/YRpaFkfcYjMr4ZNU5ABPaQsReRPqxZYUuhzbwncX8PbNMONSO7gxbFIWzGFpGDvCNHX5yrW3vTKJV7i1UB9TFWHeSNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn2TOYvbFQWGxk0AnhcD4o6ubHYex3UEjI+NihzEw0g=;
 b=OE1Mqb+L+yijQHaitg1iDLNmOh03Cqb1dB/F2KT7b+x7wc8pDvzbVgFHWRcDEqpwJY6PVoVeHv/fgfzflUjo5XMBZ3zBN+RDV5lauZBAe8szTy2/1T+79bsIFaK/6xHLkf2a+KRNvbkZjC6SC8w+Qx4zMaeHw/9dutFu1gGoae4askJoOm5OD5s7PtSUFDvvsp4I4D2msQyLAqP+IJGcSOptHlXj0pMp5Rau955rXfjVKlmfsK3mghpUz5CUT2GKEs+pjLgBgqPHLdth8Uvdgncz1fyNo3/KtHD7qU+n/MpIWNKgeZusTh4x75oUTR9XXygx2Njo4R0i7CQcONZSIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn2TOYvbFQWGxk0AnhcD4o6ubHYex3UEjI+NihzEw0g=;
 b=hosuo2wSOFKJwZlFh3OglsOsabxw/g+4FmbvnRWhWvFF1gL23+4n+pDEcBmaphGF8rhL//YOSy/KeUd762/CdHZMtxqZQFxgof6iKCjQLYgKVE0DCbhxGfoMmCj+pZD7WAKX3IP4da3dAwje8uMRGeYvLAMC+e02hDm1pDEv/TyTWiWKKV1m593jrLlp6OxB42Gkrj7X16FC/WEOorVTqSiennzQt9ALd39YWaQ8Dbuwpw5X6+4WNz3G1/wLvSenOBYZ4vnHfYvw3KAOBP4+oZGnA8QfnKT2PXoPPki0ZOUMncCHbcNaoHft+aSxOmD01ohwPtRiue7W+eW+Zucpig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 11 Oct
 2024 23:42:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 23:42:57 +0000
Date: Fri, 11 Oct 2024 20:42:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexander Zubkov <green@qrator.net>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix misspelling of "accept*" in infiniband
Message-ID: <20241011234256.GA2274801@nvidia.com>
References: <20241008161913.19965-1-green@qrator.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008161913.19965-1-green@qrator.net>
X-ClientProxiedBy: BN9PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:408:fd::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e7a9e9-7dfa-4a91-ee8a-08dcea4e6f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X+s6Qc8N0kK0+AXc+GkIBWppbT5rP5sdBmNusLBBg5AlJgLh7tj9HDQINdUr?=
 =?us-ascii?Q?qIEQOIkh6DSu08iGKCYYI7R70UzTDs7rGGF8ymziU+iISsN66nCkZNZdnwBC?=
 =?us-ascii?Q?4ZSai5OXGL940OjNLlgrC/VkOMTdJz3uAe0JAx90k/mA+7To4rWctNtWANsr?=
 =?us-ascii?Q?yEMtkUpaGkj43qI+judwGKyw6hlc2AkkiefWhGBEXMjUqJbgHUm0tKJmo5Rs?=
 =?us-ascii?Q?VNGgbRSwwCUjxeoa5sJ55/QZrCjCl9bc6frFkhENNVMbYxcf8LXJYllkrBRH?=
 =?us-ascii?Q?oY9OiokYft1D9T7oh+g+2+wsG8TII++/zMcr05WqRo9DU5Cd4rDS+2RshAt+?=
 =?us-ascii?Q?fjzC385Af/8hrC24wOHtsaswQ5Cr7kZRY9W/r/AmWg6hAqOjl7pg37oeZhNH?=
 =?us-ascii?Q?G1BfXPkGRwoL/3BQgigumgpL0MHIlhIOpo/SfA7K1MLUgGm0ITN4kbfroCrm?=
 =?us-ascii?Q?V5pR+RYlmlLaYRKWKz1TlRc0LHSnL89lNZsrHg8uSmhiw3tns9cLHGStPUAG?=
 =?us-ascii?Q?eJuwbln9SUj36f3s251abJDkr13RzcgRupnK+/KnKXo3J491TNP6JF2StqRx?=
 =?us-ascii?Q?GlKhJpmSggL+ppCj2ixY0kg1SCxaaaX8PLYm2LlGvpdLv7vztr2/Va/THIyM?=
 =?us-ascii?Q?Qi5XmHwF1AeJk63Ar1l0loNwdj5qpyVjdQCf+cLsOfhosigYrNoTJ/21199u?=
 =?us-ascii?Q?6IkUKthJXMA87XzOdbSH0UPLen4l7EuYzhYOL+jEsvCZ6FaZySk2p41ssPhh?=
 =?us-ascii?Q?vE/s32Q7atPh97cdA68OrDUQ2/d3HofrxBAuFm52XZWBk05DG1G+FU8JqzBl?=
 =?us-ascii?Q?UBKDKfkyWbYebSD3gkIjmbsfBJxeDHag15PVQn0Ybzbhty3FuvS5se1hkVu8?=
 =?us-ascii?Q?X3oW7Cvy+aHnI/2e2X4JqHZ3I4XhfDnxtCGzI8CAWWfPo/x73+NHP9UIrsat?=
 =?us-ascii?Q?0xJuevFJ/+6DqXzDe80sUWu8U+yJOWxflUQxyv6TP3obiYpa+qECWKkgT6U2?=
 =?us-ascii?Q?Ey+97xrsEMOSc5+1w0OVK70VZhWYUa9hFQ/VgBEYbD5DsNwveIxR1Fr/I2c3?=
 =?us-ascii?Q?TJCr3pSoQkmzXN3Bt2a0j9JIJSr6WtqjLecFdK96Ar5acKBhzEwzQjmSGMM3?=
 =?us-ascii?Q?V11L4AFOzCbnLE2o9YIxT2bnkqs6hTbREto3USMl0Fe8QVRieIWhvVK/7efE?=
 =?us-ascii?Q?8tpFIb5Fh9SutzjiF0WnA1cghmTZ6iwHfY4PWk1CGqurViRxrRRTSEJwj9kj?=
 =?us-ascii?Q?VC6VlPwttxnCL6CCBssHX0Oltt1PE6Tb1Uzo0VWTxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0bv2igr9bYuPHf6dTxb1ZGxxvwED9F4w6SQIZGA3yjE+/7kP7pQTtEyNfQG2?=
 =?us-ascii?Q?zohSSigum9hFSAv1/vzKKmpk6sYNzVrJRtg3Hf0r8Ufhv7Q02i8EhYzl6CzQ?=
 =?us-ascii?Q?vOoZS//NoG0puK5VdvykS9PiTXFvc/s7t7ghI/XDPWdspPOiots9z29bjlSK?=
 =?us-ascii?Q?RrhHNlOXAabE5+vU5n9FKT+Fa/k5ZXu5FX2aGtVdKVLThXUQMJLRNBVTJ3dM?=
 =?us-ascii?Q?qZ+R10CMUZX4yp7MAiX6az544xnh1lqGmi/gtq9pVV0dd2Ugi5+aiWmaiLZQ?=
 =?us-ascii?Q?hGcI9epsf86kAMJMa92MgwAIxFnVmDJ1rBDzp6sF8eLDPQUHqkI8mNPwMsxc?=
 =?us-ascii?Q?03Y3WtyirAT4WW+Y931qftkhriqnX+2s8EEAAQm6LPfqK1/A7jtMFfEFrpSc?=
 =?us-ascii?Q?xuwDjOGfv3Gq494CY9Mo15Y+garE0bjeKONk0dQC3GqmNTW84oSx//hsBFoW?=
 =?us-ascii?Q?g0A5WFaDz6nk2WTibIdJxqf8s9AQ2g5mZGNa9bFqt2Ibg8me2jd9b+AWVXHe?=
 =?us-ascii?Q?fvdud7l5J6TNFB+MW3RdHyi567jisbzpcmoSyrx7uajEj1qah/WBazgUyVZZ?=
 =?us-ascii?Q?XFnakWCrYKClsthRetRsEUa7ZZCxsn2BvDZi/wPdJukAbPjpKYAW0SLzNDU4?=
 =?us-ascii?Q?whIMT7pD+Etktq5zdYKCQ9FjY5+y33qDKdg/Jjm4Q8MCEYkGKDS+ag8GDXvl?=
 =?us-ascii?Q?nKtiHZ3c7dHjqHRAFukHFntdKKe+4OGb8QO5Ko+PBxAVD0xr0PkMz1oY+5re?=
 =?us-ascii?Q?qta5E1h2HDKOcSn5q37O2uLZ828NVd/kj3JeoNC/vjMDdF4xq+koJkEt/gh9?=
 =?us-ascii?Q?K2fjgs9Ieo1sFDuUkOcEoFvOOW6zWkArgoM04zZmKesjtY8YQKABJR2Dejcj?=
 =?us-ascii?Q?INBJL0lEZuo6bIeAWQ7/lbjso/Ii65bSEPkVnzTUrUkR6ZPTghbA5D/zG6s/?=
 =?us-ascii?Q?g3uQsgbUZQi1YR7MoHpX1Tgb5aiyO5Q3gRr0vd5DiQK9AI7WzpulxWQnybzb?=
 =?us-ascii?Q?3ygRDE8OIDMNEoEKbfRq9/B+Hg7sjOYuKg3r395cB+jQOUCR0vnBj8MwlNqI?=
 =?us-ascii?Q?u5Qw4uOU7OA+SSobzwGPXrnejpRr8NrNSfCAHqL0x3kq12muDdC0LPYlfpgW?=
 =?us-ascii?Q?LWDMCJsZx/O4j55szN08U3EhwFqUyRU6nTsyd3mxcWayEdZ+uqvjFPXecrRd?=
 =?us-ascii?Q?Y/LjkIzTT00UApW3VoZwEg/Fb/CYBXmaK8pyKrcfyFw6233K5qbuD073kooN?=
 =?us-ascii?Q?5+epSlBl8N3qLvCrVvxtzHCSwwpofYoSR+pmI4C7dnIerbmwk+NcZ5wN9+ty?=
 =?us-ascii?Q?NiLDs/eymO8SOq+pAzo/nvRNASPB3ldh6LGvdKXcFnImpHnpsWN39nrde1ms?=
 =?us-ascii?Q?Yvbj245cfmAu2HJbfrDA9nNaCLZ5w5kayHv0N9YwXqLyg6+AnU+2cCR0nEcf?=
 =?us-ascii?Q?CePbZHACMusramPngFxsQHgcfJBdpdXD8wDfx3vXucg6eWhUbnD1qxJHjumB?=
 =?us-ascii?Q?N6ofQPfT/eSatwqj75tbutAsQbnP2I+woIJ1csUu1v28Rmye6LSPcXkthFa4?=
 =?us-ascii?Q?QSifiv0IxmKoeDDbIbc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e7a9e9-7dfa-4a91-ee8a-08dcea4e6f65
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 23:42:57.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWY5uKpsFDUxe+uYgeZWidWfdYIV/J2my6LHJ6icsZRGQiqiO5pJoTaclGCBS0Ha
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564

On Tue, Oct 08, 2024 at 06:19:13PM +0200, Alexander Zubkov wrote:
> There is "accept*" misspelled as "accpet*" in the comments.
> Fix the spelling.
> 
> Signed-off-by: Alexander Zubkov <green@qrator.net>
> ---
>  drivers/infiniband/hw/irdma/cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason

