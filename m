Return-Path: <linux-rdma+bounces-5074-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E77984A88
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 20:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3F2280D82
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 18:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478C731A60;
	Tue, 24 Sep 2024 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JINyzNbn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B01B85F5
	for <linux-rdma@vger.kernel.org>; Tue, 24 Sep 2024 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200837; cv=fail; b=EMbFLfp399aFPFdQsHlRHAbpT2Qk0c+BJdl32bZSsntCA/ntc17rM+NM07RWQsyZv8ZPPXsBqhiMt85v8IlO074u+GFpwDC5OJVQnGg/HZ09tu8u0+7AWherJOOedaXAKK5Ko7gOkqT28EP2BN6oVHIEwprx94G4PUhcyJQ3Ck0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200837; c=relaxed/simple;
	bh=//yF6J0i7CIid8LLL2vHxbggFe9It2yfxoLdQB/r+Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gO8btsCOEB7WbohDUuxGSub279OuH3RekUV8wdMUQXxoBvLwZmQDAQ4pxbuk2zAy88NuxOng6UXACvF4K++X0Ydp8J60SFKsFeTWZtYxL9II6yY+8xDCDF6PoT0XMJHZlBcV0sYLmrjHCyWR9d/UzlIK0B8GubrZ7vYHdeCKbIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JINyzNbn; arc=fail smtp.client-ip=40.107.212.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHnHH7wPx54p1ri5UUz53Iq7C5SXIniTF7BPQRKjOOuGCJ2RIPJpJMIg/TCymS01aqxuVpgWHX65OMxbYGoBCqpwQ/PoQles3ye6V34pn/g47x0E45slpUIF74br+vD2XQTODWNiglE0jRcoSP0+QOZuubrAZCav04DZphaiCo4gZwfBlu+tNebbQ42lIxCtpgH0veHti3Ua5i72FNmdBLpP9n8l1UH5g7aKeAB2s8LFf2xQPoJgUADiz02iFssqFTJaIfAtUz7e+gpynhoKnYhqc7Uatvs6LCyZ2f0fWhHjxVle9jSCVXeif516qPfusfWdemAxwfWgUwNT37tbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vfrQNqW53HtcMWO8PwF/kSffqExtWFwFgYetbwvcgg=;
 b=iDrTAOCTtzxe9sDvbD2MpFoGEoZ/dHawd5sJm9yBX7ehIlQ2KCndL4Bvmj18h5ak02lp/8SbRrbawiN4aDZipct14H1HJj/DUBnHrFLd5JNIfW1mzBv2niiL9jQaC+c09DCQAsk1F3d+fJFbrLSv2kZ7Oyn/vFXfw0lo8ZHjq9nf+GOOi1nq/cOmePQBPRIGumyDRdN98kUpeA2CC9dIGvaKEo6MfBoVZfD14/rSYWxeB3fohcoP+VlqwIXVkagDJxqz+ByQM2mdNpp9O54rvvMxzjwLIi85Ya5q2Jt++IiYeiSmAGVdUlOKxXUBZz8doAhG1mWExg0Y1STBdEdP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vfrQNqW53HtcMWO8PwF/kSffqExtWFwFgYetbwvcgg=;
 b=JINyzNbnovZowkMPLVbLmd/W5ZBtpuM9n5PcaE0RTRXi7PRJl7XdpZvRBcoz03hvaIeaS+LeivpzZrZDay5JeRJnZikhnVo/C+2NzKOIOcvXriXFInQ0vBJd29MXNZd9tFq71M8GnJ4n273hVzh/ynJOrakD7IcN2vuwNkMNlWdHCpWxGo1/oLBLTV0QPjZb2ie7rPNWQmcvrd4x9qOv5N0x8dPnA9weCIu6Gcf5e84zMK6X7rrlFR30QIDST7pWOqnhb47PcL9vLIVKq/IhukcFbeeSYFT79R3gEY4NSRKIi2d/ZhNQmUvlhVpGgOBoAcZhXCDASYTef/65RgwA+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8547.namprd12.prod.outlook.com (2603:10b6:610:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 24 Sep
 2024 18:00:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 18:00:32 +0000
Date: Tue, 24 Sep 2024 15:00:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	kernel test robot <lkp@intel.com>,
	Yehuda Yitschak <yehuday@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH] RDMA/efa: Fix node guid compiler warning
