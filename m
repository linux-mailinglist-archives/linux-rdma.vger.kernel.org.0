Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD7E317432
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 00:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhBJXSM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 18:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbhBJXQE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 18:16:04 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE53C06174A
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 15:15:21 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id r77so3518335qka.12
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 15:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A04FuOuabEMWMqveDhzS7fg2WzWndmfaSzVZorZ+JI4=;
        b=Ns6JsN5qtazoElgRVa0XnesDAewJX8RsV7itNxt5qvvBLLHy/UriQTck5x0LZ9beto
         KKJ5qWgZml/d78AylTy0WklTEY6iXsvfzstAuvjTjSC1CvQcq2apajyQRHHIMIvKcThx
         QT8LYwYOUm0Q6v33vq5gHvc5z+WyzANkliH+ZX5NnlQMHmz5xklxZxj/GfKY6pzGn3vV
         DwlUoYralmok9ceHhE7tzViRJ/DgY/GA6UQLXKrLTTHl/AITMqXzQ3cFx3TNaBYg8wgd
         UCQA1zOj1JJduZAv+MI3LPB30Azslwcn0fNmd+n/a8t7sPvpFAA/6cjhZ6aQb4qHmWSw
         pVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A04FuOuabEMWMqveDhzS7fg2WzWndmfaSzVZorZ+JI4=;
        b=iuYOUuNkWyqPTgnjlXtafZfKNrMaUT2NZSRuU56k3WUjMoPpKtowjKI622grAw4ABL
         VAJIVmtXr+i0tWUu9Z+MZ6YV7XT611QH4HERotAgmtLCu77N7Qq0zBtDCG+0XWhPEyvb
         Y+ubbVdL9FekeXC+6FM8FwntZXHhlto/c+TMb+pkdil8REoRXlcnLOAfFZdnZSv+qRdw
         ActBt3onbChOVyd178OEwjgpP7D4fHZX9pw9OHJR/ryWRaA/bsrVGcPhtnWBT0c84gLg
         G5p3f6ZdTiWvagxBuAsDXNpAkYOqYX0cq2sk9Rh+grwJhrz9zRd6w0WDzdEUuk9CkRb0
         EzGw==
X-Gm-Message-State: AOAM533c+t7owPOWdEJQQhxGLRNa2hLetpZe4bW+m3uD40r4UlfZSSOm
        wc038a6t0zORMqwDdRzkTJojozXu8mfflIlh
X-Google-Smtp-Source: ABdhPJzLnS834YVlzUo+5rDNp+XKYxMN4n/BJsoIOChs0YKKyZain+hoQIvek3LZAAen3REy/aAD3A==
X-Received: by 2002:a05:620a:38e:: with SMTP id q14mr5930060qkm.239.1612998920655;
        Wed, 10 Feb 2021 15:15:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id k4sm167813qth.40.2021.02.10.15.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:15:19 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9yhb-006HKg-5i; Wed, 10 Feb 2021 19:15:19 -0400
Date:   Wed, 10 Feb 2021 19:15:19 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 3/4] mm/gup: add a range variant of
 unpin_user_pages_dirty_lock()
Message-ID: <20210210231519.GR4718@ziepe.ca>
References: <20210205204127.29441-1-joao.m.martins@oracle.com>
 <20210205204127.29441-4-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205204127.29441-4-joao.m.martins@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 05, 2021 at 08:41:26PM +0000, Joao Martins wrote:
> Add a unpin_user_page_range_dirty_lock() API which takes a starting page
> and how many consecutive pages we want to unpin and optionally dirty.
> 
> To that end, define another iterator for_each_compound_range()
> that operates in page ranges as opposed to page array.
> 
> For users (like RDMA mr_dereg) where each sg represents a
> contiguous set of pages, we're able to more efficiently unpin
> pages without having to supply an array of pages much of what
> happens today with unpin_user_pages().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/linux/mm.h |  2 ++
>  mm/gup.c           | 62 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +/**
> + * unpin_user_page_range_dirty_lock() - release and optionally dirty
> + * gup-pinned page range
> + *
> + * @page:  the starting page of a range maybe marked dirty, and definitely released.
> + * @npages: number of consecutive pages to release.
> + * @make_dirty: whether to mark the pages dirty
> + *
> + * "gup-pinned page range" refers to a range of pages that has had one of the
> + * get_user_pages() variants called on that page.

Tidy this language though, this only works with the pin_user_pages
variants because it hardwires FOLL_PIN

Jason
