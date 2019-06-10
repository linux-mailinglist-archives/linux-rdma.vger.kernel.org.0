Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006C13BC00
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 20:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbfFJSs6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 14:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387643AbfFJSs5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 14:48:57 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A92B920820;
        Mon, 10 Jun 2019 18:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560192536;
        bh=XZ86jjwF1oGd+f9Yai/J2YS8bqa+X4CsP9P3m5jkPgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vxSI1n8hE3eHo/16Zg9bxLvcSmbXCMzoUQftAKSOey74cbJ0zFxqpltBc9zdQKEVy
         hDIKg4YD2+TT+LptXX/spm2ZXE4xJSdVGYsM8cGvhTC8UT2GacA2Gop52+Ux1XEtJP
         ICgSsbL7k6a5Slvj9AV11Iqv/enrD28Qv+oNr+4Y=
Date:   Mon, 10 Jun 2019 11:48:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     syzbot <syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com>,
        dasaratharaman.chandramouli@intel.com, dledford@redhat.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        roland@purestorage.com, sean.hefty@intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: bad unlock balance in ucma_event_handler
Message-ID: <20190610184853.GG63833@gmail.com>
References: <000000000000af6530056e863794@google.com>
 <20180613170543.GB30019@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613170543.GB30019@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 13, 2018 at 11:05:43AM -0600, Jason Gunthorpe wrote:
> On Wed, Jun 13, 2018 at 06:47:02AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    73fcb1a370c7 Merge branch 'akpm' (patches from Andrew)
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16d70827800000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f3b4e30da84ec1ed
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e5579222b6a3edd96522
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=176daf97800000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e7bd57800000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com
> > 
> > 
> > =====================================
> > WARNING: bad unlock balance detected!
> > 4.17.0-rc5+ #58 Not tainted
> > kworker/u4:0/6 is trying to release lock (&file->mut) at:
> > [<ffffffff8593ecc0>] ucma_event_handler+0x780/0xff0
> > drivers/infiniband/core/ucma.c:390
> > but there are no more locks to release!
> > 
> > other info that might help us debug this:
> > 4 locks held by kworker/u4:0/6:
> >  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:
> > __write_once_size include/linux/compiler.h:215 [inline]
> >  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:
> > arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
> >  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at: atomic64_set
> > include/asm-generic/atomic-instrumented.h:40 [inline]
> >  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at: atomic_long_set
> > include/asm-generic/atomic-long.h:57 [inline]
> >  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at: set_work_data
> > kernel/workqueue.c:617 [inline]
> >  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:
> > set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
> >  #0:         (ptrval) ((wq_completion)"ib_addr"){+.+.}, at:
> > process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
> >  #1:         (ptrval) ((work_completion)(&(&req->work)->work)){+.+.}, at:
> > process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
> >  #2:         (ptrval) (&id_priv->handler_mutex){+.+.}, at:
> > addr_handler+0xa6/0x3d0 drivers/infiniband/core/cma.c:2796
> >  #3:         (ptrval) (&file->mut){+.+.}, at: ucma_event_handler+0x10e/0xff0
> > drivers/infiniband/core/ucma.c:350
> 
> I think this is probably a use-after-free race, eg when we do
> ctx->file->mut we have raced with ucma_free_ctx() ..
> 
> Which probably means something along the way to free_ctx() did not
> call rdma_addr_cancel?
> 
> Jason

This is still happening.  Just FYI, ignoring these reports doesn't make the bugs
go away.  Here's a crash report from v5.2.0-rc4:

https://syzkaller.appspot.com/text?tag=CrashReport&x=102aa7c1a00000

=====================================
WARNING: bad unlock balance detected!
5.2.0-rc4 #44 Not tainted
-------------------------------------
kworker/u4:2/61 is trying to release lock (&file->mut) at:
[<ffffffff851a3f81>] ucma_event_handler+0x711/0xef0 drivers/infiniband/core/ucma.c:394
but there are no more locks to release!

other info that might help us debug this:
4 locks held by kworker/u4:2/61:
 #0: 000000005ff5546b ((wq_completion)ib_addr){+.+.}, at: __write_once_size include/linux/compiler.h:221 [inline]
 #0: 000000005ff5546b ((wq_completion)ib_addr){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: 000000005ff5546b ((wq_completion)ib_addr){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
 #0: 000000005ff5546b ((wq_completion)ib_addr){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 #0: 000000005ff5546b ((wq_completion)ib_addr){+.+.}, at: set_work_data kernel/workqueue.c:620 [inline]
 #0: 000000005ff5546b ((wq_completion)ib_addr){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
 #0: 000000005ff5546b ((wq_completion)ib_addr){+.+.}, at: process_one_work+0x87e/0x1790 kernel/workqueue.c:2240
 #1: 00000000d75dabcd ((work_completion)(&(&req->work)->work)){+.+.}, at: process_one_work+0x8b4/0x1790 kernel/workqueue.c:2244
 #2: 0000000058b7aa49 (&id_priv->handler_mutex){+.+.}, at: addr_handler+0xaf/0x3d0 drivers/infiniband/core/cma.c:3031
 #3: 00000000e5042b0a (&file->mut){+.+.}, at: ucma_event_handler+0xb3/0xef0 drivers/infiniband/core/ucma.c:354

stack backtrace:
CPU: 1 PID: 61 Comm: kworker/u4:2 Not tainted 5.2.0-rc4 #44
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ib_addr process_one_req
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x172/0x1f0 lib/dump_stack.c:113
 print_unlock_imbalance_bug kernel/locking/lockdep.c:3846 [inline]
 print_unlock_imbalance_bug.cold+0x114/0x123 kernel/locking/lockdep.c:3823
 __lock_release kernel/locking/lockdep.c:4062 [inline]
 lock_release+0x67b/0xa00 kernel/locking/lockdep.c:4322
 __mutex_unlock_slowpath+0x8e/0x6b0 kernel/locking/mutex.c:1198
 mutex_unlock+0xd/0x10 kernel/locking/mutex.c:714
 ucma_event_handler+0x711/0xef0 drivers/infiniband/core/ucma.c:394
 addr_handler+0x2e9/0x3d0 drivers/infiniband/core/cma.c:3064
 process_one_req+0x106/0x680 drivers/infiniband/core/addr.c:644
 process_one_work+0x989/0x1790 kernel/workqueue.c:2269
 worker_thread+0x98/0xe40 kernel/workqueue.c:2415
 kthread+0x354/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

- Eric
