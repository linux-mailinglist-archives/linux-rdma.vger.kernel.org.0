Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2933A21B513
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGJMaj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 08:30:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:42882 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgGJMaj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Jul 2020 08:30:39 -0400
IronPort-SDR: ODehUNdGJs4nVO609EFbS6cGcQn+JCWiIS/qDxMM7fgZ13HCUem4HuTqdurJ4N43yJ8Z3ccl+1
 R2v9hS6WuHvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="213074042"
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="213074042"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 05:30:37 -0700
IronPort-SDR: cftD1yfh/1nQA1PDZMmZn1DC4qquNxaY/8BnGAe2+5lxp8nPb91koWGednsCdzSMuEPYsc/Mkl
 0PHDoh3FWFCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="484163756"
Received: from dedwards-mobl.ger.corp.intel.com (HELO [10.249.32.130]) ([10.249.32.130])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jul 2020 05:30:33 -0700
Subject: Re: [PATCH 1/2] dma-buf.rst: Document why indefinite fences are a bad
 idea
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        Jesse Natalie <jenatali@microsoft.com>,
        Steve Pronovost <spronovo@microsoft.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <42dafd6d-cd8e-2de9-4d34-47aff76f5640@linux.intel.com>
Date:   Fri, 10 Jul 2020 14:30:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709123339.547390-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Op 09-07-2020 om 14:33 schreef Daniel Vetter:
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

For first 5 patches, and patch 16, 17:

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

> Acked-by: Christian König <christian.koenig@amd.com>
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
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  Documentation/driver-api/dma-buf.rst | 70 ++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
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
> +At various times &dma_fence with an indefinite time until dma_fence_wait()
> +finishes have been proposed. Examples include:
> +
> +* Future fences, used in HWC1 to signal when a buffer isn't used by the display
> +  any longer, and created with the screen update that makes the buffer visible.
> +  The time this fence completes is entirely under userspace's control.
> +
> +* Proxy fences, proposed to handle &drm_syncobj for which the fence has not yet
> +  been set. Used to asynchronously delay command submission.
> +
> +* Userspace fences or gpu futexes, fine-grained locking within a command buffer
> +  that userspace uses for synchronization across engines or with the CPU, which
> +  are then imported as a DMA fence for integration into existing winsys
> +  protocols.
> +
> +* Long-running compute command buffers, while still using traditional end of
> +  batch DMA fences for memory management instead of context preemption DMA
> +  fences which get reattached when the compute job is rescheduled.
> +
> +Common to all these schemes is that userspace controls the dependencies of these
> +fences and controls when they fire. Mixing indefinite fences with normal
> +in-kernel DMA fences does not work, even when a fallback timeout is included to
> +protect against malicious userspace:
> +
> +* Only the kernel knows about all DMA fence dependencies, userspace is not aware
> +  of dependencies injected due to memory management or scheduler decisions.
> +
> +* Only userspace knows about all dependencies in indefinite fences and when
> +  exactly they will complete, the kernel has no visibility.
> +
> +Furthermore the kernel has to be able to hold up userspace command submission
> +for memory management needs, which means we must support indefinite fences being
> +dependent upon DMA fences. If the kernel also support indefinite fences in the
> +kernel like a DMA fence, like any of the above proposal would, there is the
> +potential for deadlocks.
> +
> +.. kernel-render:: DOT
> +   :alt: Indefinite Fencing Dependency Cycle
> +   :caption: Indefinite Fencing Dependency Cycle
> +
> +   digraph "Fencing Cycle" {
> +      node [shape=box bgcolor=grey style=filled]
> +      kernel [label="Kernel DMA Fences"]
> +      userspace [label="userspace controlled fences"]
> +      kernel -> userspace [label="memory management"]
> +      userspace -> kernel [label="Future fence, fence proxy, ..."]
> +
> +      { rank=same; kernel userspace }
> +   }
> +
> +This means that the kernel might accidentally create deadlocks
> +through memory management dependencies which userspace is unaware of, which
> +randomly hangs workloads until the timeout kicks in. Workloads, which from
> +userspace's perspective, do not contain a deadlock.  In such a mixed fencing
> +architecture there is no single entity with knowledge of all dependencies.
> +Thefore preventing such deadlocks from within the kernel is not possible.
> +
> +The only solution to avoid dependencies loops is by not allowing indefinite
> +fences in the kernel. This means:
> +
> +* No future fences, proxy fences or userspace fences imported as DMA fences,
> +  with or without a timeout.
> +
> +* No DMA fences that signal end of batchbuffer for command submission where
> +  userspace is allowed to use userspace fencing or long running compute
> +  workloads. This also means no implicit fencing for shared buffers in these
> +  cases.


