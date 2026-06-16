Return-Path: <linux-rdma+bounces-22273-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HrwsGRzfMGrUYAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22273-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 07:29:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D0A68C2F2
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 07:28:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=cgcy0ckI;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22273-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22273-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CED63054520
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 05:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E3B3CF69B;
	Tue, 16 Jun 2026 05:28:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DACA3CF679;
	Tue, 16 Jun 2026 05:28:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587733; cv=fail; b=jkpcHzMFZUsBHX/X6syxrVMx4jImIf1QYSthnBeCJinzvRsGkr3Q5rl/g6l2BYle0JKTPB/6fO/KbEvY3yJVhql+ta6do+7xWMEdWztwOvsr0z0yepgLO7eOjg6atEvQI1hls1bkQ4H7ZhiqBY/D/+s/juBWlC7te2/Z0vDz0Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587733; c=relaxed/simple;
	bh=Q10YB513uyOVcWQYJhhTofqfCf+r1RunABZuXrF22tA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e30MuGqqZVErrVuDmptUWPGmQGcugLEcETRKLU/RQjaFwyy070vror03HB2upy6ob4bnHPDJhPWZAJ/apLqqrSs3YwwsGjNSyXCb0fiu3u8T1eHBajkUVJkBpHd4qFolZaKLs6MBz9swM4ZEECsmzmW4dbB1kpirhCbhmlp03lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cgcy0ckI; arc=fail smtp.client-ip=52.101.57.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ow1vQ+lkLD1szkbwI2tLsIfcOimnc8A6EwqLaBFUL4GpJbtp0vDHyweaKcBtzePcT/9N36ECEicBoWKFlZXlpEuM3W4sWZ9y2UO4WGAp4Z3XI35abEJi3Mda/u7XOT2j58SMsHg4IfqmQM20Omk48zqLpwKpYkVOtrkvn/6AmZm0LVMSE6e1K5vzNVP4TdCeMPkCxaq9iD+FS3A6UiPXxfn2hL+zyYcYKa5pzaJHGXje2ZlWMF76TtlJFYWduaX6CKUEUM3U3f2yjC7eYKXbU38wIEmbkxeGcTCfSHtMNrIc3J0as7UUIe0NvL8kcdh7xboczGFTaawgDgkDHoZEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/EJLDJcxrD544//TNeUkvjqW2+rPuDRI6+gvmFzIhE=;
 b=c7RrEieA1+QZb8qEHDQEd06FYp2zye7QfrpNO/bGZakTKdRAA6cOxy0sHFs+P9Sway5lSm8qYsLhScpOlVbg7s2H23hPmlLgAt5BIJhWFMC4z20BOUi7S+qgOMplc+eZahR/ZX0LD48m4z86fnr1IQfPnCxkX60h5azoC4B46Q/sk9C5s7hp98f8DPTKuQ7kF24zN7Coz1dJy9R3l39jB2reI+GgKMeGTKGDbdk2ZbwERrqcIwdYASKNCsLEtfBavwImU4jOtzvMHrRqu+pPB1wBkP6zVy8B2OKs5pJ+XeyQeLO67kyckprCqmeJ6WfJ8iX8awmsHJimQJAobrCPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/EJLDJcxrD544//TNeUkvjqW2+rPuDRI6+gvmFzIhE=;
 b=cgcy0ckIix4ojWnmYAdo2ti5zFIcaU+exE0kMTaHDd+BiDcVuQ6TegaqcUhsoyItVPqskyqhOVjzxbtky1czN+JqDBAX5Esmz/u4/VI3g5VLd3XBygkaQ+pbRJxlCoX75cWmZZFX47uHJGS4qY735yL9xusFtcOZ45vn5KcowcyQqNJAc2S7IbuJaMgDS9h8BWFHlEIOT0HQRK8LEKAY5TlpGMzls64NLiZb31ifGvWotWkV3BuhRJmc8JTdD2sU3wGwKiV+uNFDhYXyYVvwzNRfSVMUO4NoxWOq890LBhz5pYVOQDAKWtpAfFcvqJwri4D4nrYfCfVdNRvVHYLzhA==
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 05:28:48 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 05:28:48 +0000
Message-ID: <b5c24c51-5550-4829-a626-01a242d94e73@nvidia.com>
Date: Tue, 16 Jun 2026 08:28:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][net-next] net/mlx5: Remove broken and unused
 mlx5_query_mtppse()
