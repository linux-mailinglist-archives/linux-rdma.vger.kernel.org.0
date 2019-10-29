Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90EA7E82A0
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 08:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfJ2Hmm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 03:42:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfJ2Hmm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 03:42:42 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8530D20717;
        Tue, 29 Oct 2019 07:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572334961;
        bh=EbzxDYf6F9qkZrsDsyMkAiltpwzAI2hBO1OY7oXdHJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tl+kQ8BMYWCd8fvOnRBW6Ofq5pzKD217pHkHzsqQTfp+zFX5ZLY/ACcevqy7TGojH
         iDxR2B+ezePu7JVT/6NGdEmsUcwkj4t55AXnBus3jqOc6gQeOAlk2rx38VbFERcotd
         9AfU1S25yaxRIVMLbtUj2zZaqgA1YhB3iSGZIYXU=
Date:   Tue, 29 Oct 2019 09:42:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Mark Bloch <markb@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Yevgeny Kliteynik <kliteyn@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] IB/mlx5: Support flow counters offset for bulk
 counters
Message-ID: <20191029074236.GB5545@unreal>
References: <20191029055916.7322-1-leon@kernel.org>
 <9a0ea9cf-d0f3-7d31-c027-b1568e4a25b1@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a0ea9cf-d0f3-7d31-c027-b1568e4a25b1@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 06:48:42AM +0000, Mark Bloch wrote:
> Hey Leon,
>
> On 10/28/2019 22:59, Leon Romanovsky wrote:
> > From: Yevgeny Kliteynik <kliteyn@mellanox.com>
> >
> > Add support for flow steering counters action with
> > a non-base counter ID (offset) for bulk counters.
> >
> > When creating a flow counter object, save the bulk value.
> > This value is used when a flow action with a non-base
> > counter ID is requested - to validate that the required
> > offset is in the range of the allocated bulk.
> >
> > Signed-off-by: Yevgeny Kliteynik <kliteyn@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/hw/mlx5/devx.c        | 12 ++++++++-
> >  drivers/infiniband/hw/mlx5/flow.c        | 34 ++++++++++++++++++++++--
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h     |  2 +-
> >  include/uapi/rdma/mlx5_user_ioctl_cmds.h |  1 +
> >  4 files changed, 45 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
> > index 6b1fca91d7d3..3900fcb1ccaf 100644
> > --- a/drivers/infiniband/hw/mlx5/devx.c
> > +++ b/drivers/infiniband/hw/mlx5/devx.c
> > @@ -100,6 +100,7 @@ struct devx_obj {
> >  		struct mlx5_ib_devx_mr	devx_mr;
> >  		struct mlx5_core_dct	core_dct;
> >  		struct mlx5_core_cq	core_cq;
> > +		u32			flow_counter_bulk_size;
> >  	};
> >  	struct list_head event_sub; /* holds devx_event_subscription entries */
> >  };
> > @@ -192,7 +193,7 @@ bool mlx5_ib_devx_is_flow_dest(void *obj, int *dest_id, int *dest_type)
> >  	}
> >  }
> >
> > -bool mlx5_ib_devx_is_flow_counter(void *obj, u32 *counter_id)
> > +bool mlx5_ib_devx_is_flow_counter(void *obj, u32 *counter_id, u32 *bulk_size)
> >  {
> >  	struct devx_obj *devx_obj = obj;
> >  	u16 opcode = MLX5_GET(general_obj_in_cmd_hdr, devx_obj->dinbox, opcode);
> > @@ -201,6 +202,7 @@ bool mlx5_ib_devx_is_flow_counter(void *obj, u32 *counter_id)
> >  		*counter_id = MLX5_GET(dealloc_flow_counter_in,
> >  				       devx_obj->dinbox,
> >  				       flow_counter_id);
> > +		*bulk_size = devx_obj->flow_counter_bulk_size;
> >  		return true;
> >  	}
> >
> > @@ -1463,6 +1465,14 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_CREATE)(
> >  	if (err)
> >  		goto obj_free;
> >
> > +	if (opcode == MLX5_CMD_OP_ALLOC_FLOW_COUNTER) {
> > +		u8 bulk = MLX5_GET(alloc_flow_counter_in,
> > +				   cmd_in,
> > +				   flow_counter_bulk);
> > +		if (bulk)
> > +			obj->flow_counter_bulk_size = 64UL << ffs(bulk);
>
> Why do you need ffs and not just: 64 << bulk ?
> As this field is a bitmask, only a single bit should be set and that should already
> be validated by the FW.

I preferred this approach instead of checking if "64UL << bulk" overflow while doing shift,
but if you insist, we can change the code below to be something like this:
check_shl_overflow(64UL, bulk, obj->flow_counter_bulk_size)

>
> > +	}
> > +
> >  	uobj->object = obj;
> >  	INIT_LIST_HEAD(&obj->event_sub);
> >  	obj->ib_dev = dev;
> > diff --git a/drivers/infiniband/hw/mlx5/flow.c b/drivers/infiniband/hw/mlx5/flow.c
> > index b198ff10cde9..05637039bcd7 100644
> > --- a/drivers/infiniband/hw/mlx5/flow.c
> > +++ b/drivers/infiniband/hw/mlx5/flow.c
> > @@ -85,6 +85,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
> >  	struct mlx5_ib_dev *dev = mlx5_udata_to_mdev(&attrs->driver_udata);
> >  	int len, ret, i;
> >  	u32 counter_id = 0;
> > +	u32 bulk_size = 0;
> > +	u32 *offset;
> >
> >  	if (!capable(CAP_NET_RAW))
> >  		return -EPERM;
> > @@ -151,8 +153,32 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
> >  	if (len) {
> >  		devx_obj = arr_flow_actions[0]->object;
> >
> > -		if (!mlx5_ib_devx_is_flow_counter(devx_obj, &counter_id))
> > +		if (!mlx5_ib_devx_is_flow_counter(devx_obj,
> > +						  &counter_id,
> > +						  &bulk_size))
> >  			return -EINVAL;
> > +
> > +		if (uverbs_attr_is_valid(
> > +			    attrs,
> > +			    MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET)) {
> > +			int num_offsets = uverbs_attr_ptr_get_array_size(
> > +				attrs,
> > +				MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET,
> > +				sizeof(uint32_t));
> > +
> > +			if (num_offsets != 1)
> > +				return -EINVAL;> +
> > +			offset = uverbs_attr_get_alloced_ptr(
> > +				attrs,
> > +				MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET);
> > +
> > +			if (*offset && *offset >= bulk_size)
> > +				return -EINVAL;
>
> This logic/validity check should probably be in: mlx5_ib_devx_is_flow_counter().
> you pass it the the offset (or 0) and you get back a counter_id and false/true if valid.

Agree.

>
> > +
> > +			counter_id += *offset;
> > +		}
> > +
> >  		flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_COUNT;
> >  	}
> >
> > @@ -598,7 +624,11 @@ DECLARE_UVERBS_NAMED_METHOD(
> >  	UVERBS_ATTR_IDRS_ARR(MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX,
> >  			     MLX5_IB_OBJECT_DEVX_OBJ,
> >  			     UVERBS_ACCESS_READ, 1, 1,
> > -			     UA_OPTIONAL));
> > +			     UA_OPTIONAL),
> > +	UVERBS_ATTR_PTR_IN(MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET,
> > +			   UVERBS_ATTR_MIN_SIZE(sizeof(uint32_t)),
>
> Why uint32_t and not u32?

Copy/paste from user space.

>
> > +			   UA_OPTIONAL,
> > +			   UA_ALLOC_AND_COPY));
> side note, both MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET and MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX
> are optional, but you should provide MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET only
> if you are also passing MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX.
>
> Which means you can pass MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET without
> MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX and everything will work.
>
> I wonder if we should have a way to define such things.

