Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E18444253
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 14:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhKCN1J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 09:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231393AbhKCN1J (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Nov 2021 09:27:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 290BD60E98;
        Wed,  3 Nov 2021 13:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635945872;
        bh=Zx9q3zIGkX8pNCY7LYwd4eL/DfJAa27wrbvPxkrl3pA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P2wdRaY82iIc2FbPz4/WSPYZ1taBF8K01r/K1svfT38BtERn9GUJXzvdCNYUwdljh
         3ALVSbI5lnAmr+xVj8S3SoLpvu8ob/AV82P9PNEJSjTesL0JBuSPQ56epF35L/50Vg
         Pr2YrBB0+K5Xq0s1NbQzbGuXczHA+EtHZPdn7yIakqhM73VXHpc6FQ3QanQX164vyC
         VBcM53CqMe3nGOJQxKlwCQ6xG7/iQD/dU5kAiOlEIlPTuKyzgYfO7PmKnm7ww7+URH
         Go9opsSiCXlbvNmRDO3bw7mFhnIjpQxVo0ZwFOUNkdRQhT960QIbsXQ/blgu/MmBY+
         /Fzd6fw8v5v6A==
Date:   Wed, 3 Nov 2021 15:24:28 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Rely on vendors to set right IOVA
Message-ID: <YYKNjKcy9j5f3o8E@unreal>
References: <4b0a31bbc372842613286a10d7a8cbb0ee6069c7.1635400472.git.leonro@nvidia.com>
 <20211103125144.GB1298412@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103125144.GB1298412@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 03, 2021 at 09:51:44AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 28, 2021 at 08:55:22AM +0300, Leon Romanovsky wrote:
> > From: Aharon Landau <aharonl@nvidia.com>
> > 
> > The vendors set the IOVA of newly created MRs in rereg_user_mr, so don't
> > overwrite it. That ensures that this field is set only if IB_MR_REREG_TRANS
> > flag is provided.
> > 
> > Fixes: 6e0954b11c05 ("RDMA/uverbs: Allow drivers to create a new HW object during rereg_mr")
> > Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/core/uverbs_cmd.c | 3 ---
> >  1 file changed, 3 deletions(-)
> 
> I rewrote the commit message:

Thanks a lot.

> 
>     RDMA/core: Require the driver to set the IOVA correctly during rereg_mr
>     
>     If the driver returns a new MR during rereg it has to fill it with the
>     IOVA from the proper source. If IB_MR_REREG_TRANS is set then the IOVA is
>     cmd.hca_va, otherwise the IOVA comes from the old MR. mlx5 for example has
>     two calls inside rereg_mr:
>     
>                     return create_real_mr(new_pd, umem, mr->ibmr.iova,
>                                           new_access_flags);
>     and
>                     return create_real_mr(new_pd, new_umem, iova, new_access_flags);
>     
>     Unconditionally overwriting the iova in the newly allocated MR will
>     corrupt the iova if the first path is used.
>     
>     Remove the redundant initializations from ib_uverbs_rereg_mr().
>     
>     Fixes: 6e0954b11c05 ("RDMA/uverbs: Allow drivers to create a new HW object during rereg_mr")
>     Link: https://lore.kernel.org/r/4b0a31bbc372842613286a10d7a8cbb0ee6069c7.1635400472.git.leonro@nvidia.com
>     Signed-off-by: Aharon Landau <aharonl@nvidia.com>
>     Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason
