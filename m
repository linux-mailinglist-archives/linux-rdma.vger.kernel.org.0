Return-Path: <linux-rdma+bounces-8393-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F25DA54029
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 02:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DBA3A9E11
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 01:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F621865E3;
	Thu,  6 Mar 2025 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ocSqCcsP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36642AD13;
	Thu,  6 Mar 2025 01:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741225968; cv=fail; b=cE6vxSpIC1m0G2l+IkxA4uZHEF0JDq4SPYa8ghdQ0nHscuGSMadkO2RmERihgD3PZ/BhbvTiQZCuaKQV6YCJmMGD+wlRN6+0cShuvIO2tlkvszv342VCKqrG6kNK171HuLmZMtYSJv/1bAB+I95Ih8O1tGaNUI22si4a+DIAaBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741225968; c=relaxed/simple;
	bh=EPNlcDIcYn94cFMT0QqFrQf8fSrUogL84UvTuZEcRFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hjuunqm03lE3f8RKZd8iTSRE0KudMLtGnthjb9gwzxfeu2Yhtp2cRpuGGjuhSMhHxhJs+0ziMzUdFMua9ltbRB9jHvX95tGhtG0yPQEuJaNVFe5xpZJZYs4O928jBu99W4GdzUrHze4g8xzrDMZYMo2uuR6FEEWJfR+KWGSw59Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ocSqCcsP; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xd9JzZhqQ/6KIbSv6nCQFWcTndE91zP2A9OQtCY2/L49vy1IeEXKylSijdccwvopiqaNq9E8ZnhO424tYE+9BBSG+RSV1Ew2IWzn/ERIrRFkYHH4DZF4rqMBDJEav1A+ZB27tj45x/iJM3QOYA1u0319MpR9kdAaxhrnOZHDOm82gxAl4hN6/ZlxmTmZtUHbIqWPMKnp/3y+gn7phHnrsWLmHAPoLLaaCXQn4EWXu0x0FLGA3kRP7CFI3x4QgyC28+flpq+1i9MkebBC3rlobnDBMZzhUxIFiX0jqxfFRsq02qAyUlt9vkvoAHx/N5pm6OOQwRwXTgKYm3/AcyXBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28Z9+NjRMHUOVJ9Mhb5T4+ZuAdm1jDjAJXWJEYWljXw=;
 b=NS/RhXqhpD0pd+tpJKJba+qYW1n9kwkEFQ/omoJOWma53WQXeMIbtYS39EBKxz9cNLl6wu4gVjlgP2VfXC7SVvX2QwxiAovkKxt7kRJnvhNzs5ynd5dL79B6fbi9VZTdE7RgjiQNFpQpEr8a6a/7fM/z0Q44rctiiioFcbfi+gETp/jkhRTk9DYLSOaYpTYdvv2hGdHcg0Em7wXGj4+GHG9t1kRHlJlnW1kflz0DBfqUY2EIVBYxqwLcFHmRb70q+E30NDpg2s5aQPpyJsOlbbaApUZS8GwioRthDzg3uIoTy799zLeLXc0cWElSExscBI8zO0YoFCbQBEVMC/QwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28Z9+NjRMHUOVJ9Mhb5T4+ZuAdm1jDjAJXWJEYWljXw=;
 b=ocSqCcsP7z9NqZS/oRD91QdfWrb4g8d4PhEpwDC+dFmZ1Fp9qTMK+wZBG+je3P/wTx5kcPAXj8sy1pDTgZSq6eyU2P6EknEjk2FggQ7sAjsVPiIS+NM+S8GEkHyKXYiWkgL4WWsBzVAB7reDN8QBK0TCkbEN5T8hX5egdksp0l0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 01:52:43 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 01:52:43 +0000
