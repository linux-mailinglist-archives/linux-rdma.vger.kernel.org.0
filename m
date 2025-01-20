Return-Path: <linux-rdma+bounces-7120-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 809C3A172CB
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2025 19:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1143166496
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2025 18:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A93C187858;
	Mon, 20 Jan 2025 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZYaJB67J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD01EF081
	for <linux-rdma@vger.kernel.org>; Mon, 20 Jan 2025 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737398968; cv=fail; b=EDl2n15vQxtHM0H5jvlrlR2RBeW92ftUsqCuFl0qZCfpr1NDEzejRuFBR0CkL10BGy97mlSR5vyDULIVYdM/zbvXRE3mJLUph0moFb0bNbz8T/AQrBJMPlqDckug946uXvwn/XCTZctLHFZC4j+0532egQ0eWU7I9nQqju7Ib4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737398968; c=relaxed/simple;
	bh=ZO1yZQ6Ehy/Qmnfletl7PPUVF56EcWufLQrb89Mg7N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LkO6ZGzJ8lnh/3NGKN+D3Pm1CXX7k+EMpVF9Lr0RRww3KqcBVRiJGaI7bvw2dT4H9KZL4BGznpUEUys5nug1MvwCRRfQKWTY6bAzmu0JaLSVsA24R2O1tmq5vHodwZCNBx+VrBtwd6P5eSNomjGDPQtviQgCdt1V9wJ3ziOBHC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZYaJB67J; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNnlfRBFqYkGJIv7JVbXRU99FgK5VLwXqH2/EpwYKXC/M7cGfKtmeRb5OT0Q30hzIP/yY5bsS6F9GxYXUGm+6/Az7yz72P1JRcciegP5VSc/96P9rDDiYTbQFRnAwItBhFvyDyKrjiDhxPllD0JwJKA1PMbiVMWza0dA9x177Io24zCrPZDvDniMI1OrPPaLNeY1hVzBVnh3JEpCbg8IIKZbVez85wCyvSYJbKCXwQqo/XNjFEfAGuFG/l9rpbHGBTDLJ8Qf1bpzt6vgJF2lad8k2N2MqpohQZZvHjwB2Xx4/bAYbMTDePswSuxXJI0ZF4Id14PAL+7ysP1Ld7q0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNqdTNTaQmSUGqY5mvQLRfSJBGj+Lq68LMNV9eqyJNU=;
 b=h7EgmFTofxAjRsmsr3YbYnP+OOY4dAZDVThOPW0Tg+CE7GBjt7UZm1HvRp9JOzrTNb9CzfyHSGWQxjLfv632X9BL8RS1p6rJWQLBjIjcWw6QNtFg4BfAOckuEc5WkTwyd+rIgIc8+HqGKH9mS8neBBKlZCH3Hh1a9qSFNzFDIvMXPedhJxgk8+kTHoKJ3NVtvOx1imV2CmmpLw5/Akvm6NnLdr/DtUpPpZTIvgJY79bvPV3ndWI0SKsRmUtkhR2rVfv8llPeegBFCg6QxyFt2UeHYPGQV6RndgaJiRaUYD1ItZv9Lu1DCmsLe2tmxPlG0Um6BnpU0bpa/SjalsF7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNqdTNTaQmSUGqY5mvQLRfSJBGj+Lq68LMNV9eqyJNU=;
 b=ZYaJB67JGEFhheORNU8wt9WIOrg48ero3byRpF7aCCgvwCNlPPL1A0tqPGolRp5QP+YaybsDIaDZTP3GgzmUPldKK31koORwzPyl7qe9X2HNfGxrz23PsXbJKiX9ZWT9rogq8+VADCwXt5kA1GRZExflBehgKwhao5g6iNUY+AWzzouN42iC3DybNePc0Rp1982+qcMWFeRZsRaNyO0VCZrfqWcLUx95Ti9nt5rc27yFAUxDPmHlXwpHKrh+aqo49LUcSA/Gypb9c6MSeuGCrCWDz9CjAFmIMWi2YNvpDfER/T9511P1PnK26tAPRx9JUGw4y17qOb0FcXQ6qYFMqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.19; Mon, 20 Jan
 2025 18:49:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Mon, 20 Jan 2025
 18:49:23 +0000
