Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65943F39E7
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Aug 2021 11:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhHUJie (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Aug 2021 05:38:34 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18026 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhHUJie (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 Aug 2021 05:38:34 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GsCxp4q0Kzbdy0;
        Sat, 21 Aug 2021 17:34:06 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 21 Aug 2021 17:37:53 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 21 Aug
 2021 17:37:53 +0800
Subject: Re: [PATCH v4 for-next 01/12] RDMA/hns: Introduce DCA for RC QP
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
 <1627525163-1683-2-git-send-email-liangwenpeng@huawei.com>
 <20210819235449.GA398955@nvidia.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <leon@kernel.org>,
        Xi Wang <wangxi11@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <a42b8286-a57e-5b71-9fac-f918c061f0a8@huawei.com>
Date:   Sat, 21 Aug 2021 17:37:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210819235449.GA398955@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/8/20 7:54, Jason Gunthorpe wrote:
> On Thu, Jul 29, 2021 at 10:19:12AM +0800, Wenpeng Liang wrote:
> 
>> +static int UVERBS_HANDLER(HNS_IB_METHOD_DCA_MEM_REG)(
>> +	struct uverbs_attr_bundle *attrs)
>> +{
>> +	struct hns_roce_ucontext *uctx = uverbs_attr_to_hr_uctx(attrs);
>> +	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->ibucontext.device);
>> +	struct ib_uobject *uobj =
>> +		uverbs_attr_get_uobject(attrs, HNS_IB_ATTR_DCA_MEM_REG_HANDLE);
>> +	struct dca_mem_attr init_attr = {};
>> +	struct dca_mem *mem;
>> +	int ret;
>> +
>> +	if (uverbs_copy_from(&init_attr.addr, attrs,
>> +			     HNS_IB_ATTR_DCA_MEM_REG_ADDR) ||
>> +	    uverbs_copy_from(&init_attr.size, attrs,
>> +			     HNS_IB_ATTR_DCA_MEM_REG_LEN) ||
>> +	    uverbs_copy_from(&init_attr.key, attrs,
>> +			     HNS_IB_ATTR_DCA_MEM_REG_KEY))
>> +		return -EFAULT;
> 
> This should return the code from uverbs_copy_from() not
> -EFAULT.
> 

I will fix it, including the other uverbs_copy_from of this patchset.

>> +DECLARE_UVERBS_NAMED_METHOD(
>> +	HNS_IB_METHOD_DCA_MEM_REG,
>> +	UVERBS_ATTR_IDR(HNS_IB_ATTR_DCA_MEM_REG_HANDLE, HNS_IB_OBJECT_DCA_MEM,
>> +			UVERBS_ACCESS_NEW, UA_MANDATORY),
>> +	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_REG_LEN, UVERBS_ATTR_TYPE(u32),
>> +			   UA_MANDATORY),
>> +	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_REG_ADDR, UVERBS_ATTR_TYPE(u64),
>> +			   UA_MANDATORY),
>> +	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_REG_KEY, UVERBS_ATTR_TYPE(u64),
>> +			   UA_MANDATORY));
> 
> I think these ptr_in's are supposed to be const_in these days? The
> code you were referencing for this pre-dates const_in and hasn't been
> converted.
> 
> The distinction is that const_in is only for small < 64 bit types.
> 
> Please check all the cases for both of these things
> 

thanks,

>> +extern const struct uapi_definition hns_roce_dca_uapi_defs[];
>> +static const struct uapi_definition hns_roce_uapi_defs[] = {
>> +	UAPI_DEF_CHAIN(hns_roce_dca_uapi_defs),
>> +	{}
>> +};
> 
> The 2nd array isn't necessary, is it?
> 
> Jason
> .
> 

I will delete it.

Thanks,
Wenpeng.


