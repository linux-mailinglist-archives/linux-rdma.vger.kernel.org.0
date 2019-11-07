Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7283CF2E7A
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2019 13:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbfKGMuV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Nov 2019 07:50:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388089AbfKGMuV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 Nov 2019 07:50:21 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A0318C5D7802DF2471A4;
        Thu,  7 Nov 2019 20:50:16 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 7 Nov 2019
 20:50:10 +0800
Subject: Re: [PATCH for-next 1/2] RDMA/hns: Add the workqueue framework for
 flush cqe handler
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1572255945-20297-1-git-send-email-liuyixian@huawei.com>
 <1572255945-20297-2-git-send-email-liuyixian@huawei.com>
 <20191106204013.GA26459@ziepe.ca>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <e2e0f478-a057-c297-7e1e-d9b09eee2986@huawei.com>
Date:   Thu, 7 Nov 2019 20:48:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20191106204013.GA26459@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/11/7 4:40, Jason Gunthorpe wrote:
> On Mon, Oct 28, 2019 at 05:45:44PM +0800, Yixian Liu wrote:
>> @@ -1998,6 +2000,17 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
>>  		}
>>  	}
>>  
>> +	snprintf(workq_name, HNS_ROCE_WORKQ_NAME_LEN - 1,
>> +		 "hns_roce_%d_flush_wq", device_id);
>> +	device_id++;
>> +
>> +	hr_dev->flush_workq = alloc_workqueue(workq_name, WQ_HIGHPRI, 0);
>> +	if (!hr_dev->flush_workq) {
> 
> Why is this so time critical?

Hi Jason,

I am not quite sure whether you concerned with the flag "WQ_HIGHPRI" or
why WQ is created in hns_roce_v2_init.

If it is WQ_HIGHPRI, yes, it is much better to implement flush operation
ASAP to help generating flushed cqe as ULP may poll cqe urgently. If you
concerned allocation stage, as flush operation is support for hip08 only,
there is no other place proper than here I think.

> 
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> index bec48f2..2c8f726 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> @@ -43,6 +43,49 @@
>>  
>>  #define SQP_NUM				(2 * HNS_ROCE_MAX_PORTS)
>>  
>> +static void flush_work_handle(struct work_struct *work)
>> +{
>> +	struct hns_roce_flush_work *flush_work = container_of(work,
>> +					struct hns_roce_flush_work, work);
>> +	struct hns_roce_qp *hr_qp = flush_work->hr_qp;
>> +	struct device *dev = flush_work->hr_dev->dev;
>> +	struct ib_qp_attr attr;
>> +	int attr_mask;
>> +	int ret;
>> +
>> +	attr_mask = IB_QP_STATE;
>> +	attr.qp_state = IB_QPS_ERR;
>> +
>> +	ret = hns_roce_modify_qp(&hr_qp->ibqp, &attr, attr_mask, NULL);
>> +	if (ret)
>> +		dev_err(dev, "Modify QP to error state failed(%d) during CQE flush\n",
>> +			ret);
> 
> There is something wrong with your description as all this seems to do
> is tell the HW to go to the ERR state.

For the flush operation, in addition to modify qp to ERR state, the head pointers
of SQ and RQ are also told to the HW with this interface as following. This part
of codes is already there.

if (new_state == IB_QPS_ERR) {
        roce_set_field(context->byte_160_sq_ci_pi,
                       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
                       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S,
                       hr_qp->sq.head);
        roce_set_field(qpc_mask->byte_160_sq_ci_pi,
                       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
                       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S, 0);

        if (!ibqp->srq) {
                roce_set_field(context->byte_84_rq_ci_pi,
                       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
                       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S,
                       hr_qp->rq.head);
                roce_set_field(qpc_mask->byte_84_rq_ci_pi,
                       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
                       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S, 0);
        }
}

> 
> Why don't you do this from hns_roce_irq_work_handle() ?

As described in the cover letter, here we used CMWQ (concurrency management workqueue)
to make sure that flush operation can be implemented ASAP. Current irq workqueue is
a singlethread workqueue, which may delay the flush too long when the system is heavy.

Do you mean we can change irq workqueue to CMWQ to put flush work into it?

> 
>> +	kfree(flush_work);
>> +
>> +	/*
>> +	 * make sure we signal QP destroy leg that flush QP was completed
>> +	 * so that it can safely proceed ahead now and destroy QP
>> +	 */
>> +	if (atomic_dec_and_test(&hr_qp->refcount))
>> +		complete(&hr_qp->free);
> 
>> +}
>> +
>> +void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
>> +{
>> +	struct hns_roce_flush_work *flush_work;
>> +
>> +	flush_work = kzalloc(sizeof(struct hns_roce_flush_work), GFP_ATOMIC);
>> +	if (!flush_work)
>> +		return;
> 
> Don't do things that can fail here

Do you mean that as "GFP_ATOMIC" is used, the if branch can be deleted?

> 
>> +
>> +	flush_work->hr_dev = hr_dev;
>> +	flush_work->hr_qp = hr_qp;
>> +	INIT_WORK(&flush_work->work, flush_work_handle);
>> +	atomic_inc(&hr_qp->refcount);
>> +	queue_work(hr_dev->flush_workq, &flush_work->work);
>> +}
>> +
>>  void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
>>  {
>>  	struct device *dev = hr_dev->dev;
> 
> .
> 

