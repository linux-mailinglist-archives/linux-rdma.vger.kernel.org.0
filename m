Return-Path: <linux-rdma+bounces-22027-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tsy1ISVkKGrGDAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22027-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 21:06:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D312D663844
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 21:06:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Cl4ho44K;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22027-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22027-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE8B8303A8FA
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 19:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E094968E0;
	Tue,  9 Jun 2026 19:00:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D56340298;
	Tue,  9 Jun 2026 19:00:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031647; cv=fail; b=aOUCJdWfMkCSrC7I1IcFYIXxmrsleilXOfJCmn6hcpNLnnu2rS342KB3+qfCK2x6e+0t0p5Ok+QSKRQT7vvTgZw3mGFGSsB0wskA0O2KPOfJWGtomKJqQpba6HMphHXV9iQyEeb68O8mGHb1NOAHOnf6glQz05OZyZXDGexKI58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031647; c=relaxed/simple;
	bh=wc6NNcpiiymHcC2Omr1GrrQA2iduhR2A8cwwMqFOXQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ISy5A2unqT4c9xG+fUHJyqKS+2JCnYEJvGZ8vtZVD6+WObXAPk3VzLNgxfDBQJZdGitPJEqxE2w02pSJuyYhztVZybxeB+Fx4ywWYabGSk/7bohEtyNk/lBae2QIYz9nVFbjdwtX5b1FTTygYE4vdOe/UPnQQC/MxPblxqJ0EKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cl4ho44K; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5AR2OCgijHnj8YLB6iJw4Q7fJed5RlzcW8WU1cJEA1XvA2zi6V3yb4yZxt+O6agvnf7lX6MzPA0dgsGqNLKGMD3F2+5WX2aQKabCcILoGHjRrxxYu3GHZ4pe0ScYY1sMFymXZVp3U5xcrkmsIJCdlM7J1tWBSN6LdOoP2BUM2d+MlV89O0lG/7k2ZRIpCPyL5rUC2vtBH379jUfJpV9JSt/PX48XnVfx6APF2CoKip4dVpYRzemrA4Obfr5+6sb3KU8Oec/kv5zk4zQOxTZrHOCqzJu5X4W00e9WC0LZc2nRwG91m9dT9Wl7FZW/XK/EkV7uzWgvSDMGVWJWiGSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xz22y3I770EZP3J/GSfxDMWl9RrsYYEDeQIg3WnfhR8=;
 b=UQa0PUUXzjBkNddnp7oVbT/vDi1PW1NnjoFI/ruh32P0ufaRnugtVnlwo4FPdKvYgIhTAOeYRl+nbQK4ix8MlKpCbF7juwXCi6elX7RKnaCaRYWPmBSPewaOtRJMgtCnmbsBTGwg9UYUiFlQIWnjdRFsyaPfFm1OdRsFoOjOFAH5aOfD9+KJn2cN9FVFrBu3DkyaeWKl6ccSVrme5YbojPLeDwjNjUW8aXGMtoYVko8Vt/8CMoeJzPN/Fjsvp0h60pgB1cI+uXms4cP16lff/khevLSC/G3lfPGgXR6tjSR2SE4eMIcP5Tkbr1Ib2DDlfbwtMqlJ7d9LKUr5cIruOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz22y3I770EZP3J/GSfxDMWl9RrsYYEDeQIg3WnfhR8=;
 b=Cl4ho44KRVUEOnmxHQPRDaGYPeuB9gWRi1wyj4As07u0sEyjuUNk9e/MiiAIziDp/XwQOUwGlvGZM7SVYur0vHYKIbyvbEDxKdn2L7PFaHWXZ8htKz5dHMrMD1wpahXQgTjVNZmOxMMV0CNHNt963qZpYzAT6oLz4z3/DNCKkP2u9px4ldmQKWIN2Veg/iMM0UXYm5AWyXXn88BBt4ogKdRfwhlfMx2ESudzBtpu4R0/CKwxKzOM4EW58aH9TDHKARPUaWsKEtmOz9jTNNTU67Rr0kxqWKqIJO6BK6QOZX2hXtaO+g/BJWNq+r7CrRaqOCViKGjzPnoo6s79eLwwOA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ5PPFFA661D690.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 19:00:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.011; Tue, 9 Jun 2026
 19:00:41 +0000
