Return-Path: <linux-rdma+bounces-13301-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D4B53FBB
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 03:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2240A054BA
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 01:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE127260D;
	Fri, 12 Sep 2025 01:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OPQbtFPC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A618168BD;
	Fri, 12 Sep 2025 01:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639647; cv=fail; b=FgiCHKGEs1LXHPSfv+1ps3TW1Wda/EN0SqLcc4gvFa06Omq0/rTQqLCfWJ33tyh6Degp4fBeX3np0c7PQa/ONIQJkuINnG1EpYYrcQM6qmr7TGFyUtbyp92DsHWAm5OhX8ykasYuSpTA6EWwFFLBRHssCUSOsNGj66VxlI9koWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639647; c=relaxed/simple;
	bh=e6K4vzPVmc9Ms101ZOJFn6jF6EQDs+aD1el2958h5IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qzdosySqdiFl0tsmd3q++6kObhIWtcpW+UQC4Aw1/UShh6tKqCL29hQkorvDNJ79uBFBlaEQ8RuIQ5InDX3acVFGEMzrNR43b8izzYFeVCspWJokNXnKJm+PdnYtbV4DIKUsbWYndgA5auLrTABXZ0zLkTh81cALTvC5VGWNWd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OPQbtFPC; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwlkTFWN84yWqcUS6zKjEJ+tUo732Wdu4AnI4eDtkQUkdl6P7P13zt2RQwQpWgZG1tLuwpScnVlT1NEtxYeUARTGiemkDHrqpKXx8XSQRClN2cr54vRufQ4mZ3lEYoksQl1Wgn3FHgncUnLIYX1CKtIfRVf24zyxV947Z65mv6pmY/jLXeZcfcw8uxlH1r0G9lLloIl3Dy5tHgKBWhKnl77SuSiTeYJ6AIiFSQmH6eLL7lbcuQdB6omlDRRMUBC8jJEpJvLwpcymiJP3akDQ5bdXnwEZ9A82qTQQtSZ1uIVxQJqvD6T3nTBizSlzkFDbfVVDUHHOt+VuvsxM9Tl4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NS+FnGkz8b00KZ/KJ+XlXKcgLwKxopjTWDZVtqN9lw=;
 b=aON3DM4Hl+DRE4Xk3hpQmdS8ur2Dx1K8yeHeWMVJztxb/Q7FzmxI/bRQWmgJo8ncHCT83Szd9aZO74A9KGyv5jXLnkheFfQER5LlLl18fCG8WQdBePLxQ/qIzwf3wNt0MVfz3Ma292Nn3xLjkElvwTPBHcDifbCAqakzphjh7kjTKA82ylXNskb/NthYzO4e/eoPNnsWKE1YzqwsgbIB2E6C1ewIi0gSHy+LPyicujDvmhNbO+qyUHBuOR/e4ofolN7Mn8xpBHsqMY8vfx0H1ou24Qdirx2hnLEgBeXiANIA7AKFR9ILhgASa5vps5gjyKMjE3KK015X9FEnSW4tJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NS+FnGkz8b00KZ/KJ+XlXKcgLwKxopjTWDZVtqN9lw=;
 b=OPQbtFPC03IqNSr2psTrMoiimfsPNuXKr09iRSWawH4BPvTE33vMgojoh49TsbQ4Mg72sRS2FhQazOuXSaJV3uGvEOpLEkaKUou7Y/UpGK9R7CbKxXC42icFEUptM+4dAqtv8vlDvjMbh0eTaKoe8VAhoLdxIzS1nblk6no+j4JYPXV8KCphF+w/0SzDVZ/K2vlHcRwVu5VuEB6ePWLKVmuoK0cLsKT/jjTWND9iT9gJO9F1Xo5Re4U1lkN4ZbHS/GM1goeNwjN+T/GidIvwxgpcHHOdNXLYQofLUjw+t/zWoPv2RIas4ouclcqGOK5cEGpw3awwaxzerzSyamakjQ==
