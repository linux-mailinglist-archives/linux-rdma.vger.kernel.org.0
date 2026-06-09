Return-Path: <linux-rdma+bounces-22008-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nDVAB3jMJ2ql2QIAu9opvQ
	(envelope-from <linux-rdma+bounces-22008-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 10:19:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DD565DAA8
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 10:19:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="b/0YjtP0";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22008-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22008-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D01C30A38CB
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 08:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3133EDAC7;
	Tue,  9 Jun 2026 08:10:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B003ED3D1;
	Tue,  9 Jun 2026 08:10:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992626; cv=fail; b=sUYcbq4bANSK/c9N0LQsNkLqsbdzkCsPYj74F77RYcXxhZYnNC1ERae5/uP4OeP6zfDxjYGXLCkClBfdyyLH8/2sjzyQrIKe+uIXwoa/xoFpCiiWumit0D4FR3nOn7nZNNnenI7QkirBQPnTVDkXlhbfaVaSQvhWVUt0fWx/ANQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992626; c=relaxed/simple;
	bh=bXO8ighz8OWl+s9OfXKdWMQa1OEXd+vYyO6+G+i4VzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fv6+Ftl1Sk5EiSmSgQuSeRUb6Q2DZ3guNsXIT06NTE4kVH+AgSCoFlzYSfbgSFtiz2ae+jP8jVph67wxWrQmow7tEFnBKyIxT5a5NBYG5BmfQoj4WuZ4rVamnXibtwUQc4McATS/khja1YzJ+rIJVQA4KlT+D/Ojnnc5wRQUHn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b/0YjtP0; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJ162TOjq3TYHEzJK1LF0SHmHxJZfYXYVqkPhP2h2C88zg1vBMbagBbLAOy5nZGV0F7D6QSqlYXsjHzL4sM9i9Vn9ftgsNqJcHxAX8+Ha4ou9ALHPlnEB3w/63g6dfPkLnNgkIA6YFIv8cFFI+eNXyiGoKAs3St+8/1R1vZP5bmTPxJqm/xh7qGeK4lzGOAASUG8lyEQDlcGrvsYey23KX4hVBw1+H2iJNnaGez1/qNt7K/wgQ9+Uq/+EwAecTX2+asgeemi3Ryt1xadMyb1y4rvRJtRMgitQ+ZF4wxyozLqQ96cwZXsbWke4PKuA3LYMc+j21ZiVCz1+Fpt6Hx2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OG/CD6Beh8bBjWm2fruFycMJJkPDh9J+6IKZy7nCz0=;
 b=vfw5HyJrHlWFdQgOXpyXQ3+PCr/XrNZ7guGHTfjuBw2YBYwHzoxAeRu5FbM1/TzGu7VEAKuemBZK7yClQMFBsLaV/g+Iyr3KAWuYtM0xS0eD3BTFRnvAinP/7MtDznAu18K2812tfcpYxp7E2toslGjP296oGGhJBX/ss1fxphMFAf/kRVBM+7WL2WMAtfgGZJJZwnLEW6y8jA4pNg5wTpOuFwfajKScyLU9Mj1c4T/FI8sylAgBe55es1ACTN2ZUk6Tft04a1Fl10xcJDdfNkpWwO5xtL9wVfcFbs/d6dRV2avv1buP9xa/jsYIlsU24wk/VN5N45Z8sS2f3viyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OG/CD6Beh8bBjWm2fruFycMJJkPDh9J+6IKZy7nCz0=;
 b=b/0YjtP0INpnJvGNrV28KyrXkSIg/s2kjfqjPn9bHonIwY155ePtT0ZaeocafxOJ5XechoSdzy/MTkMb6cVc8zxNZSZVfxZ9/EizENHH5dTYHF2WHivbnxCw74+eJsoG28NlznBAoxD6RxoA8KZo6YOc6oRyt1atHLuP5ovOxDk=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 08:10:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 08:10:20 +0000
Message-ID: <40243782-e4ff-435c-ae40-3ac1c7c4815e@amd.com>
Date: Tue, 9 Jun 2026 10:10:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] dma-buf: add optional get_tph() callback
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <20260608185646.4085127-1-zhipingz@meta.com>
 <20260608185646.4085127-4-zhipingz@meta.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260608185646.4085127-4-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2c72f9-4f2e-4cc3-7edb-08dec5fe8c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	FN8VdltyksNbhVVztnm2It9eyaKUCBHpjsuM6Rg0/VlO415hZ2mIIEpxh6uv78RDNhYVV8M+Uwp+Tvs1DShXSwSEc6Gfwl78So9RP/XLk1aWbEhDTDPBa3SUOBa+83cZmi0ky02cueiW/4mo+/cV9n14vWu3+P2gTgqk3Uo85Kv6oi+JZodY+Cz+JrcPnAGT4WsIalusmnUKPrVPJiGX3iCdldfqHTLg6H4HBPCvmNHBcjG0kphrKFw2EBsF0+2oN+SNTGsqWys24aOWyiszjPNkR98hPvSdr+zn0SCG/5rGcJyoZsWX69OfWvB10BHBgn3/dlgCxbWe0SBrS7tGNzM0q3Kk+xsnVvW2wDO8VXUrBOrRTvsD0sMi/lDMo+rxPHr1NHaNDBSi1UNA62yOsxdIMwpRam94+11UZeNDUqz0X/oAWMDPZFoznnEx0dHyflGrAbaLPDpdVbUfpIo9WrihDhFHTV2H7OfGPTx80wq657rkY89tye1t+w21/oZ2k9yCfQfNFt6Vek53jpLH2C7gizszLa6HMvTmTBUAn9haSfBzjF4gH9D5UOV3pykTLeo8KA4BoKjZxftJuPPA17DYnDeyRH3FFqGezE2/gYNHy+fVnQmseVWfRbsDikMMTtSD07cQYw3Utx76ChWPURDGyOq7zr8OBRiumNnjIyLfNDfnGYZ3AmR4kSuIqiQA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2ZKRkc3VHRqNUdpZGFDNlYxMkMzR3lPUncvdkd1SnoxbUdYV3EyS2Z5eFJD?=
 =?utf-8?B?L200UVdOczB3T0V3T3lrbmJrdEJ0bHdHRmhXZEJYb25UT2tjbHdsUmZKNFA2?=
 =?utf-8?B?RnVMaGd4TjRPQWdPMi92cUcyUXp5M0lOckFOYWpMUFUxNnlUckVYcUV3TUxr?=
 =?utf-8?B?c1hlcGllNDJ0NnJGdE4waG4waHJmT2huZFVveXhPMDQ2YXVLVVNkTWRmdHdw?=
 =?utf-8?B?TldwL0l4dVVkeGpGcS9HdGltdHo2ZEE2ZmFXSnJQUXM1TzAvai9GOEczUDAy?=
 =?utf-8?B?MVFuR2JNRWN0L05LUk1ubG9hT3haajFCQ2trOGFwRytrblhwKzdpeFB3R3d1?=
 =?utf-8?B?SEJZMlZUY2p5S0VWYlhzak1adjNhcmZYNnlMMkptWjdEb2lpb0tqaGZtWUI5?=
 =?utf-8?B?WFhtUGV6NkpjdEZha0RsdHE3VU1vMWhZUjlyOTlaTG52aGVuVkdVK2xITXZL?=
 =?utf-8?B?UGZUV1ZweXQ4cHlWejcyUVRFcXdUY2Q1MWROZ1ArQWVJVEh3K2JKeGw2VUEy?=
 =?utf-8?B?Y2dDb0RibzdDYjJHeW85cmsxU0RheCtvTG50V3duSzJIS2FlZU1YN3AwbXNy?=
 =?utf-8?B?eEhvLzlPWmlMemJCWVJZTDBweU5kLzRVdGNJbExnUVdFU3F3bHlmeTNMblc0?=
 =?utf-8?B?M0tsblhaM0FZN1J1eHVUY281T1RiR0d6Q3E3MVVOdGdEUGZsbnU4Si9nclVQ?=
 =?utf-8?B?UWt6d0FpUmNwdUd0c2NaN0FTRlhucVNWTTdJTVBzZXNncUU2YTJHRCt5UmhH?=
 =?utf-8?B?NW9QNDh0RGhaNlR2Q29GakoxZDF4RkNpZXNnbHNPUHFlbzdod2hrbHNra1Uw?=
 =?utf-8?B?Mi9SSnpjdXZQaTlLN3JtQzRDVTVkR0lwTmVPaUthZXQ3UXlsbVI5b29DL2la?=
 =?utf-8?B?SmFoMk9aYnV2dm5GY3pjVUxWcVpHaEJlZWJqU2ZuM1JDQ2RMMDRrenJyd2sv?=
 =?utf-8?B?U0JrQnJ1UklLYUppczVLdkIxQlFWV3BZTWhOZ2tvUVd1S1ExM05LRXBScHNn?=
 =?utf-8?B?WDZxa3JJMklDTUp5bndBSGU0MVVBVE5xbFVRZ1hkUDkyanRua1hUN0pRTnMr?=
 =?utf-8?B?a29RQ2R0UWtEd1FUalA0N2Q3RFV2ZTMvT0VTbVhiTXp5R3ppdFNqVWZNY25u?=
 =?utf-8?B?Ym5PWmhmZEpEeTVqVXVLb2FYalZwTFE5TnlUbGxNcitETlVnc3ZXRVFCL3Q4?=
 =?utf-8?B?ZGhPMlh2MFMzQUZKZk1XY1E5Z1hnaWk5RGVkT3lMV0xQZ1BmTG9Qd3hJZGty?=
 =?utf-8?B?L1VBa3NZa3FtN2ZiQW1DUTRKRkJNcW1GSkVNeDZERHk1L1M0aUUwM0VGOFZR?=
 =?utf-8?B?eUxJaUhKOTZlQ3hiRndNUStFY25qVElXNEJwL0taOCt3QTRjNzRRQUUxaWRr?=
 =?utf-8?B?ZUZKZkhhUFlUbjlWQVcwNDI1Z2MzTGdweTY1OFlUemV3T29iM3lUM1h4N2JM?=
 =?utf-8?B?ZFVIMER3cXNBTzJrYUNRaTdtYklIS0JKY3JjcUpwa0N2Y1dvMHpCbUFiUndq?=
 =?utf-8?B?TzZlMFJXa0FCMEV1Ykl1Yjd6MXBFY3AwRkl1ekM3OXc1S012YWVZVWYyN3hP?=
 =?utf-8?B?bXl1Qk45MFNadHF0YkFsaVhXakx6VEUvMWlSb3pnWjJHOTF0dU9CNFFMV1Mr?=
 =?utf-8?B?ZHdEeCsxOGtzUng0QWJQZmJJWHhUOUozMTdlYmhka3prNHpqSjV4VFVDcnM2?=
 =?utf-8?B?ZjZsUmhmU2NobndNOUtJM3lTdFlJL1FHdEpsU1JWaEMwQng0RUYvQ0VHWlIv?=
 =?utf-8?B?bVk2d1dLa2k1ajNrdkNmOFBrS3lTellpWndYdjRBRVFWTUg0QVVnMzhTcnBX?=
 =?utf-8?B?Wml5VWduZW1yQ2JudkJoQlQ5NUJoSjkzcnVzbE15RW92MnZQcmsxYVBjNjZ0?=
 =?utf-8?B?M1BFZ0x5cHZMTXlTQ1Yxd1VnbWFiYVdOTHdyNFJGNWtoTytaU3FFc2hGb2hn?=
 =?utf-8?B?bGhZb1AyZXd6WTlkREJXK0ZMN3Z2ZDNnbzhSRkhTbUxXZFRONitFVkZQSHRZ?=
 =?utf-8?B?YnlHeFhkWFJkcnI1cTVoRm4wMXRScTlnckk3S1RSTWkxbjQ0WTg0enUrMm41?=
 =?utf-8?B?dVlPUDRZYmpoREFlWCsyaTUzOVo4ZlRqa1RNSHVDTVY3VDI2Q3FUdFphalNx?=
 =?utf-8?B?K3NhMjVDNm1iYzZZL3BkeXJnM0xTZiswdThvL25QTDRTaDhPaTlqU28vRVZV?=
 =?utf-8?B?akxtVlBpNmM2NFZEdDM3V3VsOG1qM1RGNmxhdTM4ZXRJQVVtRXVQTzZSSkNj?=
 =?utf-8?B?c09VY0g0ZTdodXNweHdQWnVhZmJmNkF5RUQ2WUZQVnlsYlhXcXQ4TzNncFVl?=
 =?utf-8?Q?gg1dsuGATmuDP9oRO/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2c72f9-4f2e-4cc3-7edb-08dec5fe8c5e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:10:20.2326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmYqpQaeHgyRt5afyFMdTzpoBQREunVx+E52ISUS7dwYKO/fBm881VHtquCcN02n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22008-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87DD565DAA8

