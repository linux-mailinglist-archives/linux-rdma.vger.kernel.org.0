Return-Path: <linux-rdma+bounces-21633-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0F8SJYUhH2qRhQAAu9opvQ
	(envelope-from <linux-rdma+bounces-21633-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 20:31:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAFC631169
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 20:31:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=LW6pe534;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21633-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21633-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B91E301DD95
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 18:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC55391E45;
	Tue,  2 Jun 2026 18:31:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431537C92C
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 18:31:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425089; cv=fail; b=Umxf4zAOxSWJIuWqWR5yFS2imI9mfDwNRM55/QXnxtwb0aXGoMIrLqjLi2p4u3PsJsYE+w89DT5ZqSpbjRq2Ns59M8c13jr3tgK6veEYX9zgjUYLsMMF0/0tqFMWaQIA0Oa0OGScKcnz/cyH2UGknp3A65QBg+pFHQ7kI2O6Twg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425089; c=relaxed/simple;
	bh=4pv3MquKb1XIuAcJ+Cw2C5Id61xcL7K2h/aoATXWAGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kel89qb25DBHoEnz5IojI+TAu80Qvd1gkO3vvRmYsJcSgqsdOqNXzs2wH87gLLcRuqixo/1faTCko/4UE7hwv1C4YZiwdkH97woPO5RXsfIrV5+0lTaFiM2srHyLWP2RP0s9ReQx/SD3OL6pYHPYDhxQehso0PHPRV6NmSMBEMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LW6pe534; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMHdC5SnlpVmfwENZhc3OizY1i8R4WU7s2jURBLQSw5cwdjXItMjw1xpExebGG6sRalGRxsF0FOBixymSahBdje/1g+f5BwkzAZEb14+xgnK5/nw37aHvblIo6XF/VdX8YrO1jaglSZOEBzKZrsoI0q20sJ15ofrOrPRNwRH5Ibn3P/6Qet2A+ktzbTqVR0HfcqdXzh5nWe580A07JoYB8xkNPcmWxcwga29bGZgvjSFNNW/WsCzh4xD5F/9B4VDjPl11ng5nou6mvjKl3BZDnQLdiuHUaQE/Yxd971vlumebqiBkLaScVsKN+/kux2KpXNV9gVGPgHIv51swAkNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEo8pmSMEkHMtreIcDgYEST2ow9TAf9n4V/jl3nfbf0=;
 b=aYtLAvZntFOrVuzlUCUr+n1cQbcYAYxFwkwHC7eweRX0NHZgxaH2guZLTJ/XsyPlzS3n+xLHEYlXefDIEi6zNP3zA6o3DMUwFlyj0ndb0aWY5WmMSl+nNhCyBSKnOjQZ96aXzGvL2tXNyMoBoVG95JrAkXSzi1+3wheY4GWDCMhyzVIFyCJNVivwFZXOUhXeOLS1z3hKArpwRFnqCKAA3qLRHUAd/aAQdiSrFXg+Z/iQcW4kkHcOG2m6LruQYvetzy977EoHrMfiiN1bDoWJ8quhvdoZIaLSW8KlwNpHixj18GYIDk6bIXCRea9LL9AFHhgy5BE1zotpvcAOzS/xuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEo8pmSMEkHMtreIcDgYEST2ow9TAf9n4V/jl3nfbf0=;
 b=LW6pe534dHkC68pOLmzeA6LD/jS6bJWXWvR2UYyf9GyLzZyLxOATI4tp7/wq6GIeU7ux6uluF/7X8Nmp0awsUanEndbUAvrFgzH/OvLxZmRe6zftC/UyS6C+9KV+PyrAfp2W/L0JzUAyWbKy0iL1YEt7staLLHcL7BQAsd9kW4sK5cGnjGRvHcM7PxJKukW/hOjW8/ipi/lp5cRJI+YbF2mQQmvHutCw1Udsz6gfAQm7XL12ivNCKcENdELcjOyuMEicPa87a/5nc+8QPG1ytZzEVyqd5PQlV79zZQkwt8r29taygiN/BlHBNwIY/GcLxKWUvvEStF+trooitVixfg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW9PR12MB999209.namprd12.prod.outlook.com (2603:10b6:303:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 2 Jun
 2026 18:31:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 18:31:24 +0000
Date: Tue, 2 Jun 2026 15:31:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Leon Romanovsky <leon@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 2/2] RDMA/rxe: Fix up RCU usage for
 rxe_ns_pernet_sk6().
Message-ID: <20260602183123.GA1045352@nvidia.com>
References: <20260425060436.2316620-1-kuniyu@google.com>
 <20260425060436.2316620-3-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425060436.2316620-3-kuniyu@google.com>
X-ClientProxiedBy: MN0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW9PR12MB999209:EE_
X-MS-Office365-Filtering-Correlation-Id: cf67bf4f-48cb-40bb-f294-08dec0d5268b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799006|4143699003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	z6/kF0pKJjkO+4KuTLujfFI+h4ApOJATfbh708chkeI2ojJDFbk/dCsKua71IHr9UXrr/fEgq5bnQrEJkV2+VP/f9JjWTU9L8LI22RzXMkLyR+Ss8R7yCql9yV02tl2rW7yK7oz7LNTIAeuXcSXTiUWNBx0E9Q9RPcygTlCoZSOYkzSPWBkS7WVKvQ1V3g4r3WueYhiQiQCZXVQG49wC63pTvZ1GxOIt/X6GVBK4HC9y393/ND1y4wc3Zzc9ATLXj+r/7aViU5Y1sh8NrxfARe/iwD2kyFk+GQmpw/3OxRoQfsPtFgKvzeiDV8CN7hPpshJzm56XvuXI7HL9lf2gmbdoIw59DhJ2v3Pc4+hl2q5j1RSgE5gkk9ZSLMlt2HNADmLsuVUFGPVnXLe1fgzeXMaLGBnqDB+95VejpLKqhY+Iu3adyBNu0nxnwQE9WNppsy7lSaAnvUHiNKA61Mr0LEAi8stZ+U13X6EbNol3XSG9ZAykRLB6VdwhLshc7UOGrZijTX5cXzOHcc0SHoESn2vRvEsKPpLiOVUX6Yx3wmCR4Kt1tYzgquN5aY+Wuw3rHCRAVD7qSO5cory2y9G52UMtmyI/zHrVFWGdZWXUsX3wZy4eS5zub7sfiq/4yRqUKhJbpXQ8ZiVC0e2E/mC4YYfiC/5b3pCWtYko+qdeywE2G/8O9R7Xqdg2viB5kruK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(4143699003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SmwmiC9Zya+hIWTBa64Hc1z5YSmE+cW+OTLETZCn3iuoExS/wn3oX4RJZTXr?=
 =?us-ascii?Q?l59J+JyJOQseBpg/q0YBnckUJZnBCvNk2lbuVQHUuK9ojSmlfNfNmE9AuMUm?=
 =?us-ascii?Q?aygy6HPDL1VWvdw0bVtSbgXvvGwYs0hORjR6QhvEVepZUAJSiof6d/vyN4zj?=
 =?us-ascii?Q?wJNl5NjYlkcAF85RtA6FTMH/cEPFr/DE+QjLp1KP3O0G2JS591FuJvbuB7cV?=
 =?us-ascii?Q?hA39UeBWBDEKUpy51hOou9aUJ5gkuT+D2KXu3c58sM/wgTV23Bqe1FjFUV4d?=
 =?us-ascii?Q?1HPkJUYBhN9sPZL4iCCimnz2kXn/fieaNRsj6NNH7SppiHXhf6N4fBgiGTQp?=
 =?us-ascii?Q?jUTCymAhGQXAxYMNTm0J2VHZkhfqQWxIIw5elScqcCLQDFw4MOG6G3mARoNz?=
 =?us-ascii?Q?dFm53EefE9G5183UialKFxZBZY6O6OINR8CNQ1l/TLLKERj52Zgq0A/ZBoo+?=
 =?us-ascii?Q?hBnIp4iNjPEVlJzDQLaamAJ9vr0aPy1AkpWd6jqOGmzvkFWQ/I/f8aw+rUVC?=
 =?us-ascii?Q?mOxN64MZyQEnr9+v6hcO6pd8cCtSlETRhRlxQWZiqSyBRlw8Ary/8tweC9wY?=
 =?us-ascii?Q?fs7Y1UOuPKgzebLmCLoa8OmBMbX1CqbhehdEIBiDV8itHMKqJdzYqr80WMCv?=
 =?us-ascii?Q?kELVE/oSywoMr+H2gPV9cUDhI1QM2YdFxFh0qiBXRuJtcZzCP0LYrSMQsMGe?=
 =?us-ascii?Q?4qWGpVaTAv7l8UjMP69YBn2b9koHlcRxdrAYCZBcjrjybSsjcYwhk2UMqYGY?=
 =?us-ascii?Q?gCGdGuy72Y0qoEp4FcTV0ZSJEg3Qjsxx4W/57qjv9X4TXntX6vifHbiaoOul?=
 =?us-ascii?Q?UUocKRPgrJnXw+hgKM8z1NP9D1P6bXQPw0s1B2nrtij/6uw0+zxeYfVeEvyD?=
 =?us-ascii?Q?Hsw3jx98NzIE4JojOcdL2d5kxz0qvn2pYs/dNXSbs5FIrmdXq010HwSaB1vU?=
 =?us-ascii?Q?ssuRlZii7iRu8iqeC8MpuSJAsRrxTWNF3OxtMvtv/COQhzyA7mQXoKFJVfTU?=
 =?us-ascii?Q?3NNcuH3Yo+mN/J6P6zkgCFPCdA/4Ujw59r95orHlO3AB7XI1ZaeYNfGjQsDr?=
 =?us-ascii?Q?KggtOoNty7bVeaonC+O64//0wiSNy6PMoev6/A7PcQMQV0xOLBArvNBYNCBR?=
 =?us-ascii?Q?ddcq/5u5xEr1A/vq1rUkDfZv6kBTGwhuGyhZ+ItKLfIfW+vmAFY63pOSubXP?=
 =?us-ascii?Q?Gsod5Od0YDrGvGmZ5Dp01O/Q2IyQuiWr3pK19Hd4FeDBcXTb+RLWvxJUkV71?=
 =?us-ascii?Q?f3brLY+I+WmH2Uq5mM+NCDH2PGRTcjU7SFr4IW62V2Jsi6myKiQhpnyIF1oW?=
 =?us-ascii?Q?ACAXPLN6VtlADNOfRTRkM4ZXXWFjfZ5F+ExIKAq5Nd33I1Hmdgt9sGN+fp+W?=
 =?us-ascii?Q?JlE18B5Smmm6GPKGz7BEJZKjO3xzOj7CyWmUsta2TBVxgk5I1kzCeStri/DO?=
 =?us-ascii?Q?+YJt4GmPJ/SHhOja0nTlppffI6uP8WPgV68CnvLr4AKMmuAXjpPq/uzwOVR6?=
 =?us-ascii?Q?2svCSQ7ZWR5ViH5UNaMMMkiztZDbnraOm7Q4Z+4LKZHcf6eK+xVjbBOOmF6E?=
 =?us-ascii?Q?bvBsX0azV7zq489t2mQvT5JQR53dkJC6wRBpxu/XVeg8QOsNd12zMuNc71LP?=
 =?us-ascii?Q?5yy9qz7000dOopnSSBNadCVmWVmq+ZYp6AH0v1+6bisamSaXxnWFo+0HBIMd?=
 =?us-ascii?Q?j5gitlBs7+Em64ynovq9G0VN++3gY/Cwnf5J+0hh+8BreE1G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf67bf4f-48cb-40bb-f294-08dec0d5268b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 18:31:24.2792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJ7OzgqKHn+RhW0uurq/s7RlMqXLKbL6lz8+Jga9JCFMaLgaSAvLQzRte+2t6skU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999209
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21633-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:zyjzyj2000@gmail.com,m:leon@kernel.org,m:dsahern@kernel.org,m:kuni1840@gmail.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AAFC631169

On Sat, Apr 25, 2026 at 06:04:14AM +0000, Kuniyuki Iwashima wrote:
> @@ -133,16 +133,21 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>  					 struct in6_addr *saddr,
>  					 struct in6_addr *daddr)
>  {
> -	struct dst_entry *ndst;
> +	struct dst_entry *ndst = NULL;
>  	struct flowi6 fl6 = {};
> +	struct sock *sk;
>  
>  	fl6.flowi6_oif = ndev->ifindex;
>  	memcpy(&fl6.saddr, saddr, sizeof(*saddr));
>  	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
>  	fl6.flowi6_proto = IPPROTO_UDP;
>  
> -	ndst = ip6_dst_lookup_flow(net, rxe_ns_pernet_sk6(net), &fl6, NULL);
> -	if (IS_ERR(ndst)) {
> +	rcu_read_lock();
> +	sk = rxe_ns_pernet_sk6(net);
> +	if (sk)
> +		ndst = ip6_dst_lookup_flow(net, sk, &fl6, NULL);
> +	rcu_read_unlock();
> +	if (IS_ERR_OR_NULL(ndst)) {
>  		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
>  		return NULL;
>  	}

This idea seems correct, but ..

>  struct sock *rxe_ns_pernet_sk6(struct net *net)
>  {
>  	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> -	struct sock *sk;
> -
> -	rcu_read_lock();
> -	sk = rcu_dereference(ns_sk->rxe_sk6);
> -	rcu_read_unlock();
>
> -	return sk;
> +	return rcu_dereference(ns_sk->rxe_sk6);
>  }

This is called from several places that don't hold the rcu so it can't
quite work like this.

Jason

