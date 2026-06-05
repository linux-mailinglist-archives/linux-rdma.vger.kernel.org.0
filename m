Return-Path: <linux-rdma+bounces-21847-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lg63Kf0DI2rKgQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21847-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:14:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECE964A09C
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:14:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=CxlgvbbW;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21847-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21847-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90A68303B858
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042B237703A;
	Fri,  5 Jun 2026 17:03:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437F369234
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 17:03:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679029; cv=fail; b=nlcDYZ2ibOeSOgPy2rU73f2s9KPkJhoxaezlLeKtZElWd7mqnsKn2eprz+HFuBX4rREPl6epzlmsD/WbghLZcUMnDjFDZXCHNb8g02Wh5LCYOox3/Zhnx26h3npSEgm/3guP7/xSeIFWfjLHIouwBdL4lCPsmnvr9zHxP//x5/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679029; c=relaxed/simple;
	bh=wEqKqLWiKw756WMWA3cfEgCnWh92AzrNsNxUpJL6NZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AchY1+ZAxedaGgny9xgF8KhL0FD9xB0XVDNJCyYoztgkV2e+6o/iQmUDbpIehASuVXJmUYvyY3LBWs5AtbCLMn1XVrbIx4pcHcJJv1EYrd7vNNwHv4JValQqpjNLh7UVrKDluHQ5eX0hye7OE0veRYoxSy1tpIu5/ql2qRX2r74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CxlgvbbW; arc=fail smtp.client-ip=52.101.53.28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOcmTB128We5U+BXg14ABJEf9DysYut7CepGA1kMcC7mJmv3wLMaKgb8z5Uu9lGI3lS3TAXP04zZXhVg1jppRZumyu+T2C72vFc2n7ysPEXSjr8OUx4yYDuLBAHIgEpTEiza9nUqch2Nt2g8ZUhkTcsGljyZVTbC70yk/LndGtuIUlaNaIXvasYyHpjTUdqIlKrtOZ2Ni8eQL/ZMzoeh13eAThOtikXL4wqQCRCiOA3qK9MvLhckrg+7vbn3NAi5t4eKnj1hBrWBjtT8VAtzOJqwzVtcMF01iTYXwMP5d9R5jQCMxR/H8juOM2odoJHu4IasU5R52DRzVc7lwlhN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOl17BCurcuahgyqOMSVBi8Yx5+J0daTJfbM5ZGt3AI=;
 b=q2X/I9Pbx1szOGgdadGg+8XmuMQ/8WhFrhpLrirCIaXwOvoKBbXhBPobVm5PpvjW53EGh7neRLWTmeuVchorGKuiM2E9e41aJWKdWob44MgSnhFK8peXxfLQc1/Xq/KUwqAOXKPLD5d7CYCcH45+vO4jjHAZgjkPnR/wFGqEOf7abuG3APRV4Rosu+ugKbdNjexlTTp6khKDl6kT1zY7yApYM7Nt9XnS3UZMTF1rctjPLGQTAvGRf4BW5e/W3Sv9apy5df0/FQFq4BzSLxzhIeUS1qiDTfw78iOD54XG5c+9/Ec0GO+DbGxUVjEFXlKQAHR3vEvhsITMf6Kfv55uag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOl17BCurcuahgyqOMSVBi8Yx5+J0daTJfbM5ZGt3AI=;
 b=CxlgvbbWop/BGT2JLQCj1B1DZFQ1vF4cexVYyddLOb3YBMPJKO/OFEQzs2b1Ac7GWeZE5G75TvwjfEQG+xsQJ5pgD6F81KjK+UtTQnGV2Cv8BnDUVIxzMZ+pxdxz4fafRfT+ICkvQUouHo00x5iGJ7RfubcGgmbGhmLc8BH8zMg5NAZE6hGFTGtlP6ODuxExkkUvYbP81q+IgNh7utnAZ9jLQwnP695sXpqWGiO4NZWmMZ/wDZ3YO25nT6M87p5FUchP0rUmcm6vipBLaU7l37xO8+9e5W5BYdwCm66KWG9FMFq6eKCVY8BfApTNAvgpuz0JVKGrmNtQmFJsAs8wIA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 17:03:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 17:03:39 +0000
