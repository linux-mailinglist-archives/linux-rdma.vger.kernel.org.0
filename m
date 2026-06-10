Return-Path: <linux-rdma+bounces-22092-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OjezKEenKWrfbQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22092-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 20:04:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C38066C27C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 20:04:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=fJx9H4jp;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22092-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22092-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D8DF3019175
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC65D3546F3;
	Wed, 10 Jun 2026 18:03:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78563345CBC;
	Wed, 10 Jun 2026 18:03:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114624; cv=fail; b=m0odCxTws+rX1tq8RlZBZErHDvo4JJmyU31CEZQeM2Y+ZTeKorVO1fXjbu22T6vYhwQivlvDDwA9hW5ugubDmByfbl3p8wbQMaADdpdtO7+GNEmKlCwS1Jvzqt5q63vHth86AkfFuJangWLCza3YaZ4mCllQ5wG4u5/JkAZ6ZSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114624; c=relaxed/simple;
	bh=GgBrHa3d/uggcnGpB2opt39bZR1hnkx617XfjdO1bV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ky9zvavTU/FNWy0Sgzj5Stq5SGgw1B4wSt9XyfryFAED5Tt5borrswZeq8msITUFjhsDjbADfo3BBvMA+UDzs1/xW10P+AeZHNyRN2MZhN6dFEyXiQnkBwKW4h7b4w+f4mmMYHYefb6DAz0rD0cDIPoqEqbjiP0+4JQ31I/f5nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fJx9H4jp; arc=fail smtp.client-ip=52.101.52.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbqvDcE/dw8vvBfhRY207OlKhu/qPOAGSqoKJarRx8UuoveWNAhptO/ABP9rgxGXf4wU6gQp8aOZULvZWAn/8KW5yr4/P6yCn9Tzym143Mcd40FnCe5/nXlQag4JgagNqVKJ5qxkUxlC/YaD8E5ZpuhQM8dmUngyWiXqRsGyf6+a4qzNcsMRG/NWki4uQlEWGKiS4zvyUc4RoV9Dqyle0hG5u8uLMyBYM0ak1C8r7CUi8mhZiFHiGVDBj9G4WdeRudn34mtoe7aJmV4wIIpFO2JOGYS0Y88L5EuVFn6GbkgrmzBCpUzzD9jO7YtOqvd1ToW04+oMH1SrlfGlBD23Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJNbQCUEWAE6/HkEgSyMWQYqT9AgONEy3n6/4OC2Vl8=;
 b=ewDrec7kPdeoYe+bWERCB5YYM0KTe7VYTCg9IOLL3Z3PqHhSdowU7RoG5dneoFKreJjjeRQ9relBaESvEx79OfLEJThKS2y9TjFPu8zIHR3/YwJF3v7kaGAq6btQkjLUIJrPE1bKQC8gCm+2DlVT3ub2NmV5LKTsnlUhwVtepnsUgruTNUFBZ+r8LTkHnzFndUmKRKF2BvYDciQwb/GCjnLG2v/rSckMa6T8lsg4wtXzB3vRHoEXkLSpoZg9UZqu4XmvXlJdQ3v+s8Sj0ia7r67+Eei2zWC6QwvazGz4dD+KV360ivr6EXdyvEMiEGsx5WTvMog8FWhIpbzmF+MHAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJNbQCUEWAE6/HkEgSyMWQYqT9AgONEy3n6/4OC2Vl8=;
 b=fJx9H4jpq5ea6Psz6eqragVOPJMflK2T/Wq9JmJolfJ7HMOY+mMFixoe//syJ2c8N6XGzqDvo9JtZe82a9A2PodCHeMA/EAdymWqKJ5uAYyP9sBdxGEP9Vf9lACwr2S902PBrZWlYodgUUjWw6lbn70KGWFw/7CknoIy8APnBHvOOlxE0jAaZCTojALCcT2gH+vPU3qKJpsCZRnSsvB4VrLCtxkKBya4AUECTFPprBMAOhBRcl+pqwsK4Z2jPA621zs9z2J8Y2pk/ejWWWMt7vym02i0nW2bWy1FFsNHBtLm2ChytrN9T50cjWUQEYW2U62iZeE80rq19rJ6VXlSNg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 18:03:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 18:03:34 +0000
Date: Wed, 10 Jun 2026 15:03:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Fix broadcast address falsely
 detected as local
