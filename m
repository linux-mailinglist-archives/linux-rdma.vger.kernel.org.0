Return-Path: <linux-rdma+bounces-21157-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPhwFNNrEGqgXAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21157-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 16:44:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5236F5B667B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BDAA3095A0B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D2B41C2F2;
	Fri, 22 May 2026 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qpC8d9ku"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0A4219E4
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458730; cv=fail; b=BVjSjC7LDLGfkb53gou6Bv4Zt9lgxVpICe90xaNndIRu2H6aMm8DpsLFFPBjR5BwmmnbAnorttB18YHLOw7tQdpWH1qMkiM17xAO0KzOLfGomuD++ORPfXuJHEf9x5K/2CYvM2fow7ZjjERrekbgEFkaabvVjWJj8ZD8e+ZbHRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458730; c=relaxed/simple;
	bh=ir3y4x0pMauhci5d28EzVGleuzfoS2VA/DKMxsEMaak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nyeEmzj+wpbID4U+Lh4vG1Fy4UrHq1qQXwTNmM9+2esGZvRxUzVNDYHFP2CK0GHbtXz9A5CU5SY8HiWd6QsBSSqh0McWsERxEp9ndIJff/3NzL+2P0jaOfXTNIcb0fK140S7ay+V8yBTxYJ1N1JSY9x00Cm5sMXmByvmE5LJJZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qpC8d9ku; arc=fail smtp.client-ip=52.101.43.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVlDg91hPOxYLMDdo/x71VMD4JO1PVytuVaHn5AQHfXPKqzeAlg0UrLzX2qRLDhlWeOMqbsr/xfzphAIzM5k550rv8f1pUDKzJvyrMwAO39gdo0JsF9iOfg7ngBgKw4b/PFmS/qfJEk4hqHL6Tn//j3q0pLdLd+ZidoqjDgxBS9Cr3hwbElHTUQ9UCiC7FdSDyEb9I6XLocIawyidQY04zqSkMlSxItokP415QsOUVfAzjaH9wHL/6mWplGWkLyYc2qsfBvUylap+z1aVwEmpsgH6xo5NXiMQpRTPVL7psZBxfi9LgVHRVajq7897gvpCAaw1N0J21Bmj/DXT2MlLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9InmD2yfoHS4V51ApZT65T3g5Trq/N5PT9kgpK++q6w=;
 b=mJaDe+3MlobKniEFV87KwmK3J/dmJ3bTNPjngpgz1p9K25WuUxXEAr2p64Qg0Jpw5qIdgNH9mYa8hMTO2DXyBpa3oiqBww//sGVnhxf5c4iLuZvjEH1sBTSENM8LwubkGo4Zfs6YylZveNK6fXhOAs4iaw77ib7bW7dREYo4zR6KMUPhUb8qYTY163H/Jgq1ldWkD0Ua6tHXNbNV8P9pMRwHZGROxUfNcQi0ArWrsG/RBbJxQKZz4V7dHYCONaCFce/l2gh12TnILO7GWDh1KWjyUIXH9YVgWaI51/i1M8yUhPr2/MCZaknT6YQEdNPNBzGIdbuxPitBacegc8hsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9InmD2yfoHS4V51ApZT65T3g5Trq/N5PT9kgpK++q6w=;
 b=qpC8d9kuxuZUh+Q+3x8eT7f9uuZp/jAPCYuKcJD2zIEx+h3UE2ILN7QE9Y2GrxuDNjJ4oUp5MoeL6VgqA+WeKH96ouwAd0hDfzqFKO0B1HMm3wk+/d4QszNhH33DX1VGtxCO1+5FExS4gXoORYUQrCGqwHHeJCEqp9kytaOZE8WD5K51kOOgkT086wTi498bps2NRaV7mljLL7i4W95mR82Yxz4+zpj3s5OYllgx6vsif+UUhoYIJCySqmQhljxAJfbXVTC05EXLzL2cZyaS1GMWGFzHV0Vh8CemeL/J7Q60MMo9rdPpdXd/zqJsg4iUW/Y0Qx0Xi7dWZkwqnllKEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 14:05:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:05:19 +0000
