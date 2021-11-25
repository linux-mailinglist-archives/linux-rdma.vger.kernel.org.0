Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C395B45DB14
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 14:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351537AbhKYNbM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 08:31:12 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15868 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354147AbhKYN3M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Nov 2021 08:29:12 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J0JXX2KXrz91Kv;
        Thu, 25 Nov 2021 21:25:32 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 21:26:00 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 25 Nov
 2021 21:25:59 +0800
Subject: Re: [PATCH for-rc] RDMA/hns: Fix the error of destroying resources in
 hw reseting phase
To:     Leon Romanovsky <leon@kernel.org>
References: <20211123142402.26936-1-liangwenpeng@huawei.com>
 <YZ+NACnl23E8W7rB@unreal>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <9bb94fba-5909-6844-964e-832ce21d70de@huawei.com>
Date:   Thu, 25 Nov 2021 21:25:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YZ+NACnl23E8W7rB@unreal>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/11/25 21:17, Leon Romanovsky wrote:
> On Tue, Nov 23, 2021 at 10:24:02PM +0800, Wenpeng Liang wrote:
>> From: Yangyang Li <liyangyang20@huawei.com>
>>
>> When hns_roce_v2_destroy_qp() is called, the brief calling process of the
>> driver is as follows:
>>
>> ......
>> hns_roce_v2_destroy_qp
>> hns_roce_v2_qp_modify
>> 	   hns_roce_cmd_mbox
>> hns_roce_qp_destroy
>>
>> If hns_roce_cmd_mbox() detects that the hardware is being reset during
>> the execution of the hns_roce_cmd_mbox(), the driver will not be able
>> to get the return value from the hardware (the firmware cannot respond
>> to the driver's mailbox during the hardware reset phase). The driver
>> needs to wait for the hardware reset to complete before continuing to
>> execute hns_roce_qp_destroy(), otherwise it may happen that the driver
>> releases the resources but the hardware is still accessing. In order to
>> fix this problem, HNS RoCE needs to add a piece of code to wait for the
>> hardware reset to complete.
>>
>> The original interface get_hw_reset_stat() is the instantaneous state
>> of the hardware reset, which cannot accurately reflect whether the
>> hardware reset is completed, so it needs to be replaced with the
>> ae_dev_reset_cnt interface.
>>
>> The sign that the hardware reset is complete is that the return value
>> of the ae_dev_reset_cnt interface is greater than the original value
>> reset_cnt recorded by the driver.
>>
>> Fixes: 6a04aed6afae ("RDMA/hns: Fix the chip hanging caused by sending mailbox&CMQ during reset")
>> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> And what about the other fix?
> Should we take both of them or only one?
> https://lore.kernel.org/all/20211123084809.37318-1-liangwenpeng@huawei.com
> 
> Thanks
> 

These two fixes are independent of each other.

Thanks
Wenpeng

>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index ae14329c619c..bbfa1332dedc 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -33,6 +33,7 @@
>>  #include <linux/acpi.h>
>>  #include <linux/etherdevice.h>
>>  #include <linux/interrupt.h>
>> +#include <linux/iopoll.h>
>>  #include <linux/kernel.h>
>>  #include <linux/types.h>
>>  #include <net/addrconf.h>
>> @@ -1050,9 +1051,14 @@ static u32 hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
>>  					unsigned long instance_stage,
>>  					unsigned long reset_stage)
>>  {
>> +#define HW_RESET_TIMEOUT_US 1000000
>> +#define HW_RESET_SLEEP_US 1000
>> +
>>  	struct hns_roce_v2_priv *priv = hr_dev->priv;
>>  	struct hnae3_handle *handle = priv->handle;
>>  	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
>> +	unsigned long val;
>> +	int ret;
>>  
>>  	/* When hardware reset is detected, we should stop sending mailbox&cmq&
>>  	 * doorbell to hardware. If now in .init_instance() function, we should
>> @@ -1064,7 +1070,11 @@ static u32 hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
>>  	 * again.
>>  	 */
>>  	hr_dev->dis_db = true;
>> -	if (!ops->get_hw_reset_stat(handle))
>> +
>> +	ret = read_poll_timeout(ops->ae_dev_reset_cnt, val,
>> +				val > hr_dev->reset_cnt, HW_RESET_SLEEP_US,
>> +				HW_RESET_TIMEOUT_US, false, handle);
>> +	if (!ret)
>>  		hr_dev->is_reset = true;
>>  
>>  	if (!hr_dev->is_reset || reset_stage == HNS_ROCE_STATE_RST_INIT ||
>> -- 
>> 2.33.0
>>
> .
> 
