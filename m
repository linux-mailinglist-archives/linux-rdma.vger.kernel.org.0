Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C8E47CB6D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Dec 2021 03:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241959AbhLVCuf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 21:50:35 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:59704 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241956AbhLVCue (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Dec 2021 21:50:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V.O7sSH_1640141431;
Received: from 30.43.106.56(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.O7sSH_1640141431)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 10:50:32 +0800
Message-ID: <f79769ba-0e5b-708b-7e8d-15231a1646b9@linux.alibaba.com>
Date:   Wed, 22 Dec 2021 10:50:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH rdma-next 07/11] RDMA/erdma: Add verbs implementation
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-8-chengyou@linux.alibaba.com> <YcHXWCJyhIYldpfr@unreal>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YcHXWCJyhIYldpfr@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/21/21 9:32 PM, Leon Romanovsky wrote:
> On Tue, Dec 21, 2021 at 10:48:54AM +0800, Cheng Xu wrote:
>> The RDMA verbs implementation of erdma is divided into three files:
>> erdma_qp.c, erdma_cq.c, and erdma_verbs.c. Internal used functions and
>> datapath functions of QP/CQ are put in erdma_qp.c and erdma_cq.c, the reset
>> is in erdma_verbs.c.
>>
>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>> ---
>>   drivers/infiniband/hw/erdma/erdma_cq.c    |  201 +++
>>   drivers/infiniband/hw/erdma/erdma_qp.c    |  624 +++++++++
>>   drivers/infiniband/hw/erdma/erdma_verbs.c | 1477 +++++++++++++++++++++
>>   3 files changed, 2302 insertions(+)
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_cq.c
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_qp.c
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.c
> 
> 
> Please no inline functions in .c files and no void casting for the
> return values of functions.

Will fix it.

> <...>
> 
>> diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
>> new file mode 100644
>> index 000000000000..8c02215cee04
>> --- /dev/null
>> +++ b/drivers/infiniband/hw/erdma/erdma_qp.c
>> @@ -0,0 +1,624 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Authors: Cheng Xu <chengyou@linux.alibaba.com>
>> + *          Kai Shen <kaishen@linux.alibaba.com>
>> + * Copyright (c) 2020-2021, Alibaba Group.
>> + *
>> + * Authors: Bernard Metzler <bmt@zurich.ibm.com>
>> + *          Fredy Neeser <nfd@zurich.ibm.com>
>> + * Copyright (c) 2008-2016, IBM Corporation
> 
> What does it mean?
> 
> Thanks

As mentioned in patch 08, parts of our code come from siw with some
modification. In "erdma_qp.c" and "erdma_verbs.c", the code related with
CM module is also developed based on siw, mainly including qp state
machine implementation. So we keep original authors and copyright
information in the files.

Thanks,
Cheng Xu
