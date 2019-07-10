Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5163D640B4
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 07:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfGJFae (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 01:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfGJFae (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Jul 2019 01:30:34 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B078320665;
        Wed, 10 Jul 2019 05:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562736632;
        bh=mnyPrRPrkI7hIlrlYJGYMSU3A/sC+kozNSHgEhVuV/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TaJrhTv5tj+C1aAIwl9T2mcPRZpB2q8WigVib+0FvJNei0LY8KxZTp7vUDzhXjCJv
         tBZy2dXMxQ5E3Lgr4nCbyv61A71PMU8wxZYPbIFVCVsxtWh1hIjxLRzsvAGcJ+Cqdc
         xK88pHsO23X9IXmOGv0Ry+vAiJdkOemRczm55xn0=
Date:   Tue, 9 Jul 2019 22:30:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low! (2)
Message-ID: <20190710053030.GB2152@sol.localdomain>
Mail-Followup-To: Bart Van Assche <bvanassche@acm.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <00000000000089a718058556e1d8@google.com>
 <f71aaffa-ecf4-1def-fe50-91f37c677537@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f71aaffa-ecf4-1def-fe50-91f37c677537@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[Moved most people to Bcc; syzbot added way too many random people to this.]

Hi Bart,

On Sat, Mar 30, 2019 at 07:17:09PM -0700, Bart Van Assche wrote:
> On 3/30/19 2:58 PM, syzbot wrote:
> > syzbot has bisected this bug to:
> > 
> > commit 669de8bda87b92ab9a2fc663b3f5743c2ad1ae9f
> > Author: Bart Van Assche <bvanassche@acm.org>
> > Date:   Thu Feb 14 23:00:54 2019 +0000
> > 
> >      kernel/workqueue: Use dynamic lockdep keys for workqueues
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f1bacd200000
> > start commit:   0e40da3e Merge tag 'kbuild-fixes-v5.1' of
> > git://git.kernel..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=1409bacd200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1009bacd200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=6f39a9deb697359fe520
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e1bacd200000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1120fe0f200000
> > 
> > Reported-by: syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com
> > Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for
> > workqueues")
> > 
> > For information about bisection process see:
> > https://goo.gl/tpsmEJ#bisection
> 
> Hi Dmitry,
> 
> This bisection result doesn't make sense to me. As one can see, the message
> "BUG: MAX_STACK_TRACE_ENTRIES too low!" does not occur in the console output
> the above console output URL points at.
> 
> Bart.

This is still happening on mainline, and I think this bisection result is
probably correct.  syzbot did start hitting something different at the very end
of the bisection ("WARNING: CPU: 0 PID: 9153 at kernel/locking/lockdep.c:747")
but that seems to be just because your commit had a lot of bugs in it, which had
to be fixed by later commits.  In particular, the WARNING seems to have been
fixed by commit 28d49e282665e ("locking/lockdep: Shrink struct lock_class_key").

What seems to still be happening is that the dynamic lockdep keys which you
added make it possible for an unbounded number of entries to be added to the
fixed length stack_trace[] array in kernel/locking/lockdep.c.  Hence the "BUG:
MAX_STACK_TRACE_ENTRIES too low!".

Am I understanding it correctly?  How did you intend this to work?

- Eric
