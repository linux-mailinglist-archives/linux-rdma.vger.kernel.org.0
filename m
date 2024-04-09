Return-Path: <linux-rdma+bounces-1869-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA0989D7A3
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 13:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7E91F2276A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 11:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3317A85954;
	Tue,  9 Apr 2024 11:10:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892CB84A38;
	Tue,  9 Apr 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661036; cv=none; b=LWOuPFm1qUaXNIsV8mrIKXzrQzVLwCHqbelrq8VNuQY+JwxmP1CYjDPbbdl4jIVi7YkQZro5vCtdnF0KodsVfU3qNz64UaWkKapRPK5qTOriiP+FibICn1iDpnsQpYCCCC5wo86TfSrn0IWwP5NzWrA07fEU1a6iB+f6vmjM7MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661036; c=relaxed/simple;
	bh=QFEF+7ZaPhu+uNuab3B52rKuxoQMWSHN3kWkkmq8XMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cpE4EmgBjQTGB2Y+5diL33ckZT5IppW+Jc6o1jZIIoVftvfLJfi3KuQT7JBZT18lzH4u7j3yEtxwD2Oq8DBP/mGpqEWGU+Ye/yGQGmklRlRXuX3lBWq2TRFXNuaNF/IP5Cum1BUdch0Yg63NR6Z/QkHjG4Y79SB3o0VigtP4dHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VDNWn3MGqzFr4n;
	Tue,  9 Apr 2024 19:09:25 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F09C1400CD;
	Tue,  9 Apr 2024 19:10:23 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 19:10:22 +0800
Message-ID: <1476bb96-c0a9-379a-546b-98fc8a06beea@hisilicon.com>
Date: Tue, 9 Apr 2024 19:10:21 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] RDMA: hns: Fix possible null pointer dereference
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Aleksandr Mishin <amishin@t-argos.ru>
CC: Wei Xu <xuwei5@hisilicon.com>, Chengchang Tang
	<tangchengchang@huawei.com>, Jason Gunthorpe <jgg@ziepe.ca>, Xi Wang
	<wangxi11@huawei.com>, Shengming Shu <shushengming1@huawei.com>, Weihang Li
	<liweihang@huawei.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20240409083047.15784-1-amishin@t-argos.ru>
 <20240409092601.GG4195@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240409092601.GG4195@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)



On 2024/4/9 17:26, Leon Romanovsky wrote:
> On Tue, Apr 09, 2024 at 11:30:47AM +0300, Aleksandr Mishin wrote:
>> In hns_roce_hw_v2_get_cfg() pci_match_id() may return
>> NULL which is later dereferenced. Fix this bug by adding NULL check.
> 
> I don't know, this NULL can't happen in this flow.
> 
> Thanks
> 

Yeah, it's already checked here:

6911 static int hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
6912 {
6913         const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
6914         const struct pci_device_id *id;
6915         struct device *dev = &handle->pdev->dev;
6916         int ret;
6917
6918         handle->rinfo.instance_state = HNS_ROCE_STATE_INIT;
6919
6920         if (ops->ae_dev_resetting(handle) || ops->get_hw_reset_stat(handle)) {
6921                 handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
6922                 goto reset_chk_err;
6923         }
6924
6925         id = pci_match_id(hns_roce_hw_v2_pci_tbl, handle->pdev);
6926         if (!id)
6927                 return 0;
6928
6929         if (id->driver_data && handle->pdev->revision == PCI_REVISION_ID_HIP08)
6930                 return 0;
6931
6932         ret = __hns_roce_hw_v2_init_instance(handle);

Junxian

>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 0b567cde9d7a ("RDMA/hns: Enable RoCE on virtual functions")
>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index ba7ae792d279..31a2093334d9 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -6754,7 +6754,7 @@ static const struct pci_device_id hns_roce_hw_v2_pci_tbl[] = {
>>  
>>  MODULE_DEVICE_TABLE(pci, hns_roce_hw_v2_pci_tbl);
>>  
>> -static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
>> +static int hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
>>  				  struct hnae3_handle *handle)
>>  {
>>  	struct hns_roce_v2_priv *priv = hr_dev->priv;
>> @@ -6763,6 +6763,9 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
>>  
>>  	hr_dev->pci_dev = handle->pdev;
>>  	id = pci_match_id(hns_roce_hw_v2_pci_tbl, hr_dev->pci_dev);
>> +	if (!id)
>> +		return -ENXIO;
>> +
>>  	hr_dev->is_vf = id->driver_data;
>>  	hr_dev->dev = &handle->pdev->dev;
>>  	hr_dev->hw = &hns_roce_hw_v2;
>> @@ -6789,6 +6792,8 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
>>  
>>  	hr_dev->reset_cnt = handle->ae_algo->ops->ae_dev_reset_cnt(handle);
>>  	priv->handle = handle;
>> +
>> +	return 0;
>>  }
>>  
>>  static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
>> @@ -6806,7 +6811,11 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
>>  		goto error_failed_kzalloc;
>>  	}
>>  
>> -	hns_roce_hw_v2_get_cfg(hr_dev, handle);
>> +	ret = hns_roce_hw_v2_get_cfg(hr_dev, handle);
>> +	if (ret) {
>> +		dev_err(hr_dev->dev, "RoCE Engine cfg failed!\n");
>> +		goto error_failed_roce_init;
>> +	}
>>  
>>  	ret = hns_roce_init(hr_dev);
>>  	if (ret) {
>> -- 
>> 2.30.2
>>

