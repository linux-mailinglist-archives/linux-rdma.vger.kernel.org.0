Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34F552862E
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 15:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiEPN7h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 May 2022 09:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbiEPN7g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 May 2022 09:59:36 -0400
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2B5DF23
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 06:59:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VDN7JfA_1652709569;
Received: from 192.168.0.25(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VDN7JfA_1652709569)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 May 2022 21:59:30 +0800
Message-ID: <1b6dbe3a-8b15-3c56-5353-27525095962a@linux.alibaba.com>
Date:   Mon, 16 May 2022 21:59:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Content-Language: en-US
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-11-chengyou@linux.alibaba.com>
 <20220510131724.GA1093822@nvidia.com>
 <15a6e72f-2967-5c19-3742-d854409275ce@linux.alibaba.com>
 <20220516114940.GT1343366@nvidia.com>
 <3bf3f0f4-1592-2aa6-42c7-f1b4ff73fc6d@linux.alibaba.com>
In-Reply-To: <3bf3f0f4-1592-2aa6-42c7-f1b4ff73fc6d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/16/22 8:40 PM, Cheng Xu wrote:
> 
> 
> On 5/16/22 7:49 PM, Jason Gunthorpe wrote:
>> On Mon, May 16, 2022 at 11:15:32AM +0800, Cheng Xu wrote:
>>>
>>>
>>> On 5/10/22 9:17 PM, Jason Gunthorpe wrote:
>>>> On Thu, Apr 21, 2022 at 03:17:45PM +0800, Cheng Xu wrote:
>>>>
>>>>> +static struct rdma_link_ops erdma_link_ops = {
>>>>> +    .type = "erdma",
>>>>> +    .newlink = erdma_newlink,
>>>>> +};
>>>>
>>>> Why is there still a newlink?
>>>>
>>>> Jason
>>>
>>>
>>> Yeah, I remember your suggestion that the ibdev should keep the same
>>> lifecycle with its PCI device, and so does it now.
>>>
>>> The initialization flow for erdma now:
>>>       probe:
>>>         - Hardware specified initialization
>>>         - IB device initialization
>>>         - Calling ib_register_device with ibdev->netdev == NULL
>>>
>>> After probe, The ib device has been registered, but we left it in
>>> invalid state.
>>> To fully complete the initialization, we should set the ibdev->netdev.
>>>
>>> And the newlink command in erdma only do one thing now: set the
>>> ibdev->netdev if the rule matches, and it is uncorrelated with the
>>> ib device lifecycle.
>>
>> This is not what newlink is for, it can't be used like this
>>
>> Jason
> 
> 
> [A typo in previous reply, so I re-edit it]
> 
<...>
> Or, Is it ok that erdma registers a net notifier in our module to handle
> this?
> 

I think this twice, use a net notifier of module can not solve this, due
to the leak of all ib devices information in erdma module.

The solution may be simple: register net notifier per device in probe,
and call ib_device_set_netdev if matches in the notifier callback.

Should this be the right way?

Thanks,
Cheng Xu