Date: Mon, 20 Jan 2025 14:49:22 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Artemy Kovalyov <artemyko@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1] RDMA/mlx5: Fix implicit ODP use after free
Message-ID: <20250120184922.GS5556@nvidia.com>
References: <c96b8645a81085abff739e6b06e286a350d1283d.1737274283.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c96b8645a81085abff739e6b06e286a350d1283d.1737274283.git.leon@kernel.org>
X-ClientProxiedBy: BL0PR01CA0034.prod.exchangelabs.com (2603:10b6:208:71::47)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: d107ca77-4ac1-43a0-e0f3-08dd39832850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p+6mY+OeBtUBzA9Y+Dx+t3k+bwJTgwqpMwxpJJo2DDXlkYpeucUudWpVVCo4?=
 =?us-ascii?Q?vcc4T0lmc23Yvn84/jKS7t4YhloftU7k+sl1KZ0QlkKXplCpgWtAW4heO89o?=
 =?us-ascii?Q?+YF+ZwXvTr1w9c86d8u5mCfsbRC4JtOgqlXvVZua4XXnAkVFZ6NZr+zKav87?=
 =?us-ascii?Q?Z/Yyzusm3ZilHog283E34aBfT9azJWoUGuse4x9agJray7PU6betyxB75yOQ?=
 =?us-ascii?Q?7P1b4W7RsoZAJeyivTcGN3yH5TKPjysMupMpZFKTDLI6U48RQfLcWJNEzY7N?=
 =?us-ascii?Q?XbA6ZakBSmx3wHHcq4p5YYKuK7sYQG7JkUHXXjf11FlLFcjyN6o0NkDTKskK?=
 =?us-ascii?Q?MYlvtuHT3dVUUn6gQLRpCYkiqad6qZQ0Wnqz2ArR/XGnyZJnqNMNkxpPSPFO?=
 =?us-ascii?Q?D59Q9yeyn4s+tmBlpN/EHDkH41zpDnZHMrQA+mDiNikpGMk/XiOTnIfBUY+D?=
 =?us-ascii?Q?c63iydr4j+U2ZSxGKvpEfTw+yjikXrbn3yehmZArnGdd5Kj8rfpQyV5R/5KS?=
 =?us-ascii?Q?C6mcDqOQeVb9kt8JORafeXblwBmoUNGX/fcljbmcGN0eW+HmLbzKKOFuB8Jr?=
 =?us-ascii?Q?xpvB4PZ5BKmZURMdYTdSzK+FBmjTwFhqB1sah3/kFaULMeYB56yeO+csfslC?=
 =?us-ascii?Q?n3amwIDs8jpNQB6fEdWy7ICuzwwQb+KSnPIjcaihS3p6lAhUvgrYweqIB0oJ?=
 =?us-ascii?Q?19H5amLfRpdVDy2zk2b4G1e2UsxZ14wg2WIf+0C+TAfDGrSnKexigakpdLtO?=
 =?us-ascii?Q?V3rnTmgY5AnSy3ROXRq5GZvEhyWIhL0LlhvPkCu+COXE4hXYefJcQU7j7T0X?=
 =?us-ascii?Q?fPfJ1Jh9EqHzQBsotoU1ok+wxNH+M1174SILChBEnEQGEI5Ucm9JUGYjmlRH?=
 =?us-ascii?Q?rFCSGaKMBB1NQmety6QB3DFYID+QSre2Vnjvg2upmeOuKESkVLXD/101A8Rp?=
 =?us-ascii?Q?N5NJFjg62f34oQoykwhNMrjT2Onp9MWsl6QtQPSFUrXZ3RnEiWN5TU9sxBMH?=
 =?us-ascii?Q?ZAcRX8TzTy7Bh8o5BweaUtF0SXkRBt3ODmMbLNRBhkO5vMwHqgL6HALNNW8G?=
 =?us-ascii?Q?jG9WBQJvfPbOggk3fstf2AA0YloJ0wtqgMGrBKHj7ZQC00kwBGvsGtjwxSoT?=
 =?us-ascii?Q?0AmvLZzNq0uYTGjCSM08SiE/brgowVkVpY18oYM67rwXYwa3f5y70F70BLKr?=
 =?us-ascii?Q?TRRkacmAfKJpC/RKkXx8vAFzFIhst/FlygRbDVamiqtWdJALGVY7rxJ7siZZ?=
 =?us-ascii?Q?HmslASItjbUtmSOGZnC54GY0UeEV6btgRkSpi6kArDxB56+HmKJZ0rFLt3mk?=
 =?us-ascii?Q?tUQ8OIb0VhTSl6ooFpKKtU9aoB0LDEQCdcnjZxbuZO2LiaOj2Fa1UZ+ijN3K?=
 =?us-ascii?Q?cmOmYbrNdhB6n4jHP9W7vGTkdjPl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+uwSSaet8HanZmKK2fMJRWQu733fHAmSbw1XN2J/A3E/FcJ1f4Mf+zVWL83K?=
 =?us-ascii?Q?DAtWNJ8fZyi1YbPLb+P1GmjE9iLEsEhliJIVLlCTv8a57Vn9ZPtIby2RDLT4?=
 =?us-ascii?Q?51nnedEm3bufPZMwbZ381sPJGxaYC8595SQfJCvlqZ4SnvJt+ue0Yof2Y/sN?=
 =?us-ascii?Q?X1EJW8sUbGwmoWWmjKMPzW+zwzYsjw2nungnfe8RuQq0cksYfyIopj9hspA5?=
 =?us-ascii?Q?Tx2H312isZK40vBb4t5MNx6Pk5+47BPsBZTBAhIRzLNsHAlYx99cVXkm4ve8?=
 =?us-ascii?Q?fLYeyONe2sSe8Wmw3f9vkxcYeg+ZFuie9XLBcUmcZL5NEI21vZmd8L1v0WLa?=
 =?us-ascii?Q?zW6HXFOvuxIFoIHeCthNHD8GFw8/0I4S2qJmKUYHjOfUPXfshhVG4606g7UZ?=
 =?us-ascii?Q?EhGXM6b+2/bCurUwAC/W3Rlg9ggYzhkLE/RKaZ65xnP1OloGnNcIVFwIT9KJ?=
 =?us-ascii?Q?Pn6gyva/7sSU9YSPPb5Ruh4Su1SnZBMXNdifaHAh1F69CIYTMnTa2GzuqdcL?=
 =?us-ascii?Q?cZ6ExRQ8W0jB1T6OxvUN3B7OxMGnTXBoQ+ipk4vLVnUAYWT8VGcSg9JheMVy?=
 =?us-ascii?Q?CT0uPnnorLg1c55CnXb6vO+u3Xj8sAU1RSeoICGQ/WeVRFjZ4OILHm12aCov?=
 =?us-ascii?Q?jOrozF6l5bhyv6IYB9tNg9QcA5/gB3NJEFDeWQwGHaZJ9Ls7rM/oPB5hKjEa?=
 =?us-ascii?Q?P29EXxFJWBR09NSNhgnlZZp6LEu5mBLrPxeFR3hbQuylhF0loosuPo5WW4R6?=
 =?us-ascii?Q?E0pK4LsrqSskAFLeCDQRmEIYs/XlG7wNZHUBywRvVjztDUBH6gVDA5/au0xE?=
 =?us-ascii?Q?hEtcKTNA0zIU7exWS78lNL0zK3i3ABX5qMkR67HAU37K6ChXk2m+lrbCP+xO?=
 =?us-ascii?Q?RnZg/Zqjw2fE+nUyJdr9KS5Yhrp/nhIRrQ7YSqD6rq4+R+lQYn96GESUCiY0?=
 =?us-ascii?Q?63aA0V1UTgdVwDVQfFyx7t46tdKJlpiZb7ksYnG08lm+YK16mDjmQOWD7ZM8?=
 =?us-ascii?Q?E2pSV5Qvi8lPieZLvSbH53kxV2s+yBxgXQs5UJ2ejEf5m6IzFQWI8GX9tSL9?=
 =?us-ascii?Q?pKzNcAjtcF2QTECm6tWIi9+42UwU/k8tZWIv8MHwhKZhRbTpqk3bcnrSqa5I?=
 =?us-ascii?Q?F7uf+HhgN84zddcTrmTMIOOXBiun7SwpaNbYL+DIjwl4en/3g6Bs2Wa6kIF8?=
 =?us-ascii?Q?tjSKxbqQYZ2hSDG6SL2TpzVL8Z1PNNdyB9Vma9uSnglK6h12BZffUjYYikyZ?=
 =?us-ascii?Q?/fxqHZ16buFTp+HWIy2VoNfTm7+s38InVeOfKJN5Ae/A8haLutdASLHQlSsk?=
 =?us-ascii?Q?GFW4Vjoxb7AwDWGyvhUzGv/t76qmyoGHJstBgGlgEP1qdnvn3XrG+Fb/bNKk?=
 =?us-ascii?Q?HSDTQ1DQZL2ZSKpKN/x9Gfwym4qpI9td+Cz61EwzGK/KIKIsIU3YN4nsqbE2?=
 =?us-ascii?Q?qkB5ajBv75lkhUxr1/vCB2VhpR+HM7VIKzNHv5caOfqmqY5jKgEAm8oRAxO+?=
 =?us-ascii?Q?Hp4fTTpXzzC9TrW0/qNaJaC3sW5Oqk3ARcX1hEdF3N4uJD8A1EqYK7KCZEk2?=
 =?us-ascii?Q?y4DzOBTqzX2pGH6sDmeAjMMdl90UrA71jBPC/X56?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d107ca77-4ac1-43a0-e0f3-08dd39832850
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 18:49:23.8017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sE5sTHGWCUhXqzP9qWBGNdfvj3vO4Gcao/2bAV7CQyFwmsz/aJEiFgKhOxyhLwG+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273

