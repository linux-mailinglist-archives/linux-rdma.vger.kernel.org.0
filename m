Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D562A0FD
	for <lists+linux-rdma@lfdr.de>; Sat, 25 May 2019 00:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfEXWJ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 18:09:27 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35919 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfEXWJ0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 18:09:26 -0400
Received: by mail-vs1-f65.google.com with SMTP id l20so6898296vsp.3
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2019 15:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N9WMPAq1SBJByj8qM7LaEK8FLATRoK2GkIV6yeIQrTg=;
        b=bKmgytC7SrgoXWBeLhiR5hCTMa6fcLiMm5rC93YfDESWnXQkf9DWnWbpwOA2qai62r
         UQQrf8KjLit1Nysl+fEDFWUYjRQ1BCAU5L2WBIVkSkvA3HxAdgjSCgRcrkwYzG0lVhKA
         rkkm+QbUJn+xpBU32Ur7JFZ7RZnEvVuQ0Oh66ODXmdl++FyoKYM0Ut04eJ2K3+2AemGg
         DWabdEAuNWRwAaZALYzLij44xk2C0zYcEH2yx16sPHNGrOzr4f9fAGoOIdFEHsBFqwCQ
         KYvwVWtFbbfLv/HLr+MXFFfA2r3iSqVRvy/XUT9TF/l6/+fUUsNCW96LKaMe1KS1GPH8
         qURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N9WMPAq1SBJByj8qM7LaEK8FLATRoK2GkIV6yeIQrTg=;
        b=VLmtVfZQTss7lJqyghu9DmKfAMoWl/qipJcBJywdKnDMzo9K+H0rz01CendTTxnERn
         x9b+dh5MMCQvcP5axSmDd8dpAI4Jbz9Qfur8mvRLcads6CDK9owQEIZnMFZRNs872SAu
         fXmbJHqXVosOWzDxGPqo33erlMiesZBYGuGhbNFibcK/+8QWUa0c9mg9TfGB0y3aLYb4
         RLAmnKY5m5C2Ktxz0OfGjo8qHc/OFlR6lv7aZVYSKGnen94y2fc9vVn8lgD6cvVCXffQ
         BMpezIkGHp4w3E7/+aLseQm8hYujVKNtCBU3AaOcCOHqYV402c61J6UjKYwQRNxhFQLh
         i7oQ==
X-Gm-Message-State: APjAAAW3Et8DwK01Hm5huGuI+1z+IdpYUtfPsEg8kliU4u5TMThy2IBb
        rurr30VdA0Pp7plihC9FQNvk7A==
X-Google-Smtp-Source: APXvYqwgrX8m55ZYTOzrECuhHF6YZsdnmGWgqzcToJx9OiFpqNA9rfK65uaAw5d6QYwQwUEAquscGg==
X-Received: by 2002:a67:2e15:: with SMTP id u21mr30135920vsu.50.1558735765273;
        Fri, 24 May 2019 15:09:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id v14sm2014695vkd.4.2019.05.24.15.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 15:09:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hUINP-0002IN-DS; Fri, 24 May 2019 19:09:23 -0300
Date:   Fri, 24 May 2019 19:09:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
Message-ID: <20190524220923.GA8519@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190524143649.GA14258@ziepe.ca>
 <20190524164902.GA3346@redhat.com>
 <20190524165931.GF16845@ziepe.ca>
 <20190524170148.GB3346@redhat.com>
 <20190524175203.GG16845@ziepe.ca>
 <20190524180321.GD3346@redhat.com>
 <20190524183225.GI16845@ziepe.ca>
 <20190524184608.GE3346@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524184608.GE3346@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 02:46:08PM -0400, Jerome Glisse wrote:
> > Here is the big 3 CPU ladder diagram that shows how 'valid' does not
> > work:
> > 
> >        CPU0                                               CPU1                                          CPU2
> >                                                         DEVICE PAGE FAULT
> >                                                         range = hmm_range_register()
> >
> >   // Overlaps with range
> >   hmm_invalidate_start()
> >     range->valid = false
> >     ops->sync_cpu_device_pagetables()
> >       take_lock(driver->update);
> >        // Wipe out page tables in device, enable faulting
> >       release_lock(driver->update);
> >                                                                                                    // Does not overlap with range
> >                                                                                                    hmm_invalidate_start()
> >                                                                                                    hmm_invalidate_end()
> >                                                                                                        list_for_each
> >                                                                                                            range->valid =  true
> 
>                                                                                                              ^
> No this can not happen because CPU0 still has invalidate_range in progress and
> thus hmm->notifiers > 0 so the hmm_invalidate_range_end() will not set the
> range->valid as true.

Oh, Okay, I now see how this all works, thank you

> > And I can make this more complicated (ie overlapping parallel
> > invalidates, etc) and show any 'bool' valid cannot work.
> 
> It does work. 

Well, I ment the bool alone cannot work, but this is really bool + a
counter.

> If you want i can remove the range->valid = true from the
> hmm_invalidate_range_end() and move it within hmm_range_wait_until_valid()
> ie modifying the hmm_range_wait_until_valid() logic, this might look
> cleaner.

Let me reflect on it for a bit. I have to say I don't like the clarity
here, and I don't like the valid=true loop in the invalidate_end, it
is pretty clunky.

I'm thinking a more obvious API for drivers, as something like:

again:
    hmm_range_start();
     [..]
    if (hmm_range_test_retry())
          goto again

    driver_lock()
      if (hmm_range_end())
           goto again
    driver_unlock();

Just because it makes it very clear to the driver author what to do
and how this is working, and makes it clear that there is no such
thing as 'valid' - what we *really* have is a locking collision
forcing retry. ie this is really closer to a seq-lock scheme, not a
valid/invalid scheme. Being able to explain the concept does matter
for maintainability...

And I'm thinking the above API design would comfortably support a more
efficient seq-lock like approach without the loop in invalidate_end..

But I haven't quite thought it all through yet. Next week!

> > I still think the best solution is to move device_lock() into mirror
> > and have hmm manage it for the driver as ODP does. It is certainly the
> > simplest solution to understand.
> 
> It is un-efficient and would block further than needed forward progress
> by mm code.

I'm not sure how you get to that, we already have the device_lock()
and it already blocks forward progress by mm code.

Really the big unfortunate thing here is that valid is manipulated
outside the device_lock, but really, logically, it is covered under
the device_lock

Jason
