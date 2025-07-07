Return-Path: <linux-rdma+bounces-11916-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10606AFAAE1
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 07:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FCBC189D0C1
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 05:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E61E262FF5;
	Mon,  7 Jul 2025 05:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eDe3Y8m4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504425525F;
	Mon,  7 Jul 2025 05:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866047; cv=fail; b=bK67IdusG+PNf2goIx+PnSBCk/zBmnhKhG8fcTdRcR+ic9h+VlYEoVuX5xdT32TC34ZlbUkekGr6+pNOyeYO8W2qDaWMXJRWraV1lgP4EOcb2Ugu417PRqZowbz7jlkGqtdcgCpSOp3F8cOYCVLPwA+8fguxnHGzEoJjnbvpP6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866047; c=relaxed/simple;
	bh=5i73bmO5cyN5Bi5qa5/WRKy712cJisWxgTRPQ2Bw8Xw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nb4Ahs2LgBEG7BzGAc2HmGNMHsBNRAA3uSZbLMw9De/oBElLE2roKxrh0qsB6yYqMHmX/MKb3S4Om38/FGykvhxpaxlghyBNGimkxFd8yq/VaNsLkY1PLlojk/16xedXZWhNyLzZ+7GMt4DvADOAeULrmZ0mskkjl10SC3khgKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eDe3Y8m4; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ag5QWmHV6k0CuoONfGfueZQu8kV74HX6hjl0gy282r8LRJq7XUpqfKOAQmSEK3K2ZMgULqekLCT5KYx0y2RsyNG0Z89yF4NGdxM6/bwAAaxHtPvgxpX8Z8udszvQc8ri8bY7+LsM7VQSWCV7xd7lYogKn98fk36cHShxMQ2DbB0nuEn0OIZ2UYT4EEx/vlRASuRzlkdFCafcIwQaDpBB/1aKpfClGyq4dT7pI+pdXjFqLz4XQbbF3lIIFAlbySmJJjz1xZ1MZXYG2yj1Kh+oC+S+xDWcXsLSAtCnCrNtjT/wq9AhAR3k+RMYefEbpylOO9JnSicDZsClq9DAbCebDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fnw1L1AgU6b+2wChtFiIk6Z/1BcltRHNwTWcLP8plX8=;
 b=FVkLqg32t+u8dTqR6IRNyKz25pQUSrcaIM5dxcXH1rDR+nEQCX7vJLN6LgMvlxM307zEJ4jL4bLTkhNZp8o2e3zxvyhvM5oyMjI2cyKDvOas+vGFjOXdjw1hKYKihGlU5ntjFGyWPHZxqNVd8JYo7dsYvS+k2yIzUGxQVgSm04GEbrHCn8ER3z42sOAc/4t7ZtRFuJKMM+Jm1aHz8cIuwVclLeRfBUv3LA8o8Z9fOpWDWboyUsb2Id7DNx37NUuZ9WVDE/fM15rtWu7GlTOPNYJH94u1wL4ugyg0G/Aqszmm9DU6dyoaBNVdXKZxFNjr4u0Gpj84ub6zYOeJae/p0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fnw1L1AgU6b+2wChtFiIk6Z/1BcltRHNwTWcLP8plX8=;
 b=eDe3Y8m4zoSvRuqX6t2ZAdTB00jwqqgDpPCLyuaxMvAYZJJssyyBSgb5afSSs6YMflyhGNIMnIixHpH1zKKdKD2wz+WQcbtXeEKhziPpZ/bSAqR3pgGCoghRYyF6dcSCBMRv6fLwTGovztbCZugoHhnFnTq+6bwASsG6LHKjMnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 7 Jul
 2025 05:27:23 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%6]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 05:27:23 +0000
