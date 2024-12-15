Return-Path: <linux-rdma+bounces-6525-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB1F9F2435
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Dec 2024 14:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362DB1658D6
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Dec 2024 13:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C04D18DF86;
	Sun, 15 Dec 2024 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dIHoqEK2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D82C2FB6;
	Sun, 15 Dec 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734269977; cv=fail; b=Y8/Sek5gw5PP6hrjkd4slkTcwthlkVMq6Bm2L+v+XO9jfnDz9to+2apvByKBoutpH1hGDgM/IrMk5BHz3ymLowHnhFGfIARz32uxbaYS4CkUHPBDp7hSVF94l9lp6hRO3PDBcpwhcWEJZ8VJsLCfeOP7IIzhtck2/hYcrCB16Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734269977; c=relaxed/simple;
	bh=lkcmUShjKUDNbHeV7z2QOyed5le5B/NEA6Ux/KeKF/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ceozeU/QjXgYEz18yrp+d/ywttrUqdk4uliISlJz1vKWK0s8GW1Z/egJoslEZZc/NAnVtDR1NgPPBsK11e9erNAjwrly0BYtb4bJxAQMDra+AdEs2UmriY6rAz2FOY2RODb+wpf9r0qteQKMguLIq3cXoKKZOGatPdFqFXL4RO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dIHoqEK2; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDVMJtqO20rlrC6QhKOpuY9EV3r3yUa1MlaYQ4aTjKop8PxtmN7pf6gquinKPzlLx7xgqLSJasI5H9cQRd/iUapRciZneXzb/kZy2LFVEUsQcZ9yZ/LqlLAKq30p2UU5MlSJ1brAwjONmW/3SZH53ycpJZeeUqhqqAxls/YxNzxDpsBj9jMK4clvC7rh5A+vzXowl4TnF88+Ti8/ERsGty7r7AbbMtnBpqSRzy891dz46jue31lKyG7gDtCURoqwD0b8B3JNZxkp2vIBQALQyTuirVPMyewu3TuyZxd0I1CJHj6BEGzY6U+0HI9IN3O3MmtLjdUTUE/G4tEFELOC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC61jtmQoR4YhNaxeoZ0tSkWuvRJmFl+MdxCkSAR8dU=;
 b=EPuzs8i/5BOppNJA33klR/sRaLtc4aT2gPSNYsQpImboZvsOz8y2lV8yjQUS6ekTdXY8UhvY/aRdTNTCUzuE44mupsi5HpSDXQtDcm4DBG0yHL5X7cSTm9TVhAiSv1YnQ044uoRLa6/8s6YN4Lc7vkDc2SrIjkBGEHkfnxmzhbcppei20q49LJrFn7rXznzSo5qDcDnmX6YVcO6UD7nUtjSHNknURppvsN6n7CpPS44g6O8IA54e8PW8+tfXe1WzP9GSUSsXxdJIZE5bbi+jGxZIahg5NIW64ymXL54za5acCY828H4+9o9fD+IJ2Na2dsj/uD3V0IOqLyFaubtbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC61jtmQoR4YhNaxeoZ0tSkWuvRJmFl+MdxCkSAR8dU=;
 b=dIHoqEK2YB2Jm94EZYH0Efk83sAZe3FJ2XZbvdUBHYhz7SsKwEF/Dvo1bo9hU/ePg0fkSz1e38RHtoyoku/Czu1cvhVQxhxc4AYQCtDHECwQa8q8eHFUFcJsuhzaSvYh3rxmFcjcuqVEpJ3DuLQ4HymRu5YO/fnnxqa1qm367Lv1NNZSWpBlEHFciHPOumELIoAQtM6bi/tiu5dfbu4ic1wcHzLUScztW98oaf93cDX2pK6ZyLTAlT+7F0DNSd/7jtPtNK6JVk1ggV+ofzfjUhO/oMOyFwiz1m1fFo2PXXHnwQ52/oDz/EXuF5ZXB4jWY78kZYadbosE1GIdjKAPow==