Received: from BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37) by
 DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Fri, 12 Sep 2025 01:14:03 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:94:cafe::56) by BYAPR01CA0060.outlook.office365.com
 (2603:10b6:a03:94::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 01:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 01:14:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 11 Sep
 2025 18:13:52 -0700
Received: from [172.29.225.228] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 11 Sep
 2025 18:13:48 -0700
Message-ID: <95604c0f-558b-401c-8c79-ef5511ddb4a4@nvidia.com>
Date: Fri, 12 Sep 2025 09:12:47 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net/mlx5e: Prevent entering switchdev mode with
 inconsistent netns
To: Jakub Kicinski <kuba@kernel.org>
CC: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
References: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
 <1757326026-536849-3-git-send-email-tariqt@nvidia.com>
 <20250909182319.6bfa8511@kernel.org>
 <05a83eb7-7fb1-46ae-b7ba-bd366446b5f5@nvidia.com>
 <20250910174842.6c82fb0c@kernel.org>
 <5fa69070-59e8-4eba-877e-f0728088fd48@nvidia.com>
 <20250911171128.42d0b935@kernel.org>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <20250911171128.42d0b935@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 89994e31-ea4d-48e3-df59-08ddf199a8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHlSTDFFdCtJVDNuYmJhQjJUSHl3eDEwTkVHTFF4TVNCYXF2RU5QaGx2UUdL?=
 =?utf-8?B?dThjSFdQTElyeEMvVUhxd3p3b1RvWUJKWitqS1BKSmdrTW1UV1ppNFluNGRK?=
 =?utf-8?B?OFFQV1BLc2VkMVZsY2pIUytHbjJHMXNoNXdzY3M3MmFSYkwvSWlIU05CRDh0?=
 =?utf-8?B?d1lUSVlUbWEwa3gwdUg0TVBVOU9ob2Y3cEJ0Sjh6YnVqU3oyWkwya3ZNdmx1?=
 =?utf-8?B?RXdMOVVQcm5nOERoazZ3QnkzYTArSzYvanJPdEo0OUJNWDhNeHltT3hOSU9Y?=
 =?utf-8?B?THFsZlFmdksyMnpiZjhwTWVqQUQ2K1dKOEJVdFd1ZktIZENab1BZcGtSbmho?=
 =?utf-8?B?bnc2UW50dk9GQU9sYzNlNFNnQU5aMDhVVlk3SVlBZ2pTeC90S2Y4d3Q5Y0hD?=
 =?utf-8?B?eG9HNCtxUGlwdktuS0JQUjBXU011c2VscXA0TGt2NnQycGJNM0VKTFhvM21X?=
 =?utf-8?B?N2VGZ2ZMcURLT05ENzhuNi9HSzFRclIzL1NlZm1lc0tiVVo5UktqVjlnRE9k?=
 =?utf-8?B?bSs5MUZlRDZCNEg5QmM5aWtoekRFaTZWMUdPTDJ4TXQyZTE2QU1pc2R4Z1Nk?=
 =?utf-8?B?Z2VGVkNheGhSajJZcnJUZnh0QTdGZHAxNjBTYWFORHIwL3YxWWIxZTJNcTJr?=
 =?utf-8?B?NXQvWFQ5U2lQMmhHdEdERjVBQ1AvVE41V0gveFBjaklleTZ5VjFDYmJkek9w?=
 =?utf-8?B?SGdHWnlxczZjRkdQc0xheFpwWlZxemtaeTlmZmpJcWZGcHVxUGU5OFJLTnEx?=
 =?utf-8?B?b05nTUVhWUk0L3NVMFJNKzNDcUNXOFlnQkdOdGVFR2JvQXBXNCtsbmgyTk9w?=
 =?utf-8?B?US93b3A0bWR5REFLSzlWcWVTMWdDMWpzblQzWXpsMmlmWG1NZlN0QUZ4V00x?=
 =?utf-8?B?RWptL0RSZ3pTM0h6MG9SQkxRK1lMQWVhOGkyRThhd2JOVmlOL3RWdnNqSDhH?=
 =?utf-8?B?a0pUUTM4ZlhwaWtWcnFCMmFtTGZGanNKVnIxUFZ6Vko1eUcraWdKVEZidkpU?=
 =?utf-8?B?ZndaVDE4Q2N4dVA0d2lNVWVzaXlSajhEZW5IRzlaWHI1TjJmcTU2OERZZkQ5?=
 =?utf-8?B?d084YWlDSy9IMko5ZVc5blMwNlE2UjZhYTZZSjhqcFNvSGhQcXFtKzNFUEZF?=
 =?utf-8?B?dDVOb0hUT3hCVDZSZ3BMM2FTbVZHR2dHZ1pLZ0lWVUN0a0FUZGtramlwU1Fh?=
 =?utf-8?B?ZENKZjdobjFZdjRkRXNoV2FEc1pjZHE4UFFCaldQd3FHWCsrRGMxNjBwWGl1?=
 =?utf-8?B?a1ZKWS81cjJNanY5c24yRk1FUnRWdUl4bHRmalZYTkxWblZnN0dzMnNBaUFx?=
 =?utf-8?B?NU8za3QyUDZpKzcxc0R2MWZjTFRmNG4wREJWTkFiYWhxZlVhVlZGTDA3Z2tm?=
 =?utf-8?B?S1N2KzFTNU9IZWtYdmJpRGNydlI4T3NKbElVaFhsRnZYZ2VhRFlsdmxKWVky?=
 =?utf-8?B?ekw5eHpkUUNCRm1mUzYvUmpaVHo0M3BoT2N4Lzl5VUN5Ly9SbGx1RnQxaFdh?=
 =?utf-8?B?enZCYkszWkg0NW9uN05oRlZaVXZHYzhlYlJaYU1LSTdjemdvZkt1WjVaRW5Q?=
 =?utf-8?B?aGVia2s1SWlsaXhZT2VxTnRGVUtQSzJMdE93ankwQnJBMmNwRjFqTXFzTU5M?=
 =?utf-8?B?dUhKRElJSVFUV29icGZDVFI3VlpoZktsMkhFYXRZL1dlTjViWTJHYjYxQmFB?=
 =?utf-8?B?azRFTDFqU2tUOW9tN0NTeDhnNDh6aXRmQ1dkcmNsL1VEcVVPdnh6ajZCSEQ0?=
 =?utf-8?B?VmxwSUJuRm5aYUpjdERHVTRrM2JhOEwyZGZacEZ3V2RIOUlxV3dXYmt1eWdD?=
 =?utf-8?B?dTM2WGJHUG5yNklPZHRQOGFIVkRxWmhKZTZ3SzdLZXZFMUpEWmtLaG5kcy9w?=
 =?utf-8?B?TXQvM0ZKNXJLaEM3Ym1hVDVIQnlhN2hOU3kwTFBoNGNJS3pVcDlCVkVKU29v?=
 =?utf-8?B?anluRGFwMzlISlJTRUp2M3JOMlh6U09pN1U2dWtJME1pc1B4d3hhMlY0cStm?=
 =?utf-8?B?c0JBdHArc1RDdkRJTzVzZ2l1cHhwekplTVNjRHBVYVJ6Wkc5U1RMek1VU0FO?=
 =?utf-8?Q?UYS4A+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 01:14:02.1855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89994e31-ea4d-48e3-df59-08ddf199a8eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204



On 9/12/2025 8:11 AM, Jakub Kicinski wrote:
> On Thu, 11 Sep 2025 15:48:24 +0800 Jianbo Liu wrote:
>>>> There is a requirement from customer who wants to manage openvswitch in
>>>> a container. But he can't complete the steps (changing eswitch and
>>>> configuring OVS) in the container if the netns are different.
>>>
>>> You're preventing a configuration which you think is "bad" (for a
>>> reason unknown). How is _rejecting_ a config enabling you to fulfill
>>> some "customer requirement" which sounds like having all interfaces
>>> in a separate ns?
>>
>> My apologies, I wasn't clear. The problem is specific to the OVS control
>> plane. ovs-vsctl cannot manage the switch if the PF uplink and VF
>> representors are in different namespaces. When the PF is in a container
>> while the devlink instance is bound to the host, enabling switchdev
>> creates this exact split: the PF uplink stays in the container, while
>> the VF representors are created on the host.
> 
> So you're saying the user can mess up the configuration in a way that'd
> prevent them from using OVS. No strong objection to the patch (assuming
> commit message is improved), but I don't see how this is a fix.

Yes. We are preventing a configuration that breaks the OVS control plane 
for this specific use case. Thank you for the review. I will update the 
commit message.

