Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1041C8D15
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 17:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfJBPlU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 11:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfJBPlU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 11:41:20 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA8C21920;
        Wed,  2 Oct 2019 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570030880;
        bh=G9b9H4Ba9/KnqAf09eVEq9r579LWEnDFh3EoQ7Za7G8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMEi8zbBkDJSoy1lZV/5BtQa4VbvRxnesH26WL/9INPYCCnMyjc/a51TDT8sz9QV8
         IXqtSmtZJKqjwb+N4e93JosO3mSUmWB4fAaJUJ9RCETmRsqUluQijCxQmZ0MVfZaOr
         kuQRTGi37q+5ocj0Y0QTxFQ7/MfpeyOZfinSG5zY=
Date:   Wed, 2 Oct 2019 18:41:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Artemy Kovalyov <artemyko@mellanox.com>
Subject: Re: [PATCH 2/6] RDMA/mlx5: Fix a race with mlx5_ib_update_xlt on an
 implicit MR
Message-ID: <20191002154114.GF5855@unreal>
References: <20191001153821.23621-1-jgg@ziepe.ca>
 <20191001153821.23621-3-jgg@ziepe.ca>
 <20191002081826.GA5855@unreal>
 <20191002143928.GE17152@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002143928.GE17152@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 02, 2019 at 11:39:28AM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 02, 2019 at 11:18:26AM +0300, Leon Romanovsky wrote:
> > > @@ -202,15 +225,22 @@ static void mr_leaf_free_action(struct work_struct *work)
> > >  	struct ib_umem_odp *odp = container_of(work, struct ib_umem_odp, work);
> > >  	int idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
> > >  	struct mlx5_ib_mr *mr = odp->private, *imr = mr->parent;
> > > +	struct ib_umem_odp *odp_imr = to_ib_umem_odp(imr->umem);
> > > +	int srcu_key;
> > >
> > >  	mr->parent = NULL;
> > >  	synchronize_srcu(&mr->dev->mr_srcu);
> >
> > Are you sure that this line is still needed?
>
> Yes, in this case the mr->parent is the SRCU 'update' and it blocks
> seeing this MR in the pagefault handler.
>
> It is necessary before calling ib_umem_odp_release below that frees
> the memory

sorry for not being clear, I thought that synchronize_srcu() should be
moved after your read_lock/unlock additions to reuse grace period.

Thanks

>
> Jason
