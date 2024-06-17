Return-Path: <linux-rdma+bounces-3189-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6522990A345
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 07:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5188E1C2112E
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 05:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1056117C21C;
	Mon, 17 Jun 2024 05:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BpBYW5wO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58F2CAB;
	Mon, 17 Jun 2024 05:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718601371; cv=fail; b=MlJDhZR+1WsC/D8lIujtK28Yq9cSMPrnbKWdgrh+DGkg/NhlrtLS6iaWab/MT+FqJH8DCUlN4MNgS/plt2xIvktDFMQzHOHObG+zDj2hD/MgL9RTmtOliyPyghUvbE2seM336Ks43EE/+cT5FnLoxfl26X2YWUG2X/MVxvgdNb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718601371; c=relaxed/simple;
	bh=TzDOl5mdTdVSCaUu3OBnCq+r1EVs2X7rIVATkKRwZLA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VmY+hfQMq+/tirPfjkVp97iJFetPr5nNR2YrOA8ccwAQAEYzVUP1oeXYbM4kF56uoEeruZ1DVr7bVu2+sncaSAW72D7UYIf2t2VDLxZMBjnmTLMzO18mH5SQSNqfqtReh1bw24uHdluIBlvnFs6dFtLmghZOg9NyY7b0NbMgkso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BpBYW5wO; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acf8DMtTBG7/Y7Tsyi1lKckjOStaUxx/GQDrPDbm7U7udUwXHtdR56D8GYi3IkB56r5FYZDygin32hnnmB2bK27rZT1c3/YgWRooVPT6SLe7hlg8DPmoy9Gw/uFxIkBZFXgjWwEUUhB4X21iOH8xHwGZBjCkM3jN+WT3eSyKI4TnnuAQXSZvJ5iF4gTs24czJKfXEtGqu8GUmm63mtkksBVz04IDzgs69J3LV3ALu399iFkqHGzTp60TnPEh9Y1rAfrscMKAJ5XxLvu0qbbikZEqEjNvA10z2NOii6Stv2VKumkVrdRyb4wcKShaC0t2jKliqxOs0LlWMrXv5HXBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyShwK7hIkArZzJEE4zJpaAwoFc7CnAJngHoJBbn8I4=;
 b=H91sB56ajDf6DFidB5xSS6T3PE8a210CxY5JT8KeIc8HEVW4bBXr1su9+VusnQjJUhwJghbvxlSyRImfBl8lbZKs3n+uexEGaIPBm8eAqlJ++q851bl9lMqONqAPW57TQ0hwjtgCcyLyYL8y8Gj8pF+T8NTDxMeHLehbVnWe8pH69NFwav2MG0SJwnnVnEkbkp+G0hvSWreT30wgkzKNmOFdqIrQlSqspe6UPHj1VI6ha779R5awYXTZsci3rppOM76MZ/cwm1ZRA+kwSqUzyyNk7yL04cZNaTWOZd/GkWN7FuOJNiCDh4d3/14ou+gIrgdm+qwhoTqxcLy/jCEPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyShwK7hIkArZzJEE4zJpaAwoFc7CnAJngHoJBbn8I4=;
 b=BpBYW5wOqois4IO5mI7W8FTcaliwldpWT6k21WP/F/JOW688gTW7pgS4LX3md6w8vaXoDaXBLsb1YRmDXU8RJodMNx709PdGZ9kBmh/6+MtYkEEvENQc8CDdqq3u8zVbykwkYEdK3a19U0eydxCVmD0n8nHzJDSKAULcGNUxASTBzby9sczahewOlRgqiA5wS2/ME3k0JHgqDw5lwb17sxysU638lQUTRy/7iwQVIASLpGyNhZMi51mdKWgsG8dgv6P8OdJjdpqQndYCqu+RktLy12hqwn+iVFiP82rxZ7cp0QvmUF1kSb7AqUA4h6mcwJUoBFduEjmGjuMcKdvKuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 05:16:04 +0000
