Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C963852E5CD
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244824AbiETHEi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 03:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346298AbiETHEb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 03:04:31 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12981154B30
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 00:03:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VDpalL8_1653030219;
Received: from 30.43.105.9(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VDpalL8_1653030219)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 May 2022 15:03:40 +0800
Message-ID: <6ed58a41-1b75-2dd6-fb3a-8da1dce1400e@linux.alibaba.com>
Date:   Fri, 20 May 2022 15:03:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Tom Talpey <tom@talpey.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-11-chengyou@linux.alibaba.com>
 <20220510131724.GA1093822@nvidia.com>
 <2a46d5b3-e905-4eb5-c775-c6fc227ad615@linux.alibaba.com>
 <20220518144621.GH1343366@nvidia.com>
 <83ed54cd-7893-ea26-6bf0-780e12ca2a3e@linux.alibaba.com>
 <20220518163142.GR1343366@nvidia.com>
 <BYAPR15MB2631B46350315B486CA9ED3599D09@BYAPR15MB2631.namprd15.prod.outlook.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <BYAPR15MB2631B46350315B486CA9ED3599D09@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/20/22 12:20 AM, Bernard Metzler wrote:
> 
> 

<...>

>>> As far as I know, iWarp device only has one GID entry which generated
>>> from MAC address.
>>>
>>> For iWarp, The CM part in core code resolves address, finds
>>> route with the help of kernel's net subsystem, and then obtains the
>> correct
>>> ibdev by GID matching. The GID matching in iWarp is indeed MAC address
>>> matching.
>>>
>>> In another words, for iWarp devices, the core code doesn't handle IP
>>> addressing related stuff directly, it is finished by calling net APIs.
>>> The netdev set by ib_device_set_netdev does not used in iWarp's CM
>>> process.
>>>
>>> The binded netdev in iWarp devices, mainly have two purposes:
>>>    1). generated GID0, using the netdev's mac address.
>>>    2). get the port state and attributes.
>>>
>>> For 1), erdma device binded to net device also by mac address, which can
>>> be obtained from our PCIe bar registers.
>>> For 2), erdma can also get the information, and may be more accurately.
>>> For example, erdma can have different MTU with virtio-net in our cloud.
>>>
>>> For RoCEv2, I know that it has many GIDs, some of them are generated
>>> from IP addresses, and handing IP addressing in core code.
>>
>> Bernard, Tom what do you think?
>>
>> Jason
> 
> I think iWarp (and now RoCEv2 with its UDP dependency) drivers
> produce GIDs mostly to satisfy the current RDMA CM infrastructure,
> which depends on this type of unique identifier, inherited from IB.
> Imo, more natural would be to implement IP based RDMA protocols
> connection management by relying on IP addresses.
> 
> Sorry for asking again - why erdma does not need to link with netdev?
> Can erdma exist without using a netdev?

Actually erdma also need a net device binded to, and so does it.

These days I’m trying to find out acceptable ways to get the reference
of the binded netdev, e,g, the 'struct net_device' pointer. Unlike other
RDMA drivers can get the reference of their binded netdevs' reference 
easily (most RDMA devices are based on the extended aux devices), it is
a little more complex for erdma, because erdma and its binded net device
are two separated PCIe devices.

Then I find that the netdev reference hold in ibdev is rarely used
in core code for iWarp deivces, GID0 is the key attribute (As you and 
Tom mentioned, it appears with the historical need for compatibility,
but I think this is another story).

So, there are two choices for erdma: enum net devices and find the
matched one, or never calling ib_device_set_netdev. The second one has 
less code.

The second way can't work in ROCE. But it works for iWarp (I've tested),
since the netdev reference is rarely used for iWarp in core code, as I
said in last reply.

In short, the question discussed here is that: is it acceptable that
doesn't hold the netdev reference in core code for a iWarp driver
(indeed it has a netdev binded to) ? Or is it necessary that calling
ib_device_set_netdev to set the binded netdev for iWarp driver?

You and Tom both are specialists in iWarp, your opinions are important.

Thanks very much
Cheng Xu


> 
> Thanks,
> Bernard.
