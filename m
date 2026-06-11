Return-Path: <linux-rdma+bounces-22142-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oUfvGDgKK2oW1wMAu9opvQ
	(envelope-from <linux-rdma+bounces-22142-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 21:19:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E1674B76
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 21:19:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Cl8H1s7D;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22142-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22142-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 339A430FDD82
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 19:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4A0348C66;
	Thu, 11 Jun 2026 19:19:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A47D330D28
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 19:19:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205556; cv=fail; b=YtL8+LzOxOCJySI3plhHvWT8qpiZQkD+ujAVGBTIiZgK4c470sJQ5ZmDWFDflS8WJ+Wwmeec1Fr2tqDUxx5rSFR3Xnnx6zN29AtrmX9OF6PTj9sbrFwj2/saw04AhXSdKn+qoY7k6o2jQLUUxM5s3bnyBErEd2yIwq5F35Y4dWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205556; c=relaxed/simple;
	bh=eH7UsnWE9n1zvYMh5o/Kphu8Ndc6mFZ53DlPIUN2w/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QZHVdkZsmKjJvgDAW0qSZIPOy6g30HmDhGgbjnaOt/ActZ9OsZ24i5ifbTODLphU3EvEy9JHAIzFRC1c113Ur4WXntYSHjKhQlADSidgKuqctsM0ySK+h8NgQHKrOdmIMCQ1bMy0zVSPjfal+NEc5iGW/CPHaLHPjOryRCnn++I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cl8H1s7D; arc=fail smtp.client-ip=52.101.61.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHVqcXOlAQ6JqdEQnPl0GjS8MkC7sFcxYYPcAGeVWe9KT5NrlxFjoitTWcpHsjkfHVmayfMW7ij2f9NQAm5VjVcZOIQg8PbEQCWGiIsFLFMZ7k5IwRXUBhI6l5CtG3uUahTMy+G+loxL9QbKH6iyrPMysyggcHJ+kdgI+yrSlpp07mtjryqZka3IAAiMxqFL00f0KhTPxniGR0/nWxHlkPWnY8RWjdkg71+hXVEBvh4XAG7dGEeQ//lMFS0SKYDhzbC4iERqPGd3ImaDuLlZFL70D5QK8eotvtjPLEmS9Dm9JDKmzk71fChiPWnohSJDzP43A6iRzg4k5DwYe5KbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ChCCUE7j7Qp0tb+5SMIOOXT3eH5OnUjjhy4xxG44Mw=;
 b=kDxDUWBLQkoReGwnZfJ69Kq3ujGTNZmuw2SI5/uIBig4iE9m21lx3dl+Z7KFIZi8HxiuAbFpTS6uH2pveupdXqmvxBzyi0896ihY6x6D/SxHOEh42DUfDX1doIGgyQKI8LKg9gt+kqTXiFWnsaEolcKnqlEftdSfrCOrhJvHjyLRZFdKtyakoYMwvJ6zDyCiER6Gu43nPdgXOV4Cnxdm8rO9pDmxNWOtMey3qJ29ninn6w/eau6rVqkAyncypdc7RxgaEG0c7lklslOVWCb//O0hULh10BcEEKDKHNQzwXB6haqAL0LDd2QkCYzOlwFR1kwZBRZa8HNqE5C9a8RV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ChCCUE7j7Qp0tb+5SMIOOXT3eH5OnUjjhy4xxG44Mw=;
 b=Cl8H1s7DIDFV8y+T6MzhqpfedxVi36sU1d1ihQAB3RZhVEBqDIijw7prGYLvaVfMEet2DWGvQ32Tn2VnLKAQMAeaIfsu6Ctjy4PbJBfzohR9dgW6og9BH6JY1RgYDObEWw3x/MvXyi5ifjw5esBOHUs+zpGTi5Sw2tbdOCwOS2hGATMt9pVUm4pU4nrLstrfglJzls0iDX8hyEQ7aDRl5k+jGE0turdn3ZlBOexDSYO3Ng0Wpf/r/zi6HrtmSGIoSDBirBZASShRMBP8OuArgsPCwAA9pYJpcaq0TJlf5QR32U9Ipvvn4RDCI13xMU5P55afetK3zMFmObfut08TMA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 19:19:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 19:19:08 +0000
Date: Thu, 11 Jun 2026 16:19:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next] =?utf-8?Q?RDMA=2Fmlx?=
 =?utf-8?Q?5=3A_Release_the_HW=E2=80=91provide?= =?utf-8?Q?d?= UAR index
 rather than the SW one
