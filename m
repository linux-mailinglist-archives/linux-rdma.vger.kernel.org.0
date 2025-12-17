Return-Path: <linux-rdma+bounces-15058-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B998CC9B8E
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 23:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 903A530336BA
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 22:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C1F3126DA;
	Wed, 17 Dec 2025 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ErObLHYl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1F3101B5
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010989; cv=fail; b=PQB0SAofSmYTf7lzMht5lDdxvkrKdyrEN3A96eX5jGnpTkxu9qqcJ2Cik63EFC8tuW9Y81/f+ZtqrHnkNYbTdt30+Gbx4MpAoF5iIZoZIdJ0/I5yc2M43a0DVmWNdL+8xM3O8nm8sz4321Gh8fGgKZIEby6/jaBsbo0djNWQxLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010989; c=relaxed/simple;
	bh=5rNZjhYacG6BZe3nlSDt2WkjacPI2Nj7YfVUezejV7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M2kIT2vrbHbdBIwWC+7biOup9jqbesBYi5Lo5i9jJl8wnDq2vC8d6zfQzIz5Kj1uS3wBEV2Wv9gQeKeMAPKYSXCNRXnvLD5bnSmyb7bNEzvcvtsRI9elfnDT5E8VjqZHL7c3zOPP/U4x9Ta33mS6kWVoeX0v4IGMc8RbU47jNw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ErObLHYl; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lxny+P4Jw8xH0gKRsnMNdKvsX6/9Z2hUSuwbyWiecDjpSZDt4aYMP/sWTtN52kOkLmPKwWKwXEWOsjJS1AJWdTsC/ubg+cTA7Ag6jyV9n82loQez8GcAyhmAiNT77aaUAt6zOmy5DWHVrsaMFcMyG0b/em1G6gJjAHCL4nMgHd/Xd61N8zszQlDL/x0SgqYefoEemXhsgd20d6FHTY/id4FYNIdDlLYQFjyRsybr/fFlxhq+VZNd7dnQQxi/EJZWjVA/sy/LMXg9AaaAag4cAWtF8UHCfnIuWELagPB6gUiI/4d+KeId2I6I4vQ26d9JM/LITkB23Kuh9DbZiecyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRuVpfCZIjsvQHb/3XNWlG6N2kIhu1tySSwppwY1ZEk=;
 b=S6HlYcL9onFWvMz5QAkDilS1f3X9Jq6umhHNcoQ6H1SyDEoEB3o4qZrVOKpNEvNCt1HyMHX+0F/Y1a7pMuqV16oIGDrB1hLnfU4c68xY+BS5AEno3zSBdyJGABFmli36kS3urwD3jn02zoxpiLj07yQWZadetJvbwyu3NGok82ReiXanWd5TgGXIawVsmVgglObnX6VmorEUBaawhoobC8YnpXTRdSJSKaN4eL9duJ/J8QK869Ai7MGbhStfCxvVTeCH34oyjW0CnG/mxwksdx6b91TcKMjhIWmgIf2BmumzzDuR84c1fUUioUy46nZyyS9VeRCLJmAiY8btmF2m3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRuVpfCZIjsvQHb/3XNWlG6N2kIhu1tySSwppwY1ZEk=;
 b=ErObLHYltQ9375BgSzAcinbhDk3XZIzNEa26V1LLVeKz+QGkogmeaTZIZMo8BOZ+IJjmgcUuvUBUvkk7zqNc9SYde+t9KXSd98EfESfNFIxFBhZlHJb9nEPckjY6fvEGI6X5ZnTKwSEsIWP9BYCZnleX9IOzwncEYeKHzQgJYnRYbFex58rWqENRldamK6Qv8OGc1uemLpPSM8K+gS/q/OiCDKRh7nwzsLnM3orAr87faLsnKk3bU+K4Y6YicVYPs1NCmFyhktnokw8cJBtfGKS3fzs4xwKaY7gj21GcK/JQh+R/cvEtAuGF7aiFC6htJmYml/0MfXKayAoG5vFXAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 22:36:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 22:36:24 +0000
Date: Wed, 17 Dec 2025 18:36:23 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v5 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20251217223623.GD243690@nvidia.com>
References: <20251129165441.75274-1-sriharsha.basavapatna@broadcom.com>
 <20251129165441.75274-5-sriharsha.basavapatna@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129165441.75274-5-sriharsha.basavapatna@broadcom.com>
