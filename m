Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F34B399
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfFSIHI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 04:07:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbfFSIHI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 04:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=joSQX+c79LrXwDofUn4UcqKpzHato3fL9zTkPCCp5Mk=; b=WdRlzSpz2usjiHEXhhtXkURap
        JR/ywCqFnns9c9y2t4j4VowNJXeRydRRNboQlVSHN8bq2ehggKbdZH1HlMzQMHyezwSB+PRDQklSm
        QGdvWLYUFZn9VrVTSA3XepaQVYpa+5bgROMB9yzWCXXaKy+/WJuY+VzMSw9v59/fKxlT2CobF5aT/
        iKwPEhqNC+F/eV+jAM/BxqQZIwJr5YGZ/rjVwaXAmRH+b9vNvmm3V2rDsAcKr5ORPlRjhxXjkKPPx
        3nWz74yeA+o4L5ZKbl6tDC67LBLtYr13ByiHJ3KK4La27WSvZ17+VriT5N6Bx7Ur9bTQVNY8zxBGU
        CLLHoGCOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hdVcX-00045B-4O; Wed, 19 Jun 2019 08:07:05 +0000
Date:   Wed, 19 Jun 2019 01:07:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20190619080705.GA5164@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-12-jgg@ziepe.ca>
 <20190615142106.GK17724@infradead.org>
 <20190618004509.GE30762@ziepe.ca>
 <20190618053733.GA25048@infradead.org>
 <be4f8573-6284-04a6-7862-23bb357bfe3c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be4f8573-6284-04a6-7862-23bb357bfe3c@amd.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 19, 2019 at 12:53:55AM +0000, Kuehling, Felix wrote:
> This code is derived from our old MMU notifier code. Before HMM we used 
> to register a single MMU notifier per mm_struct and look up virtual 
> address ranges that had been registered for mirroring via driver API 
> calls. The idea was to reuse a single MMU notifier for the life time of 
> the process. It would remain registered until we got a notifier_release.
> 
> hmm_mirror took the place of that when we converted the code to HMM.
> 
> I suppose we could destroy the mirror earlier, when we have no more 
> registered virtual address ranges, and create a new one if needed later.

I didn't write the code, but if you look at hmm_mirror it already is
a multiplexer over the mmu notifier, and the intent clearly seems that
you register one per range that you want to mirror, and not multiplex
it once again.  In other words - I think each amdgpu_mn_node should
probably have its own hmm_mirror.  And while the amdgpu_mn_node objects
are currently stored in an interval tree it seems like they are only
linearly iterated anyway, so a list actually seems pretty suitable.  If
not we need to improve the core data structures instead of working
around them.
