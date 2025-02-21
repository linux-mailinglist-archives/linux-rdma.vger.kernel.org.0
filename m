Return-Path: <linux-rdma+bounces-7984-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06761A3FD9E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 18:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5065F1884B5A
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0882505D3;
	Fri, 21 Feb 2025 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDEZD8xJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21A2505C9
	for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159579; cv=none; b=EZ6vUh/rSnVIYy451t5GoBR9r2SsXviTytR+KGHks5ug9Nm8D+XggZArNPGCia7c2zC8NvQaI3rh2JWxQIoSPtXacpQa8q6dTwwhq5ZegWdv2P0fDkpd0ew5dGe5EIktdy6WVIk1q4EZe3G2h37hhwOmDzoovhldEUyBBfM/YKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159579; c=relaxed/simple;
	bh=S9EfaOz8ajYeTC6wo7NzaFHe+2g3pQvha7KawOjuMl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEWwz5+NT40oc/DnUtORsi9+SjEMwi5XT8lh9IjgJd8+97crhWbN1v4V1a3hakp4exgBN+EU4AN+9H3VR4JHJJrHnmo5CDnUHVTFKLcbisi4/gOiO+LhPnIZi87vQ+j+OdwyAGOpY+L0PwJhnBmlRZBoUcs4AF/8GRvlPgjWoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VDEZD8xJ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3078fb1fa28so19654051fa.3
        for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 09:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740159576; x=1740764376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9EfaOz8ajYeTC6wo7NzaFHe+2g3pQvha7KawOjuMl8=;
        b=VDEZD8xJfh0z8zd+LM4hj/X4DpVI8cCQx5hyHpt0vvhs/VnvGcEnoFrQYOTSTjDDIw
         flkYJTzat3Ldgih5uj2Sregt4RgcEvfPnD2tdkWpsAH3Lh8YbuaLjw6szmce8D85NBqI
         Ez1ZwzwCwuhYzr2mkfRRAWLCdgnVgzWj5SIxCH5e6J9pcyYpAJHwVWkQ+lBeznFCbd/O
         bKZQiix6NgL/dy8oTJoF4r30dyj2w/yC/m9Ypa/nv/4xbs0DXA3Tz5nSO60S2h3gV/Iw
         g7zSukfTqKbwk70OfwzlQfBEvAZq6fSqM0wScFzEdrzCltQHmnV8M2vhQt8HCoRUVj67
         4DqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740159576; x=1740764376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9EfaOz8ajYeTC6wo7NzaFHe+2g3pQvha7KawOjuMl8=;
        b=ffvuVoUI0r5hSQP7BY58PqsT3C+5B7GTZPLNHT/s0EZAv1zeaQg4ZN4+Ao8Mhyk0nO
         XBc/W+fgfnd2FyoYH70LgmW5nIwOAu2r72wuUWkfwjazskFuUiGC450UaFL3ulX+Rs1G
         edq5cusr0dE6ylXKGWuClqoqGH0UkX732bInQXpdEN+hAhBpXMNF38/4dWEndz7vQ4yt
         6x/Au2czp9gpH7C7Gb//cZ4eb5xeLnEhaHfoZgpNp9eamoqXd+NiOaaYnMHw6PDkjCCr
         mqK4yY43uyAKPVMbTp1MaPRSeR16R0KFKxBoOtE7R5VO2BgCTmnTI4ZkRytIJ8SrBsWR
         zQWA==
X-Forwarded-Encrypted: i=1; AJvYcCWGcksmdzDjequr/8Q3FLfCAvwauLC+2mJxEjjDLzZJ1KUK3/U04FBLU8+cYYIqDB2PMVB523okH6ig@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8IRvmndAujtO7eegv4DG6gBgCob/VgMrs3j3YMF1vp/vdQ/gE
	K1EuaHE7gFzuT7w+S/LF7Ntv9HNeg8HrZVJC8R1aaBkCKchzIS1l9lIGSzzUi4gXXyWs5ZYT1tw
	3jaiBOnU/tS8R1QxjkZy/O9LPS+9Ij8It2D7+
X-Gm-Gg: ASbGncuNkvDB8HGssfap+2b58aVcGKV9qHNX10zKOC4E1RRvWNJPVMdRgGOwDuqJzI9
	yy4Ur9KRh/ClYHvgK5goqLXke2FUUt1Dy7be9wlABeP2eJs7Jh/roiAmbV/bRui+1fr819YFhBw
	LKH0wh3w5W
