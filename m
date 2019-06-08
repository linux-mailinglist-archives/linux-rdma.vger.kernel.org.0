Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E405A39BF0
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 10:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFHIya (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 04:54:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfFHIya (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Jun 2019 04:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f1hJhow60v+LJiQ/UMCdIN+9Bx8ZXj0xQ+YgDg2iVzc=; b=gTClu4LEf03iqlVKsw61uPJ0B
        pS9Ck86baVc6Sm95eVVSUUBhBhNbUwnwFz+jQttEnVDd4gBod0YA7TIWl1eHagLumRzZpfFM0dOa1
        5YBQQ0X7x8gVGzHHWCIyyr4G7qROkOfLdQRDhC1QQF19EULewSw3heaYsnb1gnBDib6CvUBig7tBV
        zz/Vshh8/4EKjmDFCJxFS6vzexhFNVtxzTTzT2xdxue69XMKFDaWjnyOGWD1m+w/kdXjsgjxB8BDl
        ONOuSdIYi82tzxuRKOqBnqQfOWCtkGuNzVDEk7uzCpwoBT9zpbo71D0cotxdv7X9eZVj/OcRfy+4I
        cUXwYfNqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hZX7J-0003Ez-Ag; Sat, 08 Jun 2019 08:54:25 +0000
Date:   Sat, 8 Jun 2019 01:54:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 hmm 02/11] mm/hmm: Use hmm_mirror not mm as an
 argument for hmm_range_register
Message-ID: <20190608085425.GB32185@infradead.org>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-3-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606184438.31646-3-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

FYI, I very much disagree with the direction this is moving.

struct hmm_mirror literally is a trivial duplication of the
mmu_notifiers.  All these drivers should just use the mmu_notifiers
directly for the mirroring part instead of building a thing wrapper
that adds nothing but helping to manage the lifetime of struct hmm,
which shouldn't exist to start with.
