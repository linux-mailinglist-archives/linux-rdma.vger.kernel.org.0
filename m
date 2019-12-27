Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD8D12B3C2
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Dec 2019 10:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfL0J72 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Dec 2019 04:59:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbfL0J70 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Dec 2019 04:59:26 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1ADF5D914ACF702EC144;
        Fri, 27 Dec 2019 17:59:24 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 27 Dec 2019
 17:59:17 +0800
Subject: Re: [PATCH v4 for-next 1/2] RDMA/hns: Add the workqueue framework for
 flush cqe handler
To:     Leon Romanovsky <leon@kernel.org>
CC:     <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1577193014-42646-1-git-send-email-liuyixian@huawei.com>
 <1577193014-42646-2-git-send-email-liuyixian@huawei.com>
 <20191226081923.GB6285@unreal>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <a507777e-e1cb-1473-f0cf-35346b2706ee@huawei.com>
Date:   Fri, 27 Dec 2019 17:59:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20191226081923.GB6285@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/12/26 16:19, Leon Romanovsky wrote:
> On Tue, Dec 24, 2019 at 09:10:13PM +0800, Yixian Liu wrote:
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
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  2 ++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  4 +--
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 43 +++++++++++++++++++++++++++++
>>  3 files changed, 47 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index a1b712e..292b712 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -906,6 +906,7 @@ struct hns_roce_caps {
>>  struct hns_roce_work {
>>  	struct hns_roce_dev *hr_dev;
>>  	struct work_struct work;
>> +	struct hns_roce_qp *hr_qp;
>>  	u32 qpn;
>>  	u32 cqn;
>>  	int event_type;
>> @@ -1226,6 +1227,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *ib_pd,
>>  				 struct ib_udata *udata);
>>  int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>>  		       int attr_mask, struct ib_udata *udata);
>> +void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
>>  void *get_recv_wqe(struct hns_roce_qp *hr_qp, int n);
>>  void *get_send_wqe(struct hns_roce_qp *hr_qp, int n);
>>  void *get_send_extend_sge(struct hns_roce_qp *hr_qp, int n);
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 907c951..ec48e7e 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -5967,8 +5967,8 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
>>  		goto err_request_irq_fail;
>>  	}
>>
>> -	hr_dev->irq_workq =
>> -		create_singlethread_workqueue("hns_roce_irq_workqueue");
>> +	hr_dev->irq_workq = alloc_workqueue("hns_roce_irq_workqueue",
>> +					    WQ_MEM_RECLAIM, 0);
> 
> Combination of WQ_MEM_RECLAIM flag with kzalloc inside init_flush_work()
> can't be correct at the same time.
> 
Thanks a lot for reminder!
I will check with previous discussion on the flag WQ_MEM_RECLAIM and fix it next version.

