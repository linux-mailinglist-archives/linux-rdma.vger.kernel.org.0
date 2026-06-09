Return-Path: <linux-rdma+bounces-22029-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yvx+IcxjKGq1DAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22029-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 21:04:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD1663814
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 21:04:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Jl8veBTw;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22029-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22029-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1689E3021628
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 19:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E2B4C954B;
	Tue,  9 Jun 2026 19:01:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359844C0427;
	Tue,  9 Jun 2026 19:01:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031688; cv=fail; b=hS95EW1cOyU9eOAKsrA/7VtUbVSMQ4nEeTP4qnXXYMz7nDcVvzl4JesQKa+WauDyPBAk0STztiMimfG1vwotWeGiaBvda67kSlR9StQrUsItGxu2jUo+s55fh4v7zs3dbnqbcm+rIiaSs+7Rt5NPts/OV4jLamu9VOrjhFWknZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031688; c=relaxed/simple;
	bh=U02hl7PWT6EXTA+7o8eAC6ED8aj1UUUf0HDQJxXgbcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M3MrYaHR4014Dx+9IehOblVStGuhZy/Qw7Gn55/gd9xIfcvnQwRaRGZs9f25wHMMpyPAQbVDM8xMYKzlen3W0WZ7s0QL4kM7kjQZkmK8qM6VZpSWkMOuG1hEnlXsJeKZbHpcOUFTIqZsElMVaeSduTjguPt61cNkarTE/00f2nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jl8veBTw; arc=fail smtp.client-ip=40.107.208.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X47jaZiGqY60y6AV07LhYtvqCZJBO0u0byzrcbEjfUJ+Ad/6AwSoRxv/L3cfpWEXAQCdVLWe8O9dbNEqUPV+08hSxF7JyKHEmevJaNVaqS/WDfry+LtBIHCZKsT0FovHcqxQcMIThMTbcvAH7J5hSgZ8AtxKbxncObWrM9tZQ9CiUKS78qQmhvEUV1N0nNlRAnok+br1KBukB/M+iHnS0lUIKY0AOytbLgPvwddq6Gp2hha6dt+4KqcGOjsHRyjBGDownrC3mpcKxAAjEnN7h61D9ltow8GzWg3azxawxOElb1gheDk+fv7wgnw9If1nWRugF69JLZzP9bF9+oKP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH/EUyz0DmFg8Nqkb59n1L1xP10OY/7YvtZKBNAT83E=;
 b=yVW+6aCQcIcyXIgWLg0z6wE1u0iOgQr6iNlF89Catokq+9j8PFmx+3SiAOdMVWTxeuDLmzk0IxfQIytrKnM4R14xA/WOssJn66GE3JeIOxz2pS2JSdS/gjdlj/CAmYPBuw/iCNQujEaO5HreZtCIHdNzpMNZ6VqmOyKoxJvvsV9pckvc39rgSk+xfan5YOm21DhHVXPVVNd1Sqpy7tWjc5WtgqvF5p7A1rL+LCpKuZHy45nkXZTKQu7TvpEQ1J+WJW6Xl4h/2PxwfRhAmruuqm3X537HTgthTcwWqszB3wh/sLDkv7j0RvE8tGmTDWyEpGWJgbtmL3kFv1M7CFbVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH/EUyz0DmFg8Nqkb59n1L1xP10OY/7YvtZKBNAT83E=;
 b=Jl8veBTwWyc0vz5sPpyzIoHFL9aJQKzxkY+ywMRw89U5ETSZUd+j2g0uJ85rzqovinDPgleWhPXKtkyiudN5XqQ4+mzRDka74N+Ynlr/v4ZUkmn5dPz8S5vdzCUArFV+5i+MsVXrlMc1xyQObfbu/5OgrF7raZQO9XpBXSiyIPoEZNGgLfAo7YuOWLh2jXm7WrEd9dPBIKk84Fp1iLKHC4RYRprN8CJM2Mn961G5zwocJd31luRPN8RffJ0CSYsAt/JUMYESVPBFjmuJdEBbF133KCfkw19hU77fTKJ4gOyY4nqwfArOnv6W3M27reUSSoA+t4X+GQYt9SCTxaTw3A==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ5PPFFA661D690.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 19:01:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.011; Tue, 9 Jun 2026
 19:01:18 +0000
