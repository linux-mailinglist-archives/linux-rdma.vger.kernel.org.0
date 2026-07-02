Return-Path: <linux-rdma+bounces-22722-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C6QwLVqgRmrraQsAu9opvQ
	(envelope-from <linux-rdma+bounces-22722-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:31:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 454286FB66E
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:31:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=E00oS6Gy;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22722-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22722-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85B543135802
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB8A3491D0;
	Thu,  2 Jul 2026 17:23:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1411B349AF5;
	Thu,  2 Jul 2026 17:23:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013037; cv=fail; b=oI0IF3YQYleWJIut47iYfVrWtOcQshn7CuOdtHmTpYGZBJhNOfncORGkIyLAMGImZaimCPyg/LD/vy0ZzmCKIWxhPkc0JGYirEtrdscSQUA8wr/sUPrxVYKqF0AhL1GY243uGOvI+VH1g5AJqpW72l3Rb5XvSSWFNbcG+o8lskw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013037; c=relaxed/simple;
	bh=l5J4JFIBgcYji+MWAbXNLPF3FeSyf3yclEWoZh9EZbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YEenYh5dGkEpDjnI1Sp04CW6aB98avIM0KPd9nHcBy+Vdd3zBJCRZH5Hg+67N5v8PgzzF5e4PH5j7Y/3Bm36TvCwWJPh0yxe8rfTKTd2gmz1x44smr0gVd1h2GTtu34j0rJx5aMa13DZpLiZu3EIb20hphJitLzca2pCz9UbTu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E00oS6Gy; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPLgXByvS07D5BcVamANkLKDhKBAoZdEzzxEzGbpCOPbnl6wYGmNzDeNJ/cWsxL26qJJEDH4W5c/3YJLxtrvn6rmNUPeSw5GdguwCWqOH02yEJsCi1Q0qO4F0B/qRfPyxvWcNBVgNQb8ZGtsOK+qPiPleVNSzx8Sc2f//4FZkmL1k6MTUvAKULSoBC9FeBsmFjoe++92eRQPtAQPyW6hhJwhOZMvK5fqDs7xjyCbio+Euid0S7tIbEA0nkO1lUXh70ykujqi68xoSCut9VhE+w4r3xuBjKvBhh6tnUP708pjYSYJjR76GukykjroF6Aq/8of9Lji9Yx7U/Q2AbEcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zEyqLs+HGL3fC4dYJZtSfcKC8HQ04duGs8vcF9Tx50=;
 b=vD+sbk8Xfj5NnRDx/UqHkQltVwS1OYV32SR6XZW7LCby6O8hTZIAE2Ms0aWWgUxB/nRQYSYcd4wh12fil5b5/CDTllaM1JN4gnHOG5nWQ/MFeNILZXP41g8tvf4X1RcIuhezCKs23SSKhgYae9RvdnKH0EOG+3Q9PnrSeRBYia5DUFydShfPwVj0Mh80db7DfWDvAdUTdveVMfr48aS/L3afx9e76XT20ewhznWgHDUIE9KnL/ni7LtELRbD1L9BTEI8/6OYwW6sPBzpkW5tRS30Q1QeGjLvxhVvrVvkcohOfujDugWh0zbIGqU/lV0f1SSLF6W6FHUstSjDp6gcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zEyqLs+HGL3fC4dYJZtSfcKC8HQ04duGs8vcF9Tx50=;
 b=E00oS6GyCDR8yVLmwhrLHjaHREK3A9+2EmpCqSAQfBIxkPj4Fu86J0xoD5RgbPvhr0dpikRK7IHOmgt+WQMWwR4MC76vdpxW3uRo9+re3yyCfSF2oR/pMOxWpU5EsS2GRj6iI/EdZXYLhuheefm9eFKgOzjCKph5SrAAW1bAvcA50DZddlbdwj7RFFrQwjd88NtNNsKh0UM3wXLQz8VFOhx/KvG29GKegO8RvktSgc5z3WUwvERWpD/bIALl5U82/kHlhZmDXuaCyNJfewBxzpitnt1pk0g97GFpn/glgfisZ8hMia4aJiag3Zo8TCUvekdhT0nbGdzC+anfi2elyA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:23:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 17:23:52 +0000
Date: Thu, 2 Jul 2026 14:23:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"open list:INFINIBAND SUBSYSTEM" <linux-rdma@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: infiniband: fix bracket
Message-ID: <20260702172350.GA1508313@nvidia.com>
References: <20260627093107.31068-2-manuelebner@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627093107.31068-2-manuelebner@mailbox.org>
X-ClientProxiedBy: YT4PR01CA0306.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 41603e73-cc87-45d3-0edb-08ded85eaf7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KIC0xFqCDWyOx0D/qfgZJwdkyxlcIigCV2tiWhbvqWZ0Q1laxgtwd9uux0HhELYbmAhe3q3bG8KqHt1DzTlC7DeBY23BrH3f7cRjUlU4pB8utkkMEeRV0y7dx/HK+asMFZOoWwu0x8pHY0cLA+76mO9pURCHCm8UdehRny6LEkobRJLSsjT2qdzFkBdP58yb3xJr2KnQeksTEfnSj6+rzOTU6ywKRxvkUxGZZvYDS2HsRhC1aMzhL+ItKH9kzOwRnInthIHFIXdVudocsjbx6zmQvTUkROwP7ep0K2fnMG3fil+jzzhW2UXsUElFIMOVRXr8EGdgIzRDKtZYM46bmONgKrASC3gPfkw9jhUEvDB1p9Yuw2/bwGw59z3gAIz66Jn40TjLUIinJ7Fq/bFRzYJivUkq08uTOgJW9g3Fk7cM3F/Dq+2AHjTZ+f4tC1QV7ZKTzdCoTiPqOdJ320RjqjX4ZSydAdsRsW1TORWBRi1N9E7DWKba8UvoEqUTypPqYJ8MlPYKoXXOZkgS3boBievu9HUi4jCy1qRAGiebLvxBcZOkFCNZccO6cKb4Xz1PR01yv2KxOmsd28HkRdmdbDR2TJP5QFvbdmAt/srEP0+6PC6EulSd48O1WApFWO+VQF8M8aYQz7xKBCs4cQdcRgS+M/VlSpIpKrS0XyoEVlQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rwGvEwAA5OQsamQw3gJwIfnMNRJmDOeinHJSVggRHHqWNKP34dKYeAcSSdNh?=
 =?us-ascii?Q?uDfHBFbDvCEZOrjyyTXJVFDBatTcFVCcWyfs7/zxIw6RYneXR62H2mgsfzrG?=
 =?us-ascii?Q?GYN0lz/vJgIXWJ75gk2jURJOuVBf9nyCTTSrd/Tw9eO4K2j3BT83igubl6cq?=
 =?us-ascii?Q?cpJfAy7vct/qyYXlisx51gUM3veN/J2d+aLU1SyFuT70fIHQnChF5mYMMV0u?=
 =?us-ascii?Q?rwDP8nHgbd36ledRlSxBou0+1YxbBG4NWkJ9GHYEEu8Rf4PdGgcTZWaHwyMr?=
 =?us-ascii?Q?D/cQNCh5lB9uiCDzY/LmYpOrsO9d0fxK1GSPUW7Pw5t5MbKIZjsQ3S7O10w9?=
 =?us-ascii?Q?V0wcLrXB/te0gi/rDIWmRXrIu+gTSWohf/dgxb6oSbUdATLstNRtWJug/OCP?=
 =?us-ascii?Q?iyQ3mwcjqjwAKXU7jMo2WF3ethVolPjKpQM3Gpvb4+dusljI9R1ltlg94qnX?=
 =?us-ascii?Q?u4I2oLZt3JXHHVsmCMYy752Xnd9gsS3WKPU5iJi1wR/sD4H5ESOgVxODv4yp?=
 =?us-ascii?Q?D/X2WMHhz5/OwP5uKEaVBFa5/2J28ZxkADfDLSHYam2u4e9JabX5QhorNyH3?=
 =?us-ascii?Q?NysxCMUJpmdCmcO3Z4GzbJKX0hkb/a5eAZw8hloNCAKKfJGta2ODmZ01n4zJ?=
 =?us-ascii?Q?VhD3Twx43brxUdrdV2SUTXSxOuzoUAx9Z3LsZNgOj0BE3rguHCx11awXihiD?=
 =?us-ascii?Q?s26T+WcI8mD8O8oZ7KP8kOIr/ED47bvAWHFtX9f9ALTNuKJ5WuLX0XTbrgHm?=
 =?us-ascii?Q?A3wz6IXRj8Xq9F4/S/jVQm6FGyOn3NR2VlViGYhmd7+9t4q0lC0pXa7s05Cn?=
 =?us-ascii?Q?VIwGWqR/9O8H4iDCzDf+7GWQ/aRT4R08jrgA3TT+bWMgX1SzQMD6ZP4SJfX2?=
 =?us-ascii?Q?4qM/uRPAP40ErdCpWOB2/L/S8z4FxlI9U3AyjRwGYvH0I6c4p2fOcosCWSs5?=
 =?us-ascii?Q?jK9IdG26d6aqGFSYioF2YzMs6dRoYrvGdhgbw165TZZp7SRX30PsD2YRz021?=
 =?us-ascii?Q?zJjocGp1n5KOgs7HrMPPKrfn2HgEjIsd7W89i8O93+PeIhad4DxHpozE3yUM?=
 =?us-ascii?Q?Cvz9gWZ8UA1+xsCpGB+BP/WQTpiXYITeeMOdSUzDXzD1jUsq6T77UX5fyZSO?=
 =?us-ascii?Q?UbA1EBhYhmP5cwpIu6WFyhON0rlADm7ycui+c7JUFSTeop3QqwDzloyWOBW0?=
 =?us-ascii?Q?uDy1ur1zEWdEuIbwiGPbEQAsPMIZWuoIcQBY3wyK/m/mlwtsTd+NLBXgayZP?=
 =?us-ascii?Q?k04my+mnaQLPocgqzSc/lrySsau/2Av0BEeh79KZTDg4I0Yo6ytwa6PWRIJG?=
 =?us-ascii?Q?gzqis0Y+Xm1yCPrec7Yv8Zlo5c2i/9W6goUobxOq6d4Xe5y+o0KA41QYfcMY?=
 =?us-ascii?Q?IXyop6EDMApLMyDit5WtZ3+Z0Q/YmZmpDywlwkZL4iqDVBS4yHJoNFipVySI?=
 =?us-ascii?Q?1eYwKO5y2+lcCizoKlzC3hSkbl3C7tvxvenHVlmrqcad2BoxT2ey5FlLIUM2?=
 =?us-ascii?Q?9Wb6NLAOtJ0Z/3knkTwHAVez/VW0RYoxdXIthHfjkMo8yZWrNTkFr6AnsJFG?=
 =?us-ascii?Q?5qW8XZSXUvFoCIjmvIZzRbX+aLXAGhpQhl5wmEasvsahLGc0FYdR0rPrNbtg?=
 =?us-ascii?Q?ldciyMPC0H5+Iq3C3f/uA/o2qWJjE6c6n2bp7kO+Go7m2B0vjnCeBOpPpKJS?=
 =?us-ascii?Q?QHXkye8musfKSMUfgy9+d6Be+VjeOAlOHGLOpssE32oGx6re?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41603e73-cc87-45d3-0edb-08ded85eaf7b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:23:51.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUNLEcg7LGMlNAwANDyj8ZvYFUCs6ylLQPGLzA9g/fa247ynVcdQpVJiMTrfayQh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22722-lists,linux-rdma=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:manuelebner@mailbox.org,m:leon@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,infradead.org:email,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 454286FB66E

On Sat, Jun 27, 2026 at 11:31:08AM +0200, Manuel Ebner wrote:
> Remove needless ')'.
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/infiniband/user_mad.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next thanks

Jason

