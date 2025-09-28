Return-Path: <linux-rdma+bounces-13691-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F2ABA6918
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 08:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62ED189BEF4
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 06:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C09829ACF0;
	Sun, 28 Sep 2025 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nE8AZ8dn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A52248AF;
	Sun, 28 Sep 2025 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759041350; cv=fail; b=n3/J8+4nRlWFYa2MVOxyenrteIRB1irapFSJrhXhK7Msv1PbXc6HD89WnjUejf2L2piQe0GVYCtOgrv2Mo7ZvsRRaoj4iDvtQJo2SQFCVr/3yulnY2PY3jhvLT8VLPibNhkaXSBxjHQIgi9ARg2i6MjrksLrIsPcOru6TzrPLtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759041350; c=relaxed/simple;
	bh=wYJjYKK6YDAtuRLNAStMbHRf6sUs/XjJMsn33BFqpVI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=msnIvySEMgw40dIUsOhk0fF0QzxWa5PNZpGLbsSZe+kITAT2WMX84JzbSoSS/d+6T9x/wfJVQe96J7xWwQ7g04MRI/52N1kGPB1n6u0zJzfLArgxrreOOIP/YjtHJY4iv3/0n0v13+g6v4ahrWqXNSw7q2RZxP7kv8gMFixUlgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nE8AZ8dn; arc=fail smtp.client-ip=52.101.53.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scDw85p9A4nOOytev+DG7FOCjbzvqF13ttF/8Nu5LgZxLngiyw83V75Zdic6Ec7hzA+o9sgektsVVv26yZOz1YehrM6xnAog9tXBp3bH9UBJ3LICKZx0GVRVHDCPPD8YGWA5dFpgpBnkkgSOQ1NBnKY6W52gC1wSuGei4AuM/2FOLmwjzZKfuv78wT1i60KuhGxulJ/80PcoCv5Vr5QB1KnrLXiwYu62admrsnDln825wfWz/E5qyL56k/p4APrKGPMdkfRvMqRdAi+Kerrlhne1zpAFI5vDD3qTqVd2yHyNe6lmqc2jzkcpnqjJhsobSF4jJB2G4W8keCSwWj5cHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5uHLEfQQ3Fy1kQqJGZq4VRpEPa6tWpqhTFtEYGIUbg=;
 b=rZqjbr8pTH04yPLSVtMxslDHjzD6HRymI6xi1Enqp2AoYF18zJ8C2c4AA4hgsIDHjQxzZ0W+u3oSbc99EnQvIKCnpPOY+jozBiX4DBq+2Nir/5tUtad9kYrU03LdGfGLN+eE/Gre8i1EKPbRU6PavBZzBkshpCnhXj2eBpRyYJ8YgUNVzy41pj223mNIGNj7ARdZ8tihknquYT6L7+bMIZU1EGH7UdXn5zBMBa8PkqaBzJzS3y5kwBJjfD1sAU/hqHF4B2PB24IcKN9GeWwM+31895M0Xca6Wl8GLYxdXou+KnZ9hsUnd2cYFSRAtV8Xaw40o8cozODfEAQQiLyxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5uHLEfQQ3Fy1kQqJGZq4VRpEPa6tWpqhTFtEYGIUbg=;
 b=nE8AZ8dnx0kcCm/pscyWV81cx9Yv6k5oRzuZuHnyYRS1VSJBniSS1lTvW5hL0tuUSamsoysLWfqWLwoaSwO/X/EtCxCHTMUNos+Reo9IY0yMxbcMkP+SBD6PI9afP+wqljYTA8gIbzP9rr2RrH2BE+r6a65e8y7OHlI5I0DTMFFHJv2+AH5/ACwoAEq9StTJoXTA0cPqq6vsiI3j2yf/kMiSCSLsOLeJrr59M3URgi7hy27rbyG1+wWp1nHlS73z0qc+NwXHtQpjfDjfph+6YMLuUYhMg+5VUMrSCAKCYLXZar4mq2CDrvTXZaN2gx22v+1dvzQF3Pl90X2z+AY+ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 06:35:45 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%4]) with mapi id 15.20.9160.014; Sun, 28 Sep 2025
 06:35:43 +0000
