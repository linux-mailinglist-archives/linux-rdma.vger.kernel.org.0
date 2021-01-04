Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7C72E9143
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jan 2021 08:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbhADHmA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 4 Jan 2021 02:42:00 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4128 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbhADHmA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jan 2021 02:42:00 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4D8SGP00M8zXvlq;
        Mon,  4 Jan 2021 15:40:28 +0800 (CST)
Received: from dggema751-chm.china.huawei.com (10.1.198.193) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 4 Jan 2021 15:41:16 +0800
Received: from dggema703-chm.china.huawei.com (10.3.20.67) by
 dggema751-chm.china.huawei.com (10.1.198.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 4 Jan 2021 15:41:16 +0800
Received: from dggema703-chm.china.huawei.com ([10.8.64.130]) by
 dggema703-chm.china.huawei.com ([10.8.64.130]) with mapi id 15.01.1913.007;
 Mon, 4 Jan 2021 15:41:16 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH for-next] RDMA/hns: Create CQ with selected CQN for bank
 load balance
Thread-Topic: [PATCH for-next] RDMA/hns: Create CQ with selected CQN for bank
 load balance
Thread-Index: AQHW4mgkZnW5HkhXHkG1JdrkVb8Vqw==
Date:   Mon, 4 Jan 2021 07:41:16 +0000
Message-ID: <cec4db14c2f94c5484324c8c3ad5af2d@huawei.com>
References: <1609742115-47270-1-git-send-email-liweihang@huawei.com>
 <20210104070616.GE31158@unreal>
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

On 2021/1/4 15:06, Leon Romanovsky wrote:
> On Mon, Jan 04, 2021 at 02:35:15PM +0800, Weihang Li wrote:
>> From: Yangyang Li <liyangyang20@huawei.com>
>>
>> In order to improve performance by balancing the load between different
>> banks of cache, the CQC cache is desigend to choose one of 4 banks
>> according to lower 2 bits of CQN. The hns driver needs to count the number
>> of CQ on each bank and then assigns the CQ being created to the bank with
>> the minimum load first.
>>
>> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_cq.c     | 114 +++++++++++++++++++++++-----
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  10 ++-
>>  drivers/infiniband/hw/hns/hns_roce_main.c   |   8 +-
>>  3 files changed, 104 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
>> index 8533fc2..00350a3 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_cq.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
>> @@ -38,11 +38,74 @@
>>  #include "hns_roce_hem.h"
>>  #include "hns_roce_common.h"
>>
> 
> <...>
> 
>> +	id = ida_alloc_range(&bank->ida, bank->min, bank->max, GFP_ATOMIC);
> 
> Do you create CQ in atomic context?
> It is probably GFP_KERNEL and not GFP_ATOMIC.
> 
> Thanks
> 

Hi Leon,

Thanks for your reminder, we should use GFP_KERNEL and the spin lock of banks
needs to be changed to mutex lock.

Weihang