X-ClientProxiedBy: BLAPR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:208:32e::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d4a93f-49b4-4ffa-7a49-08de3dbcb5ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vfpMJjBlxPvMMYIJeGlzc+/2DEQGDD/RTZ7fxYoB04W3NMNtrOnMpae7qGKX?=
 =?us-ascii?Q?IWCS/18+9JItj3+3RjPQXBLXYulGnJxyNuLtrjlef103LQgzkEwlwlLH9zig?=
 =?us-ascii?Q?Hzqc+3SFHSUIehyqEhoMZuAPemB5PKljrrUZohLlSHklPmn584c8LXHY0mRy?=
 =?us-ascii?Q?OZNhBtV+6u7+YzSmYoV3Zo3I1129qiXPcnVxw9RVHygER1p+MvfJFoyXNuTK?=
 =?us-ascii?Q?/KkMq0E9Gy4svW5BLzZH9o05lclbTPSz8lkPOb7/4LJeIvAtP0FgbxkU9Biu?=
 =?us-ascii?Q?N8A5Oz7lKdqvea2p3QE1nmB/a03wWlaQgz9beXo75DUyGM+ZIMlQSgU1WlPl?=
 =?us-ascii?Q?YNN1VpL8cok2L3KFSY2ynAACRHBr8Dg9jPGcjpsGn/h6s+YtSSQXWgaeJm0j?=
 =?us-ascii?Q?lFhm1bfDAmyLz+6j03dIvet/MOu8WkEpAtHZ0Odh5WCOIMbpJkveGb7aVSGQ?=
 =?us-ascii?Q?7YJ5IPPPiQ42k8ey9SKIiFmKW4y54Zkwnw7vSUBopFpL0LHVy4iEqilaStl3?=
 =?us-ascii?Q?UywtsQ6AklvSkogqqHofJQSaZrRbtIIVhJRNgblo+9A+ZGkEZ8iVRxEahcZJ?=
 =?us-ascii?Q?oNdkcH2PLAkBk8/FCCPtZ7p0KpZWck2ImfrxguHpPfXr4rVrQhLON3w6r0r2?=
 =?us-ascii?Q?pNuTLQ+xObt3eY3ogl2wX/vRTdWydXJMZ2j5rum0DOFMzCJnIXTn0LpzStz9?=
 =?us-ascii?Q?oNyuFsP4+1lD/W2Vv18GAxfqGvWD/5CxNJKmR7te7oLSG6A0HRdDocSisVzv?=
 =?us-ascii?Q?zQ7QN6vX9Iq0cb/O6P+fwcZX1t63e7c4xA5iRKMYjTsRMsD8TVkyTlFt+fo0?=
 =?us-ascii?Q?rqNS4Np23ITB5yAOP6P7ivM69EZ8GgPW3wsajaNqdfM+R5nY0PkFAKuM1R8B?=
 =?us-ascii?Q?uYAlHYFqYx/seKBgb2oO6fM4Dy+HDe+IabSYFnSNumoaor6JxXmrxBuWccNF?=
 =?us-ascii?Q?uFZi8AePghgIBZlLeUpYvwCcEuX2O9z8SVBSwf9LIw8giWiQ2Rxg/3AXUF2z?=
 =?us-ascii?Q?ltqqezXJmDUNrKXkBWfGGsnjdWKJucmSkWDphZsYEzcEmXUdR0WM+WElwIQk?=
 =?us-ascii?Q?K9VyYIFBzwyMCW+MiQEtNl7UO1ljoLE9AXNWLF0TRirohRjfhYhqK0JjEG5p?=
 =?us-ascii?Q?dGtVzAHQ11N6qrg1fdsRYrBphbs3sxDJoW5lt2wN0CbuQnFL4CruMlX76T7j?=
 =?us-ascii?Q?guGcHcOWTqmb4RHktLQDtnjXJa7fHfv5pqxDJ/ol7TYDjFf9upM876R0Y1Ff?=
 =?us-ascii?Q?ow4MMgcDvDjyUwNMl91+gLLjQO8lqMd5Cqf9aOmGv2b3qE7JMFt9S027Joye?=
 =?us-ascii?Q?wKonGI28VX1AV0N7vXT46Ku/9xPfjvEjl0sXxC8jiXyh0W62vr7dVSYgKl0s?=
 =?us-ascii?Q?foS1wxmDJX0ts0HFsdzMoaLZXQXZ7/gxMHS/cKwqBNV8Bv1rfJCm5jTMyr/M?=
 =?us-ascii?Q?2iYHkhmDwVG5muPjbVAcmsK8GkUNd4lL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w1R43wqr40ehHmtiYx739avFafa7miooYO/f0y4G1EPBYUltzvSWB6XYhFs0?=
 =?us-ascii?Q?CChIxQZ7pN6RjXfHrCPowlzKZGNRBmH9rq7EVOev1Q6hLFSx8b7v4x7ezTHv?=
 =?us-ascii?Q?Y9B/l+QfH3F8HMV0k5VVfBQxNSx0osPMiEYugqZbH76rg6O/eXJtMBtZAFbb?=
 =?us-ascii?Q?aCRNON2G0g1hSQFLjEhBkiulCvogDB9kCvSZLPW7vZyW90ScGFxRBdHYdFxo?=
 =?us-ascii?Q?XxTinpWGIMmNHjZ4rj4y7u4o6dXnQ6CL2QeWUIe9gkJWaCXMCNBvEE9GUCJG?=
 =?us-ascii?Q?kJtZeArj1b+0/TIZbMpOpCXTODZR+uT/6nC/X+TVSOsqPvX+FCo3vb37hev0?=
 =?us-ascii?Q?loGXH4BlSXda3UvV8tNh/qVm9NdtvbEWufn7jCy3qUTkzsjqZpToyobGjw2r?=
 =?us-ascii?Q?SiDgwf6akpLQWIBaFaPddUZnft+iaUtW7VszGmiQ680NuJ0yK4aoDfjlsyBI?=
 =?us-ascii?Q?yIY6rmHXvj+rM6D7gQg6YXOIkh/7GTa+8fSxBtp0/IOxRadQutuLyrJvL5ox?=
 =?us-ascii?Q?NUD6yqJzTpRWEu13cAaI9J/6VpdOios5oJ92seJQNvoOSgpHFtvt9n6g95Bk?=
 =?us-ascii?Q?7koudFLugxhMzr/TUkf8WSwR+62Nyb0SYXTeP7mj3nF5h/GcAEhTmF3Dpv51?=
 =?us-ascii?Q?k+oqTXi0x/5d6UcxOWJKyo3W/uvKAK6uMZb38ePbtO71oS0zB/DbbifIIxfr?=
 =?us-ascii?Q?fI74Rhl3C7abPxlVjKVdoZ/cjgW2bC/PaBoZCxyZesA7CNCV2QZM53l8D6h7?=
 =?us-ascii?Q?KlO3RqgqyuoVKVy4GNORnotW8Ky82iP/dzzlNuMIRI4vwNpeEho/sx3yfS8d?=
 =?us-ascii?Q?oMupbPdakOYxf9TviFgbxGbuBUpzOUdN/XPoHqGcHSKqtLE3822cUhULi4J2?=
 =?us-ascii?Q?NGWGZLoAbBLPWmJHRnFISAavEPLmZxueHprCZBgZXJ94QSRwB5C/Uov/+KdP?=
 =?us-ascii?Q?vMtwxHKw0/rFkG6ayv1xyAr3q61mlQRYQ5U3sDeUqqa9/vxxR5yJeEkROMS2?=
 =?us-ascii?Q?wwe3K2gxfUqHEQFr46hiJilLn9yExuMnNWn+p5hPU5P+TH6NROjaEX845wnb?=
 =?us-ascii?Q?fTUiRcTNHmShzr/HVmagMwomQWWjds4ycBIYUyyyZSg/bI6HX8RNr9HXe3YE?=
 =?us-ascii?Q?x20Z+Yo88WcWH5ANncQU5560DUmaI4R4F0Pswl+5IFyUQjU4M8cN/72TJmlu?=
 =?us-ascii?Q?Hf5FeAQzXY+mqgfLOBBcPkZqXrcHIhOTdg4jKClVmS1ObiGzw9dtHpc1V7Kb?=
 =?us-ascii?Q?EtJjKZC4h2EfhX/kyYeGwhEVbtgR5Gxv2Rkt6AOt/5B5kC+dNoTIAasRafg4?=
 =?us-ascii?Q?R0Sugpl7o7aK0xpJMvpEuIO2Cuf5MvYicu/gXXKt9hj3X5sZl4kXGvkDY+6r?=
 =?us-ascii?Q?QtwXo0OY4bjCocMLdGyJzF2uAQJ/jFPlzQii3LrU0sUVYfOdtmahiJQ4JBzI?=
 =?us-ascii?Q?zJDC7AcK2TmWz508fezBU1OruadEzQvAp4zkNlpWny4PSD5hYEL8vyeC35Mf?=
 =?us-ascii?Q?JIsSun/bDpPQUxfKA4P8xfQdoYMA1V8LbvUlC75N5N8iivuAKxF8VyxcO/3i?=
 =?us-ascii?Q?DRpfi+tLQoz7O7LoPsM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d4a93f-49b4-4ffa-7a49-08de3dbcb5ae
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 22:36:24.6941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAlClNpnbXe+s6cswFuYrRPO/KA8LEek8cCzWMorFg6BkSojdJGjMJWuv12FX7i1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814

On Sat, Nov 29, 2025 at 10:24:41PM +0530, Sriharsha Basavapatna wrote:
> @@ -290,5 +295,4 @@ static inline int bnxt_re_read_context_allowed(struct bnxt_re_dev *rdev)
>  
>  #define BNXT_RE_HWRM_CMD_TIMEOUT(rdev)		\
>  		((rdev)->chip_ctx->hwrm_cmd_max_timeout * 1000)
> -
>  #endif

Stray hunk.

Jason