Date: Tue, 9 Jun 2026 16:01:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH next] drivers/infiniband/hw/mlx5/data_direct: Use
 strscpy() to copy strings into arrays
Message-ID: <20260609190116.GD584729@nvidia.com>
References: <20260608095500.2567-2-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608095500.2567-2-david.laight.linux@gmail.com>
X-ClientProxiedBy: BN9P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ5PPFFA661D690:EE_
X-MS-Office365-Filtering-Correlation-Id: a720e9d9-ccd3-48d9-a11b-08dec6597ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pA2gAXzBUVrAtEVgkF1Fr+0XuuFffLR8zsy18DY4W6MSDH+kI62kc6Ep8s2kMtcpgJwxhh5A5DE5MLHxtm6Y8o9M2vboeDOq7vr8gU/GKvu3UTxmwTSIILpuXUUfQkfNm3WLtQ/bCuE2sP3P7toYs5B4BGdxtXuw3lYidikoASjDLE9XNqg5INS+zFE1MfZxOjkab1k4oL1KBEbSp+jjI41HDMtZfyFdHk3F0tvA+sF0TjvM0orz4u44Y8H8bxpTy1YLZ943ZmTKTMgXydWJ8umgMqLsjJG7jrrTDLAyTUzeiqdeB/oElVVNcjnufRJKH4pkjFSoHbBScWOmB964X4W2z507CfqfgpbVMEg7Zf/55EZwcpI0xJEML4fCApn1o8Nq9xz8q5sPn3Kk/kKl1xaM4lMOUYdzeo6myYZ0WnWxZUKf+MJGBVOQOhyj9zHsUQCFkVNkJuwGPTdF1CDHhuuJVjvCkAiTNYjVqkCsxAvng0wGubbjXIHjmJq1czR/Mi6mUFjdVUaieIk4aP69eg5ts13iNPKuVyYoOppGbTKUG8ToatnIJXna9sliLQkLOJPGloy2/j7ZB6VvF3clTZTHznYUlGHctWs/ueNCXpxdzndi66ZSk7yw43oUf7C9yP9XSI8YG4luvuDn9P2aR6wuDXVBcQhzMOYKgvL4gdMaaymwu1Z2Soe9/4PYfSsj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0iz9aQ9ONTi1GN2wLtrg9R1uXgXUTYjgmlI1G7VIKUb6pUzH3YYiyNEwqY5g?=
 =?us-ascii?Q?6ehrSwGxbI6YNW+0U44aIxvIfDHIdrpUHl+zTRyAy7URkFg2XhpY1lSw923y?=
 =?us-ascii?Q?QJ0mXaAgTtHI85f27BdXpfbcATiYoWqvmvtHPFuiz63BHtn/A6A4JNnRbpPv?=
 =?us-ascii?Q?tv8UJcA6AstwhKd+qrRub7QTlKdAFL43ZJfP1z4C2LFNU98brjYM/lFUDviC?=
 =?us-ascii?Q?wQ/lGt271mlFVeDao/FpUTn0HQpnUCDzTvzr2378ddCR1tn+7Eu4+KADNoRS?=
 =?us-ascii?Q?ugIw3MCMcZu7lr1tyOE9Wwz116Fx0/1XyuMViDaYxPOkbt5W5+axgbgDlNPd?=
 =?us-ascii?Q?DucB+8sjrFcjm5fw1hpPNLunvo42dygJ5Hft8w850RenAmR90Zvf5OQAv4kS?=
 =?us-ascii?Q?s3itB1XZw1H+qcGJ91iB2To8mQJJpirhBzWSutvmKtIX1mJyhFGVpoW9be86?=
 =?us-ascii?Q?AkVMLS3m+RYb2tZ3Ud6vMFsudgH3l+QQfKbUYrq9s5M0kc5VBBU73Mn22NDf?=
 =?us-ascii?Q?f/g9L2Gw4GJJfdys0A5kG/gTVhgB4h9lBCj3xyVh1PhlkjhC++fqjDSokP0g?=
 =?us-ascii?Q?E6JHG8axmfHeRxvrY7aQZnmmd9jaYxteAKzC5duILKPVJR6OSROpJ0kgFw7r?=
 =?us-ascii?Q?FMs+cILRMtqoHR2SrH1f2v8hO9w+j/U8Qzep9CpXmopomhu2VYV0LiFAbFfd?=
 =?us-ascii?Q?8zCliXkbHHkmO7F7bM7XnvarMilehdxOJ3RCAlwRIJnb0DtN7A2Jv3dj8pbn?=
 =?us-ascii?Q?cMAdBmEwXZ7CrBcmLsQREeEEdmJRSpPuCovVqzn89bJ0Kr+ARvacHWyWgHRe?=
 =?us-ascii?Q?6Eiw+PoiF6GCRoy4Qlorsm9f7b7UItxWF74unWiWQerPgT4LaDtP/MTsIeLy?=
 =?us-ascii?Q?fut7rvsS45oj2xlPLSFv/SfysJaHQErIIhGYJ7uSpiceZnLTWtgWhO+AX6ls?=
 =?us-ascii?Q?5+GURsgXDCONj03euwtuLSklNWKC3vLROHqH7EM5rwsWYtFMk0fybAxcw+rE?=
 =?us-ascii?Q?xgETxA0mjE6zCe5TOV8IDVUEniHxyL5yOiWWtEOGiEeSPrCPhNxb82obbVFW?=
 =?us-ascii?Q?VftiY9AyBtW3rq0XgUE/x1Gz3XKC5nu6gYfXod9aqlS5ugc5ji0SRGHqLI5Z?=
 =?us-ascii?Q?zxKgsrT57Stk/5GhXlnsNj5FWOpgG3/dRlEVUy0b6R9XHZC/5TB3tcKgg4QA?=
 =?us-ascii?Q?qe58SWSANHPzPH7nNilUt213aZ9X1/Pw2Ip1QOmqnPdKUUZMerKwsAlZGsFF?=
 =?us-ascii?Q?zMcUcT61ZtT6akrieh1I+duIdcIWew74Z1I9KFV82O8ATAPKtZzOpb3qyhjv?=
 =?us-ascii?Q?4rqSIRJ2aFUCj8whkM+1q2W/PhiFRey4HFDOOqjbzyHlkwk3GAhlmUgMlZ4X?=
 =?us-ascii?Q?frluGBDNHqrqX9bbsKxQ5MWE5Cxoinyesoei/4ob+z+/T+GYCJtZEfyvY+3f?=
 =?us-ascii?Q?KbaX0Pxjp4ZBk8xyowE6mRibDUkiswTu1idfvXKoetkD0A19rzsCVEYJHNnB?=
 =?us-ascii?Q?wPuzCPBPiR++F+njnzrqlTwgkGtg8AZZibOT3pEQPovsl6IIWlebRsgIFBCz?=
 =?us-ascii?Q?3bwIWg6W2g9HdUPw0b6wAROXReW+t9cHmX3teXrByEmxKlTVYfW+5zSw73L3?=
 =?us-ascii?Q?aXyRSFUe8f/yJvP194OvWcFQCcivLDQ/3p/T/Mpo1yxvDXYDUh2NsiMOu07n?=
 =?us-ascii?Q?hdlsD0nt1phV+wCzjkA+xTb/hIkX5+2rqw6zZBxYZ4zvDo0p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a720e9d9-ccd3-48d9-a11b-08dec6597ca1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 19:01:18.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIMWeiEvHC8Ps/faT9HAk997SyEeI6mr3i5T0qW6AZePy7vlcQjJrpbjGhL3u9T9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFFA661D690
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22029-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:arnd@kernel.org,m:leon@kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83FD1663814

On Mon, Jun 08, 2026 at 10:54:57AM +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Replacing strcpy() with strscpy() ensures that overflow of the target
> buffer cannot happen.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  drivers/infiniband/hw/mlx5/data_direct.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next

Thanks
Jason

