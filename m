Return-Path: <linux-rdma+bounces-21981-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YPdgLfEHJ2r0qQIAu9opvQ
	(envelope-from <linux-rdma+bounces-21981-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 20:20:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D7A659A64
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 20:20:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ZMk9GCWE;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21981-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21981-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C13EC30A2D62
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 17:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F643546FD;
	Mon,  8 Jun 2026 17:52:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAFF367B6A
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2026 17:52:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941176; cv=fail; b=M2hmRbZ/PMqa/2A0BJph8c8WO5us6M7QIjr7p0scx8eJGqJy/3feDCvROqpIhOPPjRVceg4ZDAAdqJvz6dUZnb6fO5eWBSnV5Vtvcj403ZkNf5CL8KBBdMcoBhCjOa4lcqt2Cn/Pu68XrIfolVk4wLRbgcR1vtWkj1ffLviEevU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941176; c=relaxed/simple;
	bh=95WwnHGnauXQFMezLhdJB3LOUjnBb875G0eAHsUEpCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qOMnKV/r+naJrO17KSOfIuQLLZQw1iXwaRD4XvL566MmIefFUMhG45AlCGzm5MugA14ulJABrITdcIhUJwNKFipV00+7PzMfsBtuR+FZa2VVhBk5n3Ib7Z7nUnhYsDAGhjw+m4HwX0kSHF3/rYgg16vmH9zSodV8h0AK1POpClA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZMk9GCWE; arc=fail smtp.client-ip=52.101.61.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcKIyb04Ozp/c6iNxW+w3iiIMsBlGGTBJDiBw4gAWm9RfVx9jvu0iREBp9DHBFwj//ipwEV8BeuR/dWfQkqFkFZ0kCPLWckJiS8hBZPCZANfemwes61DTfpch7ATBs+LgZ+DiHotzLmC8QJOOyCyqmXLKN1c6CsNDqEjYnqA2Y825ImUzwGxuB5iGpSOiOmRrFjjwNRnlEw1cmC8Ke1ZVUisBoAS9fCWN8YmbxyG14lEdYV36EKDB7z0G1homAiEwnyBtEU/WVxKiFBZg880yPtNnq4+vmKmgPq4nZT9AWcH70QU4bBNNGP4/gxg3AVmukC8N0FKI62dpLA/toPPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6t8llLgmBTdXhJTHItn2do4fZeEK2sZKXSofbyaGY24=;
 b=KmY6Dlh8QkrBLFzz/nj9ADBzl7bVqAXEcF2WnSwyFbqbXY0zDogBP0QlpXFI+IudhIK470CdFX5Iv44xMeuNRYdzz6mz+Br5HsuJCfwDXQXOpwQn0qZBWocvdHCntE0dwj1ZUdjrp1aDAJs5q3or20qvzprlMrlEEdm0aCMRo75KpJUM9JQEKQa6aMFeHrRthO54h02zQ21Lz/JUmvi1W5fIxynAEAH7d/n7YVxCRmuzEhKOkksj7OVLkZhifCLk9DvP6pcg2XZQqYN6m1lv/H0fcUg30o4y9wHM4veZm2ugDTxnJEfUrJAyX6z7vhHYVjPt7JehQnNwJtmCy9pjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6t8llLgmBTdXhJTHItn2do4fZeEK2sZKXSofbyaGY24=;
 b=ZMk9GCWEPPE/w4uiUAELHSWR4eq3/JSdZm6B+vjMVZa7WhF3fiku7avaTDqw3bErYnOoZmjAHCqq50GE69FN7Jf/tDD5QNYKTdu2V+iJOGwwfxVwhUR6sHOT24ZSCRexZ15R8IMLXpSmgr9zS7m/4CVsJ+99ya8CB9LXKVs0eTcAB0/wo2muSLtSIj4qprDn2nJT22rt2MivEAdAZhw1GQG5TO8s2XOILQ6iviLH3OgtftMSWrjdWpNehyhw7rvrQOMnHNcy/yccZnt2q++GVsIuU/xLCbfb0dFAjh9gFB1u7UFi9OHzAfwl5dvQb2B8mRWn7d8CFL3I4lzrQVfNyQ==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Mon, 8 Jun 2026
 17:52:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:52:51 +0000
Date: Mon, 8 Jun 2026 14:52:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc: Doug Ledford <dledford@redhat.com>, Edward Srouji <edwards@nvidia.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Matan Barak <matanb@mellanox.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Noa Osherovich <noaos@mellanox.com>, patches@lists.linux.dev,
	Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH 00/10] Fix races around IB_MR_REREG_PD and mr->pd
