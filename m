Return-Path: <linux-rdma+bounces-5009-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D0E97CD39
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 19:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB434285C73
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE971A2558;
	Thu, 19 Sep 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kCCG7Qrv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735518A95C;
	Thu, 19 Sep 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726767678; cv=fail; b=EcpL0iHJrWMQwUko94qktyrRRLQAj0LtfgUbXgrHLMdaAKwIfEbEACFvRkE9IHeG94yXeRPJ97F9EJRubP6j2Sk8vs4lErz7fnX/sqao/FrTqqUb054xcDGhZD9dOdJ66NwQafadZcZot8XnB0U837RKXN5qwrfK02PQZNSB1zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726767678; c=relaxed/simple;
	bh=9XdCYfQQ+lHe/Ey8wisbRbZDos1+tpDuisHPKtTu5dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DhM0NZXE2ymMOIoFeVz+stm7akVM1VXwPNSCczsO7Kb/BarmFU34+R2JjC7bEQ68KZa+nItLyXPtrJckiY8IEe0MjmeKtOR7H7qUhs00p56eCgruvVYwTG0d4FVj93VSAQer1QU7CUzRa4+sf/O+1uGI/gHwroEnG8KoJnNiPvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kCCG7Qrv; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cxu4K8cL2hK//GO2Fq8fLaUg2tmd+Z3bDDC/FGzFOvD4jYuU7pks86bcYog7cTd1dBpWmdonVaWjnhQHr0j2PK9sMe2GBU3odZ6diYb5fw22EUWiSN/cLeJplsXSEFLhoUngU0CxguuG3eCl30XE8rE+C6v0LPC+cLH1eX7u0plVaKbn594iQe6xqzX2aKxqz9+Vr0T2E5MTYNBZQxChElD/rZi63zctFu29chpHwMSMfk+B9NIRtcSPXOIBhjE2PMFESYZJtRFnpD9FANgjsI/Qh48VUWArNgL139DICUnq8D3xE8KGnN0JrekY8tVfWri/AUXNY8lfS8YUTAippw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzCBWoaGdzddCUG8hvsr91kU4S+Ofzv70VAUQNaK0AU=;
 b=JG2A1A0digK7CgmElYYW+80dndefwaIBMJ4gmJFY2EKuesd0oegxyIwVIFdINKdMZEZRLk9QHjjTqeM3sII2giZ9rtQsk4cVaqvkkXocx6AIqUy1910bPmY5N6aOH+j3Z7XD7dS6HuHx9ZoExiwMTCaW1eMvhvUA+loMRqqGPcsqRgoxqCR0dZ+tliZ7ppv6xNU+XegYdFoMCDTj1LPhupd/asreZU3vq4yYHASSOJtJMJHFtAHvVDXq1JbrUOPB0rA40Z45zeehQyWCAhpdUr9rNHxS++tJ74e4FIGFq/ucoOmRnhEI2c6Wu3RiUuu9yQbp+xEaPogrkv9CwXrmUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=purestorage.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzCBWoaGdzddCUG8hvsr91kU4S+Ofzv70VAUQNaK0AU=;
 b=kCCG7QrvuA6X2Aq/DQ92uyCUKGeznNaJPAHiQpyWl3MZzcUy9+qiBhFpKW6z55lKXUv93wx44MYgkYb0h5aPFmZ2Nu6Q6jmrdTBwH5Gh3A/BsrLd3VRDL8R1NdYRg9F/SGpLpVpk5zmhFD8vGY0QLo4q2gDvcpKU3AQHCmEjkibNz97Yi9COhDgaN5RV5hdn+oUB2I9abCg1beJwYc6Ibow+OJOd07xt2ghBPzuuzJ8JhFVCy6RULUhhsx5PSFMSE7UrNKjJmaOdvDRjGNIOSG2jJ0JjfYUwEzHEI09WjmHGQ3Qi3eaV27Pvsm4fnr0dwDbDkxjBd/m2NVJ3YSZ97Q==
Received: from BN9PR03CA0644.namprd03.prod.outlook.com (2603:10b6:408:13b::19)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 17:41:12 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::c1) by BN9PR03CA0644.outlook.office365.com
 (2603:10b6:408:13b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25 via Frontend
 Transport; Thu, 19 Sep 2024 17:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 17:41:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Sep
 2024 10:40:58 -0700
Received: from [172.27.52.179] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Sep
 2024 10:40:53 -0700
Message-ID: <3d1be80f-4195-4b44-807e-92aa674307b7@nvidia.com>
Date: Thu, 19 Sep 2024 20:40:48 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] net/mlx5: Added cond_resched() to crdump
 collection
