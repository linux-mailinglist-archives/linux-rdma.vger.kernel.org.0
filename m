Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 949903BD13
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 21:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbfFJTrf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 15:47:35 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45925 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389093AbfFJTrf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jun 2019 15:47:35 -0400
Received: by mail-vk1-f196.google.com with SMTP id r23so1975747vkd.12
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2019 12:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tJqkZkxvqyt0n9gXCfpqbeOFz1qw5IOHXOpz6/WZhNc=;
        b=WkUG0DgqDvpwq5Ck702sSYctkVvRBLsLXKrdU9Bzq/ThgjnoERtwsm0XEtq5rMO1EB
         tGyFG23ImgFkflLRvSlYUXBMirqPn3gdS2dGo0jssn48CfllSuxtbzmEM5mikB40Tk4h
         VapbXtm/tt2rOYI3T/TYNqIZFBxkcqNtJCjLN+CsuZWqvUSw5tB3QIacT5gSlRXgis8K
         rGD/0PCbHZEhvaMBvXoda0Lf4NQpR1Pz/z0nHKhrR1rW/kJfttMYtd+tjc3/0eG52Epn
         wVv4cc9yi8+oRf29lOkpyD5LjS1iLBnZ3RMeWjeOscMdx2/PHu8BY591xYf92xNch16T
         7wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tJqkZkxvqyt0n9gXCfpqbeOFz1qw5IOHXOpz6/WZhNc=;
        b=mV+DpNSBl5frP2L099NFEeto0cZ1oa+SyP5JUFvYZz8wGUpvJHAmIdA1/hdXCS0F0b
         kfzsbT+cqIhgU9QfeP5kBFVAJe0+Fl+h6Ebr7aKL3zhDiUu70o5ppslQ7jdRQT+EZnjK
         DNP559cpSnARi9tcJxq6QYT+O74YOoTEM8fdauwUE8MGTBIZk0Xv9w8t7R9yjgNxnqvU
         CKnP/3bzgBNbmvacZEluGYh9AVQcJsbZ054/fmSwfCfRkFwNsrLT1zbQEUEOLq4UV5Oz
         OCTxvBC0t713jhebqDXczHVLdllRg/ZGK7+J0CysfwoGwS4PisF9VZJZbiZoHajMsYBF
         Mkug==
X-Gm-Message-State: APjAAAXlTm4ZyhWcqGoqAC3A3BTiXk0UHTtuuoClMq0Csn17uXdQ0SgG
        F28rFJV3CiHKjIxR6gb2/3kVKg==
X-Google-Smtp-Source: APXvYqxHX0MXghDAcbC5HGfJIEWJMHBjWcxTXhlF+7xiDLgOB64uA0+4DO5KecRyO0VbYw28h/SUqA==
X-Received: by 2002:a1f:2896:: with SMTP id o144mr15347442vko.73.1560196053934;
        Mon, 10 Jun 2019 12:47:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v133sm5191417vkv.5.2019.06.10.12.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 12:47:33 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1haQGS-0003pA-Vq; Mon, 10 Jun 2019 16:47:32 -0300
Date:   Mon, 10 Jun 2019 16:47:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com>,
        dasaratharaman.chandramouli@intel.com, dledford@redhat.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        roland@purestorage.com, sean.hefty@intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: bad unlock balance in ucma_event_handler
Message-ID: <20190610194732.GH18468@ziepe.ca>
References: <000000000000af6530056e863794@google.com>
 <20180613170543.GB30019@ziepe.ca>
 <20190610184853.GG63833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610184853.GG63833@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 10, 2019 at 11:48:54AM -0700, Eric Biggers wrote:
