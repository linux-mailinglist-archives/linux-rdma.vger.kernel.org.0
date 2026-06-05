Return-Path: <linux-rdma+bounces-21842-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +pbQII72ImpKfwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21842-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 18:17:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F03D3649AE4
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 18:17:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=SNsOTZhC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21842-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21842-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4121E30173BC
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119C93CE083;
	Fri,  5 Jun 2026 16:09:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F9433893D;
	Fri,  5 Jun 2026 16:09:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675762; cv=fail; b=iZ/0OPsQ0VjzbMstyPpm8jGXf9wnyZe0FCXNGWU1AWPREa99v59rFl3L2TmNh1ZzdL/EQ2dtuwS8w7M4uXNExjsj+uYi7Iyv16UVtIctF5yQ/+IgEpn6kYfUM0O+nCkv+fvF5svmsRmdK5MvArRgZ585TNXq7pKHhc8Z7/OCW1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675762; c=relaxed/simple;
	bh=dOT8BCx2KUP+4Mln+EX37NU5wiBeH66P08eLxSnAtUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ujBTYCziyqv0IcPgZlKkuE3/+WhXZYXDnfo9JoLps0qKg3IcEqIIwLFIC9R52xBCNa5fAYCF0sLeC390k+ct4bMtlB0dsOjT6FFQWidSutic0fkdyWxf+HE58tVaYPV33UpszJURj1gUPa5mvpEzpgdpBKoUvSBLl/Dj0gSUzcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SNsOTZhC; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNOcsSovHK+26zjceoxT3UWuLAuLO69p5Q7Gm3oB0PL8CTNdOt/DdxEMDoZCd6j713OgFSFCNjQrhnoklT3uY1PF5IciN1u1Y1l/43plO7LeC2hD1H3/fQa00gfNvibCC7r/G3ozpAC/+pO1M0a4kDMcCNoVSVKHMo/+Y1VUjb+2yR2WUPpSFLWak6z9sV22rTTD1r9AarVshNswj3udUpCIlsSPlNHGizpgwxcIhi0+LyY5rVMlzJFBfd955BIrF+tEPt4iWIv3kgYDCeNkSqNeEM/370BTJqmCIdUgfqAefCqsV2G+Y6BUFd4Y8BlfkJ2HzUY4wWv9J4Cpad48zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6X8GaMDfhvo81i/hB3v0OOvEmgiILfEODZ+xfAmeVEg=;
 b=DUrrhFbqZvc6tPZftVrrEdhqoA8dU/yuI0NYaLZYJvyXKNSIYwctUq0ooKdjdDzgDK3Sp/Ssxu8GV209yfFpAnMjCUuHDj5juN52QnlmXnq+ODA/urYcibqvvxJvJonEKL+PZqpJsSfHpvvVBZkGBvG8UOko/uIRzz5uiKTuwXIY9EHWEKhTUyCMdZcltN+itrS974Quj1rkIcBaam+maCUY+0XqyB9KzUZew2N2bm1K5dvq898FCJ5dRTd+K5TZtLs2rI/v0GxiMuJhlkDjXWCH9o+uOSlzf1dw4H+XQ1sI4TiOVBjAS7plF3hcfbPNX4+ILWR66Z/MjjQtCiet8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6X8GaMDfhvo81i/hB3v0OOvEmgiILfEODZ+xfAmeVEg=;
 b=SNsOTZhC3ullHIRjGsRQkEdZ4EtHB1+n7AdvxrE+mI7tkLnGt8knw8DzwZKV50Re4txYyPn8/3JvVLJ9piO6bT4NrYhvkdj6guux8oK1mOlSlq+mjGVRdpYDGKiivRfMtMQ2esra23DlnTg39ZgnUZkFXDTgsBW7s7gBchlYliF5lZ6OumfQWdX1LAXa/HiR2qth1w2nbFevDWlETXaNJHc2HMPgH3cARtxYbPef3ImKRb6KxVYa8W6cQ+aKrAz6ZnB67GfpEImIX9Ng+/JS0ivCpGnQolAjoBV5JAtzDqeLy3syAjpDnzdNX7RkjWXAAW4523Hb2Zc1clnpQjEcjw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 16:09:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:09:14 +0000
Date: Fri, 5 Jun 2026 13:09:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Leon Romanovsky <leon@kernel.org>,
	Doug Ledford <dledford@redhat.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Kees Cook <kees@kernel.org>,
	Dean Luick <dean.luick@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] [v2] RDMA/hfi1, rdmavt: open-code rvt_set_ibdev_name()
