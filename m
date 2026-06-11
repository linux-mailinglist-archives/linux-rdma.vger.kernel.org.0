Return-Path: <linux-rdma+bounces-22143-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B98HMG0KK2od1wMAu9opvQ
	(envelope-from <linux-rdma+bounces-22143-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 21:20:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACB9674B82
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 21:20:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=grrR52sa;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22143-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22143-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB1E431C93B4
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 19:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75AB348C66;
	Thu, 11 Jun 2026 19:20:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908BD2D73A6;
	Thu, 11 Jun 2026 19:20:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205602; cv=fail; b=Jd3Ub7GbYTFOXqBD9RJ5jL3pwhSu6DQo3bWYpfNPa3iSyoc13pei7JTAN1N5yLb2SK3f6xHPrs7iQ+kbGpaKp2dSawElek9O1M3T20M4HQaF0NNW13bWreARCOBxYeOTGQQ8v0J+ssnqPwFjM1m0+eDUhU5TL4BbplRhGYwXM2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205602; c=relaxed/simple;
	bh=+khXhWPzZ5emZWVEFJVZDHdDUOgVxiJ1qWU0ZXDC0j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gWyOZIExaLphO0yTeEXxogrUEO0w9x8Eq9ErW2Hw5Oh8lbAxLmGh3WhasYGpMZqBMSKvU2bsG1P8SQG6e3RH3oOLGFrw8CkzacCKHgslx8VDnbuXNEr6A8C7dpcZT7XdkxNeGgThLgoC0vSITmUhCnVu/j5cGX5OSxVcnJteLfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=grrR52sa; arc=fail smtp.client-ip=40.107.201.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzUIKCkF2MvL1gUDbeQVEbJQlmaAvTNjABRf1Mnpjx6CKXUEtJSxTOwtCL16pTTeT3OU5uErS6BuodENJ4HrwNPfZBTa1i0ziajugod4l6WBiP1kTI1OwZOBZdmAX7m0vqD30DLuyP7I5/hFkQ5qsyTbbNX8O1SLVG2PC+JPXogr6QUrHqMJlugq0A+KX2ls0GOUNTtYrdGmXKnBRAPMiZ1aSS1jSZg0BImJGcu59ZJOtVkeMdTK4rJbUhpnsS7Sy0q6fcA7uB4a3UJssPpwnieKBXBzlWWIk3AiH7lQ6JllZ/LI/PozF+QWaA/syA+GrqIuTtOx6RnMswwbw8Zwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VubOZ05yp+BQxJ1ZT8VHjsRWe7Z/d64hsqPOcAPmUdM=;
 b=CglJtX6zhHTqz9JID23MCFDO4MhW5N3ILG3rURtzOQlG2jiKML+IIbh+rOykZUKTlef3wswn1P8omESfbZj8ANHvJYHDoeKiySRW2S3KGc1PRLKUd4lC/xO0N/EQOEMdBzZKwDIhC+GbRic45ILjmZnmxYGxG5CRbQ6y0gy/7/CWamuMze/W1R5qlVOYy6sagKeG0CU4kDdWJJ1czfVIClEuhD9YRW2TqJWL7uhIAacqY8FjhmqyW6yOgKa2MgnLT5cyByZRHq+eoPeuXlNO7Psf2p/peMMX+/D5bC8LSIfUXt3hRMZCkqBUAzf6aN8pKUfdO125vP6g2TDonllZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VubOZ05yp+BQxJ1ZT8VHjsRWe7Z/d64hsqPOcAPmUdM=;
 b=grrR52sa8tD4gX7aq4upBHRD9+m8SGQO2/OqWNwfKmwJZ/+3LKawOJeIsHb0bS7X8qmvpKruOvS8R97XB/DTdE+jaqEpkmXjk3Qz+xRlHuYDdfBLnV61kmRY1FrOReN/kqnK/3LD+1W8z+itHxOKN8XbEoFzHnlbIWe2cYBSIaMVW1bA5C7ohnUo8FJJrqq777WGdoXZJe/+LYHKDFi0PsSxY3oB18L217KgsbqIVF5chPnd5Z8vnSUlctJ1z6ofDqvFzJ3mJCNIIJh1dc8XQPV2ybmKs/hE0Qd4HBdDylRO2SnObwhQ0OcjFReK3/9qauhD0qzmfPYBIQ0drfB9SA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 19:19:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 19:19:52 +0000
Date: Thu, 11 Jun 2026 16:19:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Roland Dreier <roland@purestorage.com>,
	Eli Cohen <eli@mellanox.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/mlx5: Fix undefined shift of user RQ
 WQE size
Message-ID: <20260611191951.GA1519234@nvidia.com>
References: <20260611-maher-sec-fixes-v1-0-cd8eb2542869@nvidia.com>
 <20260611-maher-sec-fixes-v1-1-cd8eb2542869@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-maher-sec-fixes-v1-1-cd8eb2542869@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f10d62f-4243-496e-7dbf-08dec7ee698d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Qq5DSnqQB0rezva55C335rJDLeowBadDVfXakjIBwmNLNMeAOzL3Z0BDQ4Xi6XcG2IdzgPUnkAjpElp9+xLma5NlZ8dnk3iG8NI6Vqzk3+89lQZMN21DKqbkGk4mjylq6tObYzvJGlzv467B6CQ5dcxmsCiBVOOezNNhgdd4azfw/rNtCuzhd1lmtdbn+PXv9dqBHYEl3MjtDIX0WrxhxSkv/qXofra6M3yhKhcLF0PvDVgJdF3eCFDw4cY+IvMo1dGA6dwVcya9uWG8Z3AUeTLg0yx9w/AwJtW7MjUqUQ2aMVd9K/lINe+h4dASQe77s98/9kAWzXHkONCFvpY9B4DZF7bnuMetZmfmQ0PVtTXSp0vUpr+0wHshfR7u5h1JxHxaBebR5bpFsoOb/D6dMVH9/pykdWZiAL7i+qUYMpyGwSzgLRsVkUPk1lftE5UM++7XINY63w6oSURH1AYrpfp2xil66pBPCQbYTa2Xb6nsGYu5GEpDj+Hc7mVKcOeFCIgXLpWS7yRC754TfiKzLLJQQ16lifdfvjSOArDC0ZS8458sJTdk+Y7SSkUyyT4xPpbJR43+Ee+f3Fxt6XyCYdURvig/Xef+Gi1eO1bTO6+fU0frA7o+r2OY6OMT3lyMyezUPGNxwDMFrejdNV97ScRCU0Id40b2QEQDKO5GBbOsu3EZ54gq8/H1RCKICV1R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fqYFOBjGVM9BW3vsiMK2m+a8oSBgs4thzRPE1NskXMdax5pV696jdXU9bqLD?=
 =?us-ascii?Q?iSNhW5tafnxz+UO+wTjCKWFeaW+bSj8AtR6vE6J0LVrHoCe5/FIlA5ZvRj13?=
 =?us-ascii?Q?xzmyNmRwqi7pQMZuv1nB20t5W83jEFtRAxXQGtrNCpXc5cv1vBMJ2G9KqfSS?=
 =?us-ascii?Q?y5Y6kF0r7E3x50D4qJBddQZwEP8X98HuBUTBKRdbNE0iTT9NUXPPYafStWme?=
 =?us-ascii?Q?RzGLOaELYHHiWxURVAtxE+5DEEy5lImEfO0qcbFaxQ+QjIS/WvRwwNovw5oG?=
 =?us-ascii?Q?+vDCSkCEefaVwL1y8dq7VCjifNMX8v5yqzneNhP/bbGrQoE881lwUV3klDZl?=
 =?us-ascii?Q?LbiPCYYyG5GxGqT9ZbG9XYmhYQys9BOxTPm2ws82TSp23L/Y94rEIWuReiFY?=
 =?us-ascii?Q?nXAKobvGh5JhGKGdQynAGB5eOyJ2UfaBIUbtqyIpz9vUtcmHJiyZNVdPtZI5?=
 =?us-ascii?Q?vZaUoUMKQHLyAdygLDinyRZ6nNHLgsyWN98whNt8GJ0sq2Kfp1FBNqz1D5n/?=
 =?us-ascii?Q?CqaREVz5aoW6821KhuuzsOUXDC97Crxy82xhE1qj+C9RtjSMysVkKSTc/DqO?=
 =?us-ascii?Q?PPYocT5ml9l1pUJIo4b5HoQfsEIJoEKwSFOmNobwmd5sv8BQypDLxViwJzmg?=
 =?us-ascii?Q?Ozf1TyfQgFIvz124Rcdm+7ISdXm9G21Ce6UxvTZntr8gfIWJQuXHUd73xRG7?=
 =?us-ascii?Q?YB0WfL/J1kDJtuNzi45pC+9LrXdkh/GPAsMMoB1SOzajore6NvialBc0LQky?=
 =?us-ascii?Q?lplVydmcABq4vwBBs22ChWnkExu66YbzrFwASryNiJq5LB04e+x8+ScrOMGI?=
 =?us-ascii?Q?xuODImgy9swcnKOjkDt2zdVefj+T38B8RUKmMC8mvJDnV3N1PfBBRcvIblrv?=
 =?us-ascii?Q?NIgj5BfghdtjyA7r3FXhlefzRcWZydkMWjblgP5sEwjFSSR6HZGGiUzen1P8?=
 =?us-ascii?Q?1n+UZXcTa4yXJyGSdGzoD3m3sudjnBNa6SOOZbjbfOq/krtGXSR7k4QhPCc5?=
 =?us-ascii?Q?npt42aKOF9vp+l7AV9wv5BSlgkq+d3B/cw/IUeZhXpT5AmqdEpQ8h1/E4toD?=
 =?us-ascii?Q?mFrwYG7oUKoh9+MY79Y+9ECEto7EPq27V+nY7JVmu59gXOTjKY+XJKjOmmfl?=
 =?us-ascii?Q?EpMazXRTPNlAcnaR7N8cjJd+Qy4C8mDysqQn0F26TtBoejCRvi2znWqFHFj/?=
 =?us-ascii?Q?OGxK+H9uIFwQ6+sEmvknkZRZlFLHCHl7gnHmk2FrxYg45W1DqdBulQoTVBwZ?=
 =?us-ascii?Q?sF4S9XTi0OuYXbxP+dpVS1TjudXB612t0tw7MuZ4aGfJN4EexxuV/CvTf9AR?=
 =?us-ascii?Q?/Zz/8iLRsOK1qvqrXVqwdaJtO6S0zJDmDKiVtsSSOzCaFZrNNHnNCIyMnVqN?=
 =?us-ascii?Q?Y39FhINa4+ItBdpDcjpHmrrZoTkX4O/ADedgeNh0RwW4LNb2ijtwcJVRzol1?=
 =?us-ascii?Q?WVMWxa5E7+iUJP2UC/S6CAl0eD0WtcqNf626Sa0ob30+z4q6Z+16CMZ197AH?=
 =?us-ascii?Q?uwKMELrh3aHX9YsYfwgJHn3N45pj6cb0kMBYwJub84szLV/KpVnozh/Bfy5C?=
 =?us-ascii?Q?JxSLNhrS8GhlW2M2g++ADWfFb01Ao1AApbAbTy3BrIjwRByeySqlcpk06M7M?=
 =?us-ascii?Q?ZksQ4LitprIEGEAiKNlo0VqgMG9QMejt5XJhCSof5AQhsuAWkZyOzHvtlOOL?=
 =?us-ascii?Q?Q6IvRsFq27+Dij/7saUptz2AZtfVDjnLjveaoNo8eQ7vj3yE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f10d62f-4243-496e-7dbf-08dec7ee698d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:19:52.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hnq3jb4juu6+bDuRPqnCRXppGo2Jfnm1L/OAUXXVRDLMA9RvVFN47qudM0i3oFb8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22143-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edwards@nvidia.com,m:leon@kernel.org,m:ogerlitz@mellanox.com,m:jackm@dev.mellanox.co.il,m:roland@purestorage.com,m:eli@mellanox.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:msanalla@nvidia.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1ACB9674B82

On Thu, Jun 11, 2026 at 03:50:42PM +0300, Edward Srouji wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> set_rq_size() computes the RQ WQE size as "1 << rq_wqe_shift" based on
> the user-provided rq_wqe_shift, which is only checked to be greater than
> 32, so shifts of 32 are still accepted. A shift of 31 also overflows a
> signed integer, leading to undefined behavior.
> 
> Use check_shl_overflow() to compute the RQ WQE size and reject any
> invalid values.
> 
> Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
> Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Applied just this one, please resend the other one

Thanks,
Jason