Date: Tue, 9 Jun 2026 16:00:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH next] drivers/infiniband/core/iwcm: User strscpy() to
 copy device name
Message-ID: <20260609190040.GB584729@nvidia.com>
References: <20260606202633.5018-10-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606202633.5018-10-david.laight.linux@gmail.com>
X-ClientProxiedBy: YT4PR01CA0420.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ5PPFFA661D690:EE_
X-MS-Office365-Filtering-Correlation-Id: 417a079e-4604-466e-6da7-08dec6596707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sqeayHqnEL6RCJWaNlS2Tn1ArwMDNL6D+8gK96APAyBlBavetvQiMTOFF4m/9RRAf6oyNPvlqaPd7QLWEvsHuhEnrxU2YsaHS5FWXTiiigN5fw+h9x/eektYoCVlNFLqgw4FdSiczd4KKEL27YrT2vw3xIhbjv/qWjYzyLZKnbRPGUk0zm3l9IUHMm5qAGrPcaWt0CzOsJ7CJOPAPRAzVFgkhtS0v3CWPppBu/Wy9vcJMfrMw3vSc1Bkil6hg1L21C/bgpbu7EEkhjz4GSfah5tVG8zz7omjusnaXoufq7ZBAQHPTXVAINvftlpiLs8QBMJG43fadhi7h3OjsOcwW7kLCKx685YgkItvz0AYBLzkSVSoE9O60mxr2ZQZBCQLIyOOGdKNwe5NzPbTV1xx6GouFekfsU+0AKwDVM45YtMR3Dzqz65ICYItFYNSqL4rEauaTsp6r8MSZZXk8rJzKhBp+RUcHlVKNCtApUoOZ4XLZ5O/BnYOOIE4AHr80ZwG9VGnfXrm5jw4EoSSsCYZTVEOEJcuTeh9IZbwsETj4WzYNbd7/tWgkbzzw8H5l7iZd0wQViO4xzRhuG2aYeEtH1plcWzD7Mga7scHTgZx59I/1qqz0qhOpSWdzY4dYIZ/8LxIWPwOrNlfgonCJdsYO4ejIqJDMdMTQMLvzQu/QHZFKgbmSGHEgnlWi/EAJPKH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A6xfTQRu5fVQFLzq4lAjezC9HP9EHdX3u8x6/zNqDHpGJkCjTVe4nwqxpkjD?=
 =?us-ascii?Q?A1XJSosyRbP4OHdb8Qf63rfnele/MbYXRXi6v+b0stOvOKMzQI4oZBqxco8Y?=
 =?us-ascii?Q?CrBX73to/IteRInONy8ARf17seSip3K6tFzhIyln69w+BL5E7WQoNfxFF4IB?=
 =?us-ascii?Q?lTEVtMliKobeHbD609ZRK765EyKxiGaezuQXrKL+9C6cmB+s8Q2VzOZYDbda?=
 =?us-ascii?Q?gMyQ0k80ZaLHfd3pdX1t1gEiZsbUJ8LCgXWDc/ZXZ6kOF1r9tw9yF67rgcM6?=
 =?us-ascii?Q?BDrN4LZLPY+bN2/Q7Xj57wavhjwRAvJtGs2SufpvqBzvYJ38DA53TOzCBdts?=
 =?us-ascii?Q?gPk8mwlFJeY3qbduOD6vxmIoyv0auzCD4xZ6wR0IoJVs76z/QTfm/uaNFOCB?=
 =?us-ascii?Q?obi1IwVri1hvpZQV7baZ/I4ZS2Pb8YVb0KQOoB64g2oha95HrqV6tlCh7owe?=
 =?us-ascii?Q?lsNxGLSR8mi0J88+mSuvfeqx0XMvq6wTKy2b6YuYai0MqFzIML8soEfLi1+o?=
 =?us-ascii?Q?hocxJrF8RTnOlhMMf1v8MJtCYcz2+aYhANOibafKyckvWbWl6gOzvEYk0tKM?=
 =?us-ascii?Q?kNuVZME8r4IxU+ZFB/8rpk+hIiUGVbbb792puLwAeoh6hMhPf7YDb1z8jiEO?=
 =?us-ascii?Q?zGiaUMZyWjEGjpEEHMMweLvV2szX359cLX0hZ7REQuri8ZbHl0lDrsM4tASZ?=
 =?us-ascii?Q?HKh4NUwp1HHfzokj40+E/9f9m3ZlkT2yDoQQqGUTWm3SYGHOXgdEfPDMqQJi?=
 =?us-ascii?Q?VqKbK94RxOHrHt+rDZjxA8A50kfdaAaBh2zD88vpRbYKreVGIhZTdqLq5UkS?=
 =?us-ascii?Q?FWnWsUjFTKSrqHBw9wAVWdXdE9xdqIul9mVnskzBEN0Y0eSokujZ9S0r3LEp?=
 =?us-ascii?Q?qX1gt8Aa9Pu3sMAkxCwEVDlWWziBnnUmTLSilc/rlbiwCjMvsgcImIIKztcx?=
 =?us-ascii?Q?wWfRvp7W9qc1SKLg/b7HMRIUzOxUA5iy43bOHYILG0zlxh0REWQI1A8oN2Vg?=
 =?us-ascii?Q?Co7A8ICEDJM/Iz09GIvZ+lN010wpSdS1nVlbQjdsFNvgn56kiNxlgtImTFMV?=
 =?us-ascii?Q?GARwvhG0lyEOTcMB0TUETBQZssvo8AWpPxDwtVajH86kJ2jyqJNb4SDu14ni?=
 =?us-ascii?Q?NP8VmJBr+s0NhoUaYp8Mhp255OWdBA9QlfpTQWkZZYU15gW/na910UhkpoWB?=
 =?us-ascii?Q?nYsJqTjWBbmx+K1KK7hzoF+ZXw0faos+Ynpra5UW9bd7gt114JX+7U8hb6D0?=
 =?us-ascii?Q?Z2ygI4Oa8D46qIUR0xWa+Z751L7MMk4Hlp3URQkXZD5GsenMoCujeWuPVyLh?=
 =?us-ascii?Q?OqlWNrCkHli6eGebNh/Ct5UGdiXfW42D/L6KpTcHsTX6Ttx810utodjFrZGj?=
 =?us-ascii?Q?jUxIP/H0yVGHfAbGMqP6rHUARf5MKXJNn9w3oxC3XDRBAgxYOO5WpcQhb6Gi?=
 =?us-ascii?Q?EuMVLVZKm0HvIKx75KZ4i9kk2CRwm0lBom0UTv5H8zmmLpJ4+xp+Jwr8Xtvp?=
 =?us-ascii?Q?uHKMvADpP9us+hRFSKAC7Qlk3XAFlub810bFiNto2YKj16xgmjJssNXeE0od?=
 =?us-ascii?Q?OZIUhQzF4/T7JSNwwTCcTTJJoDVxMr7YdKomamI3V90Ml5QLWncYlF56d8WX?=
 =?us-ascii?Q?C6k8oBE6b5fBwwdNKUIGQuRTjWy1hOoWXI8LAvXbT6sOKiroM7cOMaWKoJTm?=
 =?us-ascii?Q?wuFNdhB0WTL+1TxZvevHQlQG6ALAqSqZsJEl8v86Fgvubs2l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417a079e-4604-466e-6da7-08dec6596707
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 19:00:41.7697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m77CYSyfHtlBnbG/j7uuLW/v+0cF8rh9Q1p8u2Jl+cigagK1OaZBGb5Dx204mfZP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFFA661D690
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
	TAGGED_FROM(0.00)[bounces-22027-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:leon@kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D312D663844

On Sat, Jun 06, 2026 at 09:26:04PM +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  drivers/infiniband/core/iwcm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next

Thanks,
Jason

