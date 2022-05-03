Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69528518F9D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 May 2022 23:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242598AbiECVF5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 May 2022 17:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbiECVFz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 May 2022 17:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 309A93F8AB
        for <linux-rdma@vger.kernel.org>; Tue,  3 May 2022 14:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651611741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QJZ1njn9uhn5ehYZFHWPGlsKmFY9KLNy3hCxWsU4cKs=;
        b=bY2xm6zMqjFh2MNUFZNEdfmdlSCi+Q+cIzqcU0aZR2257TCnDCFWPNpUAsDwp2BfvKR761
        jKa9deBdxxbUYWOBx3LXdOlxCWlJ1LvD55P5npMzUSmqm3rre5RHtTr33K+NFY+gzNrKd8
        5t2VWhFyNZZBwnJ9ywRflC1HKJ8hR4c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-y9DlPJ3aONiStQspMMXqaw-1; Tue, 03 May 2022 17:02:18 -0400
X-MC-Unique: y9DlPJ3aONiStQspMMXqaw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9B058F3FC5;
        Tue,  3 May 2022 21:02:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBF975523C8;
        Tue,  3 May 2022 21:02:15 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id B76574188590; Tue,  3 May 2022 15:57:14 -0300 (-03)
Date:   Tue, 3 May 2022 15:57:14 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
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
Message-ID: <YnF7CjzYBhASi1Eo@fuller.cnet>
References: <20220315153132.717153751@fedora.localdomain>
 <alpine.DEB.2.22.394.2204271049050.159551@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2204271049050.159551@gentwo.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 27, 2022 at 11:19:02AM +0200, Christoph Lameter wrote:
> Ok I actually have started an opensource project that may make use of the
> onshot interface. This is a bridging tool between two RDMA protocols
> called ib2roce. See https://gentwo.org/christoph/2022-bridging-rdma.pdf
> 
> The relevant code can be found at
> https://github.com/clameter/rdma-core/tree/ib2roce/ib2roce. In
> particular look at the ib2roce.c source code. This is still
> under development.
> 
> The ib2roce briding can run in a busy loop mode (-k option) where it spins
> on ibv_poll_cq() which is an RDMA call to handle incoming packets without
> kernel interaction. See busyloop() in ib2roce.c
> 
> Currently I have configured the system to use CONFIG_NOHZ_FULL. With that
> I am able to reliably forward packets at a rate that saturates 100G
> Ethernet / EDR Infiniband from a single spinning thread.
> 
> Without CONFIG_NOHZ_FULL any slight disturbance causes the forwarding to
> fall behind which will lead to dramatic packet loss since we are looking
> here at a potential data rate of 12.5Gbyte/sec and about 12.5Mbyte per
> msec. If the kernel interrupts the forwarding by say 10 msecs then we are
> falling behind by 125MB which would have to be buffered and processing by
> additional codes. That complexity makes it processing packets much slower
> which could cause the forwarding to slow down so that a recovery is not
> possible should the data continue to arrive at line rate.

Right.

> Isolation of the threads was done through the following kernel parameters:
> 
> nohz_full=8-15,24-31 rcu_nocbs=8-15,24-31 poll_spectre_v2=off
> numa_balancing=disable rcutree.kthread_prio=3 intel_pstate=disable nosmt
> 
> And systemd was configured with the following affinites:
> 
> system.conf:CPUAffinity=0-7,16-23
> 
> This means that the second socket will be generally free of tasks and
> kernel threads.
> 
> The NUMA configuration:
> 
> $ numactl --hardware
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7
> node 0 size: 94798 MB
> node 0 free: 92000 MB
> node 1 cpus: 8 9 10 11 12 13 14 15
> node 1 size: 96765 MB
> node 1 free: 96082 MB
> 
> node distances:
> node   0   1
>   0:  10  21
>   1:  21  10
> 
> 
> I could modify busyloop() in ib2roce.c to use the oneshot mode via prctl
> provided by this patch instead of the NOHZ_FULL.
> 
> What kind of metric could I be using to show the difference in idleness of
> the quality of the cpu isolation?

Interruption length and frequencies:

-------|xxxxx|---------------|xxx|---------
	 5us 		      3us

which is what should be reported by oslat ?

> 
> The ib2roce tool already has a CLI mode where one can monitor the
> latencies that the busyloop experiences. See the latency calculations in
> busyloop() and the CLI command "core". Stats can be reset via the "zap"
> command.
> 
> I can see the usefulness of the oneshot mode but (I am very very sorry) 

Its in there...

> I
> still think that this patchset overdoes what is needed and I fail to
> understand what the point of inheritance, per syscall quiescint etc is.

Inheritance is an attempt to support unmodified binaries like so:

1) configure task isolation parameters (eg sync per-CPU vmstat to global
stats on system call returns).
2) enable inheritance (so that task isolation configuration and
activation states are copied across to child processes).
3) enable task isolation.
4) execv(binary, params)

Per syscall quiescint ? Not sure what you mean here.

> Those cause needless overhead in syscall handling and increase the
> complexity of managing a busyloop. 

Inheritance seems like a useful feature to us. Isnt it? (to be able to
configure and activate task isolation for unmodified binaries).

> Special handling when the scheduler
> switches a task? If tasks are being switched that requires them to be low
> latency and undisturbed then something went very very wrong with the
> system configuration and the only thing I would suggest is to issue some
> kernel warning that this is not the way one should configure the system.

Trying to provide mechanisms, not policy? 

Or from another POV: if the user desires, we can display the warning.

