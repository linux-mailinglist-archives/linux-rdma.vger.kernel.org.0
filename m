Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4F221242A
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 15:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgGBNKF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 09:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgGBNKF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jul 2020 09:10:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60C9C08C5C1
        for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2020 06:10:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so28272844wrm.4
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2020 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UR/7Hkhx2r/d/gKW2/boZAe2A2TsRBFJsaypFWCnjfA=;
        b=j3adNWOmm9OJqEGS2O9PeDyCmA1jAP+F/x7OmYtHmqcdn/TU3rqS6kW/wjACWmrEU4
         Sgf15nmX7IdC3oDzWtoiguuTPp+ySpmGl252B4edHUbSQqhDcdj57dcKSjOEwhgqYiuA
         JJM1I5aZ0hLWzbcrRKcWMqG8LIq1j65ljC4q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UR/7Hkhx2r/d/gKW2/boZAe2A2TsRBFJsaypFWCnjfA=;
        b=tA43qH/RHZKrkm3ifOA4OXDm+UK7Lu3mkz49mVF/C1kt0m1Ia+KSOe9GzGl94/Z/Ww
         6n5OiecwwW3B/7VKG7xGFBmnvTnh4Uw3p3Z1WpEIEJ26fV16nIj5zR1sjuHkjthhaiB8
         BR01BXW4XLfqN3Tqe3HLOPClQoXaf6r0Lp0pSAFIZz0cu/+vPaKZQA4o3X1IFbrCMTGI
         ZxZ7q/Vvi0mYZU4I3eUPyhNPdHYSjE7ImZNnHUU6j2mD/WGfP4tu1S5k3zh6z0SuKXBW
         gey4gT3KlE91mOXJ45HEy/7EbBqwkdwYsedhaU9bhKyBWSN9o6K8h2XWUnoLxjoRWuR8
         w3Tw==
X-Gm-Message-State: AOAM533TxN950F4GJXXEtAExQ1rIQlwgdn2yx+r0JQKz10ZBQ+CG0YJU
        YQNY+JdoZF89BW3o/2DsGPLBBA==
X-Google-Smtp-Source: ABdhPJz5sHpauaSEGudHIeVnkv/lyj4qN+JXLcy9j5vScVcBpcWq+e74oDRTa9tb4xhlMCyK7l3lyA==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr31028666wrs.384.1593695403555;
        Thu, 02 Jul 2020 06:10:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c206sm11123057wmf.36.2020.07.02.06.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 06:10:02 -0700 (PDT)
Date:   Thu, 2 Jul 2020 15:10:00 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        "Xiong, Jianxin" <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
Message-ID: <20200702131000.GW3278063@phenom.ffwll.local>
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
 <20200629185152.GD25301@ziepe.ca>
 <MW3PR11MB4555A99038FA0CFC3ED80D3DE56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20200630173435.GK25301@ziepe.ca>
 <MW3PR11MB45553FA6D144BF1053571D98E56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <9b4fa0c2-1661-6011-c552-e37b05f35938@amd.com>
 <20200701123904.GM25301@ziepe.ca>
 <34077a9f-7924-fbb3-04d9-cd20243f815c@amd.com>
 <CAKMK7uFf3_a+BN8CM7G8mNQPNtVBorouB+R5kxbbmFSB9XbeSg@mail.gmail.com>
 <20200701171524.GN25301@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701171524.GN25301@ziepe.ca>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 01, 2020 at 02:15:24PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 01, 2020 at 05:42:21PM +0200, Daniel Vetter wrote:
> > > >> All you need is the ability to stop wait for ongoing accesses to end and
> > > >> make sure that new ones grab a new mapping.
> > > > Swap and flush isn't a general HW ability either..
> > > >
> > > > I'm unclear how this could be useful, it is guarenteed to corrupt
> > > > in-progress writes?
> > > >
> > > > Did you mean pause, swap and resume? That's ODP.
> > >
> > > Yes, something like this. And good to know, never heard of ODP.
> > 
> > Hm I thought ODP was full hw page faults at an individual page
> > level,
> 
> Yes
> 
> > and this stop&resume is for the entire nic. Under the hood both apply
> > back-pressure on the network if a transmission can't be received,
> > but
> 
> NIC's don't do stop and resume, blocking the Rx pipe is very
> problematic and performance destroying.
> 
> The strategy for something like ODP is more complex, and so far no NIC
> has deployed it at any granularity larger than per-page.
> 
> > So since Jason really doesn't like dma_fence much I think for rdma
> > synchronous it is. And it shouldn't really matter, since waiting for a
> > small transaction to complete at rdma wire speed isn't really that
> > long an operation. 
> 
> Even if DMA fence were to somehow be involved, how would it look?

Well above you're saying it would be performance destroying, but let's
pretend that's not a problem :-) Also, I have no clue about rdma, so this
is really just the flow we have on the gpu side.

0. rdma driver maintains a list of all dma-buf that it has mapped
somewhere and is currently using for transactions

1. rdma driver gets a dma_buf->notify_move callback on one of these
buffers. To handle that it:
	1. stops hw access somehow at the rx
	2. flushes caches and whatever else is needed
	3. moves the unmapped buffer on a special list or marks it in some
	different way as unavailable
	4. launch the kthread/work_struct to fix everything back up

2. dma-buf export (gpu driver) can now issue the commands to move the
buffer around

3. rdma driver worker gets busy to restart rx:
	1. lock all dma-buf that are currently in use (dma_resv_lock).
	thanks to ww_mutex deadlock avoidance this is possible
	2. for any buffers which have been marked as unavailable in 1.3
	grab a new mapping (which might now be in system memory, or again
	peer2peer but different address)
	3. restart hw and rx
	4. unlock all dma-buf locks (dma_resv_unlock)

There is a minor problem because step 2 only queues up the entire buffer
moves behind a pile of dma_fence, and atm we haven't made it absolutely
clear who's responsible for waiting for those to complete. For gpu drivers
it's the importer since gpu drivers don't have big qualms about
dma_fences, so 3.2. would perhaps also include a dma_fence_wait to make
sure the buffer move has actually completed.

Above flow is more or less exactly what happens for gpu workloads where we
can preempt running computations. Instead of stopping rx we preempt the
compute job and remove it from the scheduler queues, and instead of
restarting rx we just put the compute job back onto the scheduler queue as
eligible for gpu time. Otherwise it's exactly the same stuff.

Of course if you only have a single compute job and too many such
interruptions, then performance is going to tank. Don't do that, instead
make sure you have enough vram or system memory or whatever :-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
