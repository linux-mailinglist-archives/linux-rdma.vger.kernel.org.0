Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3DF4E3734
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Mar 2022 04:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiCVDHl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Mar 2022 23:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiCVDHl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Mar 2022 23:07:41 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483872C7
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 20:06:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7tvfaV_1647918370;
Received: from 30.43.105.158(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V7tvfaV_1647918370)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Mar 2022 11:06:11 +0800
Message-ID: <d9438853-40c2-a8c0-d94b-22789c12b850@linux.alibaba.com>
Date:   Tue, 22 Mar 2022 11:06:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
From:   Cheng Xu <chengyou@linux.alibaba.com>
Subject: Re: [PATCH for-next v4 06/12] RDMA/erdma: Add event queue
 implementation
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Wenpeng Liang <liangwenpeng@huawei.com>, dledford@redhat.com,
        leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-7-chengyou@linux.alibaba.com>
 <57cd0171-5964-228f-b004-06cec1e4daae@huawei.com>
 <20220318181850.GG64706@ziepe.ca>
 <95ff44f2-e442-4e99-990d-2ef2fc9c1178@linux.alibaba.com>
 <20220321222314.GH64706@ziepe.ca>
Content-Language: en-US
In-Reply-To: <20220321222314.GH64706@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/22/22 6:23 AM, Jason Gunthorpe wrote:
> On Sat, Mar 19, 2022 at 05:43:16PM +0800, Cheng Xu wrote:
>>
>>
>> On 3/19/22 2:18 AM, Jason Gunthorpe wrote:
>>> On Fri, Mar 18, 2022 at 07:43:21PM +0800, Wenpeng Liang wrote:
>>>
>>>>> +static int erdma_set_ceq_irq(struct erdma_dev *dev, u16 ceqn)
>>>>> +{
>>>>> +	struct erdma_eq_cb *eqc = &dev->ceqs[ceqn];
>>>>> +	cpumask_t affinity_hint_mask;
>>>>> +	u32 cpu;
>>>>> +	int err;
>>>>> +
>>>>> +	snprintf(eqc->irq_name, ERDMA_IRQNAME_SIZE, "erdma-ceq%u@pci:%s",
>>>>> +		ceqn, pci_name(dev->pdev));
>>>>
>>>> Parameters in parentheses are not vertically aligned, a space is missing before "ceqn".
>>>
>>> Generally I will recommend such a large amount of code be run through
>>> clang-format and the good things it changes be merged. Most of what it
>>> suggests is good kernel style
>>>
>>> Jason
>>
>> Thanks, Jason. We already use clang-format since you recommended it last
>> time.
>>
>> We review the changes made by clang-format case by case, and merge most
>> of the changes. With a few cases, we handle them manually.
>>
>> For this case, clang-format put the ceqn at the first line, making it too
>> long (80 chars), and then the two lines of snprintf look like not
>> balance. So, I put the ceqn to the second line and broke the alignment
>> by mistake.
> 
> That sounds strange, clang-format never makes lines too long unless
> strings are invovled...
> 

Maybe I didn't explain this clearly.

The clang-format's result is well and matches the rule, the result looks
like this:

line 1:	snprintf(..., ..., ..., ceqn,     // 80 chars
line 2:		 pci_name(dev->pdev));    // 39 chars

The line 1 (80 chars) looks much longer than line 2 (39 chars). So I
put the 'ceqn' at line 2, then the length of the two lines are more
close, and may looks better:

line 1:	snprintf(..., ..., ...,                // 74 chars
line 2:		 ceqn, pci_name(dev->pdev));   // 45 chars

Thanks,
Cheng Xu

> Jason
