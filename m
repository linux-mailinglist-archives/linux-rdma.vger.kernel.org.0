Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937022007FE
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 13:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbgFSLjk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 07:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731869AbgFSLjh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jun 2020 07:39:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D3BC0613EF
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 04:39:37 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c185so8548205qke.7
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5lQCYSoi4FC78xGjLBeogrhLOaSlungd8A2lT6c416A=;
        b=GpTji/yhJTYfywss1k5am+JyELnNZlvvM8qP/Uyg3OD7x7MqDitwSWfgM3HPj0UhUM
         CmGRkgXfDHKjJbk/G94ThGo65HoXLKpYTHWId62kC64177gtGxTII+K1ZYz1wipOiAHJ
         eNgWeTmTaG/jDKlMWG2mJATpUK5rAwHHXT5FR/exkvaSA9MSXlfn3hlOUhTW2ZxS/H4F
         HEmI2H47vtMrMdfYBePKTzq7Q28TCNQpdwQLKytMyWVDkIDxh7YsNl1xg+jdzcXMR0cI
         rZrwuwfz+8JvRuJ/hZc0oTCMz+QMnazKQOTVrKsL2AkwHyGJfWycuxP+cVSimTbDO1fJ
         9CVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5lQCYSoi4FC78xGjLBeogrhLOaSlungd8A2lT6c416A=;
        b=I5YnWm8CiVFHaUKDpOpw18Q+Tvz7RH86CMZUt2SZRnMKLehOu7Dp9VbH0TGHfZa98g
         O4dGmdjVi8KWPzFh1A9NFFbMmJ5o38e9bwfNeC1Cuk/pxtFoqEdZ9k44T6rCWkc8rRzn
         r72+eKgNAaH26hwgBwb6YydkLekqkLJgBORC+Za5mqu53omfLgHFxhbKgVxubo4aU44y
         WXOtMYYM3MByRaQWtQ5s7JFzrPZm2akJAk6mKg+Hav2ic44gBrYq7UWPdoscy6sJhImQ
         bUf4tl/f1OVXrSXJj5/auLyrbpXqff14CMsTuEuObZNDmR9WNO0aftIDas+zmQyK+fvo
         Py5Q==
X-Gm-Message-State: AOAM531PqIPTvbbmJACkrzFroJ3Rflgxc9uHJ+xEh4baWgwJGS/Z5+oN
        KTagKGu7TRq82sImPM3ILQ/K9w==
X-Google-Smtp-Source: ABdhPJyvT5Fp9eB5e8a01kFzBtsDczKSLoT1L7Q5mintxsSice/gNXkvAdcFjnB+DRsdXJvj32xdRg==
X-Received: by 2002:a37:6191:: with SMTP id v139mr2946071qkb.213.1592566776171;
        Fri, 19 Jun 2020 04:39:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o6sm6016053qtd.59.2020.06.19.04.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 04:39:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jmFMs-00AiVa-OZ; Fri, 19 Jun 2020 08:39:34 -0300
Date:   Fri, 19 Jun 2020 08:39:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
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
Message-ID: <20200619113934.GN6578@ziepe.ca>
References: <20200604081224.863494-5-daniel.vetter@ffwll.ch>
 <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local>
 <20200611141515.GW6578@ziepe.ca>
 <20200616120719.GL20149@phenom.ffwll.local>
 <CAKMK7uE7DKUo9Z+yCpY+mW5gmKet8ugbF3yZNyHGqsJ=e-g_hA@mail.gmail.com>
 <20200617152835.GF6578@ziepe.ca>
 <20200618150051.GS20149@phenom.ffwll.local>
 <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 19, 2020 at 09:22:09AM +0200, Daniel Vetter wrote:
> > As I've understood GPU that means you need to show that the commands
> > associated with the buffer have completed. This is all local stuff
> > within the driver, right? Why use fence (other than it already exists)
> 
> Because that's the end-of-dma thing. And it's cross-driver for the
> above reasons, e.g.
> - device A renders some stuff. Userspace gets dma_fence A out of that
> (well sync_file or one of the other uapi interfaces, but you get the
> idea)
> - userspace (across process or just different driver) issues more
> rendering for device B, which depends upon the rendering done on
> device A. So dma_fence A is an dependency and will block this dma
> operation. Userspace (and the kernel) gets dma_fence B out of this
> - because unfortunate reasons, the same rendering on device B also
> needs a userptr buffer, which means that dma_fence B is also the one
> that the mmu_range_notifier needs to wait on before it can tell core
> mm that it can go ahead and release those pages

I was afraid you'd say this - this is complete madness for other DMA
devices to borrow the notifier hook of the first device!

What if the first device is a page faulting device and doesn't call
dma_fence??

It you are going to treat things this way then the mmu notifier really
needs to be part of the some core DMA buf, and not randomly sprinkled
in drivers

But really this is what page pinning is supposed to be used for, the
MM behavior when it blocks on a pinned page is less invasive than if
it stalls inside a mmu notifier.

You can mix it, use mmu notififers to keep track if the buffer is
still live, but when you want to trigger DMA then pin the pages and
keep them pinned until DMA is done. The pin protects things (well,
fork is still a problem)

Do not need to wait on dma_fence in notifiers.

Jason
