Return-Path: <linux-rdma+bounces-13794-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F6BBC239F
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Oct 2025 19:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 810D34F1F1C
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Oct 2025 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB0E2E8B71;
	Tue,  7 Oct 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oqS2tFP7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010024.outbound.protection.outlook.com [40.93.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6B28F5;
	Tue,  7 Oct 2025 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857184; cv=fail; b=lf22YAxybBTtfDMGcHTDgeGgKR7eSRdeHvcVH2iABpbVEhKXhuF+xKprEBoj7CBmYjRi5MOXRj0ShVgQi/T2Yqt7Z5VD/Msja+iH8wj+GANzcZLiVSFSmRIT972zHmHMyMRKWrc9vdsXhgWHaYwH/gYyA/M8rIjirxZ9l3fwDco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857184; c=relaxed/simple;
	bh=7F3n97H5+SvdcACbwKSy9CU4S+uxkOTvznTWlwcjxTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D8l0Rh/Djs+Tbc30h2AGK4oRoxR7xqos0JQ8DO9+YP/szR/qcj78Bm/TNSmW8+dyjsVVhld1XPK7S7ibgq3/gWgcIrowAQ7MCaZngyT1FtdMFbBzspot6TpK1pWPmzyWyAhQI2/yoWA7RYDBMbYfbo9y1zzuPBbtUUKNTxVe/8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oqS2tFP7; arc=fail smtp.client-ip=40.93.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuEKEF9KQtuVk0M5CtAX5JcN8To5R+LiSjukr7uOAfmpJ/40wmt+MnOMWJhKIVOTFO6D5Celp0/FurpCjcQbmXlrlKmpyYfe2nyIzHvZgemAqO1R6eubDOwhk5gPUvLwPRYqaSWAVzy+2aOLu2J1JzMAeonrSMrAvQ8xqwmEqx3Fs74XOSCdk/tEdLE2wmqKwInM5MZqcZtmUdO6jfTpDKQmatJ+OTScRRnwTcNaSbyDsYomy6zhD9DIVkxZhksGSdFpg/qY98iGtniK+Z+XGMWd8BOiYce5dPchqO3YsBgRvwW2jAN3mRh1X77Wk+m/VG11L33KREyEMQKP9nWy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77Cebiqg7HQUeqj1YzKZZPVSGdKxrvxGVjlG4lhzxdY=;
 b=xTddkZWY7ByYaSmkd2fP0lP3cxrEj/njS9bHbbAeynuthjDiHt+wPAy86OB6Ow3qJghPQ/XfkaWtM2kSyMjmM7P1x1mSEogUQ9aor5FWI4M1pXpdSe4jsV8gnYIs3xIpfMV8xYTNQs4crefxuXihWPax904e3Jp0N21ngLmvu/t37UgvbNaQDl9rqLiCOOrwjX7gbISbFQcub7yVT5Pdmwb1nh4bn4vO/L0NMQXikNm0h6sFBYTaChIOvzryUf/p320LjTsL3vLMi6dboq7ya40S85hONqxrUzzRhYI+WEr9FmGg2CRh3W6Ay5n9BrHA07pONSq0R/s2T0boi3sOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77Cebiqg7HQUeqj1YzKZZPVSGdKxrvxGVjlG4lhzxdY=;
 b=oqS2tFP70WABueTLlVei+tIF1EeLP7ptPYAYxHENxu/ds6K7J21KtU097Ceixl+WFPqih+TR23nX5q7P8vA3EGRGX0hunP+siXd5+gsGv4GIMadIcvpP6AvhYe9u9XwDxC22m5WAG+j1AgOeibFxkGqZGCV0sHfM7v9St+AT//5n16TPghwICymFOnW76yTbcqI5kTpbilsY3vwdrhFn7IjmTFFc6LV06XFOloR099t+HNS7XRD068V0FdoBbe4Vgm4ZjPr3nmz5WDeMiAvMMHqvJMP331iNg4tFnw+s8ouiYrziPoaFQUJAMTqiEJWMQ5BrBZSH5TC4vXnlrIjoxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12)
 by LV9PR12MB9782.namprd12.prod.outlook.com (2603:10b6:408:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 17:13:00 +0000
Received: from CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4]) by CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 17:13:00 +0000
Message-ID: <8581b3a1-0460-452e-88ce-d4d9791beae1@nvidia.com>
Date: Tue, 7 Oct 2025 20:12:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix pre-2.40 binutils assembler error
To: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Moshe Shemesh <moshe@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Nathan Chancellor <nathan@kernel.org>, Simon Horman <horms@kernel.org>,
 Cosmin Ratiu <cratiu@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251006115640.497169-1-arnd@kernel.org>
 <20251006112105.3fb129f6@kernel.org>
