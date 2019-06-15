Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C08847061
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2019 16:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfFOORc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Jun 2019 10:17:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfFOORc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Jun 2019 10:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RsiIOe9hz9lv0grh/5TETFa2K+PcFkUA7+fv86fOR5Y=; b=ZGV0NCi9ysO0XtRDFkLleOXhx
        Pytm+wwoUaqIyplTuPpzPx/Um5MRpO7oD21ESdm15ZuobrU5ByqxevsIgAb+esf98ncN5O3TO/gi5
        ngxJcin5B8yz8EStFibw7qlVy26TuST04itrGnYArJ0P8gvRWor6jkiZgOlB+tIDErzLL5J8u9E5G
        3B+q8ub4IIQvi1S4JxhxHCfMFg14viWDC3mbn+ho1Uuql4o+caakGrzhtD/njve0bkvHan7V4u1hb
        VHQQPTjV8xX35xtkkXqXRC6KHzFfG6KaCEfn4GZ5MW//F208juEbvZsLmv9LYpKHc8f3ys425dOWH
        Ta35tRB7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hc9Ul-0004Sq-0D; Sat, 15 Jun 2019 14:17:27 +0000
Date:   Sat, 15 Jun 2019 07:17:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 09/12] mm/hmm: Poison hmm_range during unregister
Message-ID: <20190615141726.GI17724@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-10-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614004450.20252-10-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -	/* Sanity check this really should not happen. */
> -	if (hmm == NULL || range->end <= range->start)
> -		return;
> -
>  	mutex_lock(&hmm->lock);
>  	list_del_rcu(&range->list);
>  	mutex_unlock(&hmm->lock);
>  
>  	/* Drop reference taken by hmm_range_register() */
> -	range->valid = false;
>  	mmput(hmm->mm);
>  	hmm_put(hmm);
> -	range->hmm = NULL;
> +
> +	/*
> +	 * The range is now invalid and the ref on the hmm is dropped, so
> +         * poison the pointer.  Leave other fields in place, for the caller's
> +         * use.
> +         */
> +	range->valid = false;
> +	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));

Formatting seems to be messed up.  But again I don't see the value
in the poisoning, just let normal linked list debugging do its work.
The other cleanups looks fine to me.