Message-ID: <20240924180030.GM9417@nvidia.com>
References: <20240924121603.16006-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924121603.16006-1-mrgolin@amazon.com>
X-ClientProxiedBy: BN9PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:408:f7::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 69667105-d0d0-4128-1d2f-08dcdcc2c808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b7w5THpbwgC8X1opwZlAyrnXgfU1BnDajmPf1PAMXowbs9Vz/eTFvaWV7IxB?=
 =?us-ascii?Q?spkDClRE9K2CzHZv+P5IQuOfyuYlCXOTmbzi+uzS7VXWrCr1CVFO1aZseFCl?=
 =?us-ascii?Q?KaLvlsOiY7AOKigT5MA8csF7CPaFojrbThN7+RH3GYfg0Y9kfgBVgX44JNwz?=
 =?us-ascii?Q?4nzv5b9ksXbeYrdCCovSfZ8V5PNh214Ytg89zwQGhGlqgw3mHLSdh++AjH67?=
 =?us-ascii?Q?O7ZHTAFuJZZ63fRwafry1qBaYWyj33g+VKsEleVsW5lzNJk+BZffGn78Fxuz?=
 =?us-ascii?Q?dgA8IVtU007L4YyYxseXTMjrYOw9SvyEHBF4xuWBe4v+d3U4U8Hhk+4J+zTS?=
 =?us-ascii?Q?Y+mPzk3cGXqmkwkyM/3XWnokbojuC1TNBh4pYGxTcESY38FbihSkh5DOExOP?=
 =?us-ascii?Q?dQU5nVNOov3ent8Lj4uO17bujLEfYpOff5ysH2tJa3k4NxUbFaGs/PZa+aeh?=
 =?us-ascii?Q?Mt7SghIys1x6Ob1ff3zDM+Oil3V3u+D3XcnLqgft+udE1iMJtDUYRW4BXwtu?=
 =?us-ascii?Q?+MDIdgx4xUfLFBtKUbMFqh1Yrwjg4H+c5gRginmLaDtG5R3ydDpfPG6gkpyi?=
 =?us-ascii?Q?q6WGVIcQ1dDDikOgxlbZo/VvNLOf/f3a0phmg13mJDzNXje1/eMhPEPs3rXx?=
 =?us-ascii?Q?sRkGgzToRfpvXtWzq/njYLtgIp4sb9/8WclA8GAi7rYqA9vE03G68n0TATsu?=
 =?us-ascii?Q?WegLZfKbpTyR2OY0KBS3Hl0YyFnX4zNC3TBPxDoJoe3XK9zB4y/6I5FxxO9U?=
 =?us-ascii?Q?U8W6OY8SuGY/+ZqGMxA2jpVXcOjsXwT2SrhpG5dTsDIh3M+xQWXQQsgOxzIR?=
 =?us-ascii?Q?LOGUEB5G90nQ1mw0y6hwi6Pjpphq3GHSrHKdLh1BdNsdyS5IiT3BEMj+AIst?=
 =?us-ascii?Q?A5G/i3KR6TPzJ5E6pC2uydFN/HGgfX5SE64jattK/meD0k26ZVzbI344MmnM?=
 =?us-ascii?Q?BK1OH/loKZxbrnG7nSXu4z9e2PROXAUChr9TOfxefDZGgRWFZkeFHoRUJfF4?=
 =?us-ascii?Q?zXUp4G9vPbuVBJnqTvlPs4BQ9WWksLodiFMVNdCh85iDE3uGXAr4NJSfcYGk?=
 =?us-ascii?Q?CS3UHk8MX3B2F5820tozm99DfvrJAJad9rMUWrKonu6zaCH7XkSKKIxgaHrb?=
 =?us-ascii?Q?UmzcAJ/wTBxlCQld/Rxq5k970DjkdcUXYPMhIbBvWj930pcn7caN6U5cY8dN?=
 =?us-ascii?Q?efrQr8G0wRLNKHySGv1ZcyJd4qCX2jyMBE8OoOozq/3MrBHzqJAobbAtj/HL?=
 =?us-ascii?Q?0gQnio79bmveItbg/q/+qO25dOjm3WGynQrObQrLiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YDtKRyLcWoUTa2fYI2q725v1mscaPlKA2DpxRAM7JIz0PfSJlEuGmCy5C6ab?=
 =?us-ascii?Q?HYRDzJIz4HzPGpS6BJdceknTUteotDE8cOWDWdY+WJusZeJ19hA/zfvEi/+6?=
 =?us-ascii?Q?rHnKSju9Y7mSK+mrBjCEpub5/MzqMC3g+JBRRVBy5i/8LYNOiNfQqy+9bOkK?=
 =?us-ascii?Q?dLTE/1SPXMLoQM/VS9qiFKU1+mcNhmRVglhujl1b9DyPeJIyglfmLa4Nvnbl?=
 =?us-ascii?Q?bYWxo/9irf0/EiSyUofkJV/b0XNdSapheUwZFxE/HMBrr/nKx9CyRcGo+QpX?=
 =?us-ascii?Q?ametKAe8/hzYIjETDdJMTbYg5duW2HZhrVL1DeyZO6DTKvQp0bZdMxL7WIfM?=
 =?us-ascii?Q?yQ6gDoUldZMiK4asgrrCnGNkEACGrTMSz6L5mzyMxXfQtsBYHbhu+7nZ+7m5?=
 =?us-ascii?Q?EmBYvl/Hlx8/H6gtVa3FGjksrVrgTwMBYKaJ9oTCet4LGTcpa/himxOLscUq?=
 =?us-ascii?Q?iYImmnFAH981+2c84OoJmWkA/zr+4yKxLIVqC9Wo0UXeocV9Qqnh3elg4eNI?=
 =?us-ascii?Q?CjKH5Z7GiBazdr9tJcTGe2aKWs9jzOeb8S3dCrmLqxPvQ1jittbf3kituDeJ?=
 =?us-ascii?Q?5LJ5K7pYHj/97GTtClA25vDquYUbI8PFBwkgejrCMgpAmpubGa64s6uI8b3X?=
 =?us-ascii?Q?p8PMjgzS99O5VIFi/Yg3wjI2WRySPeXqt2wJg3IYBUDIwGeCERa359t4eFkL?=
 =?us-ascii?Q?ir0OFOyhB6SSO0cD8oqSTRtcPB2Ktd4zWoPaLOw+X55cezDEiw8l4LEkcOf3?=
 =?us-ascii?Q?PHAgF3ocqmOZVAK6c5wsArESsMo3ePuSpAFXFklcpyE2DUWMCdrZ+QSFAVKj?=
 =?us-ascii?Q?nkwz9lIo3vYH80aNFm5RZDrAIR1bp1Kmhpay5NDntwxvyR1yoeVXe+irrRKN?=
 =?us-ascii?Q?BbiOAzDOgSwsBnGeQkNs4rXEsYzmkOv2VBAO7Rg/p0sP8tgx712AS8dseA/k?=
 =?us-ascii?Q?6sRE3XaKyDgvbZCiVPUsMx5F3KaeNjlNxL7+llZ6doXlep8VZCRUMD8ZIkbL?=
 =?us-ascii?Q?s41UTLTzThun3k5Sz1oATeNmnTmJg9rOFVSt2+1au9Y1YCWHxV/cjj4yX5Je?=
 =?us-ascii?Q?EIWdeeiv6e/zuhWb1BIi3IBZlGErI5/RwC736VpurVKH7nuhc4xCj5IhZuJk?=
 =?us-ascii?Q?tEbubSW5riHsAfNjmGX6DuFVv2EFQqqdHOKpRlJHa7jIRpsKqjXNSWZySc0R?=
 =?us-ascii?Q?ngLoEkHzNVPblNNr+4vSeQr4Q5E4EiZyT1AI69RD58Ili4guQwQwjfuDL19E?=
 =?us-ascii?Q?uktvLuKTWANX57EiL6d5O8eJyTdS/0GkVhR4Xo3y7p6dJ/oeN8SIVIlnFhHB?=
 =?us-ascii?Q?ricjNN8XayBsDqiJM790CXm8B06w4S7A1qXCHzcbudLwvO1VcTNH5N6f+1FZ?=
 =?us-ascii?Q?+Ome82/COApiW5/8AQ1jUzkmzgqIp6XDRCt+7QNz8bi1VoqrYWgAFkgUAHl2?=
 =?us-ascii?Q?9mome3yugYP/gNCjxN6TcCHgJZZPH5tt+dzI+44Rcp78AirdjJJPN2aR9Y6K?=
 =?us-ascii?Q?ffpBymrqXiUWLtiu16Xy/6l4p+FJBWBYD3iYnqV0cWu3lTpyAzaBOvha/q+f?=
 =?us-ascii?Q?zFRLshUntIcpvcQ72Ls=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69667105-d0d0-4128-1d2f-08dcdcc2c808
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 18:00:31.9136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhOYhXGJJru3uqE0clgQ7Tw+wnyBPYG7Jc00QpJD1y3d5iDUIHwFpZw0b7RAtIbe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8547

On Tue, Sep 24, 2024 at 12:16:03PM +0000, Michael Margolin wrote:
> The GUID is received in big-endian so align types accordingly to avoid
> compiler warnings.
> 
> Closes: https://lore.kernel.org/oe-kbuild-all/202409032113.bvyVfsNp-lkp@intel.com/
> 
> Fixes: 04e36fd27a2a ("RDMA/efa: Add support for node guid")
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Yehuda Yitschak <yehuday@amazon.com>
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_com_cmd.c | 2 +-
>  drivers/infiniband/hw/efa/efa_com_cmd.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
> index 5a774925cdea..5754da4e6ff8 100644
> --- a/drivers/infiniband/hw/efa/efa_com_cmd.c
> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
> @@ -465,7 +465,7 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
>  	result->db_bar = resp.u.device_attr.db_bar;
>  	result->max_rdma_size = resp.u.device_attr.max_rdma_size;
>  	result->device_caps = resp.u.device_attr.device_caps;
> -	result->guid = resp.u.device_attr.guid;
> +	result->guid = (__force __be64)resp.u.device_attr.guid;

That can't be right, use the proper conversion function, or the proper
type..

Jason

