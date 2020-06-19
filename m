Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA91F201A2C
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 20:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbgFSSSx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 14:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731178AbgFSSSw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jun 2020 14:18:52 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88A2C0613EE
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 11:18:51 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q8so9793762qkm.12
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1/Hgy08bto/uuUKyMYyyKuV+V6dnJEVWt8WI7nf113M=;
        b=oKJaPgv8wNzRDCQM/lbllCSa8UopWR/4B3ZObmEr8TAf1+Rds44pV9VzNub4sQdhc2
         bjSNRQFpC1WEcAOQoeY8RSETmivCfaJ304Nt+yFVJOJ3EAJPutPkzAstPxgxWTthm32r
         lAh5yy5JF9Zclqktay5+zs6zAs4qsPCMyyTnmAlKngaG1QbMRQj5/aW32rxFtirPl7SN
         HF7NEkxn7w4GPh8ayZInrb8FNVuIMujbguuDEsHpUspaixZEf7pYVjnwEs3vjnveMg0N
         FydqN5NJ5K9LZc5hUEs32llHDaDYk5KrqnBUzpPC9LHlhF+AF1cEaShjq0uYpfPfAwu+
         i2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1/Hgy08bto/uuUKyMYyyKuV+V6dnJEVWt8WI7nf113M=;
        b=k/2wxmqcZA29NFGRZzgmmQ7pGDltsqRfpjUGscVRI5brCJ4LKf7gk/SNLlvf1b1xU3
         GWPLToQKgLk2g3o9eivGMzQGmUZe4LKcsIyPfS9Fuo1qdpadak6quAGVVZf2gi44lOpl
         fBCJ5PdFke4qwnPlSjiTQMQadirHf7wIJYATp3NVncK2V00JsWLBLSRnEFuM9RGhWF2P
         1uFhD22mYjR8cOYtf4CAZ4pDAnEQOBPrNlUdUf6eFTde/IY+kIVnj3AiIloTiy215JNE
         o4k9qVSZPSItEYMTkpJ7hljvzj7IXnQZOiK7ehu94/u3pSCgVjVC0Y5JgKiJakhpiOus
         6Nvg==
X-Gm-Message-State: AOAM532KzZgQeZfm/BlisBo69Aa2gOzVSGItOKMTVVaFLIKFmiz8IBcQ
        JurScrBuPIejXh6YfXqKXKazXw==
X-Google-Smtp-Source: ABdhPJwp/bC67muLlOI/xSpEwuzExrlyozorQFAY/Wts3lymB2t5b6BHCjSgETZH9nZLtDVxeUxvJg==
X-Received: by 2002:a37:4e4a:: with SMTP id c71mr4652759qkb.61.1592590730926;
        Fri, 19 Jun 2020 11:18:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id f203sm815339qke.135.2020.06.19.11.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 11:18:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jmLbF-00AyFH-UW; Fri, 19 Jun 2020 15:18:49 -0300
Date:   Fri, 19 Jun 2020 15:18:49 -0300
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
Message-ID: <20200619181849.GR6578@ziepe.ca>
References: <20200617152835.GF6578@ziepe.ca>
 <20200618150051.GS20149@phenom.ffwll.local>
 <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca>
 <20200619180935.GA10009@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619180935.GA10009@redhat.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 19, 2020 at 02:09:35PM -0400, Jerome Glisse wrote:
> On Fri, Jun 19, 2020 at 02:23:08PM -0300, Jason Gunthorpe wrote:
> > On Fri, Jun 19, 2020 at 06:19:41PM +0200, Daniel Vetter wrote:
> > 
> > > The madness is only that device B's mmu notifier might need to wait
> > > for fence_B so that the dma operation finishes. Which in turn has to
> > > wait for device A to finish first.
> > 
> > So, it sound, fundamentally you've got this graph of operations across
> > an unknown set of drivers and the kernel cannot insert itself in
> > dma_fence hand offs to re-validate any of the buffers involved?
> > Buffers which by definition cannot be touched by the hardware yet.
> > 
> > That really is a pretty horrible place to end up..
> > 
> > Pinning really is right answer for this kind of work flow. I think
> > converting pinning to notifers should not be done unless notifier
> > invalidation is relatively bounded. 
> > 
> > I know people like notifiers because they give a bit nicer performance
> > in some happy cases, but this cripples all the bad cases..
> > 
> > If pinning doesn't work for some reason maybe we should address that?
> 
> Note that the dma fence is only true for user ptr buffer which predate
> any HMM work and thus were using mmu notifier already. You need the
> mmu notifier there because of fork and other corner cases.

I wonder if we should try to fix the fork case more directly - RDMA
has this same problem and added MADV_DONTFORK a long time ago as a
hacky way to deal with it.

Some crazy page pin that resolved COW in a way that always kept the
physical memory with the mm that initiated the pin?

(isn't this broken for O_DIRECT as well anyhow?)

How does mmu_notifiers help the fork case anyhow? Block fork from
progressing?

> I probably need to warn AMD folks again that using HMM means that you
> must be able to update the GPU page table asynchronously without
> fence wait.

It is kind of unrelated to HMM, it just shouldn't be using mmu
notifiers to replace page pinning..

> The issue for AMD is that they already update their GPU page table
> using DMA engine. I believe this is still doable if they use a
> kernel only DMA engine context, where only kernel can queue up jobs
> so that you do not need to wait for unrelated things and you can
> prioritize GPU page table update which should translate in fast GPU
> page table update without DMA fence.

Make sense

I'm not sure I saw this in the AMD hmm stuff - it would be good if
someone would look at that. Every time I do it looks like the locking
is wrong.

Jason
