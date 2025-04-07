Return-Path: <linux-rdma+bounces-9220-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED426A7EC71
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 21:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912F044823A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 19:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82772641E6;
	Mon,  7 Apr 2025 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MAribrK6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BF12641DA
	for <linux-rdma@vger.kernel.org>; Mon,  7 Apr 2025 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051296; cv=fail; b=bLLExzVgzBaM+8myzOPs4Z8/sMQHYmSTuY7/7JydYW/pyYFAX2BD/G1IiczqVHe7jO7EQHZY6gmS2YuBhhDJIEdVUx4QDEcXSu6zlWA9/OoUswtvUVG8Ga3IIy1Q3JRKVa1gvsTioU0xZR1dKFzyJomCeDPe9vJ3Moa9YDJdukY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051296; c=relaxed/simple;
	bh=Gq+4f+CzW5yejbSgTtl5qhkhC4zB8CNWa9zexJAmdGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nYQ4mPdfnP2VuD888h/7M746YM4Bek3wal5BkHb/tAWkb/A6yV+bnQ1FIN90IxROjH4Sr24ykaLqYbK/BhhxjVGzF/qz1TNePSGmid00aP2Usb5+kySBrqMRb231yjL/GC8T4mHvsV+Y6vVd0GsR4W/MZzR72SDupVs4lhDFkq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MAribrK6; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIyH/WUlZA7ewKlV5uR9kIgCWOcJqXFHaNKTwu+BDTEshM65RuAxATbB7CqlQsbHqBSeeoCxP6UHhYICeekvldpruzxJST971xKgPfbm8PIaOKdnHSMAYSdaEXPJktx/bxie0HjImTc7fuaYWqSCr7CiTgb3qI//iPxc7kZ0h+DucQLdvwbnb1nGY2MHxE9krL6e+PkfUD+kJPw+jDHK6TtvZY9Npf3HLJ8WEoyE4iRQn3nBaPhdPULexPiLmPYXkav8/fpQsJttvvdHdMGYRKOMHz6BwHUxGr0I1ZcaXDKQNeBV7RYYph7PR6kXFJKQIAEk96eT7CNdgEM/so7gtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqyE3T7mmPc93kooqN22xZfv1tYfIpZNvN+9W/hRiiQ=;
 b=GNNMS4bmTacYiMEFePxR5XhMXycxysXirvjWjYClGdSAnZkZMSA5eC6HEZ2XYnNmmoa4F30WzThQth1t6w/wGmvRa+uJiEl+9FuaXj1rgwQAQlpDrZsG1m9cYaVCjitnXduIWcJKX0Q34L8qYNcnfs4+ui089tj0lSOg2fm+bVsS5h1iaLadKISoZtFTWCtYm7zGAY0lXwy1zftqcKYX5BByCn32iAdOAKlyeauB4QE271LCb39+PCYVy/ZmnNCnfsdGBkl6ZkelJgODkRdUxt+xFVhlQKoJV67Xe9KUbAAxqc9dJYH09h8MXxxiMU3DWNEAbucyAcc+kbcC2TtvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqyE3T7mmPc93kooqN22xZfv1tYfIpZNvN+9W/hRiiQ=;
 b=MAribrK6VE8HTGXgu67ySZLfuicsf/77rdCvILHbLNM7zgJ0kc5/Znj9oA66fgfxyGg8afTyZx75GKgqKgotQFiZVeNVzgMMFEw5u7CTsBi0MjB91yqGE0jfCSXDPgfURZt1watAsXDOqW9qrZq/pZ+w94b4U0aeJNHFqZrMshD4Mj+vARTsReg74KghjQGptjBW9uVq6+f0605PWRGj1fVqTweWd8Wq2v6ZPhkM1w4oqdxrPIAH0FO5uUwju5X+6DHufRnPQH2MFADtT6MCoAizRRR+DSFdO0pOvxHvg+tLJpBc2NT9cJBIXwtyLp8r7WIYXjPx2cJmDNA8rrL7BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Mon, 7 Apr
 2025 18:41:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 18:41:31 +0000
Date: Mon, 7 Apr 2025 15:41:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Moroni <jmoroni@google.com>
Cc: leon@kernel.org, markzhang@nvidia.com, linux-rdma@vger.kernel.org,
	edumazet@google.com
