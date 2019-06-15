Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 459644705D
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2019 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfFOOOi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Jun 2019 10:14:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfFOOOi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Jun 2019 10:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6K3IZWimfXFDx5zlj0FydVfqj2gXTabKUZsGz9eiwgw=; b=NDaar3aYYUTqIadeUzt3fjl5e
        xTvini6vXAxFVVQTpQjC/ZVFmzryOfabxlaFlyZA9bhVT+06royjNgkE6cNob+/+Zo0FZs6bvV6i2
        VV99tEpby1InU8VhqJHXDCu8OrpmNPZf177PEPtOvB64PS4aPV7XjPvCz0pCp9kzA00pOYzzGBUDW
        GenFaGRR1yzUlw7nCrOkq+FP9YqBtZNwe1bMN2gEUOqCCy6Na/j6nAQDBCzPKIOyZbbXEwoKCXER8
        g8r+0iep8vK1xgNwY+knre1ESI1PCehtG9SiyEQby/7Vugv6F9vqNXIS2/CraTZJ8jq/eDJjaRazX
        3ehroctrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hc9Rz-0002Dl-UH; Sat, 15 Jun 2019 14:14:35 +0000
Date:   Sat, 15 Jun 2019 07:14:35 -0700
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
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 06/12] mm/hmm: Hold on to the mmget for the
 lifetime of the range
Message-ID: <20190615141435.GF17724@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-7-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614004450.20252-7-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>  	mutex_lock(&hmm->lock);
> -	list_for_each_entry(range, &hmm->ranges, list)
> -		range->valid = false;
> -	wake_up_all(&hmm->wq);
> +	/*
> +	 * Since hmm_range_register() holds the mmget() lock hmm_release() is
> +	 * prevented as long as a range exists.
> +	 */
> +	WARN_ON(!list_empty(&hmm->ranges));
>  	mutex_unlock(&hmm->lock);

This can just use list_empty_careful and avoid the lock entirely.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
