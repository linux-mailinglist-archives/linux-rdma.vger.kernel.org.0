Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C1B2111B7
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2020 19:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgGARP1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jul 2020 13:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbgGARP1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Jul 2020 13:15:27 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E2AC08C5C1
        for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2020 10:15:27 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r12so14503530ilh.4
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2020 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XxnIxtjRpDkvkw51GDJVMxPTPGtFOykolSOKsxdLZrI=;
        b=iMvRepgl7G2zNXZ76Hr/JM0kvklKj2OppBxjxki23srGIrq6ioLxbixoQwwF7o1gQ3
         mc8DiDRPkO9ZyXHbNZ0Jh4v2uQwXQA2gROyeb/mgI4mJFKsKttQ9NEbiEMzptwBUStYL
         2W8vWBjzv+7LD4ciLeUZbm8WPBdaSb/yTwUFHpFfhvlOPA8eFvPChumv6qX/xUZWJaS7
         WExrJXqm1XpHR8IWSlASm6a0MgLkfL0lsNNB5/u0oF0nfUb5jMsYAMMqMDqNPbWIUoUy
         CDrBg1oCeaG5p8JYa2fTsFbABglV5FY6TMeSOyvHrYsOn6LQ9x16PZAKJJggXGpO9L2h
         Bmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XxnIxtjRpDkvkw51GDJVMxPTPGtFOykolSOKsxdLZrI=;
        b=pOb0eZt1yPriJtxLM2oeSrKp3aiPg0o4RmRTgXH/IfQl61DHHpHDEghXoc+8lVXjgu
         vwMyDjbv2LSao3tjPgOPAGiUX4AhHHw1w/BbxhCNYJzsQW3KhwZkFgpU0HBrumDy3vCR
         v7cLwuQF/5kcm7/E+3AyYfyLE4a343YJouAo7oKtR+rK6Tf9UUSHhpqDhprB1rmwDxzO
         KJwn6OyFxgUXyGpo6vBweCrJaSZPM/OaSELjHod0dWXEtL52bGcmxAxSWQz1OsHxILmX
         E2yuvcQ4F559ReZXqXrTPLKeEUMEch7qrLAQc5nUOFWmHeZhdSXXeiKQmtGlHKwOkdG1
         6G1g==
X-Gm-Message-State: AOAM531Gn3f4QLVVkz1cFBnLnLCsi7xWM84UyaqGWVRIQo15KnB+5fTC
        kjDfyBKFAfhSJFuTi8/6EnQCQA==
X-Google-Smtp-Source: ABdhPJxhHTHmbob6OQdYcormvVS6B2LDFca749np99vHRxmGD/Dd5URAcW/wKfoHCWMGpgIuDlfENA==
X-Received: by 2002:a92:844b:: with SMTP id l72mr9137016ild.19.1593623725989;
        Wed, 01 Jul 2020 10:15:25 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id t6sm3162260ioi.20.2020.07.01.10.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 10:15:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jqgKS-002ans-8p; Wed, 01 Jul 2020 14:15:24 -0300
Date:   Wed, 1 Jul 2020 14:15:24 -0300
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
Message-ID: <20200701171524.GN25301@ziepe.ca>
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
 <20200629185152.GD25301@ziepe.ca>
 <MW3PR11MB4555A99038FA0CFC3ED80D3DE56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20200630173435.GK25301@ziepe.ca>
 <MW3PR11MB45553FA6D144BF1053571D98E56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <9b4fa0c2-1661-6011-c552-e37b05f35938@amd.com>
 <20200701123904.GM25301@ziepe.ca>
 <34077a9f-7924-fbb3-04d9-cd20243f815c@amd.com>
 <CAKMK7uFf3_a+BN8CM7G8mNQPNtVBorouB+R5kxbbmFSB9XbeSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFf3_a+BN8CM7G8mNQPNtVBorouB+R5kxbbmFSB9XbeSg@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 01, 2020 at 05:42:21PM +0200, Daniel Vetter wrote:
> > >> All you need is the ability to stop wait for ongoing accesses to end and
> > >> make sure that new ones grab a new mapping.
> > > Swap and flush isn't a general HW ability either..
> > >
> > > I'm unclear how this could be useful, it is guarenteed to corrupt
> > > in-progress writes?
> > >
> > > Did you mean pause, swap and resume? That's ODP.
> >
> > Yes, something like this. And good to know, never heard of ODP.
> 
> Hm I thought ODP was full hw page faults at an individual page
> level,

Yes

> and this stop&resume is for the entire nic. Under the hood both apply
> back-pressure on the network if a transmission can't be received,
> but

NIC's don't do stop and resume, blocking the Rx pipe is very
problematic and performance destroying.

The strategy for something like ODP is more complex, and so far no NIC
has deployed it at any granularity larger than per-page.

> So since Jason really doesn't like dma_fence much I think for rdma
> synchronous it is. And it shouldn't really matter, since waiting for a
> small transaction to complete at rdma wire speed isn't really that
> long an operation. 

Even if DMA fence were to somehow be involved, how would it look?

Jason
