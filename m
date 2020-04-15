Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599881A9042
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 03:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389056AbgDOBQL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 14 Apr 2020 21:16:11 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2482 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388394AbgDOBQH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 21:16:07 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 9C32ACCB51166508916D;
        Wed, 15 Apr 2020 09:16:01 +0800 (CST)
Received: from DGGEML422-HUB.china.huawei.com (10.1.199.39) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 15 Apr 2020 09:16:01 +0800
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.102]) by
 dggeml422-hub.china.huawei.com ([10.1.199.39]) with mapi id 14.03.0487.000;
 Wed, 15 Apr 2020 09:15:53 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 4/6] RDMA/hns: Simplify the cqe code of poll cq
Thread-Topic: [PATCH for-next 4/6] RDMA/hns: Simplify the cqe code of poll cq
Thread-Index: AQHWEV6GcY2/HSIcqEiHWpkevZN09A==
Date:   Wed, 15 Apr 2020 01:15:53 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A022FF6E2@DGGEML522-MBX.china.huawei.com>
References: <1586760042-40516-1-git-send-email-liweihang@huawei.com>
 <1586760042-40516-5-git-send-email-liweihang@huawei.com>
 <20200414125645.GC5100@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/4/14 20:56, Jason Gunthorpe wrote:
> On Mon, Apr 13, 2020 at 02:40:40PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> Encapsulate codes to get status of cqe into a function and use map table
>> instead of switch-case to reduce cyclomatic complexity of
>> hns_roce_v2_poll_one().
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 130 +++++++++++++----------------
>>  1 file changed, 57 insertions(+), 73 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index e938bd8..c2d2c9e 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -2954,6 +2954,61 @@ static int hns_roce_v2_sw_poll_cq(struct hns_roce_cq *hr_cq, int num_entries,
>>  	return npolled;
>>  }
>>  
>> +static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
>> +			   struct hns_roce_v2_cqe *cqe, struct ib_wc *wc)
>> +{
>> +	static struct {
>> +		u32 cqe_status;
>> +		enum ib_wc_status wc_status;
>> +	} map[] = {
> 
> Also should be const
> 
> Jason
> 

I see, thanks for your reminder.

Weihang