Message-ID: <20260611191907.GA1519174@nvidia.com>
References: <20260611-fix-uar-release-v1-1-f5464d845dbf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-fix-uar-release-v1-1-f5464d845dbf@nvidia.com>
X-ClientProxiedBy: BN0PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:408:141::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 46974baa-5239-4fad-38ae-08dec7ee4f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Jr6lHITacnWWs3dp1POUTzjUMrSoTTxjVRNkFws2n14SHo7hGmA/b0UL1L7XGc7FF2ZpMtqeHyJSIw5n4F8vuJYfhxymLDfVgS8rlMkL3HSr4sHJCGXVdpS0hBEmchcpbSuOKImGD9TVSQy4rOqkKGpyf++96BT4wEY4rBWVqt1MVnaGemIp0+kVYFHZ9+fQ6lfo1BAEccp0MSgTyIpOTywZIc7AR/LKo4PthGWgfVAMl2TLDFM4i8bV4DMFNpUxIphzilM+asVRQOueTN+YufwaslHmGCJ4bezQfLPre2N/cZxayzwgw+Jknbff60DisfC0pd++tELncGOvDt9SyyPedGtuBbHe7McYtJLJu0EQKr3HQ8uX4vc0IpPy5mhiA+XE7Of0W0fSIe0Gl6PpsYM7U0iK++QHwS3ZS5qnh/j1xdXJvhcspSxBc4ZSaAl1a+igdhK2VQYI5cAN0cHIcJlOhWep0w//OllDYid4R16wEyJsWC80QisXKjRu1+B2q68imjfzunX8z6Otvw/dWtsKYZ8Ld8mfrTMcA2S7A5Vyppp70oFVCnoFknU2FRV3JvPJ8sTyrnfB5aeW+hGr3erhvspQ3V3a1WBIBT5pNqaX3Qz7BCDtNrlbl4rLM6KMpN0jmxR9fvmfqg7yfoaLQgKpuT8isfMyW9bAdz5jv1CVoqK+sS0c+MiIKdtE/6gz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yeMXg02T+imOd/KeGXEgxrDR/B48QHKli8BTxlO0HGR4hdWi0m5eUvMdnebA?=
 =?us-ascii?Q?aOMdFqg81URYO+OVslPoZXbCsmT/HwyNyQ+ksQuoTdCYrgmFkX81pxfnljdc?=
 =?us-ascii?Q?yDTqfLyQdA0lWYg9g+TkfY3u4H02CGqY4rrM7igwd+pDhj/HAsh8tkHu9Abg?=
 =?us-ascii?Q?xkzbk/twZ/YxHaxMAJA8YHeCgcgvFO3hZ8fC95BO3MGqxhtvVx4cHcQnABqz?=
 =?us-ascii?Q?55PSqL7sqncw3l2ErNJACoOYsmEGt4xxG5ilNuHrRjg0wilczFDXkE0lDpC9?=
 =?us-ascii?Q?JaMyhOy+ceZIH3lUC/C0DmqoAxFb3+TUYkMha5cOd0JsC8D0cqzcGCYv2WOy?=
 =?us-ascii?Q?AzpqQ5fVXEb8uQdWVZq4HEDuJHLlkPkPbNyXxAgw/0zt0yyGJuDSx3RAJ38m?=
 =?us-ascii?Q?pCDZajf6BPLlPXmgXFaYPX/6MCTukgJPRF9jWfr9bkC1QlqrAc5ilpRjpRCF?=
 =?us-ascii?Q?G9hzKCrtwf/x0nU0ub+IcHjYfPKVVvRrOicI4wNHWgQeILx/IcT5flX63wk9?=
 =?us-ascii?Q?9v8VxRdAgwUL10LdJ4svmNnzyuWcmLpJLVoAOpnJp0IWk2P2UVtHjQ/bxymz?=
 =?us-ascii?Q?dySzbhjP4M9Qa0pKuEfSx3nVLpHfVLZL6OD96TelQoDBQb1VmaMIwQ4NW1Gg?=
 =?us-ascii?Q?WsnTsIv9RDsu6iUYyPjvEMFu6btDRADquUnyAxcqWLa3ecHsKUG6ZZrphUOt?=
 =?us-ascii?Q?E1dRIURg+h0cODDWyuRK7m0UNTlE7C3BUGpT9d+cE6lMVf/AY4pq42qUf/h6?=
 =?us-ascii?Q?Mhu8j2O+cWRQ/OrssIqSzHz0BjR6nlxq+GeQMgAiek55Z/9I33RCA4UqjSOG?=
 =?us-ascii?Q?vqFBl3OCKgAM1siVs/7Z+Ce2rkiiJfk060ijW4eo/+8huc2PVJRkymHATdSO?=
 =?us-ascii?Q?9LoWCaxkrweQysNl+0JEsVMt67RGX8+0sGMFzJg7PxmeVEKMgT6tLN2C697y?=
 =?us-ascii?Q?NhK+j0YF9ih9NbFodO3/3853DxO1qXphClrRRNszS3YEOEdj5zTEaHlIx3Tk?=
 =?us-ascii?Q?Ii2DNiv0C1DDKJ6slBSJ+fVpJw6ZUqd9JK/XE8f+qFPWaSXs88VxfiQWy3Ys?=
 =?us-ascii?Q?UId14TQ2BNPEIPqEKL3FXu/CES0EUQDtEoDkczjUEZwvd7wYco4OkUQ2ksyl?=
 =?us-ascii?Q?ls435kfr8Gi3CFuSeQ6QBtxhqr8yGGpxBxPt30/f9n/0nz/altzLnDVZ+tYY?=
 =?us-ascii?Q?x7o1vJNBtjq6UHBFo8/mc30yXJONzmucU/gxYARXHpyQZseRRAb9gUmovivd?=
 =?us-ascii?Q?wE3AoKWUfU2oiPXfwrWkOx7BBp3kg3uBcoilSutXH7qYMx6cjucu3qjrCL80?=
 =?us-ascii?Q?OlIyyFEzXwMsbWviwXEQ6MAuETXYwBmNR1BTGK6p9CjWJPLZMEpXveFv6B9U?=
 =?us-ascii?Q?KqLRvh/Tpgu61AhDxK4fzffkAmfRhaXujRwSnPh4U2EAuI1+pdqs7Bi5Fyq+?=
 =?us-ascii?Q?P8++AOUIMM6N78vGEmDiaqZSbqQtGInJ0wlTaF+BPezB5sRF9XPuG8pTkkEh?=
 =?us-ascii?Q?ivhhhIkDvfJJrqZUSaQ2RUN7iOhvJ1RAbT98L1x4Kn11n2wt/J0u4THzX/hA?=
 =?us-ascii?Q?xk9s0IMFxDmMv8Dwtd0564/VXbTjXwvZLW+K0bKToIaplrcDOnNQjBFFL09k?=
 =?us-ascii?Q?U7soMYl880XB8eCMbS4nmlTtytZYQE+p5oUUkhTGmLuzHkRr8FlXpn2IxsBo?=
 =?us-ascii?Q?NjCAZMxgwnHRnCjvDVyGEIE81DHYe8c5Z9MmH9fclgUNo6jX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46974baa-5239-4fad-38ae-08dec7ee4f66
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:19:08.4107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHlAVjiICTxDGh2tuENJJO10o67D7moA4Qvt93lgvkxZsApUjnfpY92gHcPiYX7z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22142-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:yishaih@mellanox.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD9E1674B76

On Thu, Jun 11, 2026 at 01:20:15PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Free the UAR index returned by the hardware.
> 
> Fixes: 4ed131d0bb15 ("IB/mlx5: Expose dynamic mmap allocation")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next

Thanks,
Jason

