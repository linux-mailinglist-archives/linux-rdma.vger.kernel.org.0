Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E3747E083
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Dec 2021 09:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347242AbhLWIim (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Dec 2021 03:38:42 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:38100 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhLWIim (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Dec 2021 03:38:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V.WXU1D_1640248719;
Received: from 30.43.106.19(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.WXU1D_1640248719)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 16:38:40 +0800
Message-ID: <a002e8cb-88ed-2ecc-503c-f687dd882928@linux.alibaba.com>
Date:   Thu, 23 Dec 2021 16:38:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH rdma-next 07/11] RDMA/erdma: Add verbs implementation
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-8-chengyou@linux.alibaba.com> <YcHXWCJyhIYldpfr@unreal>
 <BYAPR15MB2631D125013B5C4E06C87167997C9@BYAPR15MB2631.namprd15.prod.outlook.com>
 <252268cf-55d6-35b1-3daf-20b231c2d8ee@linux.alibaba.com>
 <BYAPR15MB263117DA2E661F36741F35A2997D9@BYAPR15MB2631.namprd15.prod.outlook.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <BYAPR15MB263117DA2E661F36741F35A2997D9@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/22/21 8:46 PM, Bernard Metzler wrote:
>> -----Original Message-----
>> From: Cheng Xu <chengyou@linux.alibaba.com>
>> Sent: Wednesday, 22 December 2021 04:11
>> To: Bernard Metzler <BMT@zurich.ibm.com>; Leon Romanovsky
>> <leon@kernel.org>
>> Cc: jgg@ziepe.ca; dledford@redhat.com; linux-rdma@vger.kernel.org;
>> KaiShen@linux.alibaba.com; tonylu@linux.alibaba.com
>> Subject: [EXTERNAL] Re: [PATCH rdma-next 07/11] RDMA/erdma: Add verbs
>> implementation
>>
>>
>>
>> On 12/21/21 11:20 PM, Bernard Metzler wrote:
>>>> -----Original Message-----
>>>> From: Leon Romanovsky <leon@kernel.org>
>>>> Sent: Tuesday, 21 December 2021 14:32
>>>> To: Cheng Xu <chengyou@linux.alibaba.com>
>>>> Cc: jgg@ziepe.ca; dledford@redhat.com; linux-rdma@vger.kernel.org;
>>>> KaiShen@linux.alibaba.com; tonylu@linux.alibaba.com
>>>> Subject: [EXTERNAL] Re: [PATCH rdma-next 07/11] RDMA/erdma: Add verbs
>>>> implementation
>>>>
>>>> On Tue, Dec 21, 2021 at 10:48:54AM +0800, Cheng Xu wrote:
>>>>> The RDMA verbs implementation of erdma is divided into three files:
>>>>> erdma_qp.c, erdma_cq.c, and erdma_verbs.c. Internal used functions and
>>>>> datapath functions of QP/CQ are put in erdma_qp.c and erdma_cq.c, the
>>>> reset
>>>>> is in erdma_verbs.c.
>>>>>
>>>>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>>>>> ---
>>>>>    drivers/infiniband/hw/erdma/erdma_cq.c    |  201 +++
>>>>>    drivers/infiniband/hw/erdma/erdma_qp.c    |  624 +++++++++
>>>>>    drivers/infiniband/hw/erdma/erdma_verbs.c | 1477
>> +++++++++++++++++++++
>>>>>    3 files changed, 2302 insertions(+)
>>>>>    create mode 100644 drivers/infiniband/hw/erdma/erdma_cq.c
>>>>>    create mode 100644 drivers/infiniband/hw/erdma/erdma_qp.c
>>>>>    create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.c
>>>>
>>>>
>>>> Please no inline functions in .c files and no void casting for the
>>>> return values of functions.
>>>>
>>>> <...>
>>>>
>>>>> diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c
>>>> b/drivers/infiniband/hw/erdma/erdma_qp.c
>>>>> new file mode 100644
>>>>> index 000000000000..8c02215cee04
>>>>> --- /dev/null
>>>>> +++ b/drivers/infiniband/hw/erdma/erdma_qp.c
>>>>> @@ -0,0 +1,624 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * Authors: Cheng Xu <chengyou@linux.alibaba.com>
>>>>> + *          Kai Shen <kaishen@linux.alibaba.com>
>>>>> + * Copyright (c) 2020-2021, Alibaba Group.
>>>>> + *
>>>>> + * Authors: Bernard Metzler <bmt@zurich.ibm.com>
>>>>> + *          Fredy Neeser <nfd@zurich.ibm.com>
>>>>> + * Copyright (c) 2008-2016, IBM Corporation
>>>>
>>>> What does it mean?
>>>>
>>>
>>> Significant parts of the driver have been taken from siw it seems.
>>> Probably really from an old version of it.
>>> In that case I would have recommended to take the upstream siw
>>> code, which has been cleaned from those issues we now see again
>>> (including debugfs code, extern definitions, inline in .c code,
>>> casting issues, etc etc.). Why starting in 2020 with
>>> code from 2016, if better code is available?
>>>
>>> Bernard.
>>
>> First of all, thank you for developing siw, Bernard and Fredy, so we
>> can build our erdma based on your work.
> 
> You are welcome.
> You probably got the code from https://github.com/zrlio/softiwarp
> where I stopped pushing updates 4 years ago. By then, I started working
> on making it acceptable for upstream. As said, I highly recommend taking
> it from there, since the community already invested time and effort to
> make the code better, and finally acceptable. If you do so, please also
> update the copyright notice.

Thank you, and I will follow your recommendation.

> Fredy isn't part of it since almost 10 years, and is not reachable
> via the email provided. And, by 2016, his contributions were limited to
> the siw_cm.c code only.
> 
> 
> 
>> At the beginning, we started developing erdma driver in kernel
>> 4.9/4.19/5.10, and didn't know the upstream siw version since it is in
> 
> 
> siw is in the Linux kernel since v5.3
> 

Yes, I got it wrong.

Thanks,
Cheng Xu

>> the newer kernel version. As a result, we develop erdma based on the
>> older version.
>> Thank you for your recommendation. We will check the differences and
>> take the upstream siw code if needed.
>>
>> Thanks,
>> Cheng Xu
