Return-Path: <linux-rdma+bounces-4498-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F209195C4BB
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 07:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF962859D8
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 05:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B61E4D8DF;
	Fri, 23 Aug 2024 05:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H8QrP9cR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4728748A;
	Fri, 23 Aug 2024 05:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724390219; cv=fail; b=IJ+MpbUGPC4+pqeI4E0a9UzKXhfQngnrzXKydOQ4t6wLxsKnmfCIunQj5F4F0mga6u/lGxHj9fao2BEjE76Ix9WKcwrI9Ih856xxbxXX0rPxkoVyYhRBjAC5vMtFWlRUcZfncuoOXnOpfmBLqveqB9iGCeW6fpKFFyrRdaCQMLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724390219; c=relaxed/simple;
	bh=QaVRwuI5/oeL76rpkVIdkNlqQfjbiknUvDPor72FuO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m4WkLB+hhQU/GTIEj4FKCsRPAOOVNk0KNK3uRsPZFKuctAMZRs49ecEd+lZN3jnto4ADNged0T27XfT5DoAgD6+g5TXyJMO1DBCs4J0CO9brmh0r1DDhfFvLk4TOd4pI3MnAVOJWau1MNrAkNEbrW1+DNNLa6XIiufMnZObbq2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H8QrP9cR; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjQ59wJq0iWPGM28pg1xCsOfz2nHTzVs2XvGQzASOWeSFL9pXnZpHZ+kv8Gs0UCe5npedcltdB7WCHJNTzodYg7vUzU+T7dZNUS2m46LQQMi0MzEoZG2E+PHh9BeoK0UzFI8x5YZcgh5tz1lHFyGfH7QdlLlP5kqm9VT/a3QeBOxhIgXMuS1YRcI2l5Ysjdx11fbeLbBVgz6Eba/n49SMUJspPgnHZ3F0YnAVhRWsi+X71/XlSkSSmiRPmtxmrtH/02XerTz4AMgYaSrZo/0tzspN7UpdtiU721mQP8T6ILf5rpRip2r5iGBhE7JKZmWqgB7Ws/57V1nCNoODYLBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5sHbN5/IIitBLcpJyxBo4G/2kLMrvoOcfYuZkUlQTE=;
 b=W7PRqL86V4F5ebcKGHjY+lubQerDxmqs5mM+J6WbANYNqiDbD/V9vtUH228GXBLZGrRzKgxzHh6Py39wzPrf4aO1HoCa9A60/ZjHfnNBcxGWrebXnzEqEcRYUveo2fO6qaMG+9oMcpST+WGKaARsOsJIatPEf+SaeCn0pSr3gX912b7Huesp+Q8iTKBDBVlB4997GECNiAPv3s33H+/t+4IB5bQRLU44OuGx1YvVNv5cUnKjo1bkjhvyxTdPF40zVtOBfwna3bxQTQL5lR8MMhUE5aE5vIDOQZdamxTI/mtSX91EzPqshtl6AfSzmcKaRWWKuxXJiuweo6Z/Bfz5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5sHbN5/IIitBLcpJyxBo4G/2kLMrvoOcfYuZkUlQTE=;
 b=H8QrP9cRDIe28jRlv2+939wwWI3sAPR83lZB32b/Zvir6a5wT2Le9Bn7eVtzcVcVf7mh96a5/mU0G0pLa46xG6A2xuItBCPB/NEpThVZooaoOjvmcA+s76wTtI2PTqz9N4zmoxgtBJEfEHWPKQKlwP4TzyRd4X0ks2ERt6t2bKnQgZNcKiD8hIty5Wbhhy2SA++goD5wJPsHTVIH3X4MkamC1XInsZWUXZF8i24S2VxWLwp8K/xJzRkDAskYdVpV+rc9FtJ0jsD6fdqPYzk670LmdhZS3yaLyEuCJrWgDPlhRrevuw4NpuzKJJlZ98Zq0fo3u9zclhgBzu6mIyIvnw==
