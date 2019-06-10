Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC383B6F2
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390712AbfFJOJD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 10:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390707AbfFJOJD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 10:09:03 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7D22207E0;
        Mon, 10 Jun 2019 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560175742;
        bh=Dmhjn6dmerxXt3ol9jRCHnE5w1zR4m9csfEWBzDuhn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3TGXv+nJgo3yOOp07fNs9ycIRFhMbZiT4PcS0cEAJ02ju98idOf2y9PHPKHXF6V+
         w8ZxiPBtWL/+Zz6AQVV3DxIbWnfmd/6CJYLx8IuuIFRoVQGlu4QTyvf9sDzgPcVJou
         XmQ2mMHsCGStAcmRMU6mZ8bQEfW17nWTl9HF3Txs=
Date:   Mon, 10 Jun 2019 17:08:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] IB/mlx4: prevent undefined shift in set_user_sq_size()
Message-ID: <20190610140858.GA6369@mtr-leonro.mtl.com>
References: <20190608092231.GA28890@mwanda>
 <20190610132849.GD18468@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610132849.GD18468@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 10, 2019 at 10:28:49AM -0300, Jason Gunthorpe wrote:
> On Sat, Jun 08, 2019 at 12:22:31PM +0300, Dan Carpenter wrote:
> > The ucmd->log_sq_bb_count is a u8 that comes from the user.  If it's
> > larger than the number of bits in an int then that's undefined behavior.
> > It turns out this doesn't really cause an issue at runtime but it's
> > still nice to clean it up.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/infiniband/hw/mlx4/qp.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
> > index 5221c0794d1d..9f6eb23e8044 100644
> > --- a/drivers/infiniband/hw/mlx4/qp.c
> > +++ b/drivers/infiniband/hw/mlx4/qp.c
> > @@ -439,7 +439,8 @@ static int set_user_sq_size(struct mlx4_ib_dev *dev,
> >  			    struct mlx4_ib_create_qp *ucmd)
> >  {
> >  	/* Sanity check SQ size before proceeding */
> > -	if ((1 << ucmd->log_sq_bb_count) > dev->dev->caps.max_wqes	 ||
> > +	if (ucmd->log_sq_bb_count > 31					 ||
> > +	    (1 << ucmd->log_sq_bb_count) > dev->dev->caps.max_wqes	 ||
>
> Surely this should use check_shl_overflow() ?

Yes

>
> Jason