Jason ???

>
> Mark
>
> >
> >  DECLARE_UVERBS_NAMED_METHOD_DESTROY(
> >  	MLX5_IB_METHOD_DESTROY_FLOW,
> > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > index 0bdb8b45ea15..0fb58ecccb7e 100644
> > --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > @@ -1367,7 +1367,7 @@ struct mlx5_ib_flow_handler *mlx5_ib_raw_fs_rule_add(
> >  	struct mlx5_flow_act *flow_act, u32 counter_id,
> >  	void *cmd_in, int inlen, int dest_id, int dest_type);
> >  bool mlx5_ib_devx_is_flow_dest(void *obj, int *dest_id, int *dest_type);
> > -bool mlx5_ib_devx_is_flow_counter(void *obj, u32 *counter_id);
> > +bool mlx5_ib_devx_is_flow_counter(void *obj, u32 *counter_id, u32 *bulk_size);
> >  int mlx5_ib_get_flow_trees(const struct uverbs_object_tree_def **root);
> >  void mlx5_ib_destroy_flow_action_raw(struct mlx5_ib_flow_action *maction);
> >  #else
> > diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
> > index d0da070cf0ab..20d88307f75f 100644
> > --- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
> > +++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
> > @@ -198,6 +198,7 @@ enum mlx5_ib_create_flow_attrs {
> >  	MLX5_IB_ATTR_CREATE_FLOW_ARR_FLOW_ACTIONS,
> >  	MLX5_IB_ATTR_CREATE_FLOW_TAG,
> >  	MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX,
> > +	MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX_OFFSET,
> >  };
> >
> >  enum mlx5_ib_destoy_flow_attrs {
> >
