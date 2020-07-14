Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91DE21F87B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 19:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgGNRqu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 13:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgGNRqu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 13:46:50 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE9BC061794
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 10:46:49 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id rk21so23471405ejb.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jlekstrand-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NB5nytNOxsJJioGL1Jixv5ej+NnEMHWRKbTcnkeqcug=;
        b=bSqLibnaW/T58mL9feuhhYVqPsWXPihE0fwbIoqc39uqy6e+2BiUPZkGhVblD9R7Au
         akO6EH8cfrhK7Yf9kbjdwsNm/6+fhjEZ3TpbUP5BDyMVe2hVLNAK+Py5VsTtpjhiRqXo
         ghR+N/exkc4TPT4gAJesMOByGNpGxPZIDqXuQtW22DePJpZrEUFaDJWQNwfKaTT1ZgpI
         kyFzzeT1Vdif9Pe+iniC0KvvcPEJ8tLHRT3UovOz0N1Lfoe1dkguuagsdB3lgAtjM0cO
         SOxzOeMDOR+S7GSg8nxtewQSGNLBtatjVg9+jrdz2gjSMDz1GJxtFthbxYF5QEAXZJJS
         fZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NB5nytNOxsJJioGL1Jixv5ej+NnEMHWRKbTcnkeqcug=;
        b=FOB07j6+TUeRC/YVSUqOCzQs0K179Pmn8Q1eANQf5IusARrf8I605pGx7bLAl5xtAC
         QXVGzdcrilnP2GQcj1Ya5IB4L7w9VyVvawWFY/FNEjcQr3jVwCglnCCjLl7MTQ09W680
         sfQKzQjSdZc2sbBcthfvSWtrZjjJanHeEeRbj6ZwzHWKXbBSbMHA7upkzsFUXm5b36Si
         MvyJyVNuZTiC9mJqXpLYiU9DmnMIjDwWAttUt4WBpHvgigZ8jwcNeJ6H+vt0pNK2xasH
         MfeDGydYZJOgmwh5LMXxtloxUSEwl+2IUt3xWm3Jdht4CDM6EMcw/3orgrTkIVemgq2a
         JoAQ==
X-Gm-Message-State: AOAM5311qhOvSrg0rvYi00OG2oXzejnY+XM18kof3QbAG34Jxu7BLTP/
        aIFW8VxoKkLC7QYBzSkZeytX/xuNNKFIWmzxOsivEg==
X-Google-Smtp-Source: ABdhPJx0c4bCwqzJhlZQg26rtFZ2ogbu3hjGv1Go+aM7VrNiOmfc9AqYjZOFezTtwnrBkWcWaFJT4975ZoMq1Diy5+w=
X-Received: by 2002:a17:906:26c3:: with SMTP id u3mr5380567ejc.483.1594748808337;
 Tue, 14 Jul 2020 10:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch> <20200709123339.547390-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20200709123339.547390-1-daniel.vetter@ffwll.ch>
From:   Jason Ekstrand <jason@jlekstrand.net>
Date:   Tue, 14 Jul 2020 12:46:37 -0500
Message-ID: <CAOFGe95aevRvreikoUPksZ83GskdOzuzVMkyKmbQPNiHzbjjhg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dma-buf.rst: Document why indefinite fences are a bad idea
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        Jesse Natalie <jenatali@microsoft.com>,
        Steve Pronovost <spronovo@microsoft.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, linaro-mm-sig@lists.linaro.org,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This matches my understanding for what it's worth.  In my little bit
of synchronization work in drm, I've gone out of my way to ensure we
can maintain this constraint.

Acked-by: Jason Ekstrand <jason@jlekstrand.net>

