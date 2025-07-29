Return-Path: <linux-rdma+bounces-12521-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E337B148C3
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 08:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796D7166668
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 06:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7644211499;
	Tue, 29 Jul 2025 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CJU+D9vD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE751F5E6;
	Tue, 29 Jul 2025 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772246; cv=fail; b=XHw0sjmESdthPXP1/t0MRcUf/6CGZics5aHoAzz8Zf8YpGboXhzDWjVs6ix6NLekbpGi8eVe5q/KZuRy1fRQ+f5DQ4nb2OhaKg4gf12coa/MjirGj8gQ6qSke0QLxowKY5AN8x8X3danlF4YgR53/Efk7KHgwMm1VWFe3qK5YkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772246; c=relaxed/simple;
	bh=XZiAxGH1igk6vnM/pQ0GD0aK2qUsFAuNH6wwZWTh7qA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e1nQ0cUnnuKWkiemweTiC8YxxUfVspmzzSmBmM6PvXutjqhK0MZQURUlqiSKcyFq3qUEpjb7GVUOqiNciwwxAP1/dSnB6+LgVyOuxQex2VFCKLP+8nTzp72wW8Dp6XlIi8lTjjzgo7tlyjFw06b5bSys5/24Kgy0hMSdcWlZ5zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CJU+D9vD; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rm+tNGyoOaqeKIbkAtEafwEUHUTGeFq6z1YtH+rUsgkg30tjFkuSLrXac6O/L+1/RDE1drtqo47VWlvl9mu3iFoYBBngzlerCZzWFFh8/QiePIgmDVFy5pBmdQ5TPWo+BhrGfMhLckgVsNNmYr/tx2tyH2E9vyLN2nFRqkr2fUZ4BooMHafLTNu031fTEEyFNLvK2lAT0X21qTILl73s7KaxVDatY0Q0guC22DIiLlciay6icQbgI1haSYOOorVHTpp1/VOfN+6Crhkob9fMRjoj7jCZdshHtvVc+QxNceFe24Txfski+k6ip73UWxtdgJVE8KO5MRH8XHoM8SbvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8+FvkYmkOrmtpoLMobuJdrNl4gKzWw8UFS8ueRY1nI=;
 b=GJgY3oW78Nf6PDiAVAg460Dqaf54KnBJqfbPg8FFfHFMB3Zwjq6xx2hHw5u504JJdYr4TDKkOHbKshpBGs/vHqm9E3V9F42WkfjhfK7LWhM17KQp0jQP8BpO5HvY1f931amUgrUjEk4AkKC0aQh4DVJn+ygYd3ysEy9CIewFTMkluzDHBZ/wkmuWpBfoMrNEt0W4eNgK6EpGJZUks9DNw68+DXBrue38DRNrSD605Uu/RCNTC3GG/qbI4tanDzj9IqQYjB09yimppNT1W4mdI8egxOeYfoeTCV4j0FiBb0vuFI7BgoBlsqRgznPUorwgrQTvD+SKhjCgUOo7rJmnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8+FvkYmkOrmtpoLMobuJdrNl4gKzWw8UFS8ueRY1nI=;
 b=CJU+D9vDO93m+uPrKJPqsI0mXrOfNEK/wNYm8ZCkEprmOWCiszBSqCy9uHhpDpuopqvDgc+lUwrQXFerv+4W7nEDsOYxfK7oYEVwQEA0o1Hn6MQkkuEDnvsTjFz743vSyEOg2dMO5iYX8AlUbjpWdyrzGFRbXCcEHaA8IBLUV3r4m88loS2Quf7nzXp2d1FZ91+YQzqBcrPxYa//+HG0LkR6cN8cavkiqgxORqzpguzZ4WI9ZkYC42wPA7nMjO57OA1beaje8mGtdZGJDcuLVT7ScuVIc6SvRCK4MPkCIHIKmvgJpdM9XfCUK5IddRSnkoIXrKSND99cclp5732VXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 06:57:22 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 06:57:21 +0000
