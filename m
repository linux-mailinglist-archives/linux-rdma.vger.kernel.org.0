Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4792BC52
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 01:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfE0XMn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 19:12:43 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35513 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfE0XMn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 19:12:43 -0400
Received: by mail-vs1-f68.google.com with SMTP id q13so11583346vso.2
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 16:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wX6N01CkJjaDlOJ1ros8bm2onANhDW8NXyCYvkrtemg=;
        b=CZiPuQaEwv3lqb5SZe/gadbr2on0uyWsxhzjtp+toaxSYDJsJ0veJ+MsHzoIX193A5
         tGyRL3+z39ibqHrkHL4ig8trKDTVq1uE+qiFVL+hYR3cMJo6o4Aspd5k9Fgs+fP8XTOZ
         EBxJZ1nObd0eaWg5uaSRpy2MVza2dQ+cCF/Qs41qm/fon5bRysCHkLJfqF4gN+OpH5zZ
         HsFELDr80DLkXDrbWdXyBCpSqjsGY+tiobrH4KQ86PlJi0KLZWAX8yW8dgduwngWgKtU
         Mr0WcxTALRjcOItn9ozWYXvUi+Rq2hQhmvWnN4sexsY5xyXZZ4wuDkWK4Q22BTIVNblW
         xkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wX6N01CkJjaDlOJ1ros8bm2onANhDW8NXyCYvkrtemg=;
        b=cH3axGi6rPKdQ1nAMYvU3gZC6Z0Jpb5jbU7faHxBZM3zbrhEMxD4znG9jhsXTcnioJ
         2i1x8fe7HzSXprLFkgUG4msj1AXM9BcC4c2vDJXnPBTnyrv3nM9NH0Djs1+Qn5QWMrD9
         IVSnY+aLvd1inipH29mfz8kgP8FpqaMdf9Wqz2cZWpSqwNXkWxNukrIcRMsdld1PgjbB
         xfbyJgWMA+PkHpuY1v4eiiNOnXFWsCHBxGN5XDqzDh8bn69/KuwVeyM7P1JYRgQo3etr
         sPBIocRJwR/1zQF01mGS4FtAViTlMAROG9g3a0UW12yNVZWDKiR07MPUFzDSy6Jtn1y+
         feEw==
X-Gm-Message-State: APjAAAWJEO78IjHTiaKNLk7HkTfLDKTM24ZgIiMgGDO+tzNM2/lWUOBv
        /6yWNR4M3YFerFmwFXJ8+ACgRQ==
X-Google-Smtp-Source: APXvYqy4sB3fYsZi2sRGgGcMy7oWE4xaEc4c4gHWtniQFIlK09l6934M+QPzMYcjxy9CgA/oBmrq0Q==
X-Received: by 2002:a67:fa48:: with SMTP id j8mr50026871vsq.143.1558998761897;
        Mon, 27 May 2019 16:12:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a95sm5421589uaa.13.2019.05.27.16.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 16:12:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVOnI-000638-S7; Mon, 27 May 2019 20:12:40 -0300
Date:   Mon, 27 May 2019 20:12:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     john.hubbard@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v2] infiniband/mm: convert put_page() to put_user_page*()
Message-ID: <20190527231240.GA23224@ziepe.ca>
References: <20190525014522.8042-1-jhubbard@nvidia.com>
 <20190525014522.8042-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190525014522.8042-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 06:45:22PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For infiniband code that retains pages via get_user_pages*(),
> release those pages via the new put_user_page(), or
> put_user_pages*(), instead of put_page()
> 
> This is a tiny part of the second step of fixing the problem described
> in [1]. The steps are:
> 
> 1) Provide put_user_page*() routines, intended to be used
>    for releasing pages that were pinned via get_user_pages*().
> 
> 2) Convert all of the call sites for get_user_pages*(), to
>    invoke put_user_page*(), instead of put_page(). This involves dozens of
>    call sites, and will take some time.
> 
> 3) After (2) is complete, use get_user_pages*() and put_user_page*() to
>    implement tracking of these pages. This tracking will be separate from
>    the existing struct page refcounting.
> 
> 4) Use the tracking and identification of these pages, to implement
>    special handling (especially in writeback paths) when the pages are
>    backed by a filesystem. Again, [1] provides details as to why that is
>    desirable.
> 
> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
> 
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Cc: Christian Benvenuti <benve@cisco.com>
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> Acked-by: Jason Gunthorpe <jgg@mellanox.com>
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c              |  7 ++++---
>  drivers/infiniband/core/umem_odp.c          | 10 +++++-----
>  drivers/infiniband/hw/hfi1/user_pages.c     | 11 ++++-------
>  drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +++---
>  drivers/infiniband/hw/qib/qib_user_pages.c  | 11 ++++-------
>  drivers/infiniband/hw/qib/qib_user_sdma.c   |  6 +++---
>  drivers/infiniband/hw/usnic/usnic_uiom.c    |  7 ++++---
>  7 files changed, 27 insertions(+), 31 deletions(-)

Applied to for-next, thanks

Jason
