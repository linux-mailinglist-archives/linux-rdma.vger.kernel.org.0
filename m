Return-Path: <linux-rdma+bounces-3291-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7733B90E37B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 08:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8517B2288F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 06:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C6F6F2E2;
	Wed, 19 Jun 2024 06:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t5KElNKv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A381E529;
	Wed, 19 Jun 2024 06:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778820; cv=fail; b=t71Z9TRYVA7YLpU4R0dE3GZLtYv1HYR0EiJ4aZttg3SJE0NBvaYgeIpSCYjb8Jda58cLSR0En3sTO2sT35vQ2go9WoU9KuyIAEcXiS/2ibTScRxz2P/STzuD4lMK2NWABCkhO9AD5EZBu7G+51p6QmxVSzPeB/uqGRZUvdPC1pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778820; c=relaxed/simple;
	bh=yB/ficxIiYYR5+spx4Cn5Y3sGRSeIQTtUASPHsY0NiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kSD5z35elyeZMGXMcEtzyByEjiIlRu6lew758xZB9a0Yukfa/KenG+2TM3XKiPvBt52KYPEBSOYfOf9IGiIXEl87b+s3VgweSxCQqkjuQcd1q8P3pP8gX+ei4wjcbMt0l+kr/sFz86SoA54/BU2dZakvUpk8GqlNWOPJ7eLXARw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t5KElNKv; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9IaQhnMpd/CRYJNrZOmCScn8e3/soQc6j77KqPNT9nAFh3AXZwdT0sdWKb1Dwzvq/FRHgvj7qrWqSJsGPHD+z1HID81v+VJkFpKu9kifRYRkAkJ//wP8DTB6ywvZZ+kfCeppHh1X/fT/VF2XIeXgwkNm92zz/oo36Ila22zdPbahdgLPGwf0RCwjhYwr2DOMhQz4Vqf+CMQUAv1Ans/UhnrBGz2FBoVkY+S/yyVspaxgNfoI0W9mkIv29/Y6B3aEJG7db4mK9+Q8oeb+KcxKTBi825HXY/oUAWj28YAOsCQY/azNG5ATQdy43UtWG7Erc5Y+hqNZlZROpvsCGWLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JjwV5eRSETzEfU5fuxVLTrrFLeZi+4tDsNSCPC6LW4=;
 b=Lio2/aGwU0LAu+28iqEa0/vQ4AlJWkpDlqoT7APuutDAqFsmMmnOdoIewrnG50uZ/Gt0yo0WWQXg9SaP+8snylZ1RIwcue3ffADApoaW4Lwai31FX55mYmHv+KrNwiOWJ4U125furEdpeqOp0bqPJavhTpDkoaSJFcfs5KcoMWM8knf8DLGbComD1pvwWwExLMz+oglq1eB0lcyjZKxjy6ySLNoM2lUkwb54YgOX01/qvKMnYPfpvCIXaHwHbHGB2d8Iq8WlkL+Iwf6S/Ti3zZWWtlcvPXoH/LiE13ZeSA8dzX/aGJG+QceBpzxW/xHBdzQtRzPqcSH+1DfX9DkGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JjwV5eRSETzEfU5fuxVLTrrFLeZi+4tDsNSCPC6LW4=;
 b=t5KElNKva/VDO543DMrAjVkUuYvl3GD4JAWLGQi/SIZI1JX0RQubOq3SNR6pNUl4mROQp92hgFECM2to4KbRPNPrGCSaGh4yH1FTsVrZO/C9oVsae6Zi3BXRHtIZePcukEy4XGmfTyJn5N2vnaO6JI8HHgobo5Gr3eHUBtjlDg0CXcg/xEv5Px7qBP03zxsQygDT8DELvf6p++FSja234Y/BjefkOMbOBjTLpsMKruo8QCY8rcBaXVweHGprEK48tJ9jzvuzRikucM/UX3Kv0MrtIUrznWVc5HJJRNLdgP0J1g2DMrbUvGTd3L3owJTmXDDQXFmrFmyPXVX8ajOOaA==
