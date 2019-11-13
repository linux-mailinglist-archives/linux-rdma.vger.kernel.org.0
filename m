Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95604FAA6F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 07:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKMGrh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 01:47:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbfKMGrh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Nov 2019 01:47:37 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EAC26263DE4128090E24;
        Wed, 13 Nov 2019 14:47:34 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 14:47:29 +0800
Subject: Re: [RFC PATCH V2 for-next] RDMA/hns: Add UD support for hip08
To:     Doug Ledford <dledford@redhat.com>, oulijun <oulijun@huawei.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1571474772-2212-1-git-send-email-oulijun@huawei.com>
 <20191021141312.GD25178@ziepe.ca>
 <9eea1f7b-fef1-080a-2f54-64b914822c94@huawei.com>
 <ad4a492cfd16ab37186d7fdead215ba52f5c3da5.camel@redhat.com>
 <4ab0f98e4569a9700d94173c7f3d93e00bd9635b.camel@redhat.com>
From:   Weihang Li <liweihang@hisilicon.com>
Message-ID: <6de24f84-c360-eb1f-9f3e-a90ff7f9a75c@hisilicon.com>
Date:   Wed, 13 Nov 2019 14:47:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4ab0f98e4569a9700d94173c7f3d93e00bd9635b.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/10/22 0:45, Doug Ledford wrote:
> On Mon, 2019-10-21 at 10:58 -0400, Doug Ledford wrote:
>> On Mon, 2019-10-21 at 22:20 +0800, oulijun wrote:
>>> 在 2019/10/21 22:13, Jason Gunthorpe 写道:
>>>> On Sat, Oct 19, 2019 at 04:46:12PM +0800, Lijun Ou wrote:
>>>>> index bd78ff9..722cc5f 100644
>>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
>>>>> @@ -377,6 +377,10 @@ static int hns_roce_set_user_sq_size(struct
>>>>> hns_roce_dev *hr_dev,
>>>>>  		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp-
>>>>>> sq.wqe_cnt *
>>>>>  							(hr_qp-
>>>>>> sq.max_gs - 2));
>>>>>  
>>>>> +	if (hr_qp->ibqp.qp_type == IB_QPT_UD)
>>>>> +		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp-
>>>>>> sq.wqe_cnt *
>>>>> +						       hr_qp-
>>>>>> sq.max_gs);
>>>>> +
>>>>>  	if ((hr_qp->sq.max_gs > 2) && (hr_dev->pci_dev->revision 
>>>>> ==
>>>>> 0x20)) {
>>>>>  		if (hr_qp->sge.sge_cnt > hr_dev-
>>>>>> caps.max_extend_sg) {
>>>>>  			dev_err(hr_dev->dev,
>>>>> @@ -1022,6 +1026,9 @@ struct ib_qp *hns_roce_create_qp(struct
>>>>> ib_pd *pd,
>>>>>  	int ret;
>>>>>  
>>>>>  	switch (init_attr->qp_type) {
>>>>> +	case IB_QPT_UD:
>>>>> +		if (!capable(CAP_NET_RAW))
>>>>> +			return -EPERM;
>>>> This needs a big comment explaining why this HW requires it.
>>>>
>>>> Jason
>>>>
>>> Add the detail comments for HW limit?
>>
>> I can add those comments while taking the pactch.  Plus we need to add
>> a
>> fallthrough annotation at the same place.  I'll fix it up and unfreeze
>> the hns queue.
>>
> 
> Does this meet people's approval?
> 
>         switch (init_attr->qp_type) {
>         case IB_QPT_UD:
>                 /*
>                  * DO NOT REMOVE!
>                  * The HNS RoCE hardware has a security vulnerability.
>                  * Normally, UD packet routing is achieved using nothing
>                  * but the ib_ah struct, which contains the src gid in the
>                  * sgid_attr element.  Th src gid is sufficient for the
>                  * hardware to know if any vlan tag is needed, as well as
>                  * any priority tag.  In the case of HNS RoCE, the vlan
>                  * tag is passed to the hardware along with the src gid.
>                  * This allows a situation where a malicious user could
>                  * intentionally send packets with a gid that belongs to
>                  * vlan A, but direct the packets to go out to vlan B
>                  * instead.
>                  * Because the ability to send out packets with arbitrary
>                  * headers is reserved for CAP_NET_RAW, and because UD
>                  * queue pairs can be tricked into doing that, make all
>                  * UD queue pairs on this hardware require CAP_NET_RAW.
>                  */
>                 if (!capable(CAP_NET_RAW))
>                         return -EPERM;
>                 /* fallthrough */
>         case IB_QPT_RC: {
> 

Hi Doug,

To avoid the potential risk of vlan config issue, we decide to remove this patch.
Thanks a lot for the work of you, Jason and Leon on this issue.

Weihang

