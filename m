Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F67131E6F8
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Feb 2021 08:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBRHap (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 02:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhBRHZY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Feb 2021 02:25:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A61C061756;
        Wed, 17 Feb 2021 23:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/2v+QGn+KU5Y7ETX+f4m+/C9mqYX7kRJpIOupRvF2fw=; b=kyZS8ocnGrcZV4lsTNDl3BpyDz
        dtG2dlWSViX5bE/25KdLYGkIuQbJmPjbol66/1AmOcyvA5cdB5BCSAM62kN93HWw/f3EN80pIPjC5
        TOAPr+85sW+VKW/Cd7u6yd8zjg7ij0DvNXmorpVNT3IjiD7O5MTAFkOxTiKlIjfiYW0+RYubUcRLA
        7SIMfXRuNwqnryEJxN1Kf9Rb1qaeeLPteifBnBlGLowjgJQHr0uDjuHQ7jOaSsgam8vfrxi5LZxwa
        bAhyyADILF6RwTIu/nchrTFTzunLnu00KPL2MaxWz6fG5+9jCjuRNca4vuxqDfA33oDBljBYxd/rT
        1oIXJmBg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCdfs-001Mmr-1K; Thu, 18 Feb 2021 07:24:34 +0000
Date:   Thu, 18 Feb 2021 07:24:32 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 0/4] mm/gup: page unpining improvements
Message-ID: <20210218072432.GA325423@infradead.org>
References: <20210212130843.13865-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212130843.13865-1-joao.m.martins@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 12, 2021 at 01:08:39PM +0000, Joao Martins wrote:
> Hey,
> 
> This series improves page unpinning, with an eye on improving MR
> deregistration for big swaths of memory (which is bound by the page
> unpining), particularly:

Can you also take a look at the (bdev and iomap) direct I/O code to
make use of this?  It should really help there, with a much wieder use
than RDMA.