On Thu, Jul 9, 2020 at 7:33 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote=
:
>
> Comes up every few years, gets somewhat tedious to discuss, let's
> write this down once and for all.
>
> What I'm not sure about is whether the text should be more explicit in
> flat out mandating the amdkfd eviction fences for long running compute
> workloads or workloads where userspace fencing is allowed.
>
> v2: Now with dot graph!
>
> v3: Typo (Dave Airlie)
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Acked-by: Daniel Stone <daniels@collabora.com>
> Cc: Jesse Natalie <jenatali@microsoft.com>
> Cc: Steve Pronovost <spronovo@microsoft.com>
> Cc: Jason Ekstrand <jason@jlekstrand.net>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Mika Kuoppala <mika.kuoppala@intel.com>
> Cc: Thomas Hellstrom <thomas.hellstrom@intel.com>
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-rdma@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  Documentation/driver-api/dma-buf.rst | 70 ++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-=
api/dma-buf.rst
> index f8f6decde359..100bfd227265 100644
> --- a/Documentation/driver-api/dma-buf.rst
> +++ b/Documentation/driver-api/dma-buf.rst
> @@ -178,3 +178,73 @@ DMA Fence uABI/Sync File
>  .. kernel-doc:: include/linux/sync_file.h
>     :internal:
>
> +Indefinite DMA Fences
> +~~~~~~~~~~~~~~~~~~~~
> +
> +At various times &dma_fence with an indefinite time until dma_fence_wait=
()
> +finishes have been proposed. Examples include:
> +
> +* Future fences, used in HWC1 to signal when a buffer isn't used by the =
display
> +  any longer, and created with the screen update that makes the buffer v=
isible.
> +  The time this fence completes is entirely under userspace's control.
> +
> +* Proxy fences, proposed to handle &drm_syncobj for which the fence has =
not yet
> +  been set. Used to asynchronously delay command submission.
> +
> +* Userspace fences or gpu futexes, fine-grained locking within a command=
 buffer
> +  that userspace uses for synchronization across engines or with the CPU=
, which
> +  are then imported as a DMA fence for integration into existing winsys
> +  protocols.
> +
> +* Long-running compute command buffers, while still using traditional en=
d of
> +  batch DMA fences for memory management instead of context preemption D=
MA
> +  fences which get reattached when the compute job is rescheduled.
> +
> +Common to all these schemes is that userspace controls the dependencies =
of these
> +fences and controls when they fire. Mixing indefinite fences with normal
> +in-kernel DMA fences does not work, even when a fallback timeout is incl=
uded to
> +protect against malicious userspace:
> +
> +* Only the kernel knows about all DMA fence dependencies, userspace is n=
ot aware
> +  of dependencies injected due to memory management or scheduler decisio=
ns.
> +
> +* Only userspace knows about all dependencies in indefinite fences and w=
hen
> +  exactly they will complete, the kernel has no visibility.
> +
> +Furthermore the kernel has to be able to hold up userspace command submi=
ssion
> +for memory management needs, which means we must support indefinite fenc=
es being
> +dependent upon DMA fences. If the kernel also support indefinite fences =
in the
> +kernel like a DMA fence, like any of the above proposal would, there is =
the
> +potential for deadlocks.
> +
> +.. kernel-render:: DOT
> +   :alt: Indefinite Fencing Dependency Cycle
> +   :caption: Indefinite Fencing Dependency Cycle
> +
> +   digraph "Fencing Cycle" {
> +      node [shape=3Dbox bgcolor=3Dgrey style=3Dfilled]
> +      kernel [label=3D"Kernel DMA Fences"]
> +      userspace [label=3D"userspace controlled fences"]
> +      kernel -> userspace [label=3D"memory management"]
> +      userspace -> kernel [label=3D"Future fence, fence proxy, ..."]
> +
> +      { rank=3Dsame; kernel userspace }
> +   }
> +
> +This means that the kernel might accidentally create deadlocks
> +through memory management dependencies which userspace is unaware of, wh=
ich
> +randomly hangs workloads until the timeout kicks in. Workloads, which fr=
om
> +userspace's perspective, do not contain a deadlock.  In such a mixed fen=
cing
> +architecture there is no single entity with knowledge of all dependencie=
s.
> +Thefore preventing such deadlocks from within the kernel is not possible=
.
> +
> +The only solution to avoid dependencies loops is by not allowing indefin=
ite
> +fences in the kernel. This means:
> +
> +* No future fences, proxy fences or userspace fences imported as DMA fen=
ces,
> +  with or without a timeout.
> +
> +* No DMA fences that signal end of batchbuffer for command submission wh=
ere
> +  userspace is allowed to use userspace fencing or long running compute
> +  workloads. This also means no implicit fencing for shared buffers in t=
hese
> +  cases.
> --
> 2.27.0
>
