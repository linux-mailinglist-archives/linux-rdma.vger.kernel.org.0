Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6C051AD62
	for <lists+linux-rdma@lfdr.de>; Wed,  4 May 2022 20:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356342AbiEDTBQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 15:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356109AbiEDTBP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 15:01:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D15822292
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651690657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uAicELaPXE9dwMxkjrZ0sq+/Xws0OTtxlGLWhiCN/ho=;
        b=aX5yaoL/QPH1HsH++ja7EVGm6j8CwRnHmNHlXRH927TDGBafpq1i/tGC0c0yS1wHwMAubJ
        D+Wo69GvPb1iwvc6gouMJuN5Q7xk0pKwjfezEiViPGVb9/6TEvRqRql2hM80XwkkYfWFDH
        nJCIKi2S5vRs1kdsiiBIctAsMo4jp0I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-xVv9cXqFP6OQBnN1v2isgg-1; Wed, 04 May 2022 14:57:34 -0400
X-MC-Unique: xVv9cXqFP6OQBnN1v2isgg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA6BB3C138A0;
        Wed,  4 May 2022 18:57:33 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E417B2D441;
        Wed,  4 May 2022 18:57:12 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 1D5EA4936633; Wed,  4 May 2022 15:56:51 -0300 (-03)
Date:   Wed, 4 May 2022 15:56:51 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Lameter <cl@gentwo.de>, linux-kernel@vger.kernel.org,
        Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        linux-rdma@vger.kernel.org
Subject: Re: [patch v12 00/13] extensible prctl task isolation interface and
 vmstat sync
Message-ID: <YnLMc5X8MZElk0NT@fuller.cnet>
References: <20220315153132.717153751@fedora.localdomain>
 <alpine.DEB.2.22.394.2204271049050.159551@gentwo.de>
 <YnF7CjzYBhASi1Eo@fuller.cnet>
 <87h765juyk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h765juyk.ffs@tglx>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 04, 2022 at 03:20:03PM +0200, Thomas Gleixner wrote:
> On Tue, May 03 2022 at 15:57, Marcelo Tosatti wrote:
> > On Wed, Apr 27, 2022 at 11:19:02AM +0200, Christoph Lameter wrote:
> >> I could modify busyloop() in ib2roce.c to use the oneshot mode via prctl
> >> provided by this patch instead of the NOHZ_FULL.
> >> 
> >> What kind of metric could I be using to show the difference in idleness of
> >> the quality of the cpu isolation?
> >
> > Interruption length and frequencies:
> >
> > -------|xxxxx|---------------|xxx|---------
> > 	 5us 		      3us
> >
> > which is what should be reported by oslat ?
> 
> How is oslat helpful there? That's running artifical workload benchmarks
> which are not necessarily representing the actual
> idle->interrupt->idle... timing sequence of the real world usecase.

Ok, so what is happening today on production on some telco installations 
(considering virtualized RAN usecase) is this:

1) Basic testing: Verify the hardware, software and its configuration
(cpu isolation parameters etc) are able to achieve the desired maximum
interruption length/frequencies through a synthetic benchmark like 
cyclictest and oslat, for a duration that is considered sufficient.

One might also use the actual application in a synthetic configuration
(for example FlexRAN with synthetic data).

2) From the above, assume real world usecase is able to achieve the
desired maximum interruption length/frequency.

Of course, that is sub-optimal. The rt-trace-bcc.py scripts instruments
certain functions in the kernel (say smp_call_function family), 
allowing one to check if certain interruptions have happened
on production. Example:

$ sudo ./rt-trace-bcc.py -c 36-39
[There can be some warnings dumped; we can ignore them]
Enabled hook point: process_one_work
Enabled hook point: __queue_work
Enabled hook point: __queue_delayed_work
Enabled hook point: generic_exec_single
Enabled hook point: smp_call_function_many_cond
Enabled hook point: irq_work_queue
Enabled hook point: irq_work_queue_on
TIME(s)            COMM                 CPU  PID      MSG
0.009599293        rcuc/8               8    75       irq_work_queue_on (target=36, func=nohz_full_kick_func)
0.009603039        rcuc/8               8    75       irq_work_queue_on (target=37, func=nohz_full_kick_func)
0.009604047        rcuc/8               8    75       irq_work_queue_on (target=38, func=nohz_full_kick_func)
0.009604848        rcuc/8               8    75       irq_work_queue_on (target=39, func=nohz_full_kick_func)
0.103600589        rcuc/8               8    75       irq_work_queue_on (target=36, func=nohz_full_kick_func)
...

Currently it does not record the length of each interruption, but it
could (or you can do that from its output).

