Return-Path: <linux-rdma+bounces-22796-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o87qI6avS2oMYgEAu9opvQ
	(envelope-from <linux-rdma+bounces-22796-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 15:37:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF05B7115AA
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 15:37:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=mh14CfjX;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22796-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22796-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15E0630C5385
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 11:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20420422532;
	Mon,  6 Jul 2026 11:48:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B61E41DEE2;
	Mon,  6 Jul 2026 11:48:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338532; cv=fail; b=OaWfuB7W7cFtBG+kzSjkLBbxuvdZffTx5Cn5iTBivvpyEyvdf0PuDwPnawLsSlw27Jtu9UkokEGwfjzGZe4p4mxbw2omfKF8Ooqv5efjNwrom03t8XD3GbOLDh7Cxh+OAgvkUFjfk5lMZVAAYPbXilxQ/bYUcuh5eUY7TWM++1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338532; c=relaxed/simple;
	bh=ABzRG8TUzuMkUH582GBV3VtSHRB/XpX3awmdPQAXydw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rNy7032NmQ48V1/ohJ6emeDxinsvWu9zT2T9p2Qr9qk5Sr5mY+W22cQkyEOKia5uOd0LlSVlIkmefgrptigOmvxBrf2v33T8dgTu5nFMEutI+s/d00LnmEzf3e2FO1UpGeWXqeNqYxUckvEUTzEkto9cpTaLfzzpyq5+e3Fr5go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mh14CfjX; arc=fail smtp.client-ip=52.101.57.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m82OdOP6qgcOR6t6eC85ghfpE4KvY6bW6LU5VF8p293mbU+8ynctKc4uYQuh7x1NSgRuBqK7CKGBZnGFVcBGDtNktIDW1drMS4dCe53ZdI6Lkm5k+hUqRkhpeb2WjTnJKlhO8doCutjEqd7LEnh5wghrSni8iwawfBXmLKqv5AAn6m3z2x146QFvdsF5R5N7m1P+h8DVHH3/OLS6irMoyKX93jQeKFoDsIuhZqXFMliyt15kazu4ZzVIRyKUPwrfAcqV2hxe1aAuW7ILBMmTc19Mv/MbYch/RJpEwhZMMFCVL0owimec3ORYuT0vskBK+t664dAE7iQ/F5eYJhdM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kovUrn2/LwGyv2D7w+tzb3L2a4wEP+MG2Hn/jlksr0g=;
 b=wjIg46xw2OtL0jaeW0j40F+hzlgZPf6W1PDSlOyWlo5yzN1BgfEeuJqprmBofADeLpYLTlfHr3bjSZ7hCwRCICj3+ml36ThFE2E1TqU5hnUK+Ebc0O9JeUp1RZqJ7cMNz0BeqOjy3JG5O8t9I3Z4sj2pFcHPuOuOzEQa6x2dm7aK9ahn63WFIgA8PZEcrzKpxEcyQDbmWTjWB/zkqPuFR/Mo6HO4Q40iMmthEtbY8y1I7npoRKvopnuRDlSHizcQGfaFKXeZjNRFqW8J8iaS9qWo83fSSocKd2OplqbZX9xQyHM+kwmS/I1ou5YTKBpRW7M7UoC9btwzFPTCU/dt+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kovUrn2/LwGyv2D7w+tzb3L2a4wEP+MG2Hn/jlksr0g=;
 b=mh14CfjXFUAO1BSIdmd2RUpK+99wif8e9N+yp3sGD/goUueXLaUgVGTfq5hsot/j6JdignjNRNEODNAojiVrw0VcHYF5rorTNly2Tqjp6SXLxHBTKCS54+2endG72rmih7eRS+heo3/VV5jplqnvvC1B4g5WrmGrFF5eqD/CQFiHwgIMhOPVtWCmcsFC4Hpaju3y9DDWULRSEqT3mAMiKUpLX8WO2bMC2xJ3BZ3B2y3FvLdebyk/uiosx3AcaUkcka1Zit3ndNjcXvSi98yGc/WuINKR0g5wN25wxICNYinDfmr9idpdsBP9F2dRYU+pIuJ2FaFbfR8xmZ1zD7KCig==
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by LV2PR12MB999073.namprd12.prod.outlook.com (2603:10b6:408:352::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 11:48:46 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 11:48:46 +0000
Message-ID: <5557a08f-6d53-4425-8004-b7f0bbcd8a50@nvidia.com>
Date: Mon, 6 Jul 2026 13:48:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: bound TX CQ poll softirq residency
 with a time budget
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ben Cressey <ben@cressey.dev>
References: <20260703-mlx5e-tx-cq-time-budget-v1-1-6da2cfe9c7b1@linux.dev>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260703-mlx5e-tx-cq-time-budget-v1-1-6da2cfe9c7b1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0318.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::18) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|LV2PR12MB999073:EE_
X-MS-Office365-Filtering-Correlation-Id: dc119cf9-05e5-4fce-937a-08dedb548969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|921020|15056099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	p6ibow2XCXWjSMPRO975CMyxoO4Gd7zRJ2UAEoF/VgZOFekHQ0cNf2820wYHChFWeqrRpIRxRyCRQmGDKoxdURifqP3pmb4vyLbBl4ZqzYvY4BMWuzRnLHgpfcgDf+RkXV1XIJPgWDqfj+CIlr0olqMrgQbWzsjr9fm9G98f2/M7b2XOf8YeGpnYQoEb8NEQ8fp9fevbVrNbtp1FdSX+HViFMu2euSXsAyP1cFYFFxPIj/ujW8eCASgVFHOhn95K0QlLn5ly1nvwkO9Evs6pzjDf5YbvoV7Q204KrObYg2QTVIoKa5heOaVdgzx4b1egltnretkYZAmsr1Zmq1hPYZA4PzM2oZyqLv5fjGuf/Gh5goXZF23IWHWdACPKDfqH5vqvbHHlhkee0lWOOp6/F+H+Rt2C/+o9ZAbLRZE/yqPHcX4GFvzEjsaqStCZGWxgRUnl804opHK78XLjEd5Z5mCZBzk4dZfo7YYqJJd1d5JHMG5RHSsjbG/yoMg7hmhoCoCCIDtXPSe/nonw+RMvDx3PY2NrpDhRohmM4nYuGG1NNoadu8EIOEM+oKhXdNCU00HbZEZGaj0ZLLMG4iyUUnsLkpPmgnA1v72FQ3k5r5bwRwbVzWZlAXc0yMfum2F1Yf1GFdFVgy1hC04r06Y/L94a0HORCPkxf8VPaKQV6svtbt+PijqZQ6DP8fl4cItM2UmhX8G77u4B3SvGhmwpAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(921020)(15056099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1dYUi9YNjViNnkxUHVYWjJwWVBjd3pLb3R4S3VNbnd5RmRhUnBKdWNQLzlB?=
 =?utf-8?B?d21OQXl4dnNXSTlGUEV5L1JPdUtvOTlMbjdRay9RckxaSzZjRUpTOGNIRkJs?=
 =?utf-8?B?K3lVU3ZYSTY1bVpNWm41cENndGwwdzN6YUFYTGw0QjNzbW5XWEdGaWRiOWk1?=
 =?utf-8?B?Sys4TUpoV3RKTkJ0SVd6TUszTjlFNDl4S0NvK2dzSmdpcWhLY0dTRzBoZjFa?=
 =?utf-8?B?eXcyT1hDajhGalZ3aGdiNktSR1VpSEVjeG4rYVQveHhnRVVQRWZQay9BZjEr?=
 =?utf-8?B?UU5ja2F3QUhmMnJPNC85YmxaeE5tRkNoVlBaUXZ3VHV5d29Id1pmUkQxcWY5?=
 =?utf-8?B?VmVCVmNxTDBvbzBMczdlc01tcFZSbm9qd0JUcGh6K2ZsNjZWRWw0WnR2U2hN?=
 =?utf-8?B?YUlxRTh1MVdhQ25JRm9yaFU1WjhMMXJaZWhENDZQcFRidDd1YVRvVkJzSG1U?=
 =?utf-8?B?aVcvS1MyTFMvdWg2NWRxbTdTQUtwdmNOalhxZEkydFFzSi9Zd012N1hMM3NC?=
 =?utf-8?B?b0lSUVh4VFh3UkJCc3NMOWF1VlBLN3JPY3hjMUtTZFlxVXJUWFE3S2RxUnhV?=
 =?utf-8?B?eTNYNmpENThNMXUvUUJ0eWRrSGpVQVdiT3pZMEpleXVycktGRkZwOEg3OFFJ?=
 =?utf-8?B?VDB4MXdOMWJEU0ZMQjJJQzl3NWtPZG1vQk5GSlVqc2VZOW9LdDRpZmVkd0d6?=
 =?utf-8?B?SEtqTHQrcFkrUzJlODJIOURzcUEyWGIxaWIveUU5WmRrWjlUcmVESHRhVmxY?=
 =?utf-8?B?ZkM5T0RyUWVEV1NBQnYxdmRuR0VzbUdwNFo0MXBIeTcyN005RTYxcGI4cWhX?=
 =?utf-8?B?L2RkblpPZG5wZkNWdkNySk9KWWFTRGJVNHNOVTc3Y0IweG93TktUdi9lVHhD?=
 =?utf-8?B?dXhkN2RUemYwT2s0SUNNcEhQLzEwNXMvQUlIRFZRN05XVXlGM3ExOTJxOFVx?=
 =?utf-8?B?K3lPYktYdU1BK2lsdFVnTHZ0cVdZZ1RjdHRkVVFtSVN4N0ZGSldVOEdRUzBh?=
 =?utf-8?B?TURiOGYxTGNCZHhWdkw3QTFUbFVrZVlZVEx2M1oxVU1oQ2xzVUxiU0syenpW?=
 =?utf-8?B?Q1RiYURTNEtGYitCcHNOUTMvS0lOMU1FRDZXdHB2MTl2eERJMmJqaTQzb0VH?=
 =?utf-8?B?a2NlZ0ZCeXBST1oxMkRqaVFOdzFmaHMxL2dWTE1LWXhPNWxBRGlPS1M1SGx1?=
 =?utf-8?B?M1FXVWR0OElZajc3MkQ4VXJsWU5XeXVsWmN4ZTBoMHlpcmYzQlN5bUpvelp0?=
 =?utf-8?B?a21ZZU55K1pYcytveEhZYVY4MEFEZEo2M0VjYTNKQnJ1WUkvcExIUm5qNGd5?=
 =?utf-8?B?S3o4dlMrQ29aOURNL3pvQ1N1cng0eEdnRExFVmJQY2txeldIMDhzT04wNW9F?=
 =?utf-8?B?bTJQcDQ4YXBuYmlyYmovUjlYdXJ1dzk2TWpvdU9seWVGOW9ubFI5Rk0rcTNN?=
 =?utf-8?B?ZDlZREVoMUZaeE1HSVlVQ1FyeW1MTzZZMFFjZEo3bk9mdUFEWWNlQU4xZTZq?=
 =?utf-8?B?OTNqM0haenVOR2lUMHBlUU1MRFRUdUtRRFF0QnlCSWtMS1ZmdU9nM1FUZTBG?=
 =?utf-8?B?VUkxYTg3dllYeDJ4NHA3dGRReUY2QUd5ZzYxcUsrWUQ3eHBjTEpuYXloUWhy?=
 =?utf-8?B?eTRJMkpoQUJvTzhvcitDUXdkNmE1cXVlTk1jT25ZUE1ScktBSE1rV29Fcmp5?=
 =?utf-8?B?L05XLzFyK1VkcGNiOUJVcVlKRlp6MGFZdU83NWw1K1JLWVEzT29RRzNtTVZ1?=
 =?utf-8?B?eStHL3NlU3BhNnZYR1R4NFlidk5LSGJUTWVJMGZvaW8wZ1o1ZGhIV25BOEJw?=
 =?utf-8?B?aTIxZloyMklEVnBzWENoNi9ZczNwbkRsalFsaERqZUtCMHptdGpETkVWVkpI?=
 =?utf-8?B?Q3paZXF4cXMyUEdtVzZ2MlhhTi9waHVOZ1dwajFiMlgvMlloWHlrRCttOW1y?=
 =?utf-8?B?dTVGcnVuZTMxUG5xeDUzYVFJYlQ1Q01aL0d2eUxsbGdoNVVxUUFsalgvb2k3?=
 =?utf-8?B?cER5R0hZV01ySEo1bzFxM2luelFxbllJWVlSUzVzS2J3dWpGVk5pVUMxSjc1?=
 =?utf-8?B?WWl6UnVMb051WmFyZ2FLZTEzM3dyQlNqL3dEM1BrMW5VK2wxT0hqVmhkMkxH?=
 =?utf-8?B?cUIrZ0RYYW93d0Y2YnZlenRDTkZTU09URWZlL0I0b000Tlg4TWw0elJTMUs4?=
 =?utf-8?B?VDB3V3M5aTNLVXZrby9oa255NGVGeks2QU1sZ0JUNVkxTEUyazVKTlQ4cEJU?=
 =?utf-8?B?Um1DRGx0eUdwR28rRHhDMEJUTzNoUGFXUWNjMEk1L0hlek5TS1hvcGZCYzRR?=
 =?utf-8?B?azZLdUI3eTRKR0U4S085T0tKcCsrOEpMMlB4ZkFUSFFEVEp5QnI3Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc119cf9-05e5-4fce-937a-08dedb548969
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:48:46.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhljRQVUOn9yoCQdq6v1i6DIrJkYQ20HJbk1tuHQVOYGrTTeGbir7B2atha762+690im5NTxlA4xPmJTHAgfYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22796-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jose.fernandez@linux.dev,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ben@cressey.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp,cressey.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF05B7115AA

Hi Jose,

Thanks for your patch.

On 03.07.26 03:36, Jose Fernandez (Anthropic) wrote:
> Under strict IOMMU invalidation (iommu.strict=1), each per-fragment DMA
> unmap in the TX completion path issues a synchronous TLB invalidate and
> waits for CMD_SYNC, spinning IRQ-off in the SMMU command queue. Under
> cross-CPU command-queue contention this per-unmap cost inflates from
> microseconds to hundreds of microseconds. mlx5e_poll_tx_cq()'s per-CQE
> budget (128) does not bound time in this regime: one CQE can cover a
> multi-WQE batch with many fragments, so a single poll invocation can
> accumulate seconds of softirq residency and trip the soft-lockup
> watchdog on arm64/SMMU-v3 systems.
> 
This is interesting. I can think of 2 cases here which can overlap:

1) Packets are sent with xmit_more which trigger this many WQEs per
  CQE scenario.

2) TSO packets can have many fragments so even a single WQE will have
   more than one DMA unmap. For the default GSO size of 64K each TSO
   skb will have 2 fragments on your platform. If the GSO is bumped to
   256K then you usually get ~5 fragments.

