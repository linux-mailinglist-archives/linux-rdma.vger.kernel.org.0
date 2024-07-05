Return-Path: <linux-rdma+bounces-3657-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D4192816C
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 07:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C08285885
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 05:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F62139D1B;
	Fri,  5 Jul 2024 05:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WrxgeWh4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4F14AEF6;
	Fri,  5 Jul 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720157761; cv=fail; b=POs8vteJd/DJv7CTEZRDcoBlZ8kvLGnJfS3oHlwfmSaG3dnTTvdpOWjC94Fl+yWuvmESem/PbAX/EITchGMF9l//paXzpybFuidpLdmnUlhKylyJzl1rJK1cGRALLcl3coG7wVQvY/ysAKZWEpEwlLuQAsvtde0mugGLlZL2zzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720157761; c=relaxed/simple;
	bh=7FgQI3FwJ65R5Ix+ARXEyiZPDsfJXcVcmvLYLJFbiFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OKqF84CkhFqUFTnt3YTwvZodY1aZ/4KvEwFyG0pl5xoK/vZ/hMKroQH+0T36rGSe3ARjhw7Bz2vr8Kdm2mcLZgpYBvUcrBCkOmQVNOG00QfHFRWFhSszr38FbzmeMhNSgPiZGYUZjTLuJfJ7zaWLep+y0/Ny0U7rjXCfylEd8Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WrxgeWh4; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0kyANyKDAzW9nQS/q0JtytymGlzZIAj5tZLuc29MSnO1fG45e0zDjy8ocmN/ZTSvQqwMMLB86W6986GaQcAfHoOJyGcMPXEdA/IBd7YDKM06D20QuLK32KOu1R9/8QmMN1wqfIgXupbi9zo1kUamiK07CxHRe9EzQHIiCh3C35WfKPZVdhhe0OoCb5w+pcInrk+i4Sx98pcw2fZFjUCPnuVwnanlBCzt5uXEVKYUESKmmRRFEaoH6dJATk0NrJaQDCo7vSbrlkeT+kGkwh0ntUxB2z1rYE4xneVFDPXosQ9DtMpzfT563+qqgX+B4YYBGmPrR1d5hkRKPMMzu4HLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrG099IWRGB+JWe4Osbr23IlXXucAjC6HdYMmMbQboE=;
 b=VLwsbZajpGBWpkb8WahwQXatu/zDbyG8sxE/ivBkuekJ/qq7PSY00IiyZfSG+4ZvM4RlEVnNGyGjzL9s1bgrTNskz14JlpkE0VRHZ+z3AHIW2dVwi1pSxk1QJlJYX4TDVVEqn7sFKMC1cf+BAwwu5czaPP7aWGQfjjZ+ipKuqbiRHzZ9G/D1UyP6YY7SYIw79HFlwj0d3MKwDC2msDfhhOBsQkoWIVtJR25oEbG5bg+5H0+I5R1tui0HYdxcVryLJmb0yZOow6KXUKLUQnIG+U6SRva21SZors8MitZeL/2zdFGSwc4ISRQVqCnXa6H3/qzJhJ6OWxus93davE7PzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrG099IWRGB+JWe4Osbr23IlXXucAjC6HdYMmMbQboE=;
 b=WrxgeWh4VQwGo83XyvOPtDlKgFoNl2kquff2t+NDs5Wd1R+9WaOE7MTS0pXVL0heW8nOTN9K4zDtkwP8QIJ35ipYn1NCWuTl+Jq4goboCQUskeDmch65JyeiWaP2J9Bs10rudtDoy9zaU2dVIof03aAbhv6ZfZZLuroxJixSUPSxwbctQcPtH6TXnAX5xMAwr7OQWc1BjryxgC5TZB2+F4EbjSS3ltm18xtqPiosK3x9VD3UrgljV2KbKWwWu8qoyX17tGJ2TBDYnp2dfCEBmd0CocShAKqlmOuWoOIVi6cVZi+PgH8YHaAqWANp+e3d+E1FOhOKyBWdknuNWTQELg==
