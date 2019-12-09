Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5D611741A
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2019 19:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfLISZw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Dec 2019 13:25:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfLISZw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Dec 2019 13:25:52 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6DDB2077B;
        Mon,  9 Dec 2019 18:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575915951;
        bh=0x24JbKtdKPgiAN8s6OzmJaIhlnMzm4HgL/VS3/HRF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnGDGGKR61nsPfye0idSv4CQ458wRafaZkQmQZCr4nXClHZRBL14FF5hzcL+Iwr+5
         hgKqXB4UAbwN8iFUPw+yFGaciUZ6nXVQwOXuO2IkSomP69aIOFbEOljPCDWfbrHpqd
         RXE7T3sI5DbZKTd2gmfnMybXHlxuYQ7vJwugYwdw=
Date:   Mon, 9 Dec 2019 20:25:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 2/2] IB/umem: use get_user_pages_fast() to pin DMA
 pages
Message-ID: <20191209182547.GD67461@unreal>
References: <20191204213603.464373-1-jhubbard@nvidia.com>
 <20191204213603.464373-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204213603.464373-3-jhubbard@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 04, 2019 at 01:36:03PM -0800, John Hubbard wrote:
> And get rid of the mmap_sem calls, as part of that. Note
> that get_user_pages_fast() will, if necessary, fall back to
> __gup_longterm_unlocked(), which takes the mmap_sem as needed.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
