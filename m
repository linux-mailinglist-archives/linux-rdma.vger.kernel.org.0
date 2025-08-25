Return-Path: <linux-rdma+bounces-12902-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F7B3447E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5986716502B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6648E2FAC1E;
	Mon, 25 Aug 2025 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PnfIjS/E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1D72FAC00
	for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132929; cv=fail; b=QgjuEM8MVFi/AE/3CfhSHbJ3WNWxFZyu5F/qpirQSsUWLq53jGJtC4oWJWySf+NmTQY6IuaQCjLW9anm1Xi8y9ysZlVoaL/uctI8RDvrTmcD9bjuLlzJneNM5jbULYVOz9yktRQtST4XrJ6FK02BZOz4jWikSZJSGf8DiCYoinU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132929; c=relaxed/simple;
	bh=d17lQsb0kzEhItwJ6s7wezom67j8QRce/ZRUxR+favA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cbqeSHDUzWXqFOPx9SPXYPlykKB9UMmO1SrS7nFgTz+ATIVcxCASCxFytadKSqyZnc09C11Pc9CfS4XVjzXu/XNgWsVKvBCf1JMp8wVVdzDEPuIOysXv0jWTYivEykjOOZxZJd/9By3ROYloupMeJCthtmSzbS5aN191w7STXEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PnfIjS/E; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/r/VA5R+5+mGu8Kh4Uw5LKnk4FgBK37L2KDDafQHtkUw0epOt1pFyptbiTjyTypB4mxbTL3Lde6BKrPLT4H4R4oZ7qEMeVGgqBHr6OQKFVlP3pGt6wtwWVHbuvtCxvP4k55SmYaDUJjUM+BEI47bJgw0HNQEzcKrMAV56SaQCEFxwTXlw2M1GQCubRNOVix3z1/nrWGGdUNp/bKxFzsHdDMxXXECpmEVcxiGgp0q1dDzwjFMZAc1oha277eDZu77oDuJgZKat8hGnd3l2hptgLerQajSGRMRWeRBJBbkBP7XlH8tYWWhrZTlwa/9bl2ki4v60ivAim+yJtfNuWgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvnWlC9/ZwDuwv89dK9ttlvAUdAFrhY+nLU5vbOuXr4=;
 b=jHvGdFHi4YjZoxd7TJKJ7dG3ISYq/JiC+qWy6lH2CK520/oAoCSqepwby5hNeaLT9flStO4xf7jQwuugukyN4lqk13YHyAfFPkke4wS3PXjzqrFQJuCP+6/jXC6xQsQvvaamMfQoDBwWingFrmSMlh9sSI70zeozndo9Vt3ka9cnNWxpVcGK0jzEBEQh5E2rQqM3MZrl0w74xLF4RO3rHekRycwIRZhzRV53leNfBiDTrQiH9XJhn+aHwTYLPfgE11/ow05E8fb9/2eDMcZcw9ECoW4XEbcOz/XO4SD4iDRmkKQOOHdhajwTY5kRG3kcuQwalab6vjt8uVw12bmSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvnWlC9/ZwDuwv89dK9ttlvAUdAFrhY+nLU5vbOuXr4=;
 b=PnfIjS/EY0oGtnGNyxu0vTfQLuPIPnCZ40V6tfqnZzye0fw4TR1MAHZJ+MfiCUZjB1MSF9it7RPG4XXYAL5TuSxbWdspkvMKZUvdSN4AM1yJ88MEmgtIgioucT9nLWKsAVHfu+UiKvlpj4jRXLjctHz4boWBIox+/a1TqQm6/ovm9Lcp1PVdhGn0AOz1SyFO4XpEN6oO9zXS/sIhii0dyxyG/imynZmmiu11eGeVT9cB2TQo75VO+pCsr/Wh1Esz7IwXDtbmMYmpwdwNrzxPiGU6/TZXuxQI7SCrXq6XrntMKvsl0I/evw3HJMmNBNK/6XXwg1KeYxjVKoIA+0z1uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 14:42:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 14:42:02 +0000
Date: Mon, 25 Aug 2025 11:42:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: leon@kernel.org, Dean Luick <dean.luick@cornelisnetworks.com>,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	Douglas Miller <doug.miller@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 10/23] RDMA/hfi2: Add in HW register access
 support
Message-ID: <20250825144200.GA2070157@nvidia.com>
References: <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
 <175129743814.1859400.4253022820082459886.stgit@awdrv-04.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175129743814.1859400.4253022820082459886.stgit@awdrv-04.cornelisnetworks.com>
