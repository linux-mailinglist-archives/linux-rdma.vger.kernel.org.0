Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D232F2ABDE4
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Nov 2020 14:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgKINwr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Nov 2020 08:52:47 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:35592 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbgKINwr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Nov 2020 08:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1604929967; x=1636465967;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dF130qf7iTEZW+Un1qCpf8bzxvEwfIj3PRXuEExhO2s=;
  b=H3lU4g2lxPPC52lDEh/CZrqhCqk5Nw/0TpZvBpYjjlQU2M7vflHc6Ea3
   E8pRHJeQXmutnM53Y3JWJDmy29ck288TdJW9vNivQwRYzqtVuXdRRQWeD
   BtkvdZC4kUN/4K8cizpXnh8uKXzduMfYdudYYuoxALrU73aiIdekkFk9H
   U=;
X-IronPort-AV: E=Sophos;i="5.77,463,1596499200"; 
   d="scan'208";a="62983300"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 09 Nov 2020 13:52:39 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id A975CA1BA7;
        Mon,  9 Nov 2020 13:52:38 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.146) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 9 Nov 2020 13:52:34 +0000
Subject: Re: [PATCH for-next] RDMA/nldev: Add parent bdf to device information
 dump
To:     Leon Romanovsky <leonro@nvidia.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
References: <5e2208ab-9e87-56ae-bc38-5827637eb5be@amazon.com>
 <20201105200005.GJ36674@ziepe.ca>
 <cd3f2926-0491-8540-d6b1-534014190bae@amazon.com>
 <20201108234935.GC244516@ziepe.ca> <20201109050902.GA4527@unreal>
 <1a16f57c-cfad-c0fc-67f0-11156f9689ac@amazon.com>
 <20201109115526.GA209294@unreal>
 <07f6343c-ff35-fd08-eb82-91cb42b1bd0c@amazon.com>
 <20201109123213.GB209294@unreal>
 <813701a5-8983-dc9d-b215-8f09acf7f68d@amazon.com>
 <20201109130240.GC209294@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <78c7c263-7c3d-5ac2-5b0b-fde2890893b6@amazon.com>