Received: from BN9PR03CA0621.namprd03.prod.outlook.com (2603:10b6:408:106::26)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 05:35:56 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:106:cafe::a6) by BN9PR03CA0621.outlook.office365.com
 (2603:10b6:408:106::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30 via Frontend
 Transport; Fri, 5 Jul 2024 05:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.1 via Frontend Transport; Fri, 5 Jul 2024 05:35:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 4 Jul 2024
 22:35:42 -0700
Received: from [172.27.59.38] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 4 Jul 2024
 22:35:36 -0700
Message-ID: <c2f4a607-2840-4468-9c16-2edaca7844be@nvidia.com>
Date: Fri, 5 Jul 2024 08:35:33 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Greg KH <gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Parav Pandit
	<parav@nvidia.com>
References: <20240703073858.932299-1-shayd@nvidia.com>
 <20240703073858.932299-2-shayd@nvidia.com>
 <2024070457-creatable-heroics-94cb@gregkh>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <2024070457-creatable-heroics-94cb@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: c1abfc83-8344-453b-a457-08dc9cb457dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWdadFFJeGtrM3BjMnV1dUdubm1hZGhDeCtLc0xEK1g2ZVUwYkJncFl2dWl4?=
 =?utf-8?B?M0YvSXRJSVBXVkR6d3BjRUgwbjhDcEtDSk5FVHhtWVowMU1yQms1SWpSS3dy?=
 =?utf-8?B?N0wrcTIzSStIY0lLVS84YWYzaUxlY3llNTZzK3lsM1p1MllIcUdWOE1HTFJ5?=
 =?utf-8?B?dW0zWWpGUW9MUi9wQmc4RmtVZHFNcGdTekx3MVdLencveUlPeGdRWm9aUVJm?=
 =?utf-8?B?RUxHdVd1dG9WMXRrS2k2b1BDbWhQa1h2aVY4bmRySkVTRC9VamRVS2xaUDlU?=
 =?utf-8?B?Z3UzMHNJZzN3TllDMTJhaGtxSlBHMThhNlVzdHdaWVNHNWo5blVMNndIODVt?=
 =?utf-8?B?WmFkL20wZDVVMWFBRDd4a3Fua2hzWHJnR3VKdUJRUHJmMkJkaFU5bjdSSSsw?=
 =?utf-8?B?V1NCTUVRVEEvY1BEQThlUFZyMzd2UjAwTG51c29Eb1RBOW9zdEtSeWcwU2lu?=
 =?utf-8?B?cUtCaktqL1VUSjZ3RFI4S0Q1RkhWWDNsYkQzdk1rVFdFcE1Hd0VnaFFhSUpL?=
 =?utf-8?B?ZDlCUmkrVk1OSTJqYyttd0FneUdQend2eGkrWVdDVFUyYURxYzRUS253U1VS?=
 =?utf-8?B?RUVQY2ZXS045a1lsTFROQ0kvOXA1dno0ejJ2a0tjdWxtS3pmYWE0QjRNTmQ4?=
 =?utf-8?B?WXlPRlRrQ01XRVpiRlV1aTNuaTRwR29iOVJhNTl6YzdWYmRkUHRHZkhOa21n?=
 =?utf-8?B?NktqaytlL3ZHMUJBdEdHL2tJQkxaK3R6a3YwOVNmS0h2SVpCWCs4YlcrYlpa?=
 =?utf-8?B?Y0tKV0NhVFJQb0Uyd3g4SlhkRmcxdUd1NTY1TVJjR3l4Y3R3OU0ydkkwaHZV?=
 =?utf-8?B?MkNweXE3b1lOdzYrU1UzaUVLSHQ4dThJME1aWGx4OXVCSlJicWExdUtQNmJ3?=
 =?utf-8?B?Q2lpYnM2QWdNenJJb21zQUlxRVMwQk1BdFM5bldOS0xaODdoWTZuZWVQVTkz?=
 =?utf-8?B?UlNueklkeDh4T0c3ZlExdVNtUVlUS2VCcXpYdlpJV2xSZ2FmV3l1c2tQMmp4?=
 =?utf-8?B?RjlLWHNyakNHdWg3bGRxZmdEQk5xWEp3NFlHeWV3Rnk0SWVLMjd0bmVOSFZ6?=
 =?utf-8?B?aDNxMnBxYzg5dnZZTTY5bGs0TzdXY0ozQnRIUnJJTitSZ21WdVk4UDlTckh5?=
 =?utf-8?B?MmcrZ1MvK3M0eFlJelZESGlzRlhJSEIxdGhpY3hoMm9PcjdDWDZ5S2FYdkRu?=
 =?utf-8?B?RUdJTUVocy9UYkJIM2JZbEFBNHZyaVFEbmt4TDNtbHg3TGJHZEMzUXBaRHlL?=
 =?utf-8?B?ZGcrNXp3TVBNR0VtUGZaVmU1b1A0VldMQ3phTC9ScmpJYmFmNUhleG9UMDVG?=
 =?utf-8?B?b0U5d3NtVUNMOS8xeURyRkxGUXp3RWtFOWNVaDJYUTloZ2cyaTZ2V2w0MitG?=
 =?utf-8?B?VFg2dld1Zm4zMy9ta2RFTjRXazd1YUR4Q1p4ZC9lc0dmeVluU0VPWTFQdFBi?=
 =?utf-8?B?eC9yTTduaFhNUVM5YjRNdVM2Z3kycjFqRTBWNllwTno5cy9GaUsyRGJRRkp4?=
 =?utf-8?B?SytKZjdScm5ZV3VGaVJTbDBoSE9yeGNvMmN3bDR0RFZwdHBESUwzRnAzd2Vm?=
 =?utf-8?B?TlRQK0toRjR6Y3ZLQ3F4aFArN1UySXJXZHlKa09QSUV1WWZNbTJWZW9JWENx?=
 =?utf-8?B?NzhTVzdNQ0NLS1J6clJCRytUdTdGZitLVDVnNnBDWmlpSEkrUHJyMEo1ZVJH?=
 =?utf-8?B?ZE41TkJhUFhOVG1HNzNGQ2tOcHhKdE5XUi9hc0RVMi9HRVJpei8yVjZDWVJi?=
 =?utf-8?B?eGI2NzRGUVFuZVExcTNiV25GOFZjUStHdE5FQS9kZm44cjhobkc4N3lyMUg4?=
 =?utf-8?B?cTlnY25hekhDeUFkbnErN0RuNXdNMEI1S2d3QnNHS0c3c2YvazdQWDBSNDBQ?=
 =?utf-8?B?Vm9oQjRlYTQ2bHBsU1F4SmdCOWJaM25Gam5OMUtiZGVGRnFsRFRNUWRCWWEw?=
 =?utf-8?Q?PycCCVwb3LbckJ/csgP93RKTKr4j8KaK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 05:35:55.9704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1abfc83-8344-453b-a457-08dc9cb457dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354



On 04/07/2024 13:41, Greg KH wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Jul 03, 2024 at 10:38:57AM +0300, Shay Drory wrote:
>> +/**
>> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>> + * @irq: The associated interrupt number.
>> + *
>> + * This function should be called after auxiliary device have successfully
>> + * received the irq.
>> + * The driver is responsible to add a unique irq for the auxiliary device. The
>> + * driver can invoke this function from multiple thread context safely for
>> + * unique irqs of the auxiliary devices. The driver must not invoke this API
>> + * multiple times if the irq is already added previously.
>> + *
>> + * Return: zero on success or an error code on failure.
>> + */
>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
>> +{
>> +     struct auxiliary_irq_info *info __free(kfree) = NULL;
>> +     struct device *dev = &auxdev->dev;
>> +     char *name __free(kfree) = NULL;
>> +     int ret;
>> +
>> +     ret = auxiliary_irq_dir_prepare(auxdev);
>> +     if (ret)
>> +             return ret;
>> +
>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +     if (!info)
>> +             return -ENOMEM;
>> +
>> +     sysfs_attr_init(&info->sysfs_attr.attr);
>> +     name = kasprintf(GFP_KERNEL, "%d", irq);
>> +     if (!name)
>> +             return -ENOMEM;
>> +
>> +     ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
>> +     if (ret)
>> +             return ret;
>> +
>> +     info->sysfs_attr.attr.name = name;
>> +     ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
>> +                                   auxiliary_irqs_group.name);
>> +     if (ret)
>> +             goto sysfs_add_err;
>> +
>> +     info->sysfs_attr.attr.name = no_free_ptr(name);
> 
> This assignment of a name AFTER it has been created is odd.  I think I
> know why you are doing this, but please make it obvious and perhaps
> solve it in a cleaner way. 

I am doing it since I want the name memory to be freed in case of
sysfs_add_file_to_group() fails.
I don’t see a cleaner way available with cleanup.h.

> Assigning this "deep" in a sysfs structure is not ok.

when creating sysfs dynamically, there isn't a cleaner way to assign the
name memory.
The closest and exact same use case for pci irq sysfs which uses dynamic
sysfs is msi_sysfs_populate_desc().
It does not use cleanup.h but still has to assign.
I Don’t have any other ideas on how to implement it any more elegantly
with cleanup.h.
Do you prefer to assign it before sysfs_add_file_to_group() similar to
msi_sysfs_populate_desc() and avoid cleanup.h for now?


> 
> 
>> +     xa_store(&auxdev->irqs, irq, no_free_ptr(info), GFP_KERNEL);
>> +     return 0;
>> +
>> +sysfs_add_err:
>> +     xa_erase(&auxdev->irqs, irq);
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
>> +
>> +/**
>> + * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the given IRQ
>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>> + * @irq: the IRQ to remove.
>> + *
>> + * This function should be called to remove an IRQ sysfs entry.
>> + * The driver must invoke this API when IRQ is released by the device.
>> + */
>> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
>> +{
>> +     struct auxiliary_irq_info *info __free(kfree) = xa_load(&auxdev->irqs, irq);
> 
> No verification that this is an actual entry before you dereferenced it?
> Bold move...

Driver must do this for allocated irq. So xa_load cannot fail.
In previous versions we had WARN_ON to catch driver bugs, but you didn’t
like it.
I think this is fine the way it is in v9.

> 
> greg k-h