X-ClientProxiedBy: YT2PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 162999f5-9022-40ba-eac8-08dde3e58d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NpmMs8TSN2QkxAW9ZTXes0pktglYB5A+Io+7ALtGWk0qoD3n2gjMLWxRCIIX?=
 =?us-ascii?Q?iwRWvOYN62gz4XI2UTCzbYYNizDW5H1nDGUBHuHEWUSLLZ1N2476cokihMal?=
 =?us-ascii?Q?DKJK7HvRMQx1etDjlop7xWBO9CCYCFp8Iw+4brxK7dZO1jKTbS0Td6v1UzCT?=
 =?us-ascii?Q?fnpUfeixyRudOQ/n9VtW9aX13bFRn9DWfF9uCzN/MuKM5S4+LufWuhv0gwao?=
 =?us-ascii?Q?N7ecFMxe7hw38sivJt+48LspI+8bv7hDRHJar2ZIjichJQk/pZPCOZXjlW6A?=
 =?us-ascii?Q?P6QmEUA40HEb7eYqrIJvYRul6SFQds7FmuG8qzFK3sdT2knTJneHXR+UK58p?=
 =?us-ascii?Q?cdZ64+5rQb+zt+5F8vDcib2wYFqhnoR9wlKjZ4xUcmIb0j8CRMsVw7p26PQC?=
 =?us-ascii?Q?yyfpFY3wXsoqctzop4WxBU2UmZp6wKSp6ySdsTEKmkPftAiGF9keT5Kzpiuz?=
 =?us-ascii?Q?mCK6i4BDcXSn4gmDvsVlhnmnPnmTcVkqdfinlpv/6CzTrMg/Zd9TWFyHGQwO?=
 =?us-ascii?Q?HGejTAF7bBVgQpC9wVt1vzYdW9+v2lEn3ZTWqPYRMdy9K9pB0OhAFJFYYdx5?=
 =?us-ascii?Q?iTb0zdRERQwfINkU4MTD1bfEMGRrKdy3bIAnostAq8jOQnIp1ADoqQdPWsqk?=
 =?us-ascii?Q?pIB/Q7ZtkD6m0nc7oQE/ea76x4fYtb7ZoKDs9mF2XPryj3H1dmir+gWDnvsX?=
 =?us-ascii?Q?m2xxT23RL5VUjVsZge0AGuPw2W6DPowchRkRw5zV5FASfMFUMC2yJeo99+Zp?=
 =?us-ascii?Q?4xJhUYvtktopEih+5UncPuwj0WDxpimCL0ZxCuK0Jg+aIkQk9A/MF2qSvXX1?=
 =?us-ascii?Q?ibCnbnbHGurDR2l/z8l7nGi9+QTILJntw15BbYikHFlQRioBfgYDT3I0/pHE?=
 =?us-ascii?Q?t/uIW0bxzCimg21H7V6QdieyFNBaMQGEHO9Ahrh0WtwgETAm52HsilKEgeA3?=
 =?us-ascii?Q?F/An43l+3MmVxZTPZl00nezJ76Lo+/R38O8q0KyICuRvmmbHqm7LDhZjKM/4?=
 =?us-ascii?Q?jK6yVsKIaLPVvDD9WeRdJUhVWlFwgVl2xQ51VxY8RJvHw64DoC6IzWLVqupU?=
 =?us-ascii?Q?6HZPFZ0H1chOi4FEvVABNOmC/xffR+6YgK1f40DyMN33gL8cPS25Wg5zACsc?=
 =?us-ascii?Q?3eGBMJLlsWmrWUywOAAWg2nmdNhxfV/HT9+dP4Uy/IRBBUybX0wc/wNKyW25?=
 =?us-ascii?Q?9rOMQpOqJnJ1hqXjlt1l4Y+4dpYxJ70yAdWLHB9RNHEYJ12ZVgL+Z9f//ggJ?=
 =?us-ascii?Q?hL4430THP/28mx9BVPrpXfoGXh+ygCLHZEn3JOgVBRc4O3qI+9mPbZVewab9?=
 =?us-ascii?Q?mWC2jCU9MtT+31sE3TE03EpAEsqPv0ZcAXcx7rT/Twaes1aTy/YCPKVuReyK?=
 =?us-ascii?Q?jITbtOoVjWMg3Huzzl5DZbzA54qswgO5An3mxoEJM1Mhsa/qpL61TgBPs++k?=
 =?us-ascii?Q?c8hlAFaJ1to=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yG7xPu9jqgK/Y2GZKp4SgrpjkWUuu46uw9aMSn7nzL0cqqDi+biMu4PsSihv?=
 =?us-ascii?Q?/LoHxErkGxNL7vQIKzquhuXVOJ+E8I3Y3y5VQnM5K8QfxjFEiL7d7Oy3M3go?=
 =?us-ascii?Q?CzogUJtduXw2HHRgVyCTIHoDuh7KqDXxPgLroZZcpyFo2A+CopRqtiM2bh+m?=
 =?us-ascii?Q?0vCH5djWPT0Xim+bYbS2l9VNKfje2MEyoGn/8K28ViyQ/Vs5tjS+JUiWM1RK?=
 =?us-ascii?Q?jDFU6ltEVZoRHpEGfb60mec2ZCnH5/eVHidN9sHmVjd5ZvnYihQ+Eqd+AxZt?=
 =?us-ascii?Q?RoLWPdntZ91z53KpkbmNwCzEuBUYBs9yn1J8qlesN9O/1qnPfUPjs8sQmJDC?=
 =?us-ascii?Q?XCvC+fRE5VtnjrxlE0yG47e/DUDKenBNP+GarNJFvVLaVTAGxc8gE7/SX1CK?=
 =?us-ascii?Q?tE5+zLHWFHs60uIsxhTDVt/3YfnSfmAytSvy3/Gb0oypvva/LhueD4kqqKV2?=
 =?us-ascii?Q?y1UAGip3XIPAzMMbpIKWsZOyBf0Utoc2lBN+vvG/Nf6tA43sxk1Mk5ENBnZo?=
 =?us-ascii?Q?/OdtovADf1VfFV+Ek+ZNa8NmXH78fAfK97Rb3pVA7kPAi+9lRocCEqDh4P1o?=
 =?us-ascii?Q?J3g1FAAnpZdhlPO8g55C7d+uPXORYjmJYosLaWXh82rk/wjnEb6X3XJABnsL?=
 =?us-ascii?Q?ZI2/cdmLeogXB6IadqpR6l5SvhRjKOqC6b70MvK5fnhIX6ATTV7c25UWOlQg?=
 =?us-ascii?Q?ocPZ7enpzqqUJp/DUb00D/s0Qjul95ypjsLiV+4Ju3DIHZuPSDigXXf8EAyd?=
 =?us-ascii?Q?d44+e1QE+Pv6K6q+erzirY8nVMO1bnz7Oe13vwT81+V7WcldSdwWLOfj6SQH?=
 =?us-ascii?Q?9/FlKAbwPVEVWeUP/47rWmm3wgK3bmPXWHkyHXPCTc1mOAZFiuQVkUoooTv1?=
 =?us-ascii?Q?oGG7tzL6n1hJBNyYIinBlVFMWm+bDj2zT9IBzoBrpsfyObbvKzMseEIcgJT2?=
 =?us-ascii?Q?IckAJbCU9BbsWbHjwFNkyDYA68f8HG0WcnnprldvFF6ftCwlB8MpOZv1/cR9?=
 =?us-ascii?Q?PoTc9vsh9Vg/7+wsiddbAb2daSP12PqroxCnJ+ND9cUpOYtKtaV2348IT64W?=
 =?us-ascii?Q?ltpfWR80cnk8I3pgH80vzCgohyZNbeYSJK3Zf8UlIxpqTwfRtEvv9/jTM3RO?=
 =?us-ascii?Q?SkCO3ptNqGldQ+hUA9E9GmbbiiZiQXuWAVdSiqb9YwCOavhnouFaOsuq+wMW?=
 =?us-ascii?Q?NPsYmhygfQj2S/CLuryRLz9bynCU7+PBmK+9dFQ9PtLmbsm0rj9E3Sk5VLgI?=
 =?us-ascii?Q?fASUKPr9ecvawRvwAC5lA59E0vMVND4TddAGfN2HxgsRCzE5b12fzOXELohI?=
 =?us-ascii?Q?TZp+blF5Kn2bIAO3pGrbIFFQInEyHz3vPLQiBxRBO92N+HYcE7E9vRKCaSGJ?=
 =?us-ascii?Q?5u/DxuZO79YGqeSpKEGTWjkbvub9IpnT3Hi8KvVFDEAZy8Qw5DBFMSnqfel/?=
 =?us-ascii?Q?dTi+JK8/SnJhdvzTHl8bmm/4SmiK2Hp7HadHroprnh60wsRAGtmrvwhurIrv?=
 =?us-ascii?Q?dYuhmE5qYiu8y+EujYZswfb9aH8+2h8avuyuPlvQ0y7wB0f8m2IOPCy8uGIw?=
 =?us-ascii?Q?hfs+RwNMsnUAMdpKHEU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162999f5-9022-40ba-eac8-08dde3e58d82
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:42:02.0160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQjlSX3Cr0cGu73cFgcscehQuT5Zt0Vh36dKLFbFu6S+byTAj3Q/+QKy4fjBDQGx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407

On Mon, Jun 30, 2025 at 11:30:38AM -0400, Dennis Dalessandro wrote:

> +void jkr_handle_link_bounce(struct work_struct *work)
> +{
> +	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
> +							link_bounce_work);
> +	struct hfi2_devdata *dd = ppd->dd;
> +
> +	dd_dev_warn(dd, "%s: TODO for JKR\n", __func__);
> +}

I noticed a couple of these TODOs, they should all be cleaned up

Jason

