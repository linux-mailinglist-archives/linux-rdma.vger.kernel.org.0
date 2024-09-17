Return-Path: <linux-rdma+bounces-4977-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D798C97ABCA
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2024 09:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A7BB23D7E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2024 07:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C03138490;
	Tue, 17 Sep 2024 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KSZLFJZT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51EB4C66;
	Tue, 17 Sep 2024 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726556690; cv=fail; b=W6X60a5/xLW6tdvGWMGb/jRBmdpQ4e6iJg/AftQbOaHzGh2hhAuAcMTdha5IwOI0wnutDt78RFRCRV9y5VT3cy8GOufp2Shp+6xF+iN+G1aDvqWzVW2gweZSbkig4GQlSWXBbco7P9m0VDIj3NG9b/uukiKoDDl9mOxrZ3DX3X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726556690; c=relaxed/simple;
	bh=iMVu9F+8+01JpEKSbp+0NLdYkvfsIiRtOYhrRA2IU08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h9uUvniuEoWK798GBSWA2qtYuD2J9U8WRDkV+hXaQTvGq/oYv7jeHeY1OhVu4hzON81lBR6PPmajCst7yBxTOJ1NBNH9evwPm87UeZDz5DbULieAYCHoWs//bUafE3xqXBvN3abZtIETAoEe98Qa4plcjq5XbI0KW/82f82yUHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KSZLFJZT; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzVCPCIVtWCdng+N6h/7n8DNAWJjd36qJlQ1XOatwYQi8yixEFqtDRhHCiTzUi4ewKlNAb+X3hsVquJR2zkk5ZTWgHACrRyRotV8iAtSFOOGo1n7qGW+xN4LANASR3HAKT+E6gHBanoq/OjWmxDy5wENayUPGGRLLRTk1O4QhMgYai9TjnKkt98RjAYxwhd3vwsA2tKfk/ObexyFtECQsdCfLwPJMpOiQNE1Hvsg8mO6lHYa86007TEmRcBVkblief30l9q6uagZOw5+QJ2XabC+8jis6uj9VoD/H6IVxqJq1losQlcar/NHmTQhnkC227ilK5belN1XP2yzcDsewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN4vX00QFkSasDedje7zJSjEid9fcjhx0GTR24pniS0=;
 b=tWapMmuVRB7MUBWwu6jy+uGMVgDAyhP8Gvpd9kIGIBHVpdhhJmYLdoNxr/cmRffnnnIG3I6jJ0u1TrZl456UI9nYEBs6ylb/1E6E08tAgPaAECND9IOdD8OUfpPa2ejeQEEWBVSSLZgj4jjfri+q/Naqiz5xhhfxHW6V8HAkHX/wJTaUna05ebU5rdDZDEgYIJcotEg3SrsqJrYBh/69xJDjnrwqPGd8An+P3OVKjXuinhiX7AVe1RBFmryDBhI+giF395o+TizGlj8cwOhn1kX/UX3v3NZtg9/5cKfGVqX0VhlYaWLV2jUplr5q6KZQlQlXeujwyXe8X4Q7LZz8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN4vX00QFkSasDedje7zJSjEid9fcjhx0GTR24pniS0=;
 b=KSZLFJZTuvRl8wfWC/TiaFiEF2zmFDEKMf0DyWKmQKRSbD67ynkuE7q6CE985zbuoHKS773NS0ZsGPO2cA1jbLJuT3eVIpFRpuRq/NPS68PPzbkOKDAFSP5MyPUuUsJZaU8r8H1GCt9/WepkzX8pzz4F77bHkFHZhZVwSzRjZOXkeYuO0wxT3EScxIkw9Rzf6Ht5FkUd1z4EsmOsUQGmOTQnT/MpM5Dv0v0mFb3hGynwiua9hL1ABqVsvf6duB3IVS7vXOVQANAu0mWXEOjQ/E8wAHtTlyFMgqT2xSPrAorSjyADbjc11c+xavrm1uKnds8Pkxwf88guc1CGR8V12Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 07:04:45 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%5]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 07:04:45 +0000