Message-ID: <15b773a4-424b-4aa9-2aa4-457fbbee8ec7@amd.com>
Date: Mon, 7 Jul 2025 10:57:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 10/14] RDMA/ionic: Register device ops for control path
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, shannon.nelson@amd.com,
 brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, andrew+netdev@lunn.ch,
 allen.hubbe@amd.com, nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Boyer <andrew.boyer@amd.com>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-11-abhijit.gangurde@amd.com>
 <20250701103844.GB118736@unreal> <20250702131803.GB904431@ziepe.ca>
 <20250702180007.GK6278@unreal> <bb0ac425-2f01-b8c7-2fd7-4ecf9e9ef8b1@amd.com>
 <20250704170807.GO6278@unreal>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250704170807.GO6278@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0103.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::9) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 70afa4a1-acd5-4d97-40a7-08ddbd16f375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUJuZmhxZ1kvQzh4WHA1NWRUY1hDcTA3am95RXEzQ25yc0FCVDVjNm83L1g1?=
 =?utf-8?B?MFlxUWRURU9zUTVwYy9wZXI0dzNaNkk4M1g0M2dYaEZTVHgydjZuSkVDbzhJ?=
 =?utf-8?B?NjJRQUQ2QlFVdCtITlZUdjBBc3pYSHl0Y1pKWVF1cW1RK1NDM1d4QTlSRkRW?=
 =?utf-8?B?SW82ZzFtc3dmM3BsWnNRaURLUmVvZVgxZGREM0lBVHlONUtwUUw2M0VlZjd0?=
 =?utf-8?B?dHh1ZWFOdmlUMkptUUo2Ynl3VllrRDU1cng0QUhyeTVxTkh2NnVEWTZOaTF2?=
 =?utf-8?B?eXZWclNnQjlxbW81ZEdocDRKV1pPVng0NUd4TnBKOXkyYjB6M1FMV3JQMndv?=
 =?utf-8?B?ZTVqSFBWMkQyWVk0MmNqQVVrd2h3enUydlNzVXhJYkpVZ0JMbjZEME1vWWtL?=
 =?utf-8?B?MVJpRmt2anlLTjl3Z3ZQUGhGRUR2dVhaZmI5ZlpwRkRES2ZlYXRFUGp3aXFa?=
 =?utf-8?B?dVpCY0IzREZLRUU5YjlueFYwMTl6dkFLTzVlT1VOVDBtcHhsZlB5NlZHVmhU?=
 =?utf-8?B?cUZicE40QngrOU03YXNCeWNHd3o1UVVHMTJKeDhnYS93UFNuendIeE94eVJO?=
 =?utf-8?B?RzRkeXZUMHdIM2tNN2Vla1F5TkpRK3Z3eWFIS1N6OTNFam5QWFh6aHNPekVv?=
 =?utf-8?B?amdvd1RzR29zaVpRU2kxbFVxSTVJQkJ0OUFDVkR5TmxKUmtVdFFqUy9ZdmFY?=
 =?utf-8?B?aGU2VWN0TXpzMXN1T3BoZ1FzMWV4aldraUJOZkxoWldNZGpLaUJqT3BxMjdE?=
 =?utf-8?B?Z1ozZUpPYjk4OVQzS0FlRFREVktvU3F5bml1WW16ZDY5dFFhT3A5MjVWTWxw?=
 =?utf-8?B?UEprNXpTWk1NRW1sNXJrOW9NSStFWGZPNUkwMVNJeVpvdFZuVGFUcy9rbzZl?=
 =?utf-8?B?UllEWUZSdkxIcTlscE9KKzJvTUxJWnZQU2tIM3A2dFNhMmZrYXBSVmtJL0Rx?=
 =?utf-8?B?WFJIbkJmdlIwSGg0MmVnWVlaekJOZUMzeFNrd0srQXFWcWdoV3l6WkExYmxa?=
 =?utf-8?B?Z3FBK3FJTzFDTzBqalE0eXQvVW1ObGt6MVFjeFdSSmVJeDdjTnpFUGxJckVN?=
 =?utf-8?B?OXVrdm5KZC9wejl2WDJiZ0I1akpaaUhTdDFqTnRlRkRLa1hRcjJnb2hQK1U1?=
 =?utf-8?B?UmpyUTd5cVUyWkhCWGdwaHlWblJtY1JTU1BVUFhqWVNtalZiaGRDbHEybUJj?=
 =?utf-8?B?aEd3TWtzcXNsSWRaZG1LSG4xV3JoZWxjMjJRcTF6WE9yeWxidVRlcVdyMFVF?=
 =?utf-8?B?ckZvS0doNDBpUXRxUllVTEZTRk54WmgzVFZpYWhpSWY3d21BaFRQZDBPSHNX?=
 =?utf-8?B?ZlVmQVg0bjFQdjNwSjFvcGQzZ0JHMTkySzhzMWdZMWo2ZXhVMGhwbkVkMnBM?=
 =?utf-8?B?c294QXcydmFNanUwZ1NyZm9tMHNkRCtTcFB1d2t1SGNnQlZ0WGd1ZGtRN040?=
 =?utf-8?B?ZDM4S1dOQzAzb0ovLy9aeVZKb2NUV3VqcU40RGpheVc3OFFRdThxdmFsMklV?=
 =?utf-8?B?RmNGT043UDQyTVY3eWh2ZXpIRmJjVmVlV0NSZ0ZPTXB5VzhIRURUd05GTFZk?=
 =?utf-8?B?MG4vUzFPY2M3KzI2OFJvc3FCZjMwcXpUZCtVZ2gva255d0QxTVA5d0NpZ1g1?=
 =?utf-8?B?WXNRbmpydlJTUzFabnpzOUEyTWQyZkVOd0pvNHBpeURXZkxhNlVSYkFmc1N3?=
 =?utf-8?B?R1pLT3RWaDhYMFBKQklOb1A1YkFtT3p1WDZTTlhnR1Y4NW9HTi85VEQrYUdO?=
 =?utf-8?B?eW9QVXhvYkEyVzAwQXgrekdaMGxmejR5c0Q0Sld4b3RrTVJqQU82M1NXRExK?=
 =?utf-8?B?Q2JKOXFEWlVuaXc5dmZOSkxVSituZXQ4NW5CL0Y0bldSR3hvSkQ2VDJJbXV2?=
 =?utf-8?B?OHRrRDAwMVBpbUhhZUZqdEJ6Q0xZcVlMRkVSNmhqRGZXOVdUeWFtejFCZVU4?=
 =?utf-8?Q?MD/bOJP4odo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFJUQUdEWkxLRlhGUWRTSVkycmhYeEpCKzBCSTJTMVo3RDg0V3A2emQ3WkxP?=
 =?utf-8?B?RVhqZkV5L2pEdjk0Sk93dUtOUkkydmxVNHpKTE9VVE4vUDdKcUdtOHdkU0pT?=
 =?utf-8?B?T3cvUngySW1jQURFSllDOTZoanQvd2lsT2tyaHUrcDNtRC8zY1paV2p0VUpS?=
 =?utf-8?B?eDVDd1BlMk9rM0JHUVo2ZkRWUWFUMzFYcjNpTitxNGpIQ3hRRXM5dnVzWjMv?=
 =?utf-8?B?QWlJUjIzZjVpYURGRzZqVkd5Mjh3c2p3em45dXdpbVZpU3pOQy9WdzdqS3U2?=
 =?utf-8?B?VVA3aFMrTnAyTzdMcmJYUHB1WE5McGFUZWduZEtQZVVTZ1hWOTc4eVRUZk5M?=
 =?utf-8?B?Q0k0L0hBR0pQWDVhQ3VIMDFyNElQN3pINXNnU0ZpWTlvRkkzQUNETWtSb3JF?=
 =?utf-8?B?TWpoeS9aK0VIaENOSUhXTjhmSTNlbXR6M1lKZ3NkdHpjdjJPQzlJM2taRUU4?=
 =?utf-8?B?VFRjVlNMVy9FMWJNeWljV0ZRemZ5MnBKYU1Nemd0TmdKN0c5bTNFVGpUUGlC?=
 =?utf-8?B?bWlBVVNxZUh2ZXB4RUFOaDd1eUZYa0Z1ZTM5Qmw3emcrMGFSUEpXWUpyc01D?=
 =?utf-8?B?d3djcWJ1dDE3OFpsOHFvbE5NTDFacTd3cm1lays1MnZkYUljZ3JzV0c2MU5M?=
 =?utf-8?B?QzR2T1hPS3FUNml2dHU4ZVZCeTF3TTJ6ZVk4QURjNGpiclZWOE9JRERYc2tC?=
 =?utf-8?B?b0JzS0JkYmJwNUo2ZHpTTDVxbnA3TWx4VzhJeG9xdkVkbUlKVmMyazc1eFor?=
 =?utf-8?B?OVYvR2RKNjE5Z3FwVUM3bEZITTB5Nmd4SjBOM3k2bDNnMDVDNFV2NWVQd0sx?=
 =?utf-8?B?ME9KMWRoK0NWU1Q4Qnlta2FZNHJBeWwycmRsZG5WbFFpSktsU3hyNXlaQnp4?=
 =?utf-8?B?TlpiVGJRTjdVZCtITDZIZFpCdDIrTW5MaDVGdHZZVUxhaUhoTVlHYlB2STdC?=
 =?utf-8?B?dThuQ0s4MWRyK3ZySEJzMllrS29qY29QWWRkeFFkbm90SktJV2kwL2ZIU05r?=
 =?utf-8?B?ZlJpRHV4L1A2MWJ0cEZPWXRjbkpxTTRoVVJacE9oRnNYNHhqOC9UN29HWmx1?=
 =?utf-8?B?UG0za2djWXMzeGUzUERiNTg5U1EwK01QVHBuOFZoR3BVTURkUGt2cjhWcjNa?=
 =?utf-8?B?MjdML3d1VElvcGQ1U3NxMWFraFJObUc0OHhwb1RzNWxLeEtyU3h5TWl2Zk1N?=
 =?utf-8?B?OG5zK25wN0IvTE82UjR2U3pZRlJSNGJYaXhFVnAwb0loSzB5dHc3ZXQvRFJt?=
 =?utf-8?B?dysrMlpKK0hTY0NHbzVCMnNWa3JjYzBBendwZUlCQStzTFdqNENpVFZQYmxV?=
 =?utf-8?B?QzBUYTBRcHp3Y1Y5dC9iSW1HZktUM2lCWlNkZ0VYSE1yKzg2aHhwUm1UOHRz?=
 =?utf-8?B?WDZJdVBtMW1uMVkva2hTTnhkTFRlUWt5NlFGQVRDejl2S1hrT21qQTNNTDYw?=
 =?utf-8?B?WkdCRzJNYWlXT0Y4TC90bHFnU1FVZk9TQU03bEZSVmxZamV6Q2pTVTNraDJs?=
 =?utf-8?B?LzdYUk54Y3RPbTFsdVArWm9JcThIYXZmeHJPTUI1c29ienEzVTEwbE9DS2tW?=
 =?utf-8?B?QzdOOGtsUkp3a3JMMVR3TE5TUk1WRG9MOS9kbVBPWUl5eEdGM2F6UWI0am5Q?=
 =?utf-8?B?aWYvMXRuVTZVOWc0azRnVUlWd3B4K09LMWJBUWFNYWptbFI3eFoxbWJBVGFh?=
 =?utf-8?B?UlVVVkhDcUhGNUdVdlM2NldHYjFaL042L2VmK3FmNC9Ka1VQdEFtK3F5RGZN?=
 =?utf-8?B?SjVJL0ltL09pMThOTU1MYVV6SUNZYVk5bUQ3dUhzeGRHM1AzclRZN3lhdGN5?=
 =?utf-8?B?ZDM5ejhCWmh4SEFJVEt0SW93SVpVNjRSTi9oVlVnMzVraFYvQ21BRHdwM2s0?=
 =?utf-8?B?MTdwTzhOUm9zb0VKZndLMXhreTdlcDkxcVlhNlJYR2hCcFlEdDF3aTl2Qldy?=
 =?utf-8?B?RWhHbDV6OURMMUZ2OXdjMEFhanluVkx5UW1vWFR6YXVNY2dnL1ZRZUtpbngv?=
 =?utf-8?B?SWpHb09JRERSdW5FT3VWU3ZZNDdnRDFmVUdic3o0Tm1HZW1vaDBlWU9sbGEw?=
 =?utf-8?B?L3BMRXNIZzY2dkJuVEc0OGp2ZlI1RzdyWURYZHRFK1V0aUYrZmdGYURHK1Nl?=
 =?utf-8?Q?IN04u8M7iKxNz0QD04W4IoKg3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70afa4a1-acd5-4d97-40a7-08ddbd16f375
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 05:27:23.1166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72zqfPfys676PDGJrNzufwV0USiG7mSY1F9bj+Vns2WKIoNCLI3foCO74658jAnNXnB/U/PLtPLGIArZCQSrdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555


