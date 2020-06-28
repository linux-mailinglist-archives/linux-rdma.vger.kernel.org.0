Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DC920C734
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2020 11:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgF1JSo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Jun 2020 05:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgF1JSn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Jun 2020 05:18:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49013C061794
        for <linux-rdma@vger.kernel.org>; Sun, 28 Jun 2020 02:18:43 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ga4so13289072ejb.11
        for <linux-rdma@vger.kernel.org>; Sun, 28 Jun 2020 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cJTEdLDxB9L5VSTfDHOWhULN2nwZrofNq3+K/4DAoVM=;
        b=LUYEh7uOvxg6Mcd3JjKVgOmJVDVWt4T3YB1Jg2EoCKT7v1uSYC4BysH8XHLh6bkkbj
         UG9VhYCvCssiayJCcLop1aItkgae//ALusr+jdCx1psAOK2QikN+VZsToxjkmnIbZWBV
         b7PZBKLsCuNe4e4+ICMwrw8lwrM3EVzl5x0Amd59xHQwMvZx579j69AkXtZ3gpV21Fov
         RQnmj6tXBKg3lf809njMl4yj/Y9khcvpEnzn+ieLqO+KO180m6YeRbt1Cfgd2Tx+bpYd
         a0fY8LBqPG8G1OedX+F/nFnZFbXkoN1Cb2+FJvhCsNlRkxsWFysqhIY3G1mqemdug+Nl
         I0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cJTEdLDxB9L5VSTfDHOWhULN2nwZrofNq3+K/4DAoVM=;
        b=c73nWyebjYJGL6FicvLROGOS2oblJXYE24iQjHPxlTYS3hm9LlkF2KIHaHhaySp4ru
         mdwAy9NjVEyA/m1fbYHC0rLF82iIbVbF0PE9+8PWwtu1I8828NhEKwxdoL0dPjt8OgOj
         P/dpKpDTDS4PwDyQQFKVq6clmt2GF44WCsvTNeVBwLBkDIf0VMt+ROw5Q859flMtlQXp
         XkpwVxuDZC8iGNFmxpMbHnQwBCZZo9gcc5Z3UVx0dfSTN9clBoLVe/E/Z8YbCBv1kgEt
         HAvwFZF5AfkBpj+VbTppBn4ayCWzo/al04ct+zj5M+O8hoUkssQKtIyiAtS1+p32GKEt
         Uw3Q==
X-Gm-Message-State: AOAM530I+VY8JDg7msrgC10CSeAhXN7No0VtPLcE49vfd0D5KQz85uIf
        zMLdrGK8l9C8PaB6jCJYU7jwxA==
X-Google-Smtp-Source: ABdhPJw21v7lYMaJJ0m2P4686Ppv8ypxOFSYFqqAqinHxnu4mLIHZRfcNeJ9hwKWOH74eRF592BgKQ==
X-Received: by 2002:a17:906:824c:: with SMTP id f12mr9326060ejx.443.1593335921628;
        Sun, 28 Jun 2020 02:18:41 -0700 (PDT)
Received: from [10.0.0.57] ([141.226.208.144])
        by smtp.googlemail.com with ESMTPSA id v19sm20139818eda.70.2020.06.28.02.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2020 02:18:40 -0700 (PDT)
Subject: Re: [PATCH rdma-next 2/5] RDMA: Clean MW allocation and free flows
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
References: <20200624105422.1452290-1-leon@kernel.org>
 <20200624105422.1452290-3-leon@kernel.org>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <f5ffa1d5-d665-4913-ec40-1e6ad42685fc@dev.mellanox.co.il>