Let's first understand if this is a case of 1) (small packets sent
with xmit_more) or 2) (many TSO packets) or 1+2) (many TSO packets sent
with xmit_more).

If xmit_more is used then you can actually tune the BQL to avoid this
behavior which seems to wreak havoc on your configuration.

> Bound the invocation by time: check local_clock() every 8 CQEs against
> a budget (default 500us; module parameter tx_cq_time_budget_us,
> runtime-writable, 0 disables) and break out of the CQE loop when
> exceeded, reporting busy exactly like the existing CQE-budget
> exhaustion path so NAPI keeps the poll scheduled. Remaining
> completions are delayed by one reschedule, never stranded. The inner
> WQE walk is never interrupted mid-CQE (sqcc/dma_fifo_cc accounting).
> A new ethtool statistic (tx_time_budget_exit) counts early exits.
> 
> Also add cond_resched() in mlx5e_free_txqsq_descs(): the teardown path
> walks the same per-fragment unmaps in process context.
> 
> Tested on arm64 with SMMU-v3 under strict mode: throughput cost is
> within run-to-run variance at every measured load shape; under active
> invalidation-storm contention, the bounded poll measures 35-50%
> faster than unbounded (bounded polling yields cores back to the
> transmit path).
> 
The bounded poll is faster because it is interrupted earlier or is
it faster because it results in less contention on the IOMMU?