Content-Language: en-US
From: Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <20251006112105.3fb129f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To CH3PR12MB8583.namprd12.prod.outlook.com
 (2603:10b6:610:15f::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8583:EE_|LV9PR12MB9782:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2e2b03-3817-4159-193d-08de05c4c444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VitwSWZCaDlOcTYwRTJrM0M5MG1FOU9zeGdrMGtHUzFMUVdITWxsOWRLNGZK?=
 =?utf-8?B?b2U3RjZZa043MWlPRlBUL0o3MFoyam4rcHI2dFR5ZUJBL0J3OEh0ODZ4QVdE?=
 =?utf-8?B?UEFsdGhmMHloU29QU3JZNDBORmtTampydHZINkVUWHJmbDNVZ0h0S1E1b1ha?=
 =?utf-8?B?SU1UbUNXSG84NzBMSGNDNEIrbzllSHgxclVUMERVQmwwWkxqa01ocFpIRDIy?=
 =?utf-8?B?eUc1QTFRbWJCZlg4OW4rYlpzQkxBclNkTk5uN3g1R0VZZTZKQi83ajFidW4w?=
 =?utf-8?B?N1FHMnEwemtVbS9BOFdZbEZVdER6YjRzSkF1dGVwaWk2Q2daQVNqSExQYk1I?=
 =?utf-8?B?UGZyVWo1NzBOMUdkbEFZSW5FZEFRNjByeVNLMk5od2RCWERkUVphR1FxdC9y?=
 =?utf-8?B?ZU1QbVZqSzBtVWZJMVE2Z2FGQzBiSnFiOUpoTEN3dWVEQ0J0TkNqUlFyQklp?=
 =?utf-8?B?TVR2ZHNlOXl5bmx1eHBsRUVJSGRYSzNLSWx0QU1lZ2lWc0dBUW5ZOStZdm1p?=
 =?utf-8?B?NExZM0pwc3ZocHM2Uyt5V0dsV1BFRXlrb09hSXZSaEVieC93eTRxeWNwc3o4?=
 =?utf-8?B?WWUzSmpQV0Y4NW9lV1JzUldYVkV2dVRuL0UxQ1hJajUzWXRRUmgrZXlnMzdq?=
 =?utf-8?B?VXdqN1l1LzdjamhscDV6YldvUkR3NUw1b3EvRXVnOElPcmtlczRjVVdaM1hV?=
 =?utf-8?B?UEttcWg5d0NJYnEzTFg1ZXJIVmpsUGQyVmd6THlmVVlzYy9DRVlPS1pGa21R?=
 =?utf-8?B?cnJwMi9XMkFYZDdNZ25BaVptak1sZjlYVUhITHNNeVhCSEV6N25oMDludit1?=
 =?utf-8?B?UGdzR2dqMkpzTXdGRGdIVVhWcG5aU0FHdFgza3Znbm9taDg0MXhRWTJKY1A1?=
 =?utf-8?B?cjBWVkVXRWZYSWRDOW9nWVBuRTlOc3dGT013NGFiQnNEMGFnckdINWxTZ3Ni?=
 =?utf-8?B?NDFIUjAxWjBvSWZ4ZXB6MnJpVGxBdjMwSmNQSURJUkRubUt1VDhHaHZoT1NC?=
 =?utf-8?B?aG92eWJaNEhyT0diaklIaytKR29aQlhuS2hadHpVc1IxaVNiL0V4RXZxM0Vo?=
 =?utf-8?B?bzZpTjRpTVZ0aWZ0cU9PZEVLbjlwWURMUFVRZGxTeFAycUFXZU9pUVVZeGs5?=
 =?utf-8?B?a2tXdExiNEVrUDdMMllnd0QrTEdlY1ZZQlFRcW0rQ2JDWlZqZEx5V3F3MGRm?=
 =?utf-8?B?N1ZaS0NUNTRJOUVUK01mYzdGNDdxN3JIeklacmxzRW0xeHd0MllTcWRlclc2?=
 =?utf-8?B?dm83VUJrOFhzTDZEYUR3bm91eHB2Y3UyTm5BOHFFTnBRZ0ovZVgvWm5Rd1dM?=
 =?utf-8?B?YklEUU1vTjhWU3VFVzhPUzRWMmhhWlNCOStIc0ovb3NBeVZneWN2UDJ4RFpP?=
 =?utf-8?B?WmYycS9MZUxycmV2bCs3MGNaaWswOG1uRlRueFp5S21DdFA0WnE2MW9Fckpi?=
 =?utf-8?B?WmpFQzFDNU1CYVhiSC9hMzVYaFlKclhTTjB5eEtCRVh0WDRWMHJyMm9IU2gy?=
 =?utf-8?B?ZkRza0xBNkJxcTZHZ0J4QVFmSERtcGlJMlJ3YUNwMC9rOHBvYkNnVzJRZk1w?=
 =?utf-8?B?c0FGL2VVS1dvUHB2V0g4TngxdUo4UWJhTitiVGNoUkZsZ3JLVzN2L1p6L3RP?=
 =?utf-8?B?eXRpWFZKcEpuUlJTUGVlSGlxNlcwY3BwaXZ5TjhnVTFJcW5BWUt1am4raGor?=
 =?utf-8?B?OUtqU1BWWUtKNkdaeUovcjkweVdtSURtQmFHbFdYY1NjOHZJNVpweE1HSEJC?=
 =?utf-8?B?dUNJdndKN0I1RHM5Y0R1MnlGdzk5RlJQUm9SNzFFNW1BV0dZNEJVOXJwYVF4?=
 =?utf-8?B?NEdRQTFHT1FEQzNuQ1VEcjQrYnJXRXhsQ21NUGxlUDRlMXBCMVFHRWhDNG1S?=
 =?utf-8?B?bU9aY2cxRGwzYzB4ZzB5WVo2VTR6RWZaTUpHY1g3bjB5ODBwY1NDNkFLbkZs?=
 =?utf-8?Q?fh3NlecfinxXm+Wk3pAoE2ZsUr8Qbsuo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0s2b1daZnIyeVdxS0V1Y0ZHWmxMeU1XazhKZ3lrWjZMeHdQMC80ZzUzUnZi?=
 =?utf-8?B?UEMrY0c2cnVQM0Y3Z0xLSEVZdDNLNWNEd1NrWjlSMzY5QTRvdXM5NVE4Rm03?=
 =?utf-8?B?MjBlY05DaGhUa3UxTVVpb2kwWEtiRk9WVGZwWEkyWmNaU3NKclVZRTRrMjRU?=
 =?utf-8?B?OFRMTkNHUFVqTzRNeFpZR090aUJiOWt4TEFJUE5LMjBUa3FlRlVFbkxXTVE0?=
 =?utf-8?B?a1ozbzQwNitJaktJcmF6d0Z2Vzk0M3hFV1hDQ3JYK2lKUStNWDZBNnhiOVdV?=
 =?utf-8?B?OXc2Y0hsd2dKSDNWY1hITGVRMlZ0eWdIRitpZ3FFNm5hcHA2RzgzV3FSK1dj?=
 =?utf-8?B?MEVWSjlNRFp2cUE5N2hib09pNmFnMStTdUhCV01NczhPS21tZjVaKzNFclE4?=
 =?utf-8?B?aE1LSjY4em9WOFNqOW1UVnBLOGVwaTVtSENUblBOVmYvbUd2Wjl5aUthSmFD?=
 =?utf-8?B?SU92VjRLbVJtNWJhKzFZaldwRENDc3dZVS9KVUYzRll2UitCQ1k1OGxJTS9u?=
 =?utf-8?B?RzNKMGxjMEpZaDFNSUNBLzF4N1pHUktoNzd6OUovWnBaa2tsVzN6eGI0QUFC?=
 =?utf-8?B?c2ZiQnpoNEpKM29uSWZMZVNQWElGd0c3K3Q0b1pwSWgwL1dTMUdhQWhxMUtu?=
 =?utf-8?B?djZvSjJBY2dOWUNEMGpsTG55ZDNkWEIrc3NWL0ZYRHNTcmtLQ3lkRzR6a3hF?=
 =?utf-8?B?VUZqQ25URlFwWUdramNzUjYzMUpPbWlpVEh0VDdscDlwSXY1MHhLREhMb1ZG?=
 =?utf-8?B?VDAxY1RSZDdieHdxQjdZbXpQWDlZZjNzUDFFUDhRbmVYajBldENiRDdwWGs3?=
 =?utf-8?B?bnlZd0FJaExleWUxT2t1YzVWVUtlQmxGSmN3d0lFa2pIRzYvTFlxbk5uZGpt?=
 =?utf-8?B?TG5EbERhMXB0Nktjd21aN3ByTFhIblNyeUJYRlFsbTEyRDFmNnFWT3NobnJj?=
 =?utf-8?B?M2oyeDlkOW5UaG5YYXFiaGJpZWFwSjNYMkpqOVZqQ2hjTUlETzluMWhEMmIx?=
 =?utf-8?B?R0hKaTQ1NXNDRTBrZHRWYjZYYUNLR2o3N3dtVXpEeWRnVkVKTmU2cDJGcDA3?=
 =?utf-8?B?REtIdWg0cEpsMzkwRjJQRldOMEdQd3hjUmVtWFhHNjUxYWd4MVJvcGtrL3hY?=
 =?utf-8?B?MVJpZkRKY1dLRk5MSVptK2p2bkJTd0taaE9McjR1Z0VtWnpNVmRQb3Z5T2lm?=
 =?utf-8?B?RlZ0NUdNbE5ORVhNV3hYOGdBWUY0azBZOFRPSXVNL1I5UEVMWUxXOWh6SnV0?=
 =?utf-8?B?QXVJa2xRbUJRNThWNFJZZkh2Qk9tWW1uOXhicVR2N2FkQXBpQW5aNUdRU3kz?=
 =?utf-8?B?TDU0RVFHRURoRzg2RW5YOWM0cmxtUGttMzQ5MmYxREkrdnd4VlE1aEtjUEhZ?=
 =?utf-8?B?T1ZBZ2p2K0VqS1JpSW5IRHBlS0FIZm1ya2tlQUQ1Y2tWeXNnZUYyVFpxYW5Y?=
 =?utf-8?B?Mm5HZUNIWFlLeUFNcUh3RTRVMHZJenpjYzJySDYwWGtMTFFqaWpNUEtYbHBR?=
 =?utf-8?B?RTlmTXNackt4Q001RDIxaSsraE0wblF6TzYyQ0hNRnlLRGtkalloT00zc3dW?=
 =?utf-8?B?eWsxaW0zaUh3N3FJL0FSdlNOOUJqSkQ1VE1iQzYrQTlOcFJ3Q3d0MUFhTUNa?=
 =?utf-8?B?S3NFajJVQjRzQWNRVGtNSHZzQnNweit5SitBSE1ZOVlmVTF5dlJYSXFkb0t4?=
 =?utf-8?B?UDlTRm40cjEvZ0FRaGZMbk1KRWNiOTg4TzZ3ZUd2MnA4VGJsM1N5OC9zTXFZ?=
 =?utf-8?B?V3NWY1lPOWZ0OWdndTVzbEFmcjF6QmJCbDUwbTlWQmJ1cFQyYkU4bTVEZ1Bt?=
 =?utf-8?B?WDlQQllOOGVOTHJ0d3gyZWFWSUZib1hmZzJEUmJrOWVpQlZVVkxWSEpiamxU?=
 =?utf-8?B?eTN5M2lvcVR5amg4QWdBSnJZYk1YUnN1UWVObjgrakVOUVg1UXR0ZERBbXV5?=
 =?utf-8?B?L05UVWQzU0F0ZHBZQmpEVFNIM0dxTXpzZEx5ZVJVbmluTHlJM0syT0h4TG1K?=
 =?utf-8?B?amVTZzRJbm81K3oyRUt3cy9Nd3hHTTRzdDViQlIzRUJKTVBTTmNPRXdzeEx1?=
 =?utf-8?B?WW9wU1g0aEllRjRGTkVCM0ZpYURrVjVhcm1lT3lvY3d5R2dxeTRKY2FIbWt1?=
 =?utf-8?Q?PDPFlhObWopxs2T2S/YTU1eyX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2e2b03-3817-4159-193d-08de05c4c444
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 17:13:00.1218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zeDsnevTB7utMeUG4PIP/CgOPeGFGDYiVLgIeAsNxa7fiX9Q7dRJQZONjpE2nm8tdci5736kQHJ5ktMAoceDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9782

Thanks Arnd

On 10/6/2025 9:21 PM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon,  6 Oct 2025 13:56:34 +0200 Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Old binutils versions require a slightly stricter syntax for the .arch_extension
>> directive and fail with the extra semicolon:
>>
>> /tmp/cclfMnj9.s:656: Error: unknown architectural extension `simd;'
>>
>> Drop the semicolon to make it work with all supported toolchain version.
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> Saeed, could you ack? I think we should get this merged quickly since
> it's a build fix.

If my ack is enough you can merge, was planning to send this fix myself.

Thanks,
Patrisious.


