Return-Path: <linux-rdma+bounces-22087-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t/ggC8ygKWqwawMAu9opvQ
	(envelope-from <linux-rdma+bounces-22087-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 19:37:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B2A66BFEF
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 19:37:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=kg2Yy3NC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22087-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22087-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C358B326371C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB17A348445;
	Wed, 10 Jun 2026 17:26:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B5342C8B;
	Wed, 10 Jun 2026 17:26:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112362; cv=fail; b=u1g0Z9rCcPGQsDGakdkD8VkLgnEFhVTYPmAop/mVDyY6UiEIfZZ6bfHAQYm9PWS0SVLBVGZ0AAsynXTxXJr6d90YyN055fkhrKMlFgPL2tBfhYg/S9bvz4PyfZ0SdcDY8JDE9KvqF9DbQoNMLZHjPMDH0H4MzeSHa0rSH9778/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112362; c=relaxed/simple;
	bh=iouY0eqVqHi4kOzCgT7ZyNc+GD3JJTr763xmmN+OWcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JNMmBMZehgphe10HQTTixLJ91vmOyiPed0sEMP4b8royjXGilNLhal0rmoGAW/YWRzwKKWV4fuZUIwFVP9kYO0ahdHvic52Zjg4wIygfGtCD3E05WrTBcmNeuchJ+FNnPKJ7raTS2jQEgzftuz3Y3FJzRowiCTbPM6Vo9OHJyuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kg2Yy3NC; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRtUP/a8XkA7oBlnTD2+FehDcvLbaWyhQY0shrd7Qn5ghjP8u+ES6/zQDnfvGuteGIkMVR3MVrGxIfDvoI8UUIR6W4OSEjeHM2w1laVb5FUeGWjRdW4d5gCZrhdD3upqMofY6ONATYMTkwnMmp3SMnRFMkkS6Aqs8wGdvTdx1FE5awuQ6ZbHhMSB2X6R06smw1tLoBxJguUTmpZNZjQ3kI2WzScjBQp640j80HGPwe+ngjasSdaxn36dvxETYolrKFGeTrqpM/BZR2ht5x6MQD7DYLo0Nnu/2RwnMLL45TAQ2BFSZLhzXp4zI+XmYZgslMLINZT8Tn9fypG2/wPZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlSw1MK8RBmrNWbXAwxXUWZlvyelsysrs826Dg+zYQ4=;
 b=puqOXFtRnaahEhCZj8g9w7PWphsMyLA7rjLnvlevnDhsko2+CHbzGrGzDNbbiu1SA4bBTK8YeQEKnK/zx8lfzNWfCeArnl6/EuR54A4+LbdWWtn9ac56pbXCAiVwVbc0kjiyRIna4mYg0VkS30gxepoyDQ4oDxSy+TNpVJtBh+M5a0hRs/PbRBNdrGq9LVTHydm4eT5PvfRfSrPjjCp+drytpkYUohDU6mhawp9y2qVR88xNxlrZGRxdJitQHSMYaeYIIt79He9KDJma7XrRXmTrMJs7x6XUVIc9GB/oyUbUyVPNy/yAT/vAXxntOuuPDxPJ9zjpv2JLAtACt+oENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlSw1MK8RBmrNWbXAwxXUWZlvyelsysrs826Dg+zYQ4=;
 b=kg2Yy3NCcK/RREl2TULPFddHuY/NmeLgnWwrYq4aZq01ghywRimqK3fYjHlcSbVy4/uwrXYFKH9BqZn1xbyna9mZ/aW7tCtIf8y4yHhP3yAqwBWkr/TcYxJRUJxittxry6gzlKcrnqqn9IMRkXMoaOU/okNlbuDAB+A93ANqxzVDRfscEe3ViWW8220/5qODdcd45lz9ZGVla9w95R3GdQH4Fm/yz5wFSVO+wyGBINZdHJimShn0bjwIH3bfiPEv8hVNOgpQ7bIMgiyE6cBaVQbMdCV24wr7F6M/368sDxtx6gWlBn3if0olxOglMRkpcxB0pU+dAcef6ohkGK3SNg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 17:25:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 17:25:56 +0000
Date: Wed, 10 Jun 2026 14:25:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re: check debugfs parameter allocation
Message-ID: <20260610172555.GA1003802@nvidia.com>
References: <20260606040644.13-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606040644.13-1-ruoyuw560@gmail.com>
X-ClientProxiedBy: BL1PR13CA0281.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: e29c961c-0983-42c6-61d2-08dec71554a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	OjjnlxlukX5r9muRzVsIz1NwUmFamAepU82cFxp14rOsFqnUQyz1ihBtjjZBaJJh3XwKGJLeb/AOu9jYwqYYRNC7CubsAVAum3C0pdm2x5F6JXdtyyQDGTLWjP7B3aZeGn1feEzYrF+LnY34+nFtUtzHiYNglOUSA5ehtvDYKBmQlZ7/AFn4081LtLdOb3OvQuxJAPAlCYckOqlsGRREeTLIX9C23vr6OzEV7VSdzR95JY1n42IAYskLKqieqqhkhbLENy+ftswd/CYMQ1CPQVVcpSlpGIW3lY1Q8UTgS4RrBLuhqB92w270VMVI+TwUzsVmsC3/LZI3SH1XazNRWd5uHEI1rdcKLvr2mN+J+ngYxP846/b0418sA5ItfeB1Oy/Avgh4fgq1gJGmwoJkf3w6a1OS+R+Prs2YllRKDbUHkP30yDPKw70dtNThLQQd+nWMCfR5ZPyfKW7rNJ8uipaq+pxu3FQHDFtscb4RzsvXgV/xN4QPReo4QHbsvz94lka/hmUeU/AknQSfO8qiavTrDRXy9reg+MGyiEaraTcyDj0El/Uc3Gq1r1+bQB1bs4XQKdu4UOVTXRrkxzBcEDJgH950TwNN361VnvMHdGrAnVx7AFHXylalIjSXtvNbjX+YX70tP1gRsMhpFK7JEUpu8xhxMVMIJh3cu/bYz2f+M5xA7oZJ0WGGDG3i3MOU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tiNMdBkETK5tugF+sBlgD5qJXDOTaboTNHGLieJp12KY46jS/xBSJfqoCFD5?=
 =?us-ascii?Q?pXOV4cVTW+TyZIZVmBtdDNWtMcXvqhLUhGEmwAneHx75proeoJ9pCmyF8pSZ?=
 =?us-ascii?Q?TXSDuXK6qgLU2jX9SIbWGlO3UkEyZPoAZhuHhEaSze8LmHWPRCa/hvpyPIUF?=
 =?us-ascii?Q?RF4+HiochDG0TBZrZkl0pXFnpyutfKPgiwGeuyZM1LVXL4H10cZdtOtDDEL2?=
 =?us-ascii?Q?vcwPlUzIHXD28GARkfVu0o6YQGGytn9vtczL9SDDF6mtFlfwZ+NHPLh95CYY?=
 =?us-ascii?Q?Fvx0XxbmpW/KPE1NcywJzg3cCAlut0qh2M44CTNJfDHJo263uEe/Q1look5s?=
 =?us-ascii?Q?pj7Qv755LVOagsYXGM3ke0OvPZtZU1eFYSmg5UXgUFYPZwA3ozuz4ra9jK8R?=
 =?us-ascii?Q?cduHMlRvyPL29sqjWAPMh4FlkFrS4C2SzyfKudxQJdR5+CLoI19RVEE2R/d7?=
 =?us-ascii?Q?n7hvQBpxMA49gIwChE+qSR3Z8tgycBsk0b5xkyL+7k4VN9gObUkqK174AHpG?=
 =?us-ascii?Q?i06S6M1eZKbzMHG+PsFwO1uucuMPVcCYmbRkQjd/B2a4U89oICREeL+zYUxf?=
 =?us-ascii?Q?CIEGbsrETrIfDn26Fc5Bv09c7k4Kv4ny0qR2hSWqHqEYwARc5mGdNGsqrXSo?=
 =?us-ascii?Q?7jDh0mRjk6xKVay/UytfN/NoEnwd4HMYh8GgB4repzU+Ks0v5SuSRbfczuvA?=
 =?us-ascii?Q?wK4Xpx/7jN8YwpKNgQEvaZLR2ouh8IXjOFLJ8zg0rQB/oF0fNuJMNVItzb0J?=
 =?us-ascii?Q?OBr5+SkrEwppm5UP717AzP5R9YoH0nd8IhtGF5uzGwMTQDvekbBJHViWy40e?=
 =?us-ascii?Q?KgKbbN4L6aLkpimSa16OrQxnp+j2gMypeAzc6zw2fwz08Yi4haXoFp2CEstW?=
 =?us-ascii?Q?NYked95f1VXzdBTjYZFeBwulHTgxvScnGnQsOucPUrU3TJ5SugxjJ8DZdfCv?=
 =?us-ascii?Q?7tOtrjM2beLq8jxeDbUzMAb4Ah8SSsAvWisWli4bTuySFsu6HRUgcHUeLP3V?=
 =?us-ascii?Q?7Smm2onqYbLNrOje0hFe/GxzJbtIYC8aCFoBa0LOiIuZGovstFahbLMsatL9?=
 =?us-ascii?Q?CDrRUzyupnXFNJtzCsk+dep6CxGvuDiTEZdOQRhni+/eS7UcP248f5IWMF44?=
 =?us-ascii?Q?Kym9T086Dl47d3Y57HH+swZn1AnFR6cuoAP4YoeW1GCik6Sg+0qVcHuo0Ekt?=
 =?us-ascii?Q?6h46g8HGSHRhhcHRcaQVNxmJoB7vLmYx+R0vW+oSGNCcr7V5xIziNmaHeNh3?=
 =?us-ascii?Q?rVqxc4ZtEzbMoSX2EjywndocPEHgEGqEQHAfBEorbeHbd15Anz1TTZegwsa1?=
 =?us-ascii?Q?PEEnfFCoxPn6Eh7Kesf33sYhkStbteUxW1iZoIVBsKdcbXDEIe/hBX7Mb0hY?=
 =?us-ascii?Q?EbPUN8ke/Q+DGqno0r8tub2Gj6sVill2b6ivZqUCNCbXt3nrRZ8qs/k147NE?=
 =?us-ascii?Q?tHH602nuMbnUoZ0iBG14uT5atkWMKZm6W72kbW88uvNC5lvg6Rk2hY8QsOnC?=
 =?us-ascii?Q?/N3K1Ht163g92o33xajJ2vvEW4ajJ0esKfr/3BkOviv303+d9213BnR9ZUWK?=
 =?us-ascii?Q?BPlJOdsXDYj7Djjcui1LzF8U9ckmO9oAfww71wq3jdtaauYeTTEnbNFNTZov?=
 =?us-ascii?Q?dCNvNIM+MOTTXDQtENS9bm89DVsrLto5siif2++xYwwk3hErY39Qp/XXXgl7?=
 =?us-ascii?Q?+7dcL/+Re9AOACfwV8ArsNnTZE/F16fG66NVTISFXcbjRJTr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29c961c-0983-42c6-61d2-08dec71554a0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 17:25:56.3829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +E2o5H0iUeQiKKrgX5HC1lYwCcTJRwmfeR4UoSvIIb/nodYQk50cN6kl/ACBzv+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22087-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:selvin.xavier@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9B2A66BFEF

On Sat, Jun 06, 2026 at 12:06:44PM +0800, Ruoyu Wang wrote:
> bnxt_re_debugfs_add_pdev() allocates per-file private data for the CC
> configuration debugfs entries. The loop that initializes those entries
> uses rdev->cc_config_params immediately, so allocation failure would lead
> to NULL pointer dereferences while setting up debugfs.
> 
> Debugfs is best-effort. If the CC configuration private data cannot be
> allocated, skip those entries and continue with the independent CQ
> coalescing debugfs setup.
> 
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  drivers/infiniband/hw/bnxt_re/debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied though

>  	rdev->cc_config_params = kzalloc_obj(*cc_params);
> +	if (!rdev->cc_config_params)
> +		goto init_cq_coal;

I changed this to just return, there is no point in continuing to
setup as the machine is probably dead if this fails.

Thanks,
Jason

