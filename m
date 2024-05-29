Return-Path: <linux-rdma+bounces-2667-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C49C8D353F
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 13:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6CA1C21928
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 11:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18054169ACE;
	Wed, 29 May 2024 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j4ee+3IG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459BF168C32;
	Wed, 29 May 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981270; cv=fail; b=MQcTwHo4275owes//VWOLcF8haoc1wS/Wkerk9ipjJ7wJv431CKX/NZ2rljmkbtXqBDcWjNTVt+FOcFjt1EU5n9Wt+ql8NBJnoRwAFdJ8PRDrGIgmPnYGU0xAl3DAtmIdZtEfLuYj8I1FjLF6QYZSPl7AoVU6UGZhqqIzbJqX4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981270; c=relaxed/simple;
	bh=8OqzsGLVcE2/pN/P+GzdKzEy3U6oiUwz0QrEnFFBwXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H0WCus+3ll4pfTc7imUFF3xaiOrZUKfXHLrHPxYnSIAPRIRxgzmTRSrlJkZBSTTKJSCY2vKOQpAE5QKVIBMjIm6F0q3JSTpr4kRHisYo1soxPIBOT5uqZigfEfbSACGO+Libg2E+/KSrpfZ84UeeFNnLh1PaWCq4isQwj5ti1Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j4ee+3IG; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEkJk0doeOGtc6SqBF3G9upKKXh4sLnEODjuPF3bUKqvtz0LfwyCwLa4fCpkPXyj9CakrjV6L0oj3EAt+zsNAn4XG0bBi4YO/jO69AbDOlZ1jqvmhhK+wBgkx78/I35ACemIhv+tRuLDzDTTd7w/YqSSDpifWTgYw7h7pevOP0i9JqWd5RlMrxLPF/MP1fuc+aDXm+J6BEMP1bzsMwLgRFcaZCoTIt4Sd+dFqQgZtVRTStaULX7SIaG6ZnLn5n8YqU0Ki4UOJ4NuHpJ6BmM1+b11VMe/CKVtB2JvBQDmwb9F94orL8i9wAZTYpshWSMkaAiSBefPcE7JCFNNFVwQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yh8mS/IWoKBVXXNc7NuZ3tthRxrYsquzRI5Um+dgs2M=;
 b=SDg+0136vmGBGYZEzKRGKa3IpmcPmvYHxvhtR+MnC5o4W2qr4bq1oCy+Jj6RBQjHpsL6Dx6TMIrEKEhbtsmPbHvNq2o4soBcf6Q1h73CkLnJuJuSXPrSBex3NBrFapO0x8gnqLNAXeWZ8CWkE53bKAC8MAcF9wgYmG1DfftLrAKir68s+luIc1Zt8CujybmdKzU935VaMb4hw4aLnxNkuZ4HzoWWP1CbePUAMYLQ6+2RbX0ObtvEN7K95vK7+iDZBFUfuf5Cyg7M5oxmBc3dmG0zpj91+9S318PcCRtvi0z5cVgl7WVTbdNyjospZalT2Dcv2nloFdiuqK8LqACyIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh8mS/IWoKBVXXNc7NuZ3tthRxrYsquzRI5Um+dgs2M=;
 b=j4ee+3IGlSuLKN1NRDxhfAaB01IhVicliRr429LORdzU1S3bJ1djC5gBpSZ1K7l5JP2mREkH/EwvEDNFDRxVkiMotlfempTRKE79lOOd50CW/MDvPnI+s+1g/bWt7HtpUyKffhEvB6zSWj/2OS/oWNKVrgKX6UB4ipMS6bcq+kPbeJvp7oglAJow+hP0L1AOGcLEJpgav8sd+bzWI3bH11dfqTo/9r6kGTnl3UhsSWUCotJ3Unw2s5UfjKgO8FAkyHNXoTAyasuosIuFVf1jjn7OFW+ML25ZyxAjOm72q4y1rPjKd5JXoZfqXw7o1EZWZJpt8poCmjrwiT35SGl7Tw==
