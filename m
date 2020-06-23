Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEE42044F2
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 02:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbgFWAFa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 20:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731328AbgFWAF3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 20:05:29 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78695C061795
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 17:05:27 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z1so14125630qtn.2
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 17:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZARmJJ7xCkdZZ2t8wNh4/tQvVIlLfUoBxGbPVnLj1no=;
        b=ZqLlsVf823WvkS6Pxei8NiC2W2IIsAJoQA2urO7e9M3j3n78WU8zuiQnBC/Hh13LQ7
         W82cIEkI8yK1kig27JBpN1A+kBTvdyfep2zqFSsRZ3bneYMoHddrECdeOHAhBx3jAggE
         8oQvGlZO4VuJSft8Izl2Bf/u/NJdZDmJmyKoVRcHZq2TKwggLrrOlhDeM/ysxoX7/Me3
         dqRCX3t0aoqiPb12yGgusjNMnEL8ewMvbu4zIi2lDYR1tedgzPmqU85hNdNt9mW7kpmp
         xuKIYdmxHb1ZwHUACc5P3GQ4w7GIm5gpp47skdgCpNYwfEX9eupQQgKd/elWzUh05kv2
         mhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZARmJJ7xCkdZZ2t8wNh4/tQvVIlLfUoBxGbPVnLj1no=;
        b=d/w+U4w75LgQ8akY5ZrFF4Wi7uu9E+egw+8OBU74uiytr8dQsjr7sX7rs9sGqEb3WO
         s+uFP+yHRDTaNgzRWSC6U3T6G7sSJtPvjdZG2iH8aDIjXItie5nk/3NNC7I5Lf8gAWmP
         YOhTvvUlpzzQiyIE2hgfAIqgCfZgpimPwBPssIgmUWyc49afh1+e3Uq8r1UXyEq9WtZO
         wLxsgw/12DPlzoE5nYirjjsXtirSt3fm17rEC8sRJ33+IZb+Wn4ylZzasAjLDUF3yrf8
         OIZIE681+v0c2hdUMRnW45yLTEhk9hsIt28XBso/6pZdBPY7haFRP5udXhLKNMRhiHJK
         WFew==
X-Gm-Message-State: AOAM532v48qgwtFyk+7rKVrg0xEwXTTh4f4SNpbRsqaRaQx6gX6C+S0S
        /+k6lZue9NNG4ljepSmWo8/EPA==
X-Google-Smtp-Source: ABdhPJybLGEC9Vkbo3afR1e0rkiE4Uqi81y09rG7Z316acKAzGcUboScxSHByPFqPGL4yR3GT9b3Ew==
X-Received: by 2002:ac8:279a:: with SMTP id w26mr18731669qtw.309.1592870726664;
        Mon, 22 Jun 2020 17:05:26 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id n143sm1204192qkn.94.2020.06.22.17.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 17:05:26 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jnWRJ-00CHPu-Cd; Mon, 22 Jun 2020 21:05:25 -0300
Date:   Mon, 22 Jun 2020 21:05:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
Message-ID: <20200623000525.GX6578@ziepe.ca>
References: <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca>
 <20200619180935.GA10009@redhat.com>
 <20200619181849.GR6578@ziepe.ca>
 <20200619201011.GB13117@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619201011.GB13117@redhat.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 19, 2020 at 04:10:11PM -0400, Jerome Glisse wrote:
 
> Maybe we can audit how user ptr buffer are use today and see if
> we can define a usage pattern that would allow to cut corner in
> kernel. For instance we could use mmu notifier just to block CPU
> pte update while we do GUP and thus never wait on dma fence.

The DMA fence is the main problem, if you can think of a way to avoid
it then it would be great!
 
> Then GPU driver just keep the GUP pin around until they are done
> with the page. They can also use the mmu notifier to keep a flag
> so that the driver know if it needs to redo a GUP ie:
> 
> The notifier path:
>    GPU_mmu_notifier_start_callback(range)
>         gpu_lock_cpu_pagetable(range)
>         for_each_bo_in(bo, range) {
>             bo->need_gup = true;
>         }
>         gpu_unlock_cpu_pagetable(range)

So some kind of invalidation tracking? But this doesn't solve COW and
Fork problem?

> > It is kind of unrelated to HMM, it just shouldn't be using mmu
> > notifiers to replace page pinning..
> 
> Well my POV is that if you abide by rules HMM defined then you do
> not need to pin pages. The rule is asynchronous device page table
> update.

I think one of the hmm rules is to not block notifiers for a long
time, which these scheme seem to violate already.

Pinning for a long time is less bad than blocing notifiers for a long
time, IMHO

Jason
