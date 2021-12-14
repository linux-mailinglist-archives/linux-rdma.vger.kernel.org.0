Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD8D473999
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Dec 2021 01:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244479AbhLNAde (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Dec 2021 19:33:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42158 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244480AbhLNAde (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Dec 2021 19:33:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9658EB81619;
        Tue, 14 Dec 2021 00:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9429C34603;
        Tue, 14 Dec 2021 00:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639442011;
        bh=zFNGboipQ1592Lv07PmnoI02FEeo+/VUT+TzrTjhCgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dyAWrLQ9HqcB2okyP/HqJl6QWHJCesEL/7bIHMVaK/KBgFM+AC2JQJGh4767arhDJ
         4avnCtN2gq4yjDvAtpPpBW3fM0Lmr2CnoCDve/VIpI5jQ4HI51w2aLAF7PszCGIM3K
         Ary9sxsaYPwDIofvbaXIbLSJr2P2+Go0nsgAbr3pQXgKabasc3D5AEioB3dAlkEyFq
         4ClQo0xIx/yq+pW45JTTPL+n9pRDmWWsFKPtl345480pfwp2xMUxZTHn2VhC6NpI6y
         qkgIB1OOBbTIP34tD83aqdj3kY/hfNFaQA9tnB2t0AsspuH3WcrlHAw6z4aawbn3l2
         R6cEMNN5h3a1g==
Date:   Mon, 13 Dec 2021 18:39:09 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2] RDMA/mlx5: Use memset_after() to zero struct
 mlx5_ib_mr
Message-ID: <20211214003909.GA74268@embeddedor>
References: <20211207212022.364703-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207212022.364703-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 07, 2021 at 01:20:22PM -0800, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring fields.
> 
> Use memset_after() to zero the end of struct mlx5_ib_mr that should
> be initialized.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
> v2: rebased, umem moved into the union and is expected to be wiped
>     https://lore.kernel.org/lkml/20211207194525.GL6385@nvidia.com
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index 4a7a56ed740b..ded10719b643 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -664,8 +664,8 @@ struct mlx5_ib_mr {
>  
>  	/* User MR data */
>  	struct mlx5_cache_ent *cache_ent;
> +	/* Everything after cache_ent is zero'd when MR allocated */
>  
> -	/* This is zero'd when the MR is allocated */
>  	union {
>  		/* Used only while the MR is in the cache */
>  		struct {
> @@ -718,7 +718,7 @@ struct mlx5_ib_mr {
>  /* Zero the fields in the mr that are variant depending on usage */
>  static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
>  {
> -	memset(mr->out, 0, sizeof(*mr) - offsetof(struct mlx5_ib_mr, out));
> +	memset_after(mr, 0, cache_ent);
>  }
>  
>  static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
> -- 
> 2.30.2
> 
> 
> 
> 
