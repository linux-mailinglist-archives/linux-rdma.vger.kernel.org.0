Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6019C1565C6
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2020 18:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgBHRni (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Feb 2020 12:43:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34252 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgBHRni (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Feb 2020 12:43:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id a23so2486360qka.1
        for <linux-rdma@vger.kernel.org>; Sat, 08 Feb 2020 09:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RXOY4tl2NWvYiA+9B1bjUhFyy6o+KncngEC6FkOXeRQ=;
        b=FzZBppVgZsGVLHJCNwTuIO91PPyU6iQP5MiZWrob6/Rcc0sixNyXlewVV/aF5/j9Mr
         vGN+67tzlTy638EHdJSc0tlJZ2cr8XRJSokxNNNYu6viqGdW1cOWhHC4gduie1JHs+Ew
         Pc8PSJ7ltkEPZOFUWo7JwOe90Y00CVZeZ+4jRethpKqAYkB+CjTWIrSA9+xQSNi7BgU8
         Brcs6hAoyh2TZUP7F6Bi/owlQr6z70SHRg4hdezUf3yXXAkvr8ISs11z625HtS1D/ckm
         1s3+czshyLWCdsZSoaXypRLdsb7cCWhlo0/9PHaYqWS+ymLWcuDeiOR77wfOfOFS1egf
         V9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RXOY4tl2NWvYiA+9B1bjUhFyy6o+KncngEC6FkOXeRQ=;
        b=miFZgEj1CmrZW4PP6SQm6UwMsZd33tnFDZpDpFrRr30I7OxwB/k7Y1pSIYexkGYFIR
         mNQJUJdW/nxfYORZmbGoR60xylt9qWCXEjWTI2n5Sk9TH8ECg7Lk+V7kT1OIAYbUrsFR
         Z6YbPsdvJHnXgJ0GA5qNBqIK47V54A3+c8+AMZSbOZ7N431HIxmGPlmwUyCERXTv1Ye3
         Y2OPEKVj2UiVihfYmcJprzabIm/TKbTQ0wys+XQmTOKRybcHMnR2eee0GmgJJp57+rW3
         3M7rlptdduLzGJ+ckHOROL4So4rhrVaHGD4rD+dxlVaFz9vKDKE8Bv04+lZeGrh2ZBkP
         4cpA==
X-Gm-Message-State: APjAAAW2Kv2vpKLWvOs4b76HYuKM59Qoy7gaHtqUd3Dl2V35Ybg2RZPK
        L7cgy/G42e/5yJwndKkH6UhM+A==
X-Google-Smtp-Source: APXvYqxzirwyqXFHWPODUquYEjgCHsUJ0gGw1BEGndQY7RmsWigC7oZAzZDxtZayUsiFT2tKDr4MBQ==
X-Received: by 2002:a05:620a:110c:: with SMTP id o12mr4274060qkk.66.1581183816511;
        Sat, 08 Feb 2020 09:43:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id e130sm3101412qkb.72.2020.02.08.09.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Feb 2020 09:43:35 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j0U8l-0003SY-7J; Sat, 08 Feb 2020 13:43:35 -0400
Date:   Sat, 8 Feb 2020 13:43:35 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ira Weiny <iweiny@intel.com>, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Don Dutile <ddutile@redhat.com>
Subject: Re: [LSF/MM TOPIC] get_user_pages() for PCI BAR Memory
Message-ID: <20200208174335.GL25297@ziepe.ca>
References: <20200207182457.GM23346@mellanox.com>
 <20e3149e-4240-13e7-d16e-3975cfbe4d38@amd.com>
 <20200208135405.GO23346@mellanox.com>
 <7a2792b1-3d9f-c921-28ac-8c2475684869@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a2792b1-3d9f-c921-28ac-8c2475684869@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Feb 08, 2020 at 05:38:51PM +0100, Christian König wrote:
> Am 08.02.20 um 14:54 schrieb Jason Gunthorpe:
> > On Sat, Feb 08, 2020 at 02:10:59PM +0100, Christian König wrote:
> > > > For patch sets, we've seen a number of attempts so far, but little has
> > > > been merged yet. Common elements of past discussions have been:
> > > >    - Building struct page for BAR memory
> > > >    - Stuffing BAR memory into scatter/gather lists, bios and skbs
> > > >    - DMA mapping BAR memory
> > > >    - Referencing BAR memory without a struct page
> > > >    - Managing lifetime of BAR memory across multiple drivers
> > > I can only repeat Jérôme that this most likely will never work correctly
> > > with get_user_pages().
> > I suppose I'm using 'get_user_pages()' as something of a placeholder
> > here to refer to the existing family of kernel DMA consumers that call
> > get_user_pages to work on VMA backed process visible memory.
> > 
> > We have to have something like get_user_pages() because the kernel
> > call-sites are fundamentally only dealing with userspace VA. That is
> > how their uAPIs are designed, and we want to keep them working.
> > 
> > So, if something doesn't fit into get_user_pages(), ie because it
> > doesn't have a VMA in the first place, then that is some other
> > discussion. DMA buf seems like a pretty good answer.
> 
> Well we do have a VMA, but I strongly think that get_user_pages() is the
> wrong approach for the job.
> 
> What we should do instead is to grab the VMA for the addresses and then say
> through the vm_operations_struct: "Hello I'm driver X and want to do P2P
> with you. Who are you? What are your capabilities? Should we use PCIe or
> shortcut through some other interconnect? etc etc ect...".

This is a very topical discussion. So far all the non-struct page
approaches have fallen down in some way or another.

The big problem with a VMA centric scheme is that the VMA is ephemeral
relative to the DMA mapping, so when it comes time to unmap it is not
so clear what to do to 'put' the reference. There has also been
resistance to adding new ops to a VMA.

For instance a 'get dma buf' VMA op would solve the lifetime problems,
but significantly complicates most of the existing get_user_pages()
users as they now have to track lists of dma buf pointers so they can
de-ref the dma bufs that covered the user VA range during 'get'

FWIW, if the outcome of the discussion was to have some 'get dma buf'
VMA op that would probably be reasonable. I've talked about this
before with various people, it isn't quite as good as struct pages,
but some subsystems like RDMA can probably make it work.

> > > E.g. you have memory which is not even CPU addressable, but can be shared
> > > between GPUs using XGMI, NVLink, SLI etc....
> > For this kind of memory if it is mapped into a VMA with
> > DEVICE_PRIVATE, as Jerome has imagined, then it would be part of this
> > discussion.
> 
> I think what Jerome had in mind with its P2P ideas around HMM was that we
> could do this with anonymous memory which was migrated to a GPU device. That
> turned out to be rather complicated because you would need to be able to
> figure out to which driver you need to talk to for the migrated address,
> which in turn wasn't related to the VMA in any way.

Jerome's VMA proposal tied explicitly the lifetime of the VMA to the
lifetime of the DMA map by forcing the use of 'shared virtual memory'
(ie mmu notifiers, etc) techniques which have a very narrow usability
with HW. This is how the lifetime problem was solved in those patches.

This path has huge drawbacks for everything that is not a GPU use
case. Ie we can't fit it into virtio to solve it's current P2P DMA
problem.

> > > So we need to figure out how express DMA addresses outside of the CPU
> > > address space first before we can even think about something like extending
> > > get_user_pages() for P2P in an HMM scenario.
> > Why?
> 
> Because that's how get_user_pages() works. IIRC you call it with userspace
> address+length and get a filled struct pages and VMAs array in return.
> 
> When you don't have CPU addresses for you memory the whole idea of that
> interface falls apart. So I think we need to get away from get_user_pages()
> and work more high level here.

get_user_pages() is struct page focused, and there is some general
expectation that GPUs will have to create DEVICE_PRIVATE struct pages
for their entire hidden memory so that they can do all the HMM tricks
with anonymous memory. They also have to recongize the DEVICE_PIVATE
pages during hmm driven page faults.

Removing the DEVICE_PRIVATE from the anonymous page setup seems
impossible at the current moment - thus it seems like we are stuck
with struct pages, may as well use them?

Literally nobody like this, but all the non-struct-page proposals have
failed to get traction so far.

> > Improving the p2pdma subsystem to handle more complex cases like CPU
> > invisible memory and interconnect is a different topic, I think :)
> 
> Well you can of course ignore those, but P2P over PCIe is actually only a
> rather specific use case and I would say when we start to tackle this we
> should come up with something that works in all areas.

Well, it is the general 'standard based' problem.

Frankly, I don't think the general kernel community can tackle the
undocumented proprietary interconnect problem, as nobody really knows
what these things are. The people building these things needs to lead
that forward somehow.

Today, the closest we have, is the DEVICE_PRIVATE 'loopback' that
things like nouveau attempt to implement. They are supposed to be
able to translate the DEVICE_PRIVATE pages into some 'device internal'
address. Presumably that can reach through the device internal
interconnect, but I don't know if nouveau has gone that far.

Jason
