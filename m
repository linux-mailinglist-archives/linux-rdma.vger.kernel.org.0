Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6517F53AAD4
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jun 2022 18:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356040AbiFAQOi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jun 2022 12:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355340AbiFAQOh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Jun 2022 12:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F73141F95
        for <linux-rdma@vger.kernel.org>; Wed,  1 Jun 2022 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654100074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S7vUljB4Qlutv3sDYkD8hCAq5iyvO6STavGpYOs/65s=;
        b=Lw254GP5nfsuJCD3u/9jnsF8FvQtdMT2oRQE8Ujb5jUwfhBYjVPAY8XpKQCz0TiWX0vba0
        ShhodidVGaJF48sucebpjeORLgOgZ842s2YUfZ1OwiUASukirWtwKznGJNRGWN4QBn9XjM
        X8ppatlcO3Rpx9rnIoMDBNjr/iZun18=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-VcQTElugMnidnE_a3jK_-A-1; Wed, 01 Jun 2022 12:14:31 -0400
X-MC-Unique: VcQTElugMnidnE_a3jK_-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C84161C0CE78;
        Wed,  1 Jun 2022 16:14:29 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DAFC3323E;
        Wed,  1 Jun 2022 16:14:27 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 333E2417F27B; Wed,  1 Jun 2022 13:14:08 -0300 (-03)
Date:   Wed, 1 Jun 2022 13:14:08 -0300
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
Message-ID: <YpeQUGo/xJw6WTjK@fuller.cnet>
References: <20220315153132.717153751@fedora.localdomain>
 <alpine.DEB.2.22.394.2204271049050.159551@gentwo.de>
 <YnF7CjzYBhASi1Eo@fuller.cnet>
 <87h765juyk.ffs@tglx>
 <YnLMc5X8MZElk0NT@fuller.cnet>
 <871qx9jbql.ffs@tglx>
 <YnQA0xME3DwL2+ue@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnQA0xME3DwL2+ue@fuller.cnet>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 05, 2022 at 01:52:35PM -0300, Marcelo Tosatti wrote:
