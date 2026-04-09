Return-Path: <linux-rdma+bounces-19187-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEMOHTP212mrVAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19187-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 20:55:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7403CEE26
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 20:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E85D3012842
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A98315D43;
	Thu,  9 Apr 2026 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XOWhPBfU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A52F6184
	for <linux-rdma@vger.kernel.org>; Thu,  9 Apr 2026 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760943; cv=fail; b=gbMk3YRDG6LfafRtBc4ooC0dCh0bj9/wPH/gkY0uDUxWHypyZRR8pB74zRxjcdDQcqHnivlOAiOCIl8xHhsZvwsQ9KVmgHFFxYyxgUT9t6zE71ujtylQC2XAUphXeO8YAfBbHouMa8HZ/ve0qonaSMjOjMsPdyuVTc+Mbu19iFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760943; c=relaxed/simple;
	bh=lzfknVXJudbCnFpp2FaC/Nioko4/uFu/gvjIAZQqxkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cLlK44b5AOEhchPJDCCk+GYi+0LMjdMQyNVWfKh3h1J81JrVdlsrw8VU9ktiYSWy0MG30WNGnqqzypVGBtP3cbkBFDUkYqucePexiwTn3fUTTLJp9UEBdahvWb0R4M9uBG1tgu3w0+KBZuh7JNSjmrfJgVvr1E01nRtxCrAao9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XOWhPBfU; arc=fail smtp.client-ip=52.101.56.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sc+YUBi+zBWRgip1GWeX/hngHSv4zclISWzhGw4CdxOWKhXEh5Qc9UL0WZYK3xSgIvb0EaX5bZ//awM8K2ORzviphZKcVGwNeTASr5M0gbcm562g80kK8GK/iHwGTrV1nRazbcif83H1Gon9KJg6xuA8jVyAn4VOi6yOsi0ffn7SR0bbmi+x8g+FTCD9DznsjynN3c3zo43PMEgcbPwcGf46s2Zn+EXXt1ofDfRv/NdZBucd3Y0LT8N+sXAkf+hgOJP26XSoZp1WTdOU+TsffwoxBmy8xDCSJMSFnq1ngOpOmbMcpj5bPjCvpzs8ZcBVwNWssiYJLNsYNw4Q3T0VGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1uJC93Vr+6QkVRtg/jolnKy6Ej39OkcynvUN+kB3ZE=;
 b=d1yg5J86spPE/vFP0BXc9owp+HFXVcQMyYJ13wNXOkpvuVAev6jeUt2nu++Jp8ZzPjgn/6Jad55imCkCO38NzM2wS7Iv7qVd8c9yPn0L/wln6HK+TjwoJUb9rlB5UX6Ks1otPIT8W/WkRZZ2wWOW8LfvXK1Q0MhwhkqOvy7Xan0P6B8KxPMQYMGHWG0mW20rUOSkk+QuX/MCyZpqUV93ns3oJz4tGNm2oSAdqxlZoLaliTtXWPmUBxDx26boGFAwj+b/uiBi+OHUliYz6zMtnsm5OyQnYNsuF6nrwE0XZvAdzAWoF77OtlpsfAIEjxSAQ2YnI0fMHiVRzGJeRgwHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1uJC93Vr+6QkVRtg/jolnKy6Ej39OkcynvUN+kB3ZE=;
 b=XOWhPBfUAnmkkpxQhtdd7VRk40banQ7uwXJ6yKh15WqWyzjNHzOdLZtAmSc3BI+k/DamGWB2ekV7xOmE5V0+BSyG8lBRJo2IUejkoenADDzLW5cp2CJYZ1l03UbqDALjPFFS2Q4hmK1+Fs3zdT4I/MPvczI/w6I4OI1pYxgQUfP2Z/v/9CD+9bRGg2daa7maynMRQnUDQcOHYE6lwmuGUolnobIDhIS71DkHThDt8Xb8tG4gv11cuynF8kdVIrc/owGFlps0bqLXPPS/Av32v4hYyQyB6B9ustAgaSWzppzZg+lg0w0uApwakF8q8aX6YOx59MP+NeQcyd9KVVODqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 18:55:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 18:55:38 +0000