X-Google-Smtp-Source: AGHT+IF5exVKCteGowY5sb1hUfHze8lNd8Ud4KRXiymiqA4mamJWkMR709W9194vNhvBZmCvDASRqDhboopAfRYyZBA=
X-Received: by 2002:a05:6512:1241:b0:547:6723:93b6 with SMTP id
 2adb3069b0e04-5483909d1d1mr1547834e87.0.1740159575591; Fri, 21 Feb 2025
 09:39:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220175612.2763122-1-jmoroni@google.com> <838a95a2-f286-4f94-8667-2da8ba330c47@linux.dev>
 <CANn89iKSUZxfCm9rqEykZtzEAsu1F0dpooh1iih_RwRMHjpGNg@mail.gmail.com>
In-Reply-To: <CANn89iKSUZxfCm9rqEykZtzEAsu1F0dpooh1iih_RwRMHjpGNg@mail.gmail.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Fri, 21 Feb 2025 12:39:24 -0500
X-Gm-Features: AWEUYZlnz1TMNEe7cfLoI-bUMPn7OuByth9exfGGSRRO3IlEHjTqDNjePQnXJpk
Message-ID: <CAHYDg1Sr8WM3cY8Sjx554OtoFx6k_AX5a68KKFX9stzLx9q0FA@mail.gmail.com>
Subject: Re: [PATCH] IB/cm: use rwlock for MAD agent lock
To: Eric Dumazet <edumazet@google.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org, 
	markzhang@nvidia.com, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> If you are running at such a high workload then I'm shocked you don't
> hit all the other nasty problems with RDMA CM scalability?

It could be that we just haven't hit those issues yet :)

This serialization was slowing things down so much that I think it
has been masking some other issues. For instance, I just discovered
a bug in rping's persistent server mode (I'll be sending a Github PR
soon), which seems to be due to a race condition we started hitting
after this fix.

> Is the issue that the AH creation is very slow for some reason? It has
> been a longstanding peeve of mine that this is done under a spinlock
> context, I've long felt that should be reworked and some of those
> spinlocks converted to mutex's.

Yes, that's exactly it. We have fairly high tail latencies for creating
address handles. By removing the serialization, we can at least take
advantage of queueing, which seems to help a lot. It would be really
great if this could move out of an atomic context.

Thanks,
Jake

On Fri, Feb 21, 2025 at 12:32=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, Feb 21, 2025 at 6:04=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev>=
 wrote:
> >
> > On 20.02.25 18:56, Jacob Moroni wrote:
> > > In workloads where there are many processes establishing
> > > connections using RDMA CM in parallel (large scale MPI),
> > > there can be heavy contention for mad_agent_lock in
> > > cm_alloc_msg.
> > >
> > > This contention can occur while inside of a spin_lock_irq
> > > region, leading to interrupts being disabled for extended
> > > durations on many cores. Furthermore, it leads to the
> > > serialization of rdma_create_ah calls, which has negative
> > > performance impacts for NICs which are capable of processing
> > > multiple address handle creations in parallel.
> >
> > In the link:
> > https://www.cs.columbia.edu/~jae/4118-LAST/L12-interrupt-spinlock.html
> > "
> > ...
> > spin_lock() / spin_unlock()
> >
> > must not lose CPU while holding a spin lock, other threads will wait fo=
r
> > the lock for a long time
> >
> > spin_lock() prevents kernel preemption by ++preempt_count in
> > uniprocessor, that=E2=80=99s all spin_lock() does
> >
> > must NOT call any function that can potentially sleep
> > ex) kmalloc, copy_from_user
> >
> > hardware interrupt is ok unless the interrupt handler may try to lock
> > this spin lock
> > spin lock not recursive: same thread locking twice will deadlock
> >
> > keep the critical section as small as possible
> > ...
> > "
> > And from the source code, it seems that spin_lock/spin_unlock are not
> > related with interrupts.
> >
> > I wonder why "leading to interrupts being disabled for extended
> > durations on many cores" with spin_lock/spin_unlock?
> >
> > I am not against this commit. I am just obvious why
> > spin_lock/spin_unlock are related with "interrupts being disabled".
>
> Look at drivers/infiniband/core/cm.c
>
> spin_lock_irqsave(&cm_id_priv->lock, flags);
>
> -> Then call cm_alloc_msg() while hard IRQ are masked.