Message-ID: <33b89cd3-6e13-4ce9-9e80-60353980bc36@nvidia.com>
Date: Tue, 17 Sep 2024 10:04:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] mlx4/mlx5: {mlx4,mlx5e}_en_get_module_info
 cleanup
To: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>,
 Ido Schimmel <idosch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-rdma@vger.kernel.org
References: <14a24f93-f8d6-4bc7-8b87-86489bcedb28@ans.pl>
 <12092059-4212-44c5-9b13-dc7698933f76@nvidia.com>
 <8a0c724e-d2fb-4ae6-bf5d-74bbd0a7581b@ans.pl>
 <55ffb761-170b-4a1c-8565-7e6f531d423c@nvidia.com>
 <1ad0402c-9c6a-44bc-9776-cb02c8e55a87@ans.pl>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <1ad0402c-9c6a-44bc-9776-cb02c8e55a87@ans.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0098.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::30) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd9087d-c9a1-4ce7-79f7-08dcd6e702c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTcyQ3IrTXpITmFGRUNlNitGL1VpM01vRVdXT0pnRWpwS3ZWcy9ncE12UFUw?=
 =?utf-8?B?VEtuR0M4V0xPMWxONzczRkhXTnBEalQwbzZBK3krMVlOZnZ5dTRnVFpiK1NL?=
 =?utf-8?B?Q2lGNTlYK3VWK1dWc1dORGFmM3VYQ1JucEVWZklaNHQ1alNUYzlqL01hRExU?=
 =?utf-8?B?bDVyZTF5Y3JwZFFORy9QRUg2SXEzbm5OeG0zTDlRTXFOaHN3WEQrbEhKdTJ3?=
 =?utf-8?B?V2tQQ3V6ZGxIZXVVQXZscXhOcDdkNnA3UEx0VFpjeWl0YUJKZE1hQy9oUDZI?=
 =?utf-8?B?ZkV0WUp1eHpBbjZMYUpkYWMyZjFmM0VnZDZoY3hHN0dOYWZ3WWsrMmVadjBD?=
 =?utf-8?B?OGJBU1I3c08rbjlvZlRnOU5oa2VRcU1objZNcDdKenhTdmZSWTc0MlB2Mkho?=
 =?utf-8?B?UFlBV2ltbUIwSHVKYnVqZVV4V3JCbkJNU0tPTHZMaE50UHNCY2tsaXNZZnRs?=
 =?utf-8?B?elVrTE5qMU8vZjBuUE56STRlU0ZSMFk2bWlScW1pbk1YN1VMU21rWHJQMFVI?=
 =?utf-8?B?ZGhJOGRjZEZoNHFKKzJkWGJWL3lHY0RabnpROU9JQTU0ZkQ5RDlzRHl4OGNi?=
 =?utf-8?B?SFZDclEzaXBtd002SWhyTjVQbUhCMjA3THJscG9OQ28zMkdOQnV4REF1M2NB?=
 =?utf-8?B?M05tdGRMblF3cm5Rd0wxTmFtNnJsNnZaZjJNRmJ4Q2k0T0NNdE0xRUluY3pX?=
 =?utf-8?B?R29CTUkrQzlEbG9jQ0lHWHBhNGRLQTBPaWJ2SXc1K013OGtYOW4yNVR6aURR?=
 =?utf-8?B?TVBjOEN1Z2R1R3lRa0ZyVHlzQ3VoRUNqQmw0QXFzam90R3dzbHFnUXQ0MDJp?=
 =?utf-8?B?VjYzMUJORjlDcEF3ZHJsRVFsenJabUprR096WXZYSlI0cjJoOVlrUFg1SnVC?=
 =?utf-8?B?a01ORVJndWJES2ExMUF4UlJXNC9WRC9ybWJDT2NCWGNla1FveWhYK1pQeFZr?=
 =?utf-8?B?R2pOS0Y5b01kaXdRRWJmN2dnRStEa1Y0OGJRV1FDQjNRbWtUa3Z4TlpuajlN?=
 =?utf-8?B?a1doa0k2QmtvbEJSQ3hXTEN1RHRUSlN4T1I5RFNYYSt4MlpFd3AxMVpvYnNi?=
 =?utf-8?B?NHB2Mm9JUFFRNmRWV0dyTm5FaFJyK3dBK2wxWE9qbG1LcXdGSXJ2dTBFN2Jk?=
 =?utf-8?B?NEl5V3lad0FLb0xPenN4V3VKa21uTy95UElwTS8xNTg5SXkrNGY2ekYxWjZZ?=
 =?utf-8?B?RDZnR1lad3BjWVk1WnhobTRXNUtrS1lzV2ZackVySDk2WWVlQ01hU0dFOHFJ?=
 =?utf-8?B?NHVieDJJb3J5Y05MUER0eUs0dHNUVkJpemVIcS93RitqcndDbUdXdXljQmVO?=
 =?utf-8?B?ZWRXb3FlQ2x4bEliWS9mRHRhSVhvUW1IelpkK3Q5M3FMWll3V0JFcXhtQmJj?=
 =?utf-8?B?MzVFU3hvTm1uMWFEQ1QrbEdiWks3cGE3eDd5NXV2MGpJOElYVWs3ZklDMFhO?=
 =?utf-8?B?dFlDZkdBYjF4UTNkZld3SDFlenF3emZ3ZHNNR2wrR2NlOUEwK3hEYjByOVZp?=
 =?utf-8?B?TkswaXB0YWhWRFlNcE8yaGJKWHkwR0psNjViOGNSWEtKRzBzNXZOSFRRV09t?=
 =?utf-8?B?R3NZb0w1RnpEMXZqMlVFOW1DaTMrYmZKVnBVN2YxOVlXeGVYa2ZFaktHVjRt?=
 =?utf-8?B?bjRLMU44aUVsZXBzRGxPb1gzNWw5eWxGUWg0SEU0a25Jb0x4aDl0ZEZnVDIw?=
 =?utf-8?B?SUxEQWN3TTBOaytETktIaVlVSXl6MmQ5RGVlVGFFRTZqcXlCMHdiYUE1QXpE?=
 =?utf-8?B?clh5S3g1bFpvNEFCWjlEQkJlb0hPdFVuUUlxaTBqTThSN2lIWGVWMWlxVGVQ?=
 =?utf-8?B?MEFOM3c5TkFJWlJ4U0FVMFI1SXhHZlFyTklweDRpQXA5UEppelFVbkVGelhs?=
 =?utf-8?Q?AiVQjRnKzNTMU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGoyZ3pBc2RHZ01sSkJaR1E4T1RIaHEzampmVWdrTjNzNXp1dDVtSVBldm5m?=
 =?utf-8?B?R3QwMnZtOW5IS0tKa3AxaCtmNTZKYmZQQTdqM0ZvWEdkWnNJNmxtbHpRUHpq?=
 =?utf-8?B?R3RFZm0rZTg1Vi9XaFE1dHdRVEhsTlJ6N0o5cGpWZWhSb0tFSmZDK0s0OVRW?=
 =?utf-8?B?L040RXFaRUsyUFp2c1BXQ05tRmVLc29PbVRDYU1WMitjcTVBYWtlTkVacVRy?=
 =?utf-8?B?VEhobS9vVVg0cElwNG5VTzhHQ2N4aG8zNjFtUFJsaHc2azJKdzU3c1pVNlR0?=
 =?utf-8?B?SmJtUlpGaW9XdXBsdXkwSENIcXhqS0dZRVFYWk5zZ3Y0dzN5UFZMRVRLRENN?=
 =?utf-8?B?UUkwQUpsOXM5ZDVTTC9UVGErRzV2TldJYTlsc3Y1dHFrd3Vqa3dMZTd0Mis5?=
 =?utf-8?B?QnpGNjF4ekhjM1UwUGJkY041eFZ5eldnbEFwanptZUdSaTdIU1RkME1qcUJw?=
 =?utf-8?B?dDZ5V1NZUGZiNExrblN1di9mczJzZnY0U3ZpNENuZGQyMXpuYkpHbXlNZDBy?=
 =?utf-8?B?UU5ubGZwUVhOYStqTnMvQWVRM1B2d1hBRUdSa0tQc29ZNXBPNk5VL2RXSHlv?=
 =?utf-8?B?aVd2L21tNlZQNm5tTFRsdWVSN2gvRVByNFBBYmFYM3lNUkM3Q2UvNWFFcGha?=
 =?utf-8?B?WEhtZVlvRVUvaVROOXd3WjNma3N2SHRpWGRuVHJhbmZnZFJNYnhYT3N0VEVB?=
 =?utf-8?B?bUdaTDkrTERqN3M4b3ZPUy9mOHlqZXNIVkNNb1JaOElTR08va1Iybzd4SC94?=
 =?utf-8?B?THk4K0l2NDd5VHFZNWNzKy80eDRaQ2tPN2x2Q3pJTkR6UEpTbk14STUwcTM5?=
 =?utf-8?B?eG00ZjJXaEtKdDhTR1hnZ2NoeTNhSE5lQ1hsY3IyWFlCSENrclpZaEdxN3pM?=
 =?utf-8?B?dGEzd0NwY2RhcU56dEIwRSsxdW5VNE5veTJUQm1xV0lyYUN6M1puY0d0VWMr?=
 =?utf-8?B?d2F3ZVNJVVcyL0EvcSswSUdsYS9HVkdOZFJ4TXI5YzJRYWFnTjVTdEVhelBs?=
 =?utf-8?B?ZU9EMU1xWWhsKzZFYnBpdHhuV1U3OEdlbmJsekZCMjZGODk4ZHR1Q0NFeGhS?=
 =?utf-8?B?Vi8wZDBTd1gxQS9McWxpdGc1VVNCMWJ2TVVSUWhiSlB3Zlh2VjZlVWJWL1dS?=
 =?utf-8?B?UDFCV2xoTTE4WlhxNk80bE92VHk2TDZjTnk0Z2hncjlqOFhSbDZQR2Z5RTFC?=
 =?utf-8?B?TGlYZDlhV0tkMnBjL1ZWa0g5cm10aGZGT0NXeHNJei9mejdoVEFGZFFlb2Y4?=
 =?utf-8?B?anJBMEcxUXJ5RU1Ba3pRT2FudjRZbWkzUXo4ZHBnM3JiREd2L000d2RkdlEy?=
 =?utf-8?B?SFZTNUMyTktxTVJ0VEZtRXZhWnJwY242T2ZpZzhJYWxSZEVrRjRFWEVKd1pJ?=
 =?utf-8?B?VUZ6aHhURW8va2dYVkQwbXAzdDdVUWF5dnNVVFhjZ1lrTVAyaVJwSzdJUis0?=
 =?utf-8?B?aU9nNGhyaTR2YysyUWtzcVB5TDJka09YL1JlYVV1NG5EMGZIdVNCRi9FMmV5?=
 =?utf-8?B?b3dsVmFnWHVGbXRhV0d4Z1JzTWRyYXcvSEU3d3B1MGhnc0NTWHNXTGNJUkwv?=
 =?utf-8?B?NHNuVXdhTVJFM1JjVlNmN0p3ZktSNVg0TmFqVkZnQ3M2SGlwL29ha25BaEdB?=
 =?utf-8?B?YnV3bE9ia1RLQllma3k0K1BCYlJGekFzR0JXYU9MZ3hiRFZBVjZtd09pbzZT?=
 =?utf-8?B?Z1R6OWUyV0kxWkhGd1ZQOEw1M1lvSXFpUFpuTS9ZSkZ6dDFXaTNNcEltM2RE?=
 =?utf-8?B?RmZEY21kRW0xYU85Sk1GSFJHL3E2SzRncE5oRXdNS2RVQU5kQVowcDVCSUNq?=
 =?utf-8?B?MDhQU3VwUFJNT3RWbzZyenFhRjhqMUhsYTZYVjhjeXVzT0NYQzdCbFZBbDhr?=
 =?utf-8?B?a3dLZ3dlaGtjckJKcHZaM0k0dEhLM25hWkNrcDFnby94ODQxcE1lamlKQ0tE?=
 =?utf-8?B?dmROUWR3S1M3MUNRTDdQNldVTlBJeTFFU2hUbllUSmdFN09rVlhEYVVxdkRw?=
 =?utf-8?B?aVJtN1owbzc3WFlMS0ZoTGFKNnBOTzJiQXVFZm5TWXRObTh5MW11Ym5Ha2hI?=
 =?utf-8?B?ZmFBdVd2a2d3TTg1N1JpQTNIa3RVazNpN3Q4N0IrRWtLNmJ2M2V3R0QxSmpD?=
 =?utf-8?Q?YwtLVmbuIBJxqilDiwTzib0BH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd9087d-c9a1-4ce7-79f7-08dcd6e702c8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 07:04:45.5352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 430nQNZYMLnt5pmBSIFF8tUKdO2xaHqXQHonBlQ1M83SvbX6DIDkYI41gyMfrr9L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008

