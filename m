Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5FC37272C
	for <lists+linux-rdma@lfdr.de>; Tue,  4 May 2021 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhEDI0t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 May 2021 04:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhEDI0s (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 May 2021 04:26:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC1FF6023C;
        Tue,  4 May 2021 08:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620116754;
        bh=lyUvO8wDMyZ0Z0GJaYiY7oMjn3xDvDRiwe0amVL95bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WYVMYad3aMpgoiIpcoEH0TGohIpeot3bm8mcgjiZHUxM0L2GHUyvacWxep7Irvekj
         wbIQbiWe3coF7YmXq/J11a+RTDCZC9Gbh38GAodPZP69llK6Pk7qQvCIvinQMeNWMD
         NblsKU8UB/31fgaEtD1NsIdvZdBWtCoQSnNgs0i+RKnAcfIheSz012x5m7tzmLUO4k
         vcx8iixwF4u9GjIi+zGydppUyUJzliYMeUKC1ROzEErbaL0iY+fFlkDDwIdUMdkD5X
         I13PLXY3qtpcVhx+Br1wN3WsdqzxBw117KzAtaClTEA+OCP70kU+V/H6tyedl+wNAG
         JOAm0+1ZNjong==
Date:   Tue, 4 May 2021 11:25:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     maorg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/mlx5: Add support in MEMIC operations
Message-ID: <YJEFDmeCW3IjTdWc@unreal>
References: <YJD81HgeXxGUMaik@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJD81HgeXxGUMaik@mwanda>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 04, 2021 at 10:50:44AM +0300, Dan Carpenter wrote:
> Hello Maor Gottlieb,
> 
> The patch cea85fa5dbc2: "RDMA/mlx5: Add support in MEMIC operations"
> from Apr 11, 2021, leads to the following static checker warning:
> 
> 	drivers/infiniband/hw/mlx5/dm.c:220 mlx5_ib_handler_MLX5_IB_METHOD_DM_MAP_OP_ADDR()
> 	error: undefined (user controlled) shift '(((1))) << op'
> 
> drivers/infiniband/hw/mlx5/dm.c
>    204  static int UVERBS_HANDLER(MLX5_IB_METHOD_DM_MAP_OP_ADDR)(
>    205          struct uverbs_attr_bundle *attrs)
>    206  {
>    207          struct ib_uobject *uobj = uverbs_attr_get_uobject(
>    208                  attrs, MLX5_IB_ATTR_DM_MAP_OP_ADDR_REQ_HANDLE);
>    209          struct mlx5_ib_dev *dev = to_mdev(uobj->context->device);
>    210          struct ib_dm *ibdm = uobj->object;
>    211          struct mlx5_ib_dm_memic *dm = to_memic(ibdm);
>    212          struct mlx5_ib_dm_op_entry *op_entry;
>    213          int err;
>    214          u8 op;
>    215  
>    216          err = uverbs_copy_from(&op, attrs, MLX5_IB_ATTR_DM_MAP_OP_ADDR_REQ_OP);
>                                         ^^
> op is user controlled and in the 0-255 range.
> 
>    217          if (err)
>    218                  return err;
>    219  
>    220          if (!(MLX5_CAP_DEV_MEM(dev->mdev, memic_operations) & BIT(op)))
>                                                                       ^^^^^^^
> If it's more than 31 then this is undefined (shift wrapping generally).
> Plus it might trigger a UBSan warning at run time.


Thanks Dan, we will prepare the proper patch.
It should be something like this:
diff --git a/drivers/infiniband/hw/mlx5/dm.c b/drivers/infiniband/hw/mlx5/dm.c
index 094bf85589db..dd4480aed1aa 100644
--- a/drivers/infiniband/hw/mlx5/dm.c
+++ b/drivers/infiniband/hw/mlx5/dm.c
@@ -217,6 +217,9 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DM_MAP_OP_ADDR)(
        if (err)
                return err;

+       if (op > 31)
+               return -EINVAL;
+
        if (!(MLX5_CAP_DEV_MEM(dev->mdev, memic_operations) & BIT(op)))
                return -EOPNOTSUPP;


> 
>    221                  return -EOPNOTSUPP;
>    222  
>    223          mutex_lock(&dm->ops_xa_lock);
> 
> regards,
> dan carpenter
