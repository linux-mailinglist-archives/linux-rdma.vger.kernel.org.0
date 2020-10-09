Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3627B288C8D
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 17:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbgJIP1s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 11:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbgJIP1s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 11:27:48 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC572C0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 08:27:47 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h12so6664827qtu.1
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xwbt5W1SHlsZL0FkYNouOW6g8Ll0wtUCa+SeaTEjzTc=;
        b=ttgKNRtLI2e0gRDJB8xN+3vB0CIA3SGFb845sFXpRr7EIHR9SS8ayxdQy9u8JWfkph
         HI5OlftY5A0gElBaq0vcJPjWliRow2CLwAMjRnD8uVpmL0bZhkWu8tOm0d0XFOZnRQfz
         9KIhZexjYua/dbEnqs+BxBF2NgVCAGF/DQk2GSly54HJjoqrVTj5jVXmIqPiRQ7QKuJa
         lREN41FmwLNThDKdFAfTDFD2Xu8hJhEVsPgwVzLgWGMXcdCwCtyjqYU9H1HlTcVpDUky
         Kbs9zUFa+O8xD0B+JBN52OEx/1jgge99+CrwQPKjJ4kbTcvnxFK+KbUyCxHGJnLKjL11
         F+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xwbt5W1SHlsZL0FkYNouOW6g8Ll0wtUCa+SeaTEjzTc=;
        b=eE5vcSaoixK7R/lAzmd1lVdk8GkSc7AK2pwLKFfVNbOlBgt7HAn1CPJ0nUWoIkl5+E
         hUn5jsEL7xHaFq1eLg+gC8/s6Lr1RJDEvkkLPiYNAwyGpdwcIPgf2Jw+DI5WEhx81Fci
         immxDAaK9OnWJRTRqIveY8R+ysjibBbaN+39Pht8/EFetu7WgZkifKUZVn1QexuyszzM
         JPJUAeDSDkQDHerw/R722qzrZYy49fus//gnbAi5xtww8pjzGhWyBny2VQw10qStKNXz
         Cz2vB4xCqCCvo6H5zEPFjD2xhMBEY6ZR5GrgpCLaNsEe60ru4sN4BmacL4qolJW4NttP
         I5LQ==
X-Gm-Message-State: AOAM531RncaVn6y3H1wtGlli/tzXX7nGNWQ9bYtZ0OoIprC50d4EUGA3
        o8fx/lUSd7eMQWVhwEzR61U=
X-Google-Smtp-Source: ABdhPJxtkYr/l6zOQJPXwTT/wSwLaSpow47c0q752YtpmOuYGYv7xp6CSBt6hpYQcJSYEWR46CE9hQ==
X-Received: by 2002:ac8:373b:: with SMTP id o56mr13149216qtb.305.1602257267120;
        Fri, 09 Oct 2020 08:27:47 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w4sm6686317qtb.0.2020.10.09.08.27.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2020 08:27:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20201009150758.GV5177@ziepe.ca>
Date:   Fri, 9 Oct 2020 11:27:44 -0400
Cc:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7EC25CA9-27B5-4900-B49C-43D29ED06EB6@gmail.com>
References: <20201007111636.GD3678159@unreal>
 <4d29915c-3ed7-0253-211b-1b97f5f8cfdf@oracle.com>
 <20201008103641.GM13580@unreal>
 <aec6906d-7be5-b489-c7dc-0254c4538723@oracle.com>
 <20201008160814.GF5177@ziepe.ca>
 <727de097-4338-c1d8-73a0-1fce0854f8af@oracle.com>
 <20201009143940.GT5177@ziepe.ca>
 <0E82FB51-244C-4134-8F74-8C365259DCD5@gmail.com>
 <20201009145706.GU5177@ziepe.ca>
 <EC7EE276-3529-4374-9F90-F061AAC3B952@gmail.com>
 <20201009150758.GV5177@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Oct 9, 2020, at 11:07 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> On Fri, Oct 09, 2020 at 11:00:22AM -0400, Chuck Lever wrote:
>> 
>> 
>>> On Oct 9, 2020, at 10:57 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>> 
>>> On Fri, Oct 09, 2020 at 10:48:55AM -0400, Chuck Lever wrote:
>>>> Hi Jason-
>>>> 
>>>>> On Oct 9, 2020, at 10:39 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>> 
>>>>> On Fri, Oct 09, 2020 at 12:49:30PM +0800, Ka-Cheong Poon wrote:
>>>>>> As I mentioned before, this is a very serious restriction on how
>>>>>> the RDMA subsystem can be used in a namespace environment by kernel
>>>>>> module.  The reason given for this restriction is that any kernel
>>>>>> socket without a corresponding user space file descriptor is "rogue".
>>>>>> All Internet protocol code create a kernel socket without user
>>>>>> interaction.  Are they all "rogue"?
>>>>> 
>>>>> You should work with Chuck to make NFS use namespaces properly and
>>>>> then you can propose what changes might be needed with a proper
>>>>> justification.
>>>> 
>>>> The NFS server code already uses namespaces for creating listener
>>>> endpoints, already has a user space component that drives the
>>>> creation of listeners, and already passes an appropriate struct
>>>> net to rdma_create_id. As far as I am aware, it is namespace-aware
>>>> and -friendly all the way down to rdma_create_id().
>>>> 
>>>> What more needs to be done?
>>> 
>>> I have no idea, if you are able to pass a namespace all the way down
>>> to the listening cm_id and everything works right (I'm skeptical) then
>>> there is nothing more to worry about - why are we having this thread?
>> 
>> The thread is about RDS, not NFS. NFS has some useful examples to
>> crib, but it's not the main point.
>> 
>> I don't think NFS/RDMA namespacing works today, but it's not because
>> NFS isn't ready. I agree that is another thread.
> 
> Exactly, so instead of talking about RDS stuff without any patches,

Roger that. Maybe Ka-Cheong and team can propose some patches to
help the discussion along.


> let's talk about NFS with patches - if you can make NFS work then I
> assume RDS will be happy.

Perhaps not a valid assumption :-)

NFS is a traditional client-server model, and has a user space tool
that drives the creation of endpoints, just as you expect.

With RDS, listener endpoints are not visible in user space. They
are a globally-managed shared resource, more like network interfaces
than listener sockets.

Therefore I think the approach is going to be "one RDS listener per
net namespace". The problem Ka-Cheong is trying to address is how to
manage the destruction of a listener-namespace pair. The extra
reference count on the cm_id is pinning the namespace so it cannot
be destroyed.


> NFS has an established model for using namespaces that the other
> transports uses, so I'd rather focus on this.

Understood, but it doesn't seem like there is enough useful overlap
between the NFS and RDS usage scenarios. With NFS, I would expect
an explicit listener shutdown from userland prior to namespace
destruction.


>>>>> The rules for lifetime on IB clients are tricky, and the interaction
>>>>> with namespaces makes it all a lot more murky.
>>>> 
>>>> I think what Ka-cheong is asking is for a detailed explanation of
>>>> these lifetime rules so we can understand why rdma_create_id bumps
>>>> the namespace reference count.
>>> 
>>> It is because the CM has no code to revoke a CM ID before the
>>> namespace goes away and the pointer becomes invalid.
>> 
>> Is it just a question of "no-one has yet written this code" or is
>> there a deeper technical reason why this has not been done?
> 
> It is hard to know without spending a big deep look at this
> stuff.

Fair enough.

--
Chuck Lever
chucklever@gmail.com



