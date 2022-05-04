Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC4B51AEDA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 May 2022 22:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiEDUTK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 16:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377953AbiEDUSz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 16:18:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BB662FB;
        Wed,  4 May 2022 13:15:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651695314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2oJD7k+4DnOtUc+hYYmeV/3FEHnovMfe+24BdevlrYw=;
        b=ESY3+67uixkgq/KnTmlbfh/J1esj5LQdSZff0zyIDPvxmM6KQcWk26aEmRWKHmLLWFurHQ
        a5jUnBetFH+EW1367CNQoH+OSRAiVtzbTpfKIoKjBegg5eDD41Ytux9Ne2C4glXX1lWC6Q
        JT6Ucq3++D0XX/AVNFoZA2NsjBq4Qs9+fk7EqgfgEC84QKUTjWV8/pzJEWjwA6vZAMMegI
        6TO4CQZGYW1g07XBCFkEdX4YoAcdlMgxNgQH4qw5ZQOQZcVL7mwFmzYBslK12slf+cmmqH
        mCaSyJttDTbQMmzawol2JsQDZnRzNWQZXTjxOLxtnUIhtJiKRtrXWRlOPnLAFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651695315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2oJD7k+4DnOtUc+hYYmeV/3FEHnovMfe+24BdevlrYw=;
        b=z7V/iS1I/z0AcRhPiegimDhqSc9oxg7BG2knHRxNmH83LE8hyYBQpG6IbzvBjXno08JE75
        xn7/LaaLV0qUHqBg==
To:     Marcelo Tosatti <mtosatti@redhat.com>
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
In-Reply-To: <YnLMc5X8MZElk0NT@fuller.cnet>
References: <20220315153132.717153751@fedora.localdomain>
 <alpine.DEB.2.22.394.2204271049050.159551@gentwo.de>
 <YnF7CjzYBhASi1Eo@fuller.cnet> <87h765juyk.ffs@tglx>
 <YnLMc5X8MZElk0NT@fuller.cnet>
Date:   Wed, 04 May 2022 22:15:14 +0200
Message-ID: <871qx9jbql.ffs@tglx>
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

On Wed, May 04 2022 at 15:56, Marcelo Tosatti wrote:
> On Wed, May 04, 2022 at 03:20:03PM +0200, Thomas Gleixner wrote:
>> Can we please focus on the initial problem of
>> providing a sensible isolation mechanism with well defined semantics?
>
> Case 2, however, was implicitly suggested by you (or at least i
> understood that):
>
> "Summary: The problem to be solved cannot be restricted to
>
>     self_defined_important_task(OWN_WORLD);
>
> Policy is not a binary on/off problem. It's manifold across all levels
> of the stack and only a kernel problem when it comes down to the last
> line of defence.
>
> Up to the point where the kernel puts the line of last defence, policy
> is defined by the user/admin via mechanims provided by the kernel.
>
> Emphasis on "mechanims provided by the kernel", aka. user API.
>
> Just in case, I hope that I don't have to explain what level of scrunity
> and thought this requires."

Correct. This reasoning is still valid and I haven't changed my opinion
on that since then.

My main objections against the proposed solution back then were the all
or nothing approach and the implicit hard coded policies.

> The idea, as i understood was that certain task isolation features (or
> they parameters) might have to be changed at runtime (which depends on
> the task isolation features themselves, and the plan is to create
> an extensible interface).

Again. I'm not against useful controls to select the isolation an
application requires. I'm neither against extensible interfaces.

But I'm against overengineered implementations which lack any form of
sensible design and have ill defined semantics at the user ABI.

Designing user space ABI is _hard_ and needs a lot of thoughts. It's not
done with throwing something 'extensible' at the kernel and hope it
sticks. As I showed you in the review, the ABI is inconsistent in
itself, it has ill defined semantics and lacks any form of justification
of the approach taken.

Can we please take a step back and:

  1) Define what is trying to be solved and what are the pieces known
     today which need to be controlled in order to achieve the desired
     isolation properties.

  2) Describe the usage scenarios and the resulting constraints.

  3) Describe the requirements for features on top, e.g. inheritance
     or external control.

Once we have that, we can have a discussion about the desired control
granularity and how to support the extra features in a consistent and
well defined way.

A good and extensible UABI design comes with well defined functionality
for the start and an obvious and maintainable extension path. The most
important part is the well defined functionality.

There have been enough examples in the past how well received approaches
are, which lack the well defined part. Linus really loves to get a pull
request for something which cannot be described what it does, but could
be used for cool things in the future.

> So for case 2, all you'd have to do is to modify the application only
> once and allow the admin to configure the features.

That's still an orthogonal problem, which can be solved once a sensible
mechanism to control the isolation and handle it at the transition
points is in place. You surely want to consider it when designing the
UABI, but it's not required to create the real isolation mechanism in
the first place.

Problem decomposition is not an entirely new concept, really.

Thanks,

        tglx
