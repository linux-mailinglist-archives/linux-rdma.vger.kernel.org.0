Return-Path: <linux-rdma+bounces-22723-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OIfZALWiRmrQagsAu9opvQ
	(envelope-from <linux-rdma+bounces-22723-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:41:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9D66FB8A4
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:41:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="LP/bDs3I";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22723-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22723-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D166305C5C3
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193DD37A839;
	Thu,  2 Jul 2026 17:36:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF82E7623;
	Thu,  2 Jul 2026 17:36:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013769; cv=fail; b=ApfgrBdOAsdR0bSzHroSjeF0tDeifGcTjiGCwVBxpR5WrqEIw8pKH5Ir1rCs69EOWpTUNQWYIalGMY9xKtBktmuX1Y6BeuMUZpii+0LwoDH18lH9Sx/J3Rb2C/reWykLhyhk9maqsx6jMe9g4rUDwHFzP/WSMb2frKeAt6MBf8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013769; c=relaxed/simple;
	bh=xHFBgWQgdC9HWf4OXl/OcXowM4JhUA9QqoEagGGMDc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SOmmml3cn4j8WKnB4LN/SszpHY6MJpI6/AqQSd9SlaBlSnoq653YCBrmd0BU4WpgVYJzX8eMjkwuez3g2fVc2X0Vlqt0NqbIRKuIV/g7BIkglIjOgo25dcSQ/pUQODk3rsfuWQvE8cA3k6uuGE2Qt48QhAGrq8tlBNd+ya2ovKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LP/bDs3I; arc=fail smtp.client-ip=52.101.43.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuYAx07XH3gl/E2u8LzbO8Qh1NPzegcmFt+pM8j0r6w+elkwYSzg8aEgUIcttZGwV1XTPTnf5ikoX054XRLFiT3NoZuiA7P0oE8Rj04HwX3xGAw2SPwBa3DnyZiZ54TUYZdp7+Ust7O4HgDkIDDtF5IjQl6GrgTfCB+f9OOGrmC9tjPq1rWzrfTu/9olrhzljn6pYRVDR0xUo2DLMzP5tO69uuzCvGoQkAAEO8tXX91Ka4Vc5/DJ9mH++hJ3is/cLwbMivMPmrFPp+nMvUJifgEUrrXUZFrw4dDrNICWnUZPioLvE4xmBCToU6n4nSewYApdJO4yderIJYZCtA2AwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbusZ78SLgVTl2n/9ykZjujpBW4Y0WE6IXCzlvQQI2Y=;
 b=UIQINWxpL8ej/RYUP7rI7ZQ0BPWJE+2p75bvLAtemNNuXwaVmhw1r/mMFIh1JTz96wH9kROMBL8/rB+XsqxD9dJpyA9cYTv/uV8lD7D/0Nq57Gavekqng0Sf9V1bjLsAhTA25UHO7wqvMSxS1GtC9DkZ5rTF57ibhwd93CoMW7cTryKrEIK61dPxcCAqE8hIWDrCsiNyXoJFo2Z6mFJA4ImK6QFggE5bd4HHmr7bUzqpF5n0+NxsGBHNyneX8PtBiGJRVx4UamlMq09uNQxC/gnoDvxNnL0EemabCOMnc6Od+WnpCNvO0DCNP0lGWiz7w4VPHfDVqAHClphQEVJMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbusZ78SLgVTl2n/9ykZjujpBW4Y0WE6IXCzlvQQI2Y=;
 b=LP/bDs3IFoN4Emvlhq0wUZTGDWaZbFOd0nUgnrq1VeIp8MHdy932jqdHgjEirlzbNMnhN+UVfMQAsETWMwjwaDjMssjP/3OBzh/L62F7/ECB+Uvq07mvzzIyaJBmng0cC00jp3vEObEBg84neSTn9sYL3k5dk9OeJ6/5M7RRoxkwKAK0r2bvKYMiH4d3gRwqRBkms4m0uiQe5p/nF++vPP/rRUXPIfcK02YIVDJ6ZIiGXYJY631IthVF0gBp7S+CismQp7xdnQo01Us5LsKDFCt+XBPX4PHXiZan7KqJnb3VDQVDGTS/2gaZfIEKfWeK90WYdzYqLZy74S9ujmpkqA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV9PR12MB9760.namprd12.prod.outlook.com (2603:10b6:408:2f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:36:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 17:36:05 +0000
Date: Thu, 2 Jul 2026 14:36:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: luoqing <l1138897701@163.com>
Cc: leon@kernel.org, kees@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/iwpm: Fix spelling errors in comments
Message-ID: <20260702173604.GA1515240@nvidia.com>
References: <20260629023153.357709-1-l1138897701@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629023153.357709-1-l1138897701@163.com>
X-ClientProxiedBy: IA4P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV9PR12MB9760:EE_
X-MS-Office365-Filtering-Correlation-Id: 750b691f-ca1a-4d51-1ee6-08ded86064ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VryZvsNmnCtfXmOOnWwamDkwru+QFp0rMdMT0RHKYO+JdBFy0CKsb+ovQSCTtyM+LTXCtRAPwVB3hZTEMBACUN1wSozeSF8hvl4iXvjs0KGASbamfahRPxzcJ0i6IyiqCX76+tWSnk/bm1WtQJoXAk/2RyqfUNeQKFUf8myA/gnDeheVcXFE/7bCuG3h4rjFp+38I865IHSfgpNnMGMLiD1BywgSeSOTGBiS19Jy3PX5517QJ1tOtklIUSyQILhcSd3CsmkX3gjKMU9pg4FPXsgZE/Pi5/BldZC5dNTshQWJFTYCOb8Deid+NIOIiJ4F3dLZbIOPjoyvfh91gWVzSQahWqlYROIjjiEO7iXJ1QueevPoHDoSfi1Pkd+Kfz6+E+n/cnR+3eDfVjgS+chyxXXTpCJXmfbqoaNs1PgD5JdUOD22xdGy32U+AbZb3kykQCLwY0CO4wsYj5ze/Mf/6kNZO3mAcAOCp5fpB+OiALfSit2laixA/cyT8Eob7RMvwi8dzNNS/kqJ3rxMBdHBzmshYH838ddlw4JdcPsKSe/M7B5EGHzcvqdri0W/nS+Xotmlres+9v/Ey+WRyO4ijeIPz26cH87Gt5EAkTIbdGphM3prht7yrpBTxv/1OA9PUU28IzTMISxw8VjLu2KrXQX1Ed3i43GY1fKgEgnsEEE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SDsrjDtXq4RtvRvAoqzdbKD8ISAr00QL1IDuPxgPOwgaUX9lqGT8H5Pl7M0l?=
 =?us-ascii?Q?yGXGXSCPXS9lj50pUd+5ZMuxtgmkd4dj+16Lj15G+iUbcBGdA17SQjJTCTjD?=
 =?us-ascii?Q?dFTOPcFpO5vjg1JsAsJT6F238WUV4VkOCe5Tc1vmBEJiM9VX0l6MTo4RIXa7?=
 =?us-ascii?Q?FWzNAx4+mr5GF9D7P8nag18ftW4WMNsA+YLjP7nTNX3Qa+HmveeJ2VAZpVcF?=
 =?us-ascii?Q?HJy3BoyQSEeRDetnXSzq8wWgH+Wk1zG+ZQFeFIxRJISCuCWUSs8W8fECMuhz?=
 =?us-ascii?Q?X1HiGzq1idnbdMLyw/MLcn39HObYwRgBZfxzDRLsJ4f9FSqswuu2T8KmwVbC?=
 =?us-ascii?Q?8VBkP1wBhwL2AUxJACicTXWlGnLxRoVDT5TCXsLHIb+Vr3zXBM9ZWth25twC?=
 =?us-ascii?Q?OcYRKe1SlrOxuA8ZUntQXUFhXpJ33xD5RoYSVx7jl4GNfdl/oiBOtuVexMjY?=
 =?us-ascii?Q?My1Vri0ip9HHasAo+5kqe6Y7d9M+mn3mnOD3CAQwmRcFxQe4iS0LWgXkqOkf?=
 =?us-ascii?Q?DNQXEVHZwGnf34TkKNp239ccZZAUb8jCJe4ThdjojTjIx5y74wYpZKWoyKCC?=
 =?us-ascii?Q?EFvR0nI1hSVz8QVlnPwJJwAwTKUAHWVkPLhbdSuhjmqujdboVkIixZWqKjxG?=
 =?us-ascii?Q?KKawB/jhf0iWDqB4hWhjrEaZk2IERVoEfg9b8ab8hYnWsShPg1ZshQRbmfbb?=
 =?us-ascii?Q?AiOSUBvpcLp3P+q3a++3W57cHmnMXAdXjR5nLzerzYp4/ors2MB6yAwLzYs5?=
 =?us-ascii?Q?QNLsSJ5MVtxjbh/jlYbPcvuvFcLwe7qZaP63jdHCLv9Nh2mIvEmlbTyvzih6?=
 =?us-ascii?Q?SuELkfOf4fmuy5mJedqZ46FwC7Zg1BUCuFvLCeA2CIGZo8ceK+KA89ih7WIe?=
 =?us-ascii?Q?PTcMxDvZknhDw5oTtZx2mzYNuvDaGixuxIxsZpfVHPZM+KvHJQ8+iniW01BN?=
 =?us-ascii?Q?TzucEbPtd9WYKMeCre687PJsoIdrL2xhOrBpQxMJND9JVxRmxn51B9LP8CI/?=
 =?us-ascii?Q?QakqSCqfMFmCmRf2lCiwywLyXLq/8J8YF1A744mfGOR7ywVJmpz7/9kkU8iJ?=
 =?us-ascii?Q?qLPxs89fseKase3T8an5e7+T0a+qiBs2+hO2DVPtbu2JGa/tiCxT3ZhLsqhA?=
 =?us-ascii?Q?/d9P2xJwjIaHqYcyqam0/Y3F4YE+sjhNuZqBblpl7k2PhBSXLlFOrI2JIRA0?=
 =?us-ascii?Q?BiApC65y9YFibSQeBK6F0uRusVDwVHoxCfREcNl08D3YrHbnv5Hp3A9MPU5g?=
 =?us-ascii?Q?jEkZc82gVezsjNg4zpcSXWuBnOhTS+5QIgEJH1VjjL357nyuxe38MfupDa5e?=
 =?us-ascii?Q?cGwHHxD9Vct+dNkHNC6rZdTKMZwrJmwzJ4f0nX2hbIN1pxf6wsPAOrxmmD5V?=
 =?us-ascii?Q?LfbAj4V1MrLMOSNRw5zl2IqDjsyZDljW/nFbspsBppaj6H8V3xfk7YtC4Aur?=
 =?us-ascii?Q?OCfH106Xtuxg5YiHd7+sZVcgrnsBM9sTdxQPWdYTnAZPAnJcP2GK7LyY6NBf?=
 =?us-ascii?Q?P93ohIUmM7OjiKA2+Jjgr2HocDcGlpzesdJWbQc8Fh30IkfXvU2JXdn4r34R?=
 =?us-ascii?Q?KLQFnGjmqe7+K0K5GuMKbyYpQoDCn+axZAAC0TC+oBEliXIOrJqaXx/x8PFo?=
 =?us-ascii?Q?z3KkbXWO2Am4MKvqdr9IRCpW01TrguuQxqtkQmehOGkPKFo9rkSZTTvyvHi5?=
 =?us-ascii?Q?Lnd3n20rJRhOb+BW0WnZ5s7Vj4GiKpPk6ratxk3/tphyJQpb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750b691f-ca1a-4d51-1ee6-08ded86064ba
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:36:05.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPh6kLoYGMX5LCtrcZbVdlvscQrybXYjQCcHkACPVW+akRjRWgThbq4iKAiBcsks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9760
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22723-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_RECIPIENTS(0.00)[m:l1138897701@163.com,m:leon@kernel.org,m:kees@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D9D66FB8A4

On Mon, Jun 29, 2026 at 10:31:53AM +0800, luoqing wrote:
> From: luoqing <luoqing@kylinos.cn>
> 
> Fix spelling errors in iwpm_msg.c, changing 'quite' to 'quiet'.
> 
> Signed-off-by: luoqing <luoqing@kylinos.cn>
> ---
>  drivers/infiniband/core/iwpm_msg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason

