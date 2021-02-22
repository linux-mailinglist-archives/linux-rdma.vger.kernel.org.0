Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBA53211A6
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 08:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhBVHxt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 02:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhBVHxq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 02:53:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890BBC061574;
        Sun, 21 Feb 2021 23:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hqGoMx9Yapzi0ILQOi0zy5A/uV/LCC4QPknj+HY+INU=; b=EmdXJYOJXjM7STZpMm+JRsjv5p
        g8jamnJj8HF2tF46KSFOBqpCx9zSAUudtn1lPJ5/WVMg1i2agaoR7xfeF2L4sP57cQM7xqW1W/I3O
        Q/qpnEH68D9sPpB9ezdlL44Y+46Ov1/bEqQYMiIAi9Q1eNlvA+VaTRNjMfwsRn9rG7aOAhofTUpau
        j+IZOaEjmRnEn/shL3dVqffZFfVH5mA4yy2KWqfv1Pk17mB9VsLvNVIMAgY/WWD3WqHuOqm12mzbH
        S37wG/jHIZtOJlrIyUD4gE+G4cYhp6TFagVgz38xDBoM/x0Kp1c0NnxkNtImBFpRypqMobgl+g91X
        UBioS/JQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lE61C-006HOz-NC; Mon, 22 Feb 2021 07:52:36 +0000
Date:   Mon, 22 Feb 2021 07:52:34 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 0/4] mm/gup: page unpining improvements
Message-ID: <20210222075234.GA1492783@infradead.org>
References: <20210212130843.13865-1-joao.m.martins@oracle.com>
 <20210218072432.GA325423@infradead.org>
 <a5f7d591-f3aa-1a54-569c-bd1abcb99334@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5f7d591-f3aa-1a54-569c-bd1abcb99334@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 18, 2021 at 03:33:39PM +0000, Joao Martins wrote:
> in a bvec at once? e.g. something like from this:
> 
>         bio_for_each_segment_all(bvec, bio, iter_all) {
>                 if (mark_dirty && !PageCompound(bvec->bv_page))
>                         set_page_dirty_lock(bvec->bv_page);
>                 put_page(bvec->bv_page);
>         }
> 
> (...) to this instead:
> 
> 	bio_for_each_bvec_all(bvec, bio, i)
> 		unpin_user_page_range_dirty_lock(bvec->bv_page,
> 			DIV_ROUND_UP(bvec->bv_len, PAGE_SIZE),
> 			mark_dirty && !PageCompound(bvec->bv_page));

Yes, like that modulo the fix in your reply and any other fixes.
