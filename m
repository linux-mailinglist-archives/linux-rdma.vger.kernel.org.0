Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE0D27D557
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 20:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgI2SCU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 14:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgI2SCT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 14:02:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B82C061755
        for <linux-rdma@vger.kernel.org>; Tue, 29 Sep 2020 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EnTwQvSRGRX3sZMuLpt7EZuohSgEwT9nTEzKcYi85s4=; b=aQEk12IIcUYRTjcg56+1jFW9Qz
        xfEMdP3JQCysn+gAXWr53i8Ovii8+AC968JmsonhgY/ke2UPCcu5/sPnRqZLFdhTFYX3pJfYYE5po
        ojY7Z5spQRT7WOGsDpaSEEChMDBMNuQripC/tCc+irikjPQVL/C+3cO9S0lo999s41KZWSDw4JEGN
        ++B8dJ1ftF7KuC7ClgSq8LpoRF3GImmmSqrZ8ZNKRH8Px4o0fcJph00aIDsy6nxOysGTuxowNw4Ux
        UsjOktSutWgihypgmGoo/E+kNMF6bPiidxspcIQnbp0mIpfBKip/GnYCgrVHvQhiYgHGCFWObnOQy
        /SNHQl3g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNJx4-0001Ly-3n; Tue, 29 Sep 2020 18:02:10 +0000
Date:   Tue, 29 Sep 2020 19:02:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v2 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
Message-ID: <20200929180210.GA5012@infradead.org>
References: <20200922082104.2148873-1-leon@kernel.org>
 <20200922082104.2148873-2-leon@kernel.org>
 <20200929175946.GA767138@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929175946.GA767138@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 02:59:46PM -0300, Jason Gunthorpe wrote:
> This leaves *dma_addr set to ib_dma_mapping_error, which means the
> next try to map it will fail the if (!dma_addr) and produce a
> corrupted dma address.
> 
> *dma_addr should be set to 0 here

Maybe the code should use DMA_MAPPING_ERROR as the sentinel for a
not mapped entry?
