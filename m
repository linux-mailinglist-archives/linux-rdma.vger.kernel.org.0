Return-Path: <linux-rdma+bounces-8392-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DFFA54021
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 02:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E877C16DAF8
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 01:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8422AD13;
	Thu,  6 Mar 2025 01:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ywni1/I+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F622179A3;
	Thu,  6 Mar 2025 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741225716; cv=fail; b=WTUfvgl3hYwURt5X1rRs2KJbIWxporHUEIAiIz7PHvXPNr89QR20MS2iqeKkr/kYz/Ozc6nafmhnqABxub3Wuv1OdWU0cHfeezPkklf3Hk3WE2ifJ5OkpkGYhhmeuhPxxLcxLBOGxbnkDtTv64xCKYEAVpkObhM6sZqC4hJ83EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741225716; c=relaxed/simple;
	bh=zRDZ0I2vKsfsYQgRXKx6JTL4cBYtdPQU3/0AXPUq5jk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WjZ5WmNh5+Oz2MEOcfNpzIx+j0QTPeSKO3LQdINuQmiNBZCftR6FNWjheX6nUvODcsbsdOYm7QLi9Vq5mihVG6B3uzMl/Wyd91DdSoI9/Go4+k5ssbbaKKuaXkcKP+3SFeV5bUcvmkVt5N/YiTCe2ZnK7lrFYEh8QfDQfs3XvcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ywni1/I+; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcUm7jq1ptwZlnKF8u9LOf5MZvucLwACTHi3+SkTZyF8rLLIDVqdKSgHqv4r1aceaFIAXLsRCjwnE8OwhElEYX2vUbLm09G9NAJtcdTP0oa6t3RaMV5FiJWnZmAw+gQaE0Wtmsihfdu96Z9fleGvZt0RAmfdt+6aOwIGlykTqRXY5yrecEVnyNQWYUP+JL1dYVRJug/rOYN3xjlFdZiz1Ps2u5cxdSa7A/MG/KxmgmBex9bQcdN3ZQUO6KHj8podPnWF4jphWvqBuRo+GSLL3ewBL2OJWoJPUvHWoMHggRRXvy6TAtBMEyT+xae03DfjtjtNnlkuOB6elAC5wg7g8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNri1gKX4mzaxCk2+6S1yC7suXVGvzhY1gZLcUmobDU=;
 b=GWtPumHHzgR8WQjBDYxjmp4QD8f2PzQ/eKB55x2jCf4Q4iq0J52fCUdBfEJiAfOqRBVvpNxPtWKm2xLfqSn7EcJDMbgL/mDGO3C9TSnwOhXXxL3Tsi82WADwOWkEZjTy5PCjGbNzytRr75jMuc7iQ4YTjCRwk4QH8jMGYDd/vMa/cvCt3uh+2o1m3M6iYtWfHeVPrYQnGnur8COY9/gloTVmverQuzvHzkgFQouQWtLo/LJ3R2JmBdgkbL2wH4NWHHCOZuhSgd2rQhS25K0B862pmAPU21ty2xu/9mRzQAHKSBniUjKAjor/MX5AQ75Y0pyiBOOucT9jy5TLxmqC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNri1gKX4mzaxCk2+6S1yC7suXVGvzhY1gZLcUmobDU=;
 b=ywni1/I+evgQw7n4IPV/Sqn7ualTR9Af2Zv6xp6Ts/S8u8862++Q9hesAKdDniT1lCtDJjWfCHTfply7bKAUZXZH1yxMqUevwiAsaA9SPHjk5+TK2rKUfEHNiDBmuTy664u/3179tLCo6pcGOaqPzgQFnCZ5yydzRzYYDcQMlEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 01:48:32 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 01:48:31 +0000
