Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 894C1164300
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 12:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBSLH7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 06:07:59 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:33629 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgBSLH7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 06:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582110478; x=1613646478;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=i8udMc4Xqioawd9HapBC1RdZqmAfrSfrpcb/898M04M=;
  b=BgkJfyzlf8J8eXvc8q3Vyv16D/AmfGYFPdQ5NEeGydSwxhGMF4iI33xi
   8GRp2FLd1N2+AP56tBWNgr+XXF5YZ4qVfh5GynQJeVUmwCJi2kxMwnQ+a
   wuM8urOgTBsxUYy3SM5Kl1DV/jYR9uKh4LAVH8HHzg30jgRfK6iTsQyUm
   k=;
IronPort-SDR: iKxjKDKsqN5WyhmDZXh2tZHKUBDFkB/JED2qiLMPNPD57nzB0x3TaeUBJXHcuBe/cYOKn7R73p
 GHnTk9Tbzdkw==
X-IronPort-AV: E=Sophos;i="5.70,459,1574121600"; 
   d="scan'208";a="27434425"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 19 Feb 2020 11:07:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id C05C0C077D;
        Wed, 19 Feb 2020 11:07:53 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 19 Feb 2020 11:07:53 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.26) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 19 Feb 2020 11:07:49 +0000
Subject: Re: [PATCH for-next v2] RDMA/siw: Fix setting active_{speed, width}
 attributes
To:     Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
References: <20200218095911.26614-1-kamalheib1@gmail.com>
 <20200218165847.GA15239@unreal> <20200219084359.GA12296@kheib-workstation>
 <20200219093321.GI15239@unreal> <20200219102110.GA13582@kheib-workstation>
 <20200219105320.GJ15239@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <75244a03-6f55-e9b1-1d7a-f6d747ff1e40@amazon.com>
Date:   Wed, 19 Feb 2020 13:07:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219105320.GJ15239@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D35UWC002.ant.amazon.com (10.43.162.218) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 19/02/2020 12:53, Leon Romanovsky wrote:
> On Wed, Feb 19, 2020 at 12:21:10PM +0200, Kamal Heib wrote:
>> On Wed, Feb 19, 2020 at 11:33:21AM +0200, Leon Romanovsky wrote:
>>> On Wed, Feb 19, 2020 at 10:43:59AM +0200, Kamal Heib wrote:
>>>> On Tue, Feb 18, 2020 at 06:58:47PM +0200, Leon Romanovsky wrote:
>>>>> On Tue, Feb 18, 2020 at 11:59:11AM +0200, Kamal Heib wrote:
>>>>>> Make sure to set the active_{speed, width} attributes to avoid reporting
>>>>>> the same values regardless of the underlying device.
>>>>>>
>>>>>> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
>>>>>> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>>>>>> ---
>>>>>> V2: Change rc to rv.
>>>>>> ---
>>>>>>  drivers/infiniband/sw/siw/siw_verbs.c | 7 ++++---
>>>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
>>>>>> index 73485d0da907..d5390d498c61 100644
>>>>>> --- a/drivers/infiniband/sw/siw/siw_verbs.c
>>>>>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>>>>>> @@ -165,11 +165,12 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
>>>>>>  		   struct ib_port_attr *attr)
>>>>>>  {
>>>>>>  	struct siw_device *sdev = to_siw_dev(base_dev);
>>>>>> +	int rv;
>>>>>>
>>>>>>  	memset(attr, 0, sizeof(*attr));
>>>>>
>>>>> This line should go too. IB/core clears attr prior to call driver.
>>>>>
>>>>> Thanks
>>>>>
>>>>
>>>> This can be done in a separate patch as this patch fixes a specific issue.
>>>
>>> Whatever works for you, if you don't value your own time, go for it,
>>> do separate patch for every line you are changing. It just looks crazy
>>> to see changes like this:
>>>  * changed line
>>>  * line to be changed, but not changed
>>>  * another changed line
>>>
>>> Thanks
>>>
>>
>> Leon, With all my respect, This isn't your decision what I do and when.
> 
> Please carefully reread my answer, I didn't say what and when you should
> do, simply gave to you an explanation why request remove useless memeset
> makes sense in the context of proposed patch.

I tend to agree with Kamal..
If the patch contained the memset removal I would argue it should be dropped as
it has nothing to do with the purpose of this commit. Just adds noise to the review.
