Return-Path: <linux-rdma+bounces-16933-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0pYmJNykk2lA7QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16933-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 00:14:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0965148073
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 00:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE8173002B60
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 23:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A029BD8C;
	Mon, 16 Feb 2026 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s+yyu7ru"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6595038FA3
	for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771283670; cv=fail; b=QKZzdyvFiWt6amEOGFPfPIm0ML7T4x0d2YpF47evl/Nhc347UrE/xjN47OE9ZptX2CwAl5h0O3JgQYWyeWESLJ228+/st5MacyLUq2vL0wqXg5Cdo8x0pCL6AHYYBOSDySMPfbl6TrjGOkClVv+ghKThzeYCcm/oi9US9+r47lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771283670; c=relaxed/simple;
	bh=9oTkYAs1c0qUzQAMHw2B2HAH31jQ5uC/O7JR52a63vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cMLadeyncnPl0LzCGThb2HqbmoD7SSs1jB+BDfvPuVklt4TyGBcC3CIug9AMB8TYGouixsBW4HXQS0Q7rAUIfaHCOs6yBWxto1I8F+3/DSWUApIPedl5CXy4xXTg6T1TJt3lnAXl+TLYviRM++2dDcQToyFj9cz75umjVcRET6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s+yyu7ru; arc=fail smtp.client-ip=52.101.48.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ov8JyybdJVNj9QBdPkWu4dlN36uxe3E7ebryyNNid21u84i+v4tTHx0Vw/E4cMfOx5xVBfWwQ28iawqedQ5D6ynCiofE/SnuR2/r8qCaA6+GwB0XBg72fDNmRLZYmwH9AktS7jagGQQ86e839+OfNFjZZKYfCFOqHTz6h0X7AetoYJ47Vckc2X9s1PjLzdA8XMJRPNKbDP+5Da2wbYvpqr27Ris2tfynrW8L3KJYXWzyx6ReV3eHBaCuoAfygYspupwlY/UP6zHb0GgsutR82iL8twGEJY2rt0tYrSWQ598chWIwF63bQAIZhXh8Oe8IGZTIHNe444vz7vWFoIUm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0RlpovEGNtuiIdCh11FcORkr8ig3sq7l+oxKwiTu0U=;
 b=bLOHNR4JB3HlXXA/tccIOzf1HGspQwY/L1wofdc8g6uEPACLJd9uffaFSsqt/JDmoa0q/Zv6mIa60J6BW+A5tAhoOquio2p+HGEExv8FbaZt73lj+Px0zgb8pBPysszw7xZQj7B66cXkkeNO3rsMxI6enV4CLSDSqs1qbsNjrQ6pyQ6ZNyRKSbOHjtqxRmt0m102ZZLtiBxHj+4XzuS794+uWORPEzoZudy14GDsNUfLXycxudE4YCooHwEliSSc1/+RvABmqj3AYsapBPTbp+vXKJBDqy69HBGkd9vCAGxaLk/b9ZXfKSpW4/BlyEOcSJLulPSm7CxZvQyYCKo47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0RlpovEGNtuiIdCh11FcORkr8ig3sq7l+oxKwiTu0U=;
 b=s+yyu7ruKkby5lhz4kap4kFTASmgIEPxEiI8/rXDDMCy69d3WTpK1LwBP7oQ1YYBAYg0mdqakamOgF1n5ZA6qB6L1v9ejr1sfD6qUx1Ou9rosQjURBhiAdR1cWJAZOY8wwp2ohWPtZSRvnRaUf/rf9hjg5FJWvF0R3ZbCBGwdBRoeJQzaOWce0J4vOJcHhM7A+Z6jCNMoXtroE96n0T5VCds4ePNHTGU3fyVqcyjcXxbTLwAfK+wz9Py30Jj93mdi+pZNTgAw8on9Dm5VFkXVgrCjko/histgqld6BLNMBsdOvdXkXzMA5A7SPVEeUVMEOdRFb1AxEzp/TZYDrsuEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 23:14:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 23:14:26 +0000
