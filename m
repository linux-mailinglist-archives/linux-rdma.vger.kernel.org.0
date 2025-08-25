Return-Path: <linux-rdma+bounces-12909-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B01AB349AD
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 20:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F7D17F133
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD4F306D35;
	Mon, 25 Aug 2025 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LjrSUUiq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12E2C325C
	for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145042; cv=fail; b=d7ypl3WE8+1PwZBdfETco3aXcrzP/H1wI4eN6UE4vEo4q+4gF4KGODvpOn6ZD5pmBhCCI3U9D9ArnhIWhFIHTKlv2i+KLgjAGlOEMTgdILdzu+fIZUdd8cDexVkeY8SBcktWFcEixRioz0cFcOu95trh+0PeKD29lWCR6IYQboY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145042; c=relaxed/simple;
	bh=uOUfidNBfd2a2btwUeRch34hWzI18WY7lc/pgnFgUwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TBEfMyZVVyGN+zn+EdMS3qYWa+UydD5tsuuUkU33DTN7swrCgsKjcLMbG3DSo6X4V/9aE3IyeiWel370y8/PhV7Go+YUr0OsnHTWlRRHbRfD/ZnBShH400HOPCRq57pvOWhXu4JRFOZ5tfY2K1eMnyAQgCG/EzVoPmNIS56KRVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LjrSUUiq; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7KIghdTmcXk/QRgdtBKwlGOFcuUSojphDOAfFJwPwOccyXjlcPr/KP6Vj3JMDRx2XmKS/Tpta3foTZXkkSARZ8KxKADqFmQP4OkkkwveHny+bpS7LKc81OrDJ5chQDGijWpnSL6s4phVdNofXlMlF++yUjsKZtlcfGn9eYPEGRCzUut2rN0GUAcRqRg2xER3A8BKZFliawOFOpbBvGPyuAsxa3SOEOnHY36/KjwE+HjwT8UKVnsDfyUncKohCVWcW2SMR8eSWaf2UM4VWxvOeEf6WMKyKcEWSP4lqBdbf/qgzbG+D2nKGa/miAK+Qcl7nS94AU8yUYNjiu8MwRvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tGXXkUereRPdUW/9ufzm1IOYwyHU/pmuEz1DzCpYfY=;
 b=kKzT4kjT59BpSnl4XLv8Z8Z/TMWKu6ZFnm7qXfDjKZF3gcnRSGyWemGho0KJLi6ethAx2CfCl7v6kgmBTid3Fvlig/TASeqlcgnIMf26p7JEoAGquf67FwqkC6j0S9clZL3n8Amy2w78FiF6u6Cz3mIWGuumWxexQHwX2CpF53jX5USPtRteJV2QBaX8dzCJYFA5hQgWlQ9eGj1yFOgQzzBiuxcrcEU7rliDV10aQT+u3dTWv2JP8oTL+kwA/W9V91w5yWvN6i6aDP9+l9RIrlk/P1/f37u5ChrCblnbXqjcelJ4cBiIHdIGwcfnjSF3giUj/g4BA/FVm2E0kzlUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tGXXkUereRPdUW/9ufzm1IOYwyHU/pmuEz1DzCpYfY=;
 b=LjrSUUiqE2a59ZOssabNelgpbp0jzcZAAqQ49xsNfwdtdD5a7YqJw7bLqRYt7PvOqzkC8AfwxvBS8FsbSfsnyRI8pW2Cc/dcOMESsK9SxD/TgNlErvnvgKm8q0WOvn9d3wQ+daIvcL6yA3whyDxqdHfLoOL5rFAHm65LfEHLWjgeAGIhShfGKzirQMNI8KqxlEc248rFTxikykN7UPQLQVKbd0cYAKGUH1LymSWNwKwwtdF6aYbMcL8hzN3nrq6IiISXR6Hpa53u2+H7EuFJFkSYpaKUPmNjkdul7n8uMIKkDj8p6HbWKwjOs4+JjitIK1kIAeZD9b7wKKhdSdwufQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 18:03:58 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 18:03:58 +0000
Date: Mon, 25 Aug 2025 15:03:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, Gal Shalom <galshalom@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Enable Data-Direct with Relaxed
 Ordering