Message-ID: <0c1cea33-6676-4590-8c7c-9fe1a3d88f0b@nvidia.com>
Date: Tue, 29 Jul 2025 09:57:13 +0300
User-Agent: Mozilla Thunderbird
From: Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 0/3] Support exposing raw cycle counters in PTP
 and mlx5
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
 <20250721170916.490ce57e@kernel.org>
Content-Language: en-US
In-Reply-To: <20250721170916.490ce57e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: a71d493d-b3e2-48e6-4250-08ddce6d2a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXYzWHVxaENQT1Z1dFIrWXVpMlZaUkpxMm4yN3BjVWZ3Umk4N1ROVFd2UnI2?=
 =?utf-8?B?ditESUtsRXUwUGU0eFUzSHF5Q2ljVENKYmtxS0t0RjQvN2JIZmd0U2pwOWVs?=
 =?utf-8?B?eXBYNE9reXJoSmhHVFJUMmV2WDc2YVhLRk1oR2k4TkNKVjVKbFdjeCtadzBp?=
 =?utf-8?B?aitRd0dUOFdkTHFOTW0xSFV3NFdtTTRONC81U0hMb1JiNkJOaHRjVU5DTklO?=
 =?utf-8?B?L2dMRVVrcFVmYU84QVF6SzUzNTFZYWhsWUJLWENyRUQ2SFNseU1QcHF6RWNm?=
 =?utf-8?B?ZFZJc0FQVDFuUnhGQjB0ODNwb0FES3pTdWVFNjNRQ0E5RlhLbUNua2hvbEtz?=
 =?utf-8?B?RmdKZzdzTmpXcU1tWThXOW5uN3pwcE5EcTJqREJvVkw0Q3Q5d1BLR0lZZDkz?=
 =?utf-8?B?MW92ZDJLRForVWVCRG1OeGNBQ1lQYTNDeHhIU24rcjY5L1daaVdMdXhGVWhR?=
 =?utf-8?B?OHlmd0s3N1ZEdkJXdGpwRytvUzg5Z1dyOGF3M0VyR2lHRmhKRmhMNlBPdEdG?=
 =?utf-8?B?akNGdFR5dTVuS1dyN1BETVlUQlVhQ0V2MVprd3VjZ1N6TlNySnhTNzIrK0Rm?=
 =?utf-8?B?eUl1L2J1ZUQ3cHFueWErb1htS0U0VnRacVVJeEw4amdpMnJ2enl0c1N2ZEhT?=
 =?utf-8?B?K3Rxd2JQS29DNjM1eHdNd0hEdEhhcC95YXNCaVpFaEVGMnlsV01Ydk1DeGs1?=
 =?utf-8?B?QWJ6NzhOTFd0QzBqM2ZTTmVEem1aNmpOYURBN0RzQ3VHZ3duT3JRaFRFaXdP?=
 =?utf-8?B?NHRwSzhjbU12NTRtdXZyMFg5SDZpT3dwUVlVaWp0Um55L25zQWViV0ZQNW1E?=
 =?utf-8?B?ZWxoL2ttT0hGNU5WOE96SWVEUFhrNi81T01YN3YyL2tmcGpmSm1vcEFNWVYv?=
 =?utf-8?B?Qjlmc3p6QlRDeDJTdUdwdDZGVEJuMGswVW8rcTYxTThIbkFCbGNjelBjemtS?=
 =?utf-8?B?UkVkeFhOVENqVWhMR01uVGNsdVU3YnRwdkd5Y2lkSjBCbFl0N0RCQ3UrQTJY?=
 =?utf-8?B?dDh1WnM4ckROWEN4QURLbDF6MFdtRzdJT2FsM253Rk9PeS9mWTY2elcvTmV5?=
 =?utf-8?B?UTF3ME9BSEhmRmtOVmoyY2lFUTlyYjBIQTVHWUxGQ0VkdGNDVGZ1L2lnRDBL?=
 =?utf-8?B?QWpyY2lwd2xXa2xMYzdBQ0Evbnk3M2lnMjlFdGxPNktRcTQ1SXZteVVRYVJv?=
 =?utf-8?B?REJrQmE2OGFXam5RSnpGYitvTW5FSTNxWHQzdmEwU2FVNHdRMzc0L3lMUWU1?=
 =?utf-8?B?YkxDNGVoNzAwZVV2TzBNK1RHZVBrczdGMzZBSW4reXlJZzh3YnkwN0JSc3Z4?=
 =?utf-8?B?NmlMclJ5eVFib1Y4bUh5WWdWZVFNM21RcXBuT0dERFN5eXRWa3NaM0hGRFcw?=
 =?utf-8?B?Y0JWbmc2cC9EcnpGTHZqVzFKY3psV2RwbVFEUU0zd0I5MVJpNzVOeS9Qc09Z?=
 =?utf-8?B?VmdRRVIzUU93N1hpTTFFUHk4aDl2b3lrQVJZVFZyZ05HNXVVSEVjUzhSK21l?=
 =?utf-8?B?M3EzUzRWWUVGT1BUYU1teXJlQVNrRnpUZjdYNkU2d2V2YzloZEdlV1djQXVR?=
 =?utf-8?B?RE9ybWM1WlZmRkE1OHl4eVdyT1JRaGtWWXFpbWZ5OGpNWDBSRTNkbGhJcjhT?=
 =?utf-8?B?RWN6enhKVTQ5WnYzSVAzbVc3TTVoNGU3NDRWZkloUmdkcDhUMUpJaE5CRUJ6?=
 =?utf-8?B?RXQvdVZOZFdiM3lvZXM1R1Nib0F0d3pGcW04NHFPakFSQmM2TUIvVENvejRv?=
 =?utf-8?B?c0J4WlhBYzNpS0kxUHNvYW9uSlA5K1JISmRodGNnZHBSdDlJdUNnVUErMVFW?=
 =?utf-8?B?dXpYeElWSjdrdjVKNzRaTzNKNFVOMUNBVjRWYlI2aWJWTkEzaG9DdlFnTjdV?=
 =?utf-8?B?b2RqOWNDWmdOMHJVMkJvQy9FM1JaTGRRNkJBWEIzUTZvQmFXSCs2OVByS0RX?=
 =?utf-8?Q?kxpJ6AdY94w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elNvdGdIYWIvejR0RkJsVEFFazNna2VJL3dHakhCMm1FUXdsMFlrcWhmUDc0?=
 =?utf-8?B?VnNIcGs0U0c2aktQbkEwZ3U0OWMyLzBadDFETFdVTDZUREJQT2x3M0Q1S0ZN?=
 =?utf-8?B?ci85eld6TzlveFFrRGtJblFYU1l3czQwSzdsbElrV0pXNXYwcy8rNHlLR3VY?=
 =?utf-8?B?Uk1EY3FQZnNNQlVhbmVLV21ML3A3VnBTY2k0Qy84V0FCNTRrTDdyOEErajFK?=
 =?utf-8?B?bUJ0YTZMUkI2MGJyWXZaR01nVG1jU2JDM016MVg1Z3JURy93emEvNGxYaTRD?=
 =?utf-8?B?dXkwc2E2SjUvSm5nMjhaSFJTSjlveHBZOHE3YlJCR3pLZzg2cWUyL1NqN2RV?=
 =?utf-8?B?ODlFeGpYMElLcmJ1S3ZQRXZ2eEFuOU83WWZEczZXOTdZbzd0WXFCUTJwbUk5?=
 =?utf-8?B?REIwaGthOXh2dlp2eWdGcVpLSll5R0x0bGJHL1pQL0o3VDNCc05HWkU0eGRv?=
 =?utf-8?B?Nm5ObTFYcnhzWStyT3NRcDJyRDkvTWdSeHFRYjYwVGkwSmoxUURqYTBSMWtC?=
 =?utf-8?B?cFFOU0E3TEhtQy82bjVuNU45VnpJUG8xMlduK1o2WER2SVplczkyMEpLZnVW?=
 =?utf-8?B?RE11ZUtvU0VDVm5kdC9GT1JhT05NSGV0S1BqbEtTT0JPN1VReTZuOVo5SUt0?=
 =?utf-8?B?R3pvODVwNkdWeTRGd2RWYktyMHVxQmRvU3BmZVo0OFVoWVlwSVVLZ3ZQU1Vz?=
 =?utf-8?B?R2pvVHFRNnBETXJhVzZCcEQvdnI4SFlCUHBWeUlDeWhZQ0tjODJlWmhDaXFB?=
 =?utf-8?B?QncrUTU0blJRWk1LODlzdzE2ank4N05QOGdMWnZtL2JzSkc2elh0cmQyOFd5?=
 =?utf-8?B?NkU0aDJOUmFIRndSNG8vczRoNlUxSFAvUEVQMnFONDkwMTVTTHZjc3AwQzF1?=
 =?utf-8?B?cXdQZm9aS1AvdzNaNE9vQVlvM0N0RUQ0ejcwL1ZVZmVoM3FZZStJWWhOeEN0?=
 =?utf-8?B?M0F2U2ozd2lYcXRCbm1tN1VvbWlidWFjMzVwM3pSUHFXUDB5ZU4rYWhwVTVS?=
 =?utf-8?B?NWNUZmxrUFBmQWVVcTNhTjV4UU5CNG42aDh3cFVtQ1dTMW92L0JmNTNrczdF?=
 =?utf-8?B?VHFkM0Z5OFpDVTlpc29jdENIRldJNU1WVjRySG1LSjh1eVVIdlRoL1phTWI3?=
 =?utf-8?B?ZGNDb2NocDAvUlNoVXhBdjFtelZCb0gyd0FpVVcwdXhEam1nbktQZVpRSmpC?=
 =?utf-8?B?b1FOSG9BTUZqOFNFMkVPa0FGMnFDV3ZsczYydHNadVdaaGU4Y3Rzd3huRlda?=
 =?utf-8?B?ZTNpejVxK29HZUQzMmZsaEtkamdvRzBOc1NCUmRKVHMyeENYZ2EybGdPVkd5?=
 =?utf-8?B?V0dPMERxQ000ZWRZZS83djIxemc5WTZSTENBOElKQ3BzYkZDeDM5WUUwODdB?=
 =?utf-8?B?QTVlTnlTRGp6KzE2NkEwdWZxTVNkb245eE83MjdjQ2h1amJrYy9NOUlvV2pJ?=
 =?utf-8?B?LzJIc1k3MzAvZnh4bktCMVBnWEthMHVPKzhxMXBNUnRaRlJ1aW1UcEJxMEI0?=
 =?utf-8?B?UEUvOWQvbEZobG8rUG5Tb2c0NzFKSkNjOVRLb2w5M2VlcWp1d0pkOXpuOCtr?=
 =?utf-8?B?YklRS05tVlBEYklrcWdSSzNVWU0wQm5GYnBKZ2NvRnJvZVg5THBpLy9RaFFF?=
 =?utf-8?B?S2hFOXJ2YkkrRUx3YzRMMGoyUk5QeXQ2S1JLb1c1Y1QvdGkwbElscFhyVHlR?=
 =?utf-8?B?VGhTaU1IY0hZZ1o1WTVwQ3FvNFpTc0JWdWsrejBhK1U2aFk4YVd3QzRYMm15?=
 =?utf-8?B?SWdJb2l1MmJoWFo1anRmM3lZVU1VL2plVUlERXc3anBvZ3czNjVVSVIvaEVQ?=
 =?utf-8?B?YTVXamM1SC9yeEJNa0p1Yml5RGJENnFtQXcvVjJOZmM4clFJS3VyNkp2QVBq?=
 =?utf-8?B?TlJraTkrdWpxY3F4aS9kQmQwQU8yd0VvK1NoVzVEYTVvM0lacGFXMVl3RU16?=
 =?utf-8?B?RXorY2NLdUx5Y1BrTFcyZXZ6bkNBcHpQeUkwZUdhRTRCUHQrMnhIT3NhY1VD?=
 =?utf-8?B?MTJ2MGpYbFFNY0RmSVVQWkFMZndsQWlDWU5tc1dHN09KSFR6dlcvSHQ5alAw?=
 =?utf-8?B?OVVxeUFjQUd6WTcyb0hQbDU3RGlkbjhFTlBETHlvaElMbTEzSmxCR2MrSmFk?=
 =?utf-8?Q?uEgXp4ydRspPpLzmnro/zBB2S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71d493d-b3e2-48e6-4250-08ddce6d2a0a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 06:57:21.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XMsdtw2TBXud4lE4JQnpQSUJKw9W/fcAURGYYynmt5LKJQKwK16/OUfiSAEj0PvT7+l1SobaLJwhJV1l4d+ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912



