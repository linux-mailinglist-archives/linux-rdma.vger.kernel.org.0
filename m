Return-Path: <linux-rdma+bounces-21853-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MSCnE90FI2rUggEAu9opvQ
	(envelope-from <linux-rdma+bounces-21853-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:22:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEAC64A1E6
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:22:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=anXTnPIC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21853-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21853-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 716C53036D4B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0649528541A;
	Fri,  5 Jun 2026 17:11:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DCD70808
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 17:11:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679502; cv=fail; b=KE+aFCNl4Vdj3uL/1+3c3MGY6OP0aOdfXgVH333OkTDR9llKGZLEly8UsJSlxyKfFd8baaoJCm2yHftIWE8fpuzKHEQuWZCqdtUCEi9H1nWHcsxTAhMO+2TgpxMpKNcwb/tBxlFic2qFzL+cs1bNaCt4jWcD9hLukjTny8KbeFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679502; c=relaxed/simple;
	bh=wIFUTQ7UDo8/eVh0b9oyl9mvOIVEYHB6PrM1dANmRhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VJ5ouYj9yv2wJc6PBBxqOPTs6cbaK+oaWAVK1VJXFpcMteGsHdJKZEUOhhX+ysCP5Jl3A7vlgZpibVGgLWexp+VIM4JZRKO7YIqWkyVwxKWGkZGSf7Z1a+00bfMOBOFD+WvilUk3M0ccezOcrb8N9kkIsIyR97e7XkgYKMeawUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=anXTnPIC; arc=fail smtp.client-ip=40.107.208.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWPJ6dwUwT8FAceWODyqXq3h/7By7t9JP/WWuYS7/noZL86A6aOgj2wW+TyocZ2PhRu/xPho/Z/vWAHb1XtuWuWpMfZsgZbbuaFK+7K61g8XYZJXFgcoTpwzynQ34wWS/7auWWteC7guRtB2BkSg0luC/czIx/p5opmgZOhkjOoxxEbDOJ+Xo4CFDTdaz0QZv+s0SwAylgDWLCs/MnZW7rq8k8DDYRKC42m9JetKhTBzwh1lyCjmEcAa7hFvuhZZfpcD3fDXlAU3D0/s/NHmH0viCNSVyYoYql4Xr8TgvKOjRanZV859sOcPlVzT47gSrwhIRtZ5wLTNrn5INqAeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yKkIgbJcn/90C/+Ivyze/Cebl2SbfPq3hbZb8Njsqg=;
 b=uMWea8zZL6CwnJIaItKU+fpFB9LhHtj3EHfogVDNPgOacNoGCFU8i2qKO/GneOMpQrn/SCK/OGX3U2B2YyYOLLrXgKb3JpwzffUqZ6xkYOqYkwa02zN+A0ey9MtgEFtbs493QC/BSy8JTM5mlTGAP6eXzRLTg4mAopm4zoRbCqOOqr0fjU1Ex1EPSbdo/2tWVo4DT9D8yaGGdS6ikWnLfk/fr/UCk+gKUdQwGieJAo+37LD4l8mzTbK6cJRswjvwNcFoInwNLQnBQN82sT6eFFK4RANLZfUDyVE4svf5U5HXudQXrcbuvF1rSUc6KXgUHPtJeR1Vz0W5o61M3zQM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yKkIgbJcn/90C/+Ivyze/Cebl2SbfPq3hbZb8Njsqg=;
 b=anXTnPICxYpWkUIKxrlvuom7u3UCHajK1ayRb+33EimOYuXI8ShmgBcrxKiRBPSYdevrjkZKtlZ33/dD6ELio/y7cWqEYBuTRVw98sFF+zNNCsNAiyvx+KYOGWBGFxJz6dnrQmidqQwnbK+GXrSg7ZRd3K10SQiTMX3ff3pe3YVMJ3lnGVNQ5CHwuW6gmfwfKukE25FX11nc5DYOziZTaBMwdfSHW27UoBIicYPOu6HMNfyooFBgo3X/NOHmDg4JWtRuunjP1v7Si+odc9vSRXzJqGEakrxtUQqg27EarEzwwIpXl9FyIAvEznCtq1tSwSpeJfhzDp9MePPYyweaVg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB999080.namprd12.prod.outlook.com (2603:10b6:8:2fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 17:11:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 17:11:38 +0000
Date: Fri, 5 Jun 2026 14:11:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/2] RDMA/irdma: Remove redundant legacy_mode
 checks
Message-ID: <20260605171137.GA2771195@nvidia.com>
References: <20260602214423.1315105-1-jmoroni@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602214423.1315105-1-jmoroni@google.com>
X-ClientProxiedBy: BN1PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:408:e0::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB999080:EE_
X-MS-Office365-Filtering-Correlation-Id: 244a8eaa-0161-45b8-9afc-08dec3258187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	83CdVd0EmM9GKHE8D+DLnlzcd0P3SYscAEPARvMOksnL5p8BnJZpziXuTRDLivBV0FsERo7W8er7vDwk7HXJTFCIzi7h/MMN9Dm4g1lWDjlLqdutyU8JhqmJKAzyQX7WuwoibcU07n8Vg889lUrwnjjwCceT3ncZhmhn/pjIbaAxGUQD9ulbuDit+BO7JApOcHODu8sVokuu4BWCFCu/FIS/reufQX+lEESabT5RA/J5aLvGmqh89ixLBk/AEW5P8pN2OgQ2A3qdVGHgXFVwTpvLgxVzdfTTdtzfHL4wHXokCSwOw8I25wi3A5Et38vsXeKZsTxMcsXbBmK5LFArqS+kEIDC9bDi40nKuM8QGd7mCvpOF/mb5M24AjOcv11RCw6SXQu3qctmQnY9nxBnJlyTS221fC4x2SxvMmmuVak6a+YZ/3yJ9xzdtXVZVqWa42L9Lr6CHDGC3X5SzaGlOR5Sn73WI1NMEd3OIXbmu0G6s0GVPO6oP6GLgESBdIwOt0IplKvuGwxJBdFay/6pDlXl1pGiECmEynnwrSkl8pw2fE00PAs6T6KCd6ktQydsDiUOXdsQcolLIk++M8ALWemcGeUYEJodxP8rNr7FjQQPeglwdyZwM7S47MZ5uldZ4/zITur6I2d305AikRfnM62C0+NQ2UB8uyqC7D5pMGO9moNxwW4c2pH+uTYiwsrn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lV2wmaqMPkgdLVh9Z/SBeVu0omDCq2jtSC1gsyLoAT9RJqXBrOgFVIn+FRU2?=
 =?us-ascii?Q?fAAUOXD4tCDH80DlUPlqzOGMz6hrBg3ENiKAYghQCHdj0YhpFyBnBwboa4xb?=
 =?us-ascii?Q?Q+g0xAaKCpYYpTyWXlMp7pmVGUAunpey7DF2kea3kTt6gSgvPM79vr0qTrTN?=
 =?us-ascii?Q?btRVoZILicb+T+YXSlupR3frxvi0XFqqktjSvZVVU9Swq+Gc+KGxzXBY+IMV?=
 =?us-ascii?Q?tS3wlcJvwRNvxo5ttYmTXthCV23AEN/7sdyKi4gVa9q1lp6w9go1wN/ly9fY?=
 =?us-ascii?Q?P2K0elRIGszyMcVMUiAktWpA9PK7D8SmtOAvDqj0tol9UdcyvR2bYVMtWSs6?=
 =?us-ascii?Q?qlqwIlii7+bocpUm+4Jxh+hLweyKPymm6viZV3FFo9IMhLOcvPmYp6uSS975?=
 =?us-ascii?Q?A1J5X9oXdUuRT3Ys9bbLqSeYDQ2riCaM8pB75OnYmiILEvOSWNJj5Q1eePZh?=
 =?us-ascii?Q?PVtj6f4tdaqyt4jnwFIvYxoXUukqJ0XPWFrvrmnqpLWH5cyTDob93atbEqRg?=
 =?us-ascii?Q?Ga7mre3oqr1io2xah8QqZ2veMSXMnna/So8//D+DHH+y/KAkpOivadS3bnzt?=
 =?us-ascii?Q?whDSxdGQUfwEFDoO9mX1PE3qHdjDSY0mepQgE+aC2St0Jpmm6P0ozsXWUlW3?=
 =?us-ascii?Q?K3hXVRBUAeZtj2FdszQ9/r8C84d95CFgf5zxW48bHXurOHjI5xMRaw0clL34?=
 =?us-ascii?Q?Z30Imkn4lrhCmmCT6a4GcphTPvKHqW5oYQm25oPk5F6Fr8kG4EmACWibY8GE?=
 =?us-ascii?Q?R7uqN58eH/rnr+cVDyOtofwyYyZ3bOYCY5Zsqw0Rs5jgcH3/lqm+lqlUh7gV?=
 =?us-ascii?Q?p+OWAnlZzryXSIV5fQ6wgfyqa9gNRpo/nuh6tNOV6b2YYglUcYsQoTYoCmdj?=
 =?us-ascii?Q?diIFm62GDpqEghLU3z94ISfxLI0Br3EPz4mBrfmRUUzkO9+qnoadujYxGTuw?=
 =?us-ascii?Q?Z8gPMl4FEQ6679bShMe+WfOPgnMFKSLozG5hWjtc/OFJfYyIUdCD31ASwOM8?=
 =?us-ascii?Q?7GfJRrhjeihiEPQBmXwnTBWS1MKenqTgzAmSPJVzLk052ZPddb+UgjyNCR/2?=
 =?us-ascii?Q?r8tRYD4DtEcOwmqEy4wvQdtL5u5kAw2t0058SIW/ciAQZYL12An7AVpjS+WG?=
 =?us-ascii?Q?XisSQmIc5d2qkCBU2Vb5OT3u/gAvnJs0EZEmKIRs1/+fJfDV5c3buDBscLOR?=
 =?us-ascii?Q?EleORu+MAgtvSYz89E9Rj4CDUk0Zr0dF1ExEo39prhjmYdR7CKg/0oWKSJM/?=
 =?us-ascii?Q?pj/V+xZNeRCJ8rkJ9sK+n7fKMuja6EXUE4yv3mOkvpwTqwaS0wtd1bDWJDn0?=
 =?us-ascii?Q?3rBMhDtbknJZUKUmqnsDef12YGqvP/Zwj/BMv4RXdTX32k0thKoFDVWQwUJB?=
 =?us-ascii?Q?+7ECYoeoZP8XNjHtujgB1vqV1FCxYkWA0iV5lhUkWhvuvpKpaBfh7zU0IITm?=
 =?us-ascii?Q?4Vb8Kzg+BAHM9ej5UH+5H8XZ5TgEmpxM4R2Kpj2AE6Wx1fILRHg4ngqvHL4M?=
 =?us-ascii?Q?xoC9KVtTKciFmr8Ct1yXSCG6WDLeYwJiecOHRvNXnxoAPGtC3PbkxEonS9jX?=
 =?us-ascii?Q?viD9HvBV+0LtQuZAbgEmNCYc/OUgJVCDSmV5/oDO07dGjCz71m1hhzd9WjnJ?=
 =?us-ascii?Q?p1YhDWv9eDrXz0MYVkeL3HWLpQt/hJ6Z/N/QxTVGWKDAZvBaEILNj8C1JxDB?=
 =?us-ascii?Q?l+6INZn/KppkYmHlQ0j8kwjMjtegQZcektK/Sv+g3Y1MJtST?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244a8eaa-0161-45b8-9afc-08dec3258187
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 17:11:38.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hA3ImEE+axVI4bAMH6sGjnz4vIOopCsvIXYXNPlPe9arTlM6tRmP2JCIeQgG+vWT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999080
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21853-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:tatyana.e.nikolova@intel.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCEAC64A1E6

On Tue, Jun 02, 2026 at 09:44:22PM +0000, Jacob Moroni wrote:
> The driver has the following invariants:
> 
> 1. legacy_mode is only allowed on GEN_1 hardware (enforced
>    in irdma_alloc_ucontext).
> 
> 2. GEN_1 hardware does not set IRDMA_FEATURE_CQ_RESIZE or
>    IRDMA_FEATURE_RTS_AE. These feature flags are only set
>    for GEN_2 and GEN_3 hardware.
> 
> Therefore, legacy_mode is always false if IRDMA_FEATURE_CQ_RESIZE
> or IRDMA_FEATURE_RTS_AE is set, so remove the redundant checks.
> 
> Signed-off-by: Jacob Moroni <jmoroni@google.com>
> ---
>  drivers/infiniband/hw/irdma/uk.c    | 9 +++------
>  drivers/infiniband/hw/irdma/user.h  | 1 -
>  drivers/infiniband/hw/irdma/verbs.c | 7 +------
>  3 files changed, 4 insertions(+), 13 deletions(-)

Applied to for-next

There are more sashiko existing issues:

https://sashiko.dev/#/patchset/20260602214423.1315105-1-jmoroni%40google.com

Some of them look like they need to be fixed

Jason

