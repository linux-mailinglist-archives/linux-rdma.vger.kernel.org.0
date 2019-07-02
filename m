Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6725DA04
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 02:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfGCA7L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 20:59:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45426 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfGCA7K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jul 2019 20:59:10 -0400
Received: by mail-qk1-f196.google.com with SMTP id s22so422356qkj.12
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jul 2019 17:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aes/lBIyhGrIclhmY3CKw8tfrF9ew6U+hjN/igz1kPw=;
        b=DST95VOkZbqEUf9rwHFr+9h/xK7HQs7A4rhs3Ns3C6s7pAQRk+hNt4iJIbEu46bIHG
         /crrRYl/ZzQ/OG7Du/qPtRC2FkysgD/Xaz802qtnTcFdRVs0Y3url+q/GoVf0XwWuCN/
         /ftRZxwZgtpQDnjScdQxHslUPm5QBQ1DRyr5eJSUNewlX4Tk3Lslkt+Ifn66V/Pg/5F6
         iDzhtZaj80Z6zhGWtskugkBooeN6sIO8pXv/DLF5AhwqiYEeFw7RD389pxenTKkfiQEK
         aj2hhpsz0L0TDrTpOf/j5HClW5lZ8zLXH/MXwAO0+40EaYwTVdG2PDZsjKpB22s/k82Y
         SJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aes/lBIyhGrIclhmY3CKw8tfrF9ew6U+hjN/igz1kPw=;
        b=F6vLCKCsjPahekw68iSId07ep3gAZSRA/oYCUtC6YyW2LCNyMA/RqNXN+bg00lhD2r
         qhbFwffKc+oLIlKXMf33fjYDr/NvBDBkMftIB4lWfYy6xBAt3bBEV36DOIrWtUPrRZbn
         1AhvCxELYPTkYKZEEXAH2hVfteLoZ5aD9EmJJYiKgZs6aM+rSVSjDSYyiMXyjTLCMuFu
         2EEP9+ol+OaRgWT5Z7ZA3xqcXlu55054jPctvrVoXzYE0HnSQ8j5XMoyU2xXBGAkFzGE
         7dOs/3NI1AkloiWverYhr3xu157KDPPZNeTEBXI12UEe6MztvQ/N4Aw/6Me6iCD9F3es
         /M4w==
X-Gm-Message-State: APjAAAUTJiR22K3dvpDmpGCU0kOGg5urygxqdxBlgKk9u8PhiYMud443
        M3pmUZcrpB0NjMxrWyYnS1jV78JmOP/meQ==
X-Google-Smtp-Source: APXvYqwnoW+/a2xHbBFZa+ognemxP/HCkEIaL/1SjSfdAsqMdMxOu2MZfjhnaHURQExMHvqV/pJz6Q==
X-Received: by 2002:a37:c408:: with SMTP id d8mr27313201qki.18.1562106687957;
        Tue, 02 Jul 2019 15:31:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a21sm87851qkg.47.2019.07.02.15.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 15:31:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hiRJ8-0003Eu-JD; Tue, 02 Jul 2019 19:31:26 -0300
