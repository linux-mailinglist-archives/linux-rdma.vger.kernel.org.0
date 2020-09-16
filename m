Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AF126CAB9
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 22:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgIPUMr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 16:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgIPRdP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Sep 2020 13:33:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224FEC0611BC
        for <linux-rdma@vger.kernel.org>; Wed, 16 Sep 2020 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4wznqW8sJC/0q9lNoQI6hGqPXPHTmstMHUvp3dMrl48=; b=tNoZZEb1XI4HML39d9ImdTqXlb
        ODlAukzqQWZIsSSo0Vz7o/9gZcpICOsTMCXOvFMhj/jA4P25r4MzpdomQRUS3VebGQzYAokNkMBwT
        gcStugy6Purmfrp7qj1x7g9rF86FEfBccGMgjqQBg+cmdZRE0U9S3NB7bDjAUu1Bi8468Fxw9gyyi
        H+T+3PNoDqrqp38/OhV2xUTrzBLdzH7mRohneiG7DS0Wr9hGlnlgvTfWmy0aoVfMs28HUiBQDdKRh
        OzWoWtKCygID9EPdYw2c8hVcppyx1PzgmZ6EHfTBnMeEuMOouV0kUlPvpVyBXLj4gawbCX16MWI48
        bJVSpGjw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIb8k-0006HN-3X; Wed, 16 Sep 2020 17:22:42 +0000
Date:   Wed, 16 Sep 2020 18:22:42 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
Message-ID: <20200916172242.GA24005@infradead.org>
References: <20200914113949.346562-1-leon@kernel.org>
 <20200914113949.346562-2-leon@kernel.org>
 <20200916164516.GA11582@infradead.org>
 <20200916172100.GE3699@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916172100.GE3699@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 16, 2020 at 02:21:00PM -0300, Jason Gunthorpe wrote:
> +               dma_addr = dma & ODP_DMA_ADDR_MASK;
> +               if (dma_addr) {
> 
> > But more importantly except for (dma_addr_t)-1 (DMA_MAPPING_ERROR)
> > all dma_addr_t values are valid, so taking more than a single bit
> > from a dma_addr_t is not strictly speaking correct.
> 
> This is the result of dma_map_page(). The HW requires that
> dma_map_page(page_size) returns a DMA address that is page_size
> aligned, even for huge pages.
> 
> So at least the last 12 bits of the DMA address are always 0, they can
> be used for flags. This is also the HW representation in the page
> table.
> 
> Last time you pointed at this code you agreed this alignment was met,
> is it still OK?

True, the alignment actually makes this work.  I'd still suggest to
throw in a comment about the actual usage.