Message-ID: <cd0210cc-2531-4711-8a15-2fbae77cbf0a@nvidia.com>
Date: Sun, 28 Sep 2025 09:35:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net: tls: Cancel RX async resync request on
 rdc_delta overflow
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Boris Pismenny <borisp@nvidia.com>
References: <1757486861-542133-1-git-send-email-tariqt@nvidia.com>
 <1757486861-542133-3-git-send-email-tariqt@nvidia.com>
 <20250914115308.6e991f7d@kernel.org>
 <0b7a83ec-d505-40c3-afa4-8f6474cd78d9@nvidia.com> <aNFxIfD2aPpB11dC@krikkit>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <aNFxIfD2aPpB11dC@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: b02411b9-f3a1-4c6e-b1ef-08ddfe59400b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0I1MTZ1aEhEdDRtdEpQcTFBUFZOWWVZRlMrWTIzbW9kUWVPY3NmTlZpNlJX?=
 =?utf-8?B?NXg3elVwLzBCMWMwY0dDS2owNFNTQkZSZ3RkMU1vaTBIOC8ycFFuOC85eHlI?=
 =?utf-8?B?eEVFcWUvZ01GWEVsQ0M3YzRzZjhaRHMwUUJXeVJrWkVTbndjVTFFd2VwU3BG?=
 =?utf-8?B?dmZVRndaVGlzZHAzc3JkV25RYS9tQWl6Nnd6MU5uYU5RWE01ZTlNK09icFds?=
 =?utf-8?B?QTVoVE9SWStIcEhzcVlYNnRNQWJlYnhBL1dPYktYYm5QcG8xWURNUHE0dHdQ?=
 =?utf-8?B?THhRY2RIUGErT3Q3amZHcjI0TmZ0QUdzbkMrQTdqS2ZkVEs0eG1VTlk0RVBQ?=
 =?utf-8?B?UHNqTzJqTkEzaXNmSXE3Y1psYWFEbzZQOTQyN0FFWER4d0NEQWNEa0dhMUNz?=
 =?utf-8?B?cnZ2VGR6OEVhTUM0Y2tUdFBXMmJWZ3dNT3EzcHZkR2R1bHhhSFpQQzcySFBn?=
 =?utf-8?B?MUxacUl3cWxIeTY4Wnk5NHpsTFU5cTNpaHB3RDVwYVhOOEFWd2xhemQ4V3Iw?=
 =?utf-8?B?QllHTW1RcGpIdmdhUEVvcHdZTjhKY1p6MVVOcFRPWXl4TG85UTJOdG5sWWtE?=
 =?utf-8?B?NXNyT0tQWWpkV1VYa05pc2J2WnRCRm9DNFArcFhjdWtMdng0bHVrM2Z1Ulpr?=
 =?utf-8?B?K3BYNnBPL0I0QTdqcUgwbHJjcERzcGl0RFFhTkV5bkNpdWxmQTF6aFAyVzVh?=
 =?utf-8?B?VTRVMFo5VlFjVk56OEV3ellEcmNEdTN1TGJIN3ZYMVJlaTVPUS9LOEgvTWVE?=
 =?utf-8?B?cDRtZFRFN3dKWGIyVjRXeXpxNTVhR1VsaUZqWmdhQUQ3bnVrKzI1b2lWTHRn?=
 =?utf-8?B?emdYdTBReFlNV08wblBrMWdERGJTMFhldnNUcmMwbnhDUWZqWEFSWm9uVWc1?=
 =?utf-8?B?N3pPZXVWSHBMWmc5L2g0WUdiQ3YyK01EMUNmVjF3eXkrZWJIb0dKelBQcVRC?=
 =?utf-8?B?VU96eDM4MThHTGFoclhETzM5dEFRUUcyWWs5QXlGQzNVQk5pek5JaFVKb2hh?=
 =?utf-8?B?dHA1UUtiNEhLbnYzVklpUzVjMzlOeEpuRWkyM0pGVElNM3M3WjhpaWtRTUlQ?=
 =?utf-8?B?WFV5ZTdMb2h6WEVmdlB6OWFCLzQ1dU5lVVBlOXQxSC9GL1k2VUEzaGFaTTVO?=
 =?utf-8?B?K3lIQ1BDOUROM2VJMlFGdklQdGptTUVabXpVVGV0K28yb0JzdUR0dGlDbEp3?=
 =?utf-8?B?bktOUjJpaGR0NnpIdzVTdm9ISmRQMVV4UzBYczdTekJXQUVoMjYvREZBNUJk?=
 =?utf-8?B?VWNreTg0MXlXTjI5eTFucStrVm40THdITUdoZFhnMmxHakd5a1J6R3RmSExB?=
 =?utf-8?B?L2t1ZzhGLzZjaHV1cHllbTBldUh1TWY1V3dDUWNOTHE2a1JRMzRVR1NxZXRH?=
 =?utf-8?B?RytqTGlvSHU5KzgrcUxwVTJGZUpJeXZiSHowL1luY1psRHZnbWZ1dWZHaXNT?=
 =?utf-8?B?dC81VHkyL1JQRFRZbXpBTWZKK1Q3cEFQVEU0Mnp0VnJyLzVuT2g0MTFXL0hD?=
 =?utf-8?B?N091YUNjdFNZdkpTMzlhdTRGU1dEdWhHOXdzdVd5RW9zbUZqKzlLN3VIQzI5?=
 =?utf-8?B?Yzk4K2JieGtVc1JzSFNoMGRqZ1hJbG9GL3BSOXhNMElkbnNnKzdwdE8veXlC?=
 =?utf-8?B?dGNneVZNbDA4c1ZSOCtCcUpEZ1lHQkZHa3kxcUVIUllSRnpXTVNNcnExN0pn?=
 =?utf-8?B?amVadWJwaHcrZEpNa0VxaGoxTFdNNGovdUdjZjVESFdBMFhySGdXck11Sk50?=
 =?utf-8?B?UEVJZC9OejB6OEF5MzV4d0Vodk52QlYyN1JsQ0NjMnpKZ3J2VW1aaTNKVG1a?=
 =?utf-8?B?enhGaXd4WkRjZWlIeFJnTFNlajFQbUFqbFc5dEhzNmVmTlNxditSVWFSdDkr?=
 =?utf-8?B?ZFduVjczdnE5U3ZXS3pBVFRTUzN3M0ZudDRlSktGaWNYSzlINHhvUnY2Z1oz?=
 =?utf-8?Q?s7L4hZxBxBB8D5D+3YPbrHo3J8+7QBOD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkxzTG5sR1hzalJNV2tDc1dMNzl2WjdpTm8vcGRpbXF2dUtQZFArdkwrZVp2?=
 =?utf-8?B?TWJWOGpITi8vcW9zcmo0UmZaQzE2SVU5TG5vNEpLNnJSZzNDYVBuVGhBZUlt?=
 =?utf-8?B?WVQzRUhqOXl5V3o5c2dvVmRBUjh0T3Q5Sm5nMFkzRklmL211M3hteFNmV2lN?=
 =?utf-8?B?MnBRSmxHOFkyM0xyVS9BNS9DZHVMaUZTMXpiRUYyRWFQbllRUHpoOW9HcGlm?=
 =?utf-8?B?eDBaOFlkcjBnLzM5WEhWb05TR3lIWFZNSGRUSWs5UzdEdUVQakxyeDZDUDQv?=
 =?utf-8?B?cGFSQ3o2OUwvd05zcUlsQjR2ZDF1SDEvVVFnRUZiQjBtYzZGanJtZjdGRGJM?=
 =?utf-8?B?N2JGVytsb3N6Wmt1VnJ3TFFrU3R0UEF4M09QUUpPUnNsRStMN1hSb09QdXZ2?=
 =?utf-8?B?QnU4STUvck9VNHBBdVJXbjRYTnN4anAyMWI2clNPbmlFRHkxbkNFaDc2OFpB?=
 =?utf-8?B?YVMrZE9sZjJoTDdaN29jSG5BRDM4SS96MHAydm9ibFlnNmNFeUpuUnphZDVS?=
 =?utf-8?B?R3JYSElCeTJNZnFKeUQ3UkU2bnVsUjM2MTVIZGFnTzlvZXY4MDNqejBzWmxU?=
 =?utf-8?B?Z2dId1dNVE5WaWZOSXBCeWNrWDFFT3pHd3FaZUNTbUhkc1p5QmR1cXZhL29u?=
 =?utf-8?B?WFROWVdQOU5BbjhyQmhmdXFMT3NYR3BNRnhoamdoZTBrblp6dnp4dFhJMjFH?=
 =?utf-8?B?QTFhY1M3RnI4QjJQNlIwTW1idnh1anA4K2Q4ZzE5SDhBZVo1SUVQbmVMS1J5?=
 =?utf-8?B?bk1yckFMN2JPeFhCZ1RXZU5IeE8rVlNyOUdib0tsY1FYYU55S285NWMwL2xJ?=
 =?utf-8?B?b3ErMDY1MnVZdVJ0RVRoNXVDQit3a01scUxrWlpmL2dpR05Fdkg0NExHU0wv?=
 =?utf-8?B?bTVoeDNjT2pQdGhUa1FuanEzTUNMYmppV3F5UVF2QnFKNFNhVWNmdXc4QTJh?=
 =?utf-8?B?dU5SdkdkdXJRYkl5WE01TDNOKzA2cmdWaGhRWjl5VlF3Rm1SUzUrN2R0TTVS?=
 =?utf-8?B?MXF3blcwNU9rNjlOQTJKTTNBU3E5bFNrZ1YzWVk5czRNR2QzVStyVkxJTEE4?=
 =?utf-8?B?V1Nlck1RaDV4NjJYMEFVTm1rRVN3RmVSWXdhQk5ZQWtyRzlsVEM1U0NUUjBv?=
 =?utf-8?B?QzZab3g1M0owWC9JWlpJMHIwc1JpK0VIcTJpaHhBNUkvbkdzMVB5a25RY1FX?=
 =?utf-8?B?MThyV3hXN2RyNTRaUFhVMjFUT1VpaWdocnh2ckRkTWtIcmlPUlNJVXVWUTRT?=
 =?utf-8?B?WU9mdFZ4QzNhODV5MzJrRVprYm50Z2JSZThzQmhmK21ZNWxEVHJ6dWtHV1lM?=
 =?utf-8?B?NkkzSktqU3Q3RytRTytrWlQyNHJ3SnZnaHFVV2dsZHBnT3UrTm5DaDhYZUwv?=
 =?utf-8?B?N3dnTWJYaktDb2tpelVpbnBadjZld0x0L002OWxSaUVqWU1GYVNEWk1aeVZY?=
 =?utf-8?B?Z2xIVDBZMm5TeS9qMU1yMlB2VTFDelhDR2hRenpMNUNqcGo2SXBFa1poRm94?=
 =?utf-8?B?V1lNd0xjcGlpdksrd2FsMlFHbmNTcjdvV0MvOXVpeExtWWsweURjMHV2eVJo?=
 =?utf-8?B?cG9tWVkrV25hSGRZMTRmbklGaDRsWVhjUEZZY0ZsT0lZMHBNb3ZmcTFhWitZ?=
 =?utf-8?B?WTVCOEhXS0RmYVBBeGhuT3Z3NzJyMTlUS1NndmYzV0x5VzF4N0xTZEl3TnFI?=
 =?utf-8?B?ckNmUXhGYlFNTXdYR1RzQjVLMVpYT0VDTFFnVHhybEptVnB2YXh4alRmOHZu?=
 =?utf-8?B?TGFia2dpR1dkUkwzRFJiZmNqNnpWRGJNOHF2MVBqR0o4cTJtTDB3T2tQZ0dV?=
 =?utf-8?B?SmRSajlrMEhsMVRNbjJtazgvRkxzS2F2V01FZk5FU3F3enpHRnQ3dGVrRk5N?=
 =?utf-8?B?eVozQitQb1FwbXJNaysvb3hERXJpZ2dVcTk3SXRCdFZZSzk4RkZaZzlSREtj?=
 =?utf-8?B?TGtmWllmL1NMalgyTjhJdVc1Z2kwTXlvM1RkdEI4TVppVnJVbHlxdTlKUEQy?=
 =?utf-8?B?VURXcVFCK1k1dTdQTUVGYzVjZkFsaFErTzlRUVBNTUNiRkhXT0tQb2s1dVVV?=
 =?utf-8?B?QnZURlY2VXVudCswYXlZa2JnZmZxdE1oSjU2S0F1V0JUWnA0OFpOTFZKUE9S?=
 =?utf-8?Q?Lpgy/yYk9G/9sQc0uXXiryNLe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02411b9-f3a1-4c6e-b1ef-08ddfe59400b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 06:35:43.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoM5GUv+fYFlP8e3mHX9438P1tZvqr3raR5B7P2TMuocCQKH1jvEsW+70hyXoho9jQ7jgLRCqZjXpXCY4HGEbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473