On 22/07/2025 3:09, Jakub Kicinski wrote:
> On Tue, 15 Jul 2025 08:15:30 +0300 Tariq Toukan wrote:
>> This patch series introduces support for exposing the raw free-running
>> cycle counter of PTP hardware clocks.
> 
> Could you say more about use cases? I realized when massaging the cover
> letter to apply the series that all the use cases are vague and
> hypothetical.
> 
>> Some telemetry and low-level logging use cycle counter timestamps
>> rather than nanoseconds.
> 
> What is that "some telemetry"?
> 
>> Currently, there is no generic interface to
>> correlate these raw values with system time.
>>
>> To address this, the series introduces two new ioctl commands that
>> allow userspace to query the device's raw cycle counter together with
>> host time:
>>
>>   - PTP_SYS_OFFSET_PRECISE_CYCLES
>>
>>   - PTP_SYS_OFFSET_EXTENDED_CYCLES
>>
>> These commands work like their existing counterparts but return the
>> device timestamp in cycle units instead of real-time nanoseconds.
>>
>> This can also be useful in the XDP fast path: if a driver inserts the
>> raw cycle value into metadata instead of a real-time timestamp, it can
>> avoid the overhead of converting cycles to time in the kernel. Then
>> userspace can resolve the cycle-to-time mapping using this ioctl when
>> needed.
> 
> There is no API to achieve that today, right? The XDP access helpers
> are supposed to return converted time. Are you planning to add new
> callbacks?
>  > If there are solid networking use cases for this I'd prefer we fully
> iron them out before merging this uAPI. If there are RDMA use cases
> please spell them out in more detail.

Hi Jakub

Thanks for the feedback.

One concrete use case is monitoring the frequency stability of the 
device clock in FreeRunning mode. User space can periodically sample the 
(cycle, time) pairs returned by the new ioctl to estimate the clock’s 
frequency and detect anomalies, for example, drift caused by temperature 
changes. This is especially useful in holdover scenarios.

Another practical case is with DPDK. When the hardware is in FreeRunning 
mode, the CQE contains raw cycle counter values. DPDK returns these 
values directly to user space without converting them. The new ioctl 
provides a generic and consistent way to translate those raw values to 
host time.

As for XDP, you’re right that it doesn’t expose raw cycles today. The 
point here is more future-looking: if drivers ever choose to emit raw 
cycles into metadata for performance, this API gives user space a clean 
way to interpret those timestamps.

Carolina


