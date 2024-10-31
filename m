Return-Path: <linux-rdma+bounces-5651-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FB49B7735
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 10:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85BDCB24C3E
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 09:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCFA192B89;
	Thu, 31 Oct 2024 09:16:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6417B436;
	Thu, 31 Oct 2024 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366207; cv=none; b=ZKFYwQviOQC80xE6e/R0dvoRBBoss4RCi9ycghAlb/7NuUsHCZV8IkLWQkB6RG5SuMPFVbWZimdBXXncDtQ9CQoaqyD/vQnRSxepKdaFhNabNkX49UYrOym1Ci//miWZtfB6lwfZ0xZDZG1YrUBQDQKzgbvIPwTEQleorZHbbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366207; c=relaxed/simple;
	bh=XGhyzGfmtfsnkOjf3JGFkJYGQksRSZn8/6iLyeLRtME=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Go5NVoQz0dSA6O31ufA3bTNUep6Dq85vPOXSRhaX8+vSbK7mT+aO1ATXVnx9lWC723l0KDu+K0ne1muTuhMnO3rN1qLwmUV7rG9x/XRW9kkpBOIXUToGlNLv65MAO9SZm9l7DdZULw25XqCGpLQBs+0vku97u27j0OVmvizaVgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XfJHF3MQRz2FbnW;
	Thu, 31 Oct 2024 17:15:05 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id C3B461A0190;
	Thu, 31 Oct 2024 17:16:38 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 31 Oct 2024 17:16:38 +0800
Message-ID: <8f8de1f4-428d-4f0e-260f-cacea30fcdec@hisilicon.com>
Date: Thu, 31 Oct 2024 17:16:37 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2 for-rc 3/5] RDMA/hns: Modify debugfs name
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <tangchengchang@huawei.com>
References: <20241024124000.2931869-1-huangjunxian6@hisilicon.com>
 <20241024124000.2931869-4-huangjunxian6@hisilicon.com>
 <20241030121258.GB17187@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20241030121258.GB17187@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/10/30 20:12, Leon Romanovsky wrote:
> On Thu, Oct 24, 2024 at 08:39:58PM +0800, Junxian Huang wrote:
>> From: Yuyu Li <liyuyu6@huawei.com>
>>
>> The sub-directory of hns_roce debugfs is named after the device's
>> kernel name currently, but it will be inconvenient to use when
>> the device is renamed.
>>
>> Modify the name to pci name as users can always easily find the
>> correspondence between an RDMA device and its pci name.
>>
>> Fixes: eb7854d63db5 ("RDMA/hns: Support SW stats with debugfs")
>> Signed-off-by: Yuyu Li <liyuyu6@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_debugfs.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
>> index e8febb40f645..b869cdc54118 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_debugfs.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
>> @@ -5,6 +5,7 @@
>>  
>>  #include <linux/debugfs.h>
>>  #include <linux/device.h>
>> +#include <linux/pci.h>
>>  
>>  #include "hns_roce_device.h"
>>  
>> @@ -86,7 +87,7 @@ void hns_roce_register_debugfs(struct hns_roce_dev *hr_dev)
>>  {
>>  	struct hns_roce_dev_debugfs *dbgfs = &hr_dev->dbgfs;
>>  
>> -	dbgfs->root = debugfs_create_dir(dev_name(&hr_dev->ib_dev.dev),
>> +	dbgfs->root = debugfs_create_dir(pci_name(hr_dev->pci_dev),
>>  					 hns_roce_dbgfs_root);
> 
> Let's take this change, but the more correct way is to add .rename()
> callback to ib_device ops in similar way to what we do in ib_client
> and call to debugfs_rename() from there.
> 
> See ib_device_rename() implementation for "lient->rename(ibdev, client_data);" call.
> 

Thanks for applying and the guidance. I'll have a look at it.

Junxian

> Thanks

