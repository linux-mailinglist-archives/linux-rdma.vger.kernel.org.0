Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE2E2A4A40
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 16:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgKCPpy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 10:45:54 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:51683 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgKCPpy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Nov 2020 10:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1604418354; x=1635954354;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vFKnNT3f8dMTj7GsbHkbFMerGIK813n8dFlvilvsMu0=;
  b=tH06A1/QI5sCdTTudJmkZ5+W75OxsIZJdkWKTOiD2FV0jovaAWD8sDD5
   Ng/z+o91gspUOR0ReXyPT2Yqg5S1coN2/WCVgyAub/hj+cwJ2qRzKnvKl
   p4pEBce/Oj300fxsnHAXZRngwSir8N294OyHgFtyguevccbwiakrYx/xk
   0=;
X-IronPort-AV: E=Sophos;i="5.77,448,1596499200"; 
   d="scan'208";a="90183502"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 03 Nov 2020 15:45:37 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id 58CA6A06B7;
        Tue,  3 Nov 2020 15:45:36 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.241) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Nov 2020 15:45:32 +0000
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
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <5e2208ab-9e87-56ae-bc38-5827637eb5be@amazon.com>
Date:   Tue, 3 Nov 2020 17:45:26 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103142243.GM36674@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.241]
X-ClientProxiedBy: EX13D19UWC002.ant.amazon.com (10.43.162.179) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03/11/2020 16:22, Jason Gunthorpe wrote:
> On Tue, Nov 03, 2020 at 04:11:19PM +0200, Gal Pressman wrote:
>> On 03/11/2020 15:57, Leon Romanovsky wrote:
>>> On Tue, Nov 03, 2020 at 09:45:22AM -0400, Jason Gunthorpe wrote:
>>>> On Tue, Nov 03, 2020 at 03:26:27PM +0200, Gal Pressman wrote:
>>>>> Add the ability to query the device's bdf through rdma tool netlink
>>>>> command (in addition to the sysfs infra).
>>>>>
>>>>> In case of virtual devices (rxe/siw), the netdev bdf will be shown.
>>>>
>>>> Why? What is the use case?
>>>
>>> Right, and why isn't netdev (RDMA_NLDEV_ATTR_NDEV_NAME) enough?
>>
>> When taking system topology into consideration you need some way to pair the
>> ibdev and bdf, especially when working with multiple devices.
>> The netdev name doesn't exist on devices with no netdevs (IB, EFA).
> 
> You are supposed to use sysfs
> 
> /sys/class/infiniband/ibp0s9/device
> 
> Should always be the physical device
> 
>> Why rdma tool? Because it's more intuitive than sysfs.
> 
> But we generally don't put this information into netlink BDF is just
> the start, you need all the other topology information to make sense
> of it, and all that is in sysfs only already

As the commit message says, it's in addition to the device sysfs.

Many (if not most) of the existing rdma netlink commands are duplicates of some
sysfs entries, but show it in a more "modern" way.
I'm not convinced that bdf should be treated differently.

Similarly to how you can see netdevs bdf through 'ethtool -i' in addition to
sysfs, I think it's useful.
