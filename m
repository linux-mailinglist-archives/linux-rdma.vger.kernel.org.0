Return-Path: <linux-rdma+bounces-21234-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OcVGbtYFGofMwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21234-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 16:12:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5986C5CB985
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 16:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B526308E057
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 14:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91D5387347;
	Mon, 25 May 2026 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eekrO56E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D82BEFFE
	for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717591; cv=fail; b=H2w+WChoMJXQXaPbcEMHnTFuG+SHAnPB8hOadh3dfIeIlSgCbbRYJSo3Qve0NpFbktG3mop7abSkYqzR72X49YD826+0UC0mwnWuuY+62XdC0E9VTeoVkFKs6BNc5D6uL6a5H6tTDzWimr0Wiw2/Ogg1lsFezEd3qzHkF9JGOns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717591; c=relaxed/simple;
	bh=r4ctPFnOua3hDXCvZwtnF4ofiHUVBDiVXU0pV4SsqKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pd9TchJAXexlR9u72/n5EENkY2ktRDQczDYlpwLbnBdE3LPAKvj7H8ddYrG7FDYjEl4zEH0FrdEDv/b2h7b4NF7JB+ZteYaTSXnb6D0F3Iwvz40HiZ3LmhWYec6d+h5kW57H66L+wL4fWfeqtVn4iO/TNDI4oY7AJ/qq/fMJvqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eekrO56E; arc=fail smtp.client-ip=40.93.194.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzNZJmewOtnAa/bQWag/UDDizSQLzHyAbZ1F/GOOSpFwg41iCoXi4njSYF5iuGIwswEj8eCEcRFqlcZW/TZVW8ugPr34sCk2tYrROfiS7Ios9jQM/HGmK3KbLIrCvGyBt9p0j7yInKbM4krInBfAOA0fEAKkmLdIlKE3nnvDqgXIldQ8Dte1CqZ1BW+iIwRr1eKbLMkMBBgkN84bkGD0dOdLfv1nbW/QtfFZfFtwj+TXxRI/aGRXd0iM0l98VIxF3oPT81M/29f7Ob+GpN2Sjsy8rJFCIeMhnb9s9ZvAFwV5kAg4o8oz+29diRYjx87jrBw+i7N+DDFJd417R2FZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyMnVxiu5DEf0i2cddPf2G2FisgmrEnIyzxM1lzLYAo=;
 b=FcdqF+r9thLV5g3aJ+pxqHoJuIi0hBeTgSv72NEWHJ0lj/RNM0iGf20E0SunwjDSJ7fvk/RgB/Gl9//RtdAIyyga1/Y0U5TdvtgrRF+S4ZXSX+KCjBHFpQ5XwdOWVIirxO+gwfNc6+3ebXj2HEfYLQowmr2D4No4WHrsLsY6vdUztrvJ55p8BATvHGv4YnitFeKhcL5n97Wffng6F9pG3szAKmsYBVRKDlhuhdmvm4M0d7fE5Emd2gMQZahO7+mQ+By/Q1A/OEltGt0ue8+imttNWLhq4eHo+/5qk+jiQNXxeYjF7n2gMdarHgKx0bcAM5DRbBwFua5wqKq5uN/mwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyMnVxiu5DEf0i2cddPf2G2FisgmrEnIyzxM1lzLYAo=;
 b=eekrO56EVON87CyhbQdnSqG1qHFnrkt5kn1zn5OojDzu6AyjF4KCMJ1+sBUAvKkNWCGZ4sAbrR26qx7okqQsmnpBUkuSBGI011KwITpFv/hQ9pRtLNJgYaLCMFn/UO9H2FCIRS3C5W9/UW3564sNqjHkLVIepuh5g091P++OAGHcmejlLB8zG9x6BToOGAtXgbQX812oUBk+efJvNhkQjAW/KHRu9knA93hKm5k7W/yhBtNHK/l74Ifa3bs8lHb8C7VVNj1sPDakrh9G0plTCEhhY7nsvTKG1ykiOvAeqnMJ9vUsGdkgTSFESy/UjDTu/3od7qZd0AFv7BRekrLfvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:59:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:59:46 +0000
Date: Mon, 25 May 2026 10:59:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com,
	leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Fix out-of-bounds write in
 irdma_copy_user_pgaddrs