Message-ID: <20260608175249.GA66752@nvidia.com>
References: <0-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
X-ClientProxiedBy: YT1PR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: bedc039a-c88e-4f36-6375-08dec586c22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|3023799007|6133799003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	IwNc2WBhey94E5edr5QTWrjIVdu8JeDGwbTnkC1/UgqUCs4dxbYIXoHfMrB6vLBNEHa5hjo+E1meqyB1oOgYUqXJypgcsDVJhP8KyhwIM4Q/oKWhyWLqMwXhr3R6q5wmSdfj+kp9/p1NKunkZTrj4g1db/WfPkMP1piNH9gSRgciV7TO8SVg6pG5rFKYR3vCMiCnWeRVH93jGGDNeWUc+TOFY8DqasPAoCmC+UTRIUNFewU/xtQqRQnqCvju5jqIIBDcXP+tqwVbuQx8M5vHXNL8fsGQqh+7eyMEhD668j3ZQMYhob9RbQ/tuFNSXvAZYZO75oYtmCxCxyWg3Qm5KLxpikET8Jr0YE1f7Aq4EhA5kqBSW/o1c10sPuMaSZ6BfFvRqbEBzFr7TGbxjraSTPlXMIDrh3gF7utuesHyL+XKSDwTD70SFEs5qxSpispP58e04uktzE1gKNoBH1ulEb53laX05UFlEI69q328Ku4+s9sJZ+Vn7FzBDS1r792A6ZsLI1b71CDtWggFS0sSrkQaBTzUDV6Ux8RprBsahOYBcGOtHsi5nOHapK7lrajaAOWSsMOB0AQyXC2FRiVItoeMy8Vtf4nX9PpcCk0IEKWBBauXCwt/Z3Son8arqgkELJkn7qfNm8Y2j8MNhhst0yAJI8a9mZt4pjA7S8rTb4ZHph6gizTcelUFUyNQNtx4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(3023799007)(6133799003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kSPpW4UBYr5sWdYC0etkquSaRVC4krqE9M+oP5e0smMRo6IEzwV9VdkRRPOV?=
 =?us-ascii?Q?yuoyrVc2ND626eoWpDFJdV1fPrnPf+mLI9ih4SIsl39X4Pgqd3wsUeMMSV/w?=
 =?us-ascii?Q?6d5yXj4nZIgHAjs7OoesAgpk0WOi03XZEEv6/X72sx0VWnRilLfIFmmGfkC/?=
 =?us-ascii?Q?gFotnHIxMROXibqbaN1NJEaJAqHYuDdUl6aWW9tcWOvK1fNubhQkk04ckzom?=
 =?us-ascii?Q?lTJ0awfWwmSid2phVyJMy672iShT5ViHVtdMd7TbpThtFfK7wdJZEoYdtHL6?=
 =?us-ascii?Q?CKRcT6ZncOIThCXzrv5Nv9Ym0MZRO7F568DNpDKV7YbqKVTyaZVzPX04Xn0a?=
 =?us-ascii?Q?m/BcFqm5OvGkm+kqw8HyA6/jfZjmOHbluzcL+Ob5PearzAN06mwLJEGWTIPc?=
 =?us-ascii?Q?csMR13qdvUbWMvnbi6ppXrSj85YUG5Wn/HbgOwc542Y0j9jsRE3QgFwDeO7T?=
 =?us-ascii?Q?BLg7RfRdVeXeNb1G27QXyid6m7Iv6zjTWOxY/7Lr+b4y+ekNUBnHXEc+gehN?=
 =?us-ascii?Q?sBi4fiG1qbuf9LbUiK2rOlKD4IWyz2jLlSKrVK8+SIgdPhRTO83qZiH71O0+?=
 =?us-ascii?Q?/oS8xSXteISm1CaA+9MsFnQI8qowHgOpu+knzd8JLmTxBS8lioFIKy9JQ2Kt?=
 =?us-ascii?Q?JO14xO6BVn8DYvsODcSeySNis95YxJ+mjUdnFNXULjnD8gpGWI7zk3riKaeg?=
 =?us-ascii?Q?w5wSjxgQ+kU+oxKLnds7cnY8vUJJkS2eOnaCPjva1iArRZdrJJDd4beVgsmR?=
 =?us-ascii?Q?uaAuOK0ScRfkFSqoz7WS/bU/sIOCeZ7f0Dvn8tIQ8PUcZHR+9ZhmmkXHceac?=
 =?us-ascii?Q?4CtVT9QOwviz7R8jMBSkNVcKuM9c3J4Qu1DRCulSgBT7yx7faNDct7VuIFos?=
 =?us-ascii?Q?JnxgXwXWO8SJFdUxJqVDqVTyKQfJzE/fC1NcNoP6FbItu87BD8TvOfu9WKZp?=
 =?us-ascii?Q?H2IA+LYBZ67CI30WuY8+qPXk4CYL16zZ6QuhS4XzlLwIefPrE5Lq/hRuvzmg?=
 =?us-ascii?Q?5/IRhAzrWtJBXrCxlgrFpJ8OL2XA0bIpqQMzvvRw6gMIjipTccQ6MMVInvLB?=
 =?us-ascii?Q?dGDq9O8bRRWLzyP9SbX7Bp82xRYNNrTR45Q8IlNklzTffgsrqTBGEYHFSppS?=
 =?us-ascii?Q?bIHgHnuDcOj9BFvMzO3/lbyL3cB1hTUm5XgUDQw1QhphKHYyH5w4jDo/DuaZ?=
 =?us-ascii?Q?3grxs4n0KKmv6aTmNjQbRZcMGCxoPKt2K0oKsAO2cI6fx6uRbsLr+gaVqLzj?=
 =?us-ascii?Q?ZRxJSacLe+Om6A2+jlnklCqDH5xp5ROcPBwUe+q2EQiyDIKFqJNF9/m0WE8f?=
 =?us-ascii?Q?sychLQuqVieOUmhzq43RclwyGjeF4nmFKH1xSmkkX8vsvMWGatz+uwOy0ULW?=
 =?us-ascii?Q?Mbqw/PGIytWd24XLzrtOhJp4gE9SVbwTIOiOvpFP5c/cKMeEQT5i+0eqt/W/?=
 =?us-ascii?Q?b5Cs/8jTDRSBeuxBgfgZU2NxLBFPs+a6mTXjjTlNAZDyg4JSl/7bTO2J+0Vi?=
 =?us-ascii?Q?8funxmrqP3ek1yvotfchW+lriMuSfMRmjbN7pUXAtrv3T409puDP+ZBOLBbg?=
 =?us-ascii?Q?MkhprA4fWMRlqPOH3ItJHjPXnAN76TP8Dkns9NWI8KmsuXxANCNMC+dbB7o7?=
 =?us-ascii?Q?MO4oswfkGh1VJegiE00Ie7B6MQo1ekuV4ifEzkZkHuWdWGO4qUDctG+X6sTL?=
 =?us-ascii?Q?crlL93ImIGLqkR8QuLJaAEPH5grGLaAvwPc3MlHOYbSN2LAB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedc039a-c88e-4f36-6375-08dec586c22d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 17:52:51.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I70xLi5awrv3axZsRpHRFp/tRDMc18IH2aPVsUTGhfLRFPo8wEqEDtxEa8WrH686
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21981-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:dledford@redhat.com,m:edwards@nvidia.com,m:leonro@mellanox.com,m:leonro@nvidia.com,m:matanb@mellanox.com,m:michaelgur@nvidia.com,m:noaos@mellanox.com,m:patches@lists.linux.dev,m:swise@opengridcomputing.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10D7A659A64

On Wed, Jun 03, 2026 at 10:27:39PM -0300, Jason Gunthorpe wrote:
> Sashiko pointed out an existing bug related to mr->pd: when IB_MR_REREG_PD
> is used the mr->pd is changed while only holding the write side of the
> MR's uobject lock.
> 
> Effectively, because IB_MR_REREG_PD is usually implemented by changing the
> MR in-place, the mr->pd becomes unreadable outside an MR-specific system
> call that holds the uobject lock. All the readers in this series could
> race with an IB_MR_REREG_PD and potentially UAF the mr->pd.
> 
>  https://sashiko.dev/#/patchset/20260427-security-bug-fixes-v3-0-4621fa52de0e%40nvidia.com?part=4
> 
> This was presented as a simple 'oh look it can race with nldev' which is
> correct. However, asking AI to fully audit mr->pd touches also revealed a
> much more convoluted issue inside mlx5 ODP that is also using mr->pd from
> the page fault work queue, advise mr work queue and advise mr system call
> without any locking.
> 
> It turns out this mlx5 problem is entirely unnecessary since outside
> implicit mr there are only three cases where the UMR actually flags the
> PDN to be read by HW, umr_rereg_pas(), mlx5_ib_init_odp_mr() and
> mlx5_ib_init_dmabuf_mr(). umr_rereg_pas() is particularly tricky because
> it illegaly updates mr->pd inside the driver.  Reorganize the giant call
> chain from mlx5r_umr_set_update_xlt_mkey_seg() upward so that pdn is
> passed down from those three functions instead of unconditionally picked
> out at the bottom.
> 
> nldev however is trickier to fix. To avoid disurbing the happy paths build
> a synchronize barrier by removing the mr from the xarray and then putting
> it right back. The kref completion acts as a positive signal that the
> mr->pd is no longer being used.
> 
> Jason Gunthorpe (10):
>   IB/mlx5: Don't take the rereg_mr fallback without a new translation
>   RDMA/mlx5: Create ODP EQ for non-pinned dmabuf MRs
>   IB/mlx5: Properly support implicit ODP rereg_mr
>   RDMA/nldev: Fix locking when accessing mr->pd
>   IB/mlx5: Remove unused mkc bits in mlx5r_umr_update_mr_page_shift()
>   IB/mlx5: Pull the pdn out of the depths of the umr machinery
>   IB/mlx5: Don't mangle the mr->pd inside the rereg callback
>   IB/mlx5: Push pdn above mlx5r_umr_update_xlt()
>   IB/mlx5: Push pdn above pagfault_real_mr()
>   IB/mlx5: Push pdn above pagefault_dmabuf_mr()

Applied to for-next

Thanks,
Jason

