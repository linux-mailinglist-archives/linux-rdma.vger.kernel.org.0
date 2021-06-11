Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F383A3942
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 03:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFKBcD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 10 Jun 2021 21:32:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9068 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhFKBcD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 21:32:03 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G1NVk3rMYzYsVc;
        Fri, 11 Jun 2021 09:27:10 +0800 (CST)
Received: from dggpeml100022.china.huawei.com (7.185.36.176) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 09:29:55 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml100022.china.huawei.com (7.185.36.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 09:29:55 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Fri, 11 Jun 2021 09:29:55 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "wangxi (M)" <wangxi11@huawei.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Clear extended doorbell info before
 using
Thread-Topic: [PATCH v2 for-next] RDMA/hns: Clear extended doorbell info
 before using
Thread-Index: AQHXXeqT2LOf2vKj+E+SgooY81x00Q==
Date:   Fri, 11 Jun 2021 01:29:55 +0000
Message-ID: <71d8bb762a574c299d22e2ef419e68ec@huawei.com>
References: <1623323990-62343-1-git-send-email-liweihang@huawei.com>
 <YMH8GD2eoGLJugsS@unreal> <ec240826f2674a65b8de37bf3a7b18ec@huawei.com>
 <YMILs5uDMig7VMh0@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/6/10 20:55, Leon Romanovsky wrote:
> On Thu, Jun 10, 2021 at 12:04:29PM +0000, liweihang wrote:
>> On 2021/6/10 19:48, Leon Romanovsky wrote:
>>> On Thu, Jun 10, 2021 at 07:19:50PM +0800, Weihang Li wrote:
>>>> From: Xi Wang <wangxi11@huawei.com>
>>>>
>>>> Both of HIP08 and HIP09 require the extended doorbell information to be
>>>> cleared before being used.
>>>>
>>>> Fixes: 6b63597d3540 ("RDMA/hns: Add TSQ link table support")
>>>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>>>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>>> ---
>>>> Changes since v1:
>>>> - Add fixes tag.
>>>> - Add check for return value of hns_roce_clear_extdb_list_info().
>>>> - Link: https://patchwork.kernel.org/project/linux-rdma/patch/1623237065-43344-1-git-send-email-liweihang@huawei.com/
>>>>
>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 21 +++++++++++++++++++++
>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 +
>>>>  2 files changed, 22 insertions(+)
>>>>
>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>> index fbc45b9..d24ac5c 100644
>>>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>>> @@ -1572,6 +1572,22 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
>>>>  	}
>>>>  }
>>>>  
>>>> +static int hns_roce_clear_extdb_list_info(struct hns_roce_dev *hr_dev)
>>>> +{
>>>> +	struct hns_roce_cmq_desc desc;
>>>> +	int ret;
>>>> +
>>>> +	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CLEAR_EXTDB_LIST_INFO,
>>>> +				      false);
>>>> +	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
>>>> +	if (ret)
>>>> +		ibdev_err(&hr_dev->ib_dev,
>>>> +			  "failed to clear extended doorbell info, ret = %d.\n",
>>>> +			  ret);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>>  static int hns_roce_query_fw_ver(struct hns_roce_dev *hr_dev)
>>>>  {
>>>>  	struct hns_roce_query_fw_info *resp;
>>>> @@ -2684,6 +2700,11 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
>>>>  	if (ret)
>>>>  		return ret;
>>>>  
>>>> +	/* The hns ROCEE requires the extdb info to be cleared before using */
>>>> +	ret = hns_roce_clear_extdb_list_info(hr_dev);
>>>> +	if (ret)
>>>> +		return ret;
>>>
>>> You forgot to call to put_hem_table(hr_dev).
>>>
>>> Thanks
>>>
>>
>> Hi Leon,
>>
>> This operation is to tell the firmware to clear the on-chip resources
>> configuration before initialization, the HEM table is not involved.
> 
> Please check your hns_roce_v2_init() implementation.
> 
> You called to get_hem_table() 6 lines above, in case of error in
> hns_roce_clear_extdb_list_info(), you need to return the hem_table back.
> 
> You did it in 4 lines below.
> 
> Thanks
> 

Oh, I made a mistake, thank you :)

Weihang

>>
>> Thanks
>> Weihang
>>
>>
>>>> +
>>>>  	if (hr_dev->is_vf)
>>>>  		return 0;
>>>>  
>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>>>> index cd361c0..073e835 100644
>>>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>>>> @@ -250,6 +250,7 @@ enum hns_roce_opcode_type {
>>>>  	HNS_ROCE_OPC_CLR_SCCC				= 0x8509,
>>>>  	HNS_ROCE_OPC_QUERY_SCCC				= 0x850a,
>>>>  	HNS_ROCE_OPC_RESET_SCCC				= 0x850b,
>>>> +	HNS_ROCE_OPC_CLEAR_EXTDB_LIST_INFO		= 0x850d,
>>>>  	HNS_ROCE_OPC_QUERY_VF_RES			= 0x850e,
>>>>  	HNS_ROCE_OPC_CFG_GMV_TBL			= 0x850f,
>>>>  	HNS_ROCE_OPC_CFG_GMV_BT				= 0x8510,
>>>> -- 
>>>> 2.7.4
>>>>
>>>
>>
> 

