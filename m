Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C19532177
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 05:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiEXDJr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 May 2022 23:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiEXDJq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 May 2022 23:09:46 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2597A47A
        for <linux-rdma@vger.kernel.org>; Mon, 23 May 2022 20:09:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VEG2OW2_1653361780;
Received: from 30.43.105.181(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VEG2OW2_1653361780)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 May 2022 11:09:42 +0800
Message-ID: <f8d0f438-cffe-13a9-b192-b2f1a8511902@linux.alibaba.com>
Date:   Tue, 24 May 2022 11:09:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Content-Language: en-US
To:     Tom Talpey <tom@talpey.com>, Bernard Metzler <BMT@zurich.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <BYAPR15MB263173D47513D1B16E1B00C199D39@BYAPR15MB2631.namprd15.prod.outlook.com>
 <27ce4b52-89cf-26a0-9452-f77ae59d9e7b@linux.alibaba.com>
 <434eaddc-6419-bf89-9053-932906bce6e9@talpey.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <434eaddc-6419-bf89-9053-932906bce6e9@talpey.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/23/22 9:25 PM, Tom Talpey wrote:
> On 5/22/2022 9:39 PM, Cheng Xu wrote:
>>
>>
>> On 5/20/22 11:13 PM, Bernard Metzler wrote:
>>>
>>>> -----Original Message-----
>>>> From: Cheng Xu <chengyou@linux.alibaba.com>
>>>> Sent: Friday, 20 May 2022 09:04
>>>> To: Bernard Metzler <BMT@zurich.ibm.com>; Jason Gunthorpe
>>>> <jgg@nvidia.com>; Tom Talpey <tom@talpey.com>
>>>> Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org;
>>>> KaiShen@linux.alibaba.com; tonylu@linux.alibaba.com
>>>> Subject: [EXTERNAL] Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the
>>>> erdma module
>>>>
>>>>
>>>>
>>>> On 5/20/22 12:20 AM, Bernard Metzler wrote:
>>>>>
>>>>>
>>>>
>>>> <...>
>>>>
>>>>>>> As far as I know, iWarp device only has one GID entry which
>>>> generated
>>>>>>> from MAC address.
>>>>>>>
>>>>>>> For iWarp, The CM part in core code resolves address, finds
>>>>>>> route with the help of kernel's net subsystem, and then obtains the
>>>>>> correct
>>>>>>> ibdev by GID matching. The GID matching in iWarp is indeed MAC
>>>> address
>>>>>>> matching.
>>>>>>>
>>>>>>> In another words, for iWarp devices, the core code doesn't handle IP
>>>>>>> addressing related stuff directly, it is finished by calling net
>>>> APIs.
>>>>>>> The netdev set by ib_device_set_netdev does not used in iWarp's CM
>>>>>>> process.
>>>>>>>
>>>>>>> The binded netdev in iWarp devices, mainly have two purposes:
>>>>>>>     1). generated GID0, using the netdev's mac address.
>>>>>>>     2). get the port state and attributes.
>>>>>>>
>>>>>>> For 1), erdma device binded to net device also by mac address, which
>>>> can
>>>>>>> be obtained from our PCIe bar registers.
>>>>>>> For 2), erdma can also get the information, and may be more
>>>> accurately.
>>>>>>> For example, erdma can have different MTU with virtio-net in our
>>>> cloud.
>>>>>>>
>>>>>>> For RoCEv2, I know that it has many GIDs, some of them are generated
>>>>>>> from IP addresses, and handing IP addressing in core code.
>>>>>>
>>>>>> Bernard, Tom what do you think?
>>>>>>
>>>>>> Jason
>>>>>
>>>>> I think iWarp (and now RoCEv2 with its UDP dependency) drivers
>>>>> produce GIDs mostly to satisfy the current RDMA CM infrastructure,
>>>>> which depends on this type of unique identifier, inherited from IB.
>>>>> Imo, more natural would be to implement IP based RDMA protocols
>>>>> connection management by relying on IP addresses.
>>>>>
>>>>> Sorry for asking again - why erdma does not need to link with netdev?
>>>>> Can erdma exist without using a netdev?
>>>>
>>>> Actually erdma also need a net device binded to, and so does it.
>>>>
>>>> These days I’m trying to find out acceptable ways to get the reference
>>>> of the binded netdev, e,g, the 'struct net_device' pointer. Unlike 
>>>> other
>>>> RDMA drivers can get the reference of their binded netdevs' reference
>>>> easily (most RDMA devices are based on the extended aux devices), it is
>>>> a little more complex for erdma, because erdma and its binded net 
>>>> device
>>>> are two separated PCIe devices.
>>>>
>>>> Then I find that the netdev reference hold in ibdev is rarely used
>>>> in core code for iWarp deivces, GID0 is the key attribute (As you and
>>>> Tom mentioned, it appears with the historical need for compatibility,
>>>> but I think this is another story).
>>>>
>>>
>>> Yes, I think this is right.
>>>
>>> If you are saying you can go away with a NULL netdev at CM core, then
>>> I think that's fine?
>>> Of course the erdma driver must somehow keep track of the state of
>>> its associated network device - like catching up with link status -
>>> and must provide related information/events to the RDMA core.
>>>
>>
>> All right, and get it. I'd like to hold the binded netdev reference in
>> our probe routine, and send v9 patches.
> 
> Cheng Xu, by this do you mean you'll drop the reference after the probe?

No, we will keep the reference in the lifecycle of erdma, like what
other physical RNICs do.

> In addition to watching for link status changes, I'd expect you also
> will want to monitor ARP/ND changes, maybe even perform those in the
> netdev stack rather than your firmware.

Since we will keep the netdev's reference, we needn't do this. Anyway,
thank your suggestion very much.

> ... Does your adapter not also
> function as a normal NIC?

 From the OS view, erdma does not have NIC function itself. but indeed
our HW has, and it is performed in another PCI device, e,g, virtio-net
device in our cloud now. In other words, our NIC and RDMA devices are
separated PCIe devices in OS, but they are all emulated in the same
hardware.

More details, our scenario is cloud virtualization. We have a
hardware (called MOC, a chipset for cloud virtualization in Alibaba
Cloud, a kind of DPU/IPU), which provides IO acceleration. MOC emulates
kinds of IO devices (virtio-net, virio-blk, nvme and erdma) to provide
IO services to VMs or bare metals. In our cloud, each VM/bare metal has
a virtio-net device by nature to get the VPC network service. erdma aims
to provide RDMA service in the same VPC network. So, erdma need not have
the NIC function, and it is a redundant feature for erdma, which
is provided by virio-net already.

Thanks,
Cheng Xu

> Tom.
> 
>> Thanks your time for looking at this, Jason, Bernard and Tom.
>>
>> Cheng Xu
>>
>>