Received: from DS7PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:3b8::34)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Sun, 15 Dec
 2024 13:39:32 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:3b8:cafe::89) by DS7PR03CA0029.outlook.office365.com
 (2603:10b6:5:3b8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.18 via Frontend Transport; Sun,
 15 Dec 2024 13:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Sun, 15 Dec 2024 13:39:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Dec
 2024 05:39:23 -0800
Received: from [10.223.2.16] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 15 Dec
 2024 05:39:19 -0800
Message-ID: <70b3a7b5-abd3-4db4-8415-e0467a565847@nvidia.com>
Date: Sun, 15 Dec 2024 15:39:11 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/12] net/mlx5: fs, add mlx5_fs_pool API
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Kees
 Cook" <kees@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-6-tariqt@nvidia.com>
 <20241212172355.GE73795@kernel.org>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20241212172355.GE73795@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a8a291-04f8-46c2-0f86-08dd1d0de820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STVPNUNoRmhPUEhjclpiN0JQREk5WEdBby9LVlJtTXh2ZEpSU3ZlWDhRQy9Q?=
 =?utf-8?B?cXA5S2ljajZjRWo2SnRqS2N2emVyN2l4Q0lKc2tDblVERTNrR24vMEhhRktJ?=
 =?utf-8?B?OEZ6UWxpbVUrUmVKSGtUdGZtRzkrblpHVXdWUnl0NmwyaUpIWjR6UGd5UUJV?=
 =?utf-8?B?UCtxVklHakNsbEJaWjgvOGd5WldweTJCT3dXc2FHQnV1RTdMVkRuM0V2eTUw?=
 =?utf-8?B?VFdjNVQwVGo0THVtdVp3MkpuekY1MGdnWFdZd0dXeXdtNm40RlY0aU1VNjVy?=
 =?utf-8?B?OUJMUFJDaWh2NFNvR3JKMk80a0k4N2VRaUdXeU80Z1FQNnBMWlc3eVJOcENY?=
 =?utf-8?B?NnNyTk0rbWVGSzU4bEl4d0NIVWZnb0R3WHFaUVRHVTNjbUFOVU03UElxaS9O?=
 =?utf-8?B?ZjlVMDlmeWN5UTFRN294Z1NGR1dtUC82RmRCNGdFc2VqR3pCQmtwWEVya0wv?=
 =?utf-8?B?Mi9ETjhXU0p3bWFmSmtINmxuR2lER3poWEFtZytJZ3M2RlVQanFaeWhtbkln?=
 =?utf-8?B?TDdjeERVY2RHcXRtYWEyZ0g4M29BYUYrdEdxL21pOERsMDRZUDJiQ1grbmFZ?=
 =?utf-8?B?cFNqa0VzMWpmcFZxOEJQaC8rdHg0VTBZMDExUEsvck9LL3YzR3BlT092NXNz?=
 =?utf-8?B?anJUOXNtQ0svVVptWkZ6UEMxcGszSTJKdkt6RWk0QUZCdy9kVWZYSzhxL2tM?=
 =?utf-8?B?aFFEaTh6N3JCSlFUN1Z0MTRrVzR1R1Vodi83TmNBZ2NHOVg0Q0dodlBubVhs?=
 =?utf-8?B?Y05oZ3Q4a2NWckthNjVvdEloMU1aVTd0MkhmREp4ek94VWhQUXRneWZnb1lm?=
 =?utf-8?B?STFIMzZFa0x4VFJwNUxlZ0hVT0t5cjF5VndjRHZFU3lJeE5wTm96U3lic2FG?=
 =?utf-8?B?emo1U1VrNWJRdnVyKzBkek1tczNhTGw4Y2RDNUZHNUJYSlA4MkVzM2xGMVcw?=
 =?utf-8?B?UGsveEJHS0NJa241SHl5Mk5PTTVROWt4RC9jTGpwU3BUY05ZSGN6ZUtQUFU3?=
 =?utf-8?B?QXhqZFEzZ2ZUd2xkaHFoSEh4WTFWd1NydWQ2clNmTllPWVJ1cmpwNzhpd1FM?=
 =?utf-8?B?S2FCRERQMUNHVm56QmFJZzNEczVPVTdPL0RsQ0VTWmgxU1d4cko5bUw3amRT?=
 =?utf-8?B?NEJEQjVLZ28zZTc4dm9NdkVtZVg1bDhhSk5PYVpyQ3h1em1vWC9WdGs3MDZX?=
 =?utf-8?B?RHJKWm5oajRsYlVLcUJPRmVMQlYySW1DdTc0d3NQY0dsdGR0Zm1kZEdCTHNH?=
 =?utf-8?B?T0RrVkZhMFZaRkdLeHVSeVplY0ZESURQQU03ZjBNdmhON0dtU2RVYUFpdHl4?=
 =?utf-8?B?UW1qZHphMm0rbG9CMWdZSUh3R3hncU9hVWRJQXBXa1ZLZGFZOFBZM0VzbVlS?=
 =?utf-8?B?RnV2S3FqdkFHcmR0M21UdHBBNncyWkdmdmdrZldxMDBZSTB1UXExSm9YNnY0?=
 =?utf-8?B?bzgrdjlPKzdJa0ZaRUQzSmJjeFExcmY3YS9rQkp3cFNwVnRsTGJ4NVlWcXgr?=
 =?utf-8?B?aUtoN2xoNXZxZlkxNnNFWUtra2U1MXhMRFZTRllEb1dCRU9LdHk1ZFNjZWN1?=
 =?utf-8?B?N0MxQlpFclRUbHFNOUtGNlhlWU9ScFZ2c0kwdDlOY2liT2lzS2dhaEJ0aDZt?=
 =?utf-8?B?UW5IVUtWM1BWd25XQWo1Tmg5Skl4ZFU3cGdKVHllTXc0REd1dUtmSDFDSXNn?=
 =?utf-8?B?bGJkbzc3OUFpRXRZUE9WMU1HdGh2eG02N1JmTzJXTGNZYzlLc05Hb0pZZThh?=
 =?utf-8?B?cENuS1NKMkdHL1RUQUJBbVAyTnkzODJTMXlhWVpxWGRNazYweitlU0NDc1FK?=
 =?utf-8?B?M3daYjh3WjJhVzB3Y2d3NkFpWUJsTjU4eGdYVG1SOXRsOHR5Rndob1RVZ0Y1?=
 =?utf-8?B?K0lFT2hTVXZVS05EaGkrdmpBMW9PNm5MSG5CS2EreGtaMGhRK0ZSaFdvMUxK?=
 =?utf-8?B?RU1Bcm0zMXI2SWNTRWVDZlQ1RXFMQm9IMklLVGpUZXV5NmE1eWdQQUFvbGNR?=
 =?utf-8?B?V0lMQ3YrWVd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 13:39:32.1267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a8a291-04f8-46c2-0f86-08dd1d0de820
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020