Note however that the sum of the interruptions is not the entire
overhead caused by the interruptions: there might also cachelines thrown 
away which are only going to be "counted" when the latency sensitive
app executes.

But you could say the overhead is _at least_ the sum of interruptions +
cache effects unaccounted for.

Also note that for idle->interrupt->idle type scenarios (the vRAN
usecase above currently does not idle at all, but there is interest
from the field for that to happen for power saving reasons), you'd
also sum return from idle.

> > Inheritance is an attempt to support unmodified binaries like so:
> >
> > 1) configure task isolation parameters (eg sync per-CPU vmstat to global
> > stats on system call returns).
> > 2) enable inheritance (so that task isolation configuration and
> > activation states are copied across to child processes).
> > 3) enable task isolation.
> > 4) execv(binary, params)
> 
> What for? If an application has isolation requirements, then the
> specific requirements are part of the application design and not of some
> arbitrary wrapper. 

To be able to configure and active task isolation for an unmodified
binary, which seems a useful feature. However, have no problem of not 
supporting unmodified binaries (would have then to change the
applications).

There are 3 types of application arrangements:

==================
Userspace support
==================

Task isolation is divided in two main steps: configuration and activation.

Each step can be performed by an external tool or the latency sensitive
application itself. util-linux contains the "chisol" tool for this
purpose.

This results in three combinations:

1. Both configuration and activation performed by the
latency sensitive application.
Allows fine grained control of what task isolation
features are enabled and when (see samples section below).

2. Only activation can be performed by the latency sensitive app
(and configuration performed by chisol).
This allows the admin/user to control task isolation parameters,
and applications have to be modified only once.

3. Configuration and activation performed by an external tool.
This allows unmodified applications to take advantage of
task isolation. Activation is performed by the "-a" option
of chisol.

---

Some features might not be supportable (or have awkward behavior) on a
given combination. For example, if a feature such as "warn if
sched_out/sched_in is ever performed if task isolation is
configured/activated", then you'll get those warnings 
for combination 3 (which is the case of unmodified binaries above).

> Inheritance is an orthogonal problem and there is no reason to have this
> initially.

No problem, will drop it.

> Can we please focus on the initial problem of
> providing a sensible isolation mechanism with well defined semantics?

Case 2, however, was implicitly suggested by you (or at least i
understood that):

"Summary: The problem to be solved cannot be restricted to

    self_defined_important_task(OWN_WORLD);

Policy is not a binary on/off problem. It's manifold across all levels
of the stack and only a kernel problem when it comes down to the last
line of defence.

Up to the point where the kernel puts the line of last defence, policy
is defined by the user/admin via mechanims provided by the kernel.

Emphasis on "mechanims provided by the kernel", aka. user API.

Just in case, I hope that I don't have to explain what level of scrunity
and thought this requires." 

The idea, as i understood was that certain task isolation features (or
they parameters) might have to be changed at runtime (which depends on
the task isolation features themselves, and the plan is to create
an extensible interface). So for case 2, all you'd have to do is to 
modify the application only once and allow the admin to configure 
the features. From the documentation:

This is a snippet of code to activate task isolation if
it has been previously configured (by chisol for example)::

        #include <sys/prctl.h>
        #include <linux/types.h>

        #ifdef PR_ISOL_CFG_GET
        unsigned long long fmask;

        ret = prctl(PR_ISOL_CFG_GET, I_CFG_FEAT, 0, &fmask, 0);
        if (ret != -1 && fmask != 0) {
                ret = prctl(PR_ISOL_ACTIVATE_SET, &fmask, 0, 0, 0);
                if (ret == -1) {
                        perror("prctl PR_ISOL_ACTIVATE_SET");
                        return ret;
                }
        }
        #endif

This seemed pretty useful to me (which is possible if the features 
being discussed do not require further modifications on the part of the
application). For example, a new task isolation feature can be enabled 
without having to modify the application.

Again, maybe that was misunderstood (and i'm OK with dropping this 
and forcing both configuration and activation to be performed
inside the app), no problem.

> >> Special handling when the scheduler
> >> switches a task? If tasks are being switched that requires them to be low
> >> latency and undisturbed then something went very very wrong with the
> >> system configuration and the only thing I would suggest is to issue some
> >> kernel warning that this is not the way one should configure the system.
> >
> > Trying to provide mechanisms, not policy? 
> 
> This preemption notifier is not a mechanism, it's simply mindless
> hackery as I told you already.

Sure, if there is another way of checking "if per-CPU vmstats require
syncing" that is cheap (which seems you suggested on the other email),
can drop preempt notifiers.

