Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C043A3A2B1A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 14:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhFJMJg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 10 Jun 2021 08:09:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3834 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhFJMJg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 08:09:36 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G12fX4F34zWsm9;
        Thu, 10 Jun 2021 20:02:44 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 10 Jun 2021 20:07:37 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Thu, 10 Jun 2021 20:07:37 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "wangxi (M)" <wangxi11@huawei.com>
Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Refactor hns uar mmap flow
Thread-Topic: [PATCH v2 for-next 1/2] RDMA/hns: Refactor hns uar mmap flow
Thread-Index: AQHXWEtQbUfYhVHElUWTjIZAehxZUg==
Date:   Thu, 10 Jun 2021 12:07:37 +0000
Message-ID: <0e9d9c39fbd4487ca17791dedca9d9b4@huawei.com>
References: <1622705834-19353-1-git-send-email-liweihang@huawei.com>
 <1622705834-19353-2-git-send-email-liweihang@huawei.com>
 <20210603191205.GA318515@nvidia.com>
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

On 2021/6/4 3:12, Jason Gunthorpe wrote:
> On Thu, Jun 03, 2021 at 03:37:13PM +0800, Weihang Li wrote:
>> From: Xi Wang <wangxi11@huawei.com>
>>
>> Classify the uar address by wrapping the uar type and start page as offset
>> for hns rdma io mmap.
>>
>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_main.c | 27 ++++++++++++++++++++++++---
>>  include/uapi/rdma/hns-abi.h               |  4 ++++
>>  2 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
>> index 6c6e82b..9610bfd 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
>> @@ -338,12 +338,23 @@ static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
>>  	hns_roce_uar_free(to_hr_dev(ibcontext->device), &context->uar);
>>  }
>>  
>> -static int hns_roce_mmap(struct ib_ucontext *context,
>> -			 struct vm_area_struct *vma)
>> +/* command value is offset[15:8] */
>> +static int hns_roce_mmap_get_command(unsigned long offset)
>> +{
>> +	return (offset >> 8) & 0xff;
>> +}
>> +
>> +/* index value is offset[63:16] | offset[7:0] */
>> +static unsigned long hns_roce_mmap_get_index(unsigned long offset)
>> +{
>> +	return ((offset >> 16) << 8) | (offset & 0xff);
>> +}
> 
> Please try to avoid using this command stuff copied from mlx drivers,
> especially do not encode the qpn in this.
> 
> The proper way is to request and return a mmap cookie through the
> verb that causes the page to be allocated. For instance specifying a
> new input parameter to the create QP udata and an output parameter
> with the mmap cookie.
> 
> You can look at what the mlx UAR stuff does for some idea how to
> convert the old command style to a the preferred cookie style.
> 
> Jason
> 

Thank you, we'll look at the implementation of mlx and how to use the existing
interfaces in the framework.

Weihang
