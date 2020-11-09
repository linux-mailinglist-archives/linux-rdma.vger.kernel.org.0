Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D0C2AB312
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Nov 2020 10:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgKIJEF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Nov 2020 04:04:05 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:62965 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgKIJEE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Nov 2020 04:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1604912644; x=1636448644;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4RaKMjEQfN6iL89TUsgv5tWxQ3+M3gE1ALKdUqxLvRk=;
  b=iPOW1ZOifYHAey+fxODJXK+TDmwNVzZBC51bN+uN9s1nHw8mJ8nR+WBP
   YFz2vN4UXDahMW2Wq/YoQZACKzMMWVZjDRRreJH9rIjbuBRPd9vShK7iv
   cxgid/NF7I0hAhBEQCNpqC39HR4j+WWNxupnf5UaeSizFMCy3KF7vyjYd
   g=;
X-IronPort-AV: E=Sophos;i="5.77,463,1596499200"; 
   d="scan'208";a="62920232"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 09 Nov 2020 09:03:58 +0000
Received: from EX13D19EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 42720A25FA;
        Mon,  9 Nov 2020 09:03:55 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.55) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 9 Nov 2020 09:03:52 +0000
Subject: Re: [PATCH for-next] RDMA/nldev: Add parent bdf to device information
 dump
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
References: <20201103132627.67642-1-galpress@amazon.com>
 <20201103134522.GL36674@ziepe.ca> <20201103135719.GK5429@unreal>
 <0825e1bf-f913-d2c1-ad3f-35ba3d6b75ef@amazon.com>
 <20201103142243.GM36674@ziepe.ca>
 <5e2208ab-9e87-56ae-bc38-5827637eb5be@amazon.com>
 <20201105200005.GJ36674@ziepe.ca>
 <cd3f2926-0491-8540-d6b1-534014190bae@amazon.com>
 <20201108234935.GC244516@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <7a9866b6-fa33-0b95-4bda-4c83112be369@amazon.com>
Date:   Mon, 9 Nov 2020 11:03:47 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201108234935.GC244516@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.55]
X-ClientProxiedBy: EX13D11UWB004.ant.amazon.com (10.43.161.90) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 09/11/2020 1:49, Jason Gunthorpe wrote:
> On Sun, Nov 08, 2020 at 03:03:45PM +0200, Gal Pressman wrote:
>> On 05/11/2020 22:00, Jason Gunthorpe wrote:
>>> On Tue, Nov 03, 2020 at 05:45:26PM +0200, Gal Pressman wrote:
>>>> On 03/11/2020 16:22, Jason Gunthorpe wrote:
>>>>> On Tue, Nov 03, 2020 at 04:11:19PM +0200, Gal Pressman wrote:
>>>>>> On 03/11/2020 15:57, Leon Romanovsky wrote:
>>>>>>> On Tue, Nov 03, 2020 at 09:45:22AM -0400, Jason Gunthorpe wrote:
>>>>>>>> On Tue, Nov 03, 2020 at 03:26:27PM +0200, Gal Pressman wrote:
>>>>>>>>> Add the ability to query the device's bdf through rdma tool netlink
>>>>>>>>> command (in addition to the sysfs infra).
>>>>>>>>>
>>>>>>>>> In case of virtual devices (rxe/siw), the netdev bdf will be shown.
>>>>>>>>
>>>>>>>> Why? What is the use case?
>>>>>>>
>>>>>>> Right, and why isn't netdev (RDMA_NLDEV_ATTR_NDEV_NAME) enough?
>>>>>>
>>>>>> When taking system topology into consideration you need some way to pair the
>>>>>> ibdev and bdf, especially when working with multiple devices.
>>>>>> The netdev name doesn't exist on devices with no netdevs (IB, EFA).
>>>>>
>>>>> You are supposed to use sysfs
>>>>>
>>>>> /sys/class/infiniband/ibp0s9/device
>>>>>
>>>>> Should always be the physical device
>>>>>
>>>>>> Why rdma tool? Because it's more intuitive than sysfs.
>>>>>
>>>>> But we generally don't put this information into netlink BDF is just
>>>>> the start, you need all the other topology information to make sense
>>>>> of it, and all that is in sysfs only already
>>>>
>>>> As the commit message says, it's in addition to the device sysfs.
>>>>
>>>> Many (if not most) of the existing rdma netlink commands are duplicates of some
>>>> sysfs entries, but show it in a more "modern" way.
>>>> I'm not convinced that bdf should be treated differently.
>>>
>>> Why did you call it BDF anyhow? it has nothing to do with PCI BDF
>>> other than it happens to be the PDF for PCI devices. Netdev called
>>> this bus_info
>>
>> Are there non pci devices in the subsystem?
> 
> Yes, HNS uses non-pci devices
> 
>> I can rename to a more fitting name, will change to bus_info unless
>> someone has a better idea.
> 
> The thing is, is is still useless. You have to consult sysfs to
> understand what bus it is scoped on to do anything further with
> it. Can't just assume it is PCI.

This can be solved with Parav's suggestion.
