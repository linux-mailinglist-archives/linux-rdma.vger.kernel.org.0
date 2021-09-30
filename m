Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15BB41D826
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 12:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350129AbhI3K5u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 06:57:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49444 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350123AbhI3K5u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 06:57:50 -0400
Date:   Thu, 30 Sep 2021 12:56:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632999366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BO79hiGNy3ejhyXEBBMc8ntGofuutpY57wCe1cCdsao=;
        b=aRVrXY608v1lm5NmXBWtys3GI0cqnjpqM6yWA9ORZmodACl6ZBshHLrQCOEBXouM1ROzJ5
        mi7dazTMs868ycP5IWzgybbnJn3ba/7cuypxs/bPW25FyC8wY58L2L1PL8yIr+QFPcEXJK
        JtAnKYJ0p21tySMn4tqiJKf7ndAmIshBwXYOtTWFPKyZnTyEG0tsuu8KhDr3Ryl2KhHHE9
        0ibJXrffS2tsDluDWFPXchxrk3sTzC6SUKg8nV5VLd3sIqPR8fUY3WDO/lvCBheiE3/mJJ
        +iGQ+RqQ44PNkrlSPErxPr4KRDn8doVt+cDkp6z2VHFlGT/DO0VE6PRt8w2M0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632999366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BO79hiGNy3ejhyXEBBMc8ntGofuutpY57wCe1cCdsao=;
        b=YVuxTtJ68IpBCIvH/+TNUgTVZypiYXKDGJxT07dwWeNCCFgZy9uV9u1t457wBIq5tqngzh
        dN+JotErBVkENlCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        megaraidlinux.pdl@broadcom.com,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com
Subject: [RFC] Is lib/irq_poll still considered useful?
Message-ID: <20210930105605.ofyayf3uwk75u25s@linutronix.de>
References: <20210930103754.2128949-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930103754.2128949-1-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I was looking at irq_poll and for missing scheduling points.
It raised the question why are there 7 driver still using irq_poll and
not moved on to something else like threaded interrupts or kworker.

There is:
- Infiband can complete direct, irq_poll and kworker.
- be2iscsi only irq_poll.
- cxlflash only irq_poll. Not sure how IRQs are acked.
- ipr direct or irq_poll, can be configured. Now sure how IRQs are acked.
- lpfc kworker and/or irq_poll. Not sure all invocations are from
  interrupts like context [0].
- megaraid irq_poll. Not sure all invocations are from interrupts like
  context [0].
- mpt3sas irq_poll or io_uring io poll. Not sure all invocations are
  from interrupts like context [0].

[0] If irq_poll_sched() is not used from an interrupt (as in interrupt
service routine, timer handler, tasklet (not encouraging just noticed))
but from task context (as in kworker for instance) then irq-poll handler
will not be invoked right away. Instead it will be delayed to random
point in time until an interrupt fires or something down the stack
performs a pending softirq check.
Waking ksoftirqd itself isn't helping much since it will set a
NEED_RESCHED bit in the task_struct which local_irq_restore() isn't
testing for. So the scheduling event is delayed until spin_unlock() for
instance.

Is there a reason for the remaining user of irq_poll to keep using it?

Sebastian