Received: from BN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:e6::35)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 11:14:10 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::98) by BN0PR03CA0030.outlook.office365.com
 (2603:10b6:408:e6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Wed, 29 May 2024 11:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 11:14:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 04:14:00 -0700
Received: from [172.27.34.245] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 04:13:55 -0700
Message-ID: <7b11bbd4-585f-4322-a5c0-93ff90100a88@nvidia.com>
Date: Wed, 29 May 2024 14:13:53 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net/mlx5: Expose SFs IRQs
To: Parav Pandit <parav@nvidia.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"david.m.ertman@intel.com" <david.m.ertman@intel.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>
References: <20240528091144.112829-1-shayd@nvidia.com>
 <20240528091144.112829-3-shayd@nvidia.com>
 <fb037803-0002-4d91-9c9f-bbb233490acb@intel.com>
 <PH0PR12MB5481E8C0312FF6A6231F5E26DCF12@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <PH0PR12MB5481E8C0312FF6A6231F5E26DCF12@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 425ab258-3483-4722-b5d7-08dc7fd076ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|7416005|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2hFUmcrNkdURFpVS1R2SGRUcWQ4Z2tIc2JZbVpnTzZQbU5CcTRrSkN1aUty?=
 =?utf-8?B?WUE2MTZ1UTlLYzEzL2MxMHdXQ0dPa3o5cEE2TjJCK3RNM1U1L1V2Tmd3ald4?=
 =?utf-8?B?dVpmOGpFVmx4ZVlvckZaRjFYV091aDBrOFRTQlhTU1NvSW9RbzNDeUxEMWVn?=
 =?utf-8?B?QTFVMFFHaU8vbXdhN0U4ZGdncEw0WjZieG1sdWZmTVd6ZkdhZkJGSlg1OGVs?=
 =?utf-8?B?QmU3RGk3aE9yRk5rRm1aL3FJeWttOTcrYk9CZ2lLZFJkWWJJYmZrQWNURE1p?=
 =?utf-8?B?amlXbTZmWHViNHlTT0J5SFhNL0k5L2dhUDhubDFlclZKQU1LSndVbHF0Z1pJ?=
 =?utf-8?B?YjR6SkFmb2hySkFZcFNwbll3Q2NiUmY3RVpnUXVQZFBhZWlRRVZwRituczA5?=
 =?utf-8?B?cHVLakhKZzdjcXROcVNZL3Y2V2ZJaXk0VkZEa2pCWlUvbzFVcjZRaWl4Vzhh?=
 =?utf-8?B?c3diUXNIL2t6Wis0WWtFbzJpcll2VGhtOS91Q3pGK1RYbW5PV3pHUExHajRu?=
 =?utf-8?B?KzJHRldsOGJ6eVQzclRleTlqNjM5aXNlTEpxSFFGdkdtVitFNkNWQUFSV2pC?=
 =?utf-8?B?cTN1bkZEcTA4S2M5TmtOZ0xIVEZIQ242YStpb3YxUHA5UHhvWnpBV0E4Vkw1?=
 =?utf-8?B?RTd1RzRLL1g2WUJKNjI3TTNBQnJZdUJPRk80NDh5anVPRG1GakRyVGZ4NXJy?=
 =?utf-8?B?YlNZa2x4V2RuNzg3R1I5elpOcjUwUm9Nd1JoTXhXcW9JN0ZkeEtrZGhUeUN2?=
 =?utf-8?B?YmNsbDlUMmVkU2s3SzJQSzYxbVRZeGJ5ekFmcmxhTHVEVkZxY0hJZkZlb2hv?=
 =?utf-8?B?RUloUWhlOVBmQTgzbDhKd3R2ODgrSEgrTEN6Q1JnYjNQQ2dmU0JzYnhSaW9Z?=
 =?utf-8?B?cW9YZkpVcXcrTXNaVndMaDEvK2tZd2V5Y3g1eFJ1OGY2aEc3M3MzanJDU0xG?=
 =?utf-8?B?VnpPZk1XSEtSajcrSWtiMDRVM0h3R0orT1FiM25qa1lJRjAxLzlPQmkvRmk2?=
 =?utf-8?B?YTl0Q09kU1VTb0xIbUtBc0JsdGVFREtjbmNZYUY2RU9LdHFFWU5WT3Nkc1o5?=
 =?utf-8?B?WU5yUHhlV2hQcUhjWnBQK3gzZFQveWJyUS9WWXdDUElKdWJIcEpvWE1GZVJL?=
 =?utf-8?B?R1FNVHVTbkd0MEdvbDBqV1ZIQk9GdFlzZlpMZ21HMGZkODBYdTRvSXU5Qytz?=
 =?utf-8?B?blJVM3NWbE5SNFNmTFhxTDZFNVc3bFp2NHlIVnUrSWJ0NGhDR0NRMTdWZGU1?=
 =?utf-8?B?YzZaOExhdnluMXpjWjNDUmUvYUszZE1KdjlBVEZzT1N2dFRRc0FNdTcxYWg4?=
 =?utf-8?B?SDhvb1VtQlFyWXY1U0tzVW9nSit6RG9PMGRnWmgxN2R0WGdEMHZORFRab09R?=
 =?utf-8?B?MS9ibnRGZEFydStwWjVHV1BaL1Y2czB2ZGZidU5EVEZBb3NIOGtMQWE2aFdE?=
 =?utf-8?B?N1ROaW1CMFBmdVVzNXREVnZBWlppT0NndlNUTyswSG9aOGU2ckZyUng4YkQy?=
 =?utf-8?B?VS8vTTh4YXNMR3VFRnFWTnRSdXJkWk1ESEdmWTIrOERzODIrbVNEa3RJWFBk?=
 =?utf-8?B?WVkvSlRxTEEyVUQ5REptaGpSMXlXNnJOU2dtN0VxS0pZeThoNmhnS09SVVZj?=
 =?utf-8?B?Qkc4azJ2VzZISElFTURBUGc1WU9CV1d2Y1Y2bmVweWozamNpV0JPNDB1dWRk?=
 =?utf-8?B?VVBZZHFmN2E2RjZoNWtERU90VUc2Vm5jYU9RQ09ncnp5YmRabk1VajZOUmVT?=
 =?utf-8?B?MTJ4Y25sNU91WERueCtVT21CS05SRUNzaTUrZFRNOGdGcGZlc2Nka0hMbjVV?=
 =?utf-8?Q?UGhOZCNmmLlqiRmqybNyCnBaWjsQsAzQikT+k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(7416005)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 11:14:09.9609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 425ab258-3483-4722-b5d7-08dc7fd076ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451



On 28/05/2024 17:51, Parav Pandit wrote:
> 
>> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Sent: Tuesday, May 28, 2024 8:18 PM
> 
> [..]
> 
>> mlx5_irq_get_index(least_loaded_irq)), pool->name,
>>>    			      mlx5_irq_read_locked(least_loaded_irq) /
>> MLX5_EQ_REFS_PER_IRQ);
>>>    unlock:
>>> +	if (mlx5_irq_pool_is_sf_pool(pool)) {
>>> +		ret =
>> auxiliary_device_sysfs_irq_add(mlx5_sf_coredev_to_adev(dev),
>>> +
>> mlx5_irq_get_irq(least_loaded_irq));
>>> +		if (ret)
>>> +			mlx5_core_err(dev, "Failed to create sysfs entry for irq
>> %d, ret = %d\n",
>>> +				      mlx5_irq_get_irq(least_loaded_irq), ret);
>>
>> you are handling the error by logging a message, then ignoring it this is clearly
>> not an ERROR, just a WARN or INFO.
>>
>>> +	}
>>>    	mutex_unlock(&pool->lock);
>>>    	return least_loaded_irq;
>>>    }
>>
>> [...]
> 
> I clearly remember discussing/reviewing this internally to error out.
> Without it, we didn’t add the entry, but we will try to remove it where the remove function does not expect an error.
> 
> Shay,
> Error unwinding should happen when fail to create the sysfs entry.


correct, will fix in next version