Date: Fri, 5 Jun 2026 14:03:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: lirongqing <lirongqing@baidu.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Fix error propagation in __mlx5_ib_add
Message-ID: <20260605170338.GB2765215@nvidia.com>
References: <20260601095654.2178-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601095654.2178-1-lirongqing@baidu.com>
X-ClientProxiedBy: BLAP220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff9f613-00ae-4021-0d23-08dec3246399
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	55afWHklVX5/o87OHyyHuJXfIM5Ha+ZLUU2hfiPe4+2PzLgwxpvPTWEeH3LyK6LS7uOS8ewmltAM9p3ZH6LNQEh1i4A/f+5qvOUML3wMEiRd8waOZBERAvvRAggV8sYyFJeAKPAx4fWgn3NQF/NFZfq0G3Ef8ZUJ2S7BHoKW/bQYfws9EYkA0VAXa9ZHgiRmEJkcT2vhiJw6keP9Om4YGVT6COiM9TSgAPheA6P73YDFwnc+acz0aPkc1LppjNJmcow3p4EXP6X3g66569ya6yiKxFW74pLmGSlj16svIaKYldrdvlrqNsP5ib9m+O5FpvjYwC81mDyfPSZG1ei7TL6IePXCrOf9qShcnkOnTuXJQcHTaLTeGpbMWwQz7ETVJyzhFxUYuzgX6+cUk/9uLB9nFIQ8mQuTiYOkx5wg7zfHMdNxGKAV/0mLlz0W+hSKVe2Xglz5i5v8xySNxokHzinZRfyy13rfTwhUxAhGZVYJvE7XUyF9J1JYoheWS0ijJ8eTSspuHZ7mzIemS8h7k3Qn9IVsHDj8yznv38ERwk/WCwYsuhyluK32atI/4zAPtlYT+YnEqQ7srf+sner2Pe4CS2fiIJrbOrSFxJCOpP4YQE1iX45IuWlPFpyItTJwBYEq0LYoqNHmYUSe+AomrMMdhcKQUtb/6vmMKakV3VInlbpLQgXXRxlbjBZA7254
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sYW9fQmX7FnQ9CttLgKaoM+EAjAFEC+ZddKbnqf+45oUCmemI/9cADxiIb/H?=
 =?us-ascii?Q?RXysFi2PaYXa8q3/TDfDKUMl8wXQVMLum+JNQThmUn/OZDRej5UoVlLR85pw?=
 =?us-ascii?Q?o+b0ZR8Zg4rQDfiMpeGldjweyV09UFZCgc6qKWEMj0gLuHxvoAFC8IYboDO+?=
 =?us-ascii?Q?szEvEvDL7d61C8mWrhUJqwsvuCTqrhixIXiBWT5GHSt04DYkFOOfl3B4a9fg?=
 =?us-ascii?Q?fqYajwNPA192/h/8/ImaAjWagtLgTeuhdQArrQtE/huQrE+3qJLaKMX6RE6/?=
 =?us-ascii?Q?abJzXaj/4dWUHG9fQ06WRTK5INxhVzdY/R9fLE7eh3MIKKlmmNTn9iiOWR46?=
 =?us-ascii?Q?vbYm9OHsE6yYSnh5cKG2RassRKVZs74uwGR76sf5TJu3lQv7IVwqfz5W+v8l?=
 =?us-ascii?Q?6O8Bgbq7XolgAM7txWh1uB9f6gC1V0WgyQ96l2p3fJmAINH8Cnf8Dqp5qA08?=
 =?us-ascii?Q?N7bVqKeqBsUICRRLkuOxolsAQbYJ6TI1eY00nHl2VstjQIA8m7ufo0qIA3gI?=
 =?us-ascii?Q?v2hZ9CgU16l3VG1Qlvbt+5S1B+AZMDHtziIagieeDUl0HFj9gmq5bBIFQHmK?=
 =?us-ascii?Q?nR5qywLdxoJxNX4tIaNmFG4+G/Z2/5jdNOHOsCj9y9K+bxlmtI0IPbHcjxjM?=
 =?us-ascii?Q?/YXBP5NNE9hzQGrIeCRJA5kM1ZMbdIwXlL9XQbu1QeIb9P+a9/6XGOLESL3X?=
 =?us-ascii?Q?DHFJe4qWZR3DBmTXYsEJhVO2h5QsAjG4WAKI//HJ0ViBx5eJ6WDv3tBQhBmA?=
 =?us-ascii?Q?M6MpKr+KFUNN1kW+7eQ9fq1i4bwxvDALiD4I3HrSsMSSY8QexSFrfvvrD+Fu?=
 =?us-ascii?Q?fbql5+e0I5DjGOApsZvgeoVHlRu26P/GW5SsfMajQ/b7nMsZkwEIWNIohg/4?=
 =?us-ascii?Q?x30+9aiNHHJuR1Q0l4KOxTH8Q7yV+g7/zsol9vpj8lYQVs+t4jxnQygOAJ+Y?=
 =?us-ascii?Q?6UyaZMYcoDRYy4VQqCnwogPTX+D3IHts4bBrfW6Go96lcVkQ7qlT8R471OG1?=
 =?us-ascii?Q?HaAU4wGKtJz86J6ovx8Mktu8xvZW110wrzLLixLfWG+KImexp1B9Cu6aaBt8?=
 =?us-ascii?Q?4O1zBCQRiHnZlKf2if5L2Wz0w9wQYR9k6Yb0Kn5BqJ80g6nfdZW2l/5MZSG0?=
 =?us-ascii?Q?le0WVMVqyTIv00Eo0RDj7SyImXkbKHZ2KHZzCbnrr+qNM87n+npnMXptf5iv?=
 =?us-ascii?Q?ojKoj7KOwGcWNNiA2nu3CL/70+kRcnHX15XYd0ZzMs/diiGBALriAAVPu2Pt?=
 =?us-ascii?Q?tNFqEXHV55xfLdBNjHolJRLx0+KtsIop05o0jp6UQPjzB8qbFgArhPs24ZQI?=
 =?us-ascii?Q?aQfPBe3u9h0gLNxzqHgDazN7v7FqowLfwvzhY64GGSpCrK6Y+tMQ06X1AAd6?=
 =?us-ascii?Q?2cqF2m9+0INP2UnRj2/1ID39ZuxUUIIdJAteBYx+IaGq2XNs4iUGVuQW7qOw?=
 =?us-ascii?Q?NOi08VfbaKKUCa5uEgqP4vLHcmhBIA8X1JtGTXmzqnjo2yLJhZMjMP4zBmYY?=
 =?us-ascii?Q?Ug3JcSSsjigy/+GSbmMFHmPsmoM7+FrnlK52H6kK0WtLVGFZlPXNTjdOE/5c?=
 =?us-ascii?Q?bkfC+hdU4p4vOCQQlehXXG4kgMKqFCcDJw87+PPP814/2VfuVaBvIP2Em/yY?=
 =?us-ascii?Q?IvNG6/ox/qHSaepr+20RuTV1MKHjpkk0B6BemCObo9GmzN/YCxRlbSY5kCF4?=
 =?us-ascii?Q?ivmS8SXSBAMChUkxADL9SQM1oI7ncoYG9TYAIBXLxjqnHS3g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff9f613-00ae-4021-0d23-08dec3246399
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 17:03:39.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oe4a4iUvGMjWydhcGS9+B/KRsV5Q2fYA0WlytAMMlnls7gfNfbqh80j/araYwCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21847-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lirongqing@baidu.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:mid,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9ECE964A09C

On Mon, Jun 01, 2026 at 05:56:54AM -0400, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> __mlx5_ib_add() currently returns -ENOMEM on any stage initialization
> failure, losing the actual error code returned by the init function.
> This makes it impossible for callers to distinguish between different
> failure reasons (e.g. -EINVAL, -EIO, -EOPNOTSUPP) and leads to
> misleading error handling.
> 
> Fix it by returning the actual error code stored in 'err'.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason

