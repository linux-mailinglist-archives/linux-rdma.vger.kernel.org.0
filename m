Return-Path: <linux-rdma+bounces-5017-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFF497D3B3
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 11:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E072B1C23DA0
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB1D7E107;
	Fri, 20 Sep 2024 09:35:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D51CD2C;
	Fri, 20 Sep 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824924; cv=none; b=jpM0PbyqqXVhkbMFARc0VRG+TeomWe2OmEPGSAzKcEx2cLL6cbwDFFh7JKW8s03T0gvGJytB87RKBl1Kttu+zc2DlLs+ayV7UzC+Wc3Y8xFESupUZKY0VUJNaRSXfldNWuHd/B5L3l04LspX/tDYDOEMzYW9QftTgd1Db/p+Hd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824924; c=relaxed/simple;
	bh=7NP1yglyeICKsIogBUXfsBSZM8CXbHO3VwClDrLh7wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=laemcm/UdWvwLhpm5/WrqA//hYDZQMg4pMZZvkChJR6/BTZEmBbbwfYaOyTf2u8V7l+GTkrk4h4usnWJ0WhRpkUwc8doiPfWN+xLKyzRLxhppV6jiaf1L9Q7jwSN+NOhFeeU3LOIDniMhv3oGqbRxiVdtjHipVXccTTVkkrs/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X96HW71kgzFqmv;
	Fri, 20 Sep 2024 17:17:59 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id EBBE1141247;
	Fri, 20 Sep 2024 17:18:15 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Sep 2024 17:18:15 +0800
Message-ID: <595ec9f3-c3cd-66b3-c523-452f88e079ac@hisilicon.com>
Date: Fri, 20 Sep 2024 17:18:14 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v5 for-next 2/2] RDMA/hns: Disassociate mmap pages for all
 uctx when HW is being reset
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240913122955.1283597-1-huangjunxian6@hisilicon.com>
 <20240913122955.1283597-3-huangjunxian6@hisilicon.com>
 <20240916091323.GM4026@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240916091323.GM4026@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/9/16 17:13, Leon Romanovsky wrote:
> On Fri, Sep 13, 2024 at 08:29:55PM +0800, Junxian Huang wrote:
>> From: Chengchang Tang <tangchengchang@huawei.com>
>>
>> When HW is being reset, userspace should not ring doorbell otherwise
>> it may lead to abnormal consequence such as RAS.
>>
>> Disassociate mmap pages for all uctx to prevent userspace from ringing
>> doorbell to HW. Since all resources will be destroyed during HW reset,
>> no new mmap is allowed after HW reset is completed.
>>
>> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 9 +++++++++
>>  drivers/infiniband/hw/hns/hns_roce_main.c  | 5 +++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 24e906b9d3ae..4e374b2da101 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -7017,6 +7017,12 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
>>  
>>  	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
>>  }
>> +
>> +static void hns_roce_v2_reset_notify_user(struct hns_roce_dev *hr_dev)
>> +{
>> +	rdma_user_mmap_disassociate(&hr_dev->ib_dev);
>> +}
> 
> There is no need in one line function, please inline it.
> 

Sure.

>> +
>>  static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
>>  {
>>  	struct hns_roce_dev *hr_dev;
>> @@ -7035,6 +7041,9 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
>>  
>>  	hr_dev->active = false;
>>  	hr_dev->dis_db = true;
>> +
>> +	hns_roce_v2_reset_notify_user(hr_dev);
>> +
>>  	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
>>  
>>  	return 0;
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
>> index 4cb0af733587..49315f39361d 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
>> @@ -466,6 +466,11 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
>>  	pgprot_t prot;
>>  	int ret;
>>  
>> +	if (hr_dev->dis_db) {
> 
> How do you clear dis_db after calling to hns_roce_hw_v2_reset_notify_down()? Does it have any locking protection?
> 

Sorry for the late response, I just came back from vacation.

After calling hns_roce_hw_v2_reset_notify_down(), we will call ib_unregister_device()
and destory all HW resources eventually, so there is no need to clear dis_db.

Junxian

>> +		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_MMAP_ERR_CNT]);
>> +		return -EPERM;
>> +	}
>> +
>>  	rdma_entry = rdma_user_mmap_entry_get_pgoff(uctx, vma->vm_pgoff);
>>  	if (!rdma_entry) {
>>  		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_MMAP_ERR_CNT]);
>> -- 
>> 2.33.0
>>
> 

