Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB5D1FD3B8
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 19:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFQRt7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 13:49:59 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:16402 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQRt6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 13:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592416198; x=1623952198;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=j4nk5OciIL+cVgI3AHdUjfJsbXg5KBUkq96NqMmSZV0=;
  b=PDvFiWRL2101RqJsI8s94fuc8U1ZwbtMoq7Rch6wK95OmRoaDwBWgl5Y
   1zdMn6BgjCJEdhD7ENGvMYifR9xdDLX+vxZHGQzSjOJ3vQqDyUlExjBaR
   z00QMMdEq09tzUYqJdfoadHMfqoWp/21ldr0SgO/Y/gq0JbNIGBx+VYky
   M=;
IronPort-SDR: mWMrtAu2zhTGdGDFToCQGEn9bE1586Dc5xQDjX9bU2I77NLnZVYjE+tiE6e/L+2TSSgIiri6d3
 rEa1iG+6UsDQ==
X-IronPort-AV: E=Sophos;i="5.73,523,1583193600"; 
   d="scan'208";a="36868527"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 17 Jun 2020 17:49:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (Postfix) with ESMTPS id 58684A2793;
        Wed, 17 Jun 2020 17:49:55 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 17 Jun 2020 17:49:54 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.90) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 17 Jun 2020 17:49:49 +0000
Subject: Re: [PATCH for-next] RDMA/efa: Move provider specific attributes to
 ucontext allocation response
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
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <ff3413c8-ca1e-e864-aba5-fa6abe491a8d@amazon.com>
Date:   Wed, 17 Jun 2020 20:49:43 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200617153638.GH6578@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13P01UWA001.ant.amazon.com (10.43.160.213) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 17/06/2020 18:36, Jason Gunthorpe wrote:
> On Tue, Jun 16, 2020 at 08:44:37PM +0300, Gal Pressman wrote:
>> On 16/06/2020 12:38, Leon Romanovsky wrote:
>>> On Tue, Jun 16, 2020 at 11:53:11AM +0300, Gal Pressman wrote:
>>>> On 16/06/2020 9:30, Leon Romanovsky wrote:
>>>>> On Mon, Jun 15, 2020 at 10:59:20AM +0300, Gal Pressman wrote:
>>>>>> Provider specific attributes which are necessary for the userspace
>>>>>> functionality should be part of the alloc ucontext response, not query
>>>>>> device. This way a userspace provider could work without issuing a query
>>>>>> device verb call. However, the fields will remain in the query device
>>>>>> ABI in order to maintain backwards compatibility.
>>>>>
>>>>> I don't really understand why "should be ..."? Device properties exposed
>>>>> here are per-device and will be equal to all ucontexts, so instead of
>>>>> doing one very fast system call, you are "punishing" every ucontext
>>>>> call.
>>>>
>>>> I talked about it with Jason in the past, the query device verb is intended to
>>>> follow the IBA verb, alloc ucontext should return driver specific data that's
>>>> required to operate the user space provider.
>>>> A query device call should not be mandatory to load the provider.
>>>
>>> Why? query_device is declared as mandatory verb for any provider, so
>>> anyway all in-the-tree RDMA drivers will have such verb.
>>
>> I don't think the concern here is if the verb exists or not, my understanding is
>> that query device should be used for IBA query device attributes, not other
>> provider specific stuff.
>> Jason, want to chime in with your thoughts?
> 
> query_device should be used to implement the ibverb query_device and
> query_device_ex
> 
> It should only return rdma-core defined common stuff because that is
> what that verb does - there is no reason to return driver specific
> things as there is nothing the driver can do with it.
> 
> The only exception might be some provider specific query_device dv
> that needs more information.
> 
> query_device should not be used as some two-part
> create_context. Information related only to create_context that is not
> already exposed to query_device should not be added to query_device
> only for create_context's use.
> 
> Similarly, information in query_device should not be duplicated into
> create_context just to save a system call.

That makes sense.
To clarify, the "duplicated" fields in this patch are moved to the ucontext
allocation, where they originally belong as all of them are necessary for the
provider's functionality.
Future fields such as these will only be added to alloc_ucontext, not both, so
there's no duplication.

Otherwise, future extensions will either have to be added to query_device, which
is the wrong place, just to be consistent with the existing code. Or we add them
to the ucontext response, where they belong, and end up with some hybrid
solution where different fields are gathered from different places (yuck :\).

We got it wrong the first place but it's a two way door, let's fix it.