Subject: Re: [PATCH] IB/cm: use rwlock for MAD agent lock
Message-ID: <20250407184129.GA1778295@nvidia.com>
References: <20250220175612.2763122-1-jmoroni@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220175612.2763122-1-jmoroni@google.com>
X-ClientProxiedBy: MN2PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:208:120::42) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa58a06-5e30-417f-5d9a-08dd7603d0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gz82rn8P8IEYPDzDgHWXuBHKa5XKygtCU+odKNHXVfqv+5HbjZXINANIjQq+?=
 =?us-ascii?Q?U6aBOEEsJIY/UtRVLfAfHRMmSH0eLWSapekw/kqLfXr8lXumrjnuH2j7KLSA?=
 =?us-ascii?Q?FhuJqMrBPDLup8f8uo6dzlAzpHkUHWfXehkB44eA8z7n3QXvCSVdNYWD1/N4?=
 =?us-ascii?Q?16PsE7tHQbk3QhTm60W3pzHnPxIgqJeKfspqRIREh6Z1DXhqjeG1GcQifdIu?=
 =?us-ascii?Q?CiRpfBFn6DyfQ/galXwuLMp+SH/yREZtSRev12qNfckyzX0mLJrJj2DW47Nh?=
 =?us-ascii?Q?9i703gA/Npx8KtiAQNNFcyS/pEE2GupE/P74aufd95cErJlsuXo0QEX4xf1Q?=
 =?us-ascii?Q?T2sgZqUQ0vnYml//Ht2S43zmlTCLFkcy8GGRz4wemADUc4FueQG/FljeOlO+?=
 =?us-ascii?Q?qvmc+d+wV83lcpiuHrMJT0twQh+K0NW3oTKTHnT7r7d2GLfcwTXqTwR+JFqe?=
 =?us-ascii?Q?2Mkhonw/njPSXuBMpbLwv5HLB2bvLqJ2gCZJpFYdAGLz/CXFW4DrjFGk/78j?=
 =?us-ascii?Q?5tN8Tm/ds2QlYKCjPEtlglj+KkOIh5XZig2mXljrLAEwgqQdPZImPuA2ssyq?=
 =?us-ascii?Q?Gx3dMnSa7mD7bjN1nYGFxxuk5xZa+iou4YlE671iFCqo2UAjdds1+j5mco9M?=
 =?us-ascii?Q?+nrUhSRP9WALQqahG22Ul0x3XouKHjS2//SuOten+Nxwi77ev7EVdsYXl4lD?=
 =?us-ascii?Q?0bmpWwD9sW0wLYklrWLkDb1BjwFJHNyBjBAstny3x0pVlpNZLf0xD8yY+uks?=
 =?us-ascii?Q?DUBwSSHM9tMhtsWyBFbPcgAIWx4rpU6oSn1tc2ZTEqhjnvSayY6bPUpGHPiD?=
 =?us-ascii?Q?GJ3pz3LgIBOhT7Eq3ZCjZ9lGgO9KKQgJQXphN8J0z62/eidhUIfMSFgHiwyj?=
 =?us-ascii?Q?6bvrWjqPEgxGpk6OU2JPHnJWhI74oXdpZtRWJzTobB5e7p5ym0da4TfwVJtA?=
 =?us-ascii?Q?NsfWmIFgciJeF9LI2wrSg7RPSh6sHABJQbMiQng8CAy0dXiVkvyJ/4VLdQJ7?=
 =?us-ascii?Q?IRf6gmc3xdw/IkEeGRKhXGcYR0ywI/36mRGWFPAO9wnmU3gcQOSa1YnoDiyl?=
 =?us-ascii?Q?abcgSCYBzRyZoJI24j9o9dNhI51AQKAgu/bL4PXGuT8kMU2NrgK7USicsHko?=
 =?us-ascii?Q?PEVOAaxU2xksshcqndC1GtOW9p8vFWl+vEx2AMyeAZKYLDrBzvNXrnwHUA09?=
 =?us-ascii?Q?AdhUy16jVhpfz9EQeeRjTIFKD3xNlYMTQK93Xnss9eDHQTl05TbEjvM1hCUq?=
 =?us-ascii?Q?E3AgRCTvPpVJLhSwB1TCihihbFNGVsX/z99rSyLtaTmfpyKasKWxLV/PyjGV?=
 =?us-ascii?Q?TqetwKjZSdm0OZoHdjG91It2Zp6j1QeYS2lMmjZgugSZqmGVeLn9C7kaI9jd?=
 =?us-ascii?Q?I4Zc7qftei6fmjXg7uLAxr0XeTSx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TXq4CI3HH7gYrSA4edNLDBtsgws+csQj1cjra1jwOc81sPITFmrngSsFmijI?=
 =?us-ascii?Q?RNaspECHjNmNqZttbZu7mZU/obcKMax7Of/HvQk8EihptmhkIL+BVqWoJJpY?=
 =?us-ascii?Q?y7IWOuYUmOREIakujXTYKwlyB1LzzoNVoK657NqLthBbm10ZlAhCRzqVpCe9?=
 =?us-ascii?Q?JWTDf/9Msj5Uqi6aC/yt6H9Xvh1LR2+VK5SAdfExU3sqasq5OCzLsUcjvtRh?=
 =?us-ascii?Q?7qe2rgcxUi+406duIh0mf5S7d4cjfCnknxAT2oqo0xJfaPfamMPzwAOg3YkE?=
 =?us-ascii?Q?1q+y2N6ca3hpHWuqjHXAho57Uw48AJomi/w1jwU4kvKNcGhFiF+4O9q+i3LX?=
 =?us-ascii?Q?roaFGOBnraGJ2m/A8VGKl5Y01LtCru6xO5iaKgpYjMsxms5emtysHyVwxRy4?=
 =?us-ascii?Q?G6orBkzzEvg2D5TUrcM4GRPIFB+rGnTMcOTpGt94wg50/mnVoYOAacKVZ9Ul?=
 =?us-ascii?Q?A6QkEG4g+Z48lIcx1JlN/T2klVB/vnX4vxmdFUbTt3m9S/bUYvBv93ZNPgKx?=
 =?us-ascii?Q?lWxFinGhb0MB1foVHid0AnmDg2mO5dftPp05fkmwshoCEmecRuIecrrt6LrB?=
 =?us-ascii?Q?W8Ts6uYMe1XPMUzEvhxeIkGabUh/H0PTBOcvGpGVFmyHbNXiI8lDvtq3L4bC?=
 =?us-ascii?Q?HvKyjd2ru7HstuLFjHgul0kI0jzod6rzIPW1CHUnKgaq3mOfFrKf8sfCASO1?=
 =?us-ascii?Q?kN1tXAzKv/X68qOEbcKKUFfwPRS2VATnwAy/4KJpJ3Jz/GGHLeQH91ED30Gf?=
 =?us-ascii?Q?GwCxx0h7Asxefj+Gw6QfasHBUMSwlYcjd9yu4WMzEgRoafgs15Hz4QC9hRPV?=
 =?us-ascii?Q?kT0jKtWsi1Bwo41Ba8sXyZ8p2JY0Zaea+c6aTRK+xPLdQELU+P0QVxRlTCTt?=
 =?us-ascii?Q?lvew2xUZ/j+96EYE9SYYNFsBBq3KkuQQMZS7WFUdK50pS/fhtkB3ANlyv8a2?=
 =?us-ascii?Q?Bx1JsPX2GVXaVjs1bM6lPEuZaUa9k/lJHMqzMh0R1dnTgGWlg4yLaf9rb0zY?=
 =?us-ascii?Q?K8dWPKXs2MmSKnocfO1sV5mRfL0sxD0hFznsS4VFK67js1bAfK3QleoSkIfb?=
 =?us-ascii?Q?MbLfHiqEMG0awGFw8Zw92T/2nhaHZ7gTfAvwNjlHBxBQ7QBrIJJtjkJH9sNj?=
 =?us-ascii?Q?aNYki5rlTZEeSo++8WFYno/OkSwZWtHKdCyV2biTa0sUapU26Q5CAEfFpMSN?=
 =?us-ascii?Q?z8ZS7odxXQaD5kKHedGGJ70eTQWiESPA66mR90zZ/VxgYyJkxkzBJYAFgOII?=
 =?us-ascii?Q?DBouIACaqZWyYJB3yKmoL0qjJ8mi/vKBmonQtg8WMjNWZBEH9GqHHhPkqSQz?=
 =?us-ascii?Q?l2eTlknSHKKjXhvTxYeqjkyi6tIo8KRcSwgffEgvMO39czHsyLBthCGXT4SX?=
 =?us-ascii?Q?VqACZp8sOccoNthfjT9PawpnF6WhrJJ5W9ei/YbSbPIWeQg304X9+Rdih2A6?=
 =?us-ascii?Q?yB1V5RIRPqwjU/OBVHR8hITK8xfthd0LpOSc6feQdUFkO3N6kv3a7ul9p8oe?=
 =?us-ascii?Q?nl9jL5MooCRX7bx0hHSYncnYEMpss/qGtE3sVx7MZLfVQeRpNr7z3RAjKqoH?=
 =?us-ascii?Q?T7UtdhsJZLAruISCQ9UbVpDy6mYdyE+OYP9FqayF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa58a06-5e30-417f-5d9a-08dd7603d0a0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 18:41:31.6229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcvXF6UxqvYRi3vTpNJTBnCFprJ9946XWFUCr+GqJtThzFI7GfNj87mM7WNK7gtZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308

