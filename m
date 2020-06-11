Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944BE1F6248
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2020 09:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgFKHaV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jun 2020 03:30:21 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:60515 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFKHaV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jun 2020 03:30:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id C52C53F6E8;
        Thu, 11 Jun 2020 09:30:17 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=GCUBzBxx;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iIlSPVxu0sRf; Thu, 11 Jun 2020 09:30:16 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id E40C23F683;
        Thu, 11 Jun 2020 09:30:13 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 06F8F360305;
        Thu, 11 Jun 2020 09:30:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1591860613; bh=ax4JYSj31lLugLn4GS/xTNhVWBMkQDLT2ea6JW6fq/U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GCUBzBxxf98lTFNSP0Dlp/n/+/bdS+fx4so3iAJYi8G/MjONQRAmflLqkOikME4iD
         MUs9rU3r/y6OHX+h/VnT1g38n1UpRlf1rQRrL0SPnh1UXImH0gRwWGozv2yL3tsxRs
         9r8MaAUOa6C2A8mHoNnl+0FXmTrNB6FX2Qv1kCb4=
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     linux-rdma@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-media@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
Date:   Thu, 11 Jun 2020 09:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604081224.863494-5-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/4/20 10:12 AM, Daniel Vetter wrote:
> Two in one go:
> - it is allowed to call dma_fence_wait() while holding a
>    dma_resv_lock(). This is fundamental to how eviction works with ttm,
>    so required.
>
> - it is allowed to call dma_fence_wait() from memory reclaim contexts,
>    specifically from shrinker callbacks (which i915 does), and from mmu
>    notifier callbacks (which amdgpu does, and which i915 sometimes also
>    does, and probably always should, but that's kinda a debate). Also
>    for stuff like HMM we really need to be able to do this, or things
>    get real dicey.
>
> Consequence is that any critical path necessary to get to a
> dma_fence_signal for a fence must never a) call dma_resv_lock nor b)
> allocate memory with GFP_KERNEL. Also by implication of
> dma_resv_lock(), no userspace faulting allowed. That's some supremely
> obnoxious limitations, which is why we need to sprinkle the right
> annotations to all relevant paths.
>
> The one big locking context we're leaving out here is mmu notifiers,
> added in
>
> commit 23b68395c7c78a764e8963fc15a7cfd318bf187f
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date:   Mon Aug 26 22:14:21 2019 +0200
>
>      mm/mmu_notifiers: add a lockdep map for invalidate_range_start/end
>
> that one covers a lot of other callsites, and it's also allowed to
> wait on dma-fences from mmu notifiers. But there's no ready-made
> functions exposed to prime this, so I've left it out for now.
>
> v2: Also track against mmu notifier context.
>
> v3: kerneldoc to spec the cross-driver contract. Note that currently
> i915 throws in a hard-coded 10s timeout on foreign fences (not sure
> why that was done, but it's there), which is why that rule is worded
> with SHOULD instead of MUST.
>
> Also some of the mmu_notifier/shrinker rules might surprise SoC
> drivers, I haven't fully audited them all. Which is infeasible anyway,
> we'll need to run them with lockdep and dma-fence annotations and see
> what goes boom.
>
> v4: A spelling fix from Mika
>
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
>   Documentation/driver-api/dma-buf.rst |  6 ++++
>   drivers/dma-buf/dma-fence.c          | 41 ++++++++++++++++++++++++++++
>   drivers/dma-buf/dma-resv.c           |  4 +++
>   include/linux/dma-fence.h            |  1 +
>   4 files changed, 52 insertions(+)

I still have my doubts about allowing fence waiting from within 
shrinkers. IMO ideally they should use a trywait approach, in order to 
allow memory allocation during command submission for drivers that
publish fences before command submission. (Since early reservation 
object release requires that).

But since drivers are already waiting from within shrinkers and I take 
your word for HMM requiring this,

Reviewed-by: Thomas Hellström <thomas.hellstrom@intel.com>


