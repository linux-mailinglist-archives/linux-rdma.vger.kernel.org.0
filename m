Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CB3155FD5
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2020 21:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgBGUmF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Feb 2020 15:42:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGUmF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Feb 2020 15:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hC4I5nJwx7uto4FIN8Dk9Z+Eyug283kzyKTXci+gNBs=; b=Tw6wTJ0KsV0PA0kwHG0T+3GxJm
        WWRdxxjvyRklhUCQmYltYLKnmSGeqcw1JILVQ/pe+fHuBfsCOg/Hvwkhd0LB8Hj++M1606r8ltQgz
        4chq38ObnDTsiIst+PWX3UdXaWAtwYGIzHVB4Ixu8sXUvtjJeYPouhSC0dNLvozInAU0P9a0dK+o0
        0lRNpmR3vEHY5svMECArN0tnwk7Zdo+/4FjE2/E6Ot7QaA91vwDaRUl7aNCw6xYSuyWtZfruswHWl
        sN9fr8yGRYzm6+fHnREuFLLa4VcH9bbgC33EKWeA25QsSS177P3XWWdawSwjjFSVAbZapYHqPZfQl
        7x305BrA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j0ARu-0001cQ-03; Fri, 07 Feb 2020 20:42:02 +0000
Date:   Fri, 7 Feb 2020 12:42:01 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Don Dutile <ddutile@redhat.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [LSF/MM TOPIC] get_user_pages() for PCI BAR Memory
Message-ID: <20200207204201.GH8731@bombadil.infradead.org>
References: <20200207182457.GM23346@mellanox.com>
 <20200207194620.GG8731@bombadil.infradead.org>
 <20200207201351.GN23346@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200207201351.GN23346@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 07, 2020 at 04:13:51PM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 07, 2020 at 11:46:20AM -0800, Matthew Wilcox wrote:
> > > 
> > >  Christian König <christian.koenig@amd.com>
> > >  Daniel Vetter <daniel.vetter@ffwll.ch>
> > >  Logan Gunthorpe <logang@deltatee.com>
> > >  Stephen Bates <sbates@raithlin.com>
> > >  Jérôme Glisse <jglisse@redhat.com>
> > >  Ira Weiny <iweiny@intel.com>
> > >  Christoph Hellwig <hch@lst.de>
> > >  John Hubbard <jhubbard@nvidia.com>
> > >  Ralph Campbell <rcampbell@nvidia.com>
> > >  Dan Williams <dan.j.williams@intel.com>
> > >  Don Dutile <ddutile@redhat.com>
> > 
> > That's a long list, and you're missing 
> > 
> > "Thomas Hellström (VMware)" <thomas_os@shipmail.org>
> > Joao Martins <joao.m.martins@oracle.com>
> 
> Great, thanks, I'm not really aware of what the related work is
> though?

Thomas has been working on huge pages for graphics BARs, so that's involved
touching 'special' (ie pageless) VMAs:
https://lore.kernel.org/linux-mm/20200205125353.2760-1-thomas_os@shipmail.org/

Joao has been working on removing the need for KVM hosts to have struct pages
that cover the memory of their guests:
https://lore.kernel.org/linux-mm/20200110190313.17144-1-joao.m.martins@oracle.com/

> > both of whom have been working on related projects (for PFNs without pages).
> > Hey, you missed me too!  ;-)
> 
> Ah I was not daring to propose a discussion on 'PFNs without pages'
> again :)
> 
> The early exploratory work here has been creating ZONE_DEVICE pages as
> is already done for P2P and now moving to also mmap them to userspace.

Dynamically allocating struct pages interests me too ;-)
