Return-Path: <linux-rdma+bounces-9207-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0220CA7EA9D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AD242075E
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8520F264A69;
	Mon,  7 Apr 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W7m0Jdiq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7564264613;
	Mon,  7 Apr 2025 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049650; cv=fail; b=qAgWqAwZT2fYlEzbAwGmefv2d3/i6YOFWI9vwWjRcMJxQ6TMa8T4uPi1inJPSwEdTraxkVNipMitBVG6yE0fh0iL9MInK+yQfhQXDS+2WDa8dqc3OLLMHAs9OybK8GENNxIKQpKZkgV+yccTx2KWkxT7xEM9wZ/GzqIsoxM35cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049650; c=relaxed/simple;
	bh=g3dnni1i4A9YXR5vZ03wGTKwwZVXNeHwuSfPxy5ff+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oJz/sYr5dpBfrvv6C1VSNx7R9h1s0ETViu1Q9+KB3mj59NKRT2mBM43IARoNypVVv7xAZl+INulF/F3KGH64SXmvLujofccb4a2i3AcwXD2tIlC+rDXrRZ92MhnX0SXMw97340csoZy8E4z3Y+g3u+mhvE3NcHLyd82wjR+gHeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W7m0Jdiq; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CO0yRNBkdLq8AjdmoIoryS5hHo2Wh5JNmXRCJBO7dPm82wWnrr3Uh4/oSJdL7m7GoNeENNO8vbylSgXxEFeKWm2HE9kqMMX6uAegVrrwxZpnJ1VH78NAb5a/xtOSu+ITmTBBo8lmyICWPvo8akjnoLcbyAWKW9y+rIo2ThygzOM2aQhFRQNL3XBJ7s5zCHRg/2EJ6QOcELGDF3StIrzGDb4/UYSmBJI71xvr7E5jq2/AFiVQpp2H5AhpI4HysZmuDZs2qBBqFK6RaZ87bTlLiF/FZ2aFQfMZwaQjUPTrjlV2SpSv7uHFM0kwrBgvWTyFh7OS4VRvZmobKaXxyFADyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIq4eiAO6x80Mrx9AU01/bAOutPc09AynZ++BFAFIyU=;
 b=psK6MCykJdpaR94tPq2ZRd3f7VyXBvdeyhWiKiYLQHzlIkZPgu4S+dSA+yOSB3auHX0/fvY52jzh6TvwbtAeg1KsHbOiPz25Ma7Vjuj+Yk/vRtterUt21XQgWbkv2OvCbMCawPILQjj9i6E4RN+xOSxuACpOKertVvEzOY3Tm8NyTmlY6XPyrb73Q+TU6Lw1XEwjv8Pr1S9o5IrNjOU8JcPkBDhYy5fiqzlqe5J2jixZMtgecXs9SAcevOYp6AZ50qohHvtLTNKK5A5T0+ojZtxSu8KR4ZDVR+TDDvJU/rfHr33Zm31gTeZYW4wkweECmUwNeF5eACSxNGY9knncHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIq4eiAO6x80Mrx9AU01/bAOutPc09AynZ++BFAFIyU=;
 b=W7m0Jdiqs4qlXIFjjvLCXRFbjko1X0iiPgtMDMS6vPFznfqJfSt7ssnZcFfr40dCDNyTrBkORbp1Qdp3Llenm+lCc5vLaIpKgN3FEXKZQU6zIrrMbKAPqYD7CoN2CUmJW5AzilXaB19T6WEeCK1ZqvBrzpzjneieOeAA91TNdj+BexLZoDF8kEJu9i/2FyUVh+Z9IAM3eQpIkYp4+NJMQDNocntyKbnx/NSrycKsVGHqSJgnj4I+kCuLow9S28zvOCdI7Eh6c0hWeag3tm7eGsu2JVZf88vokjfZtdq/QIH2gRY1/74d/rLHRWNeCzJqjVFKwWaTf+fhAqWrxRjLMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 18:14:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 18:14:06 +0000
