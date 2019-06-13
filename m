Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 739484385D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbfFMPFS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:05:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18569 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732447AbfFMOPp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 10:15:45 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 884B35EB88E6AF8D283F;
        Thu, 13 Jun 2019 22:06:53 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Jun 2019
 22:06:32 +0800
Subject: Re: [PATCH] RDMA/hns: Fix an error code in
 hns_roce_set_user_sq_size()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20190608092714.GE28890@mwanda>
 <20190612172316.GU6369@mtr-leonro.mtl.com> <20190613060517.GF1915@kadam>
From:   oulijun <oulijun@huawei.com>
Message-ID: <5c35d77f-c9e2-8fe0-86d4-2a1e5a3362e3@huawei.com>
Date:   Thu, 13 Jun 2019 22:05:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20190613060517.GF1915@kadam>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/6/13 14:05, Dan Carpenter 写道:
> On Wed, Jun 12, 2019 at 08:23:16PM +0300, Leon Romanovsky wrote:
>> On Sat, Jun 08, 2019 at 12:27:14PM +0300, Dan Carpenter wrote:
>>> This function is supposed to return negative kernel error codes but here
>>> it returns CMD_RST_PRC_EBUSY (2).  The error code eventually gets passed
>>> to IS_ERR() and since it's not an error pointer it leads to an Oops in
>>> hns_roce_v1_rsv_lp_qp()
>>>
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> ---
>>> Static analysis.  Not tested.
>>>
>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>> index ac017c24b200..018ff302ab9e 100644
>>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>> @@ -1098,7 +1098,7 @@ static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
>>>  	if (ret == CMD_RST_PRC_SUCCESS)
>>>  		return 0;
>>>  	if (ret == CMD_RST_PRC_EBUSY)
>> The better fix will be to remove CMD_RST_PRC_* definitions in favor of
>> normal errno.
>>
> Yes.
>
> I've looked at that idea and I would almost feel like it's easy enough
> to send a patch like that without testing it at all.  But it would be
> better if the people with the hardware sent it.  I reported this bug
> months ago...
>
> regards,
> dan carpenter
>
> .
Hi, dan carpenter
   Sorry to reply slowly. I have noticed before months ago when I see your email.
But we are sorting through our entire process and haven't had time to deal with
it yet.

  We are agree with your modifications after analysis.   For leon's advice,  We are
considering. If consider to use normal errno, it is not easy to review the entire
reset for others.
  We will give a patch for testing and send it.

Thanks.
Lijun Ou
   