Date:   Sun, 28 Jun 2020 12:18:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624105422.1452290-3-leon@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/24/2020 1:54 PM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Move allocation and destruction of memory windows under ib_core
> responsibility and clean drivers to ensure that no updates to MW
> ib_core structures are done in driver layer.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>   drivers/infiniband/core/device.c            |  1 +
>   drivers/infiniband/core/uverbs.h            |  2 +-
>   drivers/infiniband/core/uverbs_cmd.c        | 26 ++++++++-----
>   drivers/infiniband/core/uverbs_main.c       | 10 ++---
>   drivers/infiniband/core/uverbs_std_types.c  |  3 +-
>   drivers/infiniband/hw/cxgb4/iw_cxgb4.h      |  5 +--
>   drivers/infiniband/hw/cxgb4/mem.c           | 35 ++++++-----------
>   drivers/infiniband/hw/cxgb4/provider.c      |  4 +-
>   drivers/infiniband/hw/hns/hns_roce_device.h |  5 +--
>   drivers/infiniband/hw/hns/hns_roce_main.c   |  2 +
>   drivers/infiniband/hw/hns/hns_roce_mr.c     | 31 +++++----------
>   drivers/infiniband/hw/mlx4/main.c           |  2 +
>   drivers/infiniband/hw/mlx4/mlx4_ib.h        |  5 +--
>   drivers/infiniband/hw/mlx4/mr.c             | 32 +++++-----------
>   drivers/infiniband/hw/mlx5/main.c           |  2 +
>   drivers/infiniband/hw/mlx5/mlx5_ib.h        |  5 +--
>   drivers/infiniband/hw/mlx5/mr.c             | 42 ++++++++-------------
>   include/rdma/ib_verbs.h                     |  6 +--
>   18 files changed, 91 insertions(+), 127 deletions(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 088559d72d57..257e8a667977 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2684,6 +2684,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>   	SET_OBJ_SIZE(dev_ops, ib_ah);
>   	SET_OBJ_SIZE(dev_ops, ib_counters);
>   	SET_OBJ_SIZE(dev_ops, ib_cq);
> +	SET_OBJ_SIZE(dev_ops, ib_mw);
>   	SET_OBJ_SIZE(dev_ops, ib_pd);
>   	SET_OBJ_SIZE(dev_ops, ib_srq);
>   	SET_OBJ_SIZE(dev_ops, ib_ucontext);
> diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
> index 53a10479958b..072bfe4e1b5b 100644
> --- a/drivers/infiniband/core/uverbs.h
> +++ b/drivers/infiniband/core/uverbs.h
> @@ -242,7 +242,7 @@ int ib_uverbs_dealloc_xrcd(struct ib_uobject *uobject, struct ib_xrcd *xrcd,
>   			   enum rdma_remove_reason why,
>   			   struct uverbs_attr_bundle *attrs);
>   
> -int uverbs_dealloc_mw(struct ib_mw *mw);
> +void uverbs_dealloc_mw(struct ib_mw *mw);
>   void ib_uverbs_detach_umcast(struct ib_qp *qp,
>   			     struct ib_uqp_object *uobj);
>   
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 68c9a0210220..a5301f3d3059 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -890,7 +890,7 @@ static int ib_uverbs_dereg_mr(struct uverbs_attr_bundle *attrs)
>   static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
>   {
>   	struct ib_uverbs_alloc_mw      cmd;
> -	struct ib_uverbs_alloc_mw_resp resp;
> +	struct ib_uverbs_alloc_mw_resp resp = {};
>   	struct ib_uobject             *uobj;
>   	struct ib_pd                  *pd;
>   	struct ib_mw                  *mw;
> @@ -916,21 +916,24 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
>   		goto err_put;
>   	}
>   
> -	mw = pd->device->ops.alloc_mw(pd, cmd.mw_type, &attrs->driver_udata);
> -	if (IS_ERR(mw)) {
> -		ret = PTR_ERR(mw);
> +	mw = rdma_zalloc_drv_obj(ib_dev, ib_mw);
> +	if (!mw) {
> +		ret = -ENOMEM;
>   		goto err_put;
>   	}
>   
> -	mw->device  = pd->device;
> -	mw->pd      = pd;
> +	mw->device = ib_dev;
> +	mw->pd = pd;
>   	mw->uobject = uobj;
> -	atomic_inc(&pd->usecnt);
> -
>   	uobj->object = mw;
> +	mw->type = cmd.mw_type;
>   
> -	memset(&resp, 0, sizeof(resp));
> -	resp.rkey      = mw->rkey;
> +	ret = pd->device->ops.alloc_mw(mw, &mw->rkey, &attrs->driver_udata);
> +	if (ret)
> +		goto err_alloc;
> +
> +	atomic_inc(&pd->usecnt);
> +	resp.rkey = mw->rkey;
>   	resp.mw_handle = uobj->id;
>   
>   	ret = uverbs_response(attrs, &resp, sizeof(resp));
> @@ -943,6 +946,9 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
>   
>   err_copy:
>   	uverbs_dealloc_mw(mw);
> +	mw = NULL;
> +err_alloc:
> +	kfree(mw);
>   err_put:
>   	uobj_put_obj_read(pd);
>   err_free:
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 69e4755cc04b..706c972ea3a1 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -102,15 +102,13 @@ struct ib_ucontext *ib_uverbs_get_ucontext_file(struct ib_uverbs_file *ufile)
>   }
>   EXPORT_SYMBOL(ib_uverbs_get_ucontext_file);
>   
> -int uverbs_dealloc_mw(struct ib_mw *mw)
> +void uverbs_dealloc_mw(struct ib_mw *mw)
>   {
>   	struct ib_pd *pd = mw->pd;
> -	int ret;
>   
> -	ret = mw->device->ops.dealloc_mw(mw);
> -	if (!ret)
> -		atomic_dec(&pd->usecnt);
> -	return ret;
> +	mw->device->ops.dealloc_mw(mw);
> +	atomic_dec(&pd->usecnt);
> +	kfree(mw);
>   }
>   
>   static void ib_uverbs_release_dev(struct device *device)
> diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
> index 08c39cfb1bd9..e4994cc4cc51 100644
> --- a/drivers/infiniband/core/uverbs_std_types.c
> +++ b/drivers/infiniband/core/uverbs_std_types.c
> @@ -72,7 +72,8 @@ static int uverbs_free_mw(struct ib_uobject *uobject,
>   			  enum rdma_remove_reason why,
>   			  struct uverbs_attr_bundle *attrs)
>   {
> -	return uverbs_dealloc_mw((struct ib_mw *)uobject->object);
> +	uverbs_dealloc_mw((struct ib_mw *)uobject->object);
> +	return 0;
>   }
>   
>   static int uverbs_free_rwq_ind_tbl(struct ib_uobject *uobject,
> diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> index 27da0705c88a..5545bcd0043e 100644
> --- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> +++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> @@ -983,10 +983,9 @@ struct ib_mr *c4iw_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>   			    u32 max_num_sg, struct ib_udata *udata);
>   int c4iw_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>   		   unsigned int *sg_offset);
> -int c4iw_dealloc_mw(struct ib_mw *mw);
> +void c4iw_dealloc_mw(struct ib_mw *mw);
>   void c4iw_dealloc(struct uld_ctx *ctx);
> -struct ib_mw *c4iw_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
> -			    struct ib_udata *udata);
> +int c4iw_alloc_mw(struct ib_mw *mw, u32 *rkey, struct ib_udata *udata);
>   struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start,
>   					   u64 length, u64 virt, int acc,
>   					   struct ib_udata *udata);
> diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
> index 1e4f4e525598..edb62d9cf404 100644
> --- a/drivers/infiniband/hw/cxgb4/mem.c
> +++ b/drivers/infiniband/hw/cxgb4/mem.c
> @@ -611,30 +611,23 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>   	return ERR_PTR(err);
>   }
>   
> -struct ib_mw *c4iw_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
> -			    struct ib_udata *udata)
> +int c4iw_alloc_mw(struct ib_mw *ibmw, u32 *rkey, struct ib_udata *udata)
>   {
> +	struct c4iw_mw *mhp = to_c4iw_mw(ibmw);
>   	struct c4iw_dev *rhp;
>   	struct c4iw_pd *php;
> -	struct c4iw_mw *mhp;
>   	u32 mmid;
>   	u32 stag = 0;
>   	int ret;
>   
> -	if (type != IB_MW_TYPE_1)
> -		return ERR_PTR(-EINVAL);
> +	if (ibmw->type != IB_MW_TYPE_1)
> +		return -EINVAL;
>   
> -	php = to_c4iw_pd(pd);
> +	php = to_c4iw_pd(ibmw->pd);
>   	rhp = php->rhp;
> -	mhp = kzalloc(sizeof(*mhp), GFP_KERNEL);
> -	if (!mhp)
> -		return ERR_PTR(-ENOMEM);
> -
>   	mhp->wr_waitp = c4iw_alloc_wr_wait(GFP_KERNEL);
> -	if (!mhp->wr_waitp) {
> -		ret = -ENOMEM;
> -		goto free_mhp;
> -	}
> +	if (!mhp->wr_waitp)
> +		return -ENOMEM;
>   
>   	mhp->dereg_skb = alloc_skb(SGE_MAX_WR_LEN, GFP_KERNEL);
>   	if (!mhp->dereg_skb) {
> @@ -645,18 +638,19 @@ struct ib_mw *c4iw_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
>   	ret = allocate_window(&rhp->rdev, &stag, php->pdid, mhp->wr_waitp);
>   	if (ret)
>   		goto free_skb;
> +
>   	mhp->rhp = rhp;
>   	mhp->attr.pdid = php->pdid;
>   	mhp->attr.type = FW_RI_STAG_MW;
>   	mhp->attr.stag = stag;
>   	mmid = (stag) >> 8;
> -	mhp->ibmw.rkey = stag;
> +	*rkey = stag;
>   	if (xa_insert_irq(&rhp->mrs, mmid, mhp, GFP_KERNEL)) {
>   		ret = -ENOMEM;
>   		goto dealloc_win;
>   	}
>   	pr_debug("mmid 0x%x mhp %p stag 0x%x\n", mmid, mhp, stag);
> -	return &(mhp->ibmw);
> +	return 0;
>   
>   dealloc_win:
>   	deallocate_window(&rhp->rdev, mhp->attr.stag, mhp->dereg_skb,
> @@ -665,12 +659,10 @@ struct ib_mw *c4iw_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
>   	kfree_skb(mhp->dereg_skb);
>   free_wr_wait:
>   	c4iw_put_wr_wait(mhp->wr_waitp);
> -free_mhp:
> -	kfree(mhp);
> -	return ERR_PTR(ret);
> +	return ret;
>   }
>   
> -int c4iw_dealloc_mw(struct ib_mw *mw)
> +void c4iw_dealloc_mw(struct ib_mw *mw)
>   {
>   	struct c4iw_dev *rhp;
>   	struct c4iw_mw *mhp;
> @@ -684,9 +676,6 @@ int c4iw_dealloc_mw(struct ib_mw *mw)
>   			  mhp->wr_waitp);
>   	kfree_skb(mhp->dereg_skb);
>   	c4iw_put_wr_wait(mhp->wr_waitp);
> -	pr_debug("ib_mw %p mmid 0x%x ptr %p\n", mw, mmid, mhp);
> -	kfree(mhp);
> -	return 0;
>   }
>   
>   struct ib_mr *c4iw_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
> diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
> index 1d3ff59e4060..7ec74e2fa885 100644
> --- a/drivers/infiniband/hw/cxgb4/provider.c
> +++ b/drivers/infiniband/hw/cxgb4/provider.c
> @@ -508,8 +508,10 @@ static const struct ib_device_ops c4iw_dev_ops = {
>   	.query_qp = c4iw_ib_query_qp,
>   	.reg_user_mr = c4iw_reg_user_mr,
>   	.req_notify_cq = c4iw_arm_cq,
> -	INIT_RDMA_OBJ_SIZE(ib_pd, c4iw_pd, ibpd),
> +
>   	INIT_RDMA_OBJ_SIZE(ib_cq, c4iw_cq, ibcq),
> +	INIT_RDMA_OBJ_SIZE(ib_mw, c4iw_mw, ibmw),
> +	INIT_RDMA_OBJ_SIZE(ib_pd, c4iw_pd, ibpd),
>   	INIT_RDMA_OBJ_SIZE(ib_srq, c4iw_srq, ibsrq),
>   	INIT_RDMA_OBJ_SIZE(ib_ucontext, c4iw_ucontext, ibucontext),
>   };
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index b890ff63f24d..e745e5c41770 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -1201,9 +1201,8 @@ int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
>   			    unsigned long mpt_index);
>   unsigned long key_to_hw_index(u32 key);
>   
> -struct ib_mw *hns_roce_alloc_mw(struct ib_pd *pd, enum ib_mw_type,
> -				struct ib_udata *udata);
> -int hns_roce_dealloc_mw(struct ib_mw *ibmw);
> +int hns_roce_alloc_mw(struct ib_mw *pd, u32 *rkey, struct ib_udata *udata);
> +void hns_roce_dealloc_mw(struct ib_mw *ibmw);
>   
>   void hns_roce_buf_free(struct hns_roce_dev *hr_dev, struct hns_roce_buf *buf);
>   int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index 5907cfd878a6..45f7353bd348 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -454,6 +454,8 @@ static const struct ib_device_ops hns_roce_dev_mr_ops = {
>   static const struct ib_device_ops hns_roce_dev_mw_ops = {
>   	.alloc_mw = hns_roce_alloc_mw,
>   	.dealloc_mw = hns_roce_dealloc_mw,
> +
> +	INIT_RDMA_OBJ_SIZE(ib_mw, hns_roce_mw, ibmw),
>   };
>   
>   static const struct ib_device_ops hns_roce_dev_frmr_ops = {
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index 0e71ebee9e52..4af2797c3b95 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -589,28 +589,22 @@ static int hns_roce_mw_enable(struct hns_roce_dev *hr_dev,
>   	return ret;
>   }
>   
> -struct ib_mw *hns_roce_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
> -				struct ib_udata *udata)
> +int hns_roce_alloc_mw(struct ib_mw *ibmw, u32 *rkey, struct ib_udata *udata)
>   {
> -	struct hns_roce_dev *hr_dev = to_hr_dev(ib_pd->device);
> -	struct hns_roce_mw *mw;
> +	struct hns_roce_dev *hr_dev = to_hr_dev(ibmw->device);
> +	struct hns_roce_mw *mw = to_hr_mw(ibmw);
>   	unsigned long index = 0;
>   	int ret;
>   
> -	mw = kmalloc(sizeof(*mw), GFP_KERNEL);
> -	if (!mw)
> -		return ERR_PTR(-ENOMEM);
> -
>   	/* Allocate a key for mw from bitmap */
>   	ret = hns_roce_bitmap_alloc(&hr_dev->mr_table.mtpt_bitmap, &index);
>   	if (ret)
> -		goto err_bitmap;
> +		return ret;
>   
>   	mw->rkey = hw_index_to_key(index);
>   
> -	mw->ibmw.rkey = mw->rkey;
> -	mw->ibmw.type = type;
> -	mw->pdn = to_hr_pd(ib_pd)->pdn;
> +	*rkey = mw->rkey;
> +	mw->pdn = to_hr_pd(ibmw->pd)->pdn;
>   	mw->pbl_hop_num = hr_dev->caps.pbl_hop_num;
>   	mw->pbl_ba_pg_sz = hr_dev->caps.pbl_ba_pg_sz;
>   	mw->pbl_buf_pg_sz = hr_dev->caps.pbl_buf_pg_sz;
> @@ -619,26 +613,19 @@ struct ib_mw *hns_roce_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
>   	if (ret)
>   		goto err_mw;
>   
> -	return &mw->ibmw;
> +	return 0;
>   
>   err_mw:
>   	hns_roce_mw_free(hr_dev, mw);
> -
> -err_bitmap:
> -	kfree(mw);
> -
> -	return ERR_PTR(ret);
> +	return ret;
>   }
>   
> -int hns_roce_dealloc_mw(struct ib_mw *ibmw)
> +void hns_roce_dealloc_mw(struct ib_mw *ibmw)
>   {
>   	struct hns_roce_dev *hr_dev = to_hr_dev(ibmw->device);
>   	struct hns_roce_mw *mw = to_hr_mw(ibmw);
>   
>   	hns_roce_mw_free(hr_dev, mw);
> -	kfree(mw);
> -
> -	return 0;
>   }
>   
>   static int mtr_map_region(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
> diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
> index 816d28854a8e..6471f47bd365 100644
> --- a/drivers/infiniband/hw/mlx4/main.c
> +++ b/drivers/infiniband/hw/mlx4/main.c
> @@ -2602,6 +2602,8 @@ static const struct ib_device_ops mlx4_ib_dev_wq_ops = {
>   static const struct ib_device_ops mlx4_ib_dev_mw_ops = {
>   	.alloc_mw = mlx4_ib_alloc_mw,
>   	.dealloc_mw = mlx4_ib_dealloc_mw,
> +
> +	INIT_RDMA_OBJ_SIZE(ib_mw, mlx4_ib_mw, ibmw),
>   };
>   
>   static const struct ib_device_ops mlx4_ib_dev_xrc_ops = {
> diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> index 6f4ea1067095..5fbe766aef6b 100644
> --- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
> +++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> @@ -725,9 +725,8 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>   				  u64 virt_addr, int access_flags,
>   				  struct ib_udata *udata);
>   int mlx4_ib_dereg_mr(struct ib_mr *mr, struct ib_udata *udata);
> -struct ib_mw *mlx4_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
> -			       struct ib_udata *udata);
> -int mlx4_ib_dealloc_mw(struct ib_mw *mw);
> +int mlx4_ib_alloc_mw(struct ib_mw *mw, u32 *rkey, struct ib_udata *udata);
> +void mlx4_ib_dealloc_mw(struct ib_mw *mw);
>   struct ib_mr *mlx4_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>   			       u32 max_num_sg, struct ib_udata *udata);
>   int mlx4_ib_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
> diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
> index d7c78f841d2f..82d7d8dcc9d4 100644
> --- a/drivers/infiniband/hw/mlx4/mr.c
> +++ b/drivers/infiniband/hw/mlx4/mr.c
> @@ -610,47 +610,35 @@ int mlx4_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>   	return 0;
>   }
>   
> -struct ib_mw *mlx4_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
> -			       struct ib_udata *udata)
> +int mlx4_ib_alloc_mw(struct ib_mw *ibmw, u32 *rkey, struct ib_udata *udata)
>   {
> -	struct mlx4_ib_dev *dev = to_mdev(pd->device);
> -	struct mlx4_ib_mw *mw;
> +	struct mlx4_ib_dev *dev = to_mdev(ibmw->device);
> +	struct mlx4_ib_mw *mw = to_mmw(ibmw);
>   	int err;
>   
> -	mw = kmalloc(sizeof(*mw), GFP_KERNEL);
> -	if (!mw)
> -		return ERR_PTR(-ENOMEM);
> -
> -	err = mlx4_mw_alloc(dev->dev, to_mpd(pd)->pdn,
> -			    to_mlx4_type(type), &mw->mmw);
> +	err = mlx4_mw_alloc(dev->dev, to_mpd(ibmw->pd)->pdn,
> +			    to_mlx4_type(ibmw->type), &mw->mmw);
>   	if (err)
> -		goto err_free;
> +		return err;
>   
>   	err = mlx4_mw_enable(dev->dev, &mw->mmw);
>   	if (err)
>   		goto err_mw;
>   
> -	mw->ibmw.rkey = mw->mmw.key;
> +	*rkey = mw->mmw.key;
>   
> -	return &mw->ibmw;
> +	return 0;
>   
>   err_mw:
>   	mlx4_mw_free(dev->dev, &mw->mmw);
> -
> -err_free:
> -	kfree(mw);
> -
> -	return ERR_PTR(err);
> +	return err;
>   }
>   
> -int mlx4_ib_dealloc_mw(struct ib_mw *ibmw)
> +void mlx4_ib_dealloc_mw(struct ib_mw *ibmw)
>   {
>   	struct mlx4_ib_mw *mw = to_mmw(ibmw);
>   
>   	mlx4_mw_free(to_mdev(ibmw->device)->dev, &mw->mmw);
> -	kfree(mw);
> -
> -	return 0;
>   }
>   
>   struct ib_mr *mlx4_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index ca35394a181a..8b0b1f95af2f 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -6669,6 +6669,8 @@ static const struct ib_device_ops mlx5_ib_dev_sriov_ops = {
>   static const struct ib_device_ops mlx5_ib_dev_mw_ops = {
>   	.alloc_mw = mlx5_ib_alloc_mw,
>   	.dealloc_mw = mlx5_ib_dealloc_mw,
> +
> +	INIT_RDMA_OBJ_SIZE(ib_mw, mlx5_ib_mw, ibmw),
>   };
>   
>   static const struct ib_device_ops mlx5_ib_dev_xrc_ops = {
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index 26545e88709d..d84f56517caa 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -1195,9 +1195,8 @@ int mlx5_ib_advise_mr(struct ib_pd *pd,
>   		      struct ib_sge *sg_list,
>   		      u32 num_sge,
>   		      struct uverbs_attr_bundle *attrs);
> -struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
> -			       struct ib_udata *udata);
> -int mlx5_ib_dealloc_mw(struct ib_mw *mw);
> +int mlx5_ib_alloc_mw(struct ib_mw *mw, u32 *rkey, struct ib_udata *udata);
> +void mlx5_ib_dealloc_mw(struct ib_mw *mw);
>   int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
>   		       int page_shift, int flags);
>   struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 44683073be0c..58a3d62937a1 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1973,12 +1973,11 @@ struct ib_mr *mlx5_ib_alloc_mr_integrity(struct ib_pd *pd,
>   				  max_num_meta_sg);
>   }
>   
> -struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
> -			       struct ib_udata *udata)
> +int mlx5_ib_alloc_mw(struct ib_mw *ibmw, u32 *rkey, struct ib_udata *udata)
>   {
> -	struct mlx5_ib_dev *dev = to_mdev(pd->device);
> +	struct mlx5_ib_dev *dev = to_mdev(ibmw->device);
>   	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
> -	struct mlx5_ib_mw *mw = NULL;
> +	struct mlx5_ib_mw *mw = to_mmw(ibmw);
>   	u32 *in = NULL;
>   	void *mkc;
>   	int ndescs;
> @@ -1991,21 +1990,20 @@ struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
>   
>   	err = ib_copy_from_udata(&req, udata, min(udata->inlen, sizeof(req)));
>   	if (err)
> -		return ERR_PTR(err);
> +		return err;
>   
>   	if (req.comp_mask || req.reserved1 || req.reserved2)
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>   
>   	if (udata->inlen > sizeof(req) &&
>   	    !ib_is_udata_cleared(udata, sizeof(req),
>   				 udata->inlen - sizeof(req)))
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return -EOPNOTSUPP;
>   
>   	ndescs = req.num_klms ? roundup(req.num_klms, 4) : roundup(1, 4);
>   
> -	mw = kzalloc(sizeof(*mw), GFP_KERNEL);
>   	in = kzalloc(inlen, GFP_KERNEL);
> -	if (!mw || !in) {
> +	if (!in) {
>   		err = -ENOMEM;
>   		goto free;
>   	}
> @@ -2014,11 +2012,11 @@ struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
>   
>   	MLX5_SET(mkc, mkc, free, 1);
>   	MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
> -	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
> +	MLX5_SET(mkc, mkc, pd, to_mpd(ibmw->pd)->pdn);
>   	MLX5_SET(mkc, mkc, umr_en, 1);
>   	MLX5_SET(mkc, mkc, lr, 1);
>   	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_KLMS);
> -	MLX5_SET(mkc, mkc, en_rinval, !!((type == IB_MW_TYPE_2)));
> +	MLX5_SET(mkc, mkc, en_rinval, !!((ibmw->type == IB_MW_TYPE_2)));
>   	MLX5_SET(mkc, mkc, qpn, 0xffffff);
>   
>   	err = mlx5_ib_create_mkey(dev, &mw->mmkey, in, inlen);
> @@ -2026,17 +2024,15 @@ struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
>   		goto free;
>   
>   	mw->mmkey.type = MLX5_MKEY_MW;
> -	mw->ibmw.rkey = mw->mmkey.key;
> +	*rkey = mw->mmkey.key;
>   	mw->ndescs = ndescs;
>   
>   	resp.response_length = min(offsetof(typeof(resp), response_length) +
>   				   sizeof(resp.response_length), udata->outlen);
>   	if (resp.response_length) {
>   		err = ib_copy_to_udata(udata, &resp, resp.response_length);
> -		if (err) {
> -			mlx5_core_destroy_mkey(dev->mdev, &mw->mmkey);
> -			goto free;
> -		}
> +		if (err)
> +			goto free_mkey;
>   	}
>   
>   	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
> @@ -2048,21 +2044,19 @@ struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
>   	}
>   
>   	kfree(in);
> -	return &mw->ibmw;
> +	return 0;
>   
>   free_mkey:
>   	mlx5_core_destroy_mkey(dev->mdev, &mw->mmkey);
>   free:
> -	kfree(mw);
>   	kfree(in);
> -	return ERR_PTR(err);
> +	return err;
>   }
>   
> -int mlx5_ib_dealloc_mw(struct ib_mw *mw)
> +void mlx5_ib_dealloc_mw(struct ib_mw *mw)
>   {
>   	struct mlx5_ib_dev *dev = to_mdev(mw->device);
>   	struct mlx5_ib_mw *mmw = to_mmw(mw);
> -	int err;
>   
>   	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
>   		xa_erase(&dev->odp_mkeys, mlx5_base_mkey(mmw->mmkey.key));
> @@ -2073,11 +2067,7 @@ int mlx5_ib_dealloc_mw(struct ib_mw *mw)
>   		synchronize_srcu(&dev->odp_srcu);
>   	}
>   
> -	err = mlx5_core_destroy_mkey(dev->mdev, &mmw->mmkey);
> -	if (err)
> -		return err;
> -	kfree(mmw);
> -	return 0;
> +	mlx5_core_destroy_mkey(dev->mdev, &mmw->mmkey);