Message-ID: <7e706344-2f7a-490c-aab1-a3e55111cd23@amd.com>
Date: Wed, 5 Mar 2025 17:52:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] pds_fwctl: initial driver framework
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gregkh@linuxfoundation.org,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com,
 brett.creeley@amd.com
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-5-shannon.nelson@amd.com>
 <20250304163043.00006b34@huawei.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250304163043.00006b34@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::6) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: 43345007-1022-434e-5748-08dd5c51960d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1MrNm5CMk5xdFRjaXV2UEZUVGJnMUo2d21qOU4wV1V1TzhGMHpwSVRnamNB?=
 =?utf-8?B?R2x5ZThWN1c2RDN4czBNZGFOZXZjUmNLSGtuN3hQTE1NRmx3UVZBeUltdzdp?=
 =?utf-8?B?cGlHTXZWaFcxRzRSTW0rSjBYK3VhRUN0Ny9qUHdoczRtL0FOWHVkckVJVUtZ?=
 =?utf-8?B?d0xJS2xZbHRPVHVNdDE3V05XRngzQzRhb1pjUzI4eVhtemQ5d1hlbG16V2Vj?=
 =?utf-8?B?a2JLWVhpR3lySmVLTWxWQUJTeHlCUW9COTlOQUUzY244bmlOcnMxb3U2MXU2?=
 =?utf-8?B?MW9Da1BMc2FoR3pjekdHSnZrQzcyNXpYZ3UzbjNqRHlJMHVIOFdtZVc3VHpn?=
 =?utf-8?B?bklvemVtVXVTUDJYODZjaCtiSlV5eWNUb0ZWVnNUSld5aDhQSDN4cjR1Y3or?=
 =?utf-8?B?aE9TSE12aCs5MWlWR3V5UWUzNGlzd2lnblpST0VmZ083YUFKSlNTcWVIUHJR?=
 =?utf-8?B?S2tndEJVK3lpWVAyMlBTUDdpS05rdG92SHA0cExGeTUxeVRQN21jM1JETzVF?=
 =?utf-8?B?dyt4d3cyYzFhTDYzOU5SdVJuUUxjZktCbUt3ZFhDa1FxcjZyTWlJZVh3Y3dJ?=
 =?utf-8?B?cVJ3ZFlJWEZyamRuOVRRR0JhRjVZMHF0YVk5VHBGRGZrbWNhbW9Ja0l2NDdS?=
 =?utf-8?B?ckc1enh6eHBzUzZIbkRoSXhsQ1puMlUrZkNSZ3BuOWt1VE90dW44MkVGM1kv?=
 =?utf-8?B?WmF6VDVsWnZTSHR1bUZKUjl3SlhuTk56OXlPb2l1L1Q1aG4vTHNyVFN2dW9Y?=
 =?utf-8?B?dlZxaFdnaXFmSk01dzcyNzZTMlFqODlzSzl0czVVWXlNc3pIeEh3RnV6a0Rt?=
 =?utf-8?B?Wk9zUWhIYW03N05ud0xWWG50cVdwemZNNHV5N0VZNUdXYmJvdFhmQTE0Q2tR?=
 =?utf-8?B?akdrYWEzcy9UUWdZSEh3K09XMmtoSVpZZE41TUNpQTE1SmsvOGhPNHIwZ240?=
 =?utf-8?B?MUNvd2lMaklRdHJvQUdXNGNXQ0VJa2dzZ01TWGdwSVUxa2RXVW5LWkd3Tkdt?=
 =?utf-8?B?QkxIamhNMkFEb0pBWURrZ0RGRVVid2p1YVlOSzRQc0E3T3FZdmxTekcvZHNI?=
 =?utf-8?B?SGpEai9Ub1JDMG1jY1Fia1hQYWxJV09ZcUxUU29ONTBPNU9ZZjRXd05nbGpF?=
 =?utf-8?B?TVhldEZhSnRXa0p5S2NtTDhhVGt3bkM3MHkySEM0cXRad3ltSXg5MUN1bytm?=
 =?utf-8?B?S3N2TGE4Q3BCd3NEUmxaQ3Rlc0VYZ3piK0xjUWNEdG52SWs5bWQwNzA3L3hY?=
 =?utf-8?B?NHdUQjQrTHZGd2NyQWFiM3pudXIydFhnSlQ5Sk1HYk9ScHQxVXMrRVdBcll0?=
 =?utf-8?B?V3B5TFBadCtuRTErZmlsdEZjd0dCUkhDUURFWTdYOVBhT2lxdUxQM0lWaW9L?=
 =?utf-8?B?TnVvZ2N2NXJNbUFpZXRiSHlOblkxc1JYS2M0WS91bkZkN1NUV3c1WWI5TWpi?=
 =?utf-8?B?aHkzcFVRSVRMclgyQ0xuZHgzZTZ0M1ltenE1WUo2ZVYvQWtJdHk5R0VJTXpx?=
 =?utf-8?B?MXRoc1lTZFFWUGxQSFFyVnlXNGVtWWZHK2RQKzVaQmxnbWJLSmZ2cVV0Z3ZO?=
 =?utf-8?B?NHNVRG15MzU2K3V1VGJhUjdhMXlmRWZTSkx3K3BxR0wwRXRwRThXQWFOUDcz?=
 =?utf-8?B?d2FEQ3ZacGhuODJGWEMvZDk2UlRheGRNMjRRRnZwQkljRDNqczNvNW5nS1p2?=
 =?utf-8?B?U0wyZ1lwckI3MnZvY3FhMUUwc2NqU1lHZlpiTXpsOWQvOUlHaGVtVWZHcUpQ?=
 =?utf-8?B?d2ltS0hLbmM1L0EvcWQwSm8xZytMdk1zSGJoK1FwZ0YvZFh0N24vZ2FweFk5?=
 =?utf-8?B?OVdRTElPNW5zUldxN2RveTB2a2ZKR2JZNEZSZ2syQjk5cVNncHAycHhXZENK?=
 =?utf-8?Q?x7jVKe9NhzdyV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajhuSXY2a0hQWitvMVNoRmF2OWFJUUxNdytyOU9GcTkwWlpXZVVYSjRMWmFC?=
 =?utf-8?B?TUs4UW9mVlRSNW0yTG0raUNZRzFFKzBUS2NmVUpUTGk4SFM5ei9LWCtmbGc4?=
 =?utf-8?B?dmNOREFSMVI1aXdRRUYyZWxlWFhUeWlJNDJubUNwUG96OTJtUHpEUmVYOXdz?=
 =?utf-8?B?dUFFMmJhM1VsQzVQaVJ0WElXVDNEUWQyd0QySmZsYVBiZkNNNDlYWk9yUVBx?=
 =?utf-8?B?V3Q2QjExQlRBbEgxSjlYU1hxdW0zR1pJNmNIM052TVQzR3BPU2JKWDNDRnoy?=
 =?utf-8?B?Vk43bVk0ZE1rMnFLNDlIM3lSOGpVc0g2VkxBWWQ3RUlPK3F5RFRncC9QTTQw?=
 =?utf-8?B?T0V4OWFpcXl1em5TUFpxWUlIN0lScDhRekNuVlJCNDFxbFYxR1lNNk1taUJI?=
 =?utf-8?B?YzJuTkJIVU5RbFh4K3Q2UW1ldWIvd01BYjlmbEUyOUorMkZUUlNORDdBWjh2?=
 =?utf-8?B?Q29UeXUrU0hZcGpPYitjSU12SHVlQWZweVBtd1FoYXFqSDlDSWthRXBGY0Iv?=
 =?utf-8?B?NkNYS3dYcjVDcFY5am8rd0pPK3J0cTlpWkxCdTFHZzRKY2YvelE2UXBtVUR0?=
 =?utf-8?B?V2Fqa3hLTVMySFQvSXQ3QmhUQkZXZlRhU3QrdHM5UmZXWWw0cHBpZWRsWmdI?=
 =?utf-8?B?cEdXVWQxUFNsR1Y3dGdhSGltQUNoZzVmL3RFYWxHUThWa0FDd1lmQVBQblFn?=
 =?utf-8?B?M0M5a0RrN2lsQVI1SnpCZTJZaVRiU3dtZnpEZno0QnBTbk9qN3FoQTYyUDl5?=
 =?utf-8?B?Q3ROd3ZCcHNxKy94M3JxTWw3TXpJTUFjL0RyZjQwNE9sWDEvTmpPeFhOc3Ns?=
 =?utf-8?B?MzNzb056THlWcitMQlhKZi9sVGFNUjBRbzNwUlZTbXgvVmFCdm9lQVA2MmQ3?=
 =?utf-8?B?TU1OQ1hVTXk3TmVhc3BKaUxjRTBVK3hCSzJmRmtPVUcrbi9CUnVJNU11NzBh?=
 =?utf-8?B?dDVsRmszakdmb041alp5LzVNdnpGZExqWUFHSGhOSjFCKzExcmYrV0E2QUlz?=
 =?utf-8?B?NGlaam5udkp4MURkWk4rdUFGenlkTHNWOVpGL3hoaXVxaTNHb0NrN2dqaFVM?=
 =?utf-8?B?c1pjWkFodVFuanFaT0xsQ3NISDFXREtsQm4zbHpUVFpQaUthSzUzNHNwU3No?=
 =?utf-8?B?QWpPSkl1RGVLVG9EQ2ptazExWkhvUHR2U1VYeUpHb3R4cVpVdWtCLzJLR1pX?=
 =?utf-8?B?dDJ6ZGhmcjhxYit5TDdLamp6RTdza2NFWWh3QklJVmFOQ1FUNHBGV1NKbkFs?=
 =?utf-8?B?c1FIK3g0KzZJUkFONUtCcHdvLzNoNGJNaHZILzFwK08rTmswNFNBTkJaVEpW?=
 =?utf-8?B?TGt4dXhOUmlRUFUrT0ZjelhuUEVPbFRvbllqQklmdzN6ekxDMFE2OEI2U2M4?=
 =?utf-8?B?SDl5Nk1IcUw4b1ptME4xa2ZydWl0ZmpqRzhGWW5yWkFoeVZOZkxEbHEyYTVn?=
 =?utf-8?B?M2EvZjJkZzIwdUp6bXFvM3JienVEbW9VL0dpb3JhSkNia0VCeDV1SVVLWEFC?=
 =?utf-8?B?MUlCV0s2Y1BUMkpKU3hLbG5YdWRXVEtWYlpHYnoxMlQ1d0hBd3ZkRkdmbzJF?=
 =?utf-8?B?V3h1eEpFMXI2cjFaemFFUm9LanZlOFhDL3lyZEZISXArOW1UYnZqUGRLekpv?=
 =?utf-8?B?Vmo5VEtCSkxEYVBPZVZMc0xtOWVncWp6eFVjcE0zOVVmeTQrVE9SZFNndmxN?=
 =?utf-8?B?Mis2L3dTYmsxcktZT1VYa21aSzhHR1dja1FHSlZ3bjJ5Z3RDWHh5Uk5jSXZl?=
 =?utf-8?B?S1ZSSVdSNFplYkpUQmhqVlhLMU93ckllbG9YYmV2YTJTRk9WTmdpU1VlZGhn?=
 =?utf-8?B?RkdyS2RBWEFDYzNuVmVZK3BVT0FtbVlzQVNOajZQZGFVZTZ5Mis4SlNHcUJq?=
 =?utf-8?B?Ty8xRmxjY0ZZNmF5bHRUK2lBeFVNNjRIV3Baa2FKVytDUzNTL1p5TU1SanUz?=
 =?utf-8?B?VWZqNG9HWExQT1FIOFAzOWtaa2ZFNlNuTmNKL3dyKy93NnFkZzlOdUx2OVRa?=
 =?utf-8?B?ZnpyTmkvNmcwYzNmRzV1dURMazlPNWM3c085OFVSNUZ1M2hNRnNXWGgzQVhp?=
 =?utf-8?B?UTRGSkFlR3JCSzJkZGJOWFhqUGUxK2k5U2hSaGRwZjNUWGY1L0JXVWZISWNF?=
 =?utf-8?Q?rrrJPJlWdhiTnHpGzoYGAjBmA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43345007-1022-434e-5748-08dd5c51960d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 01:52:43.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEmmEEabzAYpZYosGFHPFzrbrG5/F3ncjS66VB8C1kMpn5t9QBLdH9GKeeaKjXu/QT5j8D/HZDjawYDh3mepVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316

