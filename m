Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5BEE7504
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 16:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfJ1P0O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 11:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJ1P0O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 11:26:14 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED58921783;
        Mon, 28 Oct 2019 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572276373;
        bh=TSW9WUhS+AO6NSG6qmWuwjzu0w8iv1aBAXI7F9W8B5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aub9s7mYM9+pBbVpOdhsi1e1Om0bnJY3S1l0rsjdakbrqe0ewS/bQOAXfncq8Winh
         3JXntQhVxzoHaoHbzSri679xtP/y67OLfdLvwjkERwI6XjJ95mgkUxHab5vMmsMi37
         /QnvDav/NEPNI69Hy3FNTzvFX8576bq9Kj21hFwc=
Date:   Mon, 28 Oct 2019 17:26:09 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Hefty, Sean" <sean.hefty@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/ucma: Protect kernel from QPN larger than
 declared in IBTA
Message-ID: <20191028152609.GK5146@unreal>
References: <20191028134444.25537-1-leon@kernel.org>
 <BYAPR11MB315708DABE251D7BDE8BB49F9E660@BYAPR11MB3157.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB315708DABE251D7BDE8BB49F9E660@BYAPR11MB3157.namprd11.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 03:09:26PM +0000, Hefty, Sean wrote:
> > IBTA declares QPN as 24bits, mask input to ensure that kernel
> > doesn't get higher bits.
> >
> > Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  * Not fully tested yet, passed sanity tests for now.
> > ---
> >  drivers/infiniband/core/ucma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> > index 0274e9b704be..57e68491a2fd 100644
> > --- a/drivers/infiniband/core/ucma.c
> > +++ b/drivers/infiniband/core/ucma.c
> > @@ -1045,7 +1045,7 @@ static void ucma_copy_conn_param(struct rdma_cm_id *id,
> >  	dst->retry_count = src->retry_count;
> >  	dst->rnr_retry_count = src->rnr_retry_count;
> >  	dst->srq = src->srq;
> > -	dst->qp_num = src->qp_num;
> > +	dst->qp_num = src->qp_num & 0xFFFFFF;
>
> Why not isolate IBTA restrictions in the ib_cm?

AFAIK, there are many places in IB/core code which assume that type of
restriction, so it is safer and cleaner to sanitize input as early as
possible.

Thanks
