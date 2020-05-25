Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C139E1E13F3
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388754AbgEYSRj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 14:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbgEYSRj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 14:17:39 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E15C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 11:17:39 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b27so8190136qka.4
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GxFVJ7I6trA86Xnz8mk0PoPwonMAqicD1NV/Uaskook=;
        b=np3uCR2D4lSpt7CC8KfA0bg55VV8Yl7hHmLYV4Jore4TgSNe6wujMWRyk8sfbID2Vt
         4PqrgLWxwqJVov58UUPz+/m0/oKegEr2i9T5C9r2TQqjJtFYuwqhCGqmuEbCkXs3Zbmh
         SSfpydkcQE1z599zkXI0YjUC8LY8oYdoHJ8mMTVKkc2I3QZiL175dw44GURQbUM4pSWz
         FKK3tCbFb8cX36Y+U2nM8Br/PvCsIndb+C9JAuhVBgSKaXxYLOinVx4AvEbsz28jcrqI
         FjF5URYeuXUuVDTvNpGD2NnA1v6Ob67Dhj/aX9Ek1HdDhxRc1Opq2bYbF0YPw8C3cvuD
         4TGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GxFVJ7I6trA86Xnz8mk0PoPwonMAqicD1NV/Uaskook=;
        b=AfADWN+fKb440dB/zKd2+8Z9ve7l0SsvARRaudMOIzcy3eNN/IvvenQWyS9tFj1pMA
         5nAUl1RBEQ/FPl7MBVJfN/YGBLFVWd2TE0zQZ7aNs+raSpLhxTdw20orZMhhwzke8JGH
         Y/2uEeRGi4iggxhPOw4vp8kcu+W2x9x4v3fKZZeJtjdlcdq/yRpHNQB3HQOogfE2Ndhg
         2DjxQxgbhiRqrughSXJeuZ6CCKuDZthRrrtBfPV2IzN7ywF73KUyzt22W2yN/sQZBcyo
         7zMIAOwKzh3nKWXSe+bF9qukwTIpLVnY8uoG2S14CW8PLfPBR4DKrjUtMli5Lq6T+T5P
         gZWw==
X-Gm-Message-State: AOAM530HJiF+jw/vFo+ULqvVjuww4C/i0dWn8IV35C5kYWg+/WlEtpJr
        WxHwBpiTVBZLm93E+rAtxp6gcQ==
X-Google-Smtp-Source: ABdhPJy2EmBJcmpkAFLvlIiCo7Xn6aR6KeyFKaIDKjceYTPox+dfFngefBXKHPdftm0F0whD85neqw==
X-Received: by 2002:a37:8446:: with SMTP id g67mr15280228qkd.388.1590430658239;
        Mon, 25 May 2020 11:17:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id n206sm14961404qke.20.2020.05.25.11.17.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 11:17:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdHfN-0007Be-Ab; Mon, 25 May 2020 15:17:37 -0300
Date:   Mon, 25 May 2020 15:17:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next v1 2/9] RDMA/mlx5: Get ECE options from FW
 during create QP
Message-ID: <20200525181737.GD24366@ziepe.ca>
References: <20200523132243.817936-1-leon@kernel.org>
 <20200523132243.817936-3-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523132243.817936-3-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 23, 2020 at 04:22:36PM +0300, Leon Romanovsky wrote:
> -int mlx5_core_create_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp,
> -			u32 *in, int inlen)
> +int mlx5_qpc_create_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp,
> +		       u32 *in, int inlen, u32 *out)
>  {
> -	u32 out[MLX5_ST_SZ_DW(create_qp_out)] = {};
>  	u32 din[MLX5_ST_SZ_DW(destroy_qp_in)] = {};
>  	int err;
>  
>  	MLX5_SET(create_qp_in, in, opcode, MLX5_CMD_OP_CREATE_QP);
>  
> -	err = mlx5_cmd_exec(dev->mdev, in, inlen, out, sizeof(out));
> +	err = mlx5_cmd_exec(dev->mdev, in, inlen, out,
> +			    MLX5_ST_SZ_BYTES(create_qp_out));
>  	if (err)
>  		return err;

This hunk is unrelated right? Was missed in that other series?

Jason