Date:   Mon, 9 Nov 2020 15:52:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109130240.GC209294@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.146]
X-ClientProxiedBy: EX13D07UWA004.ant.amazon.com (10.43.160.32) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 09/11/2020 15:02, Leon Romanovsky wrote:
> On Mon, Nov 09, 2020 at 02:47:07PM +0200, Gal Pressman wrote:
>> On 09/11/2020 14:32, Leon Romanovsky wrote:
>>> On Mon, Nov 09, 2020 at 02:27:16PM +0200, Gal Pressman wrote:
>>>> On 09/11/2020 13:55, Leon Romanovsky wrote:
>>>>> On Mon, Nov 09, 2020 at 11:03:25AM +0200, Gal Pressman wrote:
>>>>>>
>>>>>> On 09/11/2020 7:09, Leon Romanovsky wrote:
>>>>>>> On Sun, Nov 08, 2020 at 07:49:35PM -0400, Jason Gunthorpe wrote:
>>>>>>>> On Sun, Nov 08, 2020 at 03:03:45PM +0200, Gal Pressman wrote:
>>>>>>>>> On 05/11/2020 22:00, Jason Gunthorpe wrote:
>>>>>>>>>> On Tue, Nov 03, 2020 at 05:45:26PM +0200, Gal Pressman wrote:
>>>>>>>>>>> On 03/11/2020 16:22, Jason Gunthorpe wrote:
>>>>>>>>>>>> On Tue, Nov 03, 2020 at 04:11:19PM +0200, Gal Pressman wrote:
>>>>>>>>>>>>> On 03/11/2020 15:57, Leon Romanovsky wrote:
>>>>>>>>>>>>>> On Tue, Nov 03, 2020 at 09:45:22AM -0400, Jason Gunthorpe wrote:
>>>>>>>>>>>>>>> On Tue, Nov 03, 2020 at 03:26:27PM +0200, Gal Pressman wrote:
>>>>>>>>>>>>>>>> Add the ability to query the device's bdf through rdma tool netlink
>>>>>>>>>>>>>>>> command (in addition to the sysfs infra).
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> In case of virtual devices (rxe/siw), the netdev bdf will be shown.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Why? What is the use case?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Right, and why isn't netdev (RDMA_NLDEV_ATTR_NDEV_NAME) enough?
>>>>>>>>>>>>>
>>>>>>>>>>>>> When taking system topology into consideration you need some way to pair the
>>>>>>>>>>>>> ibdev and bdf, especially when working with multiple devices.
>>>>>>>>>>>>> The netdev name doesn't exist on devices with no netdevs (IB, EFA).
>>>>>>>>>>>>
>>>>>>>>>>>> You are supposed to use sysfs
>>>>>>>>>>>>
>>>>>>>>>>>> /sys/class/infiniband/ibp0s9/device
>>>>>>>>>>>>
>>>>>>>>>>>> Should always be the physical device
>>>>>>>>>>>>
>>>>>>>>>>>>> Why rdma tool? Because it's more intuitive than sysfs.
>>>>>>>>>>>>
>>>>>>>>>>>> But we generally don't put this information into netlink BDF is just
>>>>>>>>>>>> the start, you need all the other topology information to make sense
>>>>>>>>>>>> of it, and all that is in sysfs only already
>>>>>>>>>>>
>>>>>>>>>>> As the commit message says, it's in addition to the device sysfs.
>>>>>>>>>>>
>>>>>>>>>>> Many (if not most) of the existing rdma netlink commands are duplicates of some
>>>>>>>>>>> sysfs entries, but show it in a more "modern" way.
>>>>>>>>>>> I'm not convinced that bdf should be treated differently.
>>>>>>>>>>
>>>>>>>>>> Why did you call it BDF anyhow? it has nothing to do with PCI BDF
>>>>>>>>>> other than it happens to be the PDF for PCI devices. Netdev called
>>>>>>>>>> this bus_info
>>>>>>>>>
>>>>>>>>> Are there non pci devices in the subsystem?
>>>>>>>>
>>>>>>>> Yes, HNS uses non-pci devices
>>>>>>>>
>>>>>>>>> I can rename to a more fitting name, will change to bus_info unless
>>>>>>>>> someone has a better idea.
>>>>>>>>
>>>>>>>> The thing is, is is still useless. You have to consult sysfs to
>>>>>>>> understand what bus it is scoped on to do anything further with
>>>>>>>> it. Can't just assume it is PCI.
>>>>>>>
>>>>>>> Can anyone please remind me why are we doing it?
>>>>>>> What problem do you solve here by adding new nldev attributes?
>>>>>>
>>>>>> https://lore.kernel.org/linux-rdma/0825e1bf-f913-d2c1-ad3f-35ba3d6b75ef@amazon.com/
>>>>>
>>>>> Thanks, but IMHO it doesn't answer on the question about the problem.
>>>>
>>>> For example, in an instance with multiple NICs and GPUs, it's common to examine
>>>> the devices topology and distances, device bdfs are needed for that.
>>>>
>>>> Also, when analyzing dmesg logs the prints contain the ibdev name, which is not
>>>> always enough when trying to debug the corresponding physical device.
>>>
>>> Gal,
>>>
>>> I'm asking which problem will solve new nldev and not why BDF is important. :)
>>
>> This patch follows the implementation of other fields in fill_dev_info() such as
>> port index, fw version, node guid, sys image guid, node type, dev protocol, etc,
>> which also exist in sysfs.
>>
>> You added most of these new nldevs not long ago, so I find your question a bit
>> confusing.. Can you please explain your concerns and why you think bdf is different?
> 
> Almost all fields that you mentioned were needed to implement rdma_rename
> utility that followed systemd internal implementation and/or were used in
> the rdma-core.
> 
> The FW version is clearly an exemption to the above.
> 
> So I'm trying to understand the rationale behind BDF and how it will
> work with different bus variants that we will have. Like Parav said,
> the IB is connected to auxiliary bus (no BDF) and will have parent
> with BDF too at the same time.

We can review the different cases and make sure it works as expected (and what's
expected), but let's first reach an agreement if I should continue with this
work or not.