To: Mohamed Khalfella <mkhalfella@purestorage.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, <yzhong@purestorage.com>,
	Shay Drori <shayd@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leon@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tariq Toukan
	<tariqt@nvidia.com>
References: <20240829213856.77619-1-mkhalfella@purestorage.com>
 <ZtELQ3MjZeFqguxE@apollo.purestorage.com>
 <43e7d936-f3c6-425a-b2ff-487c88905a0f@intel.com>
 <36b5d976-1fcb-45b9-97dd-19f048997588@nvidia.com> <ZtknozCovDvK7-bL@ceto>
 <ZuxePhq3V4ag8WTz@apollo.purestorage.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <ZuxePhq3V4ag8WTz@apollo.purestorage.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e40beac-695c-493c-3838-08dcd8d240b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnVlcDE4S3dLUmV2UTArKzVDd2JKdlYvZFVWN0pITWZOUFpKYXBvcFhmenNQ?=
 =?utf-8?B?Lzc5eHpYUXFWSXd2RnR6c3JkQTAvNmJGVGt2RVMrK0RvaE4weTlPRGt3N1NR?=
 =?utf-8?B?VnJ1S0JRVzBsNGJNN2pmSDJGRkVyb3BhZ1ZaWFVNb25aRzVNTTNVcDUzR0tJ?=
 =?utf-8?B?WUh4YmxNNGRFdUdwWVhzR3RHTVpIamV1WDRmakNCZlpaUzdZUFpLYlEvS09X?=
 =?utf-8?B?QlJyaWFadjJoNlNFUEUybVdHempnTGZqZWVoMmdGa1JrdXlWTFpjOEQ1RFFI?=
 =?utf-8?B?WVFyOTVKVG9leGNIVG9QeElHdXJreUtSWm9vOXg3QWNmQ0FPOVlmeUxGeWM3?=
 =?utf-8?B?ek5YVFBpVlI3N0hqeXlLUGRKVFplN0QxRzloUjhGcDNKQ25nYmdsdDZOcWdV?=
 =?utf-8?B?RVNxOTZvQndyWWhRYjBiWTJhcU1CTkEyTEE0MVJ4alB3Z1ExU3MvblhReGQw?=
 =?utf-8?B?TGNSNmR4eWFPTG4rRCs3ZzB2NUlrVE9KelhWZFBvM2dXN25nZ0lmZ0dCMVNE?=
 =?utf-8?B?MW9uOHVRSU1tVkNCZjU5N1NPazY3UTBqd3FwTVdLSnJvRHZzRzN6cXZtVzIv?=
 =?utf-8?B?Zk5RemYvV2pLOTI1VHNkRXFjMFNKVnVPQXk2VWd6TXcyenlRNWc3RUdxdVll?=
 =?utf-8?B?a0M2U3ZoZE9ra21VbkNGMEFrbG9yVVg5dnZxNjBDRmhMUnh3dnpxVW1Ha0l2?=
 =?utf-8?B?OTVVYSttUzQzVXFCQ0pmb2M0V1VlY21GSm9GK0tjNWtkbUZXQmowVXRFV215?=
 =?utf-8?B?THV6NmJLeWxuV0tEdmU1L1E3UUYwZXJGY0NrVWEyOXFSSXdwcGdYNXNlQXha?=
 =?utf-8?B?MTg1KzNhMHFlWHVLMVR4MG5CVStpNmlienlZQUhwT3pwNnFkMEM1Q3hRTXF2?=
 =?utf-8?B?WjJaQ0JnamFxTUw3Sy9jS3EyWktHVWZtME5HK3J0STEzejk1ZWlCNGx5RzRR?=
 =?utf-8?B?b0lneVkyYmhoYzNWazQ1cXg0bHBnMVJpOGR4Q3E5dlJtckxmOXhTbnRkNGpL?=
 =?utf-8?B?a01ranFPenpTYm9LdlBwakJZOVRucUdGNDVST0JsdEpkRkYyK1AzTVF2UllB?=
 =?utf-8?B?RFFXVTdvcWtrQ3RVZStNMUp6Z25VZ1ZmcWZSVk83cUxLdTZPekxNTkgxVWdi?=
 =?utf-8?B?TFVzNmFKU3Q3dWlIMGNHLzVHL2hGdzBXeEZoUXRianNxMDgzcnhwRDBXYUJn?=
 =?utf-8?B?c1ZvY1MvYk1QcTlEczgwK2NXcDU5ZmdIQUgzQmcySHpTMi9OTlZwemNkemcr?=
 =?utf-8?B?NzA0Q2FyV3lTRitERkpjcm1yTzZEdWZYNC9MMXpBZ2tGYW96eDdxaHAwUHlF?=
 =?utf-8?B?ejBSUFBoOVVvWDY5NWF0aEhjRE5RRWlRZ2RPOWZvOStkVmdjbTFScG9MeWsv?=
 =?utf-8?B?WkpIUXNOYjl6S2tBWGZXNnB2Ny9GL21qYTU3MlpDcHNuc1lrZGpTUXdmT3Fp?=
 =?utf-8?B?RmJWeTgrTFQvYXdBYU1LRHcvM0tSVzlPNlRuR2k5eDMxcldkc2V5Ny9BWUE5?=
 =?utf-8?B?eFBXZkZFdnlHRkxFL3AxY1l3bjBYZjNoR1BjK1FUWmcxV0xyeUdFZzkwQS9n?=
 =?utf-8?B?SXR3alJhd2Q4MS9idGxXdHpzUk1OMHBBU2s2NUgrdnlhTUMvQUdLQXltNXZZ?=
 =?utf-8?B?QmlnUWtFOTZSUHRId3B1T2owU0NvTi9kOXpBUTlsV1JWSklOb1NvbFRXSEg0?=
 =?utf-8?B?U3RrMUFzOHdINUl1d3ZIcTFoS3krRUlwa3hiWG1OMVFnYkZkYVFTMFliYm8v?=
 =?utf-8?B?N0ptYTB4UlRKR29ZU1h4YTR5WTU2TVZ6TWF3a2JLc1JjMCtscUJ0MG8raEor?=
 =?utf-8?B?ZUJ3Yzd2Nm5yeWd5enZFUEFYODdheHl6OFh1aFdlRy9TQ3UvaWNaTi9VNFJq?=
 =?utf-8?B?SlpvZVh1N3R3bkNWNWRFM0JoYjRWbW4wcG1oZzNYVWtGZHZ4cTJZMjFDZTRH?=
 =?utf-8?Q?0A3NFE97gB0TaiYNHXfpcdkMdFrw+Gcg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:41:11.8152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e40beac-695c-493c-3838-08dcd8d240b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392



