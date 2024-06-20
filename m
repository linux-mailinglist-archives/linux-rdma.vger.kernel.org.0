Return-Path: <linux-rdma+bounces-3354-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDA690FC52
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 07:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0145282A39
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 05:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DE8381C6;
	Thu, 20 Jun 2024 05:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y5wHqaeB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE81B974;
	Thu, 20 Jun 2024 05:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862537; cv=fail; b=GIMjolU9JlQoMgKg4XxA92+ScS6N7FVcmLTOkEXnze9Sj5wP5KyhA8iVkJMY9X0jhnI2FAtYdnuwmjeJU48d+HwTLy1htBRvVyQ6df6CeCZsa4pVtJcxJKNOcRnDPZ7w9gnD39hv30roWv2wcjDO0Z4zJFH3BSQcjHzWEpHkYW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862537; c=relaxed/simple;
	bh=SksYTpKFgQzRA5+5B2Mf5I3C70aaK5N2I/LRelAEyDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k806S0yyxRnZyvZm+Ak5GkPnNa2gVaGyudPclex2EfkYphoc60BbSyun4NwU/O0EQmMf05LdU35xBHTu59b0ev5k3/8Eq5RKiS3P4VYASfOO2fNvYVtPNynqOBebVAYxTIdhmqPAFUqbaeS8EnwA0Vh/f10kaYCQp0v7tGXI298=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y5wHqaeB; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQYnOxH4iUhkUwG7/EVxVPMh/L3b6eoJqRAvW8MXt4NPihUO5d+fIXVR0NlS4YM3vrYdEJCdJL1NnWqIDagc50jweIM+SkVk5WgfzI7TbCfCh1agpkKLcTWPqsbf3CfFtFLRWTGGM1fH1K7UyATqXnVgOtvGYZpX51eoLOFhg50qHdSMe0YBmgtfSZT6rXX0dHtHeqovtMDIqMtdKP1CKJxdhU75jHf2SQZTGzhZ4/ab3fRCOtmlbc26Vl1gW/1oUwaMXz1pczumdOVxezkvtQCyNO0CwQctVeYzNkvWDgtVchrNtT0uL0b6hSC0pyDIOyHiyLP6iqIfTcH8mtAbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBnBDrG/IUO1d7zS9wEPxFsf8CmDBMD5wCGemmKjgmY=;
 b=ao12sstnNbSa/322yzV9J5/irBmJGld08sIcWsWlT9nEnKVhZno3eTe3cn303JytTQ25z46W2GQ5TpXj1iT+ahYEiRfJ70xeRY0wQXKxpeXjf0lJv/F/GfgvXy94UdtiCOE+3hBHURZD/6zQEhyXnlSDqPmm4vxN0xYH1zXrhdZJdjs5JEsBjdEXibjl2nPt9exlPyLafOjnsGmF2YKgGPxA0rm6HYzjY4Vg4HzcaoDdKFAmrqDSEqvvEgXn+A9e/HMKtjwytyM0JQPPA6vQuEtVO5zSd9IRHCwK4YZbtVnFR0XMyPG+8932CrsvbLdgE6Yp/46xXLhKIpQfDqFLQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBnBDrG/IUO1d7zS9wEPxFsf8CmDBMD5wCGemmKjgmY=;
 b=Y5wHqaeBeaTSihN02I82IcA+HeDVh0n50s+vQ5iFe9Eam43JBxSz0nrk9TMIv99Qq0D8EqnXJgpPU/7kUpCAhzNUkGG/6ihXO4HKc5D7mvFpi2m4Ke7mLYLg3yrUVHehUVJYBI+YBpd7VI5PPIWkUb/VCE3UjaS2q0d2JnFIc7zPHTb7g9fuOXeITH5SYiGidQZTvfsEdvHN12l5bAR1aUOFFaRUmIg5xFDEpVGISRk886Y++BW2Py8NCoJ+6bWE47jY+9at9x7Uab/CVPS8zFHMs1JIUDs1EUDlbdBtDl08JkJ3b3VOfYsNoUiC+phi/9rtb7EgTmDuc102Ll1aEQ==
