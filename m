Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB831FF07E
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFRLah (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 07:30:37 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:6828 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgFRLae (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Jun 2020 07:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592479834; x=1624015834;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xU6RxusWjCtJ5Tvgka/7M0S0XHQ0/7WlIk2DoPFba6k=;
  b=MVtDJMqoNmFk6xpibkchiiABTT8tBKajygltdrYfG8kRBasQdFJqcSVI
   9VSREOnywwGPM3e7blHtik4f9hb1zD/MJ27Sy0cjVUkUMrXqgTwCiRa4j
   9wAFgFcvVxlHIZt3DkY5I51XEyqnpcuJt2uestggN9bncvtUdyBDUCkDa
   A=;
IronPort-SDR: m6ltjXFaX2YXvyHe/SUpFbeDgaaIyAK+YaT9iJe+g1hzt5JPtBszswiadfFzOEStscgQ/66eSk
 dHRhKe5qodLw==
X-IronPort-AV: E=Sophos;i="5.73,526,1583193600"; 
   d="scan'208";a="44981843"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 18 Jun 2020 11:30:32 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 9752CC06EE;
        Thu, 18 Jun 2020 11:30:31 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 18 Jun 2020 11:30:30 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.34) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 18 Jun 2020 11:30:26 +0000
Subject: Re: [PATCH for-next] RDMA/efa: Move provider specific attributes to
 ucontext allocation response
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20200615075920.58936-1-galpress@amazon.com>
 <20200616063045.GC2141420@unreal>
 <cba7128b-c427-bc26-5f43-69a22463debc@amazon.com>
 <20200616093835.GB2383158@unreal>
 <f6773480-5954-b58b-21f0-f5ee4ec7238b@amazon.com>
 <20200617153638.GH6578@ziepe.ca>
 <ff3413c8-ca1e-e864-aba5-fa6abe491a8d@amazon.com>
Message-ID: <626dd909-a766-9973-7a44-f174176641ea@amazon.com>
Date:   Thu, 18 Jun 2020 14:30:20 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ff3413c8-ca1e-e864-aba5-fa6abe491a8d@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D27UWB003.ant.amazon.com (10.43.161.195) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 17/06/2020 20:49, Gal Pressman wrote:
> On 17/06/2020 18:36, Jason Gunthorpe wrote:
>> On Tue, Jun 16, 2020 at 08:44:37PM +0300, Gal Pressman wrote:
>>> On 16/06/2020 12:38, Leon Romanovsky wrote:
>>>> On Tue, Jun 16, 2020 at 11:53:11AM +0300, Gal Pressman wrote:
>>>>> On 16/06/2020 9:30, Leon Romanovsky wrote:
>>>>>> On Mon, Jun 15, 2020 at 10:59:20AM +0300, Gal Pressman wrote:
>>>>>>> Provider specific attributes which are necessary for the userspace
>>>>>>> functionality should be part of the alloc ucontext response, not query
>>>>>>> device. This way a userspace provider could work without issuing a query
>>>>>>> device verb call. However, the fields will remain in the query device
>>>>>>> ABI in order to maintain backwards compatibility.
>>>>>>
>>>>>> I don't really understand why "should be ..."? Device properties exposed
>>>>>> here are per-device and will be equal to all ucontexts, so instead of
>>>>>> doing one very fast system call, you are "punishing" every ucontext
>>>>>> call.
>>>>>
>>>>> I talked about it with Jason in the past, the query device verb is intended to
>>>>> follow the IBA verb, alloc ucontext should return driver specific data that's
>>>>> required to operate the user space provider.
>>>>> A query device call should not be mandatory to load the provider.
>>>>
>>>> Why? query_device is declared as mandatory verb for any provider, so
>>>> anyway all in-the-tree RDMA drivers will have such verb.
>>>
>>> I don't think the concern here is if the verb exists or not, my understanding is
>>> that query device should be used for IBA query device attributes, not other
>>> provider specific stuff.
>>> Jason, want to chime in with your thoughts?
>>
>> query_device should be used to implement the ibverb query_device and
>> query_device_ex
>>
>> It should only return rdma-core defined common stuff because that is
>> what that verb does - there is no reason to return driver specific
>> things as there is nothing the driver can do with it.
>>
>> The only exception might be some provider specific query_device dv
>> that needs more information.
>>
>> query_device should not be used as some two-part
>> create_context. Information related only to create_context that is not
>> already exposed to query_device should not be added to query_device
>> only for create_context's use.
>>
>> Similarly, information in query_device should not be duplicated into
>> create_context just to save a system call.
> 
> That makes sense.
> To clarify, the "duplicated" fields in this patch are moved to the ucontext
> allocation, where they originally belong as all of them are necessary for the
> provider's functionality.
> Future fields such as these will only be added to alloc_ucontext, not both, so
> there's no duplication.
> 
> Otherwise, future extensions will either have to be added to query_device, which
> is the wrong place, just to be consistent with the existing code. Or we add them
> to the ucontext response, where they belong, and end up with some hybrid
> solution where different fields are gathered from different places (yuck :\).
> 
> We got it wrong the first place but it's a two way door, let's fix it.

Uhh.. We can't really get rid of the query device call as the provider needs the
max_qp attribute in order to allocate the QP table properly.

I still think we should move the fields to keep things clean, but I can drop
this change if you prefer to avoid the churn. The provider will always call
query device on context initialization and gather different fields from
different system calls.

Thoughts?
