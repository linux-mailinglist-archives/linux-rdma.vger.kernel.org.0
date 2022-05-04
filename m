Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A6451A0C6
	for <lists+linux-rdma@lfdr.de>; Wed,  4 May 2022 15:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350697AbiEDNY7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 09:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350532AbiEDNYk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 09:24:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8F841339;
        Wed,  4 May 2022 06:20:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651670403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QrZdXSiMuCobYvYSpsrOQ7STvgiRilriNe6RKeWUt1A=;
        b=0gERZxvgUmEb2yLnoczRMdHSKmOhphnWGgVmH2y7JNgmMuOPX8POrOioAV4RZc1seuqVV2
        tcbOqswbmMLhVLnJNCHUZzwFeEAtfExlbt9KjoBcA5RBvyWR0g3VInUea3O3qaeChQeHNt
        qmH/hn94pzwew6tbi8qF3L8axaXlrwBiHuPDLwjUtb+5P47expQbOyQ2Zfe6RnpCjU9DTI
        6nc1j16YhkdLYg6r8oEYduudDP8RBJUNNVc9WbO8eU16ADAIo3SHIwa7ekCltS+WBPsuSZ
        VznAYxxAsb2RMnllZDpJp4xfQ6e/Hx7Ox8WG3dQCJ56xP5mTboVvHOYND1dpFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651670403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QrZdXSiMuCobYvYSpsrOQ7STvgiRilriNe6RKeWUt1A=;
        b=WfCTZqDwmX6SIcf/TVUfvjWKsChb735lpRJuJ7kNUr0IDUVy/WS8OP8VME/zq0MLg5UfJb
        RdFxX1xkmtBg8eBw==
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Christoph Lameter <cl@gentwo.de>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
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
In-Reply-To: <YnF7CjzYBhASi1Eo@fuller.cnet>
References: <20220315153132.717153751@fedora.localdomain>
 <alpine.DEB.2.22.394.2204271049050.159551@gentwo.de>
 <YnF7CjzYBhASi1Eo@fuller.cnet>
Date:   Wed, 04 May 2022 15:20:03 +0200
Message-ID: <87h765juyk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 03 2022 at 15:57, Marcelo Tosatti wrote:
> On Wed, Apr 27, 2022 at 11:19:02AM +0200, Christoph Lameter wrote:
>> I could modify busyloop() in ib2roce.c to use the oneshot mode via prctl
>> provided by this patch instead of the NOHZ_FULL.
>> 
>> What kind of metric could I be using to show the difference in idleness of
>> the quality of the cpu isolation?
>
> Interruption length and frequencies:
>
> -------|xxxxx|---------------|xxx|---------
> 	 5us 		      3us
>
> which is what should be reported by oslat ?

How is oslat helpful there? That's running artifical workload benchmarks
which are not necessarily representing the actual
idle->interrupt->idle... timing sequence of the real world usecase.

> Inheritance is an attempt to support unmodified binaries like so:
>
> 1) configure task isolation parameters (eg sync per-CPU vmstat to global
> stats on system call returns).
> 2) enable inheritance (so that task isolation configuration and
> activation states are copied across to child processes).
> 3) enable task isolation.
> 4) execv(binary, params)

What for? If an application has isolation requirements, then the
specific requirements are part of the application design and not of some
arbitrary wrapper. Can we please focus on the initial problem of
providing a sensible isolation mechanism with well defined semantics?

Inheritance is an orthogonal problem and there is no reason to have this
initially.

>> Special handling when the scheduler
>> switches a task? If tasks are being switched that requires them to be low
>> latency and undisturbed then something went very very wrong with the
>> system configuration and the only thing I would suggest is to issue some
>> kernel warning that this is not the way one should configure the system.
>
> Trying to provide mechanisms, not policy? 

This preemption notifier is not a mechanism, it's simply mindless
hackery as I told you already.

Thanks,

        tglx