Message-ID: <20250825180357.GA2083903@nvidia.com>
References: <1221dcdda8061ba5f6bc3519044083c7438b257e.1755088503.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1221dcdda8061ba5f6bc3519044083c7438b257e.1755088503.git.leon@kernel.org>
X-ClientProxiedBy: YT3PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH8PR12MB9766:EE_
X-MS-Office365-Filtering-Correlation-Id: 93faebc9-4147-4f11-bcff-08dde401c381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BTo+WcN/aGiuwc494HjWG+hIpEpWpWQMRotbp5i8jP4Yh29jNiDbqHnLLOy7?=
 =?us-ascii?Q?zY/sCLRUl/LD7kLwOfwPGHkB+RCLTe1hrqnPoOLhATKwCOaAGbjh6Xx/iYIu?=
 =?us-ascii?Q?UXne3mEniSAdroaU51Cjm3IIvHOXMuXsYN+zW6oOPJN51tzXAL0cPvCgRkhM?=
 =?us-ascii?Q?x1jdWc749cIihct8lJrq+RfQsLLZhpkVpkVCt/Qosbnt9So6IotP8CG7e/9q?=
 =?us-ascii?Q?PCyHaFvnjG5byaRwb6pOK2VDdooOKZaFUAG2Uo1+IfzrdFdIfilWzuUjHa1n?=
 =?us-ascii?Q?8PvPc53WacoFLFcPNHS8r+sY5bXZ8LHx63HL8eJFaugb291pUAWuR1WKDio4?=
 =?us-ascii?Q?2EMudjySQQQQk2IZP1N/I3yPRBLG2eU56yJlD93SthJPw9YgTkMwsh0EmWCZ?=
 =?us-ascii?Q?WNxoihPApqevii4j5a60pTaI9utPAKCo3q0tWk+wp+MyPIaJiWpWnKkSK7E3?=
 =?us-ascii?Q?VPi+5ylbmJ8GpKnakegYfBBSmsZRV1Xj9OsxcN2g00s4ZShaYyKK85nL79Ds?=
 =?us-ascii?Q?cIs2dHtYAgV8BmqEDXpSy/kC2LMvQUFRP0572zhnogWI+d7IZQr4aUthDaZR?=
 =?us-ascii?Q?5nA0Ud8arqlpVRa0NWtO6+vlngVq7K10p+Id9iriKU9iL8RiADPOhKETZor/?=
 =?us-ascii?Q?eY52wylHb/0ZIDNQwzEATgiWPG4r/ZJ4fcItqBhlMmBMFZNN22Ow1lxpe6Bb?=
 =?us-ascii?Q?74vUmDDGkt05WGv6m1nu5LadeM+lXyHrY1Kt9W7ugI6ZZs5aozvyNCuX8TLD?=
 =?us-ascii?Q?fzQiEwqu/Z1blOKWyjeNKqNJJ088L/PGQWYswhKJoJCS1YuA7515Aph7WUOL?=
 =?us-ascii?Q?5W9bKr6WMWkJ+hoZNti311K61hFqzq3hQRrjNrLB78in0hAdeAUx+8+RgAFp?=
 =?us-ascii?Q?WGLfoqdp35izZKoUSG4XcyGxZ2XK31NqHpxnuust2cuKwcfHaiZou2I9svrp?=
 =?us-ascii?Q?9c0CufACA+Dp/FudDEVcCsX1sBqtWUXhpRl5TX+4PxLYpJZ8jhIbvT2+MQxi?=
 =?us-ascii?Q?GNwj91QG12A+X8SrkwGYnDViwX4ov/qA/Lbq8L77y7+RaQ77PZE0JAWJOYep?=
 =?us-ascii?Q?syawrEcjlNPu87FaX+ttISJtFZ2yEb0sNPHqcmy0FOmfgtLmlr+pDy/+rmWe?=
 =?us-ascii?Q?/IO5E9wtkVJEGlwsqsqZgceZ6VXk3/XlQD8hfe2ScF/TWcGAkoGRnl8ZbhUb?=
 =?us-ascii?Q?FoeDwJGtRrcbyAL1ae9HWyQ4HJ3lxW6Jad2F4qDLf6VWj+W8irwpN6mAOHsV?=
 =?us-ascii?Q?31dsSUJ7LdEx1p0qhfSbf4JkbZpQrZtCpaHGtAZvkDfXi4k96zx6qFaDr5d8?=
 =?us-ascii?Q?PDrG2pJ5fCTMN0iSmt/F/DQkikcc45SyW7iYOeUZD4dZPQaEkUvsTu+j7QnI?=
 =?us-ascii?Q?xM1VI2l9hUEMig7qKeMu1xjBQTN+GQIQFTgWYjiawBM+2ngBptytzIEsDJIK?=
 =?us-ascii?Q?o1D1lBOXDIQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v5JQcMUffgWXc2he2NYVyWjKaxl/9kokDjncV7YX76tUUAsolmlhBdEJ/m3w?=
 =?us-ascii?Q?Vq93ZNidD77xXdOBeZPiYi+40uCGPWqEYuLdxGgb3+ZGP9slKf+rbhEI2Znl?=
 =?us-ascii?Q?dbO7CzoUAjCkVyBIVClBYju7kp4bp9LONORP0aLNpeYmIft9s7d3nL4Bv6/X?=
 =?us-ascii?Q?4s6I0qC3MWvrDzw+FTbHAdCw6iCJMdd/4Hv0KcTxMEv0c3ltH+UbWD8OAk0n?=
 =?us-ascii?Q?PbegoCqpKOYvHBrHjZanzvlSafqtZ9E6htii6lGvOjmPgBSNqzIG7vDTWTya?=
 =?us-ascii?Q?EPEdDb67hq0utB90Q4J/XjtTz56v34e/RBDf6z8rVVco+DGHH7l2PfUyCPDY?=
 =?us-ascii?Q?SG/d0YunUVjL4xWT+3bT7M6p6tSZtW0ZzM8RdqpO/RypSEIrbz8M6FlfN6ln?=
 =?us-ascii?Q?/2YDXv+rIagRJPCm8le3C31/++gBrDsS2row6saDPhNopPfm4zd1ZpPh1qL5?=
 =?us-ascii?Q?LpKkz1PY1Ux/yvlbYyYbFWqv218GH/2ZdadUP7m4BaOHwRcPMVEf6Lz5xqrI?=
 =?us-ascii?Q?zlW3/yHCRKnE+9ywDK+ALS9ZQuF6vz5VOWJfyyB+h4kMC9W7e9r1vnikS1V1?=
 =?us-ascii?Q?xQmOPX3UEKHx58jMq31eouD38BzplUUqnEwA7FNyoVVECgDtoBFw6H77qsGc?=
 =?us-ascii?Q?XdCgQEpxCQQule6gS4HEb6jNqAcXL1QHWl8q8fUZzXcokje+qAaHPz6dawwr?=
 =?us-ascii?Q?LlKmNH7+xddCHHNDYlrbVbQddpZlGJghV6nTvEZ0H10VE8RLm9BhabPhrjsd?=
 =?us-ascii?Q?gA/nxxuRW9lB/mXBysBeKBn3j+M9i9yzAE4Qxzz9qPsSMLPriqRw+jPfS2rJ?=
 =?us-ascii?Q?nT+V66Bzl+cdEIP7b2g6AP1A+f+3sgyvEk74pTs7vyQxaTibfFCWdGtscCy+?=
 =?us-ascii?Q?F34RBSKJvix9FKlKrirBxzCZQfHIlVK2PVoabT4lBW5fiO4HpIfv/VzqhOrb?=
 =?us-ascii?Q?xzTjb2icxoaGP7uqZscL6crV0teM3CDIuVVXq6s4y/Hes3PSJapVrTnIUhb8?=
 =?us-ascii?Q?u1bfc9PPTH5dpa5hdqeNeGOm3yBdsLEHVATqiccfEOoZ1ThUkFKO515PcxFL?=
 =?us-ascii?Q?6RTZkpuSPD/KbWTQd1TO7YXETZYIK9wLwB10MGlfI5zUmpHHeLmL3pKunV8B?=
 =?us-ascii?Q?WKeA61xa+dEVG7gSLbyts/GMYo+CoEiqIuabT5hSKeepFfI8r72BojsuMnzS?=
 =?us-ascii?Q?NxptETVXojL8Z4OxldlGSotBPLaI6Xe/2BTtVA/mMcNY+a4KPblDrnjC6Lhi?=
 =?us-ascii?Q?RBmyUo+8B39Undk+e4frOpdOFuoIobRQhP+OAgzkowibj8LN6xkui+6un2iN?=
 =?us-ascii?Q?gD2ygaFfO08q3ZqJ+VytcvTu8SBLJhgh+Lh+mx8otCnAp0FV4fHlN76ckdTl?=
 =?us-ascii?Q?XAwNIIB7KtudUEK71DoH7LGag8eB3ymA8adWf9xVsLf+RizmAN7uMUgkcZE3?=
 =?us-ascii?Q?72pjCzVbSzuRRwPlpqUc2HNCRnoiQ1DT7DeEyAtqusQ1tugUkiqqq0fFVXa5?=
 =?us-ascii?Q?1eQKwJa3LXk+qYArae/m0OT/q4ruc2e/QB3vUu2g9iHHbr1KMUWsuv/GfpAa?=
 =?us-ascii?Q?HS7zGOq+RD+wM3M8og0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93faebc9-4147-4f11-bcff-08dde401c381
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:03:58.5175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQ3M6vu7826F6SS/i7rN35i1LpNxVMsSR7jj2UfdEbs0rrBdAnZLuvGLYy1bgwCq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9766

On Wed, Aug 13, 2025 at 03:36:01PM +0300, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@nvidia.com>
> 
> Relaxed Ordering can improve performance in certain scenarios.
> 
> Enable it in the Data-Direct use case as well.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Reviewed-by: Gal Shalom <galshalom@Nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c    | 32 ++++++++++++++++++++++++++--
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 ++
>  drivers/infiniband/hw/mlx5/mr.c      |  8 +++----
>  drivers/infiniband/hw/mlx5/umr.c     |  6 +++++-
>  4 files changed, 41 insertions(+), 7 deletions(-)

Applied to for-next, thanks

Jason