On 3/4/2025 12:30 AM, Jonathan Cameron wrote:
> On Fri, 28 Feb 2025 17:35:52 -0800
> Shannon Nelson <shannon.nelson@amd.com> wrote:
> 
>> Initial files for adding a new fwctl driver for the AMD/Pensando PDS
>> devices.  This sets up a simple auxiliary_bus driver that registers
>> with fwctl subsystem.  It expects that a pds_core device has set up
>> the auxiliary_device pds_core.fwctl
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> A few minor comments inline,
> 
>> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
>> new file mode 100644
>> index 000000000000..afc7dc283ad5
>> --- /dev/null
>> +++ b/drivers/fwctl/pds/main.c
>> @@ -0,0 +1,169 @@
>> +struct pdsfc_dev {
>> +     struct fwctl_device fwctl;
>> +     struct pds_auxiliary_dev *padev;
>> +     struct pdsc *pdsc;
> 
> Not used in this patch that I can see.  I was curious why it is
> here as I would expect that to match with the padev parent.

I'll take it out.

> 
>> +     u32 caps;
>> +     struct pds_fwctl_ident ident;
>> +};
>> +DEFINE_FREE(pdsfc_dev, struct pdsfc_dev *, if (_T) fwctl_put(&_T->fwctl));
> 
> 
>> +static void *pdsfc_info(struct fwctl_uctx *uctx, size_t *length)
>> +{
>> +     struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
>> +     struct fwctl_info_pds *info;
>> +
>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +     if (!info)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     info->uctx_caps = pdsfc_uctx->uctx_caps;
> 
> What about the UID? If it is always zero, what is it for?

Early code, thought we'd use it.  I'll take it out.

> 
>> +
>> +     return info;
>> +}
> 
>> +/**
>> + * struct pds_fwctl_comp - Firmware control completion structure
>> + * @status:     Status of the firmware control operation
>> + * @rsvd:       Word boundary padding
>> + * @comp_index: Completion index in little-endian format
>> + * @rsvd2:      Word boundary padding
> 
> 11 bytes is some extreme word padding.  I'd just call it reserved
> space.

This is the same wording we've used in the other interface files, so at 
least we're consistently odd.

I'll tweak these.

> 
>> + * @color:      Color bit indicating the state of the completion
>> + */
>> +struct pds_fwctl_comp {
>> +     u8     status;
>> +     u8     rsvd;
>> +     __le16 comp_index;
>> +     u8     rsvd2[11];
>> +     u8     color;
>> +} __packed;
> 
> ...
> 
>> +/**
>> + * struct pds_fwctl_ident - Firmware control identification structure
>> + * @features:    Supported features
> 
> Nice to have some defines or similar that give meaning to these
> features, but maybe that comes in later patches.

We don't have any defined yet, but we have found it is useful to define 
this field for future growth without breaking APIs.  I'll make that more 
clear.

> 
>> + * @version:     Interface version
>> + * @rsvd:        Word boundary padding
> 
> word size seems to be varying between structures. I'd just document
> it as "reserved"

Sure

Thanks,
sln

> 
>> + * @max_req_sz:  Maximum request size
>> + * @max_resp_sz: Maximum response size
>> + * @max_req_sg_elems:  Maximum number of request SGs
>> + * @max_resp_sg_elems: Maximum number of response SGs
>> + */
>> +struct pds_fwctl_ident {
>> +     __le64 features;
>> +     u8     version;
>> +     u8     rsvd[3];
>> +     __le32 max_req_sz;
>> +     __le32 max_resp_sz;
>> +     u8     max_req_sg_elems;
>> +     u8     max_resp_sg_elems;
>> +} __packed;
> 
> Jonathan


