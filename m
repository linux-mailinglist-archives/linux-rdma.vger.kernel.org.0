Return-Path: <linux-rdma+bounces-2319-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 860A48BE762
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 17:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95020B22E93
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1781635B0;
	Tue,  7 May 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QCDX8oWU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00303161336;
	Tue,  7 May 2024 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095323; cv=fail; b=l6sKkj82KmF0x71paXH8Y2FYDb0+BEo22D1YiffOjEPyhi6QXbwU+MGOxkp5W1cXSXN2VtRIc6wWRYOwH/c6cP6zEJ/dXAU5yUVv01w/K1xT1U96ypfjXIe7tzv9P39vp51w9K+3Si53ugaueakrpPkqcRacZel3J0daXn9PI+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095323; c=relaxed/simple;
	bh=BbZ17rixxzvoaeYNUwaXWRunuf3629Z+Jb/2hgKvZus=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gRcK5eMh1wJcihum8N3R5H89un0XuZQO/9QtVPS0fg+ysoCGxVAXFawIpQ5EYFg/XOsEwDNz8UrrLxTjI0L+rq7W78QYKz6/CVMqSsi6ARo4j1GryZR+232mmcBhI0fuG/dRTEcvPCr75EPIPOh3+mlX2BsZPr8YhplEBzs7Suw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QCDX8oWU; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD3MuN8I+Nyr886f2721F7wG3DAKA/LC9pXYF33/x+SydS1RBwuE59n/VgP3w9BE9WQa5eKpDhRRTYqRLf6yirAavRXevh09pbsdUKQMTN1HzTPWqD9uLLhr4VqDR6v7btGgEQuKImmL8GSwPRUJH7Vn5bJF6ajwWOT10Yb4uet/y9gw7xm8VOXFNWpV0zkU4aDvn79/WRvLpnhG3hlgQlOvSU70PcnFA1ssPngGjBeVt8xGKNmYE8oLLg1EzmI8GwzulX7KaJLsjqB6GJsK5EOH8pzXyfb6EgznwFPQSeu6ARwtUzNWyynls8mLgmFiHSX0XOEFqwNcEI05Xv6v4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWYzFlz3t8EUY2uKW6bYXWhA/zBv7bnZa54B8XsFVCM=;
 b=Nc5Vt0BZEpKMHGep2fBQqpYZhy8Duo3HRA85eZZkRi3IvojcgvukCBp5bXDVyO5C3ZNDD16KMS/ikN7pRDVMyuL42vidP6Hks6z/AYZc0F+Nm5nDAPclp1Nm6aXSfw9zzD2/8xEE4gCx8XweHZByPlrTKhl7zRj1CSHtx9RxVJpQEq0pqaE8ll8WEAt310dDq83FGBrMWo8BYo76LM8+ZqUCUKAtQGbsEVjRGtff5Qzc8amPl2i+v/WJXig9PDH5P1nulsGGVMcZNNRySOAkuHSw2GVqBUSD4hS7Fy8e7cNwIhK6tXtOMHscqsQ353KnvkXq4AvgWB1jhznUEGzg0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWYzFlz3t8EUY2uKW6bYXWhA/zBv7bnZa54B8XsFVCM=;
 b=QCDX8oWUTneuftPSosMzKEHE3gZbH5S/Uf6qdsUNEvT3qL1vJvGb5/adVqQhmjlG2eydxuPdJdLqIBjW8pAm/Lvgy8h0evxmTPz2twA+YztO7d+1/1YX4rFb+nmFKGZgo5/jy/PqW+0rbsu6ftGWGcsnIx9Z7f8Lc+P4KAxwoGF7ohYJCe6msg3Jm4Pi1Dkf0i9ovXUrZUgXhE8z1LEvaS5g55N+OPzMIHJg0UNhH1SsCzFUStq4tb5T0s2MqdA1BXGdtB9uZCfxsrwOlkh5Gpx87I4VHoIwokeWSGpqHIOlClWpf54pNOA2mShfehs4lq7Fop1MdOTo2GeYexskiw==