> Assisted-by: Claude:unspecified
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
> Reviewed-by: Ben Cressey <ben@cressey.dev>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  5 ++++
>  drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |  2 ++
>  drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    | 29 +++++++++++++++++++++-
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> index 7f33261ba655..b940280af19d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> @@ -171,6 +171,7 @@ static const struct counter_desc sw_stats_desc[] = {
>  	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_cqes) },
>  	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_queue_wake) },
>  	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_cqe_err) },
> +	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_time_budget_exit) },
>  	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_xdp_xmit) },
>  	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_xdp_mpwqe) },
>  	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_xdp_inlnw) },
> @@ -426,6 +427,7 @@ static void mlx5e_stats_grp_sw_update_stats_sq(struct mlx5e_sw_stats *s,
>  	s->tx_queue_wake            += sq_stats->wake;
>  	s->tx_queue_dropped         += sq_stats->dropped;
>  	s->tx_cqe_err               += sq_stats->cqe_err;
> +	s->tx_time_budget_exit      += sq_stats->time_budget_exit;
>  	s->tx_recover               += sq_stats->recover;
>  	s->tx_xmit_more             += sq_stats->xmit_more;
>  	s->tx_csum_partial_inner    += sq_stats->csum_partial_inner;
> @@ -2323,6 +2325,7 @@ static const struct counter_desc sq_stats_desc[] = {
>  	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, cqes) },
>  	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, wake) },
>  	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, cqe_err) },
> +	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, time_budget_exit) },
>  };
>  
>  static const struct counter_desc rq_xdpsq_stats_desc[] = {
> @@ -2399,6 +2402,7 @@ static const struct counter_desc ptp_sq_stats_desc[] = {
>  	{ MLX5E_DECLARE_PTP_TX_STAT(struct mlx5e_sq_stats, cqes) },
>  	{ MLX5E_DECLARE_PTP_TX_STAT(struct mlx5e_sq_stats, wake) },
>  	{ MLX5E_DECLARE_PTP_TX_STAT(struct mlx5e_sq_stats, cqe_err) },
> +	{ MLX5E_DECLARE_PTP_TX_STAT(struct mlx5e_sq_stats, time_budget_exit) },
>  };
>  
>  static const struct counter_desc ptp_ch_stats_desc[] = {
> @@ -2476,6 +2480,7 @@ static const struct counter_desc qos_sq_stats_desc[] = {
>  	{ MLX5E_DECLARE_QOS_TX_STAT(struct mlx5e_sq_stats, cqes) },
>  	{ MLX5E_DECLARE_QOS_TX_STAT(struct mlx5e_sq_stats, wake) },
>  	{ MLX5E_DECLARE_QOS_TX_STAT(struct mlx5e_sq_stats, cqe_err) },
> +	{ MLX5E_DECLARE_QOS_TX_STAT(struct mlx5e_sq_stats, time_budget_exit) },
>  };
>  
>  #define NUM_RQ_STATS			ARRAY_SIZE(rq_stats_desc)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
> index 09f155acb461..5ba954f42ccd 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
> @@ -187,6 +187,7 @@ struct mlx5e_sw_stats {
>  	u64 tx_cqes;
>  	u64 tx_queue_wake;
>  	u64 tx_cqe_err;
> +	u64 tx_time_budget_exit;
>  	u64 tx_xdp_xmit;
>  	u64 tx_xdp_mpwqe;
>  	u64 tx_xdp_inlnw;
> @@ -445,6 +446,7 @@ struct mlx5e_sq_stats {
>  	u64 cqes ____cacheline_aligned_in_smp;
>  	u64 wake;
>  	u64 cqe_err;
> +	u64 time_budget_exit;
>  };
>  
>  struct mlx5e_xdpsq_stats {
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> index 0b5e600e4a6a..994df912b765 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> @@ -43,6 +43,13 @@
>  #include "en_accel/macsec.h"
>  #include "en/ptp.h"
>  #include <net/ipv6.h>
> +#include <linux/moduleparam.h>
> +#include <linux/sched/clock.h>
> +
> +static unsigned int mlx5e_tx_cq_time_budget_us = 500;
> +module_param_named(tx_cq_time_budget_us, mlx5e_tx_cq_time_budget_us, uint, 0644);
> +MODULE_PARM_DESC(tx_cq_time_budget_us,
> +		 "Max microseconds one TX CQ poll may spend before yielding (0 = unbounded)");
>  
>  static void mlx5e_dma_unmap_wqe_err(struct mlx5e_txqsq *sq, u8 num_dma)
>  {
> @@ -760,9 +767,12 @@ void mlx5e_txqsq_wake(struct mlx5e_txqsq *sq)
>  bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
>  {
>  	struct mlx5e_sq_stats *stats;
> +	bool time_exceeded = false;
> +	u64 time_budget_end = 0;
>  	struct mlx5e_txqsq *sq;
>  	struct mlx5_cqe64 *cqe;
>  	u32 dma_fifo_cc;
> +	u32 budget_us;
>  	u32 nbytes;
>  	u16 npkts;
>  	u16 sqcc;
> @@ -790,6 +800,10 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
>  	/* avoid dirtying sq cache line every cqe */
>  	dma_fifo_cc = sq->dma_fifo_cc;
>  
> +	budget_us = READ_ONCE(mlx5e_tx_cq_time_budget_us);
> +	if (budget_us)
> +		time_budget_end = local_clock() + (u64)budget_us * NSEC_PER_USEC;
> +
>  	i = 0;
>  	do {
>  		struct mlx5e_tx_wqe_info *wi;
> @@ -842,8 +856,19 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
>  			stats->cqe_err++;
>  		}
>  
> +		/* Check between CQEs only (sqcc/dma_fifo_cc must advance together). */
> +		if (unlikely(time_budget_end && (i & 7) == 7 &&
> +			     local_clock() >= time_budget_end)) {
> +			time_exceeded = true;
> +			i++;
> +			break;
> +		}
> +
>  	} while ((++i < MLX5E_TX_CQ_POLL_BUDGET) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
>  
> +	if (unlikely(time_exceeded))
> +		stats->time_budget_exit++;
> +
>  	stats->cqes += i;
>  
>  	mlx5_cqwq_update_db_record(&cq->wq);
> @@ -858,7 +883,7 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
>  
>  	mlx5e_txqsq_wake(sq);
>  
> -	return (i == MLX5E_TX_CQ_POLL_BUDGET);
> +	return time_exceeded || (i == MLX5E_TX_CQ_POLL_BUDGET);
>  }
>  
This change is too invasive in the driver for all the other cases. We have to figure
another way to go about this issue.

Thanks,
Dragos

