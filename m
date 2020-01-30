Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DACF814DF10
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 17:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgA3Q0J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 11:26:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgA3Q0J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jan 2020 11:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+/B0HE6zQa3p2gL4st+HS2DOfpN4KdCnCEoeP4VJIFo=; b=LZWDyaRDVFK+syuICN40rElEC
        1Yj1lKoUS7e2q4dPB93/dwLIgVJf+pH7Rvj2MftTdNrrjQXIuPWTpA9/w3ATVvLELmaLqooyWOdWq
        8gkaDUu4xNRq+AzZ+e5fzxmH0Sphe9rOOdL+duuX6FSOfIo6gYG8bQzMRfjafRsWNHTiKkXFLzCO3
        PDCPi7ZUIZvM7m1ZN2fGwt3O0Hiqht5HWt8bEqsnD28QQmD1TATBNGC2go4wLQyU25YTVC+ybUs64
        4R/4RssO4UvkpleSCUqtZJnwtCVuzpVNx7Fotq/ISHx7GQPDvl6+tsqNUGcHEfWEclqPLOsOdW5y4
        OtFUvezVg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixCdp-0002Wz-8Q; Thu, 30 Jan 2020 16:26:05 +0000
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix compilation breakage without
 INFINIBAND_USER_ACCESS
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20200130112957.337869-1-leon@kernel.org>
 <20200130153426.GF21192@mellanox.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b619c5ca-dac0-cb02-21a3-68dfeb59cd1d@infradead.org>
