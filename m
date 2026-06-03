Return-Path: <linux-rdma+bounces-21679-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dne1G68jIGptwwAAu9opvQ
	(envelope-from <linux-rdma+bounces-21679-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 14:53:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C16CF637B59
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 14:53:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Y6aZzlpu;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21679-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21679-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 887E3316EF5D
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 12:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8AE47DFBC;
	Wed,  3 Jun 2026 12:41:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C5347DFBD;
	Wed,  3 Jun 2026 12:41:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490474; cv=fail; b=bHgYvObfzoyDjHwtGIbYLh5CrAOrbg/iXCsHa3oWbVhtf0H20NEZQI1cVdlRQEL5eOBtkNO/2HIC8CimhkTdYAh0CFogXjk/OLDRDZySiEPID85Z8cMH6ug0qEEs+7IvJodtUq2P7cj5et5FgdwC1sUV7fI+pCV4lwbbB6ODO1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490474; c=relaxed/simple;
	bh=/NCoc/BuwhpVlSUPmTfLgw5vMVdHpmBKr101w+YfYMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CTyQhDJA4UWXJRn3+Jpxsw4DdbqUKT/YCqVqT5izYESKEpIgaJFyNbXpw22SUK0Ao5EflHVxjelalIQp8wTQ2RXvWEjeOZPQTMUGWUPwco5HvyCG/KIO+B/J6T/H3ZQK5phA0iQw0BjkpY8uRQv7SowrZz0vdim+sK07itozypc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y6aZzlpu; arc=fail smtp.client-ip=52.101.43.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIn/dFLj1OnhJcUFnC0hvLCYLZp6ziYzvUeEnYKWzFqseMhvAy2KzTREt9EVOywuOIMqVec/srSENzLe5QrOtC6uCnS5VYAboSipLSj0HZUkaYz+XHZww/s0HMh3YLTCwvAQUr3uBuq5AuNXrqwV7/S43DNJ2ZzX5S4qoT71YpxHZJxKCYWagRIUTuCVq2uyM3uw+695VVoTQNS3inbgejO9/1v/otnpboL6xdHC+QDZg9wgjSR3ZtVtVKnU9FMR12lii/1/eSiaRzxaUBU1xbSoKS3L1+wFoRDvoEfC6ZeoFUXeOu9WPUDaLTWh/GnzDV/E859VxHE6DNqq11FUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs+viUNUi1tTatwkudodvgiODnUHr/JxZHEU0HBw1hE=;
 b=KGaKJ+nlBlwwtgeweg0nu+NB7MxvRzOHzrnoszSsGFcsL+nWFLpaokOjGuRPymn2mm3PF/K1IO2jPnj4+B+UQChmO2UC/lnBe9OXMeuszMuR1Chf8ZHGchNEHYGV1dgExTNqQk1FkyoDam2r/FvRINVA/WPeWZYFNPCgdBrNMNmub96pwXRWPUhYKDCMgcaFB87H4kGcbdB28eO0Zr/0gPMheEo8vsAKMBjcUXepPa3tu9gaqFEAycLtXqXqzGrxWpUsTBlPUBQ680pKwYnetu8JH2cAQLfDZRXtkZIxh9HvlhWY864YWfIuRMDBG2pXx6wgEHr462jCkssuTUbD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs+viUNUi1tTatwkudodvgiODnUHr/JxZHEU0HBw1hE=;
 b=Y6aZzlpu7+/GFsFvEvIIov2fqgiqxseqIH7+HExFnj4eisFEtw9E7iX6Y7BMh40ip9W2Y2wOnxWhMpjuSm3Bs9pQQEgSEQus8rMXTee4cZT5ZexRBkSfGD2Cgnb8uIJcU6E1BaFtd6GHOturDN+PqoW6oh4mF4mXls3+JStY3lFTLlSMsnPb1WGxuFftXfoOrQ1wScIfcAK9JwKDGSJbnC40n03AXr//K+sl6MBdr8tUOz0cki24Wo42KjBP8JpcHyXKcwOKuaQueWr00dqEuZz8cH3u6rz6cv7gKbzRlZnCWBc9ZRqwrZc4sg4LzcGOlV5cOC/5alW9LJ79/bX8Ig==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 3 Jun 2026
 12:41:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 12:41:07 +0000
Date: Wed, 3 Jun 2026 09:41:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc: patches@lists.linux.dev, Shiraz Saleem <shiraz.saleem@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix typing issues in the umem code
Message-ID: <20260603124106.GA1429219@nvidia.com>
References: <0-v1-88303e9e509f+f7-ib_umem_types_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-88303e9e509f+f7-ib_umem_types_jgg@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: 545debd5-24ed-4ce7-3e31-08dec16d61ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Q4areJ1gszdbs2cvW9lhESK5DSpQoFSm9TU7IvaAdQ2/DRe6E7nZnD9HbNxg/UJT+H4MtnTlDe4K/5zNWLUrCIS7Idff/uNjdrrB3JVUhCHOcWhfsDfp7wJdeNmTfeJoj2uErbzekZpGfmLWbOqpmBzUAk+0LmDRZ8WaQWiRMlQ3p2SIOG3UJU0V5zoErKPtlo8WBfKHwsLy+AKCT0mJKhADmlUk7UXBojN+Y/6x7SNi0bRTxBLqUnSRnU/gyt4Skb1ibBBPsyd0BmfLtv2WRU7+LXRtGlln2BuI+UhHjeqaRArbReh05DDM7ZBJU3FFHt1j2Yot8LpkaK5/c7K3Pti3TOlQRufYY99BaxTLZMlau4mvhEVKwR7gJp5jLMwL1/lDYp9Ep0jQwkddbq9E9nFJei4eMLzXBDgrgBYO7UJ/6+Bj6EaCdI5Ap8m/wHBB1aLZL+2Bc54pZA3aU0RUPvGI/IMGdYPcxQxHZ4Ep10bfafRoFpbrlziq5wbktRhYlmbw/Z+0tri3Z1yLvX2JlxV4MyC/5bGfgyXkicOIEWajRg7fkZ+cEj6tyn1wAz8ZvzlttzSTRIQJ5sPW/6K5p5ogIRyW9Hq7+NK5akIxnIuwi4ENgKYWKu8GvqsQfEXrzcDwLkFALKfGldQu8IG9/29IgniGYHGzhZaoDoyBSH4bT8sDAyQLmIeN52Fvfwlc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?smoi2rn5ZBj6xq2j1F/+uT1E1aPiYxYCUIh4zIbGnCJZnZZaAvfbiwGNw8xC?=
 =?us-ascii?Q?/0i1FZ4NSZGO0AaBMjbFPVsOsytbq9w88dwUkQHaF4AnUL+NETstD76GDGFp?=
 =?us-ascii?Q?FdK1Tak7mGygyXRGw2xW77qHKlu3wMk5aKM9CkKlZWh5b1nsTNJWjwqry9/a?=
 =?us-ascii?Q?bkYEmnekrEiLtwAJ7oVF2k1QbBjAcTTq6cY+cFfL6PuZ8ituZx4z6gXbtK+y?=
 =?us-ascii?Q?Pe43WOKkLy0HhotfnHeaiRLDYSUaP5tQCooH5LsZ3VQ4cKoy12o8W3xafzUp?=
 =?us-ascii?Q?1pGzFokrW1ZVSQBB8Dcyr7R6PoKVOAwiLOdLkeJs6AorkIywRRa7IGi1UYwz?=
 =?us-ascii?Q?uJ9bozD6RGR7figcu3VtywPTjkjOBjPUvLq6f5S9zwwEhtzAzyba+bfR0ajH?=
 =?us-ascii?Q?Gf92B/YBxQvlvWm7sbZqVr/WTJ/zqMlrebYw/YMlQrmaHhpOHja6iO5cGuOf?=
 =?us-ascii?Q?MjZg50oodp/capoblHml734TqO6kDLosOPJ+kwQ90+UNcMy+3FNLMrUjEwAn?=
 =?us-ascii?Q?ek2n3+UWlxn71Evd64s+8Nbx/6vwpfU4ol4VoX9Rj8LddNisD3FEvdwnPpJ0?=
 =?us-ascii?Q?Cxtv6YfiKEds1jD6lyxwmvegLh1Gygi8IkcRXjPzQ15rRF01/0EqCSFCd8eq?=
 =?us-ascii?Q?0KK2TaR6G0kJv374Mypy8U4afVh1QB0vKs7TY1INL5BHBLElCcUFzuVjRiZ0?=
 =?us-ascii?Q?fR9Ch6kVvzUidoxicRkcaau8i+XE5KSEzGYnZhIsMXJvYFwtV8N2JQYJb6Nv?=
 =?us-ascii?Q?Ihg7/7lYpsiaQJaTUgz5+tTLgOnKfsmy/ljWRCUy5OqG2U+Sxswv+0pDwQPl?=
 =?us-ascii?Q?BIugodXrmORtEqeJUey30tJVWCtjpvGdI8uUX0pJ5v3L7C9AAbRzsYtnq02K?=
 =?us-ascii?Q?DqJC5Fym6vAUaJyPN65Tv/VqZpYQC3we8pYOoSLs0I0tG1tK8ozHBR4Sdayl?=
 =?us-ascii?Q?9B/7yERNKWv55VnGz1Qa4rTYo9dUlcd5q3x8dvdEZXjKZlzosYVH+anqJWIu?=
 =?us-ascii?Q?qLNr9f1b22wUOELbKZQUqQkSQYtTIzprVfSQLRcvDbYmXqKDc8KSWFl6l/0c?=
 =?us-ascii?Q?DzZQIBDKkKfkyz7sepPKZbjrKi9wPiCH152GfnG1BkrDcq4xnoxw5fKvrjbd?=
 =?us-ascii?Q?SBzs8TPTpBgGnWsnnCEmkFgvV+AUXbPvApDik8VWklZEAQh7BnSvWLbobd8Z?=
 =?us-ascii?Q?nE/1pZBkqyZI8mqIUFVN6p3OVLRHNx6uzv+stj318EzZSTqQFFzDfybiok/p?=
 =?us-ascii?Q?UThegONmf+J0S2z+nyCxW6c1HIeexgxpuhGpZ81WvpongOyjGQe5ZX/hd+nr?=
 =?us-ascii?Q?Y4C8L/RUQKCU6VZAK5GCI/sn7fFKrNyb2FQAtj/fAFBd4/KLjgmHzckjgfNO?=
 =?us-ascii?Q?o4bz5xWOTz9efOE6bVwoZCpVnMvdb/daMksAC2ujdXKgbUeZvgLng6TMjU04?=
 =?us-ascii?Q?4g6W83F7e2tDwBKvcH7LFECdBP8szVbytbbg7zVHaV2ZCOgyJzq7KVb+Bvus?=
 =?us-ascii?Q?VP5HgkYeCGQ/HptbCmAO+1xY+t4Tz9nibhqI9ffC+cqyM5NdlWwvr4vGaTYj?=
 =?us-ascii?Q?lnCdEAb1STC3lBi2z6r7qZgvpqMlvybvY0FWbiDR9aBxlZewa+K2xSXzE9G4?=
 =?us-ascii?Q?KBN4+XldXISj/Hhhqd7qwS4QUgloZkv4OLqbGCIkBcc3xvHmHPAHEvWAQSSG?=
 =?us-ascii?Q?YUh2r9AdYhKxxWJ9TfEcWfwutvKKD7CntXYR7Hz8PSqldiQP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545debd5-24ed-4ce7-3e31-08dec16d61ce
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 12:41:07.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wfP/hVyF4I33ifptB6kwomT1KFICg+CAzj82ylcAAsUimn7Z9AzwwpANxfeb5K8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21679-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:patches@lists.linux.dev,m:shiraz.saleem@intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:mid,vger.kernel.org:from_smtp,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C16CF637B59

On Mon, Jun 01, 2026 at 01:52:30PM -0300, Jason Gunthorpe wrote:
> The types are tricky here as we have a mixture of u64, dma_addr_t and
> unsigned long used purposefully for different things:
>  - The on-the-wire IOVA address of the MR is u64
>  - The dma address is dma_addr_t which can be u32 or u64
>  - unsigned long is used for pgsize, mostly because a bunch of bit math
>    helper functions are used and they are obnoxious to use u64
> 
> Fix various silent truncations, issues on 32 bit compiles and
> understandability.
> 
> Jason Gunthorpe (3):
>   RDMA/umem: Fix truncation for block sizes >= 4G
>   RDMA/umem: Be careful about boundary conditions in
>     ib_umem_find_best_pgsz()
>   RDMA/umem: Make ib_umem_is_contiguous() safe on 32 bit

I picked up t he first patch to -rc

Jason

