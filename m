Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E86121CACB
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2020 19:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgGLRlv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jul 2020 13:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbgGLRlv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Jul 2020 13:41:51 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70CBF2063A;
        Sun, 12 Jul 2020 17:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594575711;
        bh=S++BkTob+ttQM5Y7QuHWopUrRLTDf/kvLAJ3ywexFg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lipNxcWYyFYNcwC4+SDD61u5aHtBhBjD82OcxX9oAJxyxDOOlrHu0W2aIiyQNhKem
         wmU8JLFdcP2qu7xm7eVFBGrxTH1yog+YrXhlnaqupoWdpi0cxydX8RO2OLGAAn7ypQ
         OLgUw7HljFHI8wom4rksZY2068KdoBXCpZhdSzUU=
Date:   Sun, 12 Jul 2020 20:41:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v2] RDMA/mlx5: Use xa_lock_irq when access to SRQ
 table
Message-ID: <20200712174147.GD7287@unreal>
References: <20200712102641.15210-1-leon@kernel.org>
 <20200712143306.GT12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712143306.GT12769@casper.infradead.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 12, 2020 at 03:33:06PM +0100, Matthew Wilcox wrote:
> On Sun, Jul 12, 2020 at 01:26:41PM +0300, Leon Romanovsky wrote:
> > Fixes: b02a29eb8841 ("mlx5: Convert mlx5_srq_table to XArray")
> > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> > v2:
> >  * Dropped wrong hunk
> > v1:
> > https://lore.kernel.org/linux-rdma/20200707131551.1153207-1-leon@kernel.org
> >  * I left Fixes as before to make sure that it is taken properly to stable@.
> >  * xa_lock_irqsave -> xa_lock_irq
>
> But it won't be taken properly to stable.  It's true that that's the
> earliest version that this applies to, but as far as I can tell the
> underlying bug is there a lot earlier.  It doesn't appear to be there
> in e126ba97dba9edeb6fafa3665b5f8497fc9cdf8c as the cq->lock is taken
> irqsafe in mlx5_ib_poll_cq() before calling mlx5_poll_one() which calls
> handle_responder() which calls mlx5_core_get_srq(), but it was there
> before b02a29eb8841.  I think it's up to you to figure out which version
> this bug was introduced in, because stable still cares about trees before
> 5.2 (which is when b02a29eb8841 was introduced).  You'll also have to
> produce a patch for those earlier kernels.

Of course, but first I would like to be sure that Sasha's autosel will
work out-of-box.

Thanks
