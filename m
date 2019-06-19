Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3AB14B79A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 14:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbfFSMDy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 08:03:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSMDy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 08:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rpMV7cbut4s+IQIkL5i+Lot01IcGhFHyq5nHVaZpyng=; b=A3pdiP1QbGW7j1ii05qxyfW2d
        z2qWT3JMlbvwTaaGM6TU/h2nYOMIvaXje6Q6y4HsvNBZc0iGHnfDo+NQ+G0p6dmIxFeBGpgH6qk94
        Qz8DrSDN+V1whr/dlswoX96DK23SXFL9fT7XsSjbiwXmAy95IK66enm+Ch1PvM7tn+mByWUHILn5t
        7+3TE7IgkaNMpg25l4tHj+JHg5MHS3C+ZGVeA1WZoGfjO+BBNSq5pFAl385pU0bkwQkM0g0LWFXoq
        opbr1HMuE4YnTZ1cNQkIBJSa1mkUsWPaDzcEFkaIEBG6o4aSkJJ93fstPOWzbSe/gISzlgPwN0WGz
        qh7SYpIgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hdZJg-0000AR-8n; Wed, 19 Jun 2019 12:03:52 +0000
Date:   Wed, 19 Jun 2019 05:03:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Yang, Philip" <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 11/12] mm/hmm: Remove confusing comment and logic
 from hmm_release
Message-ID: <20190619120352.GA31563@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-12-jgg@ziepe.ca>
 <20190615142106.GK17724@infradead.org>
 <20190618004509.GE30762@ziepe.ca>
 <20190618053733.GA25048@infradead.org>
 <be4f8573-6284-04a6-7862-23bb357bfe3c@amd.com>
 <20190619080705.GA5164@infradead.org>
 <20190619115632.GC9360@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619115632.GC9360@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 19, 2019 at 08:56:32AM -0300, Jason Gunthorpe wrote:
> This looks a lot like the ODP code (amdgpu_mn_node == ib_umem_odp)
> 
> The interval tree is to quickly find the driver object(s) that have
> the virtual pages during invalidation:
> 
> static int amdgpu_mn_sync_pagetables_gfx(struct hmm_mirror *mirror,
>                         const struct hmm_update *update)
> {
>         it = interval_tree_iter_first(&amn->objects, start, end);
>         while (it) {
>                 [..]
>                 amdgpu_mn_invalidate_node(node, start, end);
> 
> And following the ODP model there should be a single hmm_mirror per-mm
> (user can fork and stuff, this is something I want to have core code
> help with). 

That makes the hmm_mirror object pretty silly, though as the scope
is then exactly the same as the mmu_notifier itself.

> The hmm_mirror can either exist so long as objects exist, or it can
> exist until the chardev is closed - but never longer than the
> chardev's lifetime.
> 
> Maybe we should be considering providing a mmu notifier & interval
> tree & lock abstraction since ODP & AMD are very similar here..

It defintively sounds like a good idea to move this kind of object
management into common code.  Nouvea actually seems like the odd one
out here by not having a list of objects below the mirror, but then
again and interval tree with a single entry wouldn't really hurt it
either.
