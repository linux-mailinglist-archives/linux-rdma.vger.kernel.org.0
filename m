Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11ADB2AB831
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Nov 2020 13:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgKIM1e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Nov 2020 07:27:34 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:29242 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgKIM1e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Nov 2020 07:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1604924853; x=1636460853;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=UHZP8g72qVYIdMZaE9EwYqHHlT5pQbyHAmVBSvLAMxM=;
  b=vOMyBkM1nvSUaR+9SXXZZsbyQktwW3a4UyPQyeEgaiz6m7oh7HmhDYAu
   NgQkqDIhREmkEoy6uvD+3EAMNSjrjQejVbZkghQZEF4BdHeVgE2SO9SHA
   him3rtiDhlElEPiVVmV+6mfTbq9u17ciD919G7ZZMaSR7G4Y6Q+b84qST
   s=;
X-IronPort-AV: E=Sophos;i="5.77,463,1596499200"; 
   d="scan'208";a="92071351"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 09 Nov 2020 12:27:26 +0000
Received: from EX13D19EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id DB216140005;
        Mon,  9 Nov 2020 12:27:24 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.102) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 9 Nov 2020 12:27:21 +0000
Subject: Re: [PATCH for-next] RDMA/nldev: Add parent bdf to device information
 dump
To:     Leon Romanovsky <leonro@nvidia.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
References: <20201103134522.GL36674@ziepe.ca> <20201103135719.GK5429@unreal>
 <0825e1bf-f913-d2c1-ad3f-35ba3d6b75ef@amazon.com>
 <20201103142243.GM36674@ziepe.ca>
 <5e2208ab-9e87-56ae-bc38-5827637eb5be@amazon.com>
 <20201105200005.GJ36674@ziepe.ca>
 <cd3f2926-0491-8540-d6b1-534014190bae@amazon.com>
 <20201108234935.GC244516@ziepe.ca> <20201109050902.GA4527@unreal>
 <1a16f57c-cfad-c0fc-67f0-11156f9689ac@amazon.com>
 <20201109115526.GA209294@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <07f6343c-ff35-fd08-eb82-91cb42b1bd0c@amazon.com>
Date:   Mon, 9 Nov 2020 14:27:16 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109115526.GA209294@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.102]
X-ClientProxiedBy: EX13D50UWA004.ant.amazon.com (10.43.163.5) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 09/11/2020 13:55, Leon Romanovsky wrote:
> On Mon, Nov 09, 2020 at 11:03:25AM +0200, Gal Pressman wrote:
>>
>> On 09/11/2020 7:09, Leon Romanovsky wrote:
>>> On Sun, Nov 08, 2020 at 07:49:35PM -0400, Jason Gunthorpe wrote:
>>>> On Sun, Nov 08, 2020 at 03:03:45PM +0200, Gal Pressman wrote:
>>>>> On 05/11/2020 22:00, Jason Gunthorpe wrote:
>>>>>> On Tue, Nov 03, 2020 at 05:45:26PM +0200, Gal Pressman wrote:
>>>>>>> On 03/11/2020 16:22, Jason Gunthorpe wrote:
>>>>>>>> On Tue, Nov 03, 2020 at 04:11:19PM +0200, Gal Pressman wrote:
>>>>>>>>> On 03/11/2020 15:57, Leon Romanovsky wrote:
>>>>>>>>>> On Tue, Nov 03, 2020 at 09:45:22AM -0400, Jason Gunthorpe wrote:
>>>>>>>>>>> On Tue, Nov 03, 2020 at 03:26:27PM +0200, Gal Pressman wrote:
>>>>>>>>>>>> Add the ability to query the device's bdf through rdma tool netlink
>>>>>>>>>>>> command (in addition to the sysfs infra).
>>>>>>>>>>>>
>>>>>>>>>>>> In case of virtual devices (rxe/siw), the netdev bdf will be shown.
>>>>>>>>>>>
>>>>>>>>>>> Why? What is the use case?
>>>>>>>>>>
>>>>>>>>>> Right, and why isn't netdev (RDMA_NLDEV_ATTR_NDEV_NAME) enough?
>>>>>>>>>
>>>>>>>>> When taking system topology into consideration you need some way to pair the
>>>>>>>>> ibdev and bdf, especially when working with multiple devices.
>>>>>>>>> The netdev name doesn't exist on devices with no netdevs (IB, EFA).
>>>>>>>>
>>>>>>>> You are supposed to use sysfs
>>>>>>>>
>>>>>>>> /sys/class/infiniband/ibp0s9/device
>>>>>>>>
>>>>>>>> Should always be the physical device
>>>>>>>>
>>>>>>>>> Why rdma tool? Because it's more intuitive than sysfs.
>>>>>>>>
>>>>>>>> But we generally don't put this information into netlink BDF is just
>>>>>>>> the start, you need all the other topology information to make sense
>>>>>>>> of it, and all that is in sysfs only already
>>>>>>>
>>>>>>> As the commit message says, it's in addition to the device sysfs.
>>>>>>>
>>>>>>> Many (if not most) of the existing rdma netlink commands are duplicates of some
>>>>>>> sysfs entries, but show it in a more "modern" way.
>>>>>>> I'm not convinced that bdf should be treated differently.
>>>>>>
>>>>>> Why did you call it BDF anyhow? it has nothing to do with PCI BDF
>>>>>> other than it happens to be the PDF for PCI devices. Netdev called
>>>>>> this bus_info
>>>>>
>>>>> Are there non pci devices in the subsystem?
>>>>
>>>> Yes, HNS uses non-pci devices
>>>>
>>>>> I can rename to a more fitting name, will change to bus_info unless
>>>>> someone has a better idea.
>>>>
>>>> The thing is, is is still useless. You have to consult sysfs to
>>>> understand what bus it is scoped on to do anything further with
>>>> it. Can't just assume it is PCI.
>>>
>>> Can anyone please remind me why are we doing it?
>>> What problem do you solve here by adding new nldev attributes?
>>
>> https://lore.kernel.org/linux-rdma/0825e1bf-f913-d2c1-ad3f-35ba3d6b75ef@amazon.com/
> 
> Thanks, but IMHO it doesn't answer on the question about the problem.

For example, in an instance with multiple NICs and GPUs, it's common to examine
the devices topology and distances, device bdfs are needed for that.

Also, when analyzing dmesg logs the prints contain the ibdev name, which is not
always enough when trying to debug the corresponding physical device.