Date:   Tue, 2 Jul 2019 19:31:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Message-ID: <20190702223126.GA11860@ziepe.ca>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
 <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
 <20190627155219.GA9568@ziepe.ca>
 <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
 <MN2PR18MB318228F0D3DA5EA03A56573DA1FC0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <MN2PR18MB3182EC9EA3E330E0751836FDA1F80@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB3182EC9EA3E330E0751836FDA1F80@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 02, 2019 at 12:22:26PM +0000, Michal Kalderon wrote:
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Michal Kalderon
> > 
> > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > owner@vger.kernel.org> On Behalf Of Gal Pressman
> > >
> > > On 27/06/2019 18:52, Jason Gunthorpe wrote:
> > > > On Thu, Jun 27, 2019 at 06:25:37PM +0300, Gal Pressman wrote:
> > > >> On 27/06/2019 16:58, Michal Kalderon wrote:
> > > >>> Create a common API for adding entries to a xa_mmap.
> > > >>> This API can be used by drivers that don't require special mapping
> > > >>> for user mapped memory.
> > > >>>
> > > >>> The code was copied from the efa driver almost as is, just renamed
> > > >>> function to be generic and not efa specific.
> > > >>
> > > >> I don't think we should force the mmap flags to be the same for all
> > > drivers..
> > > >> Take a look at mlx5 for example:
> > > >>
> > > >> enum mlx5_ib_mmap_cmd {
> > > >> 	MLX5_IB_MMAP_REGULAR_PAGE               = 0,
> > > >> 	MLX5_IB_MMAP_GET_CONTIGUOUS_PAGES       = 1,
> > > >> 	MLX5_IB_MMAP_WC_PAGE                    = 2,
> > > >> 	MLX5_IB_MMAP_NC_PAGE                    = 3,
> > > >> 	/* 5 is chosen in order to be compatible with old versions of
> > > >> libmlx5
> > > */
> > > >> 	MLX5_IB_MMAP_CORE_CLOCK                 = 5,
> > > >> 	MLX5_IB_MMAP_ALLOC_WC                   = 6,
> > > >> 	MLX5_IB_MMAP_CLOCK_INFO                 = 7,
> > > >> 	MLX5_IB_MMAP_DEVICE_MEM                 = 8,
> > > >> };
> > > >>
> > > >> The flags taken from EFA aren't necessarily going to work for other
> > > drivers.
> > > >> Maybe the flags bits should be opaque to ib_core and leave the
> > > >> actual mmap callbacks in the drivers. Not sure how dealloc_ucontext
> > > >> is going to work with opaque flags though?
> > > >
> > > > Yes, the driver will have to take care of masking the flags before
> > > > lookup
> > > >
> > > > We should probably store the struct page * in the
> > > > rdma_user_mmap_entry() and use that to key struct page behavior.
> > > I don't follow why we need the struct page? How will this work for MMIO?
> > >
> > > >
> > > > Do you think we should go further and provide a generic mmap() that
> > > > does the right thing? It would not be hard to provide a callback
> > > > that computes the pgprot flags
> > >
> > > I think a generic mmap with a driver callback to do the actual
> > > rdma_user_mmap_io/vm_insert_page/... according to the flags is a good
> > > approach.
> > >
> > > If the flags are opaque to ib_core we'll need another callback to tell
> > > the driver when the entries are being freed. This way, if the entry is
> > > a DMA page for example (stated by the flags), the driver can free these
> > buffers.
> > 
> > I think we'll still end up with a fair amount of duplicated code between a few
> > drivers.
> > How about an optional driver callback to override the default one ?
> > We can start the new flags from a new range that isn't used by the other
> > drivers, If the flag is in a "driver-specific" range and a driver callback for mmap
> > is provided We'll call that function. We can also store in the
> > rdma_user_mmap_entry whether The memory was mapped using driver
> > opaque fields or not, and call the driver Free buffer functions accordingly.
> 
> Jason, 
> 
> Seems except Mellanox + hns the mmap flags aren't ABI. 
> Also, current Mellanox code seems like it won't benefit from 
> mmap cookie helper functions in any case as the mmap function is very specific and the flags used indicate 
> the address and not just how to map it.

IMHO, mlx5 has a goofy implementaiton here as it codes all of the object
type, handle and cachability flags in one thing.

> For most drivers (efa, qedr, siw, cxgb3/4, ocrdma) mmap is called on
> address received by kernel in some response. Meaning driver can
> write anything in the response that will serve as the key / flag.
> Other drivers ( i40iw ) have a simple mmap function that doesn't
> require a mmap database at all.

Are you sure? I thought the reason to have to flags at all was so that
userspace could specify different cachability..

Otherwise the offset should just be an opaque cookie and internal xa
should specify the cachability mode..

Jason
