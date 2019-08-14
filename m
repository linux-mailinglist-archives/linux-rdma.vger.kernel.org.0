Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFBDA8CB7F
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2019 08:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHNGDh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Aug 2019 02:03:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:32932 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725263AbfHNGDh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Aug 2019 02:03:37 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9F200B841736AAF1E278;
        Wed, 14 Aug 2019 14:03:35 +0800 (CST)
Received: from [127.0.0.1] (10.74.150.236) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 14 Aug 2019
 14:03:26 +0800
Subject: Re: [PATCH for-next 3/9] RDMA/hns: Completely release qp resources
 when hw err
To:     Doug Ledford <dledford@redhat.com>, Lijun Ou <oulijun@huawei.com>,
        <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
 <1565343666-73193-4-git-send-email-oulijun@huawei.com>
 <f49c56933205d90d82ffd3fa55a951843e22cda1.camel@redhat.com>
From:   Yangyang Li <liyangyang20@huawei.com>
Message-ID: <0d325f78-a929-f088-cc29-e2c7af98fd40@huawei.com>
Date:   Wed, 14 Aug 2019 14:02:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f49c56933205d90d82ffd3fa55a951843e22cda1.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.150.236]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, Doug
Thanks a lot for your reply.

在 2019/8/12 23:29, Doug Ledford 写道:
> On Fri, 2019-08-09 at 17:41 +0800, Lijun Ou wrote:
>> From: Yangyang Li <liyangyang20@huawei.com>
>>
>> Even if no response from hardware, make sure that qp related
>> resources are completely released.
>>
>> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 7a14f0b..0409851 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -4562,16 +4562,14 @@ static int
>> hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
>>  {
>>  	struct hns_roce_cq *send_cq, *recv_cq;
>>  	struct ib_device *ibdev = &hr_dev->ib_dev;
>> -	int ret;
>> +	int ret = 0;
>>  
>>  	if (hr_qp->ibqp.qp_type == IB_QPT_RC && hr_qp->state !=
>> IB_QPS_RESET) {
>>  		/* Modify qp to reset before destroying qp */
>>  		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
>>  					    hr_qp->state, IB_QPS_RESET);
>> -		if (ret) {
>> +		if (ret)
>>  			ibdev_err(ibdev, "modify QP to Reset
>> failed.\n");
>> -			return ret;
>> -		}
>>  	}
>>  
>>  	send_cq = to_hr_cq(hr_qp->ibqp.send_cq);
>> @@ -4627,7 +4625,7 @@ static int hns_roce_v2_destroy_qp_common(struct
>> hns_roce_dev *hr_dev,
>>  		kfree(hr_qp->rq_inl_buf.wqe_list);
>>  	}
>>  
>> -	return 0;
>> +	return ret;
>>  }
>>  
>>  static int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata
>> *udata)
>> @@ -4637,11 +4635,9 @@ static int hns_roce_v2_destroy_qp(struct ib_qp
>> *ibqp, struct ib_udata *udata)
>>  	int ret;
>>  
>>  	ret = hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
>> -	if (ret) {
>> +	if (ret)
>>  		ibdev_err(&hr_dev->ib_dev, "Destroy qp 0x%06lx
>> failed(%d)\n",
>>  			  hr_qp->qpn, ret);
>> -		return ret;
>> -	}
>>  
>>  	if (hr_qp->ibqp.qp_type == IB_QPT_GSI)
>>  		kfree(hr_to_hr_sqp(hr_qp));
> 
> I don't know your hardware, but this patch sounds wrong/dangerous to me.
> As long as the resources this card might access are allocated by the
> kernel, you can't get random data corruption by the card writing to
> memory used elsewhere in the kernel.  So if your card is not responding
> to your requests to free the resources, it would seem safer to leak
> those resources permanently than to free them and risk the card coming
> back to life long enough to corrupt memory reallocated to some other
> task.
> 
> Only if you can guarantee me that there is no way your commands to the
> card will fail and then the card start working again later would I
> consider this patch safe.  And if it's possible for the card to hang
> like this, should that be triggering a reset of the device?
> 

Thanks for your suggestion, I agree with you, it would seem safer to leak
those resources permanently than to free them. I will abandon this change
and consider cleaning up these leaked resources during uninstallation or reset.

Thanks