On 22/09/2025 18:54, Sabrina Dubroca wrote:
> 2025-09-22, 10:18:52 +0300, Shahar Shitrit wrote:
>>
>>
>> On 14/09/2025 21:53, Jakub Kicinski wrote:
>>> On Wed, 10 Sep 2025 09:47:40 +0300 Tariq Toukan wrote:
>>>> When a netdev issues an RX async resync request, the TLS module
>>>> increments rcd_delta for each new record that arrives. This tracks
>>>> how far the current record is from the point where synchronization
>>>> was lost.
>>>>
>>>> When rcd_delta reaches its threshold, it indicates that the device
>>>> response is either excessively delayed or unlikely to arrive at all
>>>> (at that point, tcp_sn may have wrapped around, so a match would no
>>>> longer be valid anyway).
>>>>
>>>> Previous patch introduced tls_offload_rx_resync_async_request_cancel()
>>>> to explicitly cancel resync requests when a device response failure
>>>> is detected.
>>>>
>>>> This patch adds a final safeguard: cancel the async resync request when
>>>> rcd_delta crosses its threshold, as reaching this point implies that
>>>> earlier cancellation did not occur.
>>>
>>> Missing a Fixes tag
>> Will add
>>>
>>>> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
>>>> index f672a62a9a52..56c14f1647a4 100644
>>>> --- a/net/tls/tls_device.c
>>>> +++ b/net/tls/tls_device.c
>>>> @@ -721,8 +721,11 @@ tls_device_rx_resync_async(struct tls_offload_resync_async *resync_async,
>>>>  		/* shouldn't get to wraparound:
>>>>  		 * too long in async stage, something bad happened
>>>>  		 */
>>>> -		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX))
>>>> +		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX)) {
>>>> +			/* cancel resync request */
>>>> +			atomic64_set(&resync_async->req, 0);
>>>
>>> we should probably use the helper added by the previous patch (I'd
>>> probably squash them TBH)
>>
>> It's not trivial to use the helper here, since we don't have the socket.
> 
> tls_device_rx_resync_async doesn't currently get the socket, but it
> has only one caller, tls_device_rx_resync_new_rec, which does. So
> tls_device_rx_resync_async could easily get the socket. Or just pass
> resync_async to tls_offload_rx_resync_async_request_cancel, since
> that's what it really needs?
> 
yes these are options, but we don't like too much passing the socket to
tls_device_rx_resync_new_rec() merely for this matter. Also we wanted to
keep tls_offload_rx_resync_async_request_cancel in the same format of
tls_offload_rx_resync_async_request_start/end meaning to have the socket
as a parameter.


