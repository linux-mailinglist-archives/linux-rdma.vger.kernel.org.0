Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6FD20F392
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 13:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgF3LbW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 07:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730896AbgF3LbU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jun 2020 07:31:20 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37307C061755
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2020 04:31:20 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p20so20112770ejd.13
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2020 04:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YOTloVTxKVlyBVAsAyq9ismAlOo7C6LFd+XKDsLbQSU=;
        b=XC4hIv0oVM+dyPo6RMZN8v7sqqPAKybVYTwLVFIXOp5YPAR8nAara2TuoxPPZ9hy6I
         pm87VtdvNG6A9qZbvcwyPl8fEqp3UXhgRrpxmbDlPadiIDe+29jt99MQEtu8zgJI7fvj
         cYwo2/VMZaLbFHrGc7bQ6JkFkOpCzvbl75YQIOFHMIoF2iM5F9xzuC1Z0uVFjiGu4/qS
         6ZYbI2E4cEpQILOQZQgP9UE7fp0H1ErOezwTCqZkseKvIpR3e0qMav2pT9t0Xxi7rFY7
         SHTPE2fYu8ip8BnyNpSqRpgl0+7wUQubSJu9hbP964436iwRrpxPx/kpWszurLMoqI/3
         3JKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YOTloVTxKVlyBVAsAyq9ismAlOo7C6LFd+XKDsLbQSU=;
        b=kZo3na6HOtpBuotX3FlMXx0QNU9r//91uJmLhwalyZTDoc6ttvcpvMcrfwGWFpoTn2
         ahuSSd1gYxMjEnLzVPAfisp15p/9+uC/dF8U2Ef1UhH1t91sGM/1bEOAVlgcZLtwAZVo
         6n3h5SGbVHri/MxAjj9sWtMFWb2rMEvD8l3V2GSmqACdjpK1bLR7+KNfgaixLxx4A5uR
         H7rKDGYHO3GhdE8YUJnAR8yDrxNoML24bwhaIplkuodRYr2ccKZ3Gs88ocG3EwJqDUne
         1SO9pUQ1hqETVWjFeduBXFRxx6175rNthuniWqqwVlKxaU9cB4XlqncgyWY2qBLNVaoB
         OEVQ==
X-Gm-Message-State: AOAM530R3RwMlKkx8peZxA+2XLFpWqbTmXHIe0npqi5ozC/C7a6YhIL1
        RsSFfuq8X9EfbkmiwRAy3PDLCg==
X-Google-Smtp-Source: ABdhPJxf9VETrkN3z0G8wQCq6LuOpvnqUo+JjVSJNI0wi4/Q25AH38cMMtJqP7/Iuykz/jZx+2kwLg==
X-Received: by 2002:a17:906:e0c7:: with SMTP id gl7mr16824508ejb.264.1593516678809;
        Tue, 30 Jun 2020 04:31:18 -0700 (PDT)
Received: from [10.0.0.57] ([141.226.208.144])
        by smtp.googlemail.com with ESMTPSA id s18sm1716958ejm.16.2020.06.30.04.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 04:31:18 -0700 (PDT)
Subject: Re: [PATCH rdma-next v1 4/4] RDMA/core: Convert RWQ table logic to
 ib_core allocation scheme
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
References: <20200630101855.368895-1-leon@kernel.org>
 <20200630101855.368895-5-leon@kernel.org>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <f3426e16-c427-65ac-6b1a-f3979062b85e@dev.mellanox.co.il>
