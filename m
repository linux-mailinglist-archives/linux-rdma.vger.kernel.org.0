Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE031E13F9
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 20:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbgEYSSr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 14:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbgEYSSq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 14:18:46 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12A6C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 11:18:46 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so14288227qts.9
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SYwN2rJJirqFAiOr/h/3hLTPDs7zwpgDdaevneSwti0=;
        b=GKFXijrQa+XIgaFVZT8sYujwstyZXTJfvPQe3gVYmgRfXLaJ/+oPj2VAFMItxv89tB
         UvO+7c9C0Jdxe5CjvEjhrjInjuSMNBhJpGzOpqnMuSGZBJtyRgZurl72TJjv+Rs8Wyi6
         HcZrjmQpMlmjuiuPTb/b4p3xn9AZzPl0akTPvNbKkB8Nn4pbreo/jAI45akKryBVjOvS
         G5u5B6CT8p4I4DXkrOLb4fB/N/51kG49ADpVD5XkwrJoXWRBVE388t+I7Il8+MSUw9ae
         J3FKDHN2GRmdmr8SsI/bTXucxxRBwJ8rmnOQplVxj19KWzhBcHRxIhldTP3motTzOSdD
         Bb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SYwN2rJJirqFAiOr/h/3hLTPDs7zwpgDdaevneSwti0=;
        b=N+ckKjvu/fUIcxt/j/fTak/nc97g9CQjhkzDTxWHvyq0ESkFwWgQf3ZDnCUE8rEot0
         SMERdSYekZ/5Ido4yPAot2ppp06Qc0ye2rqpK85K3en54EQnk+ZwvW27jfzm4Kv0C9sR
         qL96vq36YjIMpcA4v8jw9T1N6igge8ndvDf1Q/h9vnyXwMUhCXm548Efsad5gIu6NKCt
         UFYm0KFpqqaeNhagfnPLAN+wX1/X7zPHW/teU3akqZIB7z51i2wbsfzPJWDMPBz6Ec65
         3pt8yPrGwv1TJv6XKcEb/BuSoc7oUZLUB4iPExGYXVJ1BZJt3Wit+13isn2R6uGXJGnE
         QvJA==
X-Gm-Message-State: AOAM532xRZNM6isWbx9BjG6+HXcYrjlhFIIJk7BaS32Yw/sMtkgBpWV5
        PWRNfBZuOW6qepprDTCIu0VGeQ==
X-Google-Smtp-Source: ABdhPJyG+0NcBioRGOvanU2y3cGB202PjaQ6dFf7pNYHS9Ug6doyDHA9x7EEJYeXc8GbPjpennpmNQ==
X-Received: by 2002:aed:3242:: with SMTP id y60mr29958929qtd.127.1590430726041;
        Mon, 25 May 2020 11:18:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l184sm15033924qke.115.2020.05.25.11.18.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 11:18:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdHgT-0007CN-7Y; Mon, 25 May 2020 15:18:45 -0300
Date:   Mon, 25 May 2020 15:18:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 7/9] RDMA/mlx5: Advertise ECE support
Message-ID: <20200525181845.GE24366@ziepe.ca>
References: <20200523132243.817936-1-leon@kernel.org>
 <20200523132243.817936-8-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523132243.817936-8-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 23, 2020 at 04:22:41PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The ECE bits are configured through create_qp and modify_qp commands.
> While the create_qp() can be easily extended, it is not an easy task
> for the modify_qp().
> 
> The new bit in the comp_mask is needed to mark that kernel supports
> ECE and can receive data instead of "reserved" field in the
> struct mlx5_ib_modify_qp.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/hw/mlx5/main.c | 3 +++
>  include/uapi/rdma/mlx5-abi.h      | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 6094ab2f4cd7..570c519ca530 100644
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -1971,6 +1971,9 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
>  		resp.response_length += sizeof(resp.dump_fill_mkey);
>  	}
>  
> +	if (MLX5_CAP_GEN(dev->mdev, ece_support))
> +		resp.comp_mask |= MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE;
> +
>  	err = ib_copy_to_udata(udata, &resp, resp.response_length);
>  	if (err)
>  		goto out_mdev;
> diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
> index bc9d9e3cb369..90ea1e5aa291 100644
> +++ b/include/uapi/rdma/mlx5-abi.h
> @@ -100,6 +100,7 @@ struct mlx5_ib_alloc_ucontext_req_v2 {
>  enum mlx5_ib_alloc_ucontext_resp_mask {
>  	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_CORE_CLOCK_OFFSET = 1UL << 0,
>  	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_DUMP_FILL_MKEY    = 1UL << 1,
> +	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE               = 1UL << 2,
>  };

This should be squashed into the patch overriding the reserved field

Jason