On 17/09/2024 7:19, Krzysztof Olędzki wrote:
> On 16.09.2024 at 01:44, Gal Pressman wrote:
>> On 16/09/2024 10:30, Krzysztof Olędzki wrote:
>>> On 16.09.2024 at 00:16, Gal Pressman wrote:
>>>> Hi Krzysztof,
>>>
>>> Hi Gal,
>>>
>>> Thank you so much for your prompt review!
>>>
>>>> On 12/09/2024 9:38, Krzysztof Olędzki wrote:
>>>>> Use SFF8024 constants defined in linux/sfp.h instead of private ones.
>>>>>
>>>>> Make mlx4_en_get_module_info() and mlx5e_get_module_info() to look
>>>>> as close as possible to each other.
>>
>> mlx4 and mlx5 don't necessarily have to be similar to each other.
> 
> Agreed, however it was not a random goal. My motivation was that since
> the functions are doing exactly the same thing, it would be beneficial
> for them to look the same, so if more changes are needed in the future,
> it should be easier to make them.
> 
> Here is BTW the diff between them after all the changes:
> 
> -static int mlx4_en_get_module_info(struct net_device *dev,
> -                                  struct ethtool_modinfo *modinfo)
> +static int mlx5e_get_module_info(struct net_device *netdev,
> +                                struct ethtool_modinfo *modinfo)
>  {
> -       struct mlx4_en_priv *priv = netdev_priv(dev);
> -       struct mlx4_en_dev *mdev = priv->mdev;
> +       struct mlx5e_priv *priv = netdev_priv(netdev);
> +       struct mlx5_core_dev *dev = priv->mdev;
>         int ret;
> -       u8 data[4];
> +       u8 data[4] = {0};
> 
>         /* Read first 2 bytes to get Module & REV ID */
> -       ret = mlx4_get_module_info(mdev->dev, priv->port,
> -                                  0 /*offset*/, 2 /*size*/, data);
> +       ret = mlx5_query_module_eeprom(dev,
> +                                      0 /*offset*/, 2 /*size*/, data);
>         if (ret < 2)
>                 return -EIO;
> 
> @@ -2057,7 +1932,7 @@
>                 modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
>                 break;
>         default:
> -               netdev_err(dev, "%s: cable type not recognized: 0x%x\n",
> +               netdev_err(priv->netdev, "%s: cable type not recognized: 0x%x\n",
>                            __func__, data[0]);
>                 return -EINVAL;
>         }
> @@ -2065,113 +1940,715 @@
>         return 0;
>  }
> 
> 

The amount of diff lines is not a very interesting metric, I would drop
the changes that try to make both drivers look the same.

>>
>>>>> Simplify the logic for selecting SFF_8436 vs SFF_8636.
>>
>> This commit message reflects my main issue with this patch, patches
>> should be concise, this patch tries to achieve (at least) three
>> different things in one.
> 
> Fair. So, what we really have here:
>  1. Use SFF8024 constants defined in linux/sfp.h instead of private ones.
>  2. Simplify the logic for selecting SFF_8436 vs SFF_8636
>  3. Improving coding style
>  4. Adding extra logging in mlx4_en_get_module_info(), which is also what mlx5e_get_module_info() does.
>  5. Make mlx4_en_get_module_info() and mlx5e_get_module_info() to look as close as possible to each other.

I would do 1+2 for both drivers, 3+4 for both drivers, and drop 5.

Thanks