Date:   Tue, 30 Jun 2020 14:31:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630101855.368895-5-leon@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/30/2020 1:18 PM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Move struct ib_rwq_ind_table allocation to ib_core.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>   drivers/infiniband/core/device.c           |  1 +
>   drivers/infiniband/core/uverbs_cmd.c       | 37 ++++++++++++-------
>   drivers/infiniband/core/uverbs_std_types.c | 16 +++++---
>   drivers/infiniband/core/verbs.c            | 23 ------------
>   drivers/infiniband/hw/mlx4/main.c          |  4 +-
>   drivers/infiniband/hw/mlx4/mlx4_ib.h       | 12 +++---
>   drivers/infiniband/hw/mlx4/qp.c            | 40 ++++++--------------
>   drivers/infiniband/hw/mlx5/main.c          |  3 ++
>   drivers/infiniband/hw/mlx5/mlx5_ib.h       |  8 ++--
>   drivers/infiniband/hw/mlx5/qp.c            | 43 +++++++++-------------
>   include/rdma/ib_verbs.h                    | 11 +++---
>   11 files changed, 85 insertions(+), 113 deletions(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index b15fa3fa09ac..85d921c8e2b5 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2686,6 +2686,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>   	SET_OBJ_SIZE(dev_ops, ib_cq);
>   	SET_OBJ_SIZE(dev_ops, ib_mw);
>   	SET_OBJ_SIZE(dev_ops, ib_pd);
> +	SET_OBJ_SIZE(dev_ops, ib_rwq_ind_table);
>   	SET_OBJ_SIZE(dev_ops, ib_srq);
>   	SET_OBJ_SIZE(dev_ops, ib_ucontext);
>   	SET_OBJ_SIZE(dev_ops, ib_xrcd);
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index a5301f3d3059..a83d11d1e3ee 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -3090,13 +3090,13 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
>   {
>   	struct ib_uverbs_ex_create_rwq_ind_table cmd;
>   	struct ib_uverbs_ex_create_rwq_ind_table_resp  resp = {};
> -	struct ib_uobject		  *uobj;
> +	struct ib_uobject *uobj;
>   	int err;
>   	struct ib_rwq_ind_table_init_attr init_attr = {};
>   	struct ib_rwq_ind_table *rwq_ind_tbl;
> -	struct ib_wq	**wqs = NULL;
> +	struct ib_wq **wqs = NULL;
>   	u32 *wqs_handles = NULL;
> -	struct ib_wq	*wq = NULL;
> +	struct ib_wq *wq = NULL;
>   	int i, j, num_read_wqs;
>   	u32 num_wq_handles;
>   	struct uverbs_req_iter iter;
> @@ -3151,17 +3151,15 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
>   		goto put_wqs;
>   	}
>   
> -	init_attr.log_ind_tbl_size = cmd.log_ind_tbl_size;
> -	init_attr.ind_tbl = wqs;
> -
> -	rwq_ind_tbl = ib_dev->ops.create_rwq_ind_table(ib_dev, &init_attr,
> -						       &attrs->driver_udata);
> -
> -	if (IS_ERR(rwq_ind_tbl)) {
> -		err = PTR_ERR(rwq_ind_tbl);
> +	rwq_ind_tbl = rdma_zalloc_drv_obj(ib_dev, ib_rwq_ind_table);
> +	if (!rwq_ind_tbl) {
> +		err = -ENOMEM;
>   		goto err_uobj;
>   	}
>   
> +	init_attr.log_ind_tbl_size = cmd.log_ind_tbl_size;
> +	init_attr.ind_tbl = wqs;
> +
>   	rwq_ind_tbl->ind_tbl = wqs;
>   	rwq_ind_tbl->log_ind_tbl_size = init_attr.log_ind_tbl_size;
>   	rwq_ind_tbl->uobject = uobj;
> @@ -3169,6 +3167,12 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
>   	rwq_ind_tbl->device = ib_dev;
>   	atomic_set(&rwq_ind_tbl->usecnt, 0);
>   
> +	err = ib_dev->ops.create_rwq_ind_table(rwq_ind_tbl, &init_attr,
> +					       &rwq_ind_tbl->ind_tbl_num,
> +					       &attrs->driver_udata);
> +	if (err)
> +		goto err_create;
> +
>   	for (i = 0; i < num_wq_handles; i++)
>   		atomic_inc(&wqs[i]->usecnt);
>   
> @@ -3190,7 +3194,13 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
>   	return 0;
>   
>   err_copy:
> -	ib_destroy_rwq_ind_table(rwq_ind_tbl);
> +	for (i = 0; i < num_wq_handles; i++)
> +		atomic_dec(&wqs[i]->usecnt);
> +
> +	if (ib_dev->ops.destroy_rwq_ind_table)
> +		ib_dev->ops.destroy_rwq_ind_table(rwq_ind_tbl);
> +err_create:
> +	kfree(rwq_ind_tbl);
>   err_uobj:
>   	uobj_alloc_abort(uobj, attrs);
>   put_wqs:
> @@ -4018,8 +4028,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
>   			IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL,
>   			ib_uverbs_ex_destroy_rwq_ind_table,
>   			UAPI_DEF_WRITE_I(
> -				struct ib_uverbs_ex_destroy_rwq_ind_table),
> -			UAPI_DEF_METHOD_NEEDS_FN(destroy_rwq_ind_table))),
> +				struct ib_uverbs_ex_destroy_rwq_ind_table))),
>   
>   	DECLARE_UVERBS_OBJECT(
>   		UVERBS_OBJECT_WQ,
> diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
> index e4994cc4cc51..13c6b3066e4f 100644
> --- a/drivers/infiniband/core/uverbs_std_types.c
> +++ b/drivers/infiniband/core/uverbs_std_types.c
> @@ -82,12 +82,21 @@ static int uverbs_free_rwq_ind_tbl(struct ib_uobject *uobject,
>   {
>   	struct ib_rwq_ind_table *rwq_ind_tbl = uobject->object;
>   	struct ib_wq **ind_tbl = rwq_ind_tbl->ind_tbl;
> -	int ret;
> +	u32 table_size = (1 << rwq_ind_tbl->log_ind_tbl_size);
> +	int ret = 0, i;
> +
> +	if (atomic_read(&rwq_ind_tbl->usecnt))
> +		ret = -EBUSY;
>   
> -	ret = ib_destroy_rwq_ind_table(rwq_ind_tbl);
>   	if (ib_is_destroy_retryable(ret, why, uobject))
>   		return ret;
>   
> +	for (i = 0; i < table_size; i++)
> +		atomic_dec(&ind_tbl[i]->usecnt);
> +
> +	if (rwq_ind_tbl->device->ops.destroy_rwq_ind_table)
> +		rwq_ind_tbl->device->ops.destroy_rwq_ind_table(rwq_ind_tbl);


We had here two notes from previous review that need to be settled, ref 
count decrement before object destruction (high priority) and 
considering the existance of both alloc/destroy functions from driver 
point of view from symetic reasons. (low priority).

Let's get Jason's feedback here please.


> +	kfree(rwq_ind_tbl);
>   	kfree(ind_tbl);
>   	return ret;
>   }
> @@ -258,9 +267,6 @@ const struct uapi_definition uverbs_def_obj_intf[] = {
>   				      UAPI_DEF_OBJ_NEEDS_FN(dealloc_mw)),
>   	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_FLOW,
>   				      UAPI_DEF_OBJ_NEEDS_FN(destroy_flow)),
> -	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
> -		UVERBS_OBJECT_RWQ_IND_TBL,
> -		UAPI_DEF_OBJ_NEEDS_FN(destroy_rwq_ind_table)),
>   	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_XRCD,
>   				      UAPI_DEF_OBJ_NEEDS_FN(dealloc_xrcd)),
>   	{}
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index c41e3fdef5d6..be4c6ee3804a 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -2412,29 +2412,6 @@ int ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
>   }
>   EXPORT_SYMBOL(ib_modify_wq);
>   
> -/*
> - * ib_destroy_rwq_ind_table - Destroys the specified Indirection Table.
> - * @wq_ind_table: The Indirection Table to destroy.
> -*/
> -int ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *rwq_ind_table)
> -{
> -	int err, i;
> -	u32 table_size = (1 << rwq_ind_table->log_ind_tbl_size);
> -	struct ib_wq **ind_tbl = rwq_ind_table->ind_tbl;
> -
> -	if (atomic_read(&rwq_ind_table->usecnt))
> -		return -EBUSY;
> -
> -	err = rwq_ind_table->device->ops.destroy_rwq_ind_table(rwq_ind_table);
> -	if (!err) {
> -		for (i = 0; i < table_size; i++)
> -			atomic_dec(&ind_tbl[i]->usecnt);
> -	}
> -
> -	return err;
> -}
> -EXPORT_SYMBOL(ib_destroy_rwq_ind_table);
> -
>   int ib_check_mr_status(struct ib_mr *mr, u32 check_mask,
>   		       struct ib_mr_status *mr_status)
>   {
> diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
> index 0ad584a3b8d6..88a3a9a88bee 100644
> --- a/drivers/infiniband/hw/mlx4/main.c
> +++ b/drivers/infiniband/hw/mlx4/main.c
> @@ -2585,9 +2585,11 @@ static const struct ib_device_ops mlx4_ib_dev_ops = {
>   static const struct ib_device_ops mlx4_ib_dev_wq_ops = {
>   	.create_rwq_ind_table = mlx4_ib_create_rwq_ind_table,
>   	.create_wq = mlx4_ib_create_wq,
> -	.destroy_rwq_ind_table = mlx4_ib_destroy_rwq_ind_table,
>   	.destroy_wq = mlx4_ib_destroy_wq,
>   	.modify_wq = mlx4_ib_modify_wq,
> +
> +	INIT_RDMA_OBJ_SIZE(ib_rwq_ind_table, mlx4_ib_rwq_ind_table,
> +			   ib_rwq_ind_tbl),
>   };
>   
>   static const struct ib_device_ops mlx4_ib_dev_mw_ops = {
> diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> index 5fbe766aef6b..2730a0f65f47 100644
> --- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
> +++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> @@ -366,6 +366,10 @@ struct mlx4_ib_ah {
>   	union mlx4_ext_av       av;
>   };
>   
> +struct mlx4_ib_rwq_ind_table {
> +	struct ib_rwq_ind_table ib_rwq_ind_tbl;
> +};
> +
>   /****************************************/
>   /* alias guid support */
>   /****************************************/
> @@ -893,11 +897,9 @@ void mlx4_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
>   int mlx4_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
>   		      u32 wq_attr_mask, struct ib_udata *udata);
>   
> -struct ib_rwq_ind_table
> -*mlx4_ib_create_rwq_ind_table(struct ib_device *device,
> -			      struct ib_rwq_ind_table_init_attr *init_attr,
> -			      struct ib_udata *udata);
> -int mlx4_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table);
> +int mlx4_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_tbl,
> +				 struct ib_rwq_ind_table_init_attr *init_attr,
> +				 u32 *ind_tbl_num, struct ib_udata *udata);
>   int mlx4_ib_umem_calc_optimal_mtt_size(struct ib_umem *umem, u64 start_va,
>   				       int *num_of_mtts);
>   
> diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
> index cf51e3cbd969..5795bfc1a512 100644
> --- a/drivers/infiniband/hw/mlx4/qp.c
> +++ b/drivers/infiniband/hw/mlx4/qp.c
> @@ -4340,34 +4340,32 @@ void mlx4_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
>   	kfree(qp);
>   }
>   
> -struct ib_rwq_ind_table
> -*mlx4_ib_create_rwq_ind_table(struct ib_device *device,
> -			      struct ib_rwq_ind_table_init_attr *init_attr,
> -			      struct ib_udata *udata)
> +int mlx4_ib_create_rwq_ind_table(struct ib_rwq_ind_table *rwq_ind_table,
> +				 struct ib_rwq_ind_table_init_attr *init_attr,
> +				 u32 *ind_tbl_num, struct ib_udata *udata)
>   {
> -	struct ib_rwq_ind_table *rwq_ind_table;
>   	struct mlx4_ib_create_rwq_ind_tbl_resp resp = {};
>   	unsigned int ind_tbl_size = 1 << init_attr->log_ind_tbl_size;
> +	struct ib_device *device = rwq_ind_table->device;
>   	unsigned int base_wqn;
>   	size_t min_resp_len;
> -	int i;
> -	int err;
> +	int i, err = 0;
>   
>   	if (udata->inlen > 0 &&
>   	    !ib_is_udata_cleared(udata, 0,
>   				 udata->inlen))
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>   
>   	min_resp_len = offsetof(typeof(resp), reserved) + sizeof(resp.reserved);
>   	if (udata->outlen && udata->outlen < min_resp_len)
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>   
>   	if (ind_tbl_size >
>   	    device->attrs.rss_caps.max_rwq_indirection_table_size) {
>   		pr_debug("log_ind_tbl_size = %d is bigger than supported = %d\n",
>   			 ind_tbl_size,
>   			 device->attrs.rss_caps.max_rwq_indirection_table_size);
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>   	}
>   
>   	base_wqn = init_attr->ind_tbl[0]->wq_num;
> @@ -4375,39 +4373,23 @@ struct ib_rwq_ind_table
>   	if (base_wqn % ind_tbl_size) {
>   		pr_debug("WQN=0x%x isn't aligned with indirection table size\n",
>   			 base_wqn);
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>   	}
>   
>   	for (i = 1; i < ind_tbl_size; i++) {
>   		if (++base_wqn != init_attr->ind_tbl[i]->wq_num) {
>   			pr_debug("indirection table's WQNs aren't consecutive\n");
> -			return ERR_PTR(-EINVAL);
> +			return -EINVAL;
>   		}
>   	}
>   
> -	rwq_ind_table = kzalloc(sizeof(*rwq_ind_table), GFP_KERNEL);
> -	if (!rwq_ind_table)
> -		return ERR_PTR(-ENOMEM);
> -
>   	if (udata->outlen) {
>   		resp.response_length = offsetof(typeof(resp), response_length) +
>   					sizeof(resp.response_length);
>   		err = ib_copy_to_udata(udata, &resp, resp.response_length);
> -		if (err)
> -			goto err;
>   	}
>   
> -	return rwq_ind_table;
> -
> -err:
> -	kfree(rwq_ind_table);
> -	return ERR_PTR(err);
> -}
> -
> -int mlx4_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_tbl)
> -{
> -	kfree(ib_rwq_ind_tbl);
> -	return 0;
> +	return err;
>   }
>   
>   struct mlx4_ib_drain_cqe {
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index a6d5c35a2845..682ba1b6f34a 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -6844,6 +6844,9 @@ static const struct ib_device_ops mlx5_ib_dev_common_roce_ops = {
>   	.destroy_wq = mlx5_ib_destroy_wq,
>   	.get_netdev = mlx5_ib_get_netdev,
>   	.modify_wq = mlx5_ib_modify_wq,
> +
> +	INIT_RDMA_OBJ_SIZE(ib_rwq_ind_table, mlx5_ib_rwq_ind_table,
> +			   ib_rwq_ind_tbl),
>   };
>   
>   static int mlx5_ib_stage_common_roce_init(struct mlx5_ib_dev *dev)
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index 726386fe4440..c4a285e1950d 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -1272,10 +1272,10 @@ struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
>   void mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
>   int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
>   		      u32 wq_attr_mask, struct ib_udata *udata);
> -struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
> -						      struct ib_rwq_ind_table_init_attr *init_attr,
> -						      struct ib_udata *udata);
> -int mlx5_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table);
> +int mlx5_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_table,
> +				 struct ib_rwq_ind_table_init_attr *init_attr,
> +				 u32 *ind_tbl_num, struct ib_udata *udata);
> +void mlx5_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table);
>   struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
>   			       struct ib_ucontext *context,
>   			       struct ib_dm_alloc_attr *attr,
> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> index 0ae73f4e28a3..3124c80169fb 100644
> --- a/drivers/infiniband/hw/mlx5/qp.c
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -5063,12 +5063,13 @@ void mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
>   	kfree(rwq);
>   }
>   
> -struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
> -						      struct ib_rwq_ind_table_init_attr *init_attr,
> -						      struct ib_udata *udata)
> +int mlx5_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_table,
> +				 struct ib_rwq_ind_table_init_attr *init_attr,
> +				 u32 *ind_tbl_num, struct ib_udata *udata)
>   {
> -	struct mlx5_ib_dev *dev = to_mdev(device);
> -	struct mlx5_ib_rwq_ind_table *rwq_ind_tbl;
> +	struct mlx5_ib_rwq_ind_table *rwq_ind_tbl =
> +		to_mrwq_ind_table(ib_rwq_ind_table);
> +	struct mlx5_ib_dev *dev = to_mdev(ib_rwq_ind_table->device);
>   	int sz = 1 << init_attr->log_ind_tbl_size;
>   	struct mlx5_ib_create_rwq_ind_tbl_resp resp = {};
>   	size_t min_resp_len;
> @@ -5081,30 +5082,24 @@ struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
>   	if (udata->inlen > 0 &&
>   	    !ib_is_udata_cleared(udata, 0,
>   				 udata->inlen))
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>   
>   	if (init_attr->log_ind_tbl_size >
>   	    MLX5_CAP_GEN(dev->mdev, log_max_rqt_size)) {
>   		mlx5_ib_dbg(dev, "log_ind_tbl_size = %d is bigger than supported = %d\n",
>   			    init_attr->log_ind_tbl_size,
>   			    MLX5_CAP_GEN(dev->mdev, log_max_rqt_size));
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>   	}
>   
>   	min_resp_len = offsetof(typeof(resp), reserved) + sizeof(resp.reserved);
>   	if (udata->outlen && udata->outlen < min_resp_len)
> -		return ERR_PTR(-EINVAL);
> -
> -	rwq_ind_tbl = kzalloc(sizeof(*rwq_ind_tbl), GFP_KERNEL);
> -	if (!rwq_ind_tbl)
> -		return ERR_PTR(-ENOMEM);
> +		return -EINVAL;
>   
>   	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + sizeof(u32) * sz;
>   	in = kvzalloc(inlen, GFP_KERNEL);
> -	if (!in) {
> -		err = -ENOMEM;
> -		goto err;
> -	}
> +	if (!in)
> +		return -ENOMEM;
>   
>   	rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
>   
> @@ -5118,12 +5113,10 @@ struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
>   	MLX5_SET(create_rqt_in, in, uid, rwq_ind_tbl->uid);
>   
>   	err = mlx5_core_create_rqt(dev->mdev, in, inlen, &rwq_ind_tbl->rqtn);
> -	kvfree(in);
> -
>   	if (err)
>   		goto err;
>   
> -	rwq_ind_tbl->ib_rwq_ind_tbl.ind_tbl_num = rwq_ind_tbl->rqtn;
> +	*ind_tbl_num = rwq_ind_tbl->rqtn;
>   	if (udata->outlen) {
>   		resp.response_length = offsetof(typeof(resp), response_length) +
>   					sizeof(resp.response_length);
> @@ -5132,24 +5125,22 @@ struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
>   			goto err_copy;
>   	}
>   
> -	return &rwq_ind_tbl->ib_rwq_ind_tbl;
> +	kvfree(in);
> +	return 0;
>   
>   err_copy:
>   	mlx5_cmd_destroy_rqt(dev->mdev, rwq_ind_tbl->rqtn, rwq_ind_tbl->uid);
>   err:
> -	kfree(rwq_ind_tbl);
> -	return ERR_PTR(err);
> +	kvfree(in);
> +	return err;
>   }
>   
> -int mlx5_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_tbl)
> +void mlx5_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_tbl)
>   {
>   	struct mlx5_ib_rwq_ind_table *rwq_ind_tbl = to_mrwq_ind_table(ib_rwq_ind_tbl);
>   	struct mlx5_ib_dev *dev = to_mdev(ib_rwq_ind_tbl->device);
>   
>   	mlx5_cmd_destroy_rqt(dev->mdev, rwq_ind_tbl->rqtn, rwq_ind_tbl->uid);
> -
> -	kfree(rwq_ind_tbl);
> -	return 0;
>   }
>   
>   int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 6e2cb69fe90b..ed948946e443 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2526,11 +2526,10 @@ struct ib_device_ops {
>   	void (*destroy_wq)(struct ib_wq *wq, struct ib_udata *udata);
>   	int (*modify_wq)(struct ib_wq *wq, struct ib_wq_attr *attr,
>   			 u32 wq_attr_mask, struct ib_udata *udata);
> -	struct ib_rwq_ind_table *(*create_rwq_ind_table)(
> -		struct ib_device *device,
> -		struct ib_rwq_ind_table_init_attr *init_attr,
> -		struct ib_udata *udata);
> -	int (*destroy_rwq_ind_table)(struct ib_rwq_ind_table *wq_ind_table);
> +	int (*create_rwq_ind_table)(struct ib_rwq_ind_table *ib_rwq_ind_table,
> +				    struct ib_rwq_ind_table_init_attr *init_attr,
> +				    u32 *ind_tbl_num, struct ib_udata *udata);
> +	void (*destroy_rwq_ind_table)(struct ib_rwq_ind_table *wq_ind_table);
>   	struct ib_dm *(*alloc_dm)(struct ib_device *device,
>   				  struct ib_ucontext *context,
>   				  struct ib_dm_alloc_attr *attr,
> @@ -2653,6 +2652,7 @@ struct ib_device_ops {
>   	DECLARE_RDMA_OBJ_SIZE(ib_cq);
>   	DECLARE_RDMA_OBJ_SIZE(ib_mw);
>   	DECLARE_RDMA_OBJ_SIZE(ib_pd);
> +	DECLARE_RDMA_OBJ_SIZE(ib_rwq_ind_table);
>   	DECLARE_RDMA_OBJ_SIZE(ib_srq);
>   	DECLARE_RDMA_OBJ_SIZE(ib_ucontext);
>   	DECLARE_RDMA_OBJ_SIZE(ib_xrcd);
> @@ -4430,7 +4430,6 @@ struct ib_wq *ib_create_wq(struct ib_pd *pd,
>   int ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
>   int ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *attr,
>   		 u32 wq_attr_mask);
> -int ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table);
>   
>   int ib_map_mr_sg(struct ib_mr *mr, struct scatterlist *sg, int sg_nents,
>   		 unsigned int *sg_offset, unsigned int page_size);
> 