> 
> Hi Thomas,
> 
> On Wed, May 04, 2022 at 10:15:14PM +0200, Thomas Gleixner wrote:
> > On Wed, May 04 2022 at 15:56, Marcelo Tosatti wrote:
> > > On Wed, May 04, 2022 at 03:20:03PM +0200, Thomas Gleixner wrote:
> > >> Can we please focus on the initial problem of
> > >> providing a sensible isolation mechanism with well defined semantics?
> > >
> > > Case 2, however, was implicitly suggested by you (or at least i
> > > understood that):
> > >
> > > "Summary: The problem to be solved cannot be restricted to
> > >
> > >     self_defined_important_task(OWN_WORLD);
> > >
> > > Policy is not a binary on/off problem. It's manifold across all levels
> > > of the stack and only a kernel problem when it comes down to the last
> > > line of defence.
> > >
> > > Up to the point where the kernel puts the line of last defence, policy
> > > is defined by the user/admin via mechanims provided by the kernel.
> > >
> > > Emphasis on "mechanims provided by the kernel", aka. user API.
> > >
> > > Just in case, I hope that I don't have to explain what level of scrunity
> > > and thought this requires."
> > 
> > Correct. This reasoning is still valid and I haven't changed my opinion
> > on that since then.
> > 
> > My main objections against the proposed solution back then were the all
> > or nothing approach and the implicit hard coded policies.
> > 
> > > The idea, as i understood was that certain task isolation features (or
> > > they parameters) might have to be changed at runtime (which depends on
> > > the task isolation features themselves, and the plan is to create
> > > an extensible interface).
> > 
> > Again. I'm not against useful controls to select the isolation an
> > application requires. I'm neither against extensible interfaces.
> > 
> > But I'm against overengineered implementations which lack any form of
> > sensible design and have ill defined semantics at the user ABI.
> > 
> > Designing user space ABI is _hard_ and needs a lot of thoughts. It's not
> > done with throwing something 'extensible' at the kernel and hope it
> > sticks. As I showed you in the review, the ABI is inconsistent in
> > itself, it has ill defined semantics and lacks any form of justification
> > of the approach taken.
> > 
> > Can we please take a step back and:
> > 
> >   1) Define what is trying to be solved
> 
> Avoid interruptions to application code execution on isolated CPUs.
> 
> Different use-cases might accept different length/frequencies
> of interruptions (including no interruptions).
> 
> >      and what are the pieces known
> >      today which need to be controlled in order to achieve the desired
> >      isolation properties.
> 
> I hope you don't mean the current CPU isolation features which have to
> be enabled, but only the ones which are not enabled today:
> 
> "Isolation of the threads was done through the following kernel parameters:
> 
> nohz_full=8-15,24-31 rcu_nocbs=8-15,24-31 poll_spectre_v2=off
> numa_balancing=disable rcutree.kthread_prio=3 intel_pstate=disable nosmt
> 
> And systemd was configured with the following affinites:
> 
> system.conf:CPUAffinity=0-7,16-23
> 
> This means that the second socket will be generally free of tasks and   
> kernel threads."
> 
> So here are some features which could be written on top of the proposed
> task isolation via prctl:
> 
> 1) 
> 
> Enable or disable the following optional behaviour
> 
> A.
> if (cpu->isolated_avoid_queue_work)
> 	return -EBUSY;
> 
> queue_work_on(cpu, workfn);
> 
> (for the functions that can handle errors gracefully).
> 
> B.
> if (cpu->isolated_avoid_function_ipi)
> 	return -EBUSY;
> 
> smp_call_function_single(cpu, fn);
> (for the functions that can handle errors gracefully).
> Those that can't handle errors gracefully should be changed 
> to either handle errors or to remote work.
> 
> Not certain if this should be on per-case basis: say
> "avoid action1|avoid action2|avoid action3|..." (bit per
> action) and a "ALL" control, where actionZ is an action
> that triggers an IPI or remote work (then you would check
> for whether to fail not at smp_call_function_single 
> time but before the action starts).
> 
> Also, one might use something such as stalld (that schedules 
> tasks in/out for a short amount of time every given time window),
> which might be acceptable for his workload, so he'd disable
> cpu->isolated_avoid_queue_work (or expose this on per-case basis,
> unsure which is better).
> 
> As for IPIs, whether to block a function call to an isolated
> CPU depends on whether that function call (and its frequency) 
> will cause the latency sensitive application to violate its "latency" 
> requirements.
> 
> Perhaps "ALL - action1, action2, action3" is useful.
> 
> =======================================
> 
> 2)
> 
> In general, avoiding (or uncaching on return to userspace) 
> a CPU from caching per-CPU data (which might require an 
> IPI to invalidate later on) (see point [1] below for more thoughts
> on this issue).
> 
> 
> For example, for KVM:
> 
> /*
>  * MMU notifier 'invalidate_range_start' hook.
>  */
> void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
>                                        unsigned long end, bool may_block)
> {
>         DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
>         struct gfn_to_pfn_cache *gpc;
>         bool wake_vcpus = false;
> 	...
> 	called = kvm_make_vcpus_request_mask(kvm, req, vcpu_bitmap);
> 
> 	which will
> 	smp_call_function_many(cpus, ack_flush, NULL, wait);
> ...
> 
> 
> ====================================================
> 
> 3) Enabling a kernel warning when a task switch happens on a CPU
> which runs a task isolated thread?
> 
> From Christoph:
> 
> Special handling when the scheduler
> switches a task? If tasks are being switched that requires them to be low
> latency and undisturbed then something went very very wrong with the
> system configuration and the only thing I would suggest is to issue some
> kernel warning that this is not the way one should configure the system.
> 
> ====================================================
> 
> 4) Sending a signal whenever an application is interrupted
> (hum, this could be done via BPF).
> 
> Those are the ones i can think of at the moment. 
> Not sure what other people can think of.
> 
> >   2) Describe the usage scenarios and the resulting constraints.
> 
> Well the constraints should be in the form
> 
> 	"In a given window of time, there should be no more than N
> 	 CPU interruptions of length L each."
> 
> 	(should be more complicated due to cache effects, but choosing
> 	 a lower N and L one is able to correct that)
> 
> I believe?
> 
> Also some memory bandwidth must be available to the application
> (or data/code in shared caches).
> Which depends on what other CPUs in the system are doing, the
> cache hierarchy, the application, etc.
> 
> [1]: There is also a question of whether to focus only on 
> applications that do not perform system calls on their latency 
> sensitive path, and applications that perform system calls. 
> 
> Because some CPU interruptions can't be avoided if the application 
> is in the kernel: for example instruction cache flushes due to 
> static_key rewrites or kernel TLB flushes (well they could be avoided 
> with more infrastructure, but there is no such infrastructure at
> the moment).
> 
> >   3) Describe the requirements for features on top, e.g. inheritance
> >      or external control.
> 
> 1) Be able to use unmodified applications (as long as the features
> to be enabled are compatible with such usage, for example "killing 
> / sending signal to application if task is interrupted" is obviously
> incompatible with unmodified applications).
> 
> 2) External control: be able to modify what task isolation features are
> enabled externally (not within the application itself). The latency
> sensitive application should inform the kernel the beginning of 
> the latency sensitive section (at this time, the task isolation 
> features configured externally will be activated).
> 
> 3) One-shot mode: be able to quiesce certain kernel activities
> only on the first time a syscall is made (because the overhead
> of subsequent quiescing, for the subsequent system calls, is
> undesired).
> 
> > Once we have that, we can have a discussion about the desired control
> > granularity and how to support the extra features in a consistent and
> > well defined way.
> > 
> > A good and extensible UABI design comes with well defined functionality
> > for the start and an obvious and maintainable extension path. The most
> > important part is the well defined functionality.
> > 
> > There have been enough examples in the past how well received approaches
> > are, which lack the well defined part. Linus really loves to get a pull
> > request for something which cannot be described what it does, but could
> > be used for cool things in the future.
> > 
> > > So for case 2, all you'd have to do is to modify the application only
> > > once and allow the admin to configure the features.
> > 
> > That's still an orthogonal problem, which can be solved once a sensible
> > mechanism to control the isolation and handle it at the transition
> > points is in place. You surely want to consider it when designing the
> > UABI, but it's not required to create the real isolation mechanism in
> > the first place.
> 
> Ok, can drop all of that for smaller patches with the handling 
> of transition points only (then later add oneshot mode, inheritance,
> external control).
> 
> But might wait for discussion of requirements that you raise 
> first.
> 
> > Problem decomposition is not an entirely new concept, really.
> 
> Sure, thanks.

Actually, hope that the patches from Aaron:

[RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when the idle tick was stopped too

https://lore.kernel.org/all/alpine.DEB.2.22.394.2204250919400.2367@gentwo.de/T/

Can enable syncing of vmstat on return to userspace, for nohz_full CPUs.

Then the remaining items such as 

> if (cpu->isolated_avoid_queue_work)
>       return -EBUSY;

Can be enabled with a different (more flexible) interface such as writes
to filesystem (or task attribute that is transferred to per-CPU variable
on task initialization and remove from per-CPU variables when task
dies)