Received: from CH2PR07CA0027.namprd07.prod.outlook.com (2603:10b6:610:20::40)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 06:33:35 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::d3) by CH2PR07CA0027.outlook.office365.com
 (2603:10b6:610:20::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 06:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 06:33:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 23:33:21 -0700
Received: from [172.27.63.78] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 23:33:16 -0700
Message-ID: <21f7e9b8-00aa-4e1f-a769-9606834a234b@nvidia.com>
Date: Wed, 19 Jun 2024 09:33:12 +0300
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
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <2024061849-cupped-throwback-4fee@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e80c4c4-d6b5-48d7-1773-08dc9029bee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|1800799021|36860700010|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1k5Kzl5VGNUcmJ6ZWl5NU81TWNZZlI1T0dxTDBRYXdsWm5qTFJneC9vaEor?=
 =?utf-8?B?SkRQNEhXNXVKblFlRGtYY24yTStKQ2t6c2RIWjU5MC9sVzQ2c2tNZUZkWnZQ?=
 =?utf-8?B?Q2dIanNPalovc0k4R3hHdi9oa0s1MEpOdHloVTNYTjB6RmNFdWVBYlJhazQy?=
 =?utf-8?B?TWdqOHRBVDhScmQ3bExGbG16K1dMaXZzV21rQ1Zmeng2ODRIL0dpWWY3VG9D?=
 =?utf-8?B?L1FnelFzNjlhbndHamRJR3ZDMVBGWTRVUEY5U2VSUzB2QlJqalMxclptMmFu?=
 =?utf-8?B?cVhWMFg0SlNOVkJGUWJUcldoaUowak1MNUdOQ0JEZ0laanJHS2FEOHhaQmpO?=
 =?utf-8?B?dUwrREorZDNKTk95TnJ3eC9BaTcwYzRMY1NJRFA5bjJld1U4RmRlVllTRU14?=
 =?utf-8?B?bUVFczlRZnQ1Z0VLSDN1YVNLOERpMWZ5NjdyOXh3cGdIaGF1MUxzRTlwSzEy?=
 =?utf-8?B?T3VlVkJ1dEJTV2YvQnlqNFo3MGc0dmp3L0xLaCt5RFJhWW9ZU2hVRCtLR2M5?=
 =?utf-8?B?SmtrcklGY1BDdk04VyttZ0RqWVcwSjNsczdSRVlBWjV2NVpqamdubkIyNGc3?=
 =?utf-8?B?TmY0MHBqLzVFZlRwc0FtQS8wb3QxYmtOOTRDQnFFZXJ3bnBONFRQdElwRkwx?=
 =?utf-8?B?ZGxsblRxek5RdHErYVJZUitaLzlNKzhJVTB0YkNpVUZlaGVhK3RvSzhtVkJy?=
 =?utf-8?B?LzBUY29YVEpRTk1Jd1RmMDRLQmtLLytlSWVlWFZvc1lYREowRjZUUnV5Z0FB?=
 =?utf-8?B?eno5V1FMM3JrYkRScXl1WlJkbVd4U3RqbndyWVRtQjN3NXRhNXREY2VwMHEz?=
 =?utf-8?B?NXJJTmZPN0gzWEJGa25DT1B4K25IV1EzT0VUb3Q5aGplcHpibENJUmJ0NGU4?=
 =?utf-8?B?ZHQxYjBOMVcxdjE5SlVVUDBsa1hlQm5PeWpQZXZoTHRXV2NESEdlVE5Ndm5s?=
 =?utf-8?B?K29Oek5mN1J2YkpYZUhhOTd5SEtrV05xMU1ZVUpoa2dwRjZPRWo0anNXZHBR?=
 =?utf-8?B?Z3ROaC9jUjNQVkZvYVNVUnZETkxyVzRtdWFoelBxWlB4M3hVMmM4Tm1hM0J5?=
 =?utf-8?B?dkx0bzFkL2taV0w2dzZFZDF3MmxVaEwwaitCZjgvSjEvajhxSmVRYklnNk8w?=
 =?utf-8?B?OGdrcWZsTE5kNlB0RFlyTStKckx6WVhpS21NamJuT2hqcXdYVlRxb04vYmtw?=
 =?utf-8?B?YlpoVzVINlJNRVBpaElWMzNmQmJEV01UVzdIM3owKzJlakhIWXJQd0xhMlF4?=
 =?utf-8?B?M3R3NHhCb0x1all3VUMyc0JvclJTY1FoZnFDeDgvRVQ5b1U4VWFZeDZLeWpu?=
 =?utf-8?B?cVJ0blhub2ZuN3RLS3d5dW53dGE2MWdVU0dUTXVkNFFhVkZlWG4wMDBtN3My?=
 =?utf-8?B?YnNxbXE1VXhlWFFVQVRzcDBlNHlDbUdnOGt4Vk5jbThUcnVDMEtDZTc0QlN0?=
 =?utf-8?B?a1JueGp6MlZRT211RVRTUGNYbVh6ZDJSV1ZPaTFyRUhlUlJJd0JZT1ZTbXEy?=
 =?utf-8?B?VUNHcHJabEVXTnBGRENUY3VFQTl3aXV4K0VRalo2aXVvRjZ6MDlPUU1RU1ZD?=
 =?utf-8?B?YW5UNDVFclE4VHRYVC8rYjdzNnJLekFoNDIxeXZidFNWWHVnY25Va1V2eEtx?=
 =?utf-8?B?c0p2d0JKaHB4eGpXdVF2ckY1NHhEdmtGenQ2MFFaVUNJb2VWVVg4Q3pxUzFr?=
 =?utf-8?B?aStPZ0RiNjZKakZOcGpMQ0VnMzBWY0xEK2pHbUdBbjVKMG1VOXpDT3dDbERS?=
 =?utf-8?B?ZGV0ZWNFZWVBUGVldldJYlhWU0VMM3IwazNFSTdINlpuRSsvcEYwaFJ6QWdi?=
 =?utf-8?B?a0FGMyt4ZUQ5OHV4N0dYZ0ZhK0NrVmhIZThML0x2Yjg1cmJCalpuNE5XV3Fj?=
 =?utf-8?B?UDRjTFhCUFhoQnhKVXdFek5jM1AycXdmL3VhMDYySUlRUXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(1800799021)(36860700010)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 06:33:34.8843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e80c4c4-d6b5-48d7-1773-08dc9029bee1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741



On 18/06/2024 19:13, Greg KH wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Jun 18, 2024 at 06:09:01PM +0300, Shay Drory wrote:
>> diff --git a/drivers/base/auxiliary_sysfs.c b/drivers/base/auxiliary_sysfs.c
>> new file mode 100644
>> index 000000000000..3f112fd26e72
>> --- /dev/null
>> +++ b/drivers/base/auxiliary_sysfs.c
>> @@ -0,0 +1,110 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
>> + */
>> +
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/slab.h>
>> +
>> +struct auxiliary_irq_info {
>> +     struct device_attribute sysfs_attr;
>> +};
>> +
>> +static struct attribute *auxiliary_irq_attrs[] = {
>> +     NULL
>> +};
>> +
>> +static const struct attribute_group auxiliary_irqs_group = {
>> +     .name = "irqs",
>> +     .attrs = auxiliary_irq_attrs,
>> +};
>> +
>> +static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
>> +{
>> +     int ret = 0;
>> +
>> +     mutex_lock(&auxdev->lock);
>> +     if (auxdev->dir_exists)
>> +             goto unlock;
> 
> You do know about cleanup.h, right?  Please use it.
> 
> But what exactly are you trying to protect here?  How will you race and
> add two irqs at the same time?  Driver probe is always single threaded,
> so what would be calling this at the same time from multiple places?


mlx5 driver requests IRQs on demand for PCI PF, VF, SFs.
And it occurs from multiple threads, hence we need to protect it.


> 
> 
>> +
>> +     xa_init(&auxdev->irqs);
>> +     ret = devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
>> +     if (!ret)
>> +             auxdev->dir_exists = 1;
>> +
>> +unlock:
>> +     mutex_unlock(&auxdev->lock);
>> +     return ret;
>> +}
>> +
>> +/**
>> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>> + * @irq: The associated interrupt number.
>> + *
>> + * This function should be called after auxiliary device have successfully
>> + * received the irq.
>> + *
>> + * Return: zero on success or an error code on failure.
>> + */
>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
>> +{
>> +     struct device *dev = &auxdev->dev;
>> +     struct auxiliary_irq_info *info;
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
>> +     info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
>> +     if (!info->sysfs_attr.attr.name) {
>> +             ret = -ENOMEM;
>> +             goto name_err;
>> +     }
>> +
>> +     ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
> 
> So no lock happening here, either use it always, or not at all?


the lock is only needed to protect the group (directory) creation, which
will be used by all the IRQs of this auxdev.
parallel calls to this API will always be with different IRQs, which
means each IRQ have a unique index.


> 
> 
>> +     if (ret)
>> +             goto auxdev_xa_err;
>> +
>> +     ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
>> +                                   auxiliary_irqs_group.name);
> 
> You do know that you are never going to see these files from the
> userspace library tools that watch sysfs, right?  libudev will never see
> them as you are adding them AFTER the device is created.
> 
> So, because of that, who is really going to use these files?


To learn about the interrupt mapping of the SF IRQs.


> 
> 
>> +     if (ret)
>> +             goto sysfs_add_err;
>> +
>> +     return 0;
>> +
>> +sysfs_add_err:
>> +     xa_erase(&auxdev->irqs, irq);
>> +auxdev_xa_err:
>> +     kfree(info->sysfs_attr.attr.name);
>> +name_err:
>> +     kfree(info);
> 
> Again, cleanup.h is your friend.
> 
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
>> + */
>> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
>> +{
>> +     struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
>> +     struct device *dev = &auxdev->dev;
>> +
>> +     sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
>> +                                  auxiliary_irqs_group.name);
>> +     xa_erase(&auxdev->irqs, irq);
>> +     kfree(info->sysfs_attr.attr.name);
>> +     kfree(info);
>> +}
>> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
>> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
>> index de21d9d24a95..96be140bd1ff 100644
>> --- a/include/linux/auxiliary_bus.h
>> +++ b/include/linux/auxiliary_bus.h
>> @@ -58,6 +58,7 @@
>>    *       in
>>    * @name: Match name found by the auxiliary device driver,
>>    * @id: unique identitier if multiple devices of the same name are exported,
>> + * @irqs: irqs xarray contains irq indices which are used by the device,
>>    *
>>    * An auxiliary_device represents a part of its parent device's functionality.
>>    * It is given a name that, combined with the registering drivers
>> @@ -138,7 +139,10 @@
>>   struct auxiliary_device {
>>        struct device dev;
>>        const char *name;
>> +     struct xarray irqs;
>> +     struct mutex lock; /* Protects "irqs" directory creation */
> 
> Protects it from what?

please look the answer above

> 
> 
>>        u32 id;
>> +     u8 dir_exists:1;
> 
> I don't think this is needed, but if it really is, just use a bool.


If you know of an API that query whether a specific group is exists on
some device, can you please share it with me?
I came out empty when I looked for one :(


> 
> 
>>   };
>>
>>   /**
>> @@ -212,8 +216,24 @@ int auxiliary_device_init(struct auxiliary_device *auxdev);
>>   int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname);
>>   #define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME)
>>
>> +#ifdef CONFIG_SYSFS
>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq);
>> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev,
>> +                                    int irq);
> 
> You can use longer lines :)
> 
> thanks,
> 
> greg k-h

