Return-Path: <linux-rdma+bounces-21585-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBF5Gjy6HWoidQkAu9opvQ
	(envelope-from <linux-rdma+bounces-21585-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 18:58:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBF6622EA7
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 18:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8F09301F483
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 16:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8533343898;
	Mon,  1 Jun 2026 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E19O30CZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9B2C031E;
	Mon,  1 Jun 2026 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332758; cv=fail; b=tUf1m7zvn3/23J0+f4YwhGjnheaslWwRPDtyCZOjv7L7sBtHtLSXc10xbfXFla5sF2xreibY5JKwCmICltJMPZKnvL1pQuS7B9u43ztadFLFH4+hlEiOsU6CHodKUl3wjQa3UgK9DZ6/50Vq+xQqanpyKyR43ZUpiYCOsW7TeUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332758; c=relaxed/simple;
	bh=XoxtR28re79cTRuLWt0IvMZxdt7NkgXKF/GoJUO5EKs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pHWOhkpxHr9axcBpZFFztdIz5P17jn+1oZ9CkpmikSn1hRgTXCPxT3wJvXiAMpYc2Nm5TEpkhMX1xhxs3n05NYAfgLqQuoiRkFWj5eiDzZw2yf3q2/K2SXObpLAQ3AwXdRACjDYBjGSiPgvfnDFTRzqA+PtArAJVns7QqwFhtQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E19O30CZ; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSD7w/6vhRekHmB6qvN8cE2U9LTwLQLOO7m43OBEWLkYems9E9ZwzCpZc+CmNP7Vecso6gGjCvqznpXb2jSLl6C9aVSzMdOmwOb2xtt39DDK2TVcBvoMR6+lIjv50s8Wk1oDAt9IrKkKQgAyK4/E4kn/Rj4OCq2R2CI0KtUeFYRummAQrqdD2T2ahXYRVgQ0ipeBxtUXG1+VMur8T9ksKfwlXQ1PKBSc0TOVNy+Mf6C9LgdIt4y5aJwi+gOsXdZB94BH0iQvC+1iYDnftfWwmb+rVHqTJdjlA5WUk2MmLz4vonYE9sXbzl1N5eYr28kZLIpUws5KwYcoVy0wfLV2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHqzZqUUqNH2Y+J5mFV4cWY3LmtzoJ2tnB+v22xLaAY=;
 b=DnBhUCvV7kDcA4BWnRimoiRwHWLwrC2bgtZklikYlus1427E6znLg0oVqGshexn33jowvKQ2mSm4kKGqyaZ9s8Qs0ycxk1DuiTJjlYWVGjZECmMcDCCK4LErIOizbVnmy+SJZtgtqip/+LrzQMvriHZK6OOiiUaDk5s+TDlHNVZivZMIOC/VrbfJKT9buOvhOKJXdLPfvCR6hTN9lOH8yTD8jC1slQ/xq/xOULVUjwMcQ9Zwndt7DyiY5d+I3X0s0w+1dWqYqXTYePUyR52x7iUjnL+R0qfTZidpXQBkwEVTxCWedMHWidytsk8qP64Qa7ds6LJ2WLM7ReupYgEoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHqzZqUUqNH2Y+J5mFV4cWY3LmtzoJ2tnB+v22xLaAY=;
 b=E19O30CZB/7VlfTuQL7oxHcsv+nM/ByctwpaJXNSJArBwbtnc2imGoS2Mas2tztRUijMLvc7jA4klwjzVbaY8Yokz+LdIDGwASYfVd7EnUwPNQZsqxAcBduvP5Sc5/eZL5Wh5PhzK7ufwHmp2stG+792OoIDDLcg9ThO48BziWuDmuHs4hb4wxjeVcb+S7U9Empz+5AY9i9UriG4EUC0d1oMi2dx8XSw/SfhSkCnuCnL2gsMpLpvYeC6QQ2j5eFtz4yeRlqGUldNojNmXdaRUXtTAlMskimmNAGh5966j+q8AQibh3fMAM5wUHKOL1w9IB/nifMascyticlpihgkhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 16:52:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 16:52:34 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: patches@lists.linux.dev,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 0/3] Fix typing issues in the umem code