Received: from BN1PR14CA0026.namprd14.prod.outlook.com (2603:10b6:408:e3::31)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 15:21:59 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::c1) by BN1PR14CA0026.outlook.office365.com
 (2603:10b6:408:e3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39 via Frontend
 Transport; Tue, 7 May 2024 15:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.0 via Frontend Transport; Tue, 7 May 2024 15:21:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 08:21:34 -0700
Received: from [172.27.34.221] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 08:21:29 -0700
Message-ID: <2a731889-656b-44cc-a596-518b10b5cf81@nvidia.com>
Date: Tue, 7 May 2024 18:21:25 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Parav Pandit <parav@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"david.m.ertman@intel.com" <david.m.ertman@intel.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>
References: <20240505145318.398135-1-shayd@nvidia.com>
 <20240505145318.398135-2-shayd@nvidia.com>
 <PH0PR12MB54810AC135B9810C9BC32C8EDC1C2@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <PH0PR12MB54810AC135B9810C9BC32C8EDC1C2@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: c62ea349-0df1-4796-f5f9-08dc6ea9702a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|82310400017|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3VDcjNPOGdzYXFIQjB6aXo1R2N0UmZSU2pzeFM0VHQ0QXkvZ2FwdUI2cWRn?=
 =?utf-8?B?V3A4c0tLeHFXcG4yOTB3S3hadUMzTHRuVUk4VXRKREdqbUp5SU1ZQ25tTUls?=
 =?utf-8?B?djF4Y2JiYmVxdnFyend0ZkY3OXV1OGFVaGZoOVQ0ekJxdE5vWHVUZ1dYUmtQ?=
 =?utf-8?B?bXluWEtmQi8yK3BGbHhCZGpDQlVkaXUxVE9vRTlMcjZWSzc5Z1Z3STJaZ3Nn?=
 =?utf-8?B?cmhqd0c2NGlYQnp3aFhuTTFKNVF6YjhBaEh3R1B1eEVEeW00TXVkUGk0aHB4?=
 =?utf-8?B?OGxLUXU3Z2NNNjJyemZsamdGYWJQRVEyK0Q1Yi9wM01tK0VPc25rRnJicEdt?=
 =?utf-8?B?Z3lWcHJreHd6K3IvbnF1eHpDNUtmcU9LMkF0NjlKZDE5QkZVemZvVmVpRmxX?=
 =?utf-8?B?L0ZucUFNZmtCSHpKR0o2UnBFd25mbExlaDhJNVZ1ellGYXdyTnc5TlFVYjN1?=
 =?utf-8?B?R0o3V01xdEphMEpNNVB4c2pEU1A4eWFVNVgzK1ptRUJLdTdBRCtmeUJlLzlh?=
 =?utf-8?B?NlNwRm9xbTAxZjFzWVpnYjIyam9EVUExcEdxbWZMNG1wVGFpclMxRm5nUWcx?=
 =?utf-8?B?QW1mcEY0MW1DaEtMVjRpWHFTbzNoLzdieG5venpvY3NUclFjQVl2bStpOUVa?=
 =?utf-8?B?OGJhTWZxZFZtcjVJZnY0cUREcWt4NSt4QlZLQy81QVd2YjBySnNRbWZNK1Vv?=
 =?utf-8?B?YjdKc0puZHhDWnlpRkVDMmpWbzliV1hhaC9RbmJDYStydk1wRkVUM1p1MXZX?=
 =?utf-8?B?OEhpYmRMRXFoRHQwM0EwZnZid3Q3TkZ6bmZSZ25EdnlsT2FiYVJsOEhLOC9B?=
 =?utf-8?B?MFRHMlQ3R2ZJeG9iNDZwaDl4SjZhcFZvRUZrNG5iTGhReDBJMFVDZ1YzR3dR?=
 =?utf-8?B?RW5OYkowRU1Kd1RxMlRucVFKU29rcE16bGV1cGppc3NkYWpLVk1VbUVlTTZ5?=
 =?utf-8?B?TkZpbXB0Wk5ldjQ2WXh3bkFVaFlCZE0yaW4vcEVZUFNENVNtdGhiTVdBZjRI?=
 =?utf-8?B?TVQ2VWd6TkF1Z1hISTJaMXN0Uk9qeDBQYVVCSTlyWFVQUUtydy9rYktIaCtB?=
 =?utf-8?B?bkZQbnZaVkoxK2NmYUtjMWswM1EzU3Y2TWZIYks4TmhQQzV6S3k0QXFVTHI2?=
 =?utf-8?B?SWtTNzdpZVVPUzg1elRJVUJpMlVqWlMvb0tKZ0JUcFQ0aytBUyswaVhnN0J0?=
 =?utf-8?B?TnI5UWdMdGhseCs4VnY0NytYOEJzVnF3RlpYL3pna09WRUIyTG9iK0IxMWQw?=
 =?utf-8?B?VnpjNFdOMVZlU3hJMjVwSFhqSlQrOG1BOVg5Tmc5MmQ1OUR2WGZxeTl3djBE?=
 =?utf-8?B?TEVlRTUyQ3hreUZXbjdPS3lRVTg2RDZLbk8xT3ZYNGFVdkdnUHhYRHVWU1V6?=
 =?utf-8?B?TkIvSUlZWUNOQW5SNGIwak1LUC9LSVNIUzR5N0ZlZkpDTDFnODlLTTIwZ2lQ?=
 =?utf-8?B?QWpHVE5sS01oTWdGMGRnbDhEQWE3YUZFSVNVRm9CMy9JNFdRZ043c3hJNy9G?=
 =?utf-8?B?WXhtdmxHOVdBdUtSS2dXZVVrZ3QxOWF1NmQ3NmFzbFIrQmtFcmo0bWJlSDBz?=
 =?utf-8?B?SDZiL09aY3NGNUZ2WjFTMkxneFB0OEFWQ2xYT0o4NkUvcE9XNUpLMkdyd2NM?=
 =?utf-8?B?Y3BQL2NVTENZOXd2SktERkZoZTVGSXV4ZmdBa3NPbXM4UjduZEVxcjdHRVdV?=
 =?utf-8?B?SWRzdkRFUDVkL0toaW4zdHJna3VLQk9qRExQOXdISHlKWVE0VkVpN2JIelRl?=
 =?utf-8?B?L1JxdXA1VkdUWC8wcU10cE5iOGtGeDk5dGd2cU0zYk1ZNXhIYjRzVHpjdVhM?=
 =?utf-8?B?NTJ2MW1zQjRCYkJtU0JhbVZmT2h3TkpLV1FETDdyWGxUZjVuME9RWko5NW42?=
 =?utf-8?Q?txxKM7YOdojkD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(7416005)(82310400017)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:21:58.8128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c62ea349-0df1-4796-f5f9-08dc6ea9702a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108



On 06/05/2024 18:15, Parav Pandit wrote:
> 
>> From: Shay Drori <shayd@nvidia.com>
>> Sent: Sunday, May 5, 2024 7:53 AM
> 
> 
>> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
>> index de21d9d24a95..fe2c438c0217 100644
>> --- a/include/linux/auxiliary_bus.h
>> +++ b/include/linux/auxiliary_bus.h
>> @@ -58,6 +58,9 @@
>>    *       in
>>    * @name: Match name found by the auxiliary device driver,
>>    * @id: unique identitier if multiple devices of the same name are exported,
>> + * @irqs: irqs xarray contains irq indices which are used by the
>> + device,
>> + * @groups: first group is for irqs sysfs directory; it is a NULL terminated
>> + *          array,
>>    *
>>    * An auxiliary_device represents a part of its parent device's functionality.
>>    * It is given a name that, combined with the registering drivers @@ -138,6
>> +141,8 @@  struct auxiliary_device {
>>   	struct device dev;
>>   	const char *name;
>> +	struct xarray irqs;
>> +	const struct attribute_group *groups[2];
>>   	u32 id;
>>   };
>>
>> @@ -209,8 +214,19 @@ static inline struct auxiliary_driver
>> *to_auxiliary_drv(struct device_driver *dr  }
>>
>>   int auxiliary_device_init(struct auxiliary_device *auxdev); -int
>> __auxiliary_device_add(struct auxiliary_device *auxdev, const char
>> *modname); -#define auxiliary_device_add(auxdev)
>> __auxiliary_device_add(auxdev, KBUILD_MODNAME)
>> +int __auxiliary_device_add(struct auxiliary_device *auxdev, const char
>> *modname,
>> +			   bool irqs_sysfs_enable);
>> +#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev,
>> +KBUILD_MODNAME, false) #define auxiliary_device_add_with_irqs(auxdev)
>> \
>> +	__auxiliary_device_add(auxdev, KBUILD_MODNAME, true)
>> +
> 
>> +#ifdef CONFIG_SYSFS
>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int
>> +irq); void auxiliary_device_sysfs_irq_remove(struct auxiliary_device
>> +*auxdev, int irq); #else /* CONFIG_SYSFS */ int
>> +auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int
>> +irq) {return 0; } void auxiliary_device_sysfs_irq_remove(struct
>> +auxiliary_device *auxdev, int irq) {} #endif
>>
> Above definitions need to be static inline and should under 80 characters.
> Please fix them.


will fix in v3.