On Thu, Feb 20, 2025 at 05:56:12PM +0000, Jacob Moroni wrote:
> In workloads where there are many processes establishing
> connections using RDMA CM in parallel (large scale MPI),
> there can be heavy contention for mad_agent_lock in
> cm_alloc_msg.
> 
> This contention can occur while inside of a spin_lock_irq
> region, leading to interrupts being disabled for extended
> durations on many cores. Furthermore, it leads to the
> serialization of rdma_create_ah calls, which has negative
> performance impacts for NICs which are capable of processing
> multiple address handle creations in parallel.
> 
> The end result is the machine becoming unresponsive, hung
> task warnings, netdev TX timeouts, etc.
> 
> Since the lock appears to be only for protection from
> cm_remove_one, it can be changed to a rwlock to resolve
> these issues.
> 
> Reproducer:
> 
> Server:
>   for i in $(seq 1 512); do
>     ucmatose -c 32 -p $((i + 5000)) &
>   done
> 
> Client:
>   for i in $(seq 1 512); do
>     ucmatose -c 32 -p $((i + 5000)) -s 10.2.0.52 &
>   done
> 
> Fixes: 76039ac9095f5ee5 ("IB/cm: Protect cm_dev, cm_ports and mad_agent with kref and lock")
> Signed-off-by: Jacob Moroni <jmoroni@google.com>
> Acked-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/cm.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied to for-next, thanks

Jason

