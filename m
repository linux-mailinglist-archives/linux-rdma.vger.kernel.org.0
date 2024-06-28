Return-Path: <linux-rdma+bounces-3566-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC90F91C30D
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2024 18:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356401F23062
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2024 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C59A1C0DCC;
	Fri, 28 Jun 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UERSFyb4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C2182B9;
	Fri, 28 Jun 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590435; cv=fail; b=ktp4lJri5qbO0UVLNbXOid2rTOpEaPrRhcVV7I4zuJdWeb+0phX/+Xq5C97eJexHkrTr3qQguGVJGee7M8JZZaiPksioUdixIvnCe5ZaxZh8hiVT0/5pBmK1goOCyM6qBIl4XPF+ebZMxfUiuVLeLwDgvdYPWCf7yN1JVWmllRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590435; c=relaxed/simple;
	bh=lkIg9V6s1oUhsOTu5LnOSRE0ZjsyxntURe8y2Z5rLZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZovN6RZE1nc6fxZR7UabK9ZBh3b6x6wHAOY6GumoV3T3pp/jDjY4XYZx2P+o6Hs7QjLk8Xwe8G1E27FFTp2P09Dotp/vCqx9VzIbs1kK99RYBO48EVfnaHlowOInYJzcaJ6ZLkz5rcrt+ComcCy6XxGYyjOipgT4QYqNa+1QrnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UERSFyb4; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZV6zNVFQapVcFUWov+zgrV1x9JgIVJdB0KR4p8hUy5sU5DEP/gfe5kBDeDAyO+LNnCyDImsyMRD5Z+efCwTjCNSWFMm3shkpBffGFQO48VqGiRYWTfHKwnB/MZUldFVyrZlos0/lplytSWJ8Cjlrcn8yi2pAIQvQN8esNjEo7dd6R+56U4cNnWBmjOk0lCG2PKiMWgHYlEjlbEv9oJpspRE7u8mPyX+gGe3kU0FoRFMlBC7YkMEtexDNH9VJ3NzAlqnxtoFGd1/gyuGnegxYVXMzctnPX7Bmpi33WC+gx+jU4OhJTO1KQEPeWjoMzZ2kR6fPsvrDiX63XWEQTVcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVFo9/GiXIm7J+ifP9rzbLFIMiHSvRHv8mn3385kfzE=;
 b=AapE0bJ5iVFNajygZPuA2B0Gi5yrftCYN8+dB/0Jf5qqf3C4wpAJ7ex5Y/zaez04aUfJqAhlkDT9dGd/Cil17OnBDujkFjcHyY5y0rdFCfSCBqU4nsTPdgiJAe4sT2tAO7mZQ5JmiFkzfxNeN6r3m+yzLSmCGMq/52HxrTcXZVBwAQ9y5tr8A7BcCKKo9Vax90dcTXRzmX1Qlk+f83vIgu4jO917zH8x7nUWOuNkpsA+diCCmtVftzRQjCCF/329POaPOlyirP/oMAOEZOFdxurW6J7klavmFyQaIHfTzEIzxpgD3ShcoDLG95fiN5Ck1LRd2XRMLEKIkwvnSc23SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVFo9/GiXIm7J+ifP9rzbLFIMiHSvRHv8mn3385kfzE=;
 b=UERSFyb4NGaMPAEPJR1OBa4Nyhm1STVlZ27lt8BSSBnJdCRNNKViCp+5Q+O4o9ca81JIfMhkurLZEVJj5oVgi/YjsbB57lRlG6ouyXdiEIJnn9v0CkIkfkzLrSO4TopnV2dvkh20Txe8aXh5yRF8o9FPqVBNXjmB7gclLBMfyLHUQ7W1sNgOZmNs7cCy+HUITIT/pKbk7Oad4ysPyoxm/dGc8ZeWdfbORsLd0nvWwvOlzZyS4y6p+gzwXO1+uxbIQJ2pDArfRlBGDBFgYm04T7AViWJMsvQEoWSBeIJMNfgiXYhYNKZaI2FHWd72MFXrUB8gaUiBcJT1h1yLF6EpKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 16:00:29 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 16:00:28 +0000
