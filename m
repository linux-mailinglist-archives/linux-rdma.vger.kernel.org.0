Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D351D20C744
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2020 11:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgF1JlS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Jun 2020 05:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgF1JlS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 28 Jun 2020 05:41:18 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D30BD20771;
        Sun, 28 Jun 2020 09:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593337277;
        bh=H3AAlTIqZrtdnUz4CP9z4SGNQwRsMtfxmI74UlnV84k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VLLN4VfEwCS3zSxaJ+GN1l+3PSREFDWhQZB4D7W2CfMvUh0i5LJE1uL39OA9xJ21r
         agFx0oGE67X5QTisPbYLxoUtyafIJtG0gOPIthOzb2ZDJ9r9UfOje/464E3oCOQzvf
         sACZx6lJT/KrS1J4/ir4WJhZQ7vSlGhu1I7aj8wk=
Date:   Sun, 28 Jun 2020 12:41:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yishai Hadas <yishaih@dev.mellanox.co.il>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next 5/5] RDMA/core: Convert RWQ table logic to
 ib_core allocation scheme
Message-ID: <20200628094113.GC6281@unreal>
References: <20200624105422.1452290-1-leon@kernel.org>
 <20200624105422.1452290-6-leon@kernel.org>
 <71aa016a-a212-24b8-0d4c-e254635ea744@dev.mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71aa016a-a212-24b8-0d4c-e254635ea744@dev.mellanox.co.il>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 28, 2020 at 12:11:41PM +0300, Yishai Hadas wrote:
> On 6/24/2020 1:54 PM, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Move struct ib_rwq_ind_table allocation to ib_core.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >   drivers/infiniband/core/device.c           |  1 +
> >   drivers/infiniband/core/uverbs_cmd.c       | 37 ++++++++++++-------
> >   drivers/infiniband/core/uverbs_std_types.c | 13 ++++++-
> >   drivers/infiniband/core/verbs.c            | 25 +------------
> >   drivers/infiniband/hw/mlx4/main.c          |  4 +-
> >   drivers/infiniband/hw/mlx4/mlx4_ib.h       | 12 +++---
> >   drivers/infiniband/hw/mlx4/qp.c            | 40 ++++++--------------
> >   drivers/infiniband/hw/mlx5/main.c          |  3 ++
> >   drivers/infiniband/hw/mlx5/mlx5_ib.h       |  8 ++--
> >   drivers/infiniband/hw/mlx5/qp.c            | 43 +++++++++-------------
> >   include/rdma/ib_verbs.h                    | 11 +++---
> >   11 files changed, 86 insertions(+), 111 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index b15fa3fa09ac..85d921c8e2b5 100644
> > --- a/drivers/infiniband/core/device.c
> > +++ b/drivers/infiniband/core/device.c
> > @@ -2686,6 +2686,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
> >   	SET_OBJ_SIZE(dev_ops, ib_cq);
> >   	SET_OBJ_SIZE(dev_ops, ib_mw);
> >   	SET_OBJ_SIZE(dev_ops, ib_pd);
> > +	SET_OBJ_SIZE(dev_ops, ib_rwq_ind_table);
> >   	SET_OBJ_SIZE(dev_ops, ib_srq);
> >   	SET_OBJ_SIZE(dev_ops, ib_ucontext);
> >   	SET_OBJ_SIZE(dev_ops, ib_xrcd);
> > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > index a5301f3d3059..a83d11d1e3ee 100644
> > --- a/drivers/infiniband/core/uverbs_cmd.c
> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > @@ -3090,13 +3090,13 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
> >   {
> >   	struct ib_uverbs_ex_create_rwq_ind_table cmd;
> >   	struct ib_uverbs_ex_create_rwq_ind_table_resp  resp = {};
> > -	struct ib_uobject		  *uobj;
> > +	struct ib_uobject *uobj;
> >   	int err;
> >   	struct ib_rwq_ind_table_init_attr init_attr = {};
> >   	struct ib_rwq_ind_table *rwq_ind_tbl;
> > -	struct ib_wq	**wqs = NULL;
> > +	struct ib_wq **wqs = NULL;
> >   	u32 *wqs_handles = NULL;
> > -	struct ib_wq	*wq = NULL;
> > +	struct ib_wq *wq = NULL;
> >   	int i, j, num_read_wqs;
> >   	u32 num_wq_handles;
> >   	struct uverbs_req_iter iter;
> > @@ -3151,17 +3151,15 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
> >   		goto put_wqs;
> >   	}
> > -	init_attr.log_ind_tbl_size = cmd.log_ind_tbl_size;
> > -	init_attr.ind_tbl = wqs;
> > -
> > -	rwq_ind_tbl = ib_dev->ops.create_rwq_ind_table(ib_dev, &init_attr,
> > -						       &attrs->driver_udata);
> > -
> > -	if (IS_ERR(rwq_ind_tbl)) {
> > -		err = PTR_ERR(rwq_ind_tbl);
> > +	rwq_ind_tbl = rdma_zalloc_drv_obj(ib_dev, ib_rwq_ind_table);
> > +	if (!rwq_ind_tbl) {
> > +		err = -ENOMEM;
> >   		goto err_uobj;
> >   	}
> > +	init_attr.log_ind_tbl_size = cmd.log_ind_tbl_size;
> > +	init_attr.ind_tbl = wqs;
> > +
> >   	rwq_ind_tbl->ind_tbl = wqs;
> >   	rwq_ind_tbl->log_ind_tbl_size = init_attr.log_ind_tbl_size;
> >   	rwq_ind_tbl->uobject = uobj;
> > @@ -3169,6 +3167,12 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
> >   	rwq_ind_tbl->device = ib_dev;
> >   	atomic_set(&rwq_ind_tbl->usecnt, 0);
> > +	err = ib_dev->ops.create_rwq_ind_table(rwq_ind_tbl, &init_attr,
> > +					       &rwq_ind_tbl->ind_tbl_num,
> > +					       &attrs->driver_udata);
> > +	if (err)
> > +		goto err_create;
> > +
> >   	for (i = 0; i < num_wq_handles; i++)
> >   		atomic_inc(&wqs[i]->usecnt);
> > @@ -3190,7 +3194,13 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
> >   	return 0;
> >   err_copy:
> > -	ib_destroy_rwq_ind_table(rwq_ind_tbl);
> > +	for (i = 0; i < num_wq_handles; i++)
> > +		atomic_dec(&wqs[i]->usecnt);
> > +
> > +	if (ib_dev->ops.destroy_rwq_ind_table)
> > +		ib_dev->ops.destroy_rwq_ind_table(rwq_ind_tbl);
> > +err_create:
> > +	kfree(rwq_ind_tbl);
> >   err_uobj:
> >   	uobj_alloc_abort(uobj, attrs);
> >   put_wqs:
> > @@ -4018,8 +4028,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
> >   			IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL,
> >   			ib_uverbs_ex_destroy_rwq_ind_table,
> >   			UAPI_DEF_WRITE_I(
> > -				struct ib_uverbs_ex_destroy_rwq_ind_table),
> > -			UAPI_DEF_METHOD_NEEDS_FN(destroy_rwq_ind_table))),
> > +				struct ib_uverbs_ex_destroy_rwq_ind_table))),
> >   	DECLARE_UVERBS_OBJECT(
> >   		UVERBS_OBJECT_WQ,
> > diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
> > index e4994cc4cc51..cd82a5a80bdf 100644
> > --- a/drivers/infiniband/core/uverbs_std_types.c
> > +++ b/drivers/infiniband/core/uverbs_std_types.c
> > @@ -82,12 +82,21 @@ static int uverbs_free_rwq_ind_tbl(struct ib_uobject *uobject,
> >   {
> >   	struct ib_rwq_ind_table *rwq_ind_tbl = uobject->object;
> >   	struct ib_wq **ind_tbl = rwq_ind_tbl->ind_tbl;
> > -	int ret;
> > +	u32 table_size = (1 << rwq_ind_tbl->log_ind_tbl_size);
> > +	int ret = 0, i;
> > +
> > +	if (atomic_read(&rwq_ind_tbl->usecnt))
> > +		ret = -EBUSY;
> > -	ret = ib_destroy_rwq_ind_table(rwq_ind_tbl);
> >   	if (ib_is_destroy_retryable(ret, why, uobject))
> >   		return ret;
> > +	for (i = 0; i < table_size; i++)
> > +		atomic_dec(&ind_tbl[i]->usecnt);
> > +
>
> Upon destroy we first expect to destroy the object that is pointing to other
> objetcs and only then descraese their ref count, this was the orignal logic
> here. (See also ib_destroy_qp_user(), ib_destroy_wq() and others).

It is a bug, proper logic is to allocate HW object, elevate reference
counting, decrease reference counter and deallocate HW object.

Everything else should be fixed too.

>
> > +	if (rwq_ind_tbl->device->ops.destroy_rwq_ind_table)
> > +		rwq_ind_tbl->device->ops.destroy_rwq_ind_table(rwq_ind_tbl);
>
> This doesn't really make sense, if no destroy function was set, the
> allocation should be prevented as well.

Should we delete mlx4 RWQ implementation too?
After this refactoring, mlx4 won't have .destroy_rwq_ind_table.

Thanks
