Return-Path: <linux-rdma+bounces-10342-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82239AB64A5
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 09:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1820717AC91
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E56620C465;
	Wed, 14 May 2025 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HJWOeX8z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E28201000;
	Wed, 14 May 2025 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208345; cv=fail; b=EN79nZx9yLZxUZUXu/CavsYM/uVtb+GhMIHyaOkauD93MipDtuXEXINwVpcKyRpGBvyRjhgg7k13LIZ5cuhdbzzveeaeD/ygDyl/VCI+Q/b3pigvCZB1krsjybPcUm4fjqKBhoQu+rItn4c8RKwXfvy8s33/GNfVHYgEXbbcAUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208345; c=relaxed/simple;
	bh=oU5lg2Dejsy8T1D/rLoxxYCGFlvGX+/C4v4//Z7ZsZg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BqP6WDlwrbTyBytnfLhFekfklJ4Z1U8ap7gZIwkq910Sy+b9Fa6CtjvjMXSTtrbglg9fC5mJsj40UIcX13y5Z/HPfaYfjQKceRT54jsbaLBqIVSN8u0deXhRjUjMpprXc71iomlwWbkdT7r9vPDjYp5SLA45CvqcE77UJVYyDCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HJWOeX8z; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgdWfjdcWZXFVK3GuUJ4lAykaTTxW4Bfi3YfmugE9PUVjALPa+AgbtDoQyEjU3ks1o/XkxLuXQHB2uVu4KwELrfmIINBhgbInfd7ExZO9RzjgSynOd6G+DMaHgvWAdt9IWPWPIjFH6X+nOokBlhT3Eu3jc1c3fZI+tk+top1XqMYbeYZ06Nm9ZIZ26lJzHUE70FimBaAB1wZJEPmgCg1vcDkdNHLW1hbxtm+vrKBR9b//1DAmSZg1rhtZuqJlUSJ/rFKdc78T2vIuXVoFs1Wgj+eaolpyKkucU0/XrbO2NuVuj8Rx9LYG0gfOK/9DxBMFV5PgRPjC+GMO6fyGFiGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6P9W5QTH1yIi5Tju3Dt+Z2BlhH1XLD2rDiRAjm9XuU=;
 b=rp3tPnO1Vz8xXQ/X/VPByjPE5/D56TgTUrMUaK4/IHHvf+kahWkGix3FbvnI20n2U11dyQBcpBloDKvv7tFh2TQ7NDSZyIj1Ag9hqI6/8aasYc75YnyCpQZ2eYRbzR+dqaCIAiGzuRI3BrJdUdCgesLabHNrwBCNo6YndWYym2seZLDUJ7f3vZNE8db66ddGFZp/GRGRyrXXSRJUSoeZjPU+q9guyx5yyXXS7H4GKTAY1L8bwY71QAqmuSm0fZh8E1Ugclt3KgWhNTgsA0dVt+jgG6aa7noHpqwJsLllHC2fQ5fFAE4nghghTgqkY9LZIuHa7ZBDnm0Ou+YFRp+3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6P9W5QTH1yIi5Tju3Dt+Z2BlhH1XLD2rDiRAjm9XuU=;
 b=HJWOeX8zi9HXiS6SL7qtMvGKEErVf7AS/KCccdI7+xezFCxZkp+lZ4YPgNFgk9tXO1n5R7Sn21Z/2p9W1Z9LOQLs4W8AJfaeEWPPfTIb1+97BauqvdYSGLvA7igJ+Ll9OBJo/l8HYKjEm0lGD25DCDxtgiLQHphhInHKfc2NcVwlT+pioQbm/AbsIe0XQHwOvXmzy78+nbjiZdR+GFZ0pyJWSEE6/0kBOst/MipalsGhgP+gBqictB7YEkrYAXRJLkcUlKO9wk9SILXVfIN97fBu0+AK6SfdbxF5mBGHO4n5hBQFad9sCNsfmyKjbiJ73HzBogwg8qtSdqoMDo8Cbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 07:39:01 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:39:00 +0000
Message-ID: <f4d5d337-6a08-4ca6-8fab-4b640e732c9f@nvidia.com>
Date: Wed, 14 May 2025 10:38:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V9 1/5] devlink: Extend devlink rate API with
 traffic classes bandwidth management