To: lirongqing <lirongqing@baidu.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260615140406.1828-1-lirongqing@baidu.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260615140406.1828-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: ec170d37-1bcf-4f0f-46e4-08decb682494
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|921020|3023799007|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	d9iPs9vthNOwBJ5jCLyXfB1oZ2d3wPlD8ufRbIFBxUgFSGPVQ5FuOtJWl5b2j3KT+rkoBUg8Ss/FgOS4GdG6nDc5kp0Ufz5ACwc0G6elqgWPgJWKq08XLVjA1EG5k+58rv//i0TnpPAfa6EsBAmnQQ9aWdf0lHx8nxM/uBx+BGJAqTA9Rdg2sY++oFEMVdcKiln2unomUiL6JgQhxtgKIBem03d+yROf7ADS8OkSbbK65QiZ015/Rx2RFvqjd1YffZSrDZvlIi6CX2Gev5e/kHn0bSNagVHZ+cw4KtH2QNzlZNFPMrp+gv4BEXSVvxhIvGBxMv2klrRidiK0sietAhnKtZaCyBEGPz/ibA5xrFsp7hDkhNR+0a/hmRq3wu9TSCN82UnFvi+f4k03ckL8JsUTOWmLUDMUVGR7Ae5jsdIWtesBzJyFhQSrxIxpuXCfqOseuJzOJwtZrPBu1HQdtXt9ipk7O/xjJMjueuNTB/R3aoe4w7i7pfUz28+/5cZwWPfHhCS5VOameeMmSbRAtCThnWrrwVOKfwo7sEfa6WWcQ2clDqTgIUSwHDbl6pq5TjCf73ghhQe16fqTqV2qNIAzsERd/NQEKmSQP8cQzGdNn2IvGgGvAbm09SA1dz9z9xL2GmfxzrKJOvwFOKr4ntHnBiYiUQGGQEy36/4aetl6sPqXtiFdAtuUSd+i73Z88nuk9MhhA95hgoAVaaXkhtyRVoptBXpeX5bYHnfaeyM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(921020)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0Y3RTByYzI5RjRzNWJ6b0xoalRZbkxaYjlJa0lZbkRXc3V0UkcxS3ByS0t1?=
 =?utf-8?B?alZvT1IxL2crbkNuKzdNZGc5NTk3elpZelVaUTErZWU3OHR1cDZZTnMwUzNL?=
 =?utf-8?B?enBzN2NCMk5HK24zNGh5MGE1RkxpaXpudFJ2cHZzSzBUVWFnNVV6akpXcWt5?=
 =?utf-8?B?V2d3V0p2SFNVOVpucFBnTnhIc1A4OW1iWmRxR0d4cVNDNmpkWWhXYk9hRmkr?=
 =?utf-8?B?MjYwRlV5K3c5ZllkU1ZRTWlvT3dYc2k5LzFJMUtrU2hXb1Fab0ZQVEVPekJC?=
 =?utf-8?B?c2FCN1d5aUlNUlNvNUJPNXJDWnNxL2Jldmw3OUJ4QktCdjRUQVc0dDVXV05i?=
 =?utf-8?B?eXh5ZEYwdW01WGxZbjNQelFwNEQ2WUUwaHNvSzFvWGo2Q2NuWGY1dGRPNnBt?=
 =?utf-8?B?c2lmTytTdUNVMWZvZ2tKcjAwTEUwQVVnYktDcktlOVVrYzZ3ZmIvQ1R1TU56?=
 =?utf-8?B?YklGSms0M1NoaTF5NWROOC9EMHhIVnBycENDOXVEazl1N3F1d3N4cXVoaGZi?=
 =?utf-8?B?eFZNVFcxZHNNVFBBTmRzWXpsa2lrY0pqeDNHdCtUZUl3SlNBUnQrOWgrQkFp?=
 =?utf-8?B?d24wR0NvNUxDNzhCWmUxWFU0V1RBZGpCMmFMTzQ0THhYUDBZWGVGeStTSk40?=
 =?utf-8?B?Nnc3M0NqQllsWW9HcjBWNVRQcnpSSEg4Mk11dUlaemJTaEVhUE9FcklUcklD?=
 =?utf-8?B?WGJOdG5NNzI1bmFEaXo0Y3pLUWFzV0dzZ3FscTV4dzE1Z2ErNGRVaFVpRCsw?=
 =?utf-8?B?WldWaHNybXRlbWlDdmxpbFBwRGx6WjJrOEc4SEFnVW1Gb2NFSjk4d1ZXZG1l?=
 =?utf-8?B?c2ZIbysrZEpBRFB6aVJ2VW50TnZ1TDJ0SzVRMGR3c2RHTS9RUGRGWTM2WGxu?=
 =?utf-8?B?VmFKaWEyQXpyU2lpSlUwSHBOY012eDhNN1JOcXd2dTFQWW1ZSHpndEVBR2Fo?=
 =?utf-8?B?b3RLTkthRCsxMDU4VXJvTWhaRHlJRnQvMWU1MFhQdGk2Vld2KzE4cExqM1dr?=
 =?utf-8?B?QXgvT0hkcVFBNmQvZk54SUZKTXpXWnoreVJKNTZXYmp0OWRMZUpob2RyZFYy?=
 =?utf-8?B?TENpUUMyekFxTkZzbzV4SHVOOXFiVFRWdHhaSlFPNDFId3AvanJua2UrMTJQ?=
 =?utf-8?B?WW9tYmFpZlNxLzA1ZzRmVnlBQUdmL01qaTZRcnNaanZvaXpzbCtpN2J3T1g3?=
 =?utf-8?B?aXFDeEdVZTVGWk51NnIvOVhha2RsOFZQbjduODZFR29WYUNBOHFaenZzTFln?=
 =?utf-8?B?cEZRWFc3MkozV2kzNmI3eEh3L0pzcHlOUVY0RkxSdWJYWDE1OHpOM0F4Y2xY?=
 =?utf-8?B?S21OV0QwS1ZPNHgvWSttTU92UFNjSmFwNmJMQWgzWXlZck93UWhwR3o2NU0x?=
 =?utf-8?B?dFBEem5kc21UcjlPeGdZbEVzUjFZQ3BabG5rWFlHditEOXBualRSVDdHVk5M?=
 =?utf-8?B?dnVQK3JrbjFzVitDQlM0TWM1dmMyL0pnVEsvUG1HVEs2Z1BtOFlYMFVmamRO?=
 =?utf-8?B?NHlKT1hTeTJ4cmswYmh4NWVQYUJqeG44OGRnVnlsU0JqNEFOTmpYbGRlMU5h?=
 =?utf-8?B?NVBkNTNWK0RrOHRUeFBvWVp4UWVqaFMzWmoyWDRhZVFCeTNkYTE1YTVVUmNv?=
 =?utf-8?B?UTZydENUa1VGQmJydm1acXkvMlU4eW56SzdLakVuNzVJY3AxYy94VTVhV0Zr?=
 =?utf-8?B?eHpZUGNTV0pWL2NReVdCMHlBeXByT2FKSDRHOWViVXhLL3czLzlEdC95citW?=
 =?utf-8?B?RysxUWFOSTA5NnJwRHVLSGlURzlGMWdVRFNNTVh4V0ZsTitGYkNDQmVrR0o3?=
 =?utf-8?B?c0NROHBIb3hocks3dzRSWEpZdUE3Z2w4SUhBMWhQend3UzlJYi9QRXYwMm0r?=
 =?utf-8?B?WHpWL3FUdk91b0pENUlGUDVPT09wVGtDZlB3eU8wTncwaHlyYkY1c2orVjZy?=
 =?utf-8?B?SXdhUXVMYnNoTktqNWI4aVVqMVdzVVlOZVpMYk5LZFdROVNqQ0xndFhwcmFs?=
 =?utf-8?B?NEF0WHBHYm80VmlFQUdUZnZmTmJ0WTRKTVBtQTFFV05xZ3VsZTZURytPZm14?=
 =?utf-8?B?cFNEOTZNY1hhZ0lNTnBQd1JON3E2cTNZSjN1WUgvT3lnaHpUNU1OdmorQzVn?=
 =?utf-8?B?WVIwTEhsYy9GeGREeHRYVE9ockd0N3Z1ZmcybHFYVWZaNzdNWWp1V2xXRUJt?=
 =?utf-8?B?RStBZ2RNeXhxd1Nnc3NFWm5oTWFJbDdOV3pyUVFzdTlDK3QrRjkxNFlhR2x3?=
 =?utf-8?B?Q3lWUlMzV2NzUUU5ZVZKOUdlWGVlWkt6d0FFbURjT3RMSmV4dmY4Y2dPa1lQ?=
 =?utf-8?Q?ekN3rmjyQ44OnutDwB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec170d37-1bcf-4f0f-46e4-08decb682494
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:28:48.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBsNqhPKZL57hkoLfVWBteQjAJON0sMnCiDEUGVOPjuACz5bl7vD5g7utFdgcqoK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22273-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lirongqing@baidu.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2D0A68C2F2

On 15/06/2026 17:04, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> mlx5_query_mtppse() reads the Event Trigger Pin (MTPPSE) register but
> reads the returned arm and mode values from the input buffer 'in'
> instead of the output buffer 'out', so it always returns the values
> that were written rather than the actual hardware state, making the
> query useless.
> 
> The function has no in-tree callers. Remove it rather than fix it.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Gal Pressman <gal@nvidia.com>

