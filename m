Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E7DFA0A
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 03:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfJVBHp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 21:07:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4743 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727953AbfJVBHp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 21:07:45 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 13D85B15AB4D2ED69D9E;
        Tue, 22 Oct 2019 09:07:41 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 22 Oct 2019
 09:07:31 +0800
Subject: Re: [RFC PATCH V2 for-next] RDMA/hns: Add UD support for hip08
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1571474772-2212-1-git-send-email-oulijun@huawei.com>
 <20191021141312.GD25178@ziepe.ca>
 <9eea1f7b-fef1-080a-2f54-64b914822c94@huawei.com>
 <ad4a492cfd16ab37186d7fdead215ba52f5c3da5.camel@redhat.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <0222baee-1ef1-dd7b-ab13-fd228de9f85f@huawei.com>
Date:   Tue, 22 Oct 2019 09:07:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <ad4a492cfd16ab37186d7fdead215ba52f5c3da5.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/10/21 22:58, Doug Ledford 写道:
> On Mon, 2019-10-21 at 22:20 +0800, oulijun wrote:
>> 在 2019/10/21 22:13, Jason Gunthorpe 写道:
>>> On Sat, Oct 19, 2019 at 04:46:12PM +0800, Lijun Ou wrote:
>>>> index bd78ff9..722cc5f 100644
>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
>>>> @@ -377,6 +377,10 @@ static int hns_roce_set_user_sq_size(struct
>>>> hns_roce_dev *hr_dev,
>>>>  		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp-
>>>>> sq.wqe_cnt *
>>>>  							(hr_qp-
>>>>> sq.max_gs - 2));
>>>>  
>>>> +	if (hr_qp->ibqp.qp_type == IB_QPT_UD)
>>>> +		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp-
>>>>> sq.wqe_cnt *
>>>> +						       hr_qp-
>>>>> sq.max_gs);
>>>> +
>>>>  	if ((hr_qp->sq.max_gs > 2) && (hr_dev->pci_dev->revision ==
>>>> 0x20)) {
>>>>  		if (hr_qp->sge.sge_cnt > hr_dev->caps.max_extend_sg) {
>>>>  			dev_err(hr_dev->dev,
>>>> @@ -1022,6 +1026,9 @@ struct ib_qp *hns_roce_create_qp(struct
>>>> ib_pd *pd,
>>>>  	int ret;
>>>>  
>>>>  	switch (init_attr->qp_type) {
>>>> +	case IB_QPT_UD:
>>>> +		if (!capable(CAP_NET_RAW))
>>>> +			return -EPERM;
>>> This needs a big comment explaining why this HW requires it.
>>>
>>> Jason
>>>
>> Add the detail comments for HW limit?
> I can add those comments while taking the pactch.  Plus we need to add a
> fallthrough annotation at the same place.  I'll fix it up and unfreeze
> the hns queue.
>
Thanks