Are we fully sure that this can never be triggered by user space to fail 
as of the property of the MW that can be binded with bypassing kernel ? 
the new code just ignored the err.

>   }
>   
>   int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 3aa20ce23556..7160662899bb 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2490,9 +2490,8 @@ struct ib_device_ops {
>   			 unsigned int *sg_offset);
>   	int (*check_mr_status)(struct ib_mr *mr, u32 check_mask,
>   			       struct ib_mr_status *mr_status);
> -	struct ib_mw *(*alloc_mw)(struct ib_pd *pd, enum ib_mw_type type,
> -				  struct ib_udata *udata);
> -	int (*dealloc_mw)(struct ib_mw *mw);
> +	int (*alloc_mw)(struct ib_mw *mw, u32 *rkey, struct ib_udata *udata);
> +	void (*dealloc_mw)(struct ib_mw *mw);
>   	int (*attach_mcast)(struct ib_qp *qp, union ib_gid *gid, u16 lid);
>   	int (*detach_mcast)(struct ib_qp *qp, union ib_gid *gid, u16 lid);
>   	struct ib_xrcd *(*alloc_xrcd)(struct ib_device *device,
> @@ -2653,6 +2652,7 @@ struct ib_device_ops {
>   	DECLARE_RDMA_OBJ_SIZE(ib_ah);
>   	DECLARE_RDMA_OBJ_SIZE(ib_counters);
>   	DECLARE_RDMA_OBJ_SIZE(ib_cq);
> +	DECLARE_RDMA_OBJ_SIZE(ib_mw);
>   	DECLARE_RDMA_OBJ_SIZE(ib_pd);
>   	DECLARE_RDMA_OBJ_SIZE(ib_srq);
>   	DECLARE_RDMA_OBJ_SIZE(ib_ucontext);
> 

