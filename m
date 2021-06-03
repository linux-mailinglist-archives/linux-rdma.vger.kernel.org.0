Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76E439986E
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 05:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFCDOB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 2 Jun 2021 23:14:01 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7079 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhFCDOA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Jun 2021 23:14:00 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FwW8V0xfhzYnVj;
        Thu,  3 Jun 2021 11:09:30 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (7.185.36.148) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 11:12:15 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml100021.china.huawei.com (7.185.36.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 11:12:14 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Thu, 3 Jun 2021 11:12:14 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "wangxi (M)" <wangxi11@huawei.com>
Subject: Re: [PATCH for-next 1/2] RDMA/hns: Refactor hns uar mmap flow
Thread-Topic: [PATCH for-next 1/2] RDMA/hns: Refactor hns uar mmap flow
Thread-Index: AQHXU6KIYF57APVpj02AMxmljmiQ3A==
Date:   Thu, 3 Jun 2021 03:12:14 +0000
Message-ID: <2fd072cd42804bc9aa2948123fcf48cf@huawei.com>
References: <1622193545-3281-1-git-send-email-liweihang@huawei.com>
 <1622193545-3281-2-git-send-email-liweihang@huawei.com>
 <YLdocig+JjG+nLF+@unreal>
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

On 2021/6/2 19:16, Leon Romanovsky wrote:
> On Fri, May 28, 2021 at 05:19:04PM +0800, Weihang Li wrote:
>> From: Xi Wang <wangxi11@huawei.com>
>>
>> Classify the uar address by wrapping the uar type and start page as offset
>> for hns rdma io mmap.
>>
>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_main.c | 27 ++++++++++++++++++++++++---
>>  include/uapi/rdma/hns-abi.h               |  4 ++++
>>  2 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
>> index 6c6e82b..00dbbf1 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
>> @@ -338,12 +338,23 @@ static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
>>  	hns_roce_uar_free(to_hr_dev(ibcontext->device), &context->uar);
>>  }
>>  
>> -static int hns_roce_mmap(struct ib_ucontext *context,
>> -			 struct vm_area_struct *vma)
>> +/* command value is offset[15:8] */
>> +static inline int hns_roce_mmap_get_command(unsigned long offset)
>> +{
>> +	return (offset >> 8) & 0xff;
>> +}
>> +
>> +/* index value is offset[63:16] | offset[7:0] */
>> +static inline unsigned long hns_roce_mmap_get_index(unsigned long offset)
>> +{
>> +	return ((offset >> 16) << 8) | (offset & 0xff);
>> +}
> 
> Let's follow the common practice and don't introduce inline functions in .c files.
> 
> Thanks
> 

Sure, thanks.

Weihang