Message-ID: <4852e263-dc4d-46bb-9fb5-cd78d7f8c553@amd.com>
Date: Wed, 5 Mar 2025 17:48:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] pds_core: add new fwctl auxiliary_device
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gregkh@linuxfoundation.org,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com,
 brett.creeley@amd.com
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-4-shannon.nelson@amd.com>
 <20250304160321.000038a0@huawei.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250304160321.000038a0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: ee33f0e3-360f-4133-a9a7-08dd5c50ffc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXBnaU8zTDBXdWM2TEtTTFlSUm9Tcy9BTGpFWVNPZTlpWjlHSFFJTXBFbGh5?=
 =?utf-8?B?QlF6VXVlYTkwVVJFSFFFbkxYTXBLdWJtZHRTditOMHErMWtYNSt5dmNnK0hn?=
 =?utf-8?B?Sm03VElhY0JhRk9UT1I3ZGk4ZnlsdXZ5Qkc5S2YzUlVVS01ybElXV05UR1JB?=
 =?utf-8?B?dVZJcnN3TEVsd210SHBoQm5nSVR3ZHhzQVBqVDVCRUt5cjBXSFZWK0dPWTZi?=
 =?utf-8?B?bEY5UHFWRUJzcGEveDZiWk1qUklUbEVoWnVLSXFuczBmeDhzUDJjeTRYYUVa?=
 =?utf-8?B?eTFJbFhVQlFsMVREeUpneCtrMEYvb0l1V2RLNG5Mam1wV3I5T2RseUVZWnVs?=
 =?utf-8?B?SWJTTklTZWxpazJVTkJhaEpLUjFnNjRhbWJPcFRqK3Y2STl1K3dRZDhxejVL?=
 =?utf-8?B?a3pxMjUvMjVNWHJKU293aUJwOU9LZEp5aGh2NlB4UFVicVBzR1RhbkdSVGUw?=
 =?utf-8?B?SGs3ZThJaldWcEJiU1JzNmJ2eHhTbUVaM0FZZnYybFBTamd1TENOa3RMZkZI?=
 =?utf-8?B?M2k1b21wb1JXdDBZSUh0ckR0MVVaUlVkMkVJNjIyY3d3U1J6Vnk5NDVXNGVP?=
 =?utf-8?B?UHBZMEwyNWZpSTdVVzBFWTZ2VkMzY0VuZDZvbUsyMU53c0hBZnpYZFQ4U3E5?=
 =?utf-8?B?TCtuVFZlRlJITUxRdFBtTkdRYW1wSy9oa1hYUll3SmVwaGxNcUhtdU91TjFr?=
 =?utf-8?B?NWpOd3N3V2VtRXZtL051TjZpaTZEYVE0RVFGdFBkMEI1MlBicm5IdjlaMXRQ?=
 =?utf-8?B?MUJSSElhL2ZDWlpFRFlvNVBDTisyQ0pTSk5iQWtVSGIyZGNZaXhkeE1qdU5E?=
 =?utf-8?B?N21VemZhemRleE90ZS9nUkZYem9QSnFsaXhXZUVyZmRQaFdvdG5oYWpkdExJ?=
 =?utf-8?B?TS9EdU83VGFYdE8rSmdQMy9rT3ZEZG1ldkFPZFo4NUM0QzdxN2tjdSsydi94?=
 =?utf-8?B?Y3RCOVFwN1BnZ1BpdFN5bkQvdENwWm5XcTdYbUtpRDRSVVdISkxRUHR2Miti?=
 =?utf-8?B?Zmo5VlY0bWQvN2dIbmhjc0FKUmxEeDNLa0kvZk8yQkFmcFlNUm4reXJmNlAv?=
 =?utf-8?B?ZXQ1ekFDTkpDK2RYcS9LQ05hdmFEZnFSdkN0MHdQSm5KYmxZaTBpUUN1WkNH?=
 =?utf-8?B?dkNnemk5V1JjR1ZYZzNJR0o5L2xhNlpVTjVHNGJSczJ1cUt4Q0l4N2F2bWlF?=
 =?utf-8?B?cXNCNFA0cVhZSkRKWG5sNGlrOVNRQ3VlL3JmRFJicEY2aDdQbmFUa3RxazZE?=
 =?utf-8?B?dGRzcTFiTHUwdUpCRUVXRHNCMTBpbTZreS9wZjBJUE9TN1FZWWtPZGFjSlcw?=
 =?utf-8?B?TnV5K1ozSFowRHpRNkVNRWd0K0swOTFzMmdVa0hmRjF2dUJSQUJsMGVYTWZk?=
 =?utf-8?B?T2JmMVlCTitYaTRBYXQ3WmkyRTFObUlMQkIxdzVXK1dOaXkrSHR6NFBSMkdK?=
 =?utf-8?B?ZGRzcjUrK1p4eGVva3J3MTMzQzVHZkc3eklyc0lxUmpUY3d4Q1huMFcyOSsy?=
 =?utf-8?B?RUdHZVVIRWp2UkJuUnhzeVEyanZsNmdTTkswcmwwS0RMSlVCUzFQWEFsSDdu?=
 =?utf-8?B?Skw0bEJlMGUvNDE5VGJTczgvYVZaTGJmZ3pkTk51Ni9vbU5vZmxtbXM5aGFP?=
 =?utf-8?B?WDFZZzlrdmNiMFg0c0dsNCt6YjRxVEI3OG45VWhJa21EWlp0elZsc213STNQ?=
 =?utf-8?B?SXlGRE9ITFZlOGRUb0tyQ1JJL2k1SjhHMUxjN0IyMWM3YXY1bDV6Mm0xeFdD?=
 =?utf-8?B?bXpsSm9mcFdPSGxqZ3Ixbks3UGx2ZFk5QnNOcjRSVkxNdzhkMUN1VGdKamxN?=
 =?utf-8?B?UFVlRjgwTENOMlRMRzRybzZITnJHaGlIQ1c0RFJDWlUyMnJPbjA2L2FpMmQz?=
 =?utf-8?Q?teyXKNjvQ+Oz/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFRlUUI3cUlmbU9LeDVQSVEybkFMUnM0LzQveEI1SGU3T2JvZmlUYmI3ZUhp?=
 =?utf-8?B?VXR0SU1QaTl3MERQbWpmTjVkaW1zbC9Kb0x6T1RoaEZLbVZ4dFhOSUFMUjli?=
 =?utf-8?B?bHVlczhPSEJYZnQ4andqbEFtbmd5ZGZnaVVON2VmakRuSEhwc1JwcDJ4Vlk1?=
 =?utf-8?B?cXpwZUJFRHdrWmRMSXdNZnZsY292QUs0NTZEc0d1bXFWT08xc3NydHY0YVl5?=
 =?utf-8?B?Rzl0Z0krWWs2VjJTN1JqZHZCbm1wc29IZ2QzN3hPSlhwTlMyNC9TMDNrdEpm?=
 =?utf-8?B?UWlGWjN6TVJLKzhxUFhURUtyUmlSZ3ZGRk8ydnQ5SDNlZ3ZpUi8vZkdiRktF?=
 =?utf-8?B?WWtkdkpXanJaVzdwTEh3NzdqamRZcW9yNVY3Vk5pMW1aVVM0cU90OWJyc3ZY?=
 =?utf-8?B?ZktQblp3NUQwYU93bFB6UWJaaVkxUjZ5Q0pMZ1FicTRGckhmQUdnbXlkdzdo?=
 =?utf-8?B?aDN4cmlaL25nSGk4Y0tJTDRrc2luRWZEQmovZk9yckgzSzhKNmhGUzcvRVNJ?=
 =?utf-8?B?dHRDR3hTU3FSaENsdjkwL3pzaS9pdUx6VzBFRk81aWk4MjdXMVpRVFkydVhy?=
 =?utf-8?B?cnpmRlBWcU9CMnFKOEdOK05kdFJyUDJZUjluUzUvV0JQckFTVmVOa0JFeUlB?=
 =?utf-8?B?MjNURW9xU3RUVFRQVDM0cCtKOVhTT01SZURINWN0SHQ2WGw1WmpKaG1IOGY5?=
 =?utf-8?B?SDhNMmFDcjlLcnc3TndVbVBpdHlJRlF5ekd3Ui9JaWlPWUE2bnM4VmpBaTJo?=
 =?utf-8?B?MzFvYXJMaE1yQ0pmVHc5UUpvcitsQWt5L3VaTXhVY0pNRDlCTWgweGVpODZn?=
 =?utf-8?B?aFRqbktMOUdPenVrbFdRbEtrdjl2ZnQ3WGxoMmg2LzFkMC83ZUFFbURkb3Y1?=
 =?utf-8?B?WmVUazhKb2JJbm14TTRRdTRqbDVLdmcySWZDMjE1UkJLZktxTWtFNkNSRFAx?=
 =?utf-8?B?MzBha2RIVUhHcmZSQTVyeVFZRGUxUjNCc3Rkc1NnMU13V3lSeVhBY0ZVUVJV?=
 =?utf-8?B?ZC9TRkhhMDVUVy9TcDkyN05nMUYvaDVMV29VK3VNZ3BKUlZxNmdzYlVEVUVv?=
 =?utf-8?B?Q2w1cllHRGN2VU10c2k3bC9VelVGREg5YWdtM3YrTXFzeVNZdXhjMk5GTE9Y?=
 =?utf-8?B?L250STF4djhrd3kvbWR1eXptTG9DS0FYMzNpSXM3bTIzVVBkRDI0TWVycmNy?=
 =?utf-8?B?VDYyTnhnZDcwM3hZVktSWmxRcDZSL0hsS1pOakJMUmZLT2NReUZFeGZjSCty?=
 =?utf-8?B?OXNQRmNDNmZtTXU4OHRSK2o5WlQvdTVIK0poYnVKQiszVW8vbXNnQVFYek9L?=
 =?utf-8?B?QUZlN1EraHdCVlF5Z1VzSWVKVkQrd0Y4KytrKzNlaGdUVlI3cklHOTNlZ0ZO?=
 =?utf-8?B?NDY2TnMrRFpGVGdySUovZmNKbExkK2hneE1JcnNicEhtdHBsM2xDTE1JZVhS?=
 =?utf-8?B?T1NFWE9NMXowalIyY3hFQjJGQ1ArckFrVHNDMzU1cDZpUEZXRFYvZmltS2Ji?=
 =?utf-8?B?VjY0WWlndU9qVGhva0xCSDdHcjd3S1o0Q2ltWkdQNENnbSsvMFo5bUZ0K2hy?=
 =?utf-8?B?a1RQeDhrcmxHanNZb21pUXY4c0wrZ015RmhWUnRNZFRqWWhNU1U1Mng2Y216?=
 =?utf-8?B?QUhCaVNVN2lWeit2bHFyVWtaeHEzNHhZZVhqZ0lDZ1VWc3AxLzZic0M5a3Ex?=
 =?utf-8?B?THJaam5uWUpaY1VMRUhwYVM5RHlac1FlamZzdVFCZHZBQkk0UFJsT1RrMUJ6?=
 =?utf-8?B?YkdkbGpnSnF1eDgxZ2xuRytsaHdFQ3VsRmN4VGhQTWZ0M2p0aXc0eE5PL2Fu?=
 =?utf-8?B?OHpyZzlKanVqbjNSMWU1YlkwMUFsNWpXY3k5ZFZUV3YyZnBoV0NYUE5XQnRl?=
 =?utf-8?B?MEZzTmtTR2JCRU44Q0svY2JZSzR1QlBHaG8wVkdIYllaa0hnVnpFUy8vTXFD?=
 =?utf-8?B?cEQ2c1kyWnY2ckhhL1RZUFl3Y3hzSU5ESmp5aFFuclJvQi9aNFZTMlh0R0ZT?=
 =?utf-8?B?UTFma2tsTTlUQ3hiTWtuUTBXV3lUY3owMW9wc3N2WFRMSXZYYTdlbmREd3dl?=
 =?utf-8?B?V3kzSEdab0g1ZHRZTHF1NkpxVldqNmQxZXlmbUtFYkg0YlBmR3BTZnRjTzlX?=
 =?utf-8?Q?DHL2Fr3P1+hmBgqpXctW07BF8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee33f0e3-360f-4133-a9a7-08dd5c50ffc2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 01:48:31.6395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiNzCxGMt08ueGmUbEDl97dxdLr24c/cbKCWFaoSt74ajz26eFiA0SiPaJvv+Bs72vS9nYD/rsVN+4mWrQjoLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316

