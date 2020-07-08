Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C901218428
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 11:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgGHJti (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 05:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgGHJti (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jul 2020 05:49:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2C4C08C5DC
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2020 02:49:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so48159175wrs.11
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jul 2020 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GZShcKPFpqES2sTlaXu0+aLjhVaehBiP66MG6kX93c0=;
        b=GdCkVmFATenowtvtlQVSpSzElju4m414mKArdqAjU+5ulZjcLloKVWm5qk9JhB+Kja
         k+QoiAzYHZD+MAfkW6WxL1KJwx00iAi9DpiUR4fKJ86ybZ4hUe6Quu320Gg+F6oDtkY8
         SehTHojS0t5G8pCRlTYrmLi2s2cHnCCKtzyvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GZShcKPFpqES2sTlaXu0+aLjhVaehBiP66MG6kX93c0=;
        b=EXm2FKmqNbEkJ5A3CkeyUseyKt1M36UAnzW6UA1Nb49sMDTbdNjvqWI92G2mYOQOpE
         6r2rGjRKzq4xnj9+9QmtE0hqoHBDBBuYd7gEuIb6R8wyT447N9lN4EDZzhuQSK+GdzTt
         MHsKJi6Oj4pudmnqxRdkJZO2FadgBO7fe2k40hLXDkp8kD3evGyRFLYcPdcAu0QiR/jA
         QlpB7opH8t1t1QpEYbRLq+nDyuVUQzUHT79KlGpcVIduz4N0DhZ57o2M1S4mnYkyVGyp
         /Dt9A9O4/m7tCtWm7xMaliPqPbjYQnY6tfM6921Qhxt799LEA3kwfO7GczWNJ+R9lokZ
         canA==
X-Gm-Message-State: AOAM532L/itTKyJhDGD178VgerpgxYa4nN6aDny/JwJUE3UeqkjIN23V
        aPReVdcjvJ2MHHF1SpIMJTHnUA==
X-Google-Smtp-Source: ABdhPJx/hCEDu3TifTBNO01a+XGP1RMbCshXrEjvlv8gStmFtSO/TgMoCQgSIRGd+mK7JKGoUvckPg==
X-Received: by 2002:adf:afc3:: with SMTP id y3mr60962970wrd.277.1594201776849;
        Wed, 08 Jul 2020 02:49:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h23sm5082314wmb.3.2020.07.08.02.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 02:49:36 -0700 (PDT)
Date:   Wed, 8 Jul 2020 11:49:34 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
Message-ID: <20200708094934.GI3278063@phenom.ffwll.local>
References: <20200702131000.GW3278063@phenom.ffwll.local>
 <20200702132953.GS25301@ziepe.ca>
 <11e93282-25da-841d-9be6-38b0c9703d42@amd.com>
 <20200702181540.GC3278063@phenom.ffwll.local>
 <20200703120335.GT25301@ziepe.ca>
 <CAKMK7uGqABchpPLTm=vmabkwK3JJSzWTFWhfU+ywbwjw-HgSzw@mail.gmail.com>
 <20200703131445.GU25301@ziepe.ca>
 <f2ec5c61-a553-39b5-29e1-568dae9ca2cd@amd.com>
 <MW3PR11MB45553DB31AD67C8B870A345FE5660@MW3PR11MB4555.namprd11.prod.outlook.com>
 <d28286c7-b1c1-a4a8-1d38-264ed1761cdd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d28286c7-b1c1-a4a8-1d38-264ed1761cdd@amd.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 08, 2020 at 11:38:31AM +0200, Christian König wrote:
> Am 07.07.20 um 23:58 schrieb Xiong, Jianxin:
> > > -----Original Message-----
> > > From: Christian König <christian.koenig@amd.com>
> > > Am 03.07.20 um 15:14 schrieb Jason Gunthorpe:
> > > > On Fri, Jul 03, 2020 at 02:52:03PM +0200, Daniel Vetter wrote:
> > > > 
> > > > > So maybe I'm just totally confused about the rdma model. I thought:
> > > > > - you bind a pile of memory for various transactions, that might
> > > > > happen whenever. Kernel driver doesn't have much if any insight into
> > > > > when memory isn't needed anymore. I think in the rdma world that's
> > > > > called registering memory, but not sure.
> > > > Sure, but once registered the memory is able to be used at any moment
> > > > with no visibilty from the kernel.
> > > > 
> > > > Unlike GPU the transactions that trigger memory access do not go
> > > > through the kernel - so there is no ability to interrupt a command
> > > > flow and fiddle with mappings.
> > > This is the same for GPUs with user space queues as well.
> > > 
> > > But we can still say for a process if that this process is using a DMA-buf which is moved out and so can't run any more unless the DMA-buf is
> > > accessible again.
> > > 
> > > In other words you somehow need to make sure that the hardware is not accessing a piece of memory any more when you want to move it.
> > > 
> > While a process can be easily suspended, there is no way to tell the RDMA NIC not to process posted work requests that use specific memory regions (or with any other conditions).
> > 
> > So far it appears to me that DMA-buf dynamic mapping for RDMA is only viable with ODP support. For NICs without ODP, a way to allow pinning the device memory is still needed.
> 
> And that's exactly the reason why I introduced explicit pin()/unpin()
> functions into the DMA-buf API:
> https://elixir.bootlin.com/linux/latest/source/drivers/dma-buf/dma-buf.c#L811
> 
> It's just that at least our devices drivers currently prevent P2P with
> pinned DMA-buf's for two main reasons:
> 
> a) To prevent deny of service attacks because P2P BARs are a rather rare
> resource.
> 
> b) To prevent failures in configuration where P2P is not always possible
> between all devices which want to access a buffer.

So the above is more or less the question in the cover letter (which
didn't make it to dri-devel). Can we somehow throw that limitation out, or
is that simply not a good idea?

Simply moving buffers to system memory when they're pinned does simplify a
lot of headaches. For a specific custom built system we can avoid that
maybe, but I think upstream is kinda a different thing.

Cheers, Daniel

> Regards,
> Christian.
> 
> > 
> > Jianxin
> > 
> > > Christian.
> > > 
> > > > Jason
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