Message-ID: <20260605160913.GB2728758@nvidia.com>
References: <20260602140453.3542427-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602140453.3542427-1-arnd@kernel.org>
X-ClientProxiedBy: BL1PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 504532ac-7a1b-4827-253a-08dec31cc999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	DwSuLOdaAE6MHnCkMSUJCc/jWUFOxYh2O5i4l4G7+8Wb2s83eY+64S3uE7B1+pWWN/gUWN5zAQ/usWIp92bNIdNl4dfLNo50cnI5TrTiVqC4PR8fL3RQwsX11ElsRkEpBvssrlt++91KUFN1lj1dCPdZGXTnOQWpSuYVRYo/Q64Wg/pTfdIV0Nqnia/d+amqezr5YWIPoXJjJMVUAFNTT53wW7gL06NYWbbYiLIEXEabc9GVyxkUwQ8favyNrSdaI95TFUEG6Wh0+72XJI46PWcjtjg/GtPTgq37dvnKjLUBhEcYOkK1x0mVWq5p8R9jIVKDRAF441XMBH7dYd1KJoumSn/2ZKtxbPiHhWA7AZ/YcU2cbgCtwrlKX6sB/famPHb90wlAC7drH6eXZd1JmVwKp3iLjO2+JC6I0rf9NUbATH1n4o0c5BYuXuK52y/7hnPeQ7mYr44fNKqw2GUa+VadGZYhbO5OQK8NvOp+77Iyuct4jbsukmbDjBwhldplhRKiJxWKkIHlHPN73fglDBVn+PA6nm/22E5SqKQ2/qiRd2QSYj5BB69TAY7InivCb2kcgS74XRB2S4Cmcd89FqiYW1VP6Nz5JB1+a/TL2r2FwyQL4xzmXr9J84OXWdIamGGUkWBegGKoMuYaDD2fAZz8fJtfsClae5BB1V00HsSA/OWMi5HhtAUWao8ZpEhu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DEYKPymROBWE18NYSwMPecmPKCMpaBlJU5Ce9EpUoCLNE4l5Wk1HYbWQbjbp?=
 =?us-ascii?Q?JGEzFkc42wuOyJ3JIlHEMlvcpDpI3qv9Tx2CrBYltnP6o1yKVj3E8IQp8rjd?=
 =?us-ascii?Q?DadMGiAA0HV9KmTdi0CESaGJce5yTZS32fylcIeGhBgbzB5bEdMqH/WV/5Cn?=
 =?us-ascii?Q?Cw/QtO2cg0i0jzuhgEJELqbT+UMgtDpl5IxbOFoPY5PxUCjZ6me42zDSUx5M?=
 =?us-ascii?Q?+5jTiFqoY3a8/Q5/rgSowVPH2RqlvG5govOBM+2HTXHx9MAV1uMbVoKGHXwt?=
 =?us-ascii?Q?E0OtXjXt8sGJuTZgBLOk9qITw6lLLbpzRM62EqKe03PEmbFLbKHtU8xZA1r+?=
 =?us-ascii?Q?6uHUfvhrhSXqKDcmrtRXYkt7I+CYyerLrde2wXAaNMsaxLJT5jsThDA+73rt?=
 =?us-ascii?Q?qJIeZ/BSW0kHhH4y/Z9vhOqJo3UsoXVKrDI1dgFNmaBRQ/dwN0G151fWNkol?=
 =?us-ascii?Q?twW1UX3ut1uM/1/+AOAtt+Y79zzzRAIRYhwwI2d1S8sPT8E6HX0CxJyIhbNX?=
 =?us-ascii?Q?hYdq9pm4Lf72FOmwizG1fIc3phB6YXSEJ6nzqNDJhkLivUgkwnEdy2ibP2RG?=
 =?us-ascii?Q?gQ/vQS0f0t+8d98vrkw7pGvC3hoODfNlGTyHHV65mlEGODnmuFBUBanqhupk?=
 =?us-ascii?Q?I7lOORaKdj2SPbBFohfX0YpVbN0E6DAGdBaOPaaZ1z2MrNHi56zBZomEQZJg?=
 =?us-ascii?Q?yoQa2qKXdhKu1YZmicQJc+l6U3eflB2UhvI7u2J42aIAcAaTgx7NE/Xdo0hg?=
 =?us-ascii?Q?DRkCciIRYAoK45gzOPjboe2ACb8cJe5UgrhRk6d+keciEQ2O+FYLXJuOHVdQ?=
 =?us-ascii?Q?YGYK0q2nGNxer5IxUpd89ul0Jv9BAWEl6LBvWp7tNG2OudnAop8RxanFlSFv?=
 =?us-ascii?Q?se/MPXDHCPOuA8Gklez1JI/dYN7Mmlj0yAmhX1JQIcf5/Ts1bEj3jPS+B9YA?=
 =?us-ascii?Q?fR/4wgYCXNvt09Ru1GKyDMV7WI1orhsR641SA1XExtMEa5SMUzgerqPbpDd/?=
 =?us-ascii?Q?qiBkJxcHn+cqFc3UtHrMEgL1G0kNSZDOGq/aQb847VS40XDtKHnFkMOkifkn?=
 =?us-ascii?Q?3hZiogxatI0/RfKyd1AiYV4U3tUYQkcIPkM6UkHiYrZE1sUucYXG3KZbA57M?=
 =?us-ascii?Q?qO/DamdrytiOUTW2EP6pLutkaAFVo+5jESkUzh72Z965A6WU1KbgYvhPqgUb?=
 =?us-ascii?Q?rCamT+cC1v9hkRtoUs3MC0KjOPCMNUBTKi2QLFFML0I4gHMXr9ytafGDmAEE?=
 =?us-ascii?Q?arrj3OyPasxqXzIXAE8FAwyFRfJHztQS4SiLufJlRnRA48W73zP9GFwgV9fC?=
 =?us-ascii?Q?4vaVKsZ/cF8G/OhHFv6FSliP8kbootZbe3WtuYGYhd2I8lKIH1G7hoCPGiB0?=
 =?us-ascii?Q?odFFzHyShYpIJ8nJqRnIAKJJof0n0Pk/z/QCrexW7Ze8AFBMptLqiK01y4XZ?=
 =?us-ascii?Q?ZrV6xdHFYL258GKSodq5G9wR9y/Ifil5VhurJm2YA21EHr0/K1EBHxsXJ/MK?=
 =?us-ascii?Q?awmNpFzieF9r7gvNiWPSOZoB38QMLo6pxPFqMs2LbApUVXJEo/oTP3sZuhJk?=
 =?us-ascii?Q?pYtOJOPN1q/uqPOYx7ZdLzyyf+He4VK/P9saghC092DukQYiz6hew0A3D7Sz?=
 =?us-ascii?Q?tGH3opSLPqTB6SH8xQYTtcO5wyQi8oB007mh3ERtWDNkN1iSiiVg/eLOFAkT?=
 =?us-ascii?Q?1xxrGN3M3Ppc0c9c115vX3TnZDFzIeDW9mJWq7f7ht8MrNcs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504532ac-7a1b-4827-253a-08dec31cc999
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:09:14.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrQhRpnEPbKtMBQyLm2c+OQOYJFKUBA76W2P5xbecxmtldGjULQUygy4mj5lEZaF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-21842-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arnd@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:leon@kernel.org,m:dledford@redhat.com,m:michael.j.ruhl@intel.com,m:mike.marciniszyn@intel.com,m:arnd@arndb.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:marco.crivellari@suse.com,m:kees@kernel.org,m:dean.luick@cornelisnetworks.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[cornelisnetworks.com,kernel.org,redhat.com,intel.com,arndb.de,gmail.com,suse.com,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:mid,vger.kernel.org:from_smtp,arndb.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F03D3649AE4

On Tue, Jun 02, 2026 at 04:04:34PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns about a function missing a printf attribute:
> 
> include/rdma/rdma_vt.h:457:47: error: diagnostic behavior may be improved by adding the 'format(printf, 2, 3)' attribute to the declaration of 'rvt_set_ibdev_name' [-Werror,-Wmissing-format-attribute]
>   447 | static inline void rvt_set_ibdev_name(struct rvt_dev_info *rdi,
>       | __attribute__((format(printf, 2, 3)))
>   448 |                                       const char *fmt, const char *name,
>   449 |                                       const int unit)
> 
> The helper was originally added as an abstraction for the hfi1 and
> qib drivers needing the same thing, but now qib is gone, and hfi1
> is the only remaining user of rdma_vt.
> 
> Avoid the warning and allow the compiler to check the format string by
> open-coding the helper and directly assigning the device name.
> 
> Fixes: 5084c8ff21f2 ("IB/{rdmavt, hfi1, qib}: Self determine driver name")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---
> v2: fix typo
>     drop two other patches from the series that are no longer
>     relevant, leaving only one patch
> ---
>  drivers/infiniband/hw/hfi1/init.c | 13 ++++++++++++-
>  include/rdma/rdma_vt.h            | 20 --------------------
>  2 files changed, 12 insertions(+), 21 deletions(-)

Applied, thanks

Jason

