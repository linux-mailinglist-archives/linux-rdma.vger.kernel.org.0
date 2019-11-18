Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD9F01006D4
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 14:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfKRNwt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 08:52:49 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58432 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbfKRNwt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Nov 2019 08:52:49 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C950D3C28F15D918035F;
        Mon, 18 Nov 2019 21:52:46 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 21:52:40 +0800
Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Add the workqueue framework for
 flush cqe handler
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1573563124-12579-1-git-send-email-liuyixian@huawei.com>
 <1573563124-12579-2-git-send-email-liuyixian@huawei.com>
 <20191115210621.GE4055@ziepe.ca>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <523cf93d-a849-ab24-36f0-903fb1afe7ff@huawei.com>
Date:   Mon, 18 Nov 2019 21:50:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20191115210621.GE4055@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/11/16 5:06, Jason Gunthorpe wrote:
> On Tue, Nov 12, 2019 at 08:52:03PM +0800, Yixian Liu wrote:
>> HiP08 RoCE hardware lacks ability(a known hardware problem) to flush
>> outstanding WQEs if QP state gets into errored mode for some reason.
>> To overcome this hardware problem and as a workaround, when QP is
>> detected to be in errored state during various legs like post send,
>> post receive etc [1], flush needs to be performed from the driver.
>>
>> The earlier patch[1] sent to solve the hardware limitation explained
>> in the cover-letter had a bug in the software flushing leg. It
>> acquired mutex while modifying QP state to errored state and while
>> conveying it to the hardware using the mailbox. This caused leg to
>> sleep while holding spin-lock and caused crash.
>>
>> Suggested Solution:
>> we have proposed to defer the flushing of the QP in the Errored state
>> using the workqueue to get around with the limitation of our hardware.
>>
>> This patch adds the framework of the workqueue and the flush handler
>> function.
>>
>> [1] https://patchwork.kernel.org/patch/10534271/
>>
>> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
>> Reviewed-by: Salil Mehta <salil.mehta@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  3 +++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  4 ++--
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 33 +++++++++++++++++++++++++++++
>>  3 files changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index a1b712e..42d8a5a 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -906,6 +906,7 @@ struct hns_roce_caps {
>>  struct hns_roce_work {
>>  	struct hns_roce_dev *hr_dev;
>>  	struct work_struct work;
>> +	struct hns_roce_qp *hr_qp;
>>  	u32 qpn;
>>  	u32 cqn;
>>  	int event_type;
>> @@ -1034,6 +1035,7 @@ struct hns_roce_dev {
>>  	const struct hns_roce_hw *hw;
>>  	void			*priv;
>>  	struct workqueue_struct *irq_workq;
>> +	struct hns_roce_work flush_work;
>>  	const struct hns_roce_dfx_hw *dfx;
>>  };
>>  
>> @@ -1226,6 +1228,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *ib_pd,
>>  				 struct ib_udata *udata);
>>  int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>>  		       int attr_mask, struct ib_udata *udata);
>> +void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
>>  void *get_recv_wqe(struct hns_roce_qp *hr_qp, int n);
>>  void *get_send_wqe(struct hns_roce_qp *hr_qp, int n);
>>  void *get_send_extend_sge(struct hns_roce_qp *hr_qp, int n);
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 907c951..ec48e7e 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -5967,8 +5967,8 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
>>  		goto err_request_irq_fail;
>>  	}
>>  
>> -	hr_dev->irq_workq =
>> -		create_singlethread_workqueue("hns_roce_irq_workqueue");
>> +	hr_dev->irq_workq = alloc_workqueue("hns_roce_irq_workqueue",
>> +					    WQ_MEM_RECLAIM, 0);
>>  	if (!hr_dev->irq_workq) {
>>  		dev_err(dev, "Create irq workqueue failed!\n");
>>  		ret = -ENOMEM;
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> index 9442f01..0111f2e 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> @@ -43,6 +43,39 @@
>>  
>>  #define SQP_NUM				(2 * HNS_ROCE_MAX_PORTS)
>>  
>> +static void flush_work_handle(struct work_struct *work)
>> +{
>> +	struct hns_roce_work *flush_work = container_of(work,
>> +					struct hns_roce_work, work);
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
>> +
>> +	if (atomic_dec_and_test(&hr_qp->refcount))
>> +		complete(&hr_qp->free);
>> +}
>> +
>> +void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
>> +{
>> +	struct hns_roce_work *flush_work = &hr_dev->flush_work;
>> +
>> +	flush_work->hr_dev = hr_dev;
>> +	flush_work->hr_qp = hr_qp;
>> +	INIT_WORK(&flush_work->work, flush_work_handle);
>> +	atomic_inc(&hr_qp->refcount);
>> +	queue_work(hr_dev->irq_workq, &flush_work->work);
> 
> It kind of looks like this can be called multiple times? It won't work
> right unless it is called exactly once
> 
> Jason

Yes, you are right.

So I think the reasonable solution is to allocate it dynamically, and I think
it is a very very little chance that the allocation will be failed. If this happened,
I think the application also needs to be over.

So I will fall back to v1 for this part in next version.

	flush_work = kzalloc(sizeof(struct hns_roce_flush_work), GFP_ATOMIC)
	if (!flush_work)
		return;

Or, could you give me some advice for it?

Thanks.

> 
> .
> 

