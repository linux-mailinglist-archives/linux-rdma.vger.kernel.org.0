Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D37F2AAB11
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Nov 2020 14:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgKHNIu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Nov 2020 08:08:50 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:5134 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgKHNIt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Nov 2020 08:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1604840928; x=1636376928;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YEbDrFEzfEshk+AU1KE5yPLF2KWuAt3thzLX0wHMfxA=;
  b=v4kj+fmVlbACIaffnc5LQtcYFp4pxqaoJEdaC8E15Js7ujHM2WMpDNv2
   5ztxbeMBTyBRBav06Zq8vn8Z6X9zBVAxtH2OoA5BO5DK/26OhnouO/u+c
   vdRRLyK990qLfpFYDAXEnqnT+g5+SKlVb8+cGJsVgSSIXZzwBB//gTJfa
   s=;
X-IronPort-AV: E=Sophos;i="5.77,461,1596499200"; 
   d="scan'208";a="92981248"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 08 Nov 2020 13:08:42 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 1F8D1A17B4;
        Sun,  8 Nov 2020 13:03:54 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.55) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 8 Nov 2020 13:03:50 +0000
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
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <cd3f2926-0491-8540-d6b1-534014190bae@amazon.com>
Date:   Sun, 8 Nov 2020 15:03:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105200005.GJ36674@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.55]
X-ClientProxiedBy: EX13D42UWA001.ant.amazon.com (10.43.160.153) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/11/2020 22:00, Jason Gunthorpe wrote:
> On Tue, Nov 03, 2020 at 05:45:26PM +0200, Gal Pressman wrote:
>> On 03/11/2020 16:22, Jason Gunthorpe wrote:
>>> On Tue, Nov 03, 2020 at 04:11:19PM +0200, Gal Pressman wrote:
>>>> On 03/11/2020 15:57, Leon Romanovsky wrote:
>>>>> On Tue, Nov 03, 2020 at 09:45:22AM -0400, Jason Gunthorpe wrote:
>>>>>> On Tue, Nov 03, 2020 at 03:26:27PM +0200, Gal Pressman wrote:
>>>>>>> Add the ability to query the device's bdf through rdma tool netlink
>>>>>>> command (in addition to the sysfs infra).
>>>>>>>
>>>>>>> In case of virtual devices (rxe/siw), the netdev bdf will be shown.
>>>>>>
>>>>>> Why? What is the use case?
>>>>>
>>>>> Right, and why isn't netdev (RDMA_NLDEV_ATTR_NDEV_NAME) enough?
>>>>
>>>> When taking system topology into consideration you need some way to pair the
>>>> ibdev and bdf, especially when working with multiple devices.
>>>> The netdev name doesn't exist on devices with no netdevs (IB, EFA).
>>>
>>> You are supposed to use sysfs
>>>
>>> /sys/class/infiniband/ibp0s9/device
>>>
>>> Should always be the physical device
>>>
>>>> Why rdma tool? Because it's more intuitive than sysfs.
>>>
>>> But we generally don't put this information into netlink BDF is just
>>> the start, you need all the other topology information to make sense
>>> of it, and all that is in sysfs only already
>>
>> As the commit message says, it's in addition to the device sysfs.
>>
>> Many (if not most) of the existing rdma netlink commands are duplicates of some
>> sysfs entries, but show it in a more "modern" way.
>> I'm not convinced that bdf should be treated differently.
> 
> Why did you call it BDF anyhow? it has nothing to do with PCI BDF
> other than it happens to be the PDF for PCI devices. Netdev called
> this bus_info

Are there non pci devices in the subsystem?
I can rename to a more fitting name, will change to bus_info unless someone has
a better idea.