Message-ID: <20260610180332.GA1017469@nvidia.com>
References: <20260609-fix-rdma-resolve-addr-v1-1-449b8b4e6c09@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-fix-rdma-resolve-addr-v1-1-449b8b4e6c09@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0868.namprd03.prod.outlook.com
 (2603:10b6:408:13d::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: b703b073-0a46-484a-f283-08dec71a966c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|5023799004|56012099006|11063799006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bdnvEsNhK3rmmUTQuugcH7giuL9tBnI6q/O1WMSddrHlAn9LavdpK6rqfwubxVNR7AlchiLI4W4ncH90wJTnMo2JxC31g4EObHz9nZXNXf66I4F4LeB/cxJC6+sgQ96V21nB/d3eYsmIgiongba1qbjf284n+S1P1iD9NhMhMglQczfoymAlToWhkvS3rjMT6n0cK4wDQ6cXCkBHncJejKsvVcGzZ8DB+1MyUaT1uT8jrgjsatj7DDfP8zRouz0JBbLcEpH4TX2ivKgcPQzXMZOXZDLTFPQc2eIxGzuCoTa48ci7Eyw7QWZcbmDi+Mtj8pe2B125WQ60ZUP2PgtylE+jDNON+z5BlmdYNudWVIS2cAy+sbKY80ty1CWFZYhMDccKLVLIUw8oEjUHA4CbQ7wUFnREiCMSr7JHalL/irAq6P3AugCM4w9kFt0PiqP5vwoew8O2XXMSWLGTrouxUResr3IWlvPV4aq2SGJql2Gw+Dl0pkVsP5WW8O9eHJbwsgriz5sQRCyBEtJ+Fnv0sr4k8XMjDBzl6YtLe3EeexuxgUv1daxPYkjQ4MbCK6ftNOVGLYmV+AR9mnDFTGbrO/ITeogHCuee4TXjAf9GTTJMX6YFYpdwZAzH4gHOGbE/N2yd8L/viNQruOZhzfuehmRr9BuAMQyamBZy/yD65rbUT75Kc/w77RBIM8gW9Fd0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(5023799004)(56012099006)(11063799006)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JNvOf1M9yq7R9tOrXURc/KjibgJ0IY57Mp6wsEs8Cbs4+P026KKveYepyrUF?=
 =?us-ascii?Q?8Sbp9eo0P+OFlLwy5FuRGXy6YEZnrzA9Lud7FejFBKi9MPUMTTTyXB2l4VpO?=
 =?us-ascii?Q?uU0E/yY3EGvV1GenZFH2fO3si1FHolbgGe6XgzK5qxwM8K6W9SuFW3z5I4iD?=
 =?us-ascii?Q?ijIo/XP1tq6vPFHgNpyWxzm4hi2X6mh8G1Td6fL5HtAq5ConeYM3nLP9oXCY?=
 =?us-ascii?Q?neshiAR/+ysGKXGETVyihU/0S8/MgUCHWKXWQa2AgxJfM/0uB6gVp72yYbJz?=
 =?us-ascii?Q?Q5ILVrM5iLSCyRYAKm+xMJNJplRYM5lln5JB/dJhNGv0bZ4C4VIcq9buy7du?=
 =?us-ascii?Q?M5a4Z8lRCcFoJAJrtUEqn+XcAyeOLeD9hb5MRmuyOKKPTHwEUHf2zTSPUhAR?=
 =?us-ascii?Q?fgrEqr+xK8xv6xkkhRjXliQaGFS/i149MaZtOnAt/GKBOyZnjKssupRIiK6Y?=
 =?us-ascii?Q?/Zn2B2Et8UjDFpMbPBtHonzVoVipvrnBZfXcu/GbX5SarvNcLyqRNu9O8mq4?=
 =?us-ascii?Q?KyMb0z336z1+J2k15jP5eGOahHW1KL63eYajdVpx8bFH3L75ZqIciTIiM9az?=
 =?us-ascii?Q?77EH432dmhCUnEXf9wXxdV6te+EHGdskX0NitreYryv+7l3EcKLc5WNRzx7Y?=
 =?us-ascii?Q?iPia6IT5xbnLEKMWnFnHEvRck4ElKVk5RrIC4SK7xSKXsZjSsq/qjMCGeFPv?=
 =?us-ascii?Q?8Zm25DwQTdtUOba/hxIE2yrcFJS/4oriHD5cqBKmSGBrpEfvrJGHgQurF1Sr?=
 =?us-ascii?Q?IUJ6CNfK3Z41mx9iGTqd4Ry8YDSf+F01GfWRoUjSZfnOSXA3K7hX9l1nkwcC?=
 =?us-ascii?Q?v2hK+4jJOX7Fgis2tWAxIC47HaDlfFbgpHYOswZa1spmL6CtShCi2haoGeym?=
 =?us-ascii?Q?NS/GoRPb1cv9IupVZqZ2XLDLSDeJBLShcAOZGJUUVmBoSjfk9gLD8TsATuUh?=
 =?us-ascii?Q?km1P/xsTBAhdyWMjwsCN03Ah0D5hcESLET795iK4XGG1ZoPl7Zjl2cKYaveU?=
 =?us-ascii?Q?mxv+hdDb5LrtttZRbveVQATc2ibXbi5qAJI3awzE22plwI4sUy5fE9D1dgIU?=
 =?us-ascii?Q?nK8D1zx2Vzz/CPpQZ6BXY9w6exF1Vj1w0+9bPEIjRtKbnBH1Tno1peC3rHMX?=
 =?us-ascii?Q?2A+1SkKU3Ie3PYW9wg1DD/D5gVbNuhCrpRMfHHIDPbsJtYR5Pk7/haGxDTKs?=
 =?us-ascii?Q?gynOzg/ABbLPjG9/q1LUYu5vAXBJJpb4mu+sLV2O4Hc2soOpOEKsusvEV04X?=
 =?us-ascii?Q?zZ/pXusqIjYBdnp8sCvnWv87MkbJyXLdzaD1FISmPlDsXnZQ3KntFjm491Qc?=
 =?us-ascii?Q?dKSwz9/FuDCfGvEprdMvjaFA6N/MUkCjHUNUwO254v5h41L8XuoEK6E4WG4D?=
 =?us-ascii?Q?XMHT6jarvpM4ycXryN+1t5C3JxtJkSfvjxyZ0qeddR90GjD6xJjQeLzBolTh?=
 =?us-ascii?Q?R7Xl2WKXVcZR2zIjugythTOSUgoEE9n7SFK8DcCXlRvyPU3A7tcZcVhI+TgY?=
 =?us-ascii?Q?KsnZVNqPIkqPs4vxQJZG4mmQ5HgZxWuxQwvoWXi60L/cS9+ajpGh1gbWhpyt?=
 =?us-ascii?Q?MfrPDtCp1cbIQZ8hokUk8R7YNK3hPYsGYoRd9lZa/YjnC4e9pt1CUqWhSwzn?=
 =?us-ascii?Q?m+ecotxDskMo4s9SrhXroz9cNJQbRXQzl2vRrtj33RJu1LUtPezSJGwAYlq/?=
 =?us-ascii?Q?hShgIUzBEItVXvOt7OTLDbWALxlkXYH26BBa1ozIDujjZ5UX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b703b073-0a46-484a-f283-08dec71a966c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 18:03:34.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICWw66tEKOlgSkTDIcDYMdvFCIqhAW5WZ321n6g0M3yhbaRctIrlPChcQuaXnZD1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22092-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edwards@nvidia.com,m:leon@kernel.org,m:parav@nvidia.com,m:vdumitrescu@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:msanalla@nvidia.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C38066C27C

On Tue, Jun 09, 2026 at 02:16:38PM +0300, Edward Srouji wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> When rdma_resolve_addr() is invoked with a broadcast destination on an
> IPoIB interface, is_dst_local() inspects the resolved route and
> incorrectly concludes that the address is local. As a result, the
> resolution fails with -ENODEV.
> The issue stems from using '&' to compare rt_type with RTN_LOCAL. The
> RTN_* values form a sequential enum, not a bitmask (RTN_LOCAL=2,
> RTN_BROADCAST=3). Thus, "rt_type & RTN_LOCAL" yields a non-zero result
> for a broadcast route as well.
> 
> Replace '&' with '==' when comparing rt_type against RTN_LOCAL.
> 
> Cc: stable@vger.kernel.org
> Fixes: c31e4038c97f ("RDMA/core: Use route entry flag to decide on loopback traffic")
> Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> ---
>  drivers/infiniband/core/addr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next

Thanks,
Jason

