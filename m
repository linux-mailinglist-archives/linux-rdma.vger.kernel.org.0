Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3338A20EF33
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 09:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbgF3HVl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 03:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbgF3HVl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 03:21:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AA1020768;
        Tue, 30 Jun 2020 07:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593501701;
        bh=ZsKERWtrEGE5JRCq7YYDE3xzyftMsnu1UonSAvcQpxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x4dGKY7xoipZf2WNYeBuLaG4dPWyPaSdHAmG73FppjRH8w1vbvF3cmJ2NL4DnNS9g
         v/Nsor9I1G+UK20ciSOgNyFUI54srouBaT5TXUKPfMJmoQny5UM58zZweYkagDyS1i
         4gncE9sKlHSnfVU91cTajr8I6zM2W1O95hjeC/ys=
Date:   Tue, 30 Jun 2020 10:21:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 5/5] RDMA/core: Convert RWQ table logic to
 ib_core allocation scheme
Message-ID: <20200630072137.GC17857@unreal>
References: <20200624105422.1452290-1-leon@kernel.org>
 <20200624105422.1452290-6-leon@kernel.org>
 <20200629153907.GA269101@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629153907.GA269101@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 29, 2020 at 12:39:07PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 24, 2020 at 01:54:22PM +0300, Leon Romanovsky wrote:
> > @@ -4018,8 +4028,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
> >  			IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL,
> >  			ib_uverbs_ex_destroy_rwq_ind_table,
> >  			UAPI_DEF_WRITE_I(
> > -				struct ib_uverbs_ex_destroy_rwq_ind_table),
> > -			UAPI_DEF_METHOD_NEEDS_FN(destroy_rwq_ind_table))),
> > +				struct ib_uverbs_ex_destroy_rwq_ind_table))),
>
> Removing these is kind of troublesome.. This misses the one for ioctl:
>
>         UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
>                 UVERBS_OBJECT_RWQ_IND_TBL,
>                 UAPI_DEF_OBJ_NEEDS_FN(destroy_rwq_ind_table)),

I will remove, but it seems that we have some gap here, I would expect
any sort of compilation error for mlx4.

>
> > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > index 65c9118a931c..4210f0842bc6 100644
> > +++ b/drivers/infiniband/core/verbs.c
> > @@ -1703,7 +1703,7 @@ static int _ib_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
> >  					  &old_sgid_attr_alt_av);
> >  		if (ret)
> >  			goto out_av;
> > -
> > +//
>
> ??

Interesting, I have no clue how it slipped, because I'm not using this
type of coding style even for debug.

Thanks

>
> Jason
