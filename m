Return-Path: <linux-rdma+bounces-11630-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A273AE86D2
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 16:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289D117EE9A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED94D269808;
	Wed, 25 Jun 2025 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dMq2vn0+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3C268C42;
	Wed, 25 Jun 2025 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862528; cv=fail; b=l1KIdCUnZGcOpXl1AqRUwm3mezYy4cwOeaTUBSN8Rj3JssovQMp+vTRaYOX+AjugmGTf2lkgR9t9SWgrjIvdj9AVg38VSXt409OxcqEISo+6GcRJCZdBK3NCbq2chtL+6QiGmQIrKA1mqXQcHFOAC7OQ52vJlGd5zVGoMHtwU2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862528; c=relaxed/simple;
	bh=Uf2z+rp1Z0Nd5madcak+CdB/34OW98oclb566yVSoyM=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=q5z8VamBi9DKIFry80d3IT3NxVkhla/zwgIzV97v5jTEHbcXFnBD/ULRD81Ud8As98f+l8ut2sw9vUf09tGJLvHiVC05Ge3d2E0nTQoJr/IXufyGITY9ZtbEh5E7vGs3fDP1yAXgaFibqRvY7TShBYN8It2kjPOPBV9sEo+ltcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dMq2vn0+; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9wjwVQ3AmymskLDtARQYKVxKNzhhZvjFFqk2YcBcg6PSVF/n+WTQOqujaKhWKvZ4kqUgqwrNQ7hcM1HboiNb5OQYWI/prY7ZEDzCuUPrMok2kZNk/3uOSTtpDDtazdgrBGgICGXyiLX5/OEzsu7FVYsOKJgcQ1B8U6w6aR3iHTLZnTt1cP7itEfe+rMnJ5j3R/tjWUeLVn92bV+J6xt/4zW0x00P9jidWcIyokcbU8I36KvVCUv4KsJ9sNXzpIpRqk84eJerM+igd7e4UGPoRYe9QjUlC6I0MqslUslARZBSIWJdj4fmlfDTBcFfiWWl5IiKO48XXNk8+3xhzcyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMEvf7JRzxzDs2n/rrfWRUNS2nE7CGoLdwm7bI2pK4g=;
 b=W3QJJEiIVCJ6DVJ+qN9BDV2TatYiGY4DR9m3HJpTsChx7MnEPdy8wQUYswO8kkxTeWXkCi/cARphnUhbdeJhVZGDsagmTcR42XfsjGdCs+59pk2lz6fCSqH3o9+tmv6bI7cQcevo8xkbP0jaXHCtgQ5CM0g+OwupfeTxOFkV65FBXlBCnfpQhlYW7FLy1nZ/5k/M2FOQTjxGts0bUGoRRjdg0pDdjvztYDZcqlFkuJiosHFOXr7FhNm2Xh9xFmOOdmwUMtBM4eeSRX4JJyAQoB2oIsTmwdhqXhM2MvmzGxCdx3CVvNUySnFZq0AUXkME76m91QQdowsm0GhKGBb9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMEvf7JRzxzDs2n/rrfWRUNS2nE7CGoLdwm7bI2pK4g=;
 b=dMq2vn0+kbn94XhbiQeZ3OY1nDWcuRBt28DzV3FDbLMjlsi3XAneRSHLNXfMW3RkoTt6YPDXZN7nlSC80ZCM/BxAOovDrdv0MnsCQlOssCc8jo9c3qcYkTm6DgE2j1TM9VBebUCht6YE543bp4a5j/h1h5PpoPTjsBbRV/rqvk6v/YqFxtKX1bEBFDq1WtqSjdXqIZ3qeEYy0Ks+dZqcvnOcxHMxtnf2ahhDnldfnTY6yaGRAEXdwTNkhgedIuotvKXGb+N3a7JGdO9cV3+xZkBfxh93EZQQ3YsZWJWAXY5dP/rNv8pvnkGzrVsb0PBQKxuplWwPbP0eeCo8aJGXag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.38; Wed, 25 Jun
 2025 14:42:00 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:42:00 +0000