Received: from SJ0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:a03:2c2::24)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 05:48:52 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::59) by SJ0PR13CA0049.outlook.office365.com
 (2603:10b6:a03:2c2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Thu, 20 Jun 2024 05:48:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 05:48:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 22:48:34 -0700
Received: from [172.27.63.78] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 22:48:06 -0700
Message-ID: <38bba039-aa2e-42fc-aae1-26d131cf081b@nvidia.com>
Date: Thu, 20 Jun 2024 08:47:51 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Greg KH <gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240618150902.345881-1-shayd@nvidia.com>
 <20240618150902.345881-2-shayd@nvidia.com>
 <2024061849-cupped-throwback-4fee@gregkh>
 <21f7e9b8-00aa-4e1f-a769-9606834a234b@nvidia.com>
 <2024061903-brutishly-hamper-af47@gregkh>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <2024061903-brutishly-hamper-af47@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 699853ea-14b7-45ac-c095-08dc90ecaa19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|82310400023|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1E5dldBSjJvK3BTV1IwN0F4eUpsSENFZDZLVW9uS3lqajlXaWNpQ3IxT0lG?=
 =?utf-8?B?MGJROHM5bE9BM0NRWk8vdEsreDQ0Z0phMWpBZXhUMmU2dW1oMHNXTUZGbFdL?=
 =?utf-8?B?b1c5UmtZa2xyN1czOEhtZVhLVVNhZUdnZ002REVwWmZ2OTdvRVY2ZVR6Ymhl?=
 =?utf-8?B?QXRpN2JyQld0ZktjeHVud0FHb0FMOGJFQnZXOW43aHd4aE5PRkVpenAwbWxh?=
 =?utf-8?B?cnAzUXN1dlREZnNqZ0FsVnd4SmtuTzNlc1pCTWttbkpUd0grbUcyYnBRQ3dO?=
 =?utf-8?B?NXgzNjZieURrZUVLRi9QSlRXWjVrdVphL0ViQ09nK25pS3dsOVlIM2pDd0c5?=
 =?utf-8?B?QWcrTG1CT1JubERzclpoSk5wMWlxTkVIVENtcFYvNFE4NDVSeEZQaWRLUzJz?=
 =?utf-8?B?dmJTZi8wWUVqa3g3a3pKL1FpRGtXOXZYSTIweWdYOWVSWVRoa3BDNWIrdFRh?=
 =?utf-8?B?djN0NlhvS0lWZ2w5SG04K1JQRXBZUytEVlFMODNwOXh6Q3c1OHNvWU11R1hY?=
 =?utf-8?B?bDhtWEJjL1FpdzVBQVp3UkU3S0RPNlFFZUMrN3ZGNWxNSGN1RkRsdGptcE1v?=
 =?utf-8?B?V0k1dzZjbWY1VU1lQUNUaGNFSzRGUURGNk1nTDZvYnRqWDNaNWhoQzNWZUIy?=
 =?utf-8?B?aGZia2FIY2EybmZZMlRuakM0bis5VTZEMnIxWFZWU09YaDBiRjlHdllDVm5K?=
 =?utf-8?B?c25Ub3FJcCtrUlVuOG4rVXdYWklZbDhkcisyWGlibGM5blRPMlNvdDB5bzJ5?=
 =?utf-8?B?WE53dFpIV09uMjlsUXgzdmZGak1WT21pbzFGUUc4L1BqYysyMVpLdXRSTS9M?=
 =?utf-8?B?dkl5MFRBU1VDZTVnS2ZiRUNkd21jZTVpbXp1WG1pSXpmajVSU0xaSnlXNE9w?=
 =?utf-8?B?TkVaZ1lMdm10Tlk2TFBldGtZUVo3MkpXL1BPZmdHMGxvZ05oK1NYL3lYaXZ6?=
 =?utf-8?B?TElTTEdQMy9zaWltOW4wdXhsNjBKbGc1S3BRaXE4VHBNeVpNcys3c3YzR2hL?=
 =?utf-8?B?anYzc3ZMaTZVdlp3bE4vSkMvcGRUU2hCd3RQQ25iQllCM1lxTHUyVkEyUXd0?=
 =?utf-8?B?RTV1WGR4VDl3L1R0UFVDN2JteWx6bDZkZ3NCWEtVVnlMZCttb1lZMytEUDA4?=
 =?utf-8?B?MGdZdlNCK08xUi9LQTNvbGJXUENNWUZBLy9OMks2QU96Q1g3MzZjK0ZIckJQ?=
 =?utf-8?B?eDhSemc4N241R2ZVOXkrN05GU3BicVl6MzJzUVdnZ3Q0WHF2WnpWZHRJTkk4?=
 =?utf-8?B?czNGMmRFOHcyZlNEUmVVM1RBdGJhUVVyZkNIdUtGcFV2MUdPU0ROalpLb3dw?=
 =?utf-8?B?QzAxTkNmYUdnUjNRYXc1c3hjTkdZSWIzczVmNXpsZGdTQVBwYmovb044TDFy?=
 =?utf-8?B?MlFlTXVyanJLVzhhUVpDQ0Myd3JFM0l6aHpHSTRENlNUQ1FJb3RHMHNuSFNQ?=
 =?utf-8?B?dUtBYkh5SGo0MUh2NU5PWEo3NjZYTHlubEk0bXhvZXVzS3I1SjZraTJWUUx3?=
 =?utf-8?B?Ri9IL1dLUTB4U0Z6ek5QNXFUbzBYdDNUVkgvbmFhU3lFbk9QUE5FWWUyblJu?=
 =?utf-8?B?dURZMWJuK3FUSUlSL0JQZkl2azF6WTkvc24rTzYyZDlPR3hIMTBuSGYzTzNM?=
 =?utf-8?B?Ukx4SU5QRk42aVpZZy90ejJWV2hlZnFZZ2g2UXlPaVBWZlJMZHI4MnJTNEJx?=
 =?utf-8?B?K0ZDSGtFRUlMK0ZkbVMva1F2WStZY0ZsZUwwYW1QM2UzTUF5Z2F5bXpwZmkv?=
 =?utf-8?B?NkZwZjRiS1l4aGQ1WWFodWM5T0xhVDQxL20yWUpGeERJYm5XWkxBZXU0eUI4?=
 =?utf-8?B?K044SnpZVHl1Wlc2MmFaMTNjTDFQc1d0NFppUndUOHVJUElHOE1YM0FtVVQ0?=
 =?utf-8?B?Z0F1Zm0rNnRvM2RKaEFoNkt6ZnJxTTJEVFcyKzFodmQyUkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(7416011)(82310400023)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:48:51.9482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 699853ea-14b7-45ac-c095-08dc90ecaa19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313



On 19/06/2024 9:45, Greg KH wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Jun 19, 2024 at 09:33:12AM +0300, Shay Drori wrote:
>>
>>
>> On 18/06/2024 19:13, Greg KH wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, Jun 18, 2024 at 06:09:01PM +0300, Shay Drory wrote:
>>>> diff --git a/drivers/base/auxiliary_sysfs.c b/drivers/base/auxiliary_sysfs.c
>>>> new file mode 100644
>>>> index 000000000000..3f112fd26e72
>>>> --- /dev/null
>>>> +++ b/drivers/base/auxiliary_sysfs.c
>>>> @@ -0,0 +1,110 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
>>>> + */
>>>> +
>>>> +#include <linux/auxiliary_bus.h>
>>>> +#include <linux/slab.h>
>>>> +
>>>> +struct auxiliary_irq_info {
>>>> +     struct device_attribute sysfs_attr;
>>>> +};
>>>> +
>>>> +static struct attribute *auxiliary_irq_attrs[] = {
>>>> +     NULL
>>>> +};
>>>> +
>>>> +static const struct attribute_group auxiliary_irqs_group = {
>>>> +     .name = "irqs",
>>>> +     .attrs = auxiliary_irq_attrs,
>>>> +};
>>>> +
>>>> +static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
>>>> +{
>>>> +     int ret = 0;
>>>> +
>>>> +     mutex_lock(&auxdev->lock);
>>>> +     if (auxdev->dir_exists)
>>>> +             goto unlock;
>>>
>>> You do know about cleanup.h, right?  Please use it.
>>>
>>> But what exactly are you trying to protect here?  How will you race and
>>> add two irqs at the same time?  Driver probe is always single threaded,
>>> so what would be calling this at the same time from multiple places?
>>
>>
>> mlx5 driver requests IRQs on demand for PCI PF, VF, SFs.
>> And it occurs from multiple threads, hence we need to protect it.
> 
> How are irqs asked for, for the same device, from multiple threads?
> What threads exactly?  What is causing these irqs to be asked for?
> 
> But ok, that's fine, if you want to do this, then properly protect the
> allocation, don't just half-protect it like you did here :(


Thanks for the comment, will protect all the allocations

> 
>>>> +
>>>> +     xa_init(&auxdev->irqs);
>>>> +     ret = devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
>>>> +     if (!ret)
>>>> +             auxdev->dir_exists = 1;
>>>> +
>>>> +unlock:
>>>> +     mutex_unlock(&auxdev->lock);
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +/**
>>>> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
>>>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>>>> + * @irq: The associated interrupt number.
>>>> + *
>>>> + * This function should be called after auxiliary device have successfully
>>>> + * received the irq.
>>>> + *
>>>> + * Return: zero on success or an error code on failure.
>>>> + */
>>>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
>>>> +{
>>>> +     struct device *dev = &auxdev->dev;
>>>> +     struct auxiliary_irq_info *info;
>>>> +     int ret;
>>>> +
>>>> +     ret = auxiliary_irq_dir_prepare(auxdev);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>>>> +     if (!info)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     sysfs_attr_init(&info->sysfs_attr.attr);
>>>> +     info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
>>>> +     if (!info->sysfs_attr.attr.name) {
>>>> +             ret = -ENOMEM;
>>>> +             goto name_err;
>>>> +     }
>>>> +
>>>> +     ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
>>>
>>> So no lock happening here, either use it always, or not at all?
>>
>>
>> the lock is only needed to protect the group (directory) creation, which
>> will be used by all the IRQs of this auxdev.
>> parallel calls to this API will always be with different IRQs, which
>> means each IRQ have a unique index.
> 
> You are inserting into the sysfs group at the same time?  You are
> calling xa_insert() at the same time?  Is that protected with some
> internal lock?  If so, this needs to be documented a bunch here.
> 
> Allocating irqs is NOT a fast path, just grab a lock and do it right
> please, don't make us constantly have to stare at the code to ensure it
> is correct.


like I said above, I will protect all the allocations


> 
>>>> +     if (ret)
>>>> +             goto auxdev_xa_err;
>>>> +
>>>> +     ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
>>>> +                                   auxiliary_irqs_group.name);
>>>
>>> You do know that you are never going to see these files from the
>>> userspace library tools that watch sysfs, right?  libudev will never see
>>> them as you are adding them AFTER the device is created.
>>>
>>> So, because of that, who is really going to use these files?
>>
>> To learn about the interrupt mapping of the SF IRQs.
> 
> Who is going to "learn"?  Again, you are creating files that our
> userspace tools will miss, so what userspace tools are going to be able
> to learn anything here?
> 
> This is strongly implying that all of this is just a debugging aid.  So
> please, put this in debugfs where that type of thing belongs.


It is certainly a debugging aid as I described in the commit log.
But it is one of the purpose.
The motivation was clear but probably I should have better written.
The irq affinity setting code [1] needs to read the irqs number of the
device.
Tools like irqbalance [1] are using the sysfs.
And one should be able to do the same for the PCI SF too.
They cannot rely on the debugfs.

[1] 
https://github.com/Irqbalance/irqbalance/blob/ba44a683cdfaa688e89e0d887952032766fb89aa/classify.c#L631


> 
>>>> +     if (ret)
>>>> +             goto sysfs_add_err;
>>>> +
>>>> +     return 0;
>>>> +
>>>> +sysfs_add_err:
>>>> +     xa_erase(&auxdev->irqs, irq);
>>>> +auxdev_xa_err:
>>>> +     kfree(info->sysfs_attr.attr.name);
>>>> +name_err:
>>>> +     kfree(info);
>>>
>>> Again, cleanup.h is your friend.
>>>
>>>> +     return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
>>>> +
>>>> +/**
>>>> + * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the given IRQ
>>>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>>>> + * @irq: the IRQ to remove.
>>>> + *
>>>> + * This function should be called to remove an IRQ sysfs entry.
>>>> + */
>>>> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
>>>> +{
>>>> +     struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
>>>> +     struct device *dev = &auxdev->dev;
>>>> +
>>>> +     sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
>>>> +                                  auxiliary_irqs_group.name);
>>>> +     xa_erase(&auxdev->irqs, irq);
>>>> +     kfree(info->sysfs_attr.attr.name);
>>>> +     kfree(info);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
>>>> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
>>>> index de21d9d24a95..96be140bd1ff 100644
>>>> --- a/include/linux/auxiliary_bus.h
>>>> +++ b/include/linux/auxiliary_bus.h
>>>> @@ -58,6 +58,7 @@
>>>>     *       in
>>>>     * @name: Match name found by the auxiliary device driver,
>>>>     * @id: unique identitier if multiple devices of the same name are exported,
>>>> + * @irqs: irqs xarray contains irq indices which are used by the device,
>>>>     *
>>>>     * An auxiliary_device represents a part of its parent device's functionality.
>>>>     * It is given a name that, combined with the registering drivers
>>>> @@ -138,7 +139,10 @@
>>>>    struct auxiliary_device {
>>>>         struct device dev;
>>>>         const char *name;
>>>> +     struct xarray irqs;
>>>> +     struct mutex lock; /* Protects "irqs" directory creation */
>>>
>>> Protects it from what?
>>
>> please look the answer above
> 
> You need to document it here.  Or somewhere.  Don't rely on an email
> thread from 10 years ago for when you look at this in 10 years and
> wonder what is going on...

Thanks, I will document it better in next version

> 
>>>>         u32 id;
>>>> +     u8 dir_exists:1;
>>>
>>> I don't think this is needed, but if it really is, just use a bool.
>>
>>
>> If you know of an API that query whether a specific group is exists on
>> some device, can you please share it with me?
>> I came out empty when I looked for one :(
> 
> Normally sysfs groups are NOT created this way at all.  Oh wait, they
> can be now, why not use the new feature where a group is created by the
> core but only exposed if an attribute is added there?
> 
> Will that work here?  See commit d87c295f599c ("sysfs: Introduce a
> mechanism to hide static attribute_groups") for details.  That should
> solve the issue of trying to figure out if the directory is present or
> not logic.


thank for the suggestion:)
will give it a shoot

> 
> thanks,
> 
> greg k-h