On 9/19/2024 8:24 PM, Mohamed Khalfella wrote:
> 
> On 2024-09-04 20:38:13 -0700, Mohamed Khalfella wrote:
>> On 2024-08-30 12:51:43 +0300, Moshe Shemesh wrote:
>>>
>>>
>>> On 8/30/2024 10:08 AM, Przemek Kitszel wrote:
>>>
>>>>
>>>> On 8/30/24 01:58, Mohamed Khalfella wrote:
>>>>> On 2024-08-29 15:38:55 -0600, Mohamed Khalfella wrote:
>>>>>> Changes in v2:
>>>>>> - Removed cond_resched() in mlx5_vsc_wait_on_flag(). The idea is that
>>>>>>     usleep_range() should be enough.
>>>>>> - Updated cond_resched() in mlx5_vsc_gw_read_block_fast every 128
>>>>>>     iterations.
>>>>>>
>>>>>> v1:
>>>>>> https://lore.kernel.org/all/20240819214259.38259-1-mkhalfella@purestorage.com/
>>>>>>
>>>>>> Mohamed Khalfella (1):
>>>>>>     net/mlx5: Added cond_resched() to crdump collection
>>>>>>
>>>>>>    drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 ++++
>>>>>>    1 file changed, 4 insertions(+)
>>>>>>
>>>>>> --
>>>>>> 2.45.2
>>>>>>
>>>>>
>>>>> Some how I missed to add reviewers were on v1 of this patch.
>>>>>
>>>>
>>>> You did it right, there is need to provide explicit tag, just engaging
>>>> in the discussion is not enough. v2 is fine, so:
>>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>
>>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>>> And fixes tag should be:
>>> Fixes: 8b9d8baae1de ("net/mlx5: Add Crdump support")
>>
>> Will add the tag in v3.
> 
> A quick follow up on this patch. I posted v3 [1] of this patch with
> minor changes. There are no functional differences between v2 and v3 of
> this patch. The commit messsage on v3 has information why call
> cond_resched() every 128 iterations, so that could be useful to add.
> 
> Is there anything I need to do to get v2 or v3 of this patch merged?

I already added my reviewed-by tag on this patch you can see up here, 
same goes to v3.
Thanks.
> 
> [1] https://lore.kernel.org/all/20240905040249.91241-1-mkhalfella@purestorage.com/