Date:   Thu, 30 Jan 2020 08:26:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130153426.GF21192@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/30/20 7:34 AM, Jason Gunthorpe wrote:
> On Thu, Jan 30, 2020 at 01:29:57PM +0200, Leon Romanovsky wrote:
>> From: Leon Romanovsky <leonro@mellanox.com>
>>
>> Compilation of mlx5 driver without CONFIG_INFINIBAND_USER_ACCESS generates
>> the following error.
>>
>> on x86_64:
>>
>> ld: drivers/infiniband/hw/mlx5/main.o: in function `mlx5_ib_handler_MLX5_IB_METHOD_VAR_OBJ_ALLOC':
>> main.c:(.text+0x186d): undefined reference to `ib_uverbs_get_ucontext_file'
>> ld: drivers/infiniband/hw/mlx5/main.o:(.rodata+0x2480): undefined reference to `uverbs_idr_class'
>> ld: drivers/infiniband/hw/mlx5/main.o:(.rodata+0x24d8): undefined reference to `uverbs_destroy_def_handler'
>>
>> Guard the problematic code, so VAR objects API won't be compiled without CONFIG_INFINIBAND_USER_ACCESS.
>>
>> Fixes: 7be76bef320b ("IB/mlx5: Introduce VAR object and its alloc/destroy methods")
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>>  drivers/infiniband/hw/mlx5/main.c | 22 +++++++++++++---------
>>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> Hurm. This is actually a side effect of some other code that needs to
> be deleted.. We can now make all the generated structs static and rely
> on compiler pruning to sort this out.
> 
> So this:
> 
>         if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
>                 dev->ib_dev.driver_def = mlx5_ib_defs;
> 
> Will cause the compiler to drop the entire tree of stuff, above
> references inclded.
> 
> See below:
> 
> From fb22c0daf5fac6fd5e014e691f7c92421d848330 Mon Sep 17 00:00:00 2001
> From: Jason Gunthorpe <jgg@mellanox.com>
> Date: Thu, 30 Jan 2020 11:21:21 -0400
> Subject: [PATCH] RDMA/core: Make the entire API tree static
> 
> Compilation of mlx5 driver without CONFIG_INFINIBAND_USER_ACCESS generates
> the following error.
> 
> on x86_64:
> 
>  ld: drivers/infiniband/hw/mlx5/main.o: in function `mlx5_ib_handler_MLX5_IB_METHOD_VAR_OBJ_ALLOC':
>  main.c:(.text+0x186d): undefined reference to `ib_uverbs_get_ucontext_file'
>  ld: drivers/infiniband/hw/mlx5/main.o:(.rodata+0x2480): undefined reference to `uverbs_idr_class'
>  ld: drivers/infiniband/hw/mlx5/main.o:(.rodata+0x24d8): undefined reference to `uverbs_destroy_def_handler'
> 
> This is happening because some parts of the UAPI description are not
> static. This is a hold over from earlier code that relied on struct
> pointers to refer to object types, now object types are referenced by
> number. Remove the unused globals and add statics to the remaining UAPI
> description elements.
> 
> Remove the redundent #ifdefs around mlx5_ib_*defs and obsolete
> mlx5_ib_get_devx_tree().
> 
> The compiler now trims alot more unused code, including the above
> problematic definitions when !CONFIG_INFINIBAND_USER_ACCESS.
> 
> Fixes: 7be76bef320b ("IB/mlx5: Introduce VAR object and its alloc/destroy methods")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Yes, that works also.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  drivers/infiniband/core/uverbs.h     | 17 -----------------
>  drivers/infiniband/hw/mlx5/main.c    |  2 --
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  6 +++---
>  include/rdma/uverbs_named_ioctl.h    |  6 +++---
>  4 files changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
> index 4d4cec46d25132..7df71983212d6f 100644
> --- a/drivers/infiniband/core/uverbs.h
> +++ b/drivers/infiniband/core/uverbs.h
> @@ -271,23 +271,6 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_flow_spec_type type,
>  					  size_t kern_filter_sz,
>  					  union ib_flow_spec *ib_spec);
>  
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_DEVICE);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_PD);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_MR);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_COMP_CHANNEL);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_CQ);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_QP);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_AH);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_MW);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_SRQ);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_FLOW);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_WQ);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_RWQ_IND_TBL);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_XRCD);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_FLOW_ACTION);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_DM);
> -extern const struct uverbs_object_def UVERBS_OBJECT(UVERBS_OBJECT_COUNTERS);
> -
>  /*
>   * ib_uverbs_query_port_resp.port_cap_flags started out as just a copy of the
>   * PortInfo CapabilityMask, but was extended with unique bits.
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 01fc09f3ddd3f9..0ca9581432808c 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -6247,10 +6247,8 @@ ADD_UVERBS_ATTRIBUTES_SIMPLE(
>  			     enum mlx5_ib_uapi_flow_action_flags));
>  
>  static const struct uapi_definition mlx5_ib_defs[] = {
> -#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
>  	UAPI_DEF_CHAIN(mlx5_ib_devx_defs),
>  	UAPI_DEF_CHAIN(mlx5_ib_flow_defs),
> -#endif
>  
>  	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_FLOW_ACTION,
>  				&mlx5_ib_flow_action),
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index 7b019bd4de4b2b..c160a43d77f0fd 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -1379,14 +1379,14 @@ int mlx5_ib_fill_res_entry(struct sk_buff *msg,
>  int mlx5_ib_fill_stat_entry(struct sk_buff *msg,
>  			    struct rdma_restrack_entry *res);
>  
> +extern const struct uapi_definition mlx5_ib_devx_defs[];
> +extern const struct uapi_definition mlx5_ib_flow_defs[];
> +
>  #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
>  int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user);
>  void mlx5_ib_devx_destroy(struct mlx5_ib_dev *dev, u16 uid);
>  void mlx5_ib_devx_init_event_table(struct mlx5_ib_dev *dev);
>  void mlx5_ib_devx_cleanup_event_table(struct mlx5_ib_dev *dev);
> -const struct uverbs_object_tree_def *mlx5_ib_get_devx_tree(void);
> -extern const struct uapi_definition mlx5_ib_devx_defs[];
> -extern const struct uapi_definition mlx5_ib_flow_defs[];
>  struct mlx5_ib_flow_handler *mlx5_ib_raw_fs_rule_add(
>  	struct mlx5_ib_dev *dev, struct mlx5_ib_flow_matcher *fs_matcher,
>  	struct mlx5_flow_context *flow_context,
> diff --git a/include/rdma/uverbs_named_ioctl.h b/include/rdma/uverbs_named_ioctl.h
> index 3447bfe356d6ea..6ae6cf8e4c2e13 100644
> --- a/include/rdma/uverbs_named_ioctl.h
> +++ b/include/rdma/uverbs_named_ioctl.h
> @@ -76,7 +76,7 @@
>  #define DECLARE_UVERBS_NAMED_OBJECT(_object_id, _type_attrs, ...)              \
>  	static const struct uverbs_method_def *const UVERBS_OBJECT_METHODS(    \
>  		_object_id)[] = { __VA_ARGS__ };                               \
> -	const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {           \
> +	static const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {    \
>  		.id = _object_id,                                              \
>  		.type_attrs = &_type_attrs,                                    \
>  		.num_methods = ARRAY_SIZE(UVERBS_OBJECT_METHODS(_object_id)),  \
> @@ -88,10 +88,10 @@
>   * identify all uapi methods with a (object,method) tuple. However, they have
>   * no type pointer.
>   */
> -#define DECLARE_UVERBS_GLOBAL_METHODS(_object_id, ...)	\
> +#define DECLARE_UVERBS_GLOBAL_METHODS(_object_id, ...)                         \
>  	static const struct uverbs_method_def *const UVERBS_OBJECT_METHODS(    \
>  		_object_id)[] = { __VA_ARGS__ };                               \
> -	const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {           \
> +	static const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {    \
>  		.id = _object_id,                                              \
>  		.num_methods = ARRAY_SIZE(UVERBS_OBJECT_METHODS(_object_id)),  \
>  		.methods = &UVERBS_OBJECT_METHODS(_object_id)                  \
> 


-- 
~Randy