Date: Thu, 9 Apr 2026 15:55:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Hefty <shefty@nvidia.com>
Cc: Michael Margolin <mrgolin@amazon.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"sleybo@amazon.com" <sleybo@amazon.com>,
	"matua@amazon.com" <matua@amazon.com>,
	"gal.pressman@linux.dev" <gal.pressman@linux.dev>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next 1/4] RDMA/core: Add Completion Counters support
Message-ID: <20260409185537.GQ3357077@nvidia.com>
References: <20260407115424.13359-1-mrgolin@amazon.com>
 <20260407115424.13359-2-mrgolin@amazon.com>
 <20260407141731.GC3357077@nvidia.com>
 <20260409160007.GA24340@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <20260409161357.GL3357077@nvidia.com>
 <CH8PR12MB97416FB899448DE69BF3082EBD582@CH8PR12MB9741.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH8PR12MB97416FB899448DE69BF3082EBD582@CH8PR12MB9741.namprd12.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cb4e3f-5078-4f2d-891d-08de966996ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	w+ffeQqtYc/X2ZYf8BMf0dRvQ0NTRIcJsZ9H5/TpReGzJmzD7RgZIfN/QY57Kg6GI8CEiWVS/V3a6Ux8zSkKRzrSOWcq4kl/O7S3ch+GKY5Ycc0Rfb5NYI32hDPnjaMtAstXRcjvBNfZD+jqxOcvlbiB4S5LBu9xB2QXVxAU6oRqwtYA5NYck0FXOYRQi7DkqFG3C+ZdmWlZHfjHJFlXrYwAqwG6lsNxA4ThUa+6eUMENvmC2dDhbIS3MOj7vz8qdjoM4WWk/sDKjktFQS1H35zi3tIEWW4QLrBrCwSLGvmn9GncBUpQybj/8CoGk+HQbQbD+rLbjT7NmgB+1t5RftKZR3eNFv4VmmnS/cF55c2nCGB2lLvH6q58W+hXCjjh2jGF1onnHd6huA2Pp6SBP6C41xI6k5/aN/ATLoNuvXKEyN9w5B1S8X5esHBZDGL2lOZWwLCB8jgZGNXmqNJoONTjNF3rBdcD+Nhkqv6J1iC0pxweImOBHpiJ+yd3IXrKXwXc7hosNh+03nqhLPXZPZI6bZ0MMLtsJpH5kTWVutyqKuwkgpY61mtgmKEUmDz5XnWRoVFqj84Z98Ir2a6fviB2alEMXsim6HuyGqaQe/7gvZe2w9VpuJEgnAkntA5HolB/+Zbl5oQheXVn73uZDzjGQdHgdC8KVwldV4J59uWX47xXQ09dm/tZafUdGRM2Kv0Qn1QCacij4Ig9hirMDxf5csYyoTl2e+79SAQciJY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?axoEEL8Wi2oA8dD/afY7m4D58yB0Eo4sWyUz530wC2FReSh0uR/W761uqTNG?=
 =?us-ascii?Q?F4MVaq1TJZoVPXd4ROa+ICStwrKRxkxk+8V1fFHQ18yIlr2XS18aef2Lh3VI?=
 =?us-ascii?Q?EjpRoEKQCug9vzGoqPKY5K76dKoFV8gh9NYtfv2OU7YqTtkx9gbpT4AGVfH+?=
 =?us-ascii?Q?uAyT4T1cnoCHxPHunH7nMituGcunW5g9w5Dg1VwsZOH6hC4ncdMbTupWLafu?=
 =?us-ascii?Q?F7ZH/rviRW+mC10B5cLbwtTM5vFb/Cc8IU03tQEUuOskgsGb4s90jn8ynFeX?=
 =?us-ascii?Q?AhDY3WQNdfAX6LrydgrOeOzbaPvCS11s0umthuYLRWcWYWESuZDQVaazzEdh?=
 =?us-ascii?Q?1p92MEtG26OB80ArEhtdLx0JGgPIJ3NHoPQqPY99QoayIK2BShf0YsLVgfUm?=
 =?us-ascii?Q?pR/P0W3g2Ff7NR+WtUX0r1+8ACYhrUAfNqaBuE7bhjDn70/VQ0kYlmEWiFX/?=
 =?us-ascii?Q?SwEKBrO4g6GYs7q9T4JXD//k1WhNIlJvPjbsWolq9g+G2ORuILgQyFDcfbWR?=
 =?us-ascii?Q?imJ31ZPj9KhoGCdlcQEMxJAETXEk9tSdD3EQUCWH+NuXS4x2bOBLYwhMsi/W?=
 =?us-ascii?Q?x79MurVlbbudvKgY54Sa/9bCOi7BTjExjd2l/a7h0QP3jGXYiMJ3gkJTpZpm?=
 =?us-ascii?Q?jEAbc4SXmThNZKo1gMSnNzDvfYYf3XwXstgebnONdJPc6TqZFr2egV6iBIFr?=
 =?us-ascii?Q?Ae5MVrVFof8/di2g+OIJSh6LHSBXdmdRGXU4uCdVsx4teEo+XuTIHTYxHzxb?=
 =?us-ascii?Q?ZIAalmYxujfoT/COJ7u3FNY1q6l1yQCsr35Bi0hhBreA2Sc87zzLnQgOPP8D?=
 =?us-ascii?Q?hL5iasVCx7y15jH9Fyi+TYw1YCWwy0zGKCBNNuBkDy6Ajni0Nn0QmubrbWSV?=
 =?us-ascii?Q?BBszXf626Bi0U6MDIMwbwAspLwXopbY69/2RFmP7YZTrSppLS7NVKpg1q5Ot?=
 =?us-ascii?Q?sBgy+eKPN8KdgxXrt4mbv8m21UO1YTlnPp2DJ43cKezhv5ljm+G1Qmvc1x4A?=
 =?us-ascii?Q?2WHH6kKmZ9D0GSA0YLTcqTEJA9OdHBDHf4LqUH3b5iT8s2pPGXgiQczU8K/w?=
 =?us-ascii?Q?+pF7Pkr2xyzEFNrpbhkUhhCpELc/33+f55zhKIoSpIglI1Z2Vg4uKXemFoxO?=
 =?us-ascii?Q?2vIFRAn+DbaqesNdrrH0wTb2gpFO6J0JaAJLPR03yLB/JgHBGpKU+sw0G5X0?=
 =?us-ascii?Q?PBqzwJ11wPJ0u/zCuAfi1bX3gOvUi8iAv6bypPvFAAvcxadQz9EM38VmZHqt?=
 =?us-ascii?Q?EuJENfcLyLD/0aVpLnzV8qbnhfNQPipVq92CV/x+Ti1DDxWZlaD90s2Adc8G?=
 =?us-ascii?Q?P3kNLGxuI2ItMtEqQeOc/p1LZfNJFN6nmhWySzT1R9ghsJaRzp6YDEtLXeL+?=
 =?us-ascii?Q?XkHQNmwww4PMg8RNu51cYGWk9DB3XRUdjE87gkijzr4+oCpXW/ay4gfnAA7B?=
 =?us-ascii?Q?oE4EOT7AvmVYJUXlJlj5RMsM1AIoEpAcmsZ2RcLQ4I5l9dfk46YOWDBe9+ZO?=
 =?us-ascii?Q?4/cRnIcJaHVQlr3sPQpZGg0g+HN9QNZrZYQMAxSx2MD8Pa0WBJN9yN0k3+dN?=
 =?us-ascii?Q?vc01O2N4eBxMqYKCe6i6uAC3GyXSq7rJKB+vuId3PhzCCmDs2Fn6TbiWzojL?=
 =?us-ascii?Q?+CIEADkS+7komeGVjc0vcJDXUb/9kJV34cGwTrlasfv4su+ru0l53xucl5gv?=
 =?us-ascii?Q?HBm6jHNTmKhVtQpQh4XYWQcJYFJCl2qp2GB2e/PKG+7PMxbL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cb4e3f-5078-4f2d-891d-08de966996ca
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:55:37.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33TWn0/IYUNCQPrdXLfugtyvC0iaQtnX/KyctEJpH3uMWdoMiN9Xln1Cp9awXKkm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19187-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C7403CEE26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 05:29:28PM +0000, Sean Hefty wrote:

> I view this as an implementation option.  One vendor may implement
> independent counters, which software can then piece together.
> However, another implementation may have a tight coupling.  

Well, this is a problematic state to end up in when deciding the OS
and library abstraction. If we don't have joined counters then we
can't really support implementations that have tight coupling

But if we never see an implementation like that then we wasted our
efforts making them combined.

It seems like if portals and libfabric defined them as joined together
then we probably better support it that way too as someone probably
made HW like that.

Jason