On 7/4/25 22:38, Leon Romanovsky wrote:
> On Thu, Jul 03, 2025 at 12:49:30PM +0530, Abhijit Gangurde wrote:
>> On 7/2/25 23:30, Leon Romanovsky wrote:
>>> On Wed, Jul 02, 2025 at 10:18:03AM -0300, Jason Gunthorpe wrote:
>>>> On Tue, Jul 01, 2025 at 01:38:44PM +0300, Leon Romanovsky wrote:
>>>>>> +static void ionic_flush_qs(struct ionic_ibdev *dev)
>>>>>> +{
>>>>>> +	struct ionic_qp *qp, *qp_tmp;
>>>>>> +	struct ionic_cq *cq, *cq_tmp;
>>>>>> +	LIST_HEAD(flush_list);
>>>>>> +	unsigned long index;
>>>>>> +
>>>>>> +	/* Flush qp send and recv */
>>>>>> +	rcu_read_lock();
>>>>>> +	xa_for_each(&dev->qp_tbl, index, qp) {
>>>>>> +		kref_get(&qp->qp_kref);
>>>>>> +		list_add_tail(&qp->ibkill_flush_ent, &flush_list);
>>>>>> +	}
>>>>>> +	rcu_read_unlock();
>>>>> Same question as for CQ. What does RCU lock protect here?
>>>> It should protect the kref_get against free of qp. The qp memory must
>>>> be RCU freed.
>>> I'm not sure that this was intension here. Let's wait for an answer from the author.
>> As Jason mentioned, It was intended to protect the kref_get against free of
>> cq and qp
>> in the destroy path.
> How is it possible? IB/core is supposed to protect from accessing verbs
> resources post their release/destroy.
>
> After you answered what RCU is protecting, I don't see why you would
> have custom kref over QP/CQ/e.t.c objects.
>
> Thanks
The RCU protected kref here is making sure that all the hw events are
processed before destroy callback returns. Similarly, when driver is
going for ib_unregister_device, it is draining the pending WRs and events.

Thanks,
Abhijit



