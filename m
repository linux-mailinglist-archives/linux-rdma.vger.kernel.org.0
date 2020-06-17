Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A29C1FD0FC
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 17:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFQP3n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 11:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFQP3m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 11:29:42 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BB3C0613ED
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 08:29:42 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id x16so1220726qvr.3
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v5BdIMSU0SgDrZuQSRW4xvIrY4rZ7WnbUK5J5TOXFb0=;
        b=X4atcg3QCitKJdCOr5ja2tE2bUBLSFF91J0CzDtXnsV5WejCzsk2eajJzTjXjsFLTA
         5s+gkYE18Kz4f7uWFKMYMARjm17DhKgqFhDle7hMjPDQJSHTF3vHPDJzf/g8gfXm1XCc
         xS0VLL2kkFYRGpHsv6IKsvfpDgxixqoGb1C7eZAdpsByKmZrD/PLYevp7FEa9NQdLxHk
         yZFftabPuFhyEj1G7fMasvfilN4m93P/kXM+Vvvx/r/xyhIpvBM0x0Ha3wX71m2O7A/a
         L0H0SGP2pZKrl4si0m+rtOCOCb+j5CVmE5xryjAmjELn7Uqp0ivvBvKuiMRBNAyyx2kG
         itRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v5BdIMSU0SgDrZuQSRW4xvIrY4rZ7WnbUK5J5TOXFb0=;
        b=ZBaYxY3soqZonTZGqqa4azrANlekur0+sxKOMh1HWA/nCxmzgSXwadWTg6RdwJALGU
         b1oQLsaEh/Xyjpetaw4gmGz99Xuz/jOLZAkmdpq69oLiEXrnqrNVHLXKQeGhrOlX2XgO
         +sQevOvn+3x4Y7H8Sdk4J7E+h91lbmxiFZxMBeiUWfhpA5Ast0DqjBRWQD6kaM5hlaEn
         qz3R9Mg9sgm8CBDNjWvNDRnWPGuDccnWTiTLvg5vTBVrM16WEmdsT8yZiQAEmG5i70Ty
         DfZF/ne3+wTBB4GGhabdLRSWCpjw7x0O1N3yT+ZfwQOCn6pSWf1Bs84MQpNDJtGgvUmY
         JWGA==
X-Gm-Message-State: AOAM531fRJRqdO0vgk+f9st3tfWMMJZdypbTmyXoEEuDb8Eb7jG3MKN3
        0TXMrjsww4OBfKVvOVbUx2ioIQ==
X-Google-Smtp-Source: ABdhPJyWaY8mWagCAPiiX7EhWCqcjbxUamRd5/mDpg63tRR7xxsYdOaA9ycSUwn3S5FVu3UfHzBj0g==
X-Received: by 2002:a0c:f388:: with SMTP id i8mr8163963qvk.224.1592407781973;
        Wed, 17 Jun 2020 08:29:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y13sm204954qto.23.2020.06.17.08.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 08:29:41 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jla0S-009d9h-Uc; Wed, 17 Jun 2020 12:29:40 -0300
Date:   Wed, 17 Jun 2020 12:29:40 -0300
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
Message-ID: <20200617152940.GG6578@ziepe.ca>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch>
 <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local>
 <20200611141515.GW6578@ziepe.ca>
 <20200616120719.GL20149@phenom.ffwll.local>
 <20200616145312.GC6578@ziepe.ca>
 <CAKMK7uER6ax1zr14xYLKqDfDZp+ycBsY9Yx7JaVkKQ849VfSPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uER6ax1zr14xYLKqDfDZp+ycBsY9Yx7JaVkKQ849VfSPg@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 09:57:54AM +0200, Daniel Vetter wrote:

> > At the very least I think there should be some big warning that
> > dma_fence in notifiers should be avoided.
> 
> Yeah I'm working on documentation, and also the notifiers here
> hopefully make it clear it's massive pain. I think we could even make
> a hard rule that dma_fence in mmu notifier outside of drivers/gpu is a
> bug/misfeature.

Yep!
 
> Might be a good idea to add a MAINTAINERS entry with a K: regex
> pattern, so that you can catch such modifiers. We do already have such
> a pattern for dma-fence, to catch abuse. So if you want I could type
> up a documentation patch for this, get your and others acks and the
> dri-devel folks would enforce that the dma_fence_wait madness doesn't
> leak beyond drivers/gpu

It seems like the best thing
 
> Oded has agreed to remove the dma-fence usage, since they really don't
> need it (and all the baggage that comes with it), plain old completion
> is enough for their use. This use is also why I added the regex to
> MAINTAINERS, so that in the future we can catch people who try to use
> dma_fence because it looks cute and useful, and are completely
> oblivious to all the pain and headaches involved.

This is good!

Thanks,
Jason 
