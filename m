Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684E2200474
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 10:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbgFSIwU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 04:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731467AbgFSIwM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jun 2020 04:52:12 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69845C06174E
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 01:52:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e5so6708279ote.11
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0iYzCssyK2TOwvjJibrr8lmgnan0eqOfQGCXFa8hzl0=;
        b=HvD+Ne6fK6tCSG8Ft3uKDnfSuzn6rl8X1bAjFeiWT8vLPxEZjmJncX8oPK8misPEJl
         +HrZH0ljU7LXjvI51GglxKLsrLx7GnkTO0i9JHRKNaySPY7UvFYcWLbKK6s5M2at9ofp
         O94/1+kJhIU/ih79NJR26M53HyeVdchNZ7UUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0iYzCssyK2TOwvjJibrr8lmgnan0eqOfQGCXFa8hzl0=;
        b=EjZKe0UBqjGhlxAWgsG+TVGrhtoNtjdWKpcKj1+OPuCZjIR7VLOsPrGVy8FsKrmwfz
         4esmRJx3yehvkv1qNwkXc3gLRVInPIHtvg1AJeTWcZkXjA7UXtl4VOX+eInGAvz/3ZA2
         w18APT/BYJLgkBnWXhTdIANOPmT6yMRvUfSrQ2Q5Vht7WtIpmnhQGYK5bJdtbtKda4e4
         vgW5xwF61r+RhyRpPshZ56hfaUyRnctXMZ+5uO8Tt4+s5utvLbLWDDkuXzj45cAW0Gn9
         kZ4DDl1U/PoWnSGd42VjFuO212FsflOm1LGDmgoz4Wx+cvMnhs5m/KdOAKnHhQMdPwJ6
         +PYw==
X-Gm-Message-State: AOAM530eDoFLZAW8NlYUPaBc5Sv1Zm2V/28Pg9tMPTbcqASLjlU68RzS
        OVj7Rc+D4nrwUYJGKcmFVuZLt81RHVvvWOxJte1Qmg==
X-Google-Smtp-Source: ABdhPJxybPB/cZuqnk3F2rp1schcwun27NaO2y2oNb7MhnziSDv7aRjRiagVJoh+hyyaLoyN6YBKcFhlPmqt4m4HeSs=
X-Received: by 2002:a9d:4cd:: with SMTP id 71mr2341025otm.188.1592556730628;
 Fri, 19 Jun 2020 01:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-4-daniel.vetter@ffwll.ch> <159186243606.1506.4437341616828968890@build.alporthouse.com>
 <CAPM=9ty6r1LuXAH_rf98GH0R9yN3x8xzKPjZG3QyvokpQBR-Hg@mail.gmail.com>
 <CAPj87rM0S2OPssf+WA+pjanT-0Om3yuUM1zUJCv4qTx5VYE=Fw@mail.gmail.com> <159255511144.7737.12635440776531222029@build.alporthouse.com>
In-Reply-To: <159255511144.7737.12635440776531222029@build.alporthouse.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 19 Jun 2020 10:51:59 +0200
Message-ID: <CAKMK7uHEwj6jiZkRZ5PaCUNWcuU9oE4KYm4XHZwHnFzEuChZ7w@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 03/18] dma-fence: basic lockdep annotations
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Daniel Stone <daniel@fooishbar.org>,
        Dave Airlie <airlied@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 19, 2020 at 10:25 AM Chris Wilson <chris@chris-wilson.co.uk> wr=
ote:
>
> Quoting Daniel Stone (2020-06-11 10:01:46)
> > Hi,
> >
> > On Thu, 11 Jun 2020 at 09:44, Dave Airlie <airlied@gmail.com> wrote:
> > > On Thu, 11 Jun 2020 at 18:01, Chris Wilson <chris@chris-wilson.co.uk>=
 wrote:
