Return-Path: <linux-rdma+bounces-22289-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id poGNLxqfMWrloQUAu9opvQ
	(envelope-from <linux-rdma+bounces-22289-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 21:08:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C09694C4B
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 21:08:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=e0oRZkbg;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22289-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22289-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2673F304DE88
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 19:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309D93DE425;
	Tue, 16 Jun 2026 19:07:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B5318EDA
	for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 19:07:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636871; cv=fail; b=fRG24Ng0UCiVeqst0FbzGz86XuEWKoR11t0JL6AynbL7HR0AtM7R+83hVY5imGIPEmtRpzbe7ETANtVf7PVnz7rsZPDxWlQoGbncb2D85PkOWse10K+4GBA9yZAXh0nBrLnIMJrH+M4RqTgE2tqqiRtL8KB5m50cu8eiNHo5l0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636871; c=relaxed/simple;
	bh=Qr7QVxcR47QWLhrmZFIrH+g/eBedoiaz//5iWkxeFZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QOz1W62kfckPzDwTJBnNTdMbEtVy8NMwQDJsd94duEQr2ZLlmzSKBCxQcs+Biz0cMiKHB0kOKCgpiLQgd+C1oMXXj8BbO5Z2mQyT8o6BsO/Ki4EZoY9s6Zvhw3WxcS8WydYWT0E5xbRwnbKVLVfcKkmDq9tkp70wE0JAgH8EXsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e0oRZkbg; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQAGgPy1/0I9VIXWbGHfoaKEOmdwVN3uapmkb9gEcOaIX/rNirgK1lIOXGnhuH2BXdeAluntMXFEywv1+7nMyAaFDoxhyCqu/qKE38fp3KzRk3QqCMWhVKObdYKDgYTRAJYk9P5dYzyDbm5jPTOXRzrbxMz2q8MLnaj4jCHmk2HzdWXth0mGuR260WKXGUDrmlv95nmevtkDivMTbrvavCbrmgToN0vZ0AVgEX1rPDMx5UYrO2iT9hqNu4WvEN7Cu9kKTmyaO7sCtEuQsUYDRz2YVH8JFYTKUDvaUQkNTDHnCN/WoN7HSsFkfqs8AWmWoaGl8dBPcuurwiXS9rmQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARJ/FjWcLgOTKPG9kr4iIw8nWXEkAzQcHf2UMJjkSkA=;
 b=vFpyZ5zKfFCbowMYQbY6ACcLfA+VTCrUmUvBviHGMbS+xsK5STZtWSqNjUcEH16SmxE7/Dc/s3t5sAbOX+XJ1TQRl03V7b+5OA1jE0mBzUq9vFBYYtnwAdJludTxp0wjXIjjBuM1WgOB3uYofb2yWwB8p5OdpJEfH/oTPlpi+yuOZGRjgb7gkKrAFb5VQP/xZS9RRuMOwx/9kU5XkeSP1rrYY/J2I8vqsiGEaf7M8WIvfkZkfytSIVdXDjyBZEZRGheyDb3WiWbqCPiQ0N/MeGIgZKz/1cuP6TShd0vsILbbhPh8Hiygcu2cVZzHTj6tsHlbvdGkw5w3vXl/X+i9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARJ/FjWcLgOTKPG9kr4iIw8nWXEkAzQcHf2UMJjkSkA=;
 b=e0oRZkbg+42ZmEL/+Zyr9nhu1JS/u90BM3VbKAhJ4XG7rx+RlZSyrEy1F0aPj6UXAfvbRZ52ol1jUoQgFghZLT+2fFzeRhYJC2QKJc8221Hwor+xlJLE8u6HeVoEk7dwwdcDcCBlIs85p96/EBvF0e3pR/Uja6w1wZgqM0dgP0L2bylgOIxuI/eNQbSLqTDbOVwr6A+LtCjTADJYAyiqKcngs4w8MhrtT9wlBWqA4CSunRVCCECURMGC84QLieMkGg4gib5dbQ41RNlaB1Qfa4MHwkiCO025ZUX4u/MSwPmPHM+1Ed4dHoXKeBdZn5+ftZaQD0d3AIIt0lZzX2wOWw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 19:07:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 19:07:42 +0000
Date: Tue, 16 Jun 2026 16:07:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH v2 for-next] RDMA/hns: Fix memory leak of bonding
 resources
