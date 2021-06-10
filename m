Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39D73A241E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 07:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhFJFw7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 01:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhFJFw7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 01:52:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1298F613E7;
        Thu, 10 Jun 2021 05:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623304263;
        bh=TauykevFmGAk6V4LtTmnPrn5KJC40R+AJCNxBSy4y4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQzxWppoO2dYx7mbE3p9358knIPDIzAMosIw07rrRvw/S6TX9PHI1Fx8Dkqo0ndsK
         T4IWiVz/sFweUoqI12C7t7vmF6dqn+rThlfzP2TS693cl/X1De8kIC2zJ/4lLVnOut
         5gf23J8RFT5TwkgpWdKKHI78AL2oztnx+KMY/TqfGD3t1dBsD8tETyA0nCbqWlSfrg
         zlj265WXU8ABukUzLgrD5C9Difxjt1Zhgf9soylgxJpfIjje3ujwYl/2+juWNmbLvW
         MauCD0CNWPpIgGi5pr3NYAaSeuziJVOLsGr5bJgPdgMvGPLlPtD66RPrmpzyb65ThS
         hqlLfADSWo7+Q==
Date:   Thu, 10 Jun 2021 08:50:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, jgg@mellanox.com, yishaih@mellanox.com,
        maorg@mellanox.com, phaddad@nvidia.com,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-core 2/4] mlx5: Implement
 ibv_query_qp_data_in_order() verb
Message-ID: <YMGoQ2ZmTjSun54y@unreal>
References: <20210609155932.218005-1-yishaih@nvidia.com>
 <20210609155932.218005-3-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609155932.218005-3-yishaih@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 09, 2021 at 06:59:30PM +0300, Yishai Hadas wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Implement the ibv_query_qp_data_in_order() verb by using DEVX to read
> from firmware the 'in_order_data' capability.
> 
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  providers/mlx5/mlx5.c     |  1 +
>  providers/mlx5/mlx5.h     |  3 +++
>  providers/mlx5/mlx5_ifc.h | 39 +++++++++++++++++++++++++++++++--
>  providers/mlx5/verbs.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 96 insertions(+), 2 deletions(-)

<...>

> +int mlx5_query_qp_data_in_order(struct ibv_qp *qp, enum ibv_wr_opcode op,
> +				uint32_t flags)
> +{
> +	uint32_t in_qp[DEVX_ST_SZ_DW(query_qp_in)] = {};
> +	uint32_t out_qp[DEVX_ST_SZ_DW(query_qp_out)] = {};
> +	struct mlx5_context *mctx = to_mctx(qp->context);
> +	struct mlx5_qp *mqp = to_mqp(qp);
> +	int ret;
> +
> +/* Currently this API is only supported for x86 architectures since most
> + * non-x86 platforms are known to be OOO and need to do a per-platform study.
> + */
> +#if !defined(__i386__) && !defined(__x86_64__)
> +	return 0;
> +#endif

Does it compile without warnings/errors on such platforms?
You have "return 0;" in the middle of function, so the right thing to do
it is to write with "#if ..." over function or inside like below, as
long as "#else" exists.

int mlx5_query_qp_data_in_order(struct ibv_qp *qp, enum ibv_wr_opcode op,
				uint32_t flags)
{
#if !defined(__i386__) && !defined(__x86_64__)
	/* Currently this API is only supported for x86 architectures since most
	 * non-x86 platforms are known to be OOO and need to do a per-platform study.
	 */
	 return 0;
#else
.....
#endif

> +
> +	if (flags || !mctx->qp_data_in_order_cap)
> +		return 0;
> +
> +	if (mqp->dc_type == MLX5DV_DCTYPE_DCT)
> +		return query_dct_in_order(qp);
> +
> +	if (qp->state != IBV_QPS_RTS)
> +		return 0;
> +
> +	DEVX_SET(query_qp_in, in_qp, opcode, MLX5_CMD_OP_QUERY_QP);
> +	DEVX_SET(query_qp_in, in_qp, qpn, qp->qp_num);
> +	ret = mlx5dv_devx_qp_query(qp, in_qp, sizeof(in_qp), out_qp,
> +				   sizeof(out_qp));
> +	if (ret)
> +		return 0;
> +
> +	return DEVX_GET(query_qp_out, out_qp, qpc.data_in_order);
> +}
> +

Thanks
