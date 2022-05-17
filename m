Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5EA5296F3
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 03:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiEQBxk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 May 2022 21:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiEQBxj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 May 2022 21:53:39 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B013D4B4
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 18:53:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VDPKjTu_1652752413;
Received: from 30.43.105.205(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VDPKjTu_1652752413)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 May 2022 09:53:34 +0800
Message-ID: <0f7e9389-daf3-16ec-83e8-439361ee7d97@linux.alibaba.com>
Date:   Tue, 17 May 2022 09:53:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Content-Language: en-US
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
 <1b6dbe3a-8b15-3c56-5353-27525095962a@linux.alibaba.com>
 <20220516140721.GW1343366@nvidia.com>
 <eb2f87be-7d9a-72c9-645e-0d789b604c2e@linux.alibaba.com>
 <20220516173102.GF1343366@nvidia.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220516173102.GF1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/17/22 1:31 AM, Jason Gunthorpe wrote:
> On Mon, May 16, 2022 at 11:14:24PM +0800, Cheng Xu wrote:
>>>> I think this twice, use a net notifier of module can not solve this, due
>>>> to the leak of all ib devices information in erdma module.
>>>
>>> I don't understand what this means
>> At first I want to register a global net notifier in our module, and link
>> the ib device and net device if matches in the callback. But in the
>> callback, we can not get the ib devices registered by erdma, because our
>> driver module does not maintain the ib device list. This is not the
>> right way.
> 
> The core has the device list, if you need to search it then you need
> to add a new searching function
> 

I had a mistake, instead of what I said, erdma should search net devices
in a wq to find the matched net device. Not search ib devices in net
notifier callback.

I think is should be fine.

>>
>>>> The solution may be simple: register net notifier per device in probe,
>>>> and call ib_device_set_netdev if matches in the notifier callback.
>>>
>>> That sounds wrong
>>>
>>
>> OK. So using rdma link command to handle the link relationship manually
>> is still a better choice？
> 
> No
>   
>> Actually, erdma looks like a hardware implementation of siw/rxe (more
>> likes siw, because erdma uses iWarp, and have similar CM
>> implementation): the ethernet functionality is provided by existed net
>> device, no matter what kind of the net device (due to virtio-net is
>> de-facto in cloud virtualization, erdma is binded to virtio-net in
>> practice). Due to this similarity, siw/rxe use 'rdma link' to link the
>> ib device and net device (including create ib device), Does it sound
>> reasonable that erdma use it to link the net deivce?
> 
> It is not like siw because it cannot run on any netdevice, it can only
> run on the signle netdevice the HW is linked to in the background.
> 

Yeah, you are exactly right, I omitted this detail in the last
reply.

Thanks,
Cheng Xu

> Jason
