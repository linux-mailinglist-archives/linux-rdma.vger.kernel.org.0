Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91033062BC
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 18:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbhA0Ry2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 12:54:28 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:22815 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344298AbhA0RyO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jan 2021 12:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611770054; x=1643306054;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jhznVHftUVNvuf744okezaoi0xj7I4lTuPrBPpXQ5Tk=;
  b=DlP12betbx69p89t28NFV6CXzCqips5kaYx3kzC6juNNyOETvIqD1e7l
   DM+6gb0O4TgMh7FdLWLNXcK8IrOSZlzrPOt11UjnKVsxTMa1KX3S+4UGs
   9X/ryVcPSgBc8KjHgPZP+79MVV+kGebl1U75qJjkNuB+DM9F0bdV6xCFy
   k=;
X-IronPort-AV: E=Sophos;i="5.79,380,1602547200"; 
   d="scan'208";a="77815204"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 27 Jan 2021 17:53:20 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 3337FA2369;
        Wed, 27 Jan 2021 17:53:18 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.67) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 27 Jan 2021 17:53:15 +0000
Subject: Re: [PATCH for-next 0/2] Host information userspace version
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>
References: <20210105104326.67895-1-galpress@amazon.com>
 <9286e969-09b8-a7d0-ca7e-50b8e3864a11@amazon.com>
 <20210121183512.GC4147@nvidia.com>
 <206d8797-0188-5949-aaaf-57a6901c48d9@amazon.com>
 <20210127165734.GQ4147@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <41cf157b-d36b-06a2-a204-090848e44175@amazon.com>
Date:   Wed, 27 Jan 2021 19:53:10 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127165734.GQ4147@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.67]
X-ClientProxiedBy: EX13d09UWA002.ant.amazon.com (10.43.160.186) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/01/2021 18:57, Jason Gunthorpe wrote:
> On Thu, Jan 21, 2021 at 09:40:49PM +0200, Gal Pressman wrote:
>> On 21/01/2021 20:35, Jason Gunthorpe wrote:
>>> On Tue, Jan 19, 2021 at 09:17:14AM +0200, Gal Pressman wrote:
>>>> On 05/01/2021 12:43, Gal Pressman wrote:
>>>>> The following two patches add the userspace version to the host
>>>>> information struct reported to the device, used for debugging and
>>>>> troubleshooting purposes.
>>>>>
>>>>> PR was sent:
>>>>> https://github.com/linux-rdma/rdma-core/pull/918
>>>>>
>>>>> Thanks,
>>>>> Gal
>>>>
>>>> Anything stopping this series from being merged?
>>>
>>> Honestly, I'm not very keen on this
>>>
>>> Why does this have to go through a kernel driver, can't you collect
>>> OS telemetry some other way?
>>
>> Hmm, it has to go through rdma-core somehow, what sort of component can
>> rdma-core interact with to pass such data? The only one I could think of is the
>> RDMA driver :).
>>
>> As I said, I get your concern, I was going on and off about this as well, but
>> the userspace version is a very useful piece of information in the context of a
>> kernel bypass device. It's just as important as the kernel version.
>> I agree that this is not the place to pass things like gcc version, but I don't
>> think that's the case here :).
> 
> Well, if we were to do this for mlx5 we'd want to pass UCX and maybe
> other stuff, it seems like it gets quickly out of hand.

Agree, that's why I think this should be limited to things in rdma-core's reach,
sounds like a reasonable limit to me.

> I think telemetry is better done as some telemetry subsystem, not
> integrated all over the place

Interesting, but that would still be all over the place as each package would
have to report its version to that telemetry driver.

And since this currently doesn't exist, should we stay without a solution?
Specifically talking about rdma-core version, do you think it could be merged?