On 3/4/2025 12:03 AM, Jonathan Cameron wrote:
> On Fri, 28 Feb 2025 17:35:51 -0800
> Shannon Nelson <shannon.nelson@amd.com> wrote:
> 
>> Add support for a new fwctl-based auxiliary_device for creating a
>> channel for fwctl support into the AMD/Pensando DSC.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Hi Shannon,
> 
> A few really minor comments inline from a fresh read through.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>   drivers/net/ethernet/amd/pds_core/auxbus.c |  3 +--
>>   drivers/net/ethernet/amd/pds_core/core.c   |  7 +++++++
>>   drivers/net/ethernet/amd/pds_core/core.h   |  1 +
>>   drivers/net/ethernet/amd/pds_core/main.c   | 11 +++++++++++
>>   include/linux/pds/pds_common.h             |  2 ++
>>   5 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
>> index db950a9c9d30..ac6f76c161f2 100644
>> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
>> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
>> @@ -225,8 +225,7 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
>>        }
>>
>>        /* Verify that the type is supported and enabled.  It is not
>> -      * an error if there is no auxbus device support for this
>> -      * VF, it just means something else needs to happen with it.
>> +      * an error if there is no auxbus device support.
> 
> Comment feels a bit general. Is this no auxbus support for this device
> or none at all in the kernel?

Either one of no CONFIG_AUXILIARY_BUS or no fwctl service from the DSC. 
I'll make that more clear.


> 
>>         */
>>        vt_support = !!le16_to_cpu(pf->dev_ident.vif_types[vt]);
>>        if (!(vt_support &&
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
>> index a3a68889137b..41575c7a148d 100644
>> --- a/drivers/net/ethernet/amd/pds_core/main.c
>> +++ b/drivers/net/ethernet/amd/pds_core/main.c
>> @@ -265,6 +265,10 @@ static int pdsc_init_pf(struct pdsc *pdsc)
>>
>>        mutex_unlock(&pdsc->config_lock);
>>
>> +     err = pdsc_auxbus_dev_add(pdsc, pdsc, PDS_DEV_TYPE_FWCTL, &pdsc->padev);
>> +     if (err)
>> +             goto err_out_stop;
>> +
>>        dl = priv_to_devlink(pdsc);
>>        devl_lock(dl);
>>        err = devl_params_register(dl, pdsc_dl_params,
>> @@ -297,6 +301,7 @@ static int pdsc_init_pf(struct pdsc *pdsc)
>>        devlink_params_unregister(dl, pdsc_dl_params,
>>                                  ARRAY_SIZE(pdsc_dl_params));
>>   err_out_stop:
>> +     pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
> 
> This doesn't smell right (by which I mean I had to go look at the
> implementation to be sure it wasn't a bug) In my ideal
> world that should be obvious on a more local basis.
> I'd expect a new label here. pdsc_auxbus_dev_add() should be and is
> side effect free if it fails. That is it should not make sense
> to call pdsc_auxbus_dev_del() if it fails.
> 
> It isn't a bug today as that becomes a noop due to
> &pdsc->padev being NULL but that is a detail I shouldn't
> ideally need to know when reading this code.
> 
> I'd put err_out_stop label here and rename previous
> one to err_out_auxbus_del + replace the existing
> goto err_out_stop;
> with
> goto err_out_auxbus_del;

Yes, I can break that out to be more clear.

Thanks,
sln

> 
>>        pdsc_stop(pdsc);
>>   err_out_teardown:
>>        pdsc_teardown(pdsc, PDSC_TEARDOWN_REMOVING);
>> @@ -427,6 +432,7 @@ static void pdsc_remove(struct pci_dev *pdev)
>>                 * shut themselves down.
>>                 */
>>                pdsc_sriov_configure(pdev, 0);
>> +             pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
>>
>>                timer_shutdown_sync(&pdsc->wdtimer);
>>                if (pdsc->wq)
>> @@ -485,6 +491,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
>>                if (!IS_ERR(pf))
>>                        pdsc_auxbus_dev_del(pdsc, pf,
>>                                            &pf->vfs[pdsc->vf_id].padev);
>> +     } else {
>> +             pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
>>        }
>>
>>        pdsc_unmap_bars(pdsc);
>> @@ -531,6 +539,9 @@ static void pdsc_reset_done(struct pci_dev *pdev)
>>                if (!IS_ERR(pf))
>>                        pdsc_auxbus_dev_add(pdsc, pf, PDS_DEV_TYPE_VDPA,
>>                                            &pf->vfs[pdsc->vf_id].padev);
>> +     } else {
>> +             pdsc_auxbus_dev_add(pdsc, pdsc, PDS_DEV_TYPE_FWCTL,
>> +                                 &pdsc->padev);
>>        }
>>   }
> 


