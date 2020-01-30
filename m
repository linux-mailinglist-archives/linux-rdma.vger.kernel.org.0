Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A41A814DC18
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 14:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgA3Nit (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 08:38:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35174 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3Nit (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jan 2020 08:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gj4tBMP45cheovXlG2oW95mLv7WGrgWxvXCmk0mYmW0=; b=g7mj9+jaHUzIhsK5QpQ0dOzB1
        Jvq8vBpDpaFIbqZTHS+2fQ2BjM93+rkPp4Z6SdpgI/8xM9n6R18pkTc16bxsPBDk5Das97BsAtAu3
        tHsLz2QXdJIVhWs4Wb7LmUl6OO1YuBHZx9x1PyZhBhSqlmuCAHxIuZk7b5klToGd57cxXhfPqaq4L
        veSDcl7AyARGLW2Yjs+d0QCQthubfQfTkNFMoTDSaN9h7SEXSqULHm/98Vhd3jJ+IE+4WOadJEbDB
        gNeh65IRf1T47HoKsN9q8UFaUaC7bh6F4FQJgDQl5NxvF+OKnKyYMsiDDzGHd6z/dn3+8cE9oqv8c
        wqMiAnn0w==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixA1v-0006I9-15; Thu, 30 Jan 2020 13:38:47 +0000
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix compilation breakage without
 INFINIBAND_USER_ACCESS
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20200130112957.337869-1-leon@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cfba94b4-9729-8a28-3ab2-23d06b3fce8e@infradead.org>
Date:   Thu, 30 Jan 2020 05:38:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130112957.337869-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/30/20 3:29 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Compilation of mlx5 driver without CONFIG_INFINIBAND_USER_ACCESS generates
> the following error.
> 
> on x86_64:
> 
> ld: drivers/infiniband/hw/mlx5/main.o: in function `mlx5_ib_handler_MLX5_IB_METHOD_VAR_OBJ_ALLOC':
> main.c:(.text+0x186d): undefined reference to `ib_uverbs_get_ucontext_file'
> ld: drivers/infiniband/hw/mlx5/main.o:(.rodata+0x2480): undefined reference to `uverbs_idr_class'
> ld: drivers/infiniband/hw/mlx5/main.o:(.rodata+0x24d8): undefined reference to `uverbs_destroy_def_handler'
> 
> Guard the problematic code, so VAR objects API won't be compiled without CONFIG_INFINIBAND_USER_ACCESS.
> 
> Fixes: 7be76bef320b ("IB/mlx5: Introduce VAR object and its alloc/destroy methods")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/infiniband/hw/mlx5/main.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 41ccc19d229e..c2afe6929cbb 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -2280,15 +2280,6 @@ static int mlx5_ib_mmap_offset(struct mlx5_ib_dev *dev,
>  	return ret;
>  }
> 
> -static u64 mlx5_entry_to_mmap_offset(struct mlx5_user_mmap_entry *entry)
> -{
> -	u16 cmd = entry->rdma_entry.start_pgoff >> 16;
> -	u16 index = entry->rdma_entry.start_pgoff & 0xFFFF;
> -
> -	return (((index >> 8) << 16) | (cmd << MLX5_IB_MMAP_CMD_SHIFT) |
> -		(index & 0xFF)) << PAGE_SHIFT;
> -}
> -
>  static int mlx5_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
>  {
>  	struct mlx5_ib_ucontext *context = to_mucontext(ibcontext);
> @@ -6085,6 +6076,16 @@ static void mlx5_ib_cleanup_multiport_master(struct mlx5_ib_dev *dev)
>  	mlx5_nic_vport_disable_roce(dev->mdev);
>  }
> 
> +#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
> +static u64 mlx5_entry_to_mmap_offset(struct mlx5_user_mmap_entry *entry)
> +{
> +	u16 cmd = entry->rdma_entry.start_pgoff >> 16;
> +	u16 index = entry->rdma_entry.start_pgoff & 0xFFFF;
> +
> +	return (((index >> 8) << 16) | (cmd << MLX5_IB_MMAP_CMD_SHIFT) |
> +		(index & 0xFF)) << PAGE_SHIFT;
> +}
> +
>  static int var_obj_cleanup(struct ib_uobject *uobject,
>  			   enum rdma_remove_reason why,
>  			   struct uverbs_attr_bundle *attrs)
> @@ -6223,6 +6224,7 @@ static bool var_is_supported(struct ib_device *device)
>  	return (MLX5_CAP_GEN_64(dev->mdev, general_obj_types) &
>  			MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q);
>  }
> +#endif
> 
>  ADD_UVERBS_ATTRIBUTES_SIMPLE(
>  	mlx5_ib_dm,
> @@ -6254,8 +6256,10 @@ static const struct uapi_definition mlx5_ib_defs[] = {
>  	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_FLOW_ACTION,
>  				&mlx5_ib_flow_action),
>  	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_DM, &mlx5_ib_dm),
> +#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
>  	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(MLX5_IB_OBJECT_VAR,
>  				UAPI_DEF_IS_OBJ_SUPPORTED(var_is_supported)),
> +#endif
>  	{}
>  };
> 
> --
> 2.24.1
> 


-- 
~Randy

