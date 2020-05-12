Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022B61CF391
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 13:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgELLpV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 07:45:21 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:61271 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgELLpU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 07:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589283919; x=1620819919;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KDyx1xLudqxMG1W0FxKLKkPEcah5UtfOvqzYcyXGp6U=;
  b=UT+6dDZBliQtwfckaJgQtLCJJP9P2DRqwlO97rjIszFXv7il8cwWiRjz
   76Ni4aSgWgvsJ38kHaNawwG2SYGlf3cUhfUrIGqHRSJO4xdTRYG3NRAqG
   p5lmjN9o1RE1Bhj6r/XC9Vhmr9UQ18aYN4wCTfY3NlxvypkBGKKQZ+iK6
   I=;
IronPort-SDR: O7e1tDbzQ4+O0dXrXKh2B9qKNZW5NgW+S+k4rqiSl45B6QvQHfXlorh/Y6QdFJ00ITenJDtp35
 yDVHNU4+2F1g==
X-IronPort-AV: E=Sophos;i="5.73,383,1583193600"; 
   d="scan'208";a="29887806"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 12 May 2020 11:45:06 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id B7FF9A304A;
        Tue, 12 May 2020 11:45:04 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 11:45:04 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.193) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 11:44:59 +0000
Subject: Re: [PATCH RFC rdma-core] Verbs: Introduce import verbs for device,
 PD, MR
To:     Alex Rosenbaum <rosenbaumalex@gmail.com>
CC:     Yishai Hadas <yishaih@dev.mellanox.co.il>,
        Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        <jgg@mellanox.com>, Maor Gottlieb <maorg@mellanox.com>,
        "Alex @ Mellanox" <Alexr@mellanox.com>
References: <1589202728-12365-1-git-send-email-yishaih@mellanox.com>
 <a46dc0e5-7261-0bf1-9dff-1c62644c3c73@amazon.com>
 <ac69f0fa-e177-62c9-6fe8-5b0700d97712@dev.mellanox.co.il>
 <1ada043f-b9c7-b961-d35b-9461f78ca9d2@amazon.com>
 <CAFgAxU9Q79Xh_C_-ROXOJiGf_NAMqb0Hc0L4qay_hWB_7qcfNA@mail.gmail.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <3f81f2a9-ba33-618a-2f08-fa4c164158e6@amazon.com>
