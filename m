Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 790F6155EBC
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2020 20:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBGTqY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Feb 2020 14:46:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBGTqY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Feb 2020 14:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MRJAZfyI+DPUYAJafF7nxGyfRX9uOty2eCox/3nz/no=; b=YM+PmivThUdMJ5jmolg8uNgZJp
        +2xOME1RexCGlKsXWUBk9tp92oU+hPi4rEezZmdU1xJa/1+t9v1O142GCRcelacVAFIiwR/FgP/Nx
        p8yJKbyGvgWK6wWBlBGr7ITAk/eYLvbWRdjlzezrfhvRG140VaUkSvqEI9FV4Eq0jq57m2ou20c77
        F4p5WAXepFXcWeI0Y+U/K6BaoOqjckjTw1RzuTK0e0Twp8GePH2f/j7c6+KW4HE5Rm04toDnlp10L
        6uKXTdNVZr2iENiI6gqiQGWVRnGaQlZqR1fN5fV5iLlvVAKnH5ELzIesccDh0jZUm7lsexnZKwpjf
        DHepZ6qw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j09a0-0006Xs-Ny; Fri, 07 Feb 2020 19:46:20 +0000
Date:   Fri, 7 Feb 2020 11:46:20 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ira Weiny <iweiny@intel.com>, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Don Dutile <ddutile@redhat.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [LSF/MM TOPIC] get_user_pages() for PCI BAR Memory
Message-ID: <20200207194620.GG8731@bombadil.infradead.org>
References: <20200207182457.GM23346@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200207182457.GM23346@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 07, 2020 at 02:24:57PM -0400, Jason Gunthorpe wrote:
> Many systems can now support direct DMA between two PCI devices, for
> instance between a RDMA NIC and a NVMe CMB, or a RDMA NIC and GPU
> graphics memory. In many system architectures this peer-to-peer PCI-E
> DMA transfer is critical to achieving performance as there is simply
> not enough system memory/PCI-E bandwidth for data traffic to go
> through the CPU socket.
> 
> For many years various out of tree solutions have existed to serve
> this need. Recently some components have been accpeted into mainline,
> such as the p2pdma system, which allows co-operating drivers to setup
> P2P DMA transfers at the PCI level. This has allowed some kernel P2P
> DMA transfers related to NVMe CMB and RDMA to become supported.
> 
> A major next step is to enable P2P transfers under userspace
> control. This is a very broad topic, but for this session I propose to
> focus on initial cases of supporting drivers can setup a P2P transfer
> from a PCI BAR page mmap'd to userspace. This is the basic starting
> point for future discussions on how to adapt get_user_pages() IO paths
> (ie O_DIRECT, net zero copy TX, RDMA, etc) to support PCI BAR memory.
> 
> As all current drivers doing DMA from user space must go through
> get_user_pages() (or its new sibling hmm_range_fault()), some
> extension of the get_user_pages() API is needed to allow drivers
> supporting P2P to see the pages.
> 
> get_user_pages() will require some 'struct page' and 'struct
> vm_area_struct' representation of the BAR memory beyond what today's
> io_remap_pfn_range()/etc produces.
> 
> This topic has been discussed in small groups in various conferences
> over the last year, (plumbers, ALPSS, LSF/MM 2019, etc). Having a
> larger group together would be productive, especially as the direction
> has a notable impact on the general mm.
> 
> For patch sets, we've seen a number of attempts so far, but little has
> been merged yet. Common elements of past discussions have been:
>  - Building struct page for BAR memory
>  - Stuffing BAR memory into scatter/gather lists, bios and skbs
>  - DMA mapping BAR memory
>  - Referencing BAR memory without a struct page
>  - Managing lifetime of BAR memory across multiple drivers
> 
> Based on past work, the people in the CC list would be recommended
> participants:
> 
>  Christian König <christian.koenig@amd.com>
>  Daniel Vetter <daniel.vetter@ffwll.ch>
>  Logan Gunthorpe <logang@deltatee.com>
>  Stephen Bates <sbates@raithlin.com>
>  Jérôme Glisse <jglisse@redhat.com>
>  Ira Weiny <iweiny@intel.com>
>  Christoph Hellwig <hch@lst.de>
>  John Hubbard <jhubbard@nvidia.com>
>  Ralph Campbell <rcampbell@nvidia.com>
>  Dan Williams <dan.j.williams@intel.com>
>  Don Dutile <ddutile@redhat.com>

That's a long list, and you're missing 

"Thomas Hellström (VMware)" <thomas_os@shipmail.org>
Joao Martins <joao.m.martins@oracle.com>

both of whom have been working on related projects (for PFNs without pages).
Hey, you missed me too!  ;-)

