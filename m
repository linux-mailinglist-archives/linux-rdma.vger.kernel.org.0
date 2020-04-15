Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E200C1A9041
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 03:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389055AbgDOBPq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 14 Apr 2020 21:15:46 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:41678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388394AbgDOBPn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 21:15:43 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 1E12957534F9F18236F8;
        Wed, 15 Apr 2020 09:15:38 +0800 (CST)
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.102]) by
 DGGEML403-HUB.china.huawei.com ([fe80::74d9:c659:fbec:21fa%31]) with mapi id
 14.03.0487.000; Wed, 15 Apr 2020 09:15:28 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 3/6] RDMA/hns: Simplify the qp state convert
 code
Thread-Topic: [PATCH for-next 3/6] RDMA/hns: Simplify the qp state convert
 code
Thread-Index: AQHWEV6FH2zX2yyFxUKHVDP6F7KFBA==
Date:   Wed, 15 Apr 2020 01:15:28 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A022FF6D6@DGGEML522-MBX.china.huawei.com>
References: <1586760042-40516-1-git-send-email-liweihang@huawei.com>
 <1586760042-40516-4-git-send-email-liweihang@huawei.com>
 <20200414125600.GB5100@ziepe.ca>
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
> On Mon, Apr 13, 2020 at 02:40:39PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> Use type map table to reduce the cyclomatic complexity.
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 27 ++++++++++++++-------------
>>  1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 6816278..e938bd8 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -4540,19 +4540,20 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
>>  	return ret;
>>  }
>>  
>> -static inline enum ib_qp_state to_ib_qp_st(enum hns_roce_v2_qp_state state)
>> -{
>> -	switch (state) {
>> -	case HNS_ROCE_QP_ST_RST:	return IB_QPS_RESET;
>> -	case HNS_ROCE_QP_ST_INIT:	return IB_QPS_INIT;
>> -	case HNS_ROCE_QP_ST_RTR:	return IB_QPS_RTR;
>> -	case HNS_ROCE_QP_ST_RTS:	return IB_QPS_RTS;
>> -	case HNS_ROCE_QP_ST_SQ_DRAINING:
>> -	case HNS_ROCE_QP_ST_SQD:	return IB_QPS_SQD;
>> -	case HNS_ROCE_QP_ST_SQER:	return IB_QPS_SQE;
>> -	case HNS_ROCE_QP_ST_ERR:	return IB_QPS_ERR;
>> -	default:			return -1;
>> -	}
>> +static int to_ib_qp_st(enum hns_roce_v2_qp_state state)
>> +{
>> +	const enum ib_qp_state map[] = {
> 
> Should be static
> 
> Jason
> 

OK, thank you.

Weihang