Date: Fri, 22 May 2026 11:05:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	patches@lists.linux.dev,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: Re: [PATCH 5/6] RDMA/core: Move ucaps into ib_uverbs_support.ko
Message-ID: <20260522140518.GL3602937@nvidia.com>
References: <0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
 <5-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
 <aglX-m1INAy_MfTh@FV6GYCPJ69>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aglX-m1INAy_MfTh@FV6GYCPJ69>
X-ClientProxiedBy: YT4PR01CA0308.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f88118-e8aa-41c0-8ad5-08deb80b2853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|4143699003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	j6NCLcoxYTnSmotTMJ2b5uuWUHGy4rmnsrYWB4OCADKQx+klDMBWsEqhvikI48vfJh11BRas2Hq0yRiscqzGMI+JlPeSYhtRwJC2jHeMj2IRD/7Ej5A/Yx1+GOIfB4fhM0dWxmb5r5cA8ZUnZYFfxzzpUiQ8IwP/qzVumyilaLDJj/iIb1fH9rl2haLiGj5XtsvDGL1GSDn7qo4iozrTFR6XKSoQxuQUW0VPutjZBsY9kTpJeckWzfJQXd6ZLhJ8bie4vH7aQCVALOemX7cL7dr5/J7z1+xD+vSYdzLBYxfiyTqZv8Hk1Q8qJynjUWVDXJvgJeJU7gr6VLFOiIgn7THwT3a9+JJ1iHwaGnq2PPJ1HRGRzwOpQIyGb9mah2dz//rmTJYWyHT0fqEcrmvtKZiRtim1M82jRY97vpideBLgL5omsUL8oTandR/Xdix/GXbcH+XIs/RM6jEDXGdYKo9ibCObLHj+E1tffossbXWlNLFjidnloTJTB0uAtrXjBhDLWFtHxoTPq2ls5//bd1PVSYAtUg4KqO3VXNzARRULi3ZehyjGrHku0GSdiLEHbmRjYkM16lB/rSkp6wLZHJbzpa/oKzzw2Y0QOSayMyvHmeXiRo/R3tBsbxfEgNTb+YXo/1s+ae9+Bn4OyRC1nen2CJ2ZxLLl7SjsrNZ2WA4JLFsmbU9B+Hr0lpu+NPIg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(4143699003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dfGwKmbekDmiBGrq7H/lnTLCLu5xU2UnYRwcnTRaOs/QTV5cRnCSqgUu5rxq?=
 =?us-ascii?Q?Oe1v0yTjF7bRN4D9nNSR31hhl6eZFLJxZOXuMBVYWYQQB78kZ08eFo4Mhd+d?=
 =?us-ascii?Q?jdbZaVkuw+X+C9ZYPlxgupVUQ50e7N5C09f7sAiW4gIxCoLnKva1zlMZQW9l?=
 =?us-ascii?Q?KmPh7Sk9AZY65+Bi5WiaLn4edK9L9ayHZJ3Q4Hixg0Bl+pj8VfKlldipRB/0?=
 =?us-ascii?Q?JhW234LNsxgmNrskbKU6an4ifB6ap1u90iLN9kXNMgWTWTZj/EAZiXlcinG2?=
 =?us-ascii?Q?/uEp+cgAxGZQuDibywRBYIG547H+3fv3Hxd32fAiz+aPVCgyaNmrpCVxpDiN?=
 =?us-ascii?Q?+3LjHMQhK6KDe3sDjTvZysgEUjrHsULqrDdwonShcIDytH8dt6UJWPzwU/zk?=
 =?us-ascii?Q?vziVZBSqbDB50phmzVi6uezMA8pmlWnXjbdOee36loZlVNTvORpSq0F7jHZD?=
 =?us-ascii?Q?E+6P9eysCGC65NTSp2v+fZiLUWsh3SJG20m3kOfcDQFXLdTMJ4nkOB35RwyY?=
 =?us-ascii?Q?g2p9vcFDkiOcThgpS08nB2zXlAGxRPbGZdFpK49vkn2um3cUVjabEYi+aXmv?=
 =?us-ascii?Q?lYUwKw3ZREUjiqsXFWTxJPYSMvUJde+MnekSR0Z7G6gpHES5irfYHoAMszcn?=
 =?us-ascii?Q?xgDTB5sxtivw9d9vhfykZQBpWtDrm6oJoh61O8UEw+doUA1B5RaM3HjudPi1?=
 =?us-ascii?Q?kRe+eJTfxSdlxIu+EDGxl0iq7dXPi7a0QMvnydThUDgNxDcWTJ2GY9eARQtF?=
 =?us-ascii?Q?Q5Dbbt2lwTNirNvgv+mwzic0nXBdKqR8hZ6/fQcrciMs5ZYsknh9FFXCo693?=
 =?us-ascii?Q?b4Hgf4bSPkmzC18qUaAyqefCGbUiYdX5xOd4TS6jOawkWaRV2W9M9HOqoY8v?=
 =?us-ascii?Q?pQ4UKVA/PvQLV3ZHAOqQKiq8/Dw6fxu7OyH6FcHJp/6vh6NWrZABFY8A00Af?=
 =?us-ascii?Q?4KfZkiIdJONTPIEmI0Q5vafy6dxtGVsfI1gK7s2/7yrniu5TIFLB/Dx54a3g?=
 =?us-ascii?Q?6RHnjuxgyi5c/2NJwOIjFNh+65F30BV/fQvjb/MnvO/pASuucqSufZESgQga?=
 =?us-ascii?Q?sqbtCgbGjsF71dz1wg+TKkuesZuR7wEz2+OZBU/PDP7NNIGmw2AXk/VshJpj?=
 =?us-ascii?Q?lEQE9zXjUw4Nlz2oohGfleutD6kccjoho2FM5caHWIoEXD/QINOjXeAQplZo?=
 =?us-ascii?Q?E6omg7dGJlX7Llnu5h8oqnAJIQUINT+Is82B076j0uW9vWmgOmOnGRvzh3qy?=
 =?us-ascii?Q?tjo7UuTYnvOEpCz/7eIhSz150KMpnjaY1z27aRRYeRypVpU6cQQRJSX7JRIC?=
 =?us-ascii?Q?Uhw9qbI14e2BZ4n0v39lB17V4q5Reooawt+/ujRiHxNm5JpQruJbdOxalx2a?=
 =?us-ascii?Q?tznrxBfGu7GiITYXTTBq/zGxKBAThbf+p6SVWXOqt1ii0bRfQgeUFJcl8On7?=
 =?us-ascii?Q?GJTT013Sh5u18lOCE3iUrEtRl19sJjII+tC/E8H4PwBrazUw5nxJbRDbfRXc?=
 =?us-ascii?Q?0ysYzsVdjbytbxpBVqcV9aiEF/wsawcVeH4AzJGFn1ZRx5tVkANVUW2fRLvF?=
 =?us-ascii?Q?2pmcfpTCeKLj0hxxkUI5Yl8kuAQhoIKigv0TcEG8U1QRSlRHR3gHg+77mj6e?=
 =?us-ascii?Q?GbTI/+EckAJJCUlAvJDwnOjhC9tnZh2WKdRh6lf2KVFNaDB1jPDBhMUrQh9l?=
 =?us-ascii?Q?SUb/l9zSlQlt6YXGvMawfP2Y/lGy/m4sCD0DVg4zUaRbnsxP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f88118-e8aa-41c0-8ad5-08deb80b2853
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:05:19.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TciPsz16OerQymF3QjRQDJMeMjFJa0vLoDniDL9nw/NF5Kx3omjggh4GqNadzSC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21157-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail,Nvidia.com:server fail,nvidia.com:server fail];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 5236F5B667B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 07:56:52AM +0200, Jiri Pirko wrote:

> >@@ -265,3 +266,6 @@ int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask)
> > 	mutex_unlock(&ucaps_mutex);
> > 	return ret;
> > }
> >+EXPORT_SYMBOL_NS_GPL(ib_get_ucaps, "rdma_core");
> >+
> >+module_init(ib_cleanup_ucaps);
> 
> Shouldn't this be module_exit()?

Right, must have missed a build or something

Thanks,
Jason