Message-ID: <20260616190741.GB3986358@nvidia.com>
References: <20260613102045.811623-1-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613102045.811623-1-huangjunxian6@hisilicon.com>
X-ClientProxiedBy: BL1PR13CA0330.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d8e40f-ae58-4728-e0db-08decbda8acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9TTH2L98a/EQ2UGv9hEsprirJBeV7NNAkpBBhOKIrd1GXqZYXq4DvRoEoIiGoZHplYguar4SI6+hU+ftfmMfZ7Jlip9YNOVcKB9WsIJ09F4lF9RM6ZMw8UvIDmjZOW9yjEhTofdeDcb5nxLAfvdoPXFhUThGi2h1vjsMckWKLCtt+P32AMbI6QXhyHo34hmqe50LnL/hi5kM3ou2tLb7eupFdiCkZXWZdiCVjmN94jCfQ5V0p9wPoJjFB7nsVDUd16J5c8wgygpbVrB8cbx3Faqg3xVTM4jBUCCrBIFAeDqaTMigxG1SzKv157nFasOCOlmX3uQHW+pB76mvzWssAqg8pYCyAeOFwBMRzL/885HHHsmx1nb/AyoOzlnbEd8FuovzRy6phZvdGuzuaqIKYDxqTApzcXwnq4LhsJ5frp/ayeeXDbovILIkkPEfnvk6AE9dnzDsJ7ZFtyZ8kNmCIyq//KTrb26gmabqN2KyuMrN8zd8+gCkOklp8P/vKoBooJx54PGbQSWDAKYXgtOgOybtgLONV52fqbQ+OdfGH16Apm/fQRC2uJnEA/o2PeYJENldqUSZXlv00KLKUmFQSTmM3NTXO0vMXKlqCjHBsqqHdX2m3L8TpgaH8t1DJraHvgxxsx/IT37pDL/AJ+f+Y4rX7zJYFjSkSKlu9XoFyII3AYj0GCoQbhYQ6obpFsZC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zG/BbWIXK73JNPOA/v29ZHfAOTWqJd21GIsR8F/B/rQBg/we8hmBrTMedWyU?=
 =?us-ascii?Q?uhl/NN9e3S60PmFdhfHS8FNFjI2UUcpPGoJVQMcQyjHzVQrntb0hURCHq+/m?=
 =?us-ascii?Q?VQ8JFLUTg+pLcZ7sBh5leVMmVkHQs/M8UrCrEHtLE0KABCg75ehaC5vFiNjn?=
 =?us-ascii?Q?EXNnUVhWymaK9FrYmCisuk3uj41jH4F+MpiTEbTJKXx6fILnw9gSm5n7e2Ee?=
 =?us-ascii?Q?hBmtzGsCnk50Xo1ANcOmRFPJrJMAbd26mau2klkNRxx5KLxzoyeVUraTEhTi?=
 =?us-ascii?Q?/PfsU5plQrqRRmXA9pTJmQZNdSsyLD3wM2yWtPu901y4J+sH76EFS4PWf5Q3?=
 =?us-ascii?Q?QH2VEkwH3mRkV307PPz+2RQs2GEqU3UpVphBak62TxIJdDxzunKqBXGmgeQj?=
 =?us-ascii?Q?B0Zdb1H+TIuOI1bLaQuNON0egQLk/2GzqbdIoDeuQXlJCMmQK7YmVZKPZfXU?=
 =?us-ascii?Q?sLmGxcVzrn3HiN6GAwe0f4ZHkE00GxEILz+9Dxu7VIRwsxXN9OTkXJ4tbF3H?=
 =?us-ascii?Q?YRh+oLoXiAs61bytLu6Q5WhGFeZRLUc5j9nUDnSKBAO2YxaTaasasQfZViUD?=
 =?us-ascii?Q?PJ1jaP3XQiOfPIpjnfOEhVqNIj/EXCa1WgL4fT3ru1WH93G+m5WRXfreDdK0?=
 =?us-ascii?Q?VY434xuGDdneSSnbq7SLCsvbl/8q4vwx7osEIvE535txMH9PoCP+JT6Z+cdn?=
 =?us-ascii?Q?k8woHqbMdLeY1/cCi3anzWULArCxQuUTgzW4Qjm6kKGxVk63yDXW/is32vyU?=
 =?us-ascii?Q?Ym/yiRySLQ6ZzlPEG3148BgkzpytydRF/HVL9Y1Or7BQ3zHwuUEqiVbWrYcH?=
 =?us-ascii?Q?zW08YdLNf1c7CWCVYC0a8UVVbfl5KGeXJLp7blDE9kUq0TSB6sdWj5P+c/Qq?=
 =?us-ascii?Q?taiyAgsS2utkaD1K040P20MZ6PzP98KHBA7STPJQPaSFLg5Evfy0/9K/Y2KE?=
 =?us-ascii?Q?vxJ8ht/WTs7Grw4z5QQzkptfB1lnJr3AVI16Y1TUHeqe6958Ja1VAlny+IZ5?=
 =?us-ascii?Q?oPFnlDmM4Z5sWtdPTq0WrMFTIeRyOdeqQJFlyKNpDPVIhnJ/J+qqDLo/Zy0v?=
 =?us-ascii?Q?MRpqAtqLMoUVgN5AgPyWFuH7bnO5VNAWe/U3WMrLyTVWS8Fbvrt5OF4YnEs2?=
 =?us-ascii?Q?zVcTwZxuEhySS1oXp16PjDdjvAL3Bf2rWHhE4idR55m7cw8Cs7eQgXZ1ZqaH?=
 =?us-ascii?Q?GR3Ul5ME4Ph/g4ylVL7b01JPY0DGV07d/zdzvXbz6qU8GC0RS34hpdHxAOSV?=
 =?us-ascii?Q?Cv0ks5SlF4FWY54XeXbuvoEokH/4pCVWYqER3lPEG5nbILOPkhvLCrA9TEmZ?=
 =?us-ascii?Q?K2aV507nLKvlLm5njWoBxJr64jaRzTUEcG6GT+6ArvJ5o22+GKUfE2h3z3iH?=
 =?us-ascii?Q?WaIMKWyEhZyEek4LTqRUAtS/ZX7D8UgVThY5wpurv9Mb1E+QDpzaF7Ckl/xH?=
 =?us-ascii?Q?AdT+LCKFn+9V7/vxsPhGkeZIcnfiiWh8QKdcORuluICP3r/fgUmxJI/lsLn7?=
 =?us-ascii?Q?0r/8W/g+kuJ2SLvtXJ9Uh0GR4DMikM1rgBYllMmp1wqPj7IH3QwT1IPoliGu?=
 =?us-ascii?Q?ld6O1oqYslJLN4ihOmlh4GcV815GGWjddEuWMBVhcH5pcKfQA4ssIQbAJA/N?=
 =?us-ascii?Q?BNgM9vEVoCRxZJ8c2AAFyie7HZWWLztfCmKY7oRlUAQUcgIJ5h4INQVZ3S3H?=
 =?us-ascii?Q?ENVp+q8jgxSx7TWHFAqbanspdbrHWRgxNlxqH5HWUoO4ak6Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d8e40f-ae58-4728-e0db-08decbda8acf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 19:07:42.6827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RENe/oIjut46mdhnpumXi83lR++93fFFKXvsS5j0k2xu92ipY3y741zeXHwdmTRI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
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
	TAGGED_FROM(0.00)[bounces-22289-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:huangjunxian6@hisilicon.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linuxarm@huawei.com,m:tangchengchang@huawei.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47C09694C4B

On Sat, Jun 13, 2026 at 06:20:45PM +0800, Junxian Huang wrote:
> In a corner case of concurrent driver removal and driver reset,
> bonding resource is first released in hns_roce_hw_v2_exit() during
> driver removal, and then is allocated again in hns_roce_register_device()
> during driver reset. This leads to memory leak because the release
> timing has already passed. This may also lead to a kernel panic
> as below because of the leaked notifier callback:
> 
> Call trace:
>   0xffffa20fccc04978 (P)
>   raw_notifier_call_chain+0x20/0x38
>   call_netdevice_notifiers_info+0x60/0xb8
>   netdev_lower_state_changed+0x4c/0xb8
> 
> As Sashiko suggested, the teardown order of bonding resources should
> be inverted to make sure the resources are released when the driver
> is removed.
> 
> Fixes: b37ad2e290fc ("RDMA/hns: Initialize bonding resources")
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason

