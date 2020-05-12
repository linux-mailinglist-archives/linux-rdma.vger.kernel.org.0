Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528951CEF01
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 10:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgELIWu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 04:22:50 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:19952 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgELIWt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 04:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589271770; x=1620807770;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WXPhjEUEZEAj5fDG/U8yXHYHXtsEbzkK2i/39zLazxc=;
  b=Mohdsp85BtJ1NQ9pvjoIsaAe4QmExwF6qQCy6Ue9ZJNlTr2deqOHkkzl
   DqmbeZYpEtRSxHhOt2UlZhBwNggRU8T8GL1JJ2wQK7uCbrSvioJEE7sfG
   MdzLC0R8Xj3dJWno/CQnkmoxi6NDk7LEnpzqTSZACHXu8DeKYi9OO2I7X
   E=;
IronPort-SDR: 5jF3huZUyXSxbrIIF0u6oVVrvkYTq7mHXqiOYD9vWQGOYTr273lD2dxv7SyCNphXXhqYDhBHF5
 V629EoUTjIUw==
X-IronPort-AV: E=Sophos;i="5.73,383,1583193600"; 
   d="scan'208";a="31180477"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 May 2020 08:22:37 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id C18B6A1240;
        Tue, 12 May 2020 08:22:35 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 08:22:34 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.76) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 08:22:31 +0000
Subject: Re: [PATCH RFC rdma-core] Verbs: Introduce import verbs for device,
 PD, MR
To:     Yishai Hadas <yishaih@dev.mellanox.co.il>
CC:     Yishai Hadas <yishaih@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <jgg@mellanox.com>, <maorg@mellanox.com>, <Alexr@mellanox.com>
References: <1589202728-12365-1-git-send-email-yishaih@mellanox.com>
 <a46dc0e5-7261-0bf1-9dff-1c62644c3c73@amazon.com>
 <ac69f0fa-e177-62c9-6fe8-5b0700d97712@dev.mellanox.co.il>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <1ada043f-b9c7-b961-d35b-9461f78ca9d2@amazon.com>
Date:   Tue, 12 May 2020 11:22:25 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ac69f0fa-e177-62c9-6fe8-5b0700d97712@dev.mellanox.co.il>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.76]
X-ClientProxiedBy: EX13D34UWA001.ant.amazon.com (10.43.160.173) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/05/2020 18:35, Yishai Hadas wrote:
> On 5/11/2020 5:31 PM, Gal Pressman wrote:
>> On 11/05/2020 16:12, Yishai Hadas wrote:
>>> Introduce import verbs for device, PD, MR, it enables processes to share
>>> their ibv_contxet and then share PD and MR that is associated with.
>>>
>>> A process is creating a device and then uses some of the Linux systems
>>> calls to dup its 'cmd_fd' member which lets other process to obtain
>>> owning on.
>>>
>>> Once other process obtains the 'cmd_fd' it can call ibv_import_device()
>>> which returns an ibv_contxet on the original RDMA device.
>>>
>>> On the imported device there is an option to import PD(s) and MR(s) to
>>> achieve a sharing on those objects.
>>>
>>> This is the responsibility of the application to coordinate between all
>>> ibv_context(s) that use the imported objects, such that once destroy is
>>> done no other process can touch the object except for unimport. All
>>> users of the context must collaborate to ensure this.
>>>
>>> A matching unimport verbs where introduced for PD and MR, for the device
>>> the ibv_close_device() API should be used.
>>>
>>> Detailed man pages are introduced as part of this RFC patch to clarify
>>> the expected usage and notes.
>>>
>>> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
>>
>> Hi Yishai,
>>
>> A few questions:
>> Can you please explain the use case? I remember there was a discussion on the
>> previous shared PD kernel submission (by Yuval and Shamir) but I'm not sure if
>> there was a conclusion.
>>
> 
> The expected flow and use case are as follows.
> 
> One process creates an ibv_context by calling ibv_open_device() and then enables
> owning of its 'cmd_fd' with other processes by some Linux system call, (see man
> page as part of this RFC for some alternatives). Then other process that owns
> this 'cmd_fd' will be able to have its own ibv_context for the same RDMA device
> by calling ibv_import_device().
> 
> At that point those processes really work on same kernel context and PD(s),
> MR(s) and potentially other objects in the future can be shared by calling
> ibv_import_pd()/mr() assuming that the initiator process let's the other ones
> know the kernel handle value.
> 
> Once a PD and MR which points to this PD were shared it enables a memory that
> was registered by one process to be used by others with the matching lkey/rkey
> for RDMA operations.

Thanks Yishai.
Which type of applications need this kind of functionality?

>> Could you please elaborate more how the process cleanup flow (e.g killed
>> process) is going to change? I know it's a very broad question but I'm just
>> trying to get the general idea.
>>
> 
> For now the model in those suggested APIs is that cleanup will be done or
> explicitly by calling the relevant destroy command or alternatively once all
> processes that own the cmd_fd will be closed.
> 
> From kernel side there is only one object and its ref count is not increased as
> part of the import_xxx() functions, see in the man pages some notes regarding
> this point.

ACK.

>> What's expected to happen in a case where we have two processes P1 & P2, both
>> use a shared PD, but separate MRs and QPs (created under the same shared PD).
>> Now when an RDMA read request arrives at P2's QP, but refers to an MR of P1
>> (which was not imported, but under the same PD), how would you expect the device
>> to handle that?
>>
> 
> The processes are behaving almost like 2 threads each have a QP and an MR, if
> you mix them around it will work just like any buggy software.
> In this case I would expect the device to scatter to the MR that was pointed by
> the RDMA read request, any reason that it will behave differently ?

I meant that the process is the RDMA read responder, not requester (although
it's very similar), are we OK with one process accessing memory of a different
process even though the MR isn't exported?

I'm wondering whether there are any assumption about the "security" model of
this feature, or are both processes considered exactly the same. Especially
since both the kernel and the device aren't aware of the shared resources.
It's a bit confusing that some of the resources are shared while others aren't
though all created using the same PD.