Received: from IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::c3b8:acf3:53a1:e0ed]) by IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::c3b8:acf3:53a1:e0ed%3]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 05:16:03 +0000
Message-ID: <200f40ea-5111-4751-b48e-c422dd294647@nvidia.com>
Date: Mon, 17 Jun 2024 08:15:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v5 1/2] net/mlx5e: Add txq to sq stats mapping
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: nalramli@fastly.com, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>,
 Naveen Mamindlapalli <naveenm@marvell.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240612200900.246492-1-jdamato@fastly.com>
 <20240612200900.246492-2-jdamato@fastly.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20240612200900.246492-2-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::19) To IA1PR12MB6018.namprd12.prod.outlook.com
 (2603:10b6:208:3d6::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6018:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: fb29445f-3ca2-48ad-45d9-08dc8e8c9582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U29iMG5NR2RwVFE0N1loR25FckpPVENSWGpMNnZsc1NDWU9QMkd0UndCSHBH?=
 =?utf-8?B?YlI4K1NBWWxsSE5TL0dUaUp3TlQ2SU02VGlzc1N2cEw5bGtKdVhMSkJwOS9N?=
 =?utf-8?B?U2dqclo4VW9MdFNkZ3lqOGNZM1NWY1NGV2Q3NVMwS21nbWV3NEhnaXhVV2RZ?=
 =?utf-8?B?VzRkZ1hJWXVuelJEdTE1cThiK08zTDdVMmQ0M1pYZzJnS0UrSzNZb1NReTJO?=
 =?utf-8?B?LzBJZ3JIcVJ1NWxuaGZObjdnc0lZbGY2d0owQzY1YkVuSkF2SHhVQW5pMHRq?=
 =?utf-8?B?Z2VyMEpieUNXRmwxU1VwZFl1dzRmTlM4b1Q3eEZjRllCcUwxcE9KWEFmeHNY?=
 =?utf-8?B?SXBIQkErSXJ0dGtQWTNoVHFlbTNuTVBURWNFYmV4czZMbm4wTmVPSXo5c2ZL?=
 =?utf-8?B?Q1JZc2NTVHZYZ0JHNmRRVmNrbVBuei9jeUhpWmJFNjNUdVluNHI1UnhzYUdR?=
 =?utf-8?B?MGZOSjBUSWRRSE9wU1d4cDFWOEZwKzBra1UzcFFyTWVYY0dwZTFBdUx3Slkr?=
 =?utf-8?B?N1ZxcE10bjk4YWc2YTF5VEowcjhGOFNnVFVOa0x5VjBjZ0FsaU9STXVBL01l?=
 =?utf-8?B?UWNodUMzM0xocXppNGJReXdlS3pzZEpuRGtmU1ZwMkNlR0dZREsvT3Bkdm1j?=
 =?utf-8?B?bm01QW9sNGswaERyMTFFVEdnaE1pU1ZjUVY2L3lzL2hzMFd3YXFqT0ZpcHZt?=
 =?utf-8?B?ajNwQXZIcm9vVXUyRHhZT3NnMlFEZlR3UVpXK2FScktFTEhvS3cxUnR6czBE?=
 =?utf-8?B?U1NlaHRxanhIN3hna3VjQzNDQ3dJSkMySDRMeVZ2N0phS3NjQ2ZFQ0owczhV?=
 =?utf-8?B?MWVYbDdkUnNlN3o5bFhNQWhtcmJGdUplck5yOGwycGt3Q3dQM3V4TUJBNEdy?=
 =?utf-8?B?dXE4WVV4RWhzMVErYmMvdTFSU0xnOTY1bllNbGNGQWJsY2FIdjBlQVVFWWZN?=
 =?utf-8?B?cEp6VGRwSWRFcHd5V3k2Q1BnQVp0dnprMmNQOFBVRWM3bzVyVnRyUW80c0Z6?=
 =?utf-8?B?S3FTY1hSOTdNQUp1bUNVUmRpRW54ZmRXWHFsWHBIOHBwYzlNWjcrOEEvZkFr?=
 =?utf-8?B?REliQkxGNmtYYkcyOCtjTWhLNUxhVUdEOVliTjNDb2hzdUh6cTdHOEovMjJ1?=
 =?utf-8?B?UXBBY25idyszRHAwMkZXL0t4MGJpVEtzTmhrTENVS3hodVozalZJc3hUaU4v?=
 =?utf-8?B?dXh6WGZ0TWUwQjlJUzdia3JVbGxWRUdla2VFQldqTGpGZEczcEN4VmhVUk9Y?=
 =?utf-8?B?cXRNTjV5bnlrY25RZFFoRFpDTXcxUFlwU29rMVRtY0NaV3ozQlhSTUMydm9F?=
 =?utf-8?B?TVp2NWRhREYwUzVyQkl4c01CcldCRTN6ampSZjB2b1FtZnlackFjdTdJRzds?=
 =?utf-8?B?bXJ6ODRVV3ZyYWNTTU5TaE1IZkh0K00zMzU2MzAxVmUvQTBJb09lK1VGSXR1?=
 =?utf-8?B?UDRpOG1MMEREaTdtdHczQUVRa21KeUdCdHg0UWM3dWRzRUN0cjNwSldOVHdH?=
 =?utf-8?B?bG5kcEJ5RmU5NGZVeGRNWHdMSzczZS8rMU5wdFJSODZFeFZBYXJBMjFXTlY1?=
 =?utf-8?B?cjN5c21rLzBCcG9aMitMNkVBZGhNaWczZlg3RmVTQ0NFdnlLejJ3dU5Qc0ZQ?=
 =?utf-8?B?djhlSlQySGNaNkV4a0Fyc2EwNENKRGNpc2ZLUFVOQXhHRDdJcWVGSXNsVTNS?=
 =?utf-8?B?NnFqajNNVElKa3ZnYWZZclFkRmtEOEc1Mit3YmFReEpLL2RXV0k3QkhPcGpI?=
 =?utf-8?Q?ke8AlRcnLMp/GwxE/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6018.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVpZb1hOeXg0N1pKeENtaWp2dUpUdnMxMEVwNXFjcHprYmR4cWFGRkZOSkVz?=
 =?utf-8?B?cC8wdEdJQUFkRkducmJHaGZhQTFvT3pGTDY3bWttdnh6SG45UVI3MzE2Njk2?=
 =?utf-8?B?UWdTRWk1YmsvemR4SlRYSGx3S2l4N0svaTljbjgxYWk4WkFkbzFKVE1KTjhD?=
 =?utf-8?B?bkhmRzc0MEZNSmdXUXI0QmdrejNsTCtoWTNhVXl1cGVxTnJyVm96Y3FKeG9n?=
 =?utf-8?B?QVpSNVY1TDFlOHp1YS9HQ1VJLytWMmV4bzd6eW9hY2ZudG12K3h2VEtObjly?=
 =?utf-8?B?TmVjcnhJR09sMWJBbUpUTWdtVzV2T0JsVW5EOWhsajVJQ1ZMNjE2Rm8rMjY0?=
 =?utf-8?B?bHA4emZvTVltT05kMFBQS01HNml6dG55N3hPR3JvdmlZQVYrRjJ1SjZkalVU?=
 =?utf-8?B?Rkt3ZmptaDdhNVQ5eFZ5bWhpbEFXVUpCRWl1TTZBcGplTzJPVzd1WDFZV2N0?=
 =?utf-8?B?b0JpNkM3L0tyZ1VIczVtakNtVXA0VWVhM2RFenlxNHFJdTlFL0N4dUNMWTRt?=
 =?utf-8?B?UEdIdnYvbDNjQkFWUjZjOERJQTlYWDJuQVVvNGhZU3Jla1BIMFFnRjJPOTRP?=
 =?utf-8?B?V1hIWVpVdzlFTWg5TW9vNXJLWnc5WWtlVFYySHBidStYWHFubzY4SUJmalhk?=
 =?utf-8?B?aGMzbVh0Zm1aVVNKUElmcXR3VTNSSU9vZ1MrdWxGdms1R2habWR6LytjdkR3?=
 =?utf-8?B?aURWSHpvNG5jS1RJVS85Y2R0V2VUbzFFYnNSQVJ4NVE2WCt6VWF5alcrQVFj?=
 =?utf-8?B?a1lvQkpXSVdJUzVGYnVFZFdCSWJkSjErSFJhY0IxTzJ2QXZxdzNpeDUvUkVN?=
 =?utf-8?B?dGZUZFNtcWNIZG1WTTlMK0U3QVZxSXkrcDlTZjJtbDAvTlp2Q2xPaktiQ1lw?=
 =?utf-8?B?SHBaL1BFTFNjb1U3RE55NVZyR2ZWR2VLYkFidk1ENjUyUUJ0eDlpKytWUXNu?=
 =?utf-8?B?UlZoZW10Y0R1ZUEvS2FaNTEvYUVXbWJsOXBIc0Jyb0hqNjRQV2FxV0U4b0dz?=
 =?utf-8?B?WW9BYWhWWDdmSlVsNG9GWjB6Und1SExYRzZDMFlySGt6NU5FZkVvNUVFcDFG?=
 =?utf-8?B?UGUzalBmL1k5dU1sYzlPSm1pK3dOZlRCTTRYamlJZjJCWCtnUEM2NDdJM0JQ?=
 =?utf-8?B?UFpJdzdReDNtMkhTSlNBZDNqc05ycnZiUHZBUFY4cHFSWTlVZDRVTTR6TVpH?=
 =?utf-8?B?NmxFdXorUWVkTlBydS91bDIxVERyNllIM2dQcVRtbDBWd3p1VzltUkVsSTVo?=
 =?utf-8?B?OUxFamNkVElGSTh4MW1xMDB2UHhBdEs2YjRYU2orK2dmZFFvdzVacXpHWWk4?=
 =?utf-8?B?em8wdC9DR2NEM0FoMENZYlQ2TkRyVlZTRXE5MmJodldYd203dS9FMmt4Ulg3?=
 =?utf-8?B?aTNnZWhjV0psZHhGOXJwTE04bFl4TnMxczdjQVIxbERPZHFRL3EyTVBjR1F3?=
 =?utf-8?B?Z25MNzYrVFJMaTVDL05iL0NRb2c5dWpsbTVqbXpJcndsYnc5ckgvZXAyT2hL?=
 =?utf-8?B?bkxqT0taL1JYZ2JrL2JoUmJzYUkrVTlBdThPZVRsMEpSY213WjFZUk41V1JX?=
 =?utf-8?B?REpGU3pKOEJxUWJmWUpRVDhZZlZsRkYxVmd5Q0ZFOXJXQndTRDZRQi9vMDVi?=
 =?utf-8?B?RXR6SFZxTVQxbldhdisyT2VJU2NJUnB3MU9NWEk1TDlsTlRGbWRqUFR3SVVD?=
 =?utf-8?B?RjhweXhCL3M0aXRJRjFkUlFGVHhPNGtqMy90MEhTb1dadThndFM2TFBjWWZ1?=
 =?utf-8?B?NHdkS3dlalZwZkVkNzEzTmFaTHB6b3lIM2MxeHY4T2tGYWVYREx4MVZ2QWIw?=
 =?utf-8?B?MDc4SyswUVZwSk5sd3o4RTNNWXBtNDZpbFpvZlkzU3Jqdk9yYlZCUjVDT2Vs?=
 =?utf-8?B?VFlZWmVmRkdYcyttaTlobEVWU21mZWgwUjl4VGhEaVJqVmtmMmNNcUVhZm9F?=
 =?utf-8?B?TDlrem5OVWJZdDVzYWY3N25qeEFGYUIwLzVnb21namd1WDlnRlYzbzEzU2hM?=
 =?utf-8?B?OW9EQUVFRFQ1Nm9HYm1Ob3dTT3ByRTkvQmh2OU4yV0pXbTM0bElaZjY2dXhW?=
 =?utf-8?B?R3FEdU5va0htOXFyQm0xQ0FSVzB1VXpmeXRIb0JpclVlTkZyZWR2bTVrQW9Y?=
 =?utf-8?Q?a9QuLVo52x24k9IjxCIvjewFj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb29445f-3ca2-48ad-45d9-08dc8e8c9582
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 05:16:03.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7To6hHEX0Ux1sp+1GJAgozReigLv0VbzYcc+9RZ3453XGe8smRjUhVjdqg3NTsWZh2CaboGBYRxceyaay73hRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265



On 12/06/2024 23:08, Joe Damato wrote:
> mlx5 currently maps txqs to an sq via priv->txq2sq. It is useful to map
> txqs to sq_stats, as well, for direct access to stats.
> 
> Add priv->txq2sq_stats and insert mappings. The mappings will be used
> next to tabulate stats information.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


