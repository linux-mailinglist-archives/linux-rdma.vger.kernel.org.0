Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002C0288C05
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 17:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388995AbgJIPAZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 11:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388985AbgJIPAZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 11:00:25 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5BEC0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 08:00:25 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id r8so8098174qtp.13
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MgsQJ/14p5q8gnNfxhhcQgrrunpS11H6zm49HsGpZv8=;
        b=C7NHLrFtCYBytK5kHDAwH6aa/avqgHmH/rQKZt/rT1WlC5ajPRQsS6LwSZz3G295Vr
         MsCoE/J0hDyqO+GNhdWEeizhoeZabSLbbvL5uiA0VGfr8WiUDb50wNx5TAW/R0iXW0UA
         cv6JJBwq/efqn3lC34Oi/xhiHqpA+rEq/+9yimZPQn9UVhUH/qn4suDwi+vpH4+kaaOS
         HUJmmYUciwOUb/qcM51ayGZX02QtYJUiHpdY6Meb/l5ZXyQS9xZ8UZ+uOvoOIkwFd7r+
         tlx2v5rg7sH24JEOz/z1BpxEtNhi49+rEL46P8+EA40P7Op0CtdvSJWr/S080iEJzl0i
         XfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MgsQJ/14p5q8gnNfxhhcQgrrunpS11H6zm49HsGpZv8=;
        b=lEmODWO/babJKX1QrMSvxoIEN4NKDDhCvmTf21H0i4D65quj0IoeNK5PJem1VAUu2n
         um5UkCZbIpO2i+I7iwHAKbxJvvWEQ6O1accMSTMdGYflxfthMKdavCXItgVPvtNFgjNm
         UtsElxBdz+02L5pNndKvpDPT+sPJ0uKVeIi3FZ8UXwy5ELFyVRf1U+/rfPppNEmyctkG
         6QZo+uPcnafk3iv/N1zA4ZT3zAl90vGZiLf1cbmALlWZYIvezg484axJ9xB4cAcdDLFk
         UspaZ3rtvrba1gsQpuLQfYM241spB9YpCIJmtxe5W2zMRCGvmQeDQXEoy8Df809gDWSF
         oI9w==
X-Gm-Message-State: AOAM5321erHxZTT5AAtxoTi8eMPwuJKWpzZOdVJvhYeTDa+XziH2oOrw
        37v6JFN0tVnYp0591nicLqs=
X-Google-Smtp-Source: ABdhPJzUygseYFqR339i88YjfGr1Xfj9zhervA/fQ49ydLUvZiw81pmMiNGJ7yRfH3xmLlRceG880w==
X-Received: by 2002:ac8:7281:: with SMTP id v1mr13539677qto.229.1602255624600;
        Fri, 09 Oct 2020 08:00:24 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a66sm6464203qkd.47.2020.10.09.08.00.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2020 08:00:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20201009145706.GU5177@ziepe.ca>
Date:   Fri, 9 Oct 2020 11:00:22 -0400
Cc:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <EC7EE276-3529-4374-9F90-F061AAC3B952@gmail.com>
References: <20201006124627.GH5177@ziepe.ca>
 <ad892ef5-9b86-2e75-b0f8-432d8e157f60@oracle.com>
 <20201007111636.GD3678159@unreal>
 <4d29915c-3ed7-0253-211b-1b97f5f8cfdf@oracle.com>
 <20201008103641.GM13580@unreal>
 <aec6906d-7be5-b489-c7dc-0254c4538723@oracle.com>
 <20201008160814.GF5177@ziepe.ca>
 <727de097-4338-c1d8-73a0-1fce0854f8af@oracle.com>
 <20201009143940.GT5177@ziepe.ca>
 <0E82FB51-244C-4134-8F74-8C365259DCD5@gmail.com>
 <20201009145706.GU5177@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Oct 9, 2020, at 10:57 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> On Fri, Oct 09, 2020 at 10:48:55AM -0400, Chuck Lever wrote:
>> Hi Jason-
>> 
>>> On Oct 9, 2020, at 10:39 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>> 
>>> On Fri, Oct 09, 2020 at 12:49:30PM +0800, Ka-Cheong Poon wrote:
>>>> As I mentioned before, this is a very serious restriction on how
>>>> the RDMA subsystem can be used in a namespace environment by kernel
>>>> module.  The reason given for this restriction is that any kernel
>>>> socket without a corresponding user space file descriptor is "rogue".
>>>> All Internet protocol code create a kernel socket without user
>>>> interaction.  Are they all "rogue"?
>>> 
>>> You should work with Chuck to make NFS use namespaces properly and
>>> then you can propose what changes might be needed with a proper
>>> justification.
>> 
>> The NFS server code already uses namespaces for creating listener
>> endpoints, already has a user space component that drives the
>> creation of listeners, and already passes an appropriate struct
>> net to rdma_create_id. As far as I am aware, it is namespace-aware
>> and -friendly all the way down to rdma_create_id().
>> 
>> What more needs to be done?
> 
> I have no idea, if you are able to pass a namespace all the way down
> to the listening cm_id and everything works right (I'm skeptical) then
> there is nothing more to worry about - why are we having this thread?

The thread is about RDS, not NFS. NFS has some useful examples to
crib, but it's not the main point.

I don't think NFS/RDMA namespacing works today, but it's not because
NFS isn't ready. I agree that is another thread.


>>> The rules for lifetime on IB clients are tricky, and the interaction
>>> with namespaces makes it all a lot more murky.
>> 
>> I think what Ka-cheong is asking is for a detailed explanation of
>> these lifetime rules so we can understand why rdma_create_id bumps
>> the namespace reference count.
> 
> It is because the CM has no code to revoke a CM ID before the
> namespace goes away and the pointer becomes invalid.

Is it just a question of "no-one has yet written this code" or is
there a deeper technical reason why this has not been done?


--
Chuck Lever
chucklever@gmail.com



