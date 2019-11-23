Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F11B107C86
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Nov 2019 03:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfKWCnO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Nov 2019 21:43:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbfKWCnO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 Nov 2019 21:43:14 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BA4A7C69B205942F1671;
        Sat, 23 Nov 2019 10:43:12 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sat, 23 Nov 2019
 10:43:03 +0800
Subject: Re: [PATCH rdma-core 1/7] libhns: Fix calculation errors with
 ilog32()
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1574299169-31457-1-git-send-email-liweihang@hisilicon.com>
 <1574299169-31457-2-git-send-email-liweihang@hisilicon.com>
 <678F3D1BB717D949B966B68EAEB446ED300CC8A5@dggemm526-mbx.china.huawei.com>
 <20191122180933.GE7448@ziepe.ca>
From:   Weihang Li <liweihang@hisilicon.com>
Message-ID: <35086d20-0f48-c5a8-dae7-afaa9b4ed3e4@hisilicon.com>
Date:   Sat, 23 Nov 2019 10:43:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191122180933.GE7448@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/11/23 2:09, Jason Gunthorpe wrote:
> On Fri, Nov 22, 2019 at 02:58:44AM +0000, Zengtao (B) wrote:
>>> From: linux-rdma-owner@vger.kernel.org
>>> [mailto:linux-rdma-owner@vger.kernel.org] On Behalf Of Weihang Li
>>> Sent: Thursday, November 21, 2019 9:19 AM
>>> To: jgg@ziepe.ca; leon@kernel.org
>>> Cc: dledford@redhat.com; linux-rdma@vger.kernel.org; Linuxarm
>>> Subject: [PATCH rdma-core 1/7] libhns: Fix calculation errors with ilog32()
>>>
>>> Current calculation results using ilog32() is larger than expected, which
>>> will lead to driver broken. The following is the log when QP creations
>>> fails:
>>>
>>> [   81.294844] hns3 0000:7d:00.0 hns_0: check SQ size error!
>>> [   81.294848] hns3 0000:7d:00.0 hns_0: check SQ size error!
>>> [   81.300225] hns3 0000:7d:00.0 hns_0: Sanity check sq size failed
>>> [   81.300227] hns3 0000:7d:00.0: hns_roce_set_user_sq_size error for
>>> create qp
>>> [   81.305602] hns3 0000:7d:00.0 hns_0: Sanity check sq size failed
>>> [   81.305603] hns3 0000:7d:00.0: hns_roce_set_user_sq_size error for
>>> create qp
>>> [   81.311589] hns3 0000:7d:00.0 hns_0: Create RC QP 0x000000
>>> failed(-22)
>>> [   81.318603] hns3 0000:7d:00.0 hns_0: Create RC QP 0x000000
>>> failed(-22)
>>>
>>> Fixes: b6cd213b276f ("libhns: Refactor for creating qp")
>>> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
>>>  providers/hns/hns_roce_u_verbs.c | 11 ++++++-----
>>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/providers/hns/hns_roce_u_verbs.c
>>> b/providers/hns/hns_roce_u_verbs.c
>>> index 9d222c0..bd5060d 100644
>>> +++ b/providers/hns/hns_roce_u_verbs.c
>>> @@ -645,7 +645,8 @@ static int hns_roce_calc_qp_buff_size(struct
>>> ibv_pd *pd, struct ibv_qp_cap *cap,
>>>  	int page_size = to_hr_dev(pd->context->device)->page_size;
>>>
>>>  	if (to_hr_dev(pd->context->device)->hw_version ==
>>> HNS_ROCE_HW_VER1) {
>>> -		qp->rq.wqe_shift = ilog32(sizeof(struct hns_roce_rc_rq_wqe));
>>> +		qp->rq.wqe_shift =
>>> +				ilog32(sizeof(struct hns_roce_rc_rq_wqe)) - 1;
>>>
>>>  		qp->buf_size = align((qp->sq.wqe_cnt << qp->sq.wqe_shift),
>>>  				     page_size) +
>>> @@ -662,7 +663,7 @@ static int hns_roce_calc_qp_buff_size(struct
>>> ibv_pd *pd, struct ibv_qp_cap *cap,
>>>  	} else {
>>>  		unsigned int rqwqe_size = HNS_ROCE_SGE_SIZE *
>>> cap->max_recv_sge;
>>>
>>> -		qp->rq.wqe_shift = ilog32(rqwqe_size);
>>> +		qp->rq.wqe_shift = ilog32(rqwqe_size) - 1;
>>>
>>>  		if (qp->sq.max_gs > HNS_ROCE_SGE_IN_WQE || type ==
>>> IBV_QPT_UD)
>>>  			qp->sge.sge_shift = HNS_ROCE_SGE_SHIFT;
>>> @@ -747,8 +748,8 @@ static void hns_roce_set_qp_params(struct
>>> ibv_pd *pd,
>>>  		qp->rq.wqe_cnt =
>>> roundup_pow_of_two(attr->cap.max_recv_wr);
>>>  	}
>>>
>>> -	qp->sq.wqe_shift = ilog32(sizeof(struct hns_roce_rc_send_wqe));
>>> -	qp->sq.shift = ilog32(qp->sq.wqe_cnt);
>>> +	qp->sq.wqe_shift = ilog32(sizeof(struct hns_roce_rc_send_wqe)) - 1;
>>> +	qp->sq.shift = ilog32(qp->sq.wqe_cnt) - 1;
>>
>> One suggestion, it's better to introduce a new micro instead of ilog32(x) -1.
> 
> Is the -1 even correct?
> 
> I would have guessed something called shift wants to be:
> 
>    shift = ilog32(qp->sq.wqe_cnt - 1)
> 
> Such that 
>    1 << shift == wqe_cnt
>        When wqe_cnt is a power of two.
>    1 << shift > wqe_cnt
>        When wqe_cnt is not a power of two.
> 
> Jason
> 

That's right, shift = ilog32(n - 1) is always right, but result of
ilog32(n) - 1 is only correct when n is a power of two.

Will modify to ilog32(n - 1).

Thank you
Weihang


> .
> 