Date: Mon, 7 Apr 2025 15:14:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] IB/hfi1: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20250407181404.GA1763434@nvidia.com>
References: <Z-wiYkll8Vo3ME3P@kspp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-wiYkll8Vo3ME3P@kspp>
X-ClientProxiedBy: BL1PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ad1410-1352-4cbc-000a-08dd75fffbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wJQoGfK4OOHyxsIAzez0aMWaP7S8TqIGglaRAn1Lmk5JL+H0ycFon8VuI5IQ?=
 =?us-ascii?Q?G08V6axeTABY4Tarby67g0xHxzcdE4zErdBQlFWAnD+MHdlTPjl41ux6ebvS?=
 =?us-ascii?Q?gtdZlWtvPaYfcLhLsMf380MlHqo0vRUsCENI2YDkY37e55HGbk+yRMVa347Q?=
 =?us-ascii?Q?V6KWXG5xDJTtVj99JkqlYCzUKd9yW2TzsyjIqVKELny7u8xpE+0oiGKvzrFo?=
 =?us-ascii?Q?LtbGUqrNmSElL9EYNkrPb52SpVQJ4rk+TFZVEZXZAQLGs8D2JnTarEsQCf9o?=
 =?us-ascii?Q?8EFN9XNtXpSksqG0MjwmG3GPiIcdR2+EP4I2YCQSADgfn+ws+SZnsEtTLj+J?=
 =?us-ascii?Q?POsWqTBpwFHkqqzgSkyWRo11BT79CuBRvaxWya12/XVthyyX2r5ZB+PQHC7Q?=
 =?us-ascii?Q?CFVN2JlM7wkO+4E5XgMLKL5hWtNflbYKdkFfku74f1FIiXX5yZEyA1inyCNw?=
 =?us-ascii?Q?cutZEwHfUVVIsP7ESyhDIQ0RRkoTfUg4hgBe1x1D1inoZlSLvyXqwwCjom4a?=
 =?us-ascii?Q?EWz0dpmtu8GezBxP8HijoZMj1AqPjRQK0ioCnTr+5CUTFK7zZ/kvCeyVtzBB?=
 =?us-ascii?Q?FiK2sqdOwaDZ0A580wGNZdOdQi/l2Np5t4F63XSX98d1gWhtrySNzyH2u9AE?=
 =?us-ascii?Q?/bP37fIbsKSY/DLCRVTjJJW5E6RZ/ugqsB6JGRZsY+7qqSCMOfbl5HI5Ylty?=
 =?us-ascii?Q?6VAFucIVjPk35Ku83OyeUTuNyP2cuK6VbW0fw2sXN3hQrxp9YTWPcNlPNHGu?=
 =?us-ascii?Q?8ggBkvecvDG0mNdftNKhPaLoiE6R00cZrDhB29Oef1U74xoLZwUMmx3QAr8C?=
 =?us-ascii?Q?weGhDzJoiUqHd2r8b6UwEuD+fmPgCp0b9An+TUJMQjjynDJsee2+3wA9BwTM?=
 =?us-ascii?Q?/5SIYOzvpxm/wtloCybTQeZfxzlP8ebSrbMRJORnxs2b0Vvm2IY8QYzxtvZU?=
 =?us-ascii?Q?Vp16JJFZHOQAnFQ0F4Dzg/3z6K7dkR1AtzQH75btakWJ8T3uSsEx53HGTLgL?=
 =?us-ascii?Q?Nyy7A0hyP+Qu/V3GKVt8GvMYFB+kP5U9vRcvb8EVwu0DEDqRvS8NIqwOU8NL?=
 =?us-ascii?Q?iFcmjhH1tl8p840cDN1Er/RXnquMCe57b1EdSisvfuWCvKRe7KNyVL2op7vc?=
 =?us-ascii?Q?VxU3Xzn2l1LSZAD6IBqSP16aRY6r/VrOhYsmEONQANwRG51AGK8GI7gJeHYO?=
 =?us-ascii?Q?ksDOpPv9N17VYugsH0nycJaxYZkrQKBsTVFndMlAloxO8brNFQw6kZL5rbhf?=
 =?us-ascii?Q?snBPna05/L2JJXDHNrKngsXKVQNgW6u0cQqwgbY0bbJfp56FPolEidc4SYrY?=
 =?us-ascii?Q?CzkHJTIsB5u3aCIU1CJfoVdZFCzyUDi2E80V1gYMPg0Eqcpp+su2Oa/txJ0b?=
 =?us-ascii?Q?FC3fLrMDsBdlcUKdZbBhk2iCSsBZaIP2yMNYlUJxdrseG0ZNFd3eyZifpSQu?=
 =?us-ascii?Q?Z9706x2IVOQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?18qgkA6pviy681X8sGCvfsXkO1w+2cVBfWZCF2JBwjYWs36NHtIcWQTkT44u?=
 =?us-ascii?Q?P+MkyIFpqpKvj09Mt88ouVeKW4Ug7Z98eI0TkkiltJML0YCWPyy2FRD+LMXO?=
 =?us-ascii?Q?pr4DCen77jx8D8z8+DQblK/IrNNJouBdo/icooQTDQeoG+43FKbTZ1ZoNsu5?=
 =?us-ascii?Q?g4tt/8vnQCSaRtZTWkk4/Gdz23gdlWmWbfU8rumqBR8RVcKleIqh8we8/jWv?=
 =?us-ascii?Q?HmvMzSnw92XBGqOTxpPjibUXJWeqjommIb+1qbrU/Wm5zt9a9xIaftGDSxdF?=
 =?us-ascii?Q?5hXHgk0nAg6wgXcmY9im/m0UJyA7fjVctRYImi7i8LZ7chC6mgY6z0IDe8NU?=
 =?us-ascii?Q?TU2E2KK72GgO2WNkUNRK/2pCKWyx2old2VOxg/h9gmUgax9jM/gshl84HXuM?=
 =?us-ascii?Q?utet53r7NGefIh2Kgor0wEkjEgNImorrRztGCZ4wi2j3tMsexL4s4bAW1BXA?=
 =?us-ascii?Q?DkhOtRYpKnQOmG9o0Nv5MIei03+llJ4XxynCz1F91OfiXz7J/37nvKo31P3e?=
 =?us-ascii?Q?jTJv8hpVyJlkch9JfUq3T51STEYuIKBha3zDybf/4zyhExwauoB7I3L5lhkE?=
 =?us-ascii?Q?ebsUdeciXLO4iIEUuIIAXxzMwWB3iyX5Df7FRIfMcNlfuyQC6u2tzLHRwzU6?=
 =?us-ascii?Q?jmZeDvixI4a2dc5Uk/FgF8IVe0TWnCK5KNKanKrP1femQUKa0IKF5Mdcr4I3?=
 =?us-ascii?Q?hvhjeXL7LgL7WFe9nliy9/p5z+a2hgj3smLqpzWDfDYcX9/gy0EpGI2jCisM?=
 =?us-ascii?Q?cT3TlkWEFipPtpVH/6hbN4oXjnTN7br9+IejpJRVae/OkUPAE9Edu4yBwVsf?=
 =?us-ascii?Q?YrYdADccYLAPg/8s2IpiJm1gimGNj/ydJO/q0wuamOhfgrtYY13lmkMobglt?=
 =?us-ascii?Q?5XS57KJm+bRP3SYIX5Twa6NoCi6fJ7yliPgVq0wAGkLlDuUzCIvqIw9msd/k?=
 =?us-ascii?Q?Ce39osuwMhPnW0HCasgXSWj9DtGOF+vEhsuVaviAmTf/N3BMsoPZ427VDwgK?=
 =?us-ascii?Q?th4TuD996jUf/n2ytHDxYetwlzzVN857eraYRd78AyvVtPmjo9BXmzIpRBb7?=
 =?us-ascii?Q?bkcXVSoKud69ObiCdt3MGeTlKykLvzv1Vt6H0/vXIx5uZhGvG+/wiKQPws/U?=
 =?us-ascii?Q?9TjFN0JZMBcOud9m2SQE54qJOOEFNUnVBVrNsuyC44xpwCSXm0VxjQqgaCQA?=
 =?us-ascii?Q?tMB4fOqqlSE0b/IK3TxqVUeU8yXxKNjuTOw1729jhdvScEBKYqgUUXem2vtx?=
 =?us-ascii?Q?5TUpVGPt1IipPfzTafHIuxk1ReOUWzbRDj5Xv4WQaAe2ZgeeRyzCzdRisi+O?=
 =?us-ascii?Q?ecDrP7OfWQO1gT8Y7rI+0Zof45ukMd0NZMG7G95LUg4Moa7j5RvZ/IqVXofJ?=
 =?us-ascii?Q?TkXOa9PaWwDbcnG+t74cw7V+CaBcSS+UuYkSU88NrdnloGzumX614JcRlW3t?=
 =?us-ascii?Q?bP9KaZdTuIJQOdrXBCk2+m+RppmGjzQ81v1VWOdPiCnaxeTbbMu8jaIv+Tu8?=
 =?us-ascii?Q?xdTjRhLc/iSyzD9MhSN+346MT8ROYmzfsnL00/vPTytJzMmWlifDuerMfqX0?=
 =?us-ascii?Q?zYj+X71ipbyxZ0RRuBk07KuLqJCNAE31sBGcXocC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ad1410-1352-4cbc-000a-08dd75fffbbc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 18:14:05.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xr6YT1gE6jAeUx2nmpCxTLPrA7v0tN9J6fYFfb37t/OaMX1uSwYxkRb6t+DhwoD+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630

On Tue, Apr 01, 2025 at 11:29:06AM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Remove unused flex-array member `class_data` from
> `struct opa_mad_notice_attr`.
> 
> Fix the following warning:
> 
> drivers/infiniband/hw/hfi1/mad.c:23:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Remove unused flexible array. (Jason)
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/Z-WgwsCYIXaBxnvs@kspp/
> 
>  drivers/infiniband/hw/hfi1/mad.h | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason

