Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52DD029A26
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 16:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403917AbfEXOgw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 10:36:52 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40018 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403860AbfEXOgw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 10:36:52 -0400
Received: by mail-ua1-f68.google.com with SMTP id d4so3613037uaj.7
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2019 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GHLEPoYZVhV31cok7KrMb+3z0XgL2p9iJ8cXKGhCP18=;
        b=E/xAAe6YXU9QOMecdpW0NLj4tYVOmUE5cXCSK2GCu8YQ2DQJxh9KpUb9RSJk2uSgHh
         /KL9+bm9kuEEpQLzTzDb86QjLORjOFUCIDZQkZhDO53Sr/pPe2iOWjT/UriVqMv6J0X+
         xoxyXbE4laWCEbFThtbH3bgr435xvqqZCnWJsn9P9lZ9EIypiSnhTOOhQPwM3nZdZOLF
         gV0RUbSemnSX+NLHXTU8193PXMmOWpwPxFI69ut38XuoTTdACIeMyE8MGfs/n0B6jTDp
         Q6hECGn4f1yu/hdO/Mnzz6lLcbF6uBsNCA2/GGUmYwrcdNyWCqeRKOfOoNupCjorJEwA
         KJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GHLEPoYZVhV31cok7KrMb+3z0XgL2p9iJ8cXKGhCP18=;
        b=bkUJXy5d0+kJT/lvUsoeEAJb2MX/0sNUyJgEwypytPrzjtO2YnKfj0NAfehP0quUcl
         ITRkfamFfhUuyiQiMExoFAboAuDMsW7WmfwoC4nr92kC7Bp1z9tdEVpLypGutqZh1MdQ
         w+72j8Njh8f8wyOnR71lQ9JozYYfLkYOqkvf7qbYqiyK62PrAankrXbgXb1Udu3J8JYy
         qJuC0VebXzOk9YL9DvO5l+vXFziqTETIvY5t+3RSgW5ayrITSuXKLapSdUpVrBm/8ils
         +6nRBYmPy6l8O2a9Ag0krlALGLO4PHBVhNgRZnZ/aY22XGVzZ973Y/skD1D9qYDSWhQW
         ZnRw==
X-Gm-Message-State: APjAAAXuha34w1pFHVm3FFves+O+L76hoF5B4AMreoCPGEGw3m/sDULh
        s3xxE/Y6rteL6i6LHZIFjdaAz+SwiUA=
X-Google-Smtp-Source: APXvYqwALepCgA/Gj9CzqFz7y5GIFjL1yFDhI7VMA1q74UV17dLK6TZiq5cYc+zFoe9mNLWCiM208Q==
X-Received: by 2002:a9f:3083:: with SMTP id j3mr8771789uab.110.1558708610924;
        Fri, 24 May 2019 07:36:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id e19sm1569046vsc.24.2019.05.24.07.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 07:36:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hUBJR-0003nG-Pq; Fri, 24 May 2019 11:36:49 -0300
Date:   Fri, 24 May 2019 11:36:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
Message-ID: <20190524143649.GA14258@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523153436.19102-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 12:34:25PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This patch series arised out of discussions with Jerome when looking at the
> ODP changes, particularly informed by use after free races we have already
> found and fixed in the ODP code (thanks to syzkaller) working with mmu
> notifiers, and the discussion with Ralph on how to resolve the lifetime model.

So the last big difference with ODP's flow is how 'range->valid'
works.

In ODP this was done using the rwsem umem->umem_rwsem which is
obtained for read in invalidate_start and released in invalidate_end.

Then any other threads that wish to only work on a umem which is not
undergoing invalidation will obtain the write side of the lock, and
within that lock's critical section the virtual address range is known
to not be invalidating.

I cannot understand how hmm gets to the same approach. It has
range->valid, but it is not locked by anything that I can see, so when
we test it in places like hmm_range_fault it seems useless..

Jerome, how does this work?

I have a feeling we should copy the approach from ODP and use an
actual lock here.

Jason
