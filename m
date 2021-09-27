Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1640D419672
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 16:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhI0OeF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 10:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhI0OeF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Sep 2021 10:34:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D809C061575;
        Mon, 27 Sep 2021 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=orJGo1RuUFHCIf3obfYqUs4fubLhRP1M2sWxBbv1mU0=; b=ht+Sduz34yQKStv2n3ObCtkKTF
        wEkl7m9tES10q3fvTT/ZgjHf++1D9neqPG10q/SCc4zYqu0m5zLSV9ElZvGW3FuN8ljAHf6lA50cv
        phHA/+Qm4chrVL+6hn18lr1fLTfMDp9yMES5q+R1dmQMqvmo2tfkRjoPoDcc7q4wTx6F/KvFOHeDJ
        IlgHfblRGAzSK8C8FEYPttOqNiw7gfmdcxrlT4xxsasLXsHSiL+Y9uJwkx50dM0KgQoXbXVLo8ktl
        fx6wcj2Ogr4H8nqkgkOJyfmK3VbJq+jylYRfpCTi55hRWBnd1jiuZ3O6IE0BygKeH7aunVZB9bUZz
        t3BJDHEw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUreZ-009pcs-JC; Mon, 27 Sep 2021 14:31:29 +0000
Date:   Mon, 27 Sep 2021 15:30:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Cai Huoqing <caihuoqing@baidu.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Use dma_alloc_coherent() instead of
 kmalloc/dma_map_single()
Message-ID: <YVHVlzvu58wJlA0t@infradead.org>
References: <20210926061124.335-1-caihuoqing@baidu.com>
 <20210927120235.GB3544071@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927120235.GB3544071@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 27, 2021 at 09:02:35AM -0300, Jason Gunthorpe wrote:
> This I'm not sure about, I see lots of calls to dma_sync_single_* for
> this memory and it is not unconditionally true that using coherent
> memory is better than doing the cache flushes. It depends very much
> on the access pattern.
> 
> At the very least if you convert to coherent memory I expect to see
> the sync's removed too..

In general coherent memory actually is worse for not cache coherent
architectures when you hav chance, an should mkae no difference for
cache coherent ones.  So I'd like to see numbers here instead of a
claim.
