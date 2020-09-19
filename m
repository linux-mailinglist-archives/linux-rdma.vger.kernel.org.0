Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6E3270C31
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 11:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgISJZn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sat, 19 Sep 2020 05:25:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3552 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbgISJZn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 19 Sep 2020 05:25:43 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 64C798531C50D49317DC;
        Sat, 19 Sep 2020 17:25:39 +0800 (CST)
Received: from dggema752-chm.china.huawei.com (10.1.198.194) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 19 Sep 2020 17:25:39 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema752-chm.china.huawei.com (10.1.198.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 19 Sep 2020 17:25:38 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Sat, 19 Sep 2020 17:25:38 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Create QP/CQ with selected QPN/CQN for
 bank load balance
Thread-Topic: [PATCH for-next] RDMA/hns: Create QP/CQ with selected QPN/CQN
 for bank load balance
Thread-Index: AQHWjceX3aRvAeQKjEuzXmMmmBepcA==
Date:   Sat, 19 Sep 2020 09:25:38 +0000
Message-ID: <5050c67e33754c6ca390b0203a979858@huawei.com>
References: <1599642563-10264-1-git-send-email-liweihang@huawei.com>
 <20200918142525.GA306144@nvidia.com>
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

On 2020/9/18 22:25, Jason Gunthorpe wrote:
> On Wed, Sep 09, 2020 at 05:09:23PM +0800, Weihang Li wrote:
>> From: Yangyang Li <liyangyang20@huawei.com>
>>
>> In order to improve performance by balancing the load between different
>> banks of cache, the QPC cache is desigend to choose one of 8 banks
>> according to lower 3 bits of QPN, and the CQC cache uses the lower 2 bits
>> to choose one from 4 banks. The hns driver needs to count the number of
>> QP/CQ on each bank and then assigns the QP/CQ being created to the bank
>> with the minimum load first.
>>
>> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_alloc.c  | 46 +++++++++++++++++++++++++++++
>>  drivers/infiniband/hw/hns/hns_roce_cq.c     | 38 +++++++++++++++++++++++-
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  8 +++++
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 39 ++++++++++++++++++++++--
>>  4 files changed, 128 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
>> index a522cb2..cbe955c 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
>> @@ -36,6 +36,52 @@
>>  #include "hns_roce_device.h"
>>  #include <rdma/ib_umem.h>
>>  
>> +static int get_bit(struct hns_roce_bitmap *bitmap, u8 bankid,
>> +		   u8 mod, unsigned long *obj)
>> +{
>> +	unsigned long offset_bak = bitmap->last;
>> +	bool one_circle_flag = false;
>> +
>> +	do {
>> +		*obj = find_next_zero_bit(bitmap->table, bitmap->max,
>> +					  bitmap->last);
>> +		if (*obj >= bitmap->max) {
>> +			*obj = find_first_zero_bit(bitmap->table, bitmap->max);
>> +			one_circle_flag = true;
>> +		}
>> +
>> +		bitmap->last = (*obj + 1);
>> +		if (bitmap->last == bitmap->max) {
>> +			bitmap->last = 0;
>> +			one_circle_flag = true;
>> +		}
>> +
>> +		/* Not found after a round of search */
>> +		if (bitmap->last >= offset_bak && one_circle_flag)
>> +			return -EINVAL;
>> +
>> +	} while (*obj % mod != bankid);
>> +
>> +	return 0;
>> +}
> 
> This looks like an ida, is there a reason it has to be open coded?
> 
> Jason
> 

Hi Jason,

Do you mean that the function get_bit() may be replaced by the ida
interfaces?

Thanks for your reminder, we didn't notice these interfaces before.
We'll look at them to see if they can meet our needs. If not, we will
explain in more detail about why we implement this function.

Weihang