On 6/8/26 20:56, Zhiping Zhang wrote:
> Add an optional dma-buf get_tph callback so an exporter can return TPH
> (TLP Processing Hints) metadata to an importer.
> 
> 8-bit ST and 16-bit Extended ST are distinct namespaces in the PCIe TPH
> ST table and may both be present with different values. The importer
> passes its supported steering-tag width and the exporter returns the
> matching value, or -EOPNOTSUPP if no metadata is available for that
> width.
> 
> The callback is intentionally exporter-owned and optional. The exporter
> owns the completing address space for the dma-buf, so only it can decide
> whether it has meaningful TPH metadata for that completer. The dma-buf
> core keeps the returned ST/PH tuple opaque and simply provides a
> discoverable negotiation point between exporter and importer; exporters
> that cannot derive a useful tuple just return -EOPNOTSUPP.
> 
> That keeps the kernel API generic rather than VFIO-specific. The first
> user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with the mlx5 RDMA
> driver as the first importer, but any future exporter that can derive a
> TPH tuple for its completing address space can reuse the same callback.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  include/linux/dma-buf.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d1203da56fc5..8437dbe4a83e 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -113,6 +113,37 @@ struct dma_buf_ops {
>  	 */
>  	void (*unpin)(struct dma_buf_attachment *attach);
>  
> +	/**
> +	 * @get_tph:
> +	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
> +	 * @extended: false to request the 8-bit ST namespace, true to request
> +	 *            the 16-bit Extended ST namespace
> +	 * @steering_tag: Returns the raw TPH steering tag for the requested
> +	 *                namespace
> +	 * @ph: Returns the TPH processing hint (2-bit value)
> +	 *
> +	 * Return the TPH (TLP Processing Hints) metadata associated with this
> +	 * DMA buffer for the requested steering-tag namespace. 8-bit ST and
> +	 * 16-bit Extended ST are distinct namespaces in the PCIe TPH ST table
> +	 * and may both be present with different values, so the exporter must
> +	 * select the value that matches @extended and must not substitute one
> +	 * for the other.
> +	 *
> +	 * The exporter owns the completing address space for @dmabuf and
> +	 * therefore decides whether it can derive meaningful TPH metadata for
> +	 * that completer. The dma-buf core treats the returned ST/PH tuple as
> +	 * opaque transport metadata; importers that support TPH place it on
> +	 * outbound TLPs, while exporters that cannot derive a useful tuple
> +	 * simply return -EOPNOTSUPP.
> +	 *
> +	 * Return 0 on success, or -EOPNOTSUPP if no metadata is available for
> +	 * the requested namespace.
> +	 *
> +	 * This callback is optional.
> +	 */
> +	int (*get_tph)(struct dma_buf *dmabuf, bool extended,
> +		       u16 *steering_tag, u8 *ph);
> +

That needs a wrapper for importers to call which also handles if the callback isn't present.

Regards,
Christian.

>  	/**
>  	 * @map_dma_buf:
>  	 *


