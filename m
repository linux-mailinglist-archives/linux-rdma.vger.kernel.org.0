Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D372B9F2
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 20:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfE0SPg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 14:15:36 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41295 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfE0SPg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 14:15:36 -0400
Received: by mail-ua1-f67.google.com with SMTP id l14so6794053uah.8
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8hNxMGBAGDDkJj992yk9VOgjaUK9vfpRQoQGfXOovpE=;
        b=R35p3owaTNtpz8MKhE3eb7p90Rmi3WA5z/IJLfYWxVZBpq3sSmZbyPaLZ+g95OFPLj
         9nln1OdB5Rvf8gwb4rQbRYIsNLusvEJXx7zGVj5EYwA83fEJtc5HaF1UNeCxOy5omeDa
         GAyE56QpwHgC0CT68m18jw6FEeT/1n2spYPfWdSBhQgdW6IKW3e90iju4iJHMzcjoEr8
         zyTxg1uWCQHDh7WZaUCrOJIKk18+S8uCyT77OMo4QJ0+v9wCEPzhPZEmgYXkMXXMm8VG
         MtX0tokKVf2ITpLZZPa0p/ErpJtrljHSYPhMSlFxTmruq7ArzrEqc5QUvzfeuyQkWFG2
         epXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8hNxMGBAGDDkJj992yk9VOgjaUK9vfpRQoQGfXOovpE=;
        b=qgd248xXt4coA30mApSsQ58J6nkstoUaKVt4FHC86wbmzueud/6qu6gK74ef8TRqSE
         gZynSN0UIelLY4T87xbpxzv3xYDMyXnZ3nGHmHSkoM2pYlIUei98kQv46pgH921NyVQj
         3dWPwNa0EbE/nGv+r7HLiPpH/gkVz/nmn/Ag8ytv9QCJjFTkHv1nk9qvgZqOgCqRqRkC
         lP30IudWYvZe+iOR0KUozqDPBOI7IUkNVI904RXXtEdapwcMKjg21whqYqRiw2hZgL+P
         cj9D9YLVa4iM0kifGihi6Syhpt4ibMukDuQWgYhtDe9U6Oj9oj6FjJIdcHO5eL23+nyf
         nVBw==
X-Gm-Message-State: APjAAAVzentBDCSDClcvQsMUE2MVfABjuIh439LoWIqqb4IfbeUn9zMC
        mlZ2PjgJCbN50RXWA/wp2UOsEw==
X-Google-Smtp-Source: APXvYqwv7ANsIWSla6GVRQobbng/bEadzUM3um96jeSPyG6hwcnv7WioNf8L1mG+BSjhPwpAO5GK0w==
X-Received: by 2002:ab0:4a97:: with SMTP id s23mr22342607uae.19.1558980935337;
        Mon, 27 May 2019 11:15:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id b78sm4160999vkb.10.2019.05.27.11.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 11:15:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVK9m-0002cU-92; Mon, 27 May 2019 15:15:34 -0300
Date:   Mon, 27 May 2019 15:15:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlx5: avoid 64-bit division
Message-ID: <20190527181534.GA10029@ziepe.ca>
References: <20190520111902.7104DE0184@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520111902.7104DE0184@unicorn.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 01:19:02PM +0200, Michal Kubecek wrote:
> Commit 25c13324d03d ("IB/mlx5: Add steering SW ICM device memory type")
> breaks i386 build by introducing three 64-bit divisions. As the divisor
> is MLX5_SW_ICM_BLOCK_SIZE() which is always a power of 2, we can replace
> the division with bit operations.
> 
> Fixes: 25c13324d03d ("IB/mlx5: Add steering SW ICM device memory type")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
>  drivers/infiniband/hw/mlx5/cmd.c  | 9 +++++++--
>  drivers/infiniband/hw/mlx5/main.c | 2 +-
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/mlx5/cmd.c
> index e3ec79b8f7f5..6c8645033102 100644
> +++ b/drivers/infiniband/hw/mlx5/cmd.c
> @@ -190,12 +190,12 @@ int mlx5_cmd_alloc_sw_icm(struct mlx5_dm *dm, int type, u64 length,
>  			  u16 uid, phys_addr_t *addr, u32 *obj_id)
>  {
>  	struct mlx5_core_dev *dev = dm->dev;
> -	u32 num_blocks = DIV_ROUND_UP(length, MLX5_SW_ICM_BLOCK_SIZE(dev));
>  	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {};
>  	u32 in[MLX5_ST_SZ_DW(create_sw_icm_in)] = {};
>  	unsigned long *block_map;
>  	u64 icm_start_addr;
>  	u32 log_icm_size;
> +	u32 num_blocks;
>  	u32 max_blocks;
>  	u64 block_idx;
>  	void *sw_icm;
> @@ -224,6 +224,8 @@ int mlx5_cmd_alloc_sw_icm(struct mlx5_dm *dm, int type, u64 length,
>  		return -EINVAL;
>  	}
>  
> +	num_blocks = (length + MLX5_SW_ICM_BLOCK_SIZE(dev) - 1) >>
> +		     MLX5_LOG_SW_ICM_BLOCK_SIZE(dev);
>  	max_blocks = BIT(log_icm_size - MLX5_LOG_SW_ICM_BLOCK_SIZE(dev));
>  	spin_lock(&dm->lock);
>  	block_idx = bitmap_find_next_zero_area(block_map,
> @@ -266,13 +268,16 @@ int mlx5_cmd_dealloc_sw_icm(struct mlx5_dm *dm, int type, u64 length,
>  			    u16 uid, phys_addr_t addr, u32 obj_id)
>  {
>  	struct mlx5_core_dev *dev = dm->dev;
> -	u32 num_blocks = DIV_ROUND_UP(length, MLX5_SW_ICM_BLOCK_SIZE(dev));
>  	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {};
>  	u32 in[MLX5_ST_SZ_DW(general_obj_in_cmd_hdr)] = {};
>  	unsigned long *block_map;
> +	u32 num_blocks;
>  	u64 start_idx;
>  	int err;
>  
> +	num_blocks = (length + MLX5_SW_ICM_BLOCK_SIZE(dev) - 1) >>
> +		     MLX5_LOG_SW_ICM_BLOCK_SIZE(dev);
> +
>  	switch (type) {
>  	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
>  		start_idx =
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index abac70ad5c7c..340290b883fe 100644
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -2344,7 +2344,7 @@ static int handle_alloc_dm_sw_icm(struct ib_ucontext *ctx,
>  	/* Allocation size must a multiple of the basic block size
>  	 * and a power of 2.
>  	 */
> -	act_size = roundup(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
> +	act_size = round_up(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
>  	act_size = roundup_pow_of_two(act_size);

It is kind of weird that we have round_up and the bitshift
version.. None of this is performance critical so why not just use
round_up everywhere?

Ariel, it is true MLX5_SW_ICM_BLOCK_SIZE will always be a power of
two?

Jason