Date:   Tue, 12 May 2020 14:44:54 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFgAxU9Q79Xh_C_-ROXOJiGf_NAMqb0Hc0L4qay_hWB_7qcfNA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.193]
X-ClientProxiedBy: EX13D29UWC004.ant.amazon.com (10.43.162.25) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/05/2020 13:51, Alex Rosenbaum wrote:
> On Tue, May 12, 2020 at 11:24 AM Gal Pressman <galpress@amazon.com> wrote:
>>
>> On 11/05/2020 18:35, Yishai Hadas wrote:
>>> On 5/11/2020 5:31 PM, Gal Pressman wrote:
>>>> On 11/05/2020 16:12, Yishai Hadas wrote:
>>>>> Introduce import verbs for device, PD, MR, it enables processes to share
>>>>> their ibv_contxet and then share PD and MR that is associated with.
>>>>>
>>>>> A process is creating a device and then uses some of the Linux systems
>>>>> calls to dup its 'cmd_fd' member which lets other process to obtain
>>>>> owning on.
>>>>>
>>>>> Once other process obtains the 'cmd_fd' it can call ibv_import_device()
>>>>> which returns an ibv_contxet on the original RDMA device.
>>>>>
>>>>> On the imported device there is an option to import PD(s) and MR(s) to
>>>>> achieve a sharing on those objects.
>>>>>
>>>>> This is the responsibility of the application to coordinate between all
>>>>> ibv_context(s) that use the imported objects, such that once destroy is
>>>>> done no other process can touch the object except for unimport. All
>>>>> users of the context must collaborate to ensure this.
>>>>>
>>>>> A matching unimport verbs where introduced for PD and MR, for the device
>>>>> the ibv_close_device() API should be used.
>>>>>
>>>>> Detailed man pages are introduced as part of this RFC patch to clarify
>>>>> the expected usage and notes.
>>>>>
>>>>> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
>>>>
>>>> Hi Yishai,
>>>>
>>>> A few questions:
>>>> Can you please explain the use case? I remember there was a discussion on the
>>>> previous shared PD kernel submission (by Yuval and Shamir) but I'm not sure if
>>>> there was a conclusion.
>>>>
>>>
>>> The expected flow and use case are as follows.
>>>
>>> One process creates an ibv_context by calling ibv_open_device() and then enables
>>> owning of its 'cmd_fd' with other processes by some Linux system call, (see man
>>> page as part of this RFC for some alternatives). Then other process that owns
>>> this 'cmd_fd' will be able to have its own ibv_context for the same RDMA device
>>> by calling ibv_import_device().
>>>
>>> At that point those processes really work on same kernel context and PD(s),
>>> MR(s) and potentially other objects in the future can be shared by calling
>>> ibv_import_pd()/mr() assuming that the initiator process let's the other ones
>>> know the kernel handle value.
>>>
>>> Once a PD and MR which points to this PD were shared it enables a memory that
>>> was registered by one process to be used by others with the matching lkey/rkey
>>> for RDMA operations.
>>
>> Thanks Yishai.
>> Which type of applications need this kind of functionality?
> 
> Any solution which is a single business logic based on multi-process
> design needs this.
> Example include NGINX, with TCP load balancing, sharing the RSS
> indirection table with RQ per process.
> HPC frameworks with multi-rank(process) solution on single hosts. UCX
> can share IB resources using the shared PD and can help dispatch data
> to multiple processes/MR's in single RDMA operation.
> Also, we have solutions in which the primary processes registered a
> large shared memory range, and each worker process spawned will create
> a private QP on the shared PD, and use the shared MR to save the
> registration time per-process.
> 
>>
>>>> Could you please elaborate more how the process cleanup flow (e.g killed
>>>> process) is going to change? I know it's a very broad question but I'm just
>>>> trying to get the general idea.
>>>>
>>>
>>> For now the model in those suggested APIs is that cleanup will be done or
>>> explicitly by calling the relevant destroy command or alternatively once all
>>> processes that own the cmd_fd will be closed.
>>>
>>> From kernel side there is only one object and its ref count is not increased as
>>> part of the import_xxx() functions, see in the man pages some notes regarding
>>> this point.
>>
>> ACK.
>>
>>>> What's expected to happen in a case where we have two processes P1 & P2, both
>>>> use a shared PD, but separate MRs and QPs (created under the same shared PD).
>>>> Now when an RDMA read request arrives at P2's QP, but refers to an MR of P1
>>>> (which was not imported, but under the same PD), how would you expect the device
>>>> to handle that?
>>>>
>>>
>>> The processes are behaving almost like 2 threads each have a QP and an MR, if
>>> you mix them around it will work just like any buggy software.
>>> In this case I would expect the device to scatter to the MR that was pointed by
>>> the RDMA read request, any reason that it will behave differently ?
>>
>> I meant that the process is the RDMA read responder, not requester (although
>> it's very similar), are we OK with one process accessing memory of a different
>> process even though the MR isn't exported?
>>
>> I'm wondering whether there are any assumption about the "security" model of
>> this feature, or are both processes considered exactly the same. Especially
>> since both the kernel and the device aren't aware of the shared resources.
> 
> The RDMA security model is bound to the protection domain, so once the
> application logic shared it's PD (via the 'handle') it shared extended
> the security scope.
> 
>> It's a bit confusing that some of the resources are shared while others aren't
>> though all created using the same PD.
> 
> In this RFC, the shared resource are only stateless resource. Just
> import the resource, based on handle, and you have access.
> Current design doesn't add any shared state for resources running on
> different process memory spaces, objects like QP, CQ, need user-space
> state shared to be really usable between processes ... hopefully some
> days we'll get their.

Thanks Alex.

Let me know if I'm missing anything but assuming I'm importing an MR, I realise
that the address and length fields aren't going to be valid, but still the MR
points to physical memory that probably isn't in my address space.
So the process has access to post operations on the MR, but can't access its data?

How's the implementation of the new callbacks going to look like?
It sounds like this feature doesn't involve the device at all, in that case I
assume it won't involve the providers? Is it going to be a generic libibverbs
implementation?
