Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE78E7271
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 14:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfJ1NNi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 09:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbfJ1NNi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 09:13:38 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEF4F20717;
        Mon, 28 Oct 2019 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572268417;
        bh=T0E4dOUSO+qdRVPutlqp/7UcdqvVoVpJhWquHo84bsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNj3A3iG6of6gVKGX+q6qncGSp6CrrNHL8sKQVW+ZgQIsqJqzIQJwPKtXjauiuemd
         dFev1aPTtMEEjPsuDnQozgNQHm0clftzBZQX8pBg1Vlq/56BbBZoX3yVS61B1fO9aS
         BD+eO/X6OUZPSMXdfCtEo82xcoyh8ZBq7ztqu6CM=
Date:   Mon, 28 Oct 2019 15:13:33 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Or Gerlitz <gerlitz.or@gmail.com>
Subject: Re: [PATCH rdma-next 4/6] RDMA/cm: Delete useless QPN masking
Message-ID: <20191028131333.GD5146@unreal>
References: <20191020071559.9743-1-leon@kernel.org>
 <20191020071559.9743-5-leon@kernel.org>
 <20191028125233.GA27317@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028125233.GA27317@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 09:52:33AM -0300, Jason Gunthorpe wrote:
> On Sun, Oct 20, 2019 at 10:15:57AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > QPN is supplied by kernel users who controls and creates valid QPs,
> > such flow ensures that QPN is limited to 24bits and no need to mask
> > already valid QPN.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/cm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> > index 7ffa16ea5fe3..2eb8e1fab962 100644
> > --- a/drivers/infiniband/core/cm.c
> > +++ b/drivers/infiniband/core/cm.c
> > @@ -2101,7 +2101,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
> >  	cm_id_priv->initiator_depth = param->initiator_depth;
> >  	cm_id_priv->responder_resources = param->responder_resources;
> >  	cm_id_priv->rq_psn = cm_rep_get_starting_psn(rep_msg);
> > -	cm_id_priv->local_qpn = cpu_to_be32(param->qp_num & 0xFFFFFF);
> > +	cm_id_priv->local_qpn = cpu_to_be32(param->qp_num);
>
> It does seem like this value comes from userspace:
>
> ucma_connect()
>   ucma_copy_conn_param()
>     	dst->qp_num = src->qp_num
>   rdma_connect(.., &dst)
> 	if (!id->qp) {
> 		id_priv->qp_num = conn_param->qp_num;
>
> vs
>
> cma_accept_ib()
> 	rep.qp_num = id_priv->qp_num;
>
> Maybe this needs to add some masking to ucma_copy_conn_param()?

Thanks for the callstack, Or pointed it to me too, but I missed this flow.
Let's create a pre-patch with QPN masking.

Thanks

>
> Jason