Date: Mon, 16 Feb 2026 19:14:24 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 03/10] RDMA: Add ib_respond_udata()
Message-ID: <20260216231424.GA3804671@nvidia.com>
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <3-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <20260213101053.GJ12887@unreal>
 <20260213124359.GD1218606@nvidia.com>
 <20260213153739.GR12887@unreal>
 <20260213154813.GG1218606@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213154813.GG1218606@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0379.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 061d558e-3be6-4c7e-f3ec-08de6db1209f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EblVYnXsW3ClbGqAmTOzb88y737DrO/2wy90qzemjPFXib62XfajWAq6YHDk?=
 =?us-ascii?Q?3oKHm+4L1o0yd/Xri8LQSxQyZtb9gzL8wEXdeaAplvSSX5KGazCyuHMsBOIi?=
 =?us-ascii?Q?32CZGtar40fW12b1McgznI2pKvqV+dfqHkDVgtns4hjLjhgEDwL5e6kNrJMl?=
 =?us-ascii?Q?OZex0FlFyHPPMYPmrxZnckejBsDcRgoLmOVLnfHBdEgpFoqCeNGu4ZGQ6l2l?=
 =?us-ascii?Q?cIm4z3sxt/wDrTjgWYpRYfd+NHnKIiXkVhI6w1NtXl8LW+piY0WFENGrv6LF?=
 =?us-ascii?Q?ILs3NZ07RGYbeYsG8ELzuRxog9Hnp0YQPRFrE4D+ju1BniRNQZ+za52x+XYw?=
 =?us-ascii?Q?Mf2r0Fz9jMdnUM/x3mDBOV/Atx8TSU9SK4JA+bVm7g0t6FbQx72lluwWyjfa?=
 =?us-ascii?Q?63olRqxJVTuR8IbCAl/elWXlNSHKf9EDwEJclEgJeXA8gNUPghWyYz/M0mKd?=
 =?us-ascii?Q?xxUgkvZ4RdrV3KZE0Bx8U9zSipqq2dIzXoKw7TbuOdx2G0ieYOAXnlOGFG74?=
 =?us-ascii?Q?+DK5+/70HA3bsS5AhphMtUQXH8JZpLrOIKi8+atciI2qhfJ//R/Vxd5/IjTZ?=
 =?us-ascii?Q?DXl7RDeouVjkdPW4dtOs/gZN5yXeH5qvmkZjcaFCEVUdFso66bFjHs7gZhyf?=
 =?us-ascii?Q?WEI11cDzySPnvKojg2GGif8FKUYFGh8mUZHFiQkRXTYEyAWNrDCrQwGAeNcJ?=
 =?us-ascii?Q?FHildTy/4bmjw8WALl6+O8HPSMfknxcP4t8FJnQ1n8IEyydraZQ8XmSwTRWh?=
 =?us-ascii?Q?0lbhimy2NIcSJvNRhvGnJ6qbNyb+GFip4/iO8Tlomqpb8UKb82gDfhjH3zZi?=
 =?us-ascii?Q?vFQQMRl4WljG/SCUbJHtrvMq20f3VCsY+vOVItsVmlC3l2QHLtCnGazCWKCT?=
 =?us-ascii?Q?hZ6/bX4mqxzxrZoUrTQx2yMUs8ohlC5gx6C57OpBmvNXzJIzuk+Zp7gEndhe?=
 =?us-ascii?Q?6ogDxqGXSfQkOswunsf7idJzATd2vK30rxVKgcje60wCIaw3VNp7Uaoum4Zz?=
 =?us-ascii?Q?Lkfkwtvr2M435WI0FIqyTGyynf426E4i2YZn0+C46qKxujfwLTjzWjfBudA9?=
 =?us-ascii?Q?MmJq59wDV7oxfoYvCmFZy4VgeMYDVfWGn4d8PORsz7/Hq09FbK6o73tNyK2F?=
 =?us-ascii?Q?mGAkp8hWw3nZXPTJN6RBIY+mhls32M82t2KWcTF62/DM46SB+xhZgYZf0RGw?=
 =?us-ascii?Q?FuYMn/YOVYxRnzsrGo+/IsxUX3hBgGm1+JYaT8OTK6k7MtrJRAdWHdzFeQwB?=
 =?us-ascii?Q?ojxFE2RFlk+IhXhSwEvZHaDh18hLmLg4S/zSo3J/AvM6+OMp99xHch4zJ1SM?=
 =?us-ascii?Q?DbvcMApxQ+1scJZpY4o0z/IY100P7rYclk7599d4U5Y61ZJUWl9NV8tRHGXh?=
 =?us-ascii?Q?veuLpMZmkIu3jUKzNnNncvxao0rzchalcnKa1QgKsqAopdNOO5dNBQhFP7dD?=
 =?us-ascii?Q?hq8za6U3nOcKWjQRy1Rucx2S9aTo3s+UPEA3g7SfhheHva474FVrSnj+vY0C?=
 =?us-ascii?Q?zlmjGl8pPrr0TrOXvTyJ2f41Fysk7+cIwy/DhU9TxjqpR5HxUO7EAZwbuWg8?=
 =?us-ascii?Q?ouFYdFRF3HKIBQGSQsE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8TZGoMXhoC7khv5pEsZlKOe8PXJazgdntgFEVzC/wgiHNsj1BXhAQtD4y4F4?=
 =?us-ascii?Q?WYKKCzeqFSR7YDKU4Bn0MtidkldjwB39CzDZZLTQw+x2HDSpJpldrr8/nw8/?=
 =?us-ascii?Q?tNFY/hKDmM9u0v47UnDowsvgP08BeVlsZHialWrxsnNFqAhiHBwhi2xD7xSn?=
 =?us-ascii?Q?NeJ3GAHamqIc7f1Va5ypmPy1O73WgJlJkRv6LfWoD5eu4+mY7+7eeDQI6P8d?=
 =?us-ascii?Q?UuYdGHMDjF0ow/qcf0nt/Ky4GNYy+c6Fd1VPNc+bzLyE5OFEo75FnCRamcJ0?=
 =?us-ascii?Q?r1Ek3RyrC1JiOlv/281veFLovVcAB//uVn4xN0MjrWR707DXD/cyYYewMOrx?=
 =?us-ascii?Q?E35VZMwNiXprz0f0m2kgK7OC2RzHZudL/oofKMj7tGmw/JOizGUon2cMLFfp?=
 =?us-ascii?Q?ZOE2ek63i4Ax/95USXZtPBBJIfK+81LQD+7uhdBskXylY6b6JQ+dcQxdToo6?=
 =?us-ascii?Q?YaANtmCmMr2ppnZtUlxd4RFFHdfsyOn7yTSKvhADkswEn9XEp28CSU2BKf94?=
 =?us-ascii?Q?xGinzsyYcPS0v57Z6rUxZu5MtoxBZs4w+Ibw/zbG4r8waAa5DSQrc82m6of2?=
 =?us-ascii?Q?KHenLHVw/HPVinx4AeSI+MFew9gNXizZPAZn1wS3bE9cXfCbwLOCfIKP3nyE?=
 =?us-ascii?Q?HWVVAPx6tQVGSSf39T6H0lbBjwo6qxqzjKjDgp3vixADEIcEji9XSE9Qk6jX?=
 =?us-ascii?Q?VgxH3VVfwORCrBpATKVexPobFFZA+d/ON9S65tneXz8kC2sFg+yY3mvKcP/k?=
 =?us-ascii?Q?4ade6OpOzCo3yPAgW8ELNFLZHaf3l4n2UnfTrCphBgNfmEjPq7CFA71SCysF?=
 =?us-ascii?Q?zWtoGK5Ims+fdm/hCPTHxEGB8REE/ERgd/VXYoZppq+5pBfrB6zE9saT+pEi?=
 =?us-ascii?Q?hjIFG6yK1pB/TZyxRt85DUvBaNf4OIOz+IpuHZfUfm9tAl9XPCqr4LfvCwLa?=
 =?us-ascii?Q?qk8LewFsptYrnmPanjd/eYuZ+0viXoOj6FHakrDq5PxZybuezYf2WPccn5oO?=
 =?us-ascii?Q?EfszhicvaoCQWQKPkkAIkSkeQqVjBNt4iDD8mICZNNuGKVkFzEG46wQ9zRQl?=
 =?us-ascii?Q?CWox/o0RaGtQ5Zv9/13NjncA2CY5usENBaJ5VcV2BBKH1iG7GMjwIzo0vpi+?=
 =?us-ascii?Q?imFzKbdI/f+AO7Lq/I8X28tUdfN76yWqWidke+sHcOv8G1jF4yfCPdeXVoFe?=
 =?us-ascii?Q?zaJjAQRgBGSRSP/OS+oCSgvjK4cwbxWVggxIkwNY8xJXa1sIIXTDnOlap19s?=
 =?us-ascii?Q?4OSj/zj0C/EG4h9APoMxQY0amAyzBnkQBlc32jrOuB3oOL+Wq7+iZwM4tqG0?=
 =?us-ascii?Q?aT023FBr+nG7RQpWgqSRebV1cnXa5Q4g6RezXEYe5cuiS0xCEpmyGv5B155e?=
 =?us-ascii?Q?jCRtV9omOd8hMstJnGQ5J6cm/X+TBPKQjnv7ABCVgxUoSs3oMnA0ixPPCTBy?=
 =?us-ascii?Q?3qroDnAQnfqyYnAJMB75PuAqVDuX+0/J//+SDE04n11By2OlztwODr8Adbuj?=
 =?us-ascii?Q?+C0jAL/H36WqsbHOnwOYbM8ycTBLVptNb0OfzhENBp9GS4BsBAIRz9OyXTDa?=
 =?us-ascii?Q?L6QYCuBpRcpTK0w5nvzM+hl4tFqb+L0Qweqmq1SoU6GgP9+glGggNSWBp+jq?=
 =?us-ascii?Q?/B1sOOWlRXDnF85UqUyWEJuRC+mXzO2GJ1S27Qeg6qCsJ1gyMrgkQBVZj5hy?=
 =?us-ascii?Q?i/icGSdYztLOm+OBHRh1XPqMrIeM5d/u5Fy2h77IjZhlENP7WcqiGSLf+rSo?=
 =?us-ascii?Q?0dYZ8579SA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061d558e-3be6-4c7e-f3ec-08de6db1209f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 23:14:26.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBNG9U8pV0VF1uWy+1xKs/9cDU08LL3kRaQ8fL03LmIL+EBhegq0N7JgsOHv/eCL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16933-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: A0965148073
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 11:48:13AM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 13, 2026 at 05:37:39PM +0200, Leon Romanovsky wrote:
> > On Fri, Feb 13, 2026 at 08:43:59AM -0400, Jason Gunthorpe wrote:
> > > On Fri, Feb 13, 2026 at 12:10:53PM +0200, Leon Romanovsky wrote:
> > > > > @@ -3177,6 +3177,38 @@ static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
> > > > >  		ret;                                                          \
> > > > >  	})
> > > > >  
> > > > > +static inline int _ib_respond_udata(struct ib_udata *udata, const void *src,
> > > > > +				   size_t len)
> > > > > +{
> > > > > +	size_t copy_len;
> > > > > +
> > > > > +	copy_len = min(len, udata->outlen);
> > > > 
> > > > Don't you need to check that udata->outlen is larger than zero?
> > > 
> > > As far as I can tell 0 works fine with copy_to_user()
> > 
> > My main concern that it is not clear what return value will be in that
> > case.
> > 
> > +       copy_len = min(len, udata->outlen);
> > +       if (copy_to_user(udata->outbuf, src, copy_len))
> > +               return -EFAULT; <--- this?
> > +       if (copy_len < udata->outlen) {
> > ...
> > +       }
> > +       return 0; <- or this?
> 
> Oh, yeah, that's a really good point.

So it still returns 0, copy_to_user() returns the number of bytes left
to copy. See Documentation/kernel-hacking/hacking.rst

    Unlike :c:func:`put_user()` and :c:func:`get_user()`, they
    return the amount of uncopied data (ie. 0 still means success).

Number of bytes left to copy for a 0 length copy is still 0, not
EFAULT.

I'm just going to add a comment.

Jason

