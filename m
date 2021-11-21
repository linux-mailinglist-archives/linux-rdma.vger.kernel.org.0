Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570F14583EA
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Nov 2021 14:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbhKUN6E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Nov 2021 08:58:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234993AbhKUN6E (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Nov 2021 08:58:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5C7D603E8;
        Sun, 21 Nov 2021 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637502899;
        bh=RcfZsnPLw3rO0pzRMpMxv5KHNSIfG8d0yKgbcOFOweY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pbf1oXEoNHcmssqp70xEBLJOTJXQBnEKAx8gL70kRgC0wfOPdhXXWH4ZurF/vNM/5
         6TgMA5jx/YAtwkFZkg3RHYbaEEBN2T5z3AfqS1LQGH9DEjPgX0VrJx4lzG6QQsq+/N
         FzS0/m2C2Z4W2WiW9cY7hnxbAu8aDzm3rIvO++zTpA4sW3OMj31dud1tpZBboGzYSL
         aKiPcZdwmGdepd4gVCQ6ZSLevrTn3F/Nrlh1kAMmQDJHOP8CQEj/UBLGgAXZCsjs76
         YMu0uqUfEq5xjM7pt4lXur0Y9R8qljO9KMDYOOzB8hXTY9NplL5mAgTDRmR4+k+vdP
         +w9DbtLq2ZBlA==
Date:   Sun, 21 Nov 2021 15:54:55 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Use memset_after() to zero struct mlx5_ib_mr
Message-ID: <YZpPr2P11LJNtrIm@unreal>
References: <20211118203138.1287134-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118203138.1287134-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 18, 2021 at 12:31:38PM -0800, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring fields.
> 
> Use memset_after() to zero the end of struct mlx5_ib_mr that should
> be initialized.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index e636e954f6bf..af94c9fe8753 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -665,8 +665,7 @@ struct mlx5_ib_mr {
>  	/* User MR data */
>  	struct mlx5_cache_ent *cache_ent;
>  	struct ib_umem *umem;
> -
> -	/* This is zero'd when the MR is allocated */
> +	/* Everything after umem is zero'd when the MR is allocated */
>  	union {
>  		/* Used only while the MR is in the cache */
>  		struct {
> @@ -718,7 +717,7 @@ struct mlx5_ib_mr {
>  /* Zero the fields in the mr that are variant depending on usage */
>  static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
>  {
> -	memset(mr->out, 0, sizeof(*mr) - offsetof(struct mlx5_ib_mr, out));
> +	memset_after(mr, 0, umem);

I think that it is not equivalent change and you need "memset_after(mr, 0, cache_ent);"
to clear umem pointer too.

>  }
>  
>  static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
> -- 
> 2.30.2
> 