Message-ID: <e7a83ea5-d70b-4c37-8068-a73293b51262@nvidia.com>
Date: Wed, 25 Jun 2025 17:41:54 +0300
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "David S. Miller\"" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 netdev@vger.kernel.org,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
From: Mark Bloch <mbloch@nvidia.com>
Subject: [pull-request] mlx5-next updates 2025-06-25
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: ce086ffa-3d53-460f-16b1-08ddb3f6712d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFY5M0x3ZkRVVTBnNlNvTTN2em9DTUtyNUJjY3ZyUmtYblB0Z0xRcXB4dm5p?=
 =?utf-8?B?bU5wV014b1RnTUZkVWg3c3hLUGNtZitWK00yZTgxQndnbzRaNFdqaDg3ME9Q?=
 =?utf-8?B?RDNCRloxc1lhWDVSR0tpcEhvRHRSSVRYSGZUUVBDeHp5NlBvaHk3Q3ljWlcy?=
 =?utf-8?B?Vk1LdDJ2bVpVTlpnc2NVK204RHFlU0lqcHl0OEVzMDR3cjNPREE1V1BpVktu?=
 =?utf-8?B?K3lESlA2UThFM2d6aW9IclViaDRZV2NYK3lCSWQ3VTI5ZmZYT2IxNDJveCt0?=
 =?utf-8?B?TGZpa1ZBS0YvMmw2MVVKYXpyMFp5WjUyaVpKN3duUHI0b3daRmIyV24yVFdV?=
 =?utf-8?B?dncvVlNSc0wxUzlWdVV4Q29wVmxpQy9zRmN4SUhOVnA2R3I1Q3RjSVJYUXBU?=
 =?utf-8?B?b2NlckdIWGZnWWRlSWRoekdPVG9CTGN4L1pEaTVtUHoyZUJFMEZDTXFsbElv?=
 =?utf-8?B?dnliaXBRQUMzUU14dm5MMlBjeWlYTUhUR3JGMitxTVlkUGxiMUFza1haUWQx?=
 =?utf-8?B?RTUweHRybzR5QlZrTW1HY0p1ZmlseFQySUVDejZjWDFKeDNkd3d4ci84eEs4?=
 =?utf-8?B?Yk8ycHJUL3llNjQrL2NNRG52ajYyQVdwMTF2T004RVpJUENjTFNRU3lrY0dH?=
 =?utf-8?B?am4xRnUxWTFPNVRkUzlBWkpTUVVIenkzTVlnQll1VElRNlExeHlwRnRNQ2ty?=
 =?utf-8?B?bFVYcjdsU2dId2crNTJPK0VWOWtWcTVuRlBYTnh1dDhvdUdvOEw3dDJXTjJp?=
 =?utf-8?B?ZEltVDJxVytMNU5jemR6Mmx2dWpHaEJyRDliZTV6QVpDZitFZ214Z2tXMFI0?=
 =?utf-8?B?c0krTVdNMnRnYWtMbXZnOFp5MHNMa0ZsWTdzU21oRHB1RWZBNnlwSFQrb0Fa?=
 =?utf-8?B?eGtmamQ3RUEraFVmYVNBVFJORkVPMndtYkVCNWliYUNoZzJBRUxDaWVyTEdi?=
 =?utf-8?B?Wm94cHZyNVpQYWpFYTBCOUFuVG9UZWh4eGJocFJlMzlJVkdReUdGMkVKdkVR?=
 =?utf-8?B?RVFZSmFDcnVoTnp2TVhNR0J1cXZVcVhveldSTi95cGJURmw0ekJyaElHZGxT?=
 =?utf-8?B?aHp1RVVYZUJuak9jamx5NTZ6elB1RTZsY1dMNmRndDVXOGxpbmI3eG1MUmk4?=
 =?utf-8?B?VGpMUkdnY0JCM05vSWpaZ0tHMWs0Skk5U2huMDF4eGVyaHgwTHdvaWZSVExx?=
 =?utf-8?B?Y051K2d0TFJwSkZQcDBCWXNWdlprbUo4N0FNSUVVc3dVMjlPQVBScEprVEVs?=
 =?utf-8?B?ZkNlemJyR0d1WDNISWlzaldrenp3K3lYR3pMd2d2aWttSmVOblRlU21VWk16?=
 =?utf-8?B?VDRMK1dyUFN3QVhnaVNOdDVWSXBBanVOa0xYQXVxbGJRK2JFUDh1M0N2UGUx?=
 =?utf-8?B?ZUNPTy9qbW4xSmxvSU83cGFqbk0rcjlLcm1xYTNmWkM1bmVOU3pKN3poK292?=
 =?utf-8?B?Uzh0THNLbmgxZzFtVEFKbkFPSkxhVFk3cnUzV2lqbnFaeUlxMS92dkdGTVU0?=
 =?utf-8?B?Vm5SQ3JUMm5jbCt6NjB0YndWUERWTTlIdUxkaHBoblQyWVdzaVI4bGl3UDU3?=
 =?utf-8?B?UW5yd2pETDkrc05WUmFReEw3c09mQ0hmSEhaRmp0WVVRTXVxSzhOKzFBY0x1?=
 =?utf-8?B?STVGQlN6K24xWElGSzFUdWZib0pBK1AzemFxem1QYjRMWVZoVTQxeXNRdGFJ?=
 =?utf-8?B?R2o0THYydllrdndZNVJBeXNPNVFsWjFIZlh5VEZpUjF1VDdEWlBGY0FUSlkr?=
 =?utf-8?B?QUwrNFE2eHdDU04zOEpvT0VWTGNNZlNQSWQxTDV0VnB5OTFzcnE2SGk0czhP?=
 =?utf-8?B?YmhVVVMvWFFxSGxSSkZScUtOS3M0ckFTYXErMlVHZjA3SlkySFNqNk4rVmU2?=
 =?utf-8?B?Y3Y2NHJQbkFFRVJ0MmJHRFBjYjI5bnhzR3BFMHBXeTJqRkZ4Y0Y5c2hNQWQ1?=
 =?utf-8?Q?95lcda7jkMw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVNqSjg3WUNVTmhaaXB0emN2MnNiRGd2ZEpVUWVPUkJQSkQvcXFCK3ZtbnE4?=
 =?utf-8?B?NDBIV0VyaUR0TkxJYnhLUGRISDQvTjBjVFFPZTY1d1ltaUtLSGhxc0FWTzVZ?=
 =?utf-8?B?eUMvYndwR0xENDA4bncrb1Y0Tk5oY1B4TWRMeXF6NlljbkZuUEM4MlBDblpZ?=
 =?utf-8?B?eUc2ekd1NWFkT3FlUk5qaDFqNlJrcmoyb3Z2a1Z1cmdVZjJlT2dyWUI3MWJp?=
 =?utf-8?B?NWQ4dWg2ZUh0MW5DckdMZEN1Qnh6azRjWE5JUlk0cmtveXpib0t0RWxZdjBm?=
 =?utf-8?B?dFZWQkFsRFFqNm85ekNCT2oxODU0RERoRXpvalNLMmhkNUMvNGlhdVZSSFRE?=
 =?utf-8?B?S1RQZUpFNWkraGVGc0h2UGNCUHZyYjd4SnVWQU5pMy9OcEpvOVk5QWUreGdO?=
 =?utf-8?B?LzMwTk41SCsyM1g5ZVFiM1BBQTlvNXUzTXhPNzNacEw5NnFObXhlekNxK3d5?=
 =?utf-8?B?L0htaGw0M29qYzlzdzJBN0JJWHd0UmNXR2JYVS9ZeFVwZHBhbW11VmZUQ3Z6?=
 =?utf-8?B?QmxCNHEzTVh5VEdoa1Q3YkF6QjZCV2pEYkx5em95ZHF0S1pQRldzeW9tMVR0?=
 =?utf-8?B?VFFDTXZDeTg2UmFtc3JkWFRPbm1VU3hJdkh4V1MxREtGTGh1cUtxdGpoYXdw?=
 =?utf-8?B?NkdaSlhwN3haaWdxVUkxdFdITWxPQmZtRzVZR1R1TVNEUEZ3YWJTQ0xHM25t?=
 =?utf-8?B?YU5aZjFhMk5OVThMMEhGSGJmQ3M3VFE3aCtrT3VrZzhQSnVvdEc2a3BYRU9W?=
 =?utf-8?B?RnJOenExT29aeUxxL0hUeTIwZWk0ekp0djg2dVFMUUJQeHJxZ0JFR202cjha?=
 =?utf-8?B?KzQ4MVlsRDBqTkNKRzcwWWVhWjl5QWovekFvZFRPcXpOZlhUZGlWK3NUUmVl?=
 =?utf-8?B?OXlJbGpUYlVQM0c0VFFOdWZWd2NiK1ZvV0pZcDVtTGdGYXFPeGdJbVlLK1Bn?=
 =?utf-8?B?MXYxa1hXMFczYTh5d1VXNlFZT3oxUXVabjYrdEFMYllZZTNTbUJYZzBBS2p5?=
 =?utf-8?B?T1p1aXhtM0FmSjVMTXpsakM1RGNEMi83TTNXMUxzblp3R3o5NHFEWmRMYlBQ?=
 =?utf-8?B?WDBpM3hkNDVPT3pzRnZubTI4OWJYWFZEWjVCQk1RdDQzL3VRcml5YzdCSENh?=
 =?utf-8?B?cHJUMlhOWjdVUG05a24rUjJBaE5JVjVudk84OXNPR0w5dFJKUllRYTIvd004?=
 =?utf-8?B?RzFFdGUzbzdPV1Nuc21QL0tlZGdUTkFoMHRrR3RyRklSNTQwaHpSbit6YUxn?=
 =?utf-8?B?eWxtVXZyaFFudnlPaHhUL3hUK1cyYWJJbHhyTEZ5aE9Zd3ZJOFhGZEdsTk1z?=
 =?utf-8?B?TWJrYmltakU0SHV1b3VBQ01LZjdma0x0c0lKMFZodS9SNkpXc2hhYWtGL2dE?=
 =?utf-8?B?MGJMMW1IMUdPdy95NEx3T2JFdXlIdHRLOXkveVgrNUlUTTcwQUUydGY5c2VG?=
 =?utf-8?B?eGFNL1VLNHJkWE05R0FUN2dDcEdlUDBVa1dFaXNoYnZXUXBKOXVQdjhFeGFC?=
 =?utf-8?B?ekk5Snp6ZDgwT3FGeEFaWG1iS0NER3VDU1dYTG1jZnFGcUxCRk0rRUpJNlMx?=
 =?utf-8?B?UzdMOXJVRER2VGRKWVFPUlBDRVJFUExkUXdwbENhTTFIWHNaWXExMTFLOHR6?=
 =?utf-8?B?SGtNV1Q1b3RzRGVYRnJQV016enB2RXIwZ0loL2xzbjkrbldHSnlWcE1RSXIz?=
 =?utf-8?B?MDhseE1KRE9TT0lSTEhzOHNySWVDdXR3Q2IrQWJ4UzZ2WnlYVXQxK3B0S2tY?=
 =?utf-8?B?S2srZmVscFU4aXB0NTRxRWFEQWV0RGJHL2tCWndJaktVUi8ybmVVZ1h5WWZW?=
 =?utf-8?B?QUtkRWhjUDA4QlNRb1NXMW4zMzBPSVIrV2JEdXdiNUxBUDE5RG1zTnYxWW9K?=
 =?utf-8?B?UE5uR3d6dGdOS1M0d2JIeHo4WWVvY05aOHVTbkswdnFCeG5VbGhzb09JQmpZ?=
 =?utf-8?B?R0JRR0RJeXZQQlJITm4vT2VzSVgvMWJoWGtrMG52bGtXcDNHUGszS2VwVHBV?=
 =?utf-8?B?WnVMU3BySGMrVGNRcjc0bzRKOVFTOE1hVDk2MWgvZXBtSU43em5TQmhnZ3Zz?=
 =?utf-8?B?YUR4UDgyY1JsQ1lUUGk4aDEzWnpuQ1NlanFVNzJkYXFmVkhaRmhKbnFkYTBK?=
 =?utf-8?Q?FUu9fwsZrvoP6D0yuaib/9XeM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce086ffa-3d53-460f-16b1-08ddb3f6712d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 14:42:00.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9Z3u1PXfk8g5Ms+I108lKV256jIzw2nj5XfquybCM1dLyKJEbsrcPfPAE0i9LlOBI1nxUy8Jt02JKoYrAcz/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263

Hi,

This pull request has three patches for net-next/main. Containing
general updates for the mlx5 driver. The two patches by Dragos
are preparation for an upcoming series that will expose PCI counters
for mlx5 devices.

Regards,
Mark

----------------------------------------------------------------

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to 1f6da56679d33c733aaee929fd9af962ad66edbd:

  net/mlx5: Add IFC bits for PCIe Congestion Event object (2025-06-25 07:34:27 -0400)

----------------------------------------------------------------
Dragos Tatulea (2):
      net/mlx5: Small refactor for general object capabilities
      net/mlx5: Add IFC bits for PCIe Congestion Event object

Patrisious Haddad (1):
      net/mlx5: fs, add multiple prios to RDMA TRANSPORT steering domain

 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 30 ++++++++++++++++++++++--------
 include/linux/mlx5/fs.h                           |  2 +-
 include/linux/mlx5/mlx5_ifc.h                     | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 79 insertions(+), 20 deletions(-)