On Sun, Jan 19, 2025 at 10:21:41AM +0200, Leon Romanovsky wrote:
 
> Fixes: 5256edcb98a1 ("RDMA/mlx5: Rework implicit ODP destroy")

Cc: stable

Fixes a user triggerable oops
> -	if (!refcount_inc_not_zero(&imr->mmkey.usecount))
> +	xa_lock(&imr->implicit_children);
> +	if (__xa_cmpxchg(&imr->implicit_children, idx, mr, NULL, GFP_KERNEL) !=
> +	    mr) {
> +		xa_unlock(&imr->implicit_children);
>  		return;
> +	}
>  
> -	xa_erase(&imr->implicit_children, idx);
>  	if (MLX5_CAP_ODP(mr_to_mdev(mr)->mdev, mem_page_fault))
> -		xa_erase(&mr_to_mdev(mr)->odp_mkeys,
> -			 mlx5_base_mkey(mr->mmkey.key));
> +		__xa_erase(&mr_to_mdev(mr)->odp_mkeys,
> +			   mlx5_base_mkey(mr->mmkey.key));
> +	xa_unlock(&imr->implicit_children);
> +
> +	if (!refcount_inc_not_zero(&imr->mmkey.usecount))
> +		return;

It seems the refcount must be done first:

	/*
	 * If userspace is racing freeing the parent implicit ODP MR
	 * then we can loose the race with parent destruction. In this
	 * case mlx5_ib_free_odp_mr() will free everything in the
	 * implicit_children xarray so NOP is fine. This child MR
	 * cannot be destroyed here because we are under its umem_mutex.
	 */
	if (!refcount_inc_not_zero(&imr->mmkey.usecount))
		return;

What we must not do is remove something from the xarray and then fail
to free it.

Jason