> > > > Introducing a global lockmap that cannot capture the rules correctl=
y,
> > >
> > > Can you document the rules all drivers should be following then,
> > > because from here it looks to get refactored every version of i915,
> > > and it would be nice if we could all aim for the same set of things
> > > roughly. We've already had enough problems with amdgpu vs i915 vs
> > > everyone else with fences, if this stops that in the future then I'd
> > > rather we have that than just some unwritten rules per driver and
> > > untestable.
> >
> > As someone who has sunk a bunch of work into explicit-fencing
> > awareness in my compositor so I can never be blocked, I'd be
> > disappointed if the infrastructure was ultimately pointless because
> > the documented fencing rules were \_o_/ or thereabouts. Lockdep
> > definitely isn't my area of expertise so I can't comment on the patch
> > per se, but having something to ensure we don't hit deadlocks sure
> > seems a lot better than nothing.
>
> This is doing dependency analysis on execution contexts which is a far
> cry from doing the fence dependency analysis, and so has to actively
> ignore the cycles that must exist on the dma side, and also the cycles
> that prevent entering execution contexts on the CPU. It has to actively
> ignore scheduler execution contexts, for lockdep cries, and so we do not
> get analysis of the locking contexts along that path. This would be
> solvable along the lines of extending lockdep ala lockdep_dma_enter().

drm/scheduler is annotated, found some rather improbably to hit issues
in practice. But from the quick chat I've had with K=C3=B6nig and others I
think he agrees that it's real at least in the theoretical sense.
Probably should consider playing lottery if you hit it in practice
though :-)

> Had i915's execution flow been marked up, it should have found the
> dubious wait for external fences inside the dead GPU recovery, and
> probably found a few more things to complain about with the reset locking=
.
> [Note we already do the same annotations for wait-vs-reset, but not
> reset-vs-execution.]

I know it splats, that's why the tdr annotation patch comes with a
spec proposal for lifting the wait busting we do in i915 to the
dma_fence level. I included that because amdgpu has the same problem
on modern hw. Apparently their planned fix (because they've hit this
bug in testing) was to push some shared lock down into their
atomic_comit_tail function and use that in gpu reset, so don't seem
that interested in extending dma_fence.

For i915 it's just gen2/3 display, and cross-driver dma-buf/fence
usage for those is nil and won't change. Pragmatic solution imo would
be to just not annotate gpu reset on these platforms, and relying on
our wait busting plus igt tests to make sure it keeps working as-is.
The point of the explicit annotations for the signalling side is very
much that it can be rolled out gradually, and entirely left out for
old legacy paths that aren't worth fixing.

> Determination of which waits are legal and which are not is entirely ad
> hoc, for there is no status change tracking in the dependency analysis
> [that is once an execution context is linked to a published fence, again
> integral to lockdep.] Consider if the completion chain in atomic is
> swapped out for the morally equivalent fences along intertwined timelines=
,
> and so it does a bunch of dma_fence_wait() instead. Why are those waits
> legal despite them being after we have committed to fulfilling the out
> fence? [Why are the waits on and for the GPU legal, since they equally
> block execution flow?]

No need to consider, it's already real and resulted in some pretty
splats until I got the recursion handling right.

> Forcing a generic primitive to always be part of the same global map is
> horrible. You forgo being able to use the primitive for unrelated tasks,
> lose the ability to name particular contexts to gain more informative
> dependency cycle reports from having the explicit linkage. You can add
> wait_map tracking without loss of generality [in less than 10 lines],
> and you can still enforce that all fences used for a common purpose
> follow the same rules [the simplest way being to default to the singular
> wait_map]. But it's the explicitly named execution contexts that are the
> biggest boon to reading the code and reading the lockdep warns.

So one thing that's maybe not clear here: This doesn't track the DAG
of dependencies. Doesn't even try, I'm still faithfully assuming
drivers get that part right. Which is a gap and maybe we should fix
this, but not the goal here.

All this does is validate fences against anything else that might be
going on in the system. E.g. your recursion example for atomic is
handled by just assuming that any dma_fence_wait within a signalling
section is legit and correct. We can add this later on, but not with
lockdep, since lockdep works with classes. And proofing that
dma_fences are acyclic requires you track them all as individuals.
Entirely different things.

That still leaves the below:

> Forcing a generic primitive to always be part of the same global map is
> horrible.

And  no concrete example or reason for why that's not possible.
Because frankly it's not horrible, this is what upstream is all about:
Shared concepts, shared contracts, shared code.

The proposed patches might very well encode the wrong contract, that's
all up for discussion. But fundamentally questioning that we need one
is missing what upstream is all about.

> This is a bunch of ad hoc tracking for a very narrow purpose applied
> globally, with loss of information.

It doesn't solve every problem indeed. I'm happy to review patches to
check acyclic-ness of dma-fence at the global level from you, I
haven't figured out yet how to make that happen. I know i915-gem has
that, but this is about the cross-driver contract here.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