Received: from BL1PR13CA0222.namprd13.prod.outlook.com (2603:10b6:208:2bf::17)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 05:16:53 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::f2) by BL1PR13CA0222.outlook.office365.com
 (2603:10b6:208:2bf::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Fri, 23 Aug 2024 05:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 05:16:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 22:16:38 -0700
Received: from [172.27.33.61] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 22:16:34 -0700
Message-ID: <5fc5d450-b77f-40eb-b15d-33939719a124@nvidia.com>
Date: Fri, 23 Aug 2024 08:16:32 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Added cond_resched() to crdump collection
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Mohamed Khalfella
	<mkhalfella@purestorage.com>
CC: Yuanyuan Zhong <yzhong@purestorage.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shay Drori <shayd@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240819214259.38259-1-mkhalfella@purestorage.com>
 <ea1c88ea-7583-4cfe-b0ef-a224806c96b1@intel.com>
 <ZsUYRRaKLmM5S5K9@apollo.purestorage.com>
 <ea86913b-8fbd-4134-9ee1-c8754aac0218@nvidia.com>
 <Zsdwe0lAl9xldLHK@apollo.purestorage.com>
 <1d9d555f-33b7-4d95-8fbd-87709386583c@intel.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <1d9d555f-33b7-4d95-8fbd-87709386583c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 533d0476-1eba-4f4a-5659-08dcc332ccc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkdSOE9Bb2sxaTJ2aW9IWHlUT05CMXZsTTlJOUFHZk5kQ2kwZ1BpNXNLV3NW?=
 =?utf-8?B?KzZFZlNyNkdGNzNWQkJYZHFVTCtUZ3NVdGdkMjFoc3FlL2dtVi9CeVh4bUlh?=
 =?utf-8?B?cFUvdzNzSFdYMlFiYkg1cTg5LzcySGZUc2NKNUhDVzk1SE9OWlh3NHI1UElZ?=
 =?utf-8?B?cHVEdFNmMnAxeW1WNmtVZm44YU9SL0RYMWt2MTRTYjlHYnU3NitTTWhtWTBl?=
 =?utf-8?B?WjIrTzlQOXVBakJNdDdlSmp5dTc5MjE0ZExldnBGL2gvY3NmbkN2NjdteEpT?=
 =?utf-8?B?ZW1zNEsrRzByc2diNHIrU2RjaHhJL3ZCRmxzczRtdGdVRVNodHN0TDEwamt4?=
 =?utf-8?B?ZWlHeDdvYUp5UHRxc0VLZE5nWDJsaHFVK1FCWjUxT1lzSXdrZURseDlGOXgr?=
 =?utf-8?B?RGVMM0R6VmxtdWttc2ZHdDFDRk1XR0hXVm5hNFgwWEZWZzgrbndjL3VXWStW?=
 =?utf-8?B?VnlpRnNTMGprUUd0NHV4ZVdVSklHUEhwdEJ6YXByVmorTWZFQjhBSXd4TzJv?=
 =?utf-8?B?bjF6TzY2Tisxc3h6VERwVDd5TGI3WHZMNFhDVGxBYzZ4aUxFdFdEUEhaenlt?=
 =?utf-8?B?T2hCb2syMVppZ3pVeU9Fa2k4cnphKzhENFJ4Z3FCOStBOExDM1habE9OTGVL?=
 =?utf-8?B?V29pTVZJTnVzcGNQTUlBTHlTR09qVkp4UUQzTFdIc2crbXBxaGRORnFhZEFV?=
 =?utf-8?B?OGVVdEZvVkl6VEtLR3FPSHVlRUdVMURkc3pzSm5IUkoyN2c1b3lEc1hqclJD?=
 =?utf-8?B?UFBTUngreEI4Z2ErOE9sSWZpV0Q1TGFIVDg0QjZRM0c4UkdsMUhEZTl1Z3Qx?=
 =?utf-8?B?OGUxTlA4eWdDZDlJVzVVMitWQjlPd0NLUWY2L0pXMWRxUkNaNVJpU0M5aEF2?=
 =?utf-8?B?b1dsYTlBamZEQUJkbVhRV1hraXhqN29wZTdOTXZzdE44eUpDWWJaWmNUajgz?=
 =?utf-8?B?dTZUNGFEU0RPQndhVEkzL2NGVG9rbHVnQm9oZm9PeGl0STBKaFExQnZ3UVk4?=
 =?utf-8?B?TW40OTdackphMHZUMjdYbk9LcjBNWWFrbWxQdWVhZmU5YUFad1IwemtYNEs2?=
 =?utf-8?B?T0J2d3BpVGcyMjBhT3hYUkJQbXlzK0V0OFhzNWpQZ29ITGdFRFEveUdFWnBZ?=
 =?utf-8?B?NVJISm1IOWlGczdIdk1MS0ppTE42Z2pERGpZdEZGQWd0MWk0NE1FSG9DaVEv?=
 =?utf-8?B?UlNFTlMzL0RtZk1wek92c09OSjVKL3M0NGdWZWdqUHMwdWJPSW1Nd0h3QUgx?=
 =?utf-8?B?c1RjTVpaNmU2a05wMUdkQ0dLK0hUaEFHK3huL3luYXkzZ2p6MTFadHNtaCtK?=
 =?utf-8?B?MEVycUwwS0tyU2hpN0pOOVo1ejYyRHJJd2R5NnlqUXJXVUlhOGU0TUU2alA2?=
 =?utf-8?B?dGhEV3RBVzU0MFFUQ0JhR3dWMnNuYUdJS3VHK0xnejlZMVVqUnBpUnpLWjQ0?=
 =?utf-8?B?WUdoK21Fc3h0RmpOQjVRZmJYM3VZazhxbXYzZzh3ckt4bThuN04vSTdXVUVZ?=
 =?utf-8?B?ME5HcEFucTRuSEVySTBQK2drMnFhbVIxYzVBdnUyNjJaQzNNRmR6UFczTWk1?=
 =?utf-8?B?eUxrUERUb3ZTcEN5T1NyK0RBdmFKQTRsWFVGVVBtdEYxMEdSV2U5TDUzaEQ2?=
 =?utf-8?B?T3BRT1NHVXo3eG9nUVhvZW1MOGdUMzdhUjNJcDZBUFFQT1ovWmFwQTh1K1Rn?=
 =?utf-8?B?MVlEdWtSMldSM3BmNHJZVW93dHNDQjdCSEdoaE9mZUdRbUQ5UGNWU29WMkQz?=
 =?utf-8?B?Q0dCdVdkVld3Yk5rc2p4SUFSSldEOXRjZzVOZDZIRE5KZ2NHTU1qRlp3anQy?=
 =?utf-8?B?RVl3bTh2a2tCMVhEalRvNnFFTFhwSlM0VTgrUTgrSVIvVC9SZUsxY1Z2SXdr?=
 =?utf-8?B?alk0VnNYbjlMeUVaSkgxaDJRVEtwRStKeGQ4SUEzY0U4V0NUenBNRmlwdDRZ?=
 =?utf-8?Q?4d0DPWcPUBAnGOojG8+QMq6br0eZxz0T?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 05:16:52.8871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 533d0476-1eba-4f4a-5659-08dcc332ccc3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591



On 8/23/2024 7:08 AM, Przemek Kitszel wrote:
> 
> On 8/22/24 19:08, Mohamed Khalfella wrote:
>> On 2024-08-22 09:40:21 +0300, Moshe Shemesh wrote:
>>>
>>>
>>> On 8/21/2024 1:27 AM, Mohamed Khalfella wrote:
>>>>
>>>> On 2024-08-20 12:09:37 +0200, Przemek Kitszel wrote:
>>>>> On 8/19/24 23:42, Mohamed Khalfella wrote:
> 
> 
>>>>
>>>> Putting a cond_resched() every 16 register reads, similar to
>>>> mlx5_vsc_wait_on_flag(), should be okay. With the numbers above, this
>>>> will result in cond_resched() every ~0.56ms, which is okay IMO.
>>>
>>> Sorry for the late response, I just got back from vacation.
>>> All your measures looks right.
>>> crdump is the devlink health dump of mlx5 FW fatal health reporter.
>>> In the common case since auto-dump and auto-recover are default for this
>>> health reporter, the crdump will be collected on fatal error of the mlx5
>>> device and the recovery flow waits for it and run right after crdump
>>> finished.
>>> I agree with adding cond_resched(), but I would reduce the frequency,
>>> like once in 1024 iterations of register read.
>>> mlx5_vsc_wait_on_flag() is a bit different case as the usleep there is
>>> after 16 retries waiting for the value to change.
>>> Thanks.
>>
>> Thanks for taking a look. Once in every 1024 iterations approximately
>> translates to 35284.4ns * 1024 ~= 36.1ms, which is relatively long time
>> IMO. How about any power-of-two <= 128 (~4.51ms)?

OK
> 
> Such tune-up would matter for interactive use of the machine with very
> little cores, is that the case? Otherwise I see no point [to make it
> overall a little slower, as that is the tradeoff].

Yes, as I see it, the point here is host with very few cores.

