Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C38E4991D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 08:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfFRGpK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 02:45:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfFRGpK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 02:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tV99K2d8GVHSoZ145rfgnhmZCC9mL4mRsMkgqsk8d2s=; b=VFk5UR+XIAvFhHNbE76I35I6f
        5p7lqPrAl/jivCCXN+p+cSFmOz9NxFW3q/GzZH2CfzqBSKFufzN+JFGSDjo/dIxQTZiEPsvYYqzWD
        YSzYy9RDgwu/UB1ROaPz1ZEl9EY5pV5O4miFLk1fx7AzfoNx82bqK+GrG6yR/3easJuI6lhk+jWT/
        4WTD218PsDq6oZi0gydoz2rOi9QRbKG9GNJbOSSjtoKSEBW0xsg2awCi5ClkXapFLSGwx0lQwo/Em
        qEOwti0M9nkgYlIwbAtaNtKKmOJzFmEocKqjXkQXMo5T/sbmnRuCRzbmL40TF3q9QQ/oln7clT4Xf
        d4ZT4nuhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hd6oH-000393-RU; Tue, 18 Jun 2019 05:37:33 +0000
Date:   Mon, 17 Jun 2019 22:37:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 11/12] mm/hmm: Remove confusing comment and logic
 from hmm_release
Message-ID: <20190618053733.GA25048@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-12-jgg@ziepe.ca>
 <20190615142106.GK17724@infradead.org>
 <20190618004509.GE30762@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618004509.GE30762@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 17, 2019 at 09:45:09PM -0300, Jason Gunthorpe wrote:
> Am I looking at the wrong thing? Looks like it calls it through a work
> queue should should be OK..

Yes, it calls it through a work queue.  I guess that is fine because
it needs to take the lock again.

> Though very strange that amdgpu only destroys the mirror via release,
> that cannot be right.

As said the whole things looks rather odd to me.
