Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B734945DF
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 03:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358203AbiATCvn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 21:51:43 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:55502 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230154AbiATCvm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jan 2022 21:51:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V2JWtUV_1642647099;
Received: from 30.43.105.54(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V2JWtUV_1642647099)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 20 Jan 2022 10:51:40 +0800
Message-ID: <1e4ed24b-45cd-8800-cd91-eaeb264c21a6@linux.alibaba.com>
Date:   Thu, 20 Jan 2022 10:51:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH rdma-next v2 09/11] RDMA/erdma: Add the erdma module
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <BYAPR15MB263126902D1FC48911A42BD999599@BYAPR15MB2631.namprd15.prod.outlook.com>
 <Yef2daIDIf9R3IYP@unreal>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <Yef2daIDIf9R3IYP@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/19/22 7:31 PM, Leon Romanovsky wrote:
> On Wed, Jan 19, 2022 at 10:15:43AM +0000, Bernard Metzler wrote:
>>
>>
>>> -----Original Message-----
>>> From: Cheng Xu <chengyou@linux.alibaba.com>
>>> Sent: Wednesday, 19 January 2022 05:19
>>> To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca;
>>> dledford@redhat.com
>>> Cc: leon@kernel.org; linux-rdma@vger.kernel.org;
>>> KaiShen@linux.alibaba.com; tonylu@linux.alibaba.com
>>> Subject: [EXTERNAL] Re: [PATCH rdma-next v2 09/11] RDMA/erdma: Add the
>>> erdma module
>>>
>>>
>>>
>>> On 1/18/22 8:53 PM, Bernard Metzler wrote:
>>>
>>> <...>
>>>
>>>>> +static int erdma_res_cb_init(struct erdma_dev *dev)
>>>>> +{
>>>>> +	int i;
>>>>> +
>>>>> +	for (i = 0; i < ERDMA_RES_CNT; i++) {
>>>>> +		dev->res_cb[i].next_alloc_idx = 1;
>>>>> +		spin_lock_init(&dev->res_cb[i].lock);
>>>>> +		dev->res_cb[i].bitmap = kcalloc(BITS_TO_LONGS(dev-
>>>>>> res_cb[i].max_cap),
>>>>> +						sizeof(unsigned long), GFP_KERNEL);
>>>>
>>>> better stay with less than 80 chars per line
>>>> throughout the patch series (I count currently 287 line wraps).
>>>>
>>>
>>> The kernel now allows 100 chars per line, and the checkpath.pl also
>>> checks using the new rule now. I will try to change this to 80 chars,
>>> but it actually makes some code not friendly for reading due to
>>> indent.
>>>
>>
>> Do we have a recommendation/agreement to stay with 80 chars per line
>> for the RDMA subsystem? I'd like it, but I am not sure.
> 
> Yes, we continue to use old 80 chars limit.
> 
> Thanks
> 

OK, I will follow this rule.

Thanks,
Cheng Xu

>>
>>> <...>
>>>
>>
>> Thanks,
>> Bernard.
>>
