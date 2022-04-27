Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5C851143A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Apr 2022 11:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiD0JWe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Apr 2022 05:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiD0JWd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Apr 2022 05:22:33 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A49284D4E;
        Wed, 27 Apr 2022 02:19:09 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 5A0C9B0034A; Wed, 27 Apr 2022 11:19:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1651051142; bh=THAW7SYz39sd/4SV8yYtY27oG4RBl9E93y+eOWpVpUk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lmXeCHTS1JPWXVhPjcLNIuleVDaTvDTP4ykvzJJp3YixMG8lELuB+IIFRFMXUkxXk
         X4SfPdPrQ5oy8cP2ydHY+d+L1tM+R3iWFd42J59UEL46LmMD/BP9jZA2JaH20U+tRg
         j0f3l7VzVgoMFloIDTydL6sAELGKzvfXvd8x+XSaiSlBlK/tfz2Bb7HNVPw+2gH9+Z
         Xmy+z4yX6GG1nFKOkUcSPASZYdSX4kohjSU7bMDV5eBw/EkfOksRZrcAlvezOs2BwB
         pQbIbcxs5ZINHSERykb0UQbE0Nx/nnfWR1iMYxRDHqEtb0TA5+9HHhYCQEdeatriOc
         GMU1D4KmEyBLQ==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 515BFB0001E;
        Wed, 27 Apr 2022 11:19:02 +0200 (CEST)
Date:   Wed, 27 Apr 2022 11:19:02 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        linux-rdma@vger.kernel.org
Subject: Re: [patch v12 00/13] extensible prctl task isolation interface and
 vmstat sync
In-Reply-To: <20220315153132.717153751@fedora.localdomain>
Message-ID: <alpine.DEB.2.22.394.2204271049050.159551@gentwo.de>
References: <20220315153132.717153751@fedora.localdomain>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Ok I actually have started an opensource project that may make use of the
onshot interface. This is a bridging tool between two RDMA protocols
called ib2roce. See https://gentwo.org/christoph/2022-bridging-rdma.pdf

The relevant code can be found at
https://github.com/clameter/rdma-core/tree/ib2roce/ib2roce. In
particular look at the ib2roce.c source code. This is still
under development.

The ib2roce briding can run in a busy loop mode (-k option) where it spins
on ibv_poll_cq() which is an RDMA call to handle incoming packets without
kernel interaction. See busyloop() in ib2roce.c

Currently I have configured the system to use CONFIG_NOHZ_FULL. With that
I am able to reliably forward packets at a rate that saturates 100G
Ethernet / EDR Infiniband from a single spinning thread.

Without CONFIG_NOHZ_FULL any slight disturbance causes the forwarding to
fall behind which will lead to dramatic packet loss since we are looking
here at a potential data rate of 12.5Gbyte/sec and about 12.5Mbyte per
msec. If the kernel interrupts the forwarding by say 10 msecs then we are
falling behind by 125MB which would have to be buffered and processing by
additional codes. That complexity makes it processing packets much slower
which could cause the forwarding to slow down so that a recovery is not
possible should the data continue to arrive at line rate.

Isolation of the threads was done through the following kernel parameters:

nohz_full=8-15,24-31 rcu_nocbs=8-15,24-31 poll_spectre_v2=off
numa_balancing=disable rcutree.kthread_prio=3 intel_pstate=disable nosmt

And systemd was configured with the following affinites:

system.conf:CPUAffinity=0-7,16-23

This means that the second socket will be generally free of tasks and
kernel threads.

The NUMA configuration:

$ numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7
node 0 size: 94798 MB
node 0 free: 92000 MB
node 1 cpus: 8 9 10 11 12 13 14 15
node 1 size: 96765 MB
node 1 free: 96082 MB

node distances:
node   0   1
  0:  10  21
  1:  21  10


I could modify busyloop() in ib2roce.c to use the oneshot mode via prctl
provided by this patch instead of the NOHZ_FULL.

What kind of metric could I be using to show the difference in idleness of
the quality of the cpu isolation?

The ib2roce tool already has a CLI mode where one can monitor the
latencies that the busyloop experiences. See the latency calculations in
busyloop() and the CLI command "core". Stats can be reset via the "zap"
command.

I can see the usefulness of the oneshot mode but (I am very very sorry) I
still think that this patchset overdoes what is needed and I fail to
understand what the point of inheritance, per syscall quiescint etc is.
Those cause needless overhead in syscall handling and increase the
complexity of managing a busyloop. Special handling when the scheduler
switches a task? If tasks are being switched that requires them to be low
latency and undisturbed then something went very very wrong with the
system configuration and the only thing I would suggest is to issue some
kernel warning that this is not the way one should configure the system.