On 12/12/2024 7:23 PM, Simon Horman wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Dec 11, 2024 at 03:42:16PM +0200, Tariq Toukan wrote:
>> From: Moshe Shemesh <moshe@nvidia.com>
>>
>> Refactor fc_pool API to create generic fs_pool API, as HW steering has
>> more flow steering elements which can take advantage of the same pool of
>> bulks API. Change fs_counters code to use the fs_pool API.
>>
>> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
>> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
>> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
> 
> ...
> 
>> @@ -447,11 +437,9 @@ void mlx5_fc_update_sampling_interval(struct mlx5_core_dev *dev,
>>   /* Flow counter bluks */
>>
>>   struct mlx5_fc_bulk {
>> -     struct list_head pool_list;
>> +     struct mlx5_fs_bulk fs_bulk;
>>        u32 base_id;
>> -     int bulk_len;
>> -     unsigned long *bitmask;
>> -     struct mlx5_fc fcs[] __counted_by(bulk_len);
>> +     struct mlx5_fc fcs[] __counted_by(fs_bulk.bulk_len);
>>   };
> 
> Unfortunately it seems that clang-19 doesn't know how to handle
> __counted_by() when used like this:
> 
> drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c:442:36: error: 'counted_by' argument must be a simple declaration reference
>    442 |         struct mlx5_fc fcs[] __counted_by(fs_bulk.bulk_len);

Thanks Simon, from code perspective, bulk_len should be now in the inner 
struct fs_bulk.

Keen Cook, is that going to be supported in the future? for now I will 
just remove __counted_by() from this struct.

>        |                                           ^~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:346:62: note: expanded from macro '__counted_by'
>    346 | # define __counted_by(member)           __attribute__((__counted_by__(member)))
>        |                                                                       ^~~~~~
> 
> ...