Date: Fri, 28 Jun 2024 13:00:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-next 00/12] Multi-plane support for mlx5
Message-ID: <20240628160027.GT2494510@nvidia.com>
References: <cover.1718553901.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718553901.git.leon@kernel.org>
X-ClientProxiedBy: MN2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::24) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a9e6ed-1474-423a-934e-08dc978b6e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ZILkO9v3sRPEmcJHpRvuHognL+K4gntHb68K1YiffupOQ3tCzaaY1EfoXfD?=
 =?us-ascii?Q?TrDUoBz48Rd9Y7qoiVQQnaj7AJkvfaJ5qMRlQhcan7YmfJPna6DMIBb1wP0W?=
 =?us-ascii?Q?f1p8Q4Yshpjp/AlFKftLIQ7cdq/dYndxDHE4ictJO5QYFATn024Om6qG65kj?=
 =?us-ascii?Q?Gwu7xMADflrNphDA4DnBXNmLTvLXBPoZWy+9ukh1M2R4F33fBmbVVmYZoXv1?=
 =?us-ascii?Q?m2v/nhcdAcRHqQGcbNtEP9+CJyOy4DkgxACvQMe+JNgrrxT6v9oc1v3B6ATr?=
 =?us-ascii?Q?GtVehVxQo9P64l+rHWyDTIbxejbvHnST/ZKMz9Ddpo8g4dAq+ANqZTnnIxq/?=
 =?us-ascii?Q?NjCfpQ7lfjsKFTHML7rJRzBw7DlkDvvPIKBr0m64KrKwY0a4UxqbcPXUEJQj?=
 =?us-ascii?Q?qg66PkpGt5IEgwZj5pt+L/yQQji0e9qHL8TPKTwPF1jlfoFgLCNL8aEkpr8u?=
 =?us-ascii?Q?B9v0Y75tPT+fVGjDu0bSPqArZ1WeEp7/WMDId7fO4Y6HvZVgZMTX0gJvkCMy?=
 =?us-ascii?Q?2uSb0MTGzGksPI+c0G4hEMkWke4MlidklWT1UcqO8pW/ZEQUTYveLcRpRu/S?=
 =?us-ascii?Q?ljdYvgRmxPUn0ORkvvL8J40mzoK8KWrhr5+YADiaO92YyHFN2MfL6G741hxW?=
 =?us-ascii?Q?Qn939BgWBUyw/te8L73ZO/fL09eAyligLHdfi+am/Vl25daBGKoMxcVFeOcw?=
 =?us-ascii?Q?CfdZY1V+CFg9XHU11VUx/IBPoxk9xfnpCQf4ScP/yn8/yak/QqstTxJkD8kh?=
 =?us-ascii?Q?NgBiIXAveIb4nIuet/gaN7sdFWR+nOnZwuvgu7mmrsPAyJpSZAk8Nl3nMPp/?=
 =?us-ascii?Q?i7XVB9izMQocA1466GQ0sQWyFFrAD0zKgxVP0qJZ6/GWh6VbUlVcynvwT1ko?=
 =?us-ascii?Q?Dd1X/U9hGvjZkS5T69VXQOPwMQbjT87X2mwthjTkDNvR+Z+jQ5YSeZfjAkKH?=
 =?us-ascii?Q?qFKaXITbX5EIxxcKSrOHgX3qchtVZQ3VnjTVX0wPvM977lykWnNJf82OjgMT?=
 =?us-ascii?Q?2sez3dQlbMtBGI7+98nBUXXsALkEot/psR/hwhHjOsPzuHijHMSnBcCaZVoJ?=
 =?us-ascii?Q?EfXWy72CeyxgiijDcmW1SUzkG7tK3Cf7vAuiKdivafpJPNB6nUGwvboCqtvT?=
 =?us-ascii?Q?OXniGchY+BDeXQcm5foQDR9esomq51gjoFeI0yeDHUabklHIEo7IO68D90bo?=
 =?us-ascii?Q?KJN8KedOfycHzK2crw+yJ780B3O9TyZWBkRcxfKOFnAwbIUuDf5QKCz+bB5k?=
 =?us-ascii?Q?fwYMOKVz0114WmlC6rvOMi/TyCoQIYJj+LgZA81OdEcjTTbOWfOsAa0xyZR6?=
 =?us-ascii?Q?uEfQ+y0RCvq5iceXzPnwLqVIsx/WYcEHt8Au8S2PJt+nGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QBlI3vutFsTsQ8uYGf0FjfgB9+Pw/wvYPapIAUXL6Hcuz2PLBIQ6O4+yEYJU?=
 =?us-ascii?Q?PuLSfMstDo0v4IUDjyIp23VfC7qM4Yoqa6mpdHZ2dKdwQyFE6G2R6+jykpXS?=
 =?us-ascii?Q?0DhU1eLVSvCauluFOwu11EoPmzkK8hM6e0iybcQnv4BdnX8bgA9hwIuGOqyj?=
 =?us-ascii?Q?8u/mqdLsmXs9rh/BXUysUT1BEIxkhloYL/3BUy/iPKQ7XVuBKxyFYV3Sn7la?=
 =?us-ascii?Q?2NTG5ML+ot+qV/buJWMWo/sWXthX0fs42Ch0sJUr6J5aYs4Ujb81vjHVUhBa?=
 =?us-ascii?Q?7XkhCoRv95wEpNlnQ3LUsSueGR+qF/kPp8bQ6UzAAGT259GS+47WogLVbsvL?=
 =?us-ascii?Q?TgnuZ4IxkRFDmjvu9186P5qvuvZV+W40EWglU4n8khjsNwpet/f8Ia3kM7eN?=
 =?us-ascii?Q?7OBPDXft2bIbUkV2KyzTLZ4zuma/+aH/k7EtO3q6pEj1bm5oidQxLK4PkzH3?=
 =?us-ascii?Q?3HOUoofYKJDN95lRKTE2p3G0HgSQgjiDE068Szm8VfoharMNSkhxTQYO8k7m?=
 =?us-ascii?Q?+F8brwXzbfKOcOyfoV5iDoGkLrmwWtzStsnvDNg67dBsujYwjCS6ZWPrbK3u?=
 =?us-ascii?Q?rmc5Yk9lW1sIN0JrxCJOZpOEajGPejiEXwJVY6e9DRKAhuLzdqOiaIFYJGhI?=
 =?us-ascii?Q?Jp9MKu9PdMex77eLwlnN8oAL9zaektwvRm1Xp9gPF5ojtQh+zpS5IEzWIV0b?=
 =?us-ascii?Q?mjmpKcsR4+nn/j8CqgfqDBr9ommEVfi2l6OZ1V+spweMq21r9uatfGSV+/OE?=
 =?us-ascii?Q?af00pTfz5pcDNPXGZNUwDgpVMS9NyAbI2Otf562f/FzMenSfbkruRp2dlITg?=
 =?us-ascii?Q?ssDWSNzyBLbHx8hG6vrLJfJKRZMUUBtks//lVJMKSNCeZeMuvEsKvgvISkDs?=
 =?us-ascii?Q?a9TXo1yYPyr+wYnHImFjWxn2VGgwyVgtUJmgi4pT7b+kn5CbeRhrKRWrpt9n?=
 =?us-ascii?Q?8XwPoOAxoCec9edZJ5AY4pZMwKcEyDifUhAAm5X2fBbffq/9v4nW4uDK2bdk?=
 =?us-ascii?Q?pz85yEoOjCs3fzzHxJCTJc4kICHhIb8QyxWVdMJmoJ4ucckmGXS5i/6nOQLG?=
 =?us-ascii?Q?T+IheCelig/4EbqRP5lJjtaiQdx0Fp73kZG+GHdsBHlQHxRmTNRqYWMxQdO2?=
 =?us-ascii?Q?ZxhVMNm87ax1QPhN0nQNWd3jTecP0Lbnc/2jYmTSGR+IRXgC6IGwW2GLEch4?=
 =?us-ascii?Q?XcRhMH/+cxb+2CVuZonfdnQiHqJ7yQ8MikmGgYTZvnYD5EFevknjFfCghcxP?=
 =?us-ascii?Q?paDN867ZIHcIUtFYLmW3wIc54+3mmKNlu+tci6hghKEn6A7ijuyXaDtdASaf?=
 =?us-ascii?Q?FhRG7hrT3yLiI8YmFxBbebsDfZhGmdfdVJbAserTslutq4zmFrLOf10Ykg81?=
 =?us-ascii?Q?VFEb+LsoCpxHVAbsqINLckx8bKFYLmooqXiODd/6rUnecDMA6rbtdxac2YeX?=
 =?us-ascii?Q?2fohAtY4wI7VfPlChBRiiPGJHIGlOW523joMMNWBqH11gYBpsi+3v82tj7xz?=
 =?us-ascii?Q?RgECqyk1bamgHcCMIrttpmCG22MCF4WkwvjymO0WQyIRLhp6fIU9RsHJvSwF?=
 =?us-ascii?Q?FTjmcFU2+HA8auNMYR1jORE7erxBsGAT2dGkg/k0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a9e6ed-1474-423a-934e-08dc978b6e61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:00:28.9194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wq3Bv6HkLVrXhw7SMHa7U5brc5oqvit3mdSFD+qiAPlpnDSTjyY/PN5gUssOUuok
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509

On Sun, Jun 16, 2024 at 07:08:32PM +0300, Leon Romanovsky wrote:
> Mark Zhang (12):
>   RDMA/core: Create "issm*" device nodes only when SMI is supported
>   net/mlx5: mlx5_ifc update for multi-plane support
>   RDMA/mlx5: Add support to multi-plane device and port
>   RDMA/core: Support IB sub device with type "SMI"
>   RDMA: Set type of rdma_ah to IB for a SMI sub device
>   RDMA/core: Create GSI QP only when CM is supported
>   RDMA/mlx5: Support plane device and driver APIs to add and delete it
>   RDMA/nldev: Add support to add/delete a sub IB device through netlink
>   RDMA/nldev: Add support to dump device type and parent device if
>     exists
>   RDMA/mlx5: Add plane index support when querying PTYS registers
>   net/mlx5: mlx5_ifc update for accessing ppcnt register of plane ports
>   RDMA/mlx5: Support per-plane port IB counters by querying PPCNT
>     register

This all seems quite straightforward, Leon are you going to put this
on a shared branch with all the IFC stuff/etc?

Thanks,
Jason

