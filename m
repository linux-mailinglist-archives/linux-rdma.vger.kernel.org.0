Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87083A2482
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 08:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhFJG2b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 10 Jun 2021 02:28:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9056 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhFJG2b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 02:28:31 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0v7M0LxBzZcXD;
        Thu, 10 Jun 2021 14:23:43 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (7.185.36.10) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 14:26:33 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 14:26:33 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Thu, 10 Jun 2021 14:26:33 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "wangxi (M)" <wangxi11@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Clear extended doorbell info before
 using
Thread-Topic: [PATCH for-next] RDMA/hns: Clear extended doorbell info before
 using
Thread-Index: AQHXXSAv9wr4Vl744ku7FYzI09T5Zw==
Date:   Thu, 10 Jun 2021 06:26:33 +0000
Message-ID: <45f10d85bd794db4a107489efd327162@huawei.com>
References: <1623237065-43344-1-git-send-email-liweihang@huawei.com>
 <YMDFvX0ySdq3n+Ra@unreal>
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

On 2021/6/9 21:44, Leon Romanovsky wrote:
> On Wed, Jun 09, 2021 at 07:11:05PM +0800, Weihang Li wrote:
>> From: Xi Wang <wangxi11@huawei.com>
>>
>> Both of HIP08 and HIP09 require the extended doorbell information to be
>> cleared before being used.
> 
> Is it bugfix or feature?
> For the fix, it needs to have Fixes ... line.
> 

It is a bugfix, I will add a fixes tag, thanks.

>>
>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 16 ++++++++++++++++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 +
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index fbc45b9..c5d2cfb 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -1572,6 +1572,20 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
>>  	}
>>  }
>>  
>> +static void hns_roce_clear_extdb_list_info(struct hns_roce_dev *hr_dev)
>> +{
>> +	struct hns_roce_cmq_desc desc;
>> +	int ret;
>> +
>> +	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CLEAR_EXTDB_LIST_INFO,
>> +				      false);
>> +	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
>> +	if (ret)
>> +		ibdev_warn(&hr_dev->ib_dev,
>> +			   "failed to clear extended doorbell info, ret = %d.\n",
>> +			   ret);
>> +}
>> +
>>  static int hns_roce_query_fw_ver(struct hns_roce_dev *hr_dev)
>>  {
>>  	struct hns_roce_query_fw_info *resp;
>> @@ -2684,6 +2698,8 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	/* The hns ROCEE requires the extdb info to be cleared before using */
>> +	hns_roce_clear_extdb_list_info(hr_dev);
> 
> If it "requires", why do you proceed anyway? Why don't you check for
> success/failure?
> 
> Thanks
> 

You are right, we should check for it's return value.

Weihang

>>  	if (hr_dev->is_vf)
>>  		return 0;
>>  
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> index cd361c0..073e835 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>> @@ -250,6 +250,7 @@ enum hns_roce_opcode_type {
>>  	HNS_ROCE_OPC_CLR_SCCC				= 0x8509,
>>  	HNS_ROCE_OPC_QUERY_SCCC				= 0x850a,
>>  	HNS_ROCE_OPC_RESET_SCCC				= 0x850b,
>> +	HNS_ROCE_OPC_CLEAR_EXTDB_LIST_INFO		= 0x850d,
>>  	HNS_ROCE_OPC_QUERY_VF_RES			= 0x850e,
>>  	HNS_ROCE_OPC_CFG_GMV_TBL			= 0x850f,
>>  	HNS_ROCE_OPC_CFG_GMV_BT				= 0x8510,
>> -- 
>> 2.7.4
>>
> 