Date: Mon,  1 Jun 2026 13:52:30 -0300
Message-ID: <0-v1-88303e9e509f+f7-ib_umem_types_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0f324f-1281-4b11-0aea-08debffe2dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	2kk6PGIXQZMne2wlH+ZuQLLRsLOlBbKvwSNL7GJpMs1NF8wkNaXo0jSnPKDxAFrVHaw70lt9qjx1TNntyNqEi7gGHD3RHlhBK9dLFz/YQWSjUW1Vuxaxm5yIUHKQFyiNgvKN/1AfHWjbFc6SBb9OeDPDU1SD/sCtnTG3QEjnnYr60GG5crplZPO2MQhzco0Pc1BtUMsi+0xS5P/9sMJaegGDyJBExKT02nUl6yh0kakTuO15OYTvtw9axa0YrYZJbxVhU2TQumMwuk+di+rL+gDsNgA7cknoCCmhZD7a1SfMdOrjlK3FNpObiGkHTrUzU6Zn7ynnNDEKN0PaPf/99yZyfujpnK4Ani9zPfcVwiD0gYtR5n8tQrc9oo4QXVhxJbX+Or3zFCRzScQUqlTC3gWE8CyJCOgYBq1PiipeEkkqnweS0jUPYOYMyXzi7UN5/s1BJ4Z7xo3lkFKYBHdtPTpwNC8O5UpdmcAgKVWkrbJ8f6tvPrASygxa5z1UNVF1sVqHXX3X78dSszbLJ3Z2Vwco0zhp94b5NmaglzaQQa1mkMuhxRZ2PgmNhH1LFoQEQJHEjR+jRHV1Suhy4uRSBlJUnhyut3utB03P/PC1VBjrmD5j+/drXhlOGQG+TE8scO+pIdnACQ5KnmOpXbDFQDCcfD/eeClSkv7Ww3HeXbNZ0r9vqWVH7iuIjE845vw9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NRwzpnYNHPDv3SXvMkx5oXDTbBZjuXKERb2UkDkctPV83X8scyGBCZMc+qml?=
 =?us-ascii?Q?8BuPSpe+XC6Y3T7OcTn0GQ0a7MFkt1Zc5jId99pRImow1+CflHxrrfpXZVVG?=
 =?us-ascii?Q?eI/iii0qNCORpY16X/DQEU0/awtQjx4dGZCE5Lcru4n8ThpOdNxmcMJweLvs?=
 =?us-ascii?Q?/5T/ihT2MAKhaedRIP7BTtsweQUUYtHNfIDsyszobDT7txpy6RXWIV9otjYC?=
 =?us-ascii?Q?aghdLI7MEBIQecUK569auFY1RSfEgM/ktmagKpwc/rkJ9/PX7sRSPkeP5rKM?=
 =?us-ascii?Q?0B2GwvdAQyxaEb6RU4zZd6SthwVQj2z7s3hurM5RtCq7R6ijKfzWbTOD4i+N?=
 =?us-ascii?Q?wJsy4uW/Ifx/paW/c2zCyLhcHf2kG1A4an5xhw7kuaRj1+kRaxU5KbIecCrD?=
 =?us-ascii?Q?Kp4p/uZzHlRYM53lI9Kw4GqWIZIYMFqE5QemtTddc3L7+Jzubu0z92y+uKjL?=
 =?us-ascii?Q?u49IeiPD6X2tOThZ+ldGbIhKf5dznoRePhk7iI8ZDVNhCZ65sGn+fKMXoG56?=
 =?us-ascii?Q?f0KdERqzGc6q+2oWlEujHS7dNC8l480dO27tQqMxB6MG22T+3qcL9/1jok9H?=
 =?us-ascii?Q?0CW5aWoyy6A9Yk6FExO/eYM1yPAvEHyNaFpaa9EFo5PE8BhYUpa4oA0wGwBn?=
 =?us-ascii?Q?YarcdcCK0mwXHvQixf2VEx4qzlosm6KPzvX4YKIJEP47g8MaFLOZjlzE6dYU?=
 =?us-ascii?Q?Qb1S+6pfA9y2YLr9UrztziAZBMz2UOxLoP7lvj3Juc3l1E7rsFOG1YLsec+U?=
 =?us-ascii?Q?fTQJWmoZ45CWsNeME43TmSeq4b7LeQDeVzRDL4Uu6QgofL5SrZcjN2dVgMOR?=
 =?us-ascii?Q?OpRc5mLtJ4Jit+5v6I2+PRstWGUCwsRL0F9J6QvFrAfEkUM4jxi6MC+gl6kF?=
 =?us-ascii?Q?9zqrEkI/MilvA7rGqwqqYIqqiA1C1d1AMWRhNfAErjqb6Ua78ua9qJ0dviWi?=
 =?us-ascii?Q?PqhItd0c4ASLQVpdiyGtO+JJKgVJgqdVXnGPRefDGhhmS4VhshKc1CVmdxeG?=
 =?us-ascii?Q?jCdEPDKgz6wOGoCw2OgqF8wDURCEGhLupZV15YsaIXxqETezUOvVTw659FYw?=
 =?us-ascii?Q?9kzCo5WG0CUVjFI5Pj0Xnoddjkcbg78yniutMzUU5GnLZ5KIdb3qKn1kt3ic?=
 =?us-ascii?Q?W+e1Bvzq8L4lJSE2ojAI/0cXcUA8YZdYVrZKg9zMi4zMVusAdhO8i7tFLlbm?=
 =?us-ascii?Q?CpgxcaIxWcbETVQiqaeHo3zVwEi/OfDrslidDQFy3UtK17ZC4IukXZokAzQW?=
 =?us-ascii?Q?4RD68Ajf8rmD5YMx0/1W9HcF3hxbIHIdT06Wyr7+u26TH1cofvbhsQheg6Q6?=
 =?us-ascii?Q?VoKL5j4RokaIFLabB39pS6/UnAizyltxaFKoLt5aUb+n3nWb+5oQiC4s0XHi?=
 =?us-ascii?Q?iwzrvM136/n6TubtD4VpxWWRK2bWbFA5dHwbOEXEo4t37KE/4JVuBrp5SFGI?=
 =?us-ascii?Q?2vUL4r9vft0grNuPEMqUyJd8q0j4Rtkvd2cKka4BOyxT5aKQBDp8Tp+cGreZ?=
 =?us-ascii?Q?d/7/u1ahjps3grFS/harCqm65NSRpf3DqSzfEx1GbdRmoIsV+GeQ6tHWx2Q8?=
 =?us-ascii?Q?xaVGXLh2ca7tU+BiQBzHswHZntWvzEMj6fa296lwCI6N7PoMsblBUJBNVxcy?=
 =?us-ascii?Q?/ND9gyxgJ0AkAoFxFmYAUrxktIBMP/Wu6kWnfIS2kdmm0bGxFW5UianYXgLz?=
 =?us-ascii?Q?kawpm9PKLm/8TNiGKDinoxkCga+Hq6KMlMDdvA0GMfCdLJLK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0f324f-1281-4b11-0aea-08debffe2dcd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 16:52:34.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxlfnanUkLfRab15eDm7fhOpM3S6mxnCKZeJCimSJkIHosubSfv9SgMN2S8sqT6E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21585-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Queue-Id: BFBF6622EA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The types are tricky here as we have a mixture of u64, dma_addr_t and
unsigned long used purposefully for different things:
 - The on-the-wire IOVA address of the MR is u64
 - The dma address is dma_addr_t which can be u32 or u64
 - unsigned long is used for pgsize, mostly because a bunch of bit math
   helper functions are used and they are obnoxious to use u64

Fix various silent truncations, issues on 32 bit compiles and
understandability.

Jason Gunthorpe (3):
  RDMA/umem: Fix truncation for block sizes >= 4G
  RDMA/umem: Be careful about boundary conditions in
    ib_umem_find_best_pgsz()
  RDMA/umem: Make ib_umem_is_contiguous() safe on 32 bit

 drivers/infiniband/core/iter.c |  4 ++--
 drivers/infiniband/core/umem.c | 18 ++++++++++++------
 include/rdma/ib_umem.h         | 15 +++++----------
 3 files changed, 19 insertions(+), 18 deletions(-)


base-commit: d6ab440240a04b8737ee4c7bb21af9182e451733
-- 
2.43.0