> On Wed, Jun 13, 2018 at 11:05:43AM -0600, Jason Gunthorpe wrote:
> > On Wed, Jun 13, 2018 at 06:47:02AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following crash on:
> > > 
> > > HEAD commit:    73fcb1a370c7 Merge branch 'akpm' (patches from Andrew)
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=16d70827800000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f3b4e30da84ec1ed
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e5579222b6a3edd96522
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=176daf97800000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e7bd57800000
> > > 
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com
> > > 
> > > 
> > > =====================================
> > > WARNING: bad unlock balance detected!
> > > 4.17.0-rc5+ #58 Not tainted
> > > kworker/u4:0/6 is trying to release lock (&file->mut) at:
> > > [<ffffffff8593ecc0>] ucma_event_handler+0x780/0xff0
> > > drivers/infiniband/core/ucma.c:390
> > > but there are no more locks to release!
> > > 
> > > other info that might help us debug this:
> > > 4 locks held by kworker/u4:0/6:
> > >  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:
> > > __write_once_size include/linux/compiler.h:215 [inline]
> > >  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:
> > > arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
> > >  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at: atomic64_set
> > > include/asm-generic/atomic-instrumented.h:40 [inline]
> > >  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at: atomic_long_set
> > > include/asm-generic/atomic-long.h:57 [inline]
> > >  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at: set_work_data
> > > kernel/workqueue.c:617 [inline]
> > >  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:
> > > set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
> > >  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:
> > > process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
> > >  #1:         (ptrval) ((work_completion)(&(&req->work)->work)){+.+.}, at:
> > > process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
> > >  #2:         (ptrval) (&id_priv->handler_mutex){+.+.}, at:
> > > addr_handler+0xa6/0x3d0 drivers/infiniband/core/cma.c:2796
> > >  #3:         (ptrval) (&file->mut){+.+.}, at: ucma_event_handler+0x10e/0xff0
> > > drivers/infiniband/core/ucma.c:350
> > 
> > I think this is probably a use-after-free race, eg when we do
> > ctx->file->mut we have raced with ucma_free_ctx() ..
> > 
> > Which probably means something along the way to free_ctx() did not
> > call rdma_addr_cancel?
> > 
> > Jason
> 
> This is still happening.  Just FYI, ignoring these reports doesn't make the bugs
> go away.  Here's a crash report from v5.2.0-rc4:

There are many unfixed syzkaller bugs in rdma_cm, so I'm not surprised
it is still happening..

Nobody has stepped forward to work on this code, and it is not a
simple mess to understand, let alone try to fix.

> =====================================
> WARNING: bad unlock balance detected!
> 5.2.0-rc4 #44 Not tainted
> kworker/u4:2/61 is trying to release lock (&file->mut) at:
> [<ffffffff851a3f81>] ucma_event_handler+0x711/0xef0 drivers/infiniband/core/ucma.c:394
> but there are no more locks to release!
> 
> other info that might help us debug this:
> 4 locks held by kworker/u4:2/61:
>  #0: 000000005ff5546b ((wq_completion)ib_addr){+.+.}, at: __write_once_size include/linux/compiler.h:221 [inline]
>  #0: 000000005ff5546b ((wq_completion)ib_addr){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
>  #0: 000000005ff5546b ((wq_completion)ib_addr){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
>  #0: 000000005ff5546b ((wq_completion)ib_addr){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
>  #0: 000000005ff5546b ((wq_completion)ib_addr){+.+.}, at: set_work_data kernel/workqueue.c:620 [inline]
>  #0: 000000005ff5546b ((wq_completion)ib_addr){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
>  #0: 000000005ff5546b ((wq_completion)ib_addr){+.+.}, at: process_one_work+0x87e/0x1790 kernel/workqueue.c:2240
>  #1: 00000000d75dabcd ((work_completion)(&(&req->work)->work)){+.+.}, at: process_one_work+0x8b4/0x1790 kernel/workqueue.c:2244
>  #2: 0000000058b7aa49 (&id_priv->handler_mutex){+.+.}, at: addr_handler+0xaf/0x3d0 drivers/infiniband/core/cma.c:3031
>  #3: 00000000e5042b0a (&file->mut){+.+.}, at: ucma_event_handler+0xb3/0xef0 drivers/infiniband/core/ucma.c:354

Well, it is holding the (logical) lock it is releasing, so this
probably menas ctx->file changed value while this event handler is
running. :\

A quick look suggests ucma_migrate_id does that..

.. and we can quickly see the bug, we try to obtain a lock:

        mutex_lock(&ctx->file->mut);

while another thread is changing that pointer under the lock we are
trying to get:

        ctx->file = new_file;

So probably mutex_lock went to sleep, holding &ctx->file->mut in a
register, then the thing in the lock changed ctx->file, finally the
unlock reloaded ctx->file and got the new unlocked value, and crash.

Which just an insane design in the first place.

That is as far as I can get, trying to figure out how to rework
ctx->file to be properly ref counted, accessed and locked, is a major
task.. I don't even know right now what migrate_id is supposed to be
for :(

Jason