To: Tariq Toukan <ttoukan.linux@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Dragos Tatulea <dtatulea@nvidia.com>
References: <1746769389-463484-1-git-send-email-tariqt@nvidia.com>
 <1746769389-463484-2-git-send-email-tariqt@nvidia.com>
 <20250509081625.5d4589a5@kernel.org>
 <98386cab-11c0-4f74-9925-8230af2e65c8@gmail.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <98386cab-11c0-4f74-9925-8230af2e65c8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 60830659-091c-49e1-ea44-08dd92ba6484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1o3KzFIWWZ4WjRxZDRaSE9mWDkwNjFVNzF1U0tOcmEvU2ZZc2pva3lFeEpr?=
 =?utf-8?B?VDBIa0lVYklCcnpGSU10U3pKVGw0dFo1cGZHWVQ2VkRnMWtTUlIxYUxTT1lZ?=
 =?utf-8?B?RzMxVkxBa3MrMTBoTDNUYkF0c0hZUE1XdTdrQk5aYng4L1dwVDJ5OGw1S3VV?=
 =?utf-8?B?Mm9GSllSSm5tN1VEcWpLbFdscGJDLzBoK29YR05ZdHUyUHdiMUFoODROdDZm?=
 =?utf-8?B?cWh2RUtlbXZDNHQxemlTeGZiTjNMZFpYK1BZWXBUalB1QkN6ME11VkszZ1ZW?=
 =?utf-8?B?RGFNVzF5VElzcFBaRlJNOWpxK3dhTkpUbnhHOVZyOWJOWC8zdFpOVzA1SUx4?=
 =?utf-8?B?WEc1a0JFdUdwb2JVTlZxUHlsQVoyZ1gySU1oczdxeks3ZU5hUy9IclZXRCtM?=
 =?utf-8?B?T0huaUNibFlqNnhjeGVHMy84Vk9CYk5KSnhUNDBiV1EzVUhRTDRtUHVTWGpa?=
 =?utf-8?B?R3VTM2xvSElNbkpkK3YwT3Q1NFh4ckdscng3akZTcEE1aWdmUzhMWDRXa1Jl?=
 =?utf-8?B?WU9UUXI1NzVmZ1lpVUtiQ3JkZmFkWUNTWWcrWE9OZ09nays5dVpQZ1UzdFRZ?=
 =?utf-8?B?bkdiN01hNlJMWTBDMkNWVDBkcjNVVmZpZFZ4Y3h1YkFOQ1hBZkZuTjlUT2R2?=
 =?utf-8?B?UG96WFoySldoMnZtdjMxV3Q2b1JuQzNUYnhKckpBKzhQVVpLR1JHMW5jcDFE?=
 =?utf-8?B?dlFRemFPekJtaEsveG5mUjNNMlJ1cmRyL3d3RitNNnIxeWs1OTloVXdrbXJj?=
 =?utf-8?B?a01vVzFhVkllZVdIU0dndUp6Z2dIV0VDV0p0TXpnZHBOVjBkUEh5MHFyeGJz?=
 =?utf-8?B?aGJ2cmV4VTZyOUNoTklMVkVlOFM3VjZQSGdDbC9FOGkzbHhWb3JjZkxoUGRT?=
 =?utf-8?B?OGU1RWJYSjgrUXJReE91Q3VBaUU1bFlxN1o2RzgxSVlIRnp0YWFRcHFVWk1Q?=
 =?utf-8?B?Z0hJSXlUQTY2ZTc0RDUzV1hQTGpmcE05Nm5GTnc5VlNaVTFsNmtoMER6Qlkr?=
 =?utf-8?B?czVTK0o3QTdaVy9FVm5oYThrY2dmRFRPdzFyUldPcThhN1U5RnA0TXRBbTll?=
 =?utf-8?B?TE91YXB2ZDVUNnhZZktKVWFkMmpIUFBKTlJOaWhNSWtkcjY4QlVkckI5Ymgv?=
 =?utf-8?B?TzNKRTdiUFFqSU1OTEs0bjlBYkNEdmViMnFzSXg0SDZjNG5BU0syOFdJNDRK?=
 =?utf-8?B?a0ZscXBZZDVzV2RiQ09Va2pOaE9qMmR3MTlvWFlEK1Z4cVQwbVU5emtXT2Nj?=
 =?utf-8?B?em9TWEkwdmdqQnBkU0ZUMWR6S2F3NDNRZE11SEZDOStsMlpMQ2lDS1Q3ZkFR?=
 =?utf-8?B?NzMwOC82V3FkV2NWYU5jVGNDbWtCNHJsZERJSEo4SWI5N1ZkUUMveWhndFUw?=
 =?utf-8?B?YlN0K2xvT0duWEdkWGdEd3l1U0FxVVlmaGg2SFdxeVBIa0lUNU4rcEwwQWpm?=
 =?utf-8?B?N0NxSWRJUy9QZ0xCWnRIMDhUWHk2ZDVOb2Z6VGpsMVlkKysrTGticmFMV21Z?=
 =?utf-8?B?VjUvbm00UXA5MWJ6RjBBaU9CR1hBTTNDUUdEN3VuNUVxZXpFL1RJUGZHWklu?=
 =?utf-8?B?cGJ5YkhzN28xbjZuRmVGQmdRZld4dDBTWHROTHRPQTl5aVU5ZG5BK2c5aW56?=
 =?utf-8?B?WGVkbzhRUTNIUTJHZlY1TmJRZTZDMDcwM2xTSkRSMzNSSFdCcDRDVjdBMEF0?=
 =?utf-8?B?RG0wd0EraWJZNHlhZmlVQ3ZYZytSb2NWczNCVHNTZUkyTlV4U1ZBdHAzTXlR?=
 =?utf-8?B?NlJlblI4blMxaUlNRUNHaE9vd1ZYd1VQQWl0b3BCK0o0V09Dem8wRzVZdDVR?=
 =?utf-8?B?QVVhTklIeVdtdUxjOXgxSjBEVzlYRXdaMUd1eGorakZSd1VWRGQxbmxiQmor?=
 =?utf-8?B?OElzNHZoajBBbFo1Z205bmFaZVV6U1lTdExzajdnbEtlR21LR0lpejNIcUtJ?=
 =?utf-8?Q?fO2+YePOmSc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGtIcThLSytkdVdtTnlHZ1NmMVVoVzU5cDhlQTE4V3NuMVovR1JRZ2xmOGZW?=
 =?utf-8?B?RHZRbTlhWHpJNThJcXVhMlZuaWtlMjRhak1VZmJGdTlNMVNKdmtKN1RYWXpp?=
 =?utf-8?B?U1lpUHQxOElneG9CSkZWOFo2dnlhbXZjZVA1alpFNUpGZm9HRXk1TWRCN1FY?=
 =?utf-8?B?V25kYVF5QXhHaTh2SWJIczVMZVA5emRIc2M5S3poYnNON0ZkWmZNdXZjblEr?=
 =?utf-8?B?RTE0K1pKNW9OdjM2YVBMWTFKRkRvZlR6elRtSUtmUjFyQncrZURIcDkwTXRa?=
 =?utf-8?B?RExnTHJXWE83SkJjRWVlclh1cUU4NlJqQmhEd3RldnlScnU5NHF6bDlydHoy?=
 =?utf-8?B?Y0NxcFBjWU1kcFNhVUcwNE4xUXRaY3o2dUVoSjV2SzAzYXo2dzUrNHpkSVR2?=
 =?utf-8?B?UkFnOGxIeHdMV2N1QVFDZ21YdFRMTC9BemVOdW41OWp5RUQ2NXBMQ0t3U3dZ?=
 =?utf-8?B?SXhpWXA5dk1lT3JNVDVJTXl4Q0tWZkg5T3lKQ0xKcUM2V0t4Z201ZmpTMnp2?=
 =?utf-8?B?Rk9ySjdYSFN4M1F5NGJJZ084NTdldWZBTG16RitXVHR5Q203ZmFHWjdydjlL?=
 =?utf-8?B?MDlKbmNTZ1krQklnai9meTR2Z0Q3SlFoaHpYaExnZjVsQzhNbk5XUnBYQ2N0?=
 =?utf-8?B?d1VCZkt4MnY4NkoraDRhK0dWLzZkLzV1cHRwOC9ia1FDV3ZEbE8rK2FlY0E5?=
 =?utf-8?B?ZVJtRkFvWkFXN0RrR0M2YnV2VTZSZ2pSdDhSZm9tdGxVR3RzVjVCMUVCeGR4?=
 =?utf-8?B?blVtRDdmRXR4aWlmcjMwNE5SeHhIbHZCbG56Vjl2MGxPa1dDTUNPUWIvek92?=
 =?utf-8?B?bGJwNHdlc0VjQUozdDk2dGQ3dGE3WTl0RVkvMjVrcmNBbDVzTEg5MXJpUHpY?=
 =?utf-8?B?aWFHWk1UYmFDY1grY0FLc0NNcER6NmNJelpESlYxaGRTNXhvRUR0ajVmNzg5?=
 =?utf-8?B?VEZkM21LSlVad0lBaFdBeG5zM1QwNkpCYTl0cmliejArajI1bG9UKzZXZExn?=
 =?utf-8?B?N3ZUWXlRUDE1Vmx2di9LTXUrSDJMd0svb1k2UXNMb3JaTG5tZWFpTXVXTWJ0?=
 =?utf-8?B?M0RoVU1wNCtGQlFWQjhnK0QwY2Vib0J3UEZiL3I4Lzh0UEVVeEdYS0FtN3VX?=
 =?utf-8?B?SFlDMW45NjM4YVhOSUtpNTY1eXZMSFh2ZDRha3k3SDRRUXZPN3lIWFBNSVhR?=
 =?utf-8?B?SXZndTdOdDZoWGRaSHFBR3FieG50bEovU294MGRxaVBpL0MzaUR0MytOTDVI?=
 =?utf-8?B?Tzg4ak80d2M5VlVGcW9EYnRZalFSQWduMXlCTDBoaDA0U2R1OTRxRlpEczJ2?=
 =?utf-8?B?S1lKckllNWVRNWpuZUhwVGNRd21rMTN1bWt6bmVTTndFcEVXMzhyTWV3Szlp?=
 =?utf-8?B?UlIwWDNLeFlDaUc4S2xYTVFqaWw4RTJsTi9yZUo5OGtVMzZCTkRnSUl5OUJ5?=
 =?utf-8?B?bVJCeUtLWk1DRlp6bXJyMHY2U3JtL2JISkNxQW95TkpVMG1rYjlwZ1IzRkk2?=
 =?utf-8?B?ZkhnaldITDRZdDBEbXJvdTM5WkQ4Y09SQXR2a20zdCttaE5heE9KS1M3OTIx?=
 =?utf-8?B?SVhZakN6dFU0dzYyYjdTOFJKRXVoVk5vdFQxV2ljVHg5RmVRdnlhdTVJS3lS?=
 =?utf-8?B?dGg4cEh6QVdBQ2lHQnFHRXUzVy9pQ1RLdmtxdFlOODVpWUxBNWJXVkMzOU4y?=
 =?utf-8?B?Ylk4Y1FHblBQc05lWVEyaXVVUnEwdURta3lEWDJLK3VMRFpNY3BPS3Vhdzc4?=
 =?utf-8?B?YStxYlJ4emhrYmRVTXpJWmdlclNDL2hFZnU2dEU1bDNsVWpBaGhlVnVQY2o3?=
 =?utf-8?B?TmY4OENsejJIZUw2dkx6NUdYc0tGWmtEcXNMY3BCclZMb0UrejZhRVFBbG9P?=
 =?utf-8?B?eHdRNzBPS0RPU1dDcHFXUDNSRkptM1NLZmxQZFY1VERlUW44WlNkMkhTV2hx?=
 =?utf-8?B?RHgzSlBCdklnWFlINEJLTStWeVI0RmUwemZUQmZRYXRiZzBUVVFHUGI4VnNy?=
 =?utf-8?B?ekN5a29TTVdoeUN6N3YrUENZOEJqREVOdXM1N0R3eVV4MHZOcStMNkM2eElT?=
 =?utf-8?B?c2JBNEJVK3VVVFkzRUxPYUpYQ0ZkZzN6QWhrcWN5TENrQzFCQUpKdTZVOE0w?=
 =?utf-8?Q?Vw/ErFg6rXjBdq7sfI2iDZ7hh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60830659-091c-49e1-ea44-08dd92ba6484
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 07:39:00.8158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jx7V6dIAs7490le8eVYy0J8HGTWAdieaZuUc/vfaNbIOD6KvLUcZb9Tawc5QQTQu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756

On 12/05/2025 17:27, Tariq Toukan wrote:
>> I'm going to also give you a hint that my next complaint will be that
>> there are no selftests in this series, and it extends uAPI.
> 
> I have some questions, looking for answers in an official source.
> 
> Most importantly, it is unclear to me when a selftest is required. What
> is the guideline?
> 
> Please point me to any guidance for this selftest requirement. Is it
> generic, or networking subsystem specific?
> 
> Let's make sure these things are well-defined, so we plan the extra
> effort accordingly in future features, and improve predictability.

I have also asked this question in the past, but was ignored:
https://lore.kernel.org/netdev/68e2a8cc-2371-433b-86a3-ac9dea48fb43@nvidia.com/

