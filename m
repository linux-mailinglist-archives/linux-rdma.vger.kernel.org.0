Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C192A3552E7
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 13:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343552AbhDFL4N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 6 Apr 2021 07:56:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3514 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243384AbhDFL4M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 07:56:12 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FF5XW0DT3zRZ5s;
        Tue,  6 Apr 2021 19:54:03 +0800 (CST)
Received: from dggpemm100004.china.huawei.com (7.185.36.189) by
 DGGEML401-HUB.china.huawei.com (10.3.17.32) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 6 Apr 2021 19:56:02 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpemm100004.china.huawei.com (7.185.36.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 19:56:02 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Tue, 6 Apr 2021 19:56:02 +0800
From:   liweihang <liweihang@huawei.com>
To:     chenglang <chenglang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "wangxi (M)" <wangxi11@huawei.com>
Subject: Re: [PATCH for-next 1/6] RDMA/hns: Simplify function's resource
 related command
Thread-Topic: [PATCH for-next 1/6] RDMA/hns: Simplify function's resource
 related command
Thread-Index: AQHXJ56x1wd7Q3CycEO0m538GDPOKw==
Date:   Tue, 6 Apr 2021 11:56:02 +0000
Message-ID: <59c69aa6ff594efe8cf9f04ebd9ea562@huawei.com>
References: <1617353896-40727-1-git-send-email-liweihang@huawei.com>
 <1617353896-40727-2-git-send-email-liweihang@huawei.com>
 <0426cfd3-da56-6ec4-355e-969690b93ab0@huawei.com>
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

On 2021/4/2 20:17, chenglang wrote:
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
>> index 23c438c..5b5fedf 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_common.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_common.h
>> @@ -87,6 +87,17 @@
>>   
>>   #define hr_reg_write(ptr, field, val) _hr_reg_write(ptr, field, val)
>>   
>> +#define _hr_reg_read(ptr, field_type, field_h, field_l)                        \
>> +	({                                                                     \
>> +		const field_type *_ptr = ptr;                                  \
>> +		BUILD_BUG_ON(((field_h) / 32) != ((field_l) / 32));            \
>> +		((le32_to_cpu(*((__le32 *)_ptr + (field_h) / 32)) &            \
>> +		  GENMASK((field_h) % 32, (field_l) % 32)) >>                  \
>> +		 ((field_l) % 32));                                            \
>> +	})
> I will try this:
> 
> #define _hr_reg_read(ptr, field_type, field_h, field_l) 
> 
> 	({
> 		const field_type *_ptr = ptr;
> 		FIELD_GET(GENMASK((field_h) % 32, (field_l) % 32),
> 			  le32_to_cpu(*((__le32 *)_ptr +(field_h)/32)))
> 		+ BUILD_BUG_ON_ZERO(((field_h) / 32) != ((field_l) / 32));
> 	})
> 
> 
> Thanks.
> 

OK, I will send v2 instead.

Thanks
Weihang
