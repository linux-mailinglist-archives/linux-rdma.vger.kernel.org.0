Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2BF426A8
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfFLMvQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 08:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730126AbfFLMvQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 08:51:16 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB5B820684;
        Wed, 12 Jun 2019 12:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560343875;
        bh=alzSa469y1JJr5q3B5Ji9KiBoNZToIKLnxh/GgiYEuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SUjEd4L42pdV25ROJM8YvrKiuXnPqnPKXyh3Z83hT2v8pnk2tAP75csoMhqK2HbU/
         XY0YIwB+SHtYiQSX9TNFYLu1On2Zj5LvFmH+REMwXBWHmYlvQomCX+W3T5XOzlvLwQ
         TILqkXWBivWYz5inHOyrvekl+xnm6fx91W9vd8S0=
Date:   Wed, 12 Jun 2019 15:51:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA: Convert destroy_wq to be void
Message-ID: <20190612125112.GR6369@mtr-leonro.mtl.com>
References: <20190612122741.22850-1-leon@kernel.org>
 <20190612124049.GA2448@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612124049.GA2448@lap1>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 03:40:50PM +0300, Yuval Shaia wrote:
> On Wed, Jun 12, 2019 at 03:27:41PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > All callers of destroy WQ are always success and there is no need
> > to check their return value, so convert destroy_wq to be void.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/verbs.c      | 12 +++++-------
> >  drivers/infiniband/hw/mlx4/mlx4_ib.h |  2 +-
> >  drivers/infiniband/hw/mlx4/qp.c      |  4 +---
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
> >  drivers/infiniband/hw/mlx5/qp.c      |  4 +---
> >  include/rdma/ib_verbs.h              |  2 +-
> >  6 files changed, 10 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > index 2fb834bb146c..d55f491be24f 100644
> > --- a/drivers/infiniband/core/verbs.c
> > +++ b/drivers/infiniband/core/verbs.c
> > @@ -2344,19 +2344,17 @@ EXPORT_SYMBOL(ib_create_wq);
> >   */
> >  int ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
>
> So why this one left out of this change?

This function can return -EBUSY.

>
> >  {
> > -	int err;
> >  	struct ib_cq *cq = wq->cq;
> >  	struct ib_pd *pd = wq->pd;
> >
> >  	if (atomic_read(&wq->usecnt))
> >  		return -EBUSY;

Thanks
