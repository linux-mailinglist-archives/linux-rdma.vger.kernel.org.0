Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A639C2139B0
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2020 14:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgGCMDi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jul 2020 08:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGCMDi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jul 2020 08:03:38 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC210C08C5C1
        for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2020 05:03:37 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dm12so14131754qvb.9
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jul 2020 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fdGxMNXjFPRMChoChNI232n2phwqd5WMAfBmTzyFaCA=;
        b=io/ZIfzMns8BtNmbtgig4AnbsihUo008AXWgkudubi7S5omOtZWbcf2u5xq5r6ziPd
         8VbcLiM7gvaiNtocONI3En9uup8UPIhXF6lzDcS3QY0+IlqQt2b56XP2Wd1Eq9StFNRj
         FbxqMxoSvq09ert+r1uqKwKIGlxXoy0ZW45XZSDcCbofywfXSFq4d8lHnIqKrRwanqq8
         /+qJEAYq1IsXobneb14Ws16jhmXIblDWKBwdM2jIOABicWVShZJ6BFbzhJuMeGlGty3B
         sE/CwNcGivydRmOVCIR51uWpXOrAalZBX41CqhqBRWtRDLvksgvlsixNU02FMxBoXiI2
         ynZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fdGxMNXjFPRMChoChNI232n2phwqd5WMAfBmTzyFaCA=;
        b=ihOtahu9eLa/vvlu+kj/Q3EpHw9XBQLn8G5F5qTaOIhYBN9XJqA9LkAomPLY9n8uJQ
         +E1IADv1TZzVF7CIh4dEaqaNCR6xnpg6tRet2ecmGByH9tympFltHV8Vng7LZ6LP+gUI
         X6GfIv4cYG/rfU38NZaH4xXVF1JFaO79LjuQy8fiEv0OfHs07riEjbS34jKs3J8hhIvm
         6lvwXEpGYsMrQ0roq1eul5NRM6KdtyYi2NgpMTrn5hN5p/RechGwydk0pFwWkdnS1c23
         TEaNDfiIfrwdRAveIl4C5t0mfi9e/MfBH2oQg4rFzkNSaNoZapGN8cFuKYUiEDtu93sJ
         rUpw==
X-Gm-Message-State: AOAM533XQDMkZNoSj2Bb17So+zsf7cxIT2WgZofiQ+hSFs5lFE77U+9X
        K0yclbHa+fSll+xx2tfA+1Uk7w==
X-Google-Smtp-Source: ABdhPJzkvP2fdUrs5YNEbm9kPZezMluWe3j86tbq6FtDJsXIejjeLeeNT4FwLdwBdZ6rU3GiAW2i4A==
X-Received: by 2002:a05:6214:851:: with SMTP id dg17mr35543091qvb.235.1593777817181;
        Fri, 03 Jul 2020 05:03:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y16sm9988554qkb.116.2020.07.03.05.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 05:03:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jrKPn-003RZq-RU; Fri, 03 Jul 2020 09:03:35 -0300
Date:   Fri, 3 Jul 2020 09:03:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        "Xiong, Jianxin" <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
Message-ID: <20200703120335.GT25301@ziepe.ca>
References: <MW3PR11MB45553FA6D144BF1053571D98E56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <9b4fa0c2-1661-6011-c552-e37b05f35938@amd.com>
 <20200701123904.GM25301@ziepe.ca>
 <34077a9f-7924-fbb3-04d9-cd20243f815c@amd.com>
 <CAKMK7uFf3_a+BN8CM7G8mNQPNtVBorouB+R5kxbbmFSB9XbeSg@mail.gmail.com>
 <20200701171524.GN25301@ziepe.ca>
 <20200702131000.GW3278063@phenom.ffwll.local>
 <20200702132953.GS25301@ziepe.ca>
 <11e93282-25da-841d-9be6-38b0c9703d42@amd.com>
 <20200702181540.GC3278063@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702181540.GC3278063@phenom.ffwll.local>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 02, 2020 at 08:15:40PM +0200, Daniel Vetter wrote:
> > > > 3. rdma driver worker gets busy to restart rx:
> > > > 	1. lock all dma-buf that are currently in use (dma_resv_lock).
> > > > 	thanks to ww_mutex deadlock avoidance this is possible
> > > Why all? Why not just lock the one that was invalidated to restore the
> > > mappings? That is some artifact of the GPU approach?
> > 
> > No, but you must make sure that mapping one doesn't invalidate others you
> > need.
> > 
> > Otherwise you can end up in a nice live lock :)
> 
> Also if you don't have pagefaults, but have to track busy memory at a
> context level, you do need to grab all locks of all buffers you need, or
> you'd race. There's nothing stopping a concurrent ->notify_move on some
> other buffer you'll need otherwise, and if you try to be clever and roll
> you're own locking, you'll anger lockdep - you're own lock will have to be
> on both sides of ww_mutex or it wont work, and that deadlocks.

So you are worried about atomically building some multi buffer
transaction? I don't think this applies to RDMA which isn't going to
be transcational here..

> > > And why is this done with work queues and locking instead of a
> > > callback saying the buffer is valid again?
> > 
> > You can do this as well, but a work queue is usually easier to handle than a
> > notification in an interrupt context of a foreign driver.
> 
> Yeah you can just install a dma_fence callback but
> - that's hardirq context
> - if you don't have per-page hw faults you need the multi-lock ww_mutex
>   dance anyway to avoid races.

It is still best to avoid the per-page faults and preload the new
mapping once it is ready.

Jason