Message-ID: <20260525135945.GA2440908@nvidia.com>
References: <20260512183852.614045-1-jmoroni@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512183852.614045-1-jmoroni@google.com>
X-ClientProxiedBy: BL0PR0102CA0032.prod.exchangelabs.com
 (2603:10b6:207:18::45) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 997e3518-3fdb-48e0-9dd8-08deba65e11b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	bQ5C86eBe3OWvtVjOleQM5gLc+EE4tSOMYCEdM3aCB0tdw2QnwTCoIVBHfzDI1tPYC8SPIaW7VrOqCWp6pp+XTcEY8/JKyiKaqWu1hlm0npznGZ/L7mRHWZbeJbSloJ09Ww5OucPdYHzXWr9dgcWMTwCTSLLllUHuepZ1Q861XuQvEb+w0e0yI+tWTS35to9EOUxYfSdSXHQ6lveUO9kibwHYUjwSHMUD8caaSe6exkiSSb9LUU7Br9k6LAzx1HnjC/Zi5rXwb74bidJxm/pwobwa92AJVdXixZqE6AJcjWZPi4jRMTwy+dLPHyM+VnLKmafbSfms67CtevbXQq5g67R3WkTc+5Mjc9fE8tHGSKNnVP7Z3z7v637HnyQSSYzHxc2v1XdCmeb1nf6umpIBvCMhgSKicHamh1N91+hzE1k8eCCA1CT800rTMPwRDM4fdMJdeKtLNW2kKS2FDr7ZPlP7fzuQ4/MLOw2tAcS+eQ9p8zi5VJ5j5zjpsd/iGTv5vG7jQ+Q7oACx9kdVDdp2Y6xP+fqJAvuWCE4b8GADuItFM/EUWI9yepJKSay59RDFTTcjt/xm9WMFKoU5UPWXIS0Ak2U/xyIq5Db81z4mz8646A+wP6suvBwd9qhUGtzeuaeLP5hjNJ0IKZGHRUaZfablgCJghRf+XZ3d32J7A24EPnnGv46CMUmna2eknc5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gLAfHDvYK7kii1vApZR/AY49LFshsrdyG6MZwa18RwZcyvY/UywXmWvjjmLr?=
 =?us-ascii?Q?bVVOUsp6EcdQoF5xHTqJ9hRHflT7TzULoX01HIW5Yiuw53ESTe/syeQZaYxd?=
 =?us-ascii?Q?IxoTKuCyfbslMOfDyTLDC4mkLt/7SkiP4ELTRDNIWouQTOmd4J9HTTnp8aPi?=
 =?us-ascii?Q?qtN6Bvji2y/AlJGQ7IxG3cSTpZMg5Zis4DxcOm/EzMk2UrrCsa0ZqeblX6kx?=
 =?us-ascii?Q?zjVueqqZhZy33KqSMR4ge1gy0VHm1E5ThOUYU9CFK0kgjyzMD4RqPGQftbSt?=
 =?us-ascii?Q?vnNmp2x+BI1HrtL5FndBjnyL7dxjGdMewsCQc9ky7fg6GvS4D6ztzl7XZakm?=
 =?us-ascii?Q?CdVEDywZS2tS8WsIhMWVCgd3VOZm5Vusv4yDbp/v2Sg0Uz7IHyFuyJdP66MS?=
 =?us-ascii?Q?WsAhhzogHqRCNwf8HyKA6M5sKKCrVCQ24Qe+ZpBf8OFpSiZ7KJO/2+V2uHFJ?=
 =?us-ascii?Q?mUygaKMBkvizwean5RVM8Adwpt/+M5+n9I1sMwrJTup9jXOnaw7rN6Q/Qm+C?=
 =?us-ascii?Q?ctUOslcWT5n3oT+M6ndc1/OLgDhvh+apYpouhhKEsmb+XLCPaDENMT0UNvCg?=
 =?us-ascii?Q?pYSyY9mihGiVYjkvdk60ZOyBoJgNgYlNP18ra8QbqAijkF2qzP+bXAvr75Pm?=
 =?us-ascii?Q?gta8050uLt2N8D6rVjiccRo4BoG3Rwv9oEKGQlGKi7p9HRK00XWYVJKrRQ01?=
 =?us-ascii?Q?0encMpKWCc5yywNTJOYMEpO10WNbrO6tav05rOlkUM2TdM5myXquT0sCa+qt?=
 =?us-ascii?Q?QLaNn8BuWn28Q/mdux8qMmJF2Q7YtfHdKYKk/lH+BuHNT8QNE8vlUhX3r5s1?=
 =?us-ascii?Q?S/6dCmQuOwkhqovhgdjnmQ4nuDJhLQLfX+9FoZ2t7STlsyGbAcDRvryM5I2i?=
 =?us-ascii?Q?CWW3Y86TWxbYCs2JXAquy34a+YvkFLPzyp/sU4u817r2/P7Tyek+g1ZGn48o?=
 =?us-ascii?Q?C6peyjAYNmHAvyg1/w880DGxV8nE/7P5iUKHoU5D6RCLdw6szLycZCMHqfLM?=
 =?us-ascii?Q?ZxPxj4wiOTjwAp1WzBRh+BX5UO43St9AluLfZbK4p9l373PGil/XASwhw9z1?=
 =?us-ascii?Q?0rkxJ/iEn4jqDakxgp5XSkqIUefE0Gle3ffqiqOO+Fn/hygMz/gvUlvnQIVp?=
 =?us-ascii?Q?bRbjJBvR+aGjrGnLbfYhKPOVWNVO+7xt0xbgo5idNnlpq2DiLG/O6Nj7Buqn?=
 =?us-ascii?Q?xoT7i3jN8EGD4KmrqqHfUmvR5RkgbDwexXst4kNgvtcf1TmMQnS+kSSzDPU/?=
 =?us-ascii?Q?cLk0C4iZfQ751s8q9wGOYh69N41kt/V+oBupxRpXWApink/o/sNm2GVh6tWj?=
 =?us-ascii?Q?+b4CF5oFUa3EitFfb2yXJbqBggGSfrs9Vff7EPn4M20mUksitPd60eyjhTbE?=
 =?us-ascii?Q?s4rebeNb3mtnSfugcltwvoapnpCVekVxeMimm5qNlrGtRU60SCORnCa4RD8O?=
 =?us-ascii?Q?mYHE7V7/fs0AdoD09ZkI6IhYztS4NLjaI01xY/RMlop37FVqOHssi1IKB6S0?=
 =?us-ascii?Q?xskOKie5ztffwNrR7+I2XKJh0+5qrtcvNrV6THAAw98zVN1g+KiJy9u5uIXt?=
 =?us-ascii?Q?UNHmzWEwK5qzKk6LL39k9AUoyApG/mC04NnZ5pxkEgfGpcVGlAYZBYAWgIqR?=
 =?us-ascii?Q?yJQ7ZCnaODoYQLFZzzvenbi6mpnzNAtUNceHC1TLwlkRTZgDPtQfttrLBb+r?=
 =?us-ascii?Q?XZomfvw/X56+NJ2aydoVYW9Qw2qDAY1YMDRHLL7JOLcfRKxd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997e3518-3fdb-48e0-9dd8-08deba65e11b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:59:46.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzIq07uz+7ftQC/FhxeD8MgI2/aJwXLX4sfSlGNZZ9ERAfV6e/cc3vk7FDzbuP1o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21234-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 5986C5CB985
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 06:38:52PM +0000, Jacob Moroni wrote:
> The irdma_copy_user_pgaddrs function loops through all of the umem DMA
> blocks to populate the PBLEs and will stop when either the last DMA
> block is reached or palloc->total_cnt is reached. The issue is that
> the logic for checking palloc->total_cnt would only work for non-zero
> values.
> 
> When irdma_setup_pbles is called with lvl==0, it
> calls irdma_copy_user_pgaddrs with palloc->total_cnt==0, which means
> the only way to break out of the loop is to reach the last umem DMA
> block, which means it could end up going beyond the fixed size of 4
> iwmr->pgaddrmem array that is used in the lvl==0 case.
> 
> In the case of QP/CQ/SRQ rings, the value of lvl is determined by a
> separate input (for example, req.cq_pages in the case of a CQ). So,
> we must perform explicit checking to ensure we don't overflow the
> pgaddrmem array if the user provides a umem that consists of more
> blocks than their provided req.cq_pages.
> 
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Jacob Moroni <jmoroni@google.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Applied to for-next

Can you also address the unrelated bug sashiko found:

https://sashiko.dev/#/patchset/20260512183852.614045-1-jmoroni%40google.com

Thanks,
Jason

