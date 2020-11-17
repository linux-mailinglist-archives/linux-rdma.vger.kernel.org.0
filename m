Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDCB2B6BAD
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 18:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgKQRYq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 12:24:46 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17976 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgKQRYq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Nov 2020 12:24:46 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb407610000>; Tue, 17 Nov 2020 09:24:49 -0800
Received: from [172.27.12.164] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 17:24:43 +0000
Subject: Re: [PATCH 3/9] mlx5: Move context initialization out of
 mlx5_query_device_ex()
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <3-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>,
        "Yishai Hadas" <yishaih@nvidia.com>, <maorg@nvidia.com>
Message-ID: <7f9d950b-329d-17d0-a25f-4e6f5851c26f@nvidia.com>
Date:   Tue, 17 Nov 2020 19:24:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <3-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605633889; bh=1O7eGWv8SpS2ccYZbU8jiQl/xPc6PeLLhIgHgPEOXTA=;
        h=Subject:To:References:From:CC:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=l0Iwnm6gkgK8s/l1mNGOkxqHFYxlo4L0TbzZkeauMoGTZNfUSwtW6NuqC0MDVqpaP
         lG2o8BHvx9iIJh9i69xar1uvFcQlcVKXp9jyAK8e6indS/1z4qKzjTl6ipu3WST9qf
         wkdfurG9Jtf+QKk/qGFVzMa68IHKu+gzQKxRagvaJku2b/B6djyWj2bRQTfix/a/Hg
         S3mR0r0oTsVd4JoOCC6swrFDlmibhH1EeNjpaGzx9uC30S59xDJeVbiBl+BPprndPS
         GhHBgUCl/LAx+5gcxOgWYke5STpaivzMe9L1Z2IgZMksymdKvpLr3AFblGNxfgsTfh
         xWWYfpCPe8BZg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/16/2020 10:23 PM, Jason Gunthorpe wrote:
> When the user calls mlx5_query_device_ex() it should not cause the context
> values to be mutated, only the attribute should be returned.
>
> Move this code to a dedicated function that is only called during context
> setup.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   providers/mlx5/mlx5.c  | 10 +------
>   providers/mlx5/mlx5.h  |  1 +
>   providers/mlx5/verbs.c | 62 ++++++++++++++++++++++++++++--------------
>   3 files changed, 44 insertions(+), 29 deletions(-)
>
> diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
> index 1378acf2e2f3af..06b9a52ebb3019 100644
> --- a/providers/mlx5/mlx5.c
> +++ b/providers/mlx5/mlx5.c
> @@ -1373,7 +1373,6 @@ static int mlx5_set_context(struct mlx5_context *context,
>   {
>   	struct verbs_context *v_ctx = &context->ibv_ctx;
>   	struct ibv_port_attr port_attr = {};
> -	struct ibv_device_attr_ex device_attr = {};
>   	int cmd_fd = v_ctx->context.cmd_fd;
>   	struct mlx5_device *mdev = to_mdev(v_ctx->context.device);
>   	struct ibv_device *ibdev = v_ctx->context.device;
> @@ -1518,14 +1517,7 @@ bf_done:
>   			goto err_free;
>   	}
>   
> -	if (!mlx5_query_device_ex(&v_ctx->context, NULL, &device_attr,
> -				  sizeof(struct ibv_device_attr_ex))) {
> -		context->cached_device_cap_flags =
> -			device_attr.orig_attr.device_cap_flags;
> -		context->atomic_cap = device_attr.orig_attr.atomic_cap;
> -		context->cached_tso_caps = device_attr.tso_caps;
> -		context->max_dm_size = device_attr.max_dm_size;
> -	}
> +	mlx5_query_device_ctx(context);
>   
>   	for (j = 0; j < min(MLX5_MAX_PORTS_NUM, context->num_ports); ++j) {
>   		memset(&port_attr, 0, sizeof(port_attr));
> diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
> index 782d29bf757e0b..72e710b7b5e4aa 100644
> --- a/providers/mlx5/mlx5.h
> +++ b/providers/mlx5/mlx5.h
> @@ -878,6 +878,7 @@ __be32 *mlx5_alloc_dbrec(struct mlx5_context *context, struct ibv_pd *pd,
>   void mlx5_free_db(struct mlx5_context *context, __be32 *db, struct ibv_pd *pd,
>   		  bool custom_alloc);
>   
> +void mlx5_query_device_ctx(struct mlx5_context *mctx);
>   int mlx5_query_device(struct ibv_context *context,
>   		       struct ibv_device_attr *attr);
>   int mlx5_query_device_ex(struct ibv_context *context,
> diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
> index 3622cae1df5017..42c984033d8eaa 100644
> --- a/providers/mlx5/verbs.c
> +++ b/providers/mlx5/verbs.c
> @@ -3450,19 +3450,19 @@ static void get_pci_atomic_caps(struct ibv_context *context,
>   	}
>   }
>   
> -static void get_lag_caps(struct ibv_context *ctx)
> +static void get_lag_caps(struct mlx5_context *mctx)
>   {
>   	uint16_t opmod = MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE |
>   		HCA_CAP_OPMOD_GET_CUR;
>   	uint32_t out[DEVX_ST_SZ_DW(query_hca_cap_out)] = {};
>   	uint32_t in[DEVX_ST_SZ_DW(query_hca_cap_in)] = {};
> -	struct mlx5_context *mctx = to_mctx(ctx);
>   	int ret;
>   
>   	DEVX_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
>   	DEVX_SET(query_hca_cap_in, in, op_mod, opmod);
>   
> -	ret = mlx5dv_devx_general_cmd(ctx, in, sizeof(in), out, sizeof(out));
> +	ret = mlx5dv_devx_general_cmd(&mctx->ibv_ctx.context, in, sizeof(in),
> +				      out, sizeof(out));
>   	if (ret)
>   		return;
>   
> @@ -3512,6 +3512,41 @@ int mlx5_query_device_ex(struct ibv_context *context,
>   	attr->packet_pacing_caps.supported_qpts =
>   		resp.packet_pacing_caps.supported_qpts;
>   
> +	major     = (raw_fw_ver >> 32) & 0xffff;
> +	minor     = (raw_fw_ver >> 16) & 0xffff;
> +	sub_minor = raw_fw_ver & 0xffff;
> +	a = &attr->orig_attr;
> +	snprintf(a->fw_ver, sizeof(a->fw_ver), "%d.%d.%04d",
> +		 major, minor, sub_minor);
> +
> +	if (attr_size >= offsetof(struct ibv_device_attr_ex, pci_atomic_caps) +
> +			sizeof(attr->pci_atomic_caps))
> +		get_pci_atomic_caps(context, attr);
> +
> +	return 0;
> +}
> +
> +void mlx5_query_device_ctx(struct mlx5_context *mctx)
> +{
> +	struct ibv_device_attr_ex device_attr;
> +	struct mlx5_query_device_ex_resp resp;
> +	size_t resp_size = sizeof(resp);
> +
> +	get_lag_caps(mctx);
> +
> +	if (!(mctx->cmds_supp_uhw & MLX5_USER_CMDS_SUPP_UHW_QUERY_DEVICE))
> +		return;
> +
Any reason to not read some applicable context fields (e.g. max_dm_size) 
over uverbs by reducing the resp_size to the ib part ?
> +	if (ibv_cmd_query_device_any(&mctx->ibv_ctx.context, NULL, &device_attr,
> +				     sizeof(device_attr), &resp.ibv_resp,
> +				     &resp_size))
> +		return;
> +
> +	mctx->cached_device_cap_flags = device_attr.orig_attr.device_cap_flags;
> +	mctx->atomic_cap = device_attr.orig_attr.atomic_cap;
> +	mctx->cached_tso_caps = device_attr.tso_caps;

The device_attr.tso_caps is not set over uverbs / cmd_device.c, it comes 
as UHW.
The below should be done instead.

mctx->cached_tso_caps.max_tso = resp.tso_caps.max_tso;
mctx->cached_tso_caps.supported_qpts = resp.tso_caps.supported_qpts;

> +	mctx->max_dm_size = device_attr.max_dm_size;
> +
>   	if (resp.mlx5_ib_support_multi_pkt_send_wqes & MLX5_IB_ALLOW_MPW)
>   		mctx->vendor_cap_flags |= MLX5_VENDOR_CAP_FLAGS_MPW_ALLOWED;
>   
> @@ -3519,7 +3554,8 @@ int mlx5_query_device_ex(struct ibv_context *context,
>   		mctx->vendor_cap_flags |= MLX5_VENDOR_CAP_FLAGS_ENHANCED_MPW;
>   
>   	mctx->cqe_comp_caps.max_num = resp.cqe_comp_caps.max_num;
> -	mctx->cqe_comp_caps.supported_format = resp.cqe_comp_caps.supported_format;
> +	mctx->cqe_comp_caps.supported_format =
> +		resp.cqe_comp_caps.supported_format;
>   	mctx->sw_parsing_caps.sw_parsing_offloads =
>   		resp.sw_parsing_caps.sw_parsing_offloads;
>   	mctx->sw_parsing_caps.supported_qpts =
> @@ -3544,25 +3580,11 @@ int mlx5_query_device_ex(struct ibv_context *context,
>   		mctx->vendor_cap_flags |= MLX5_VENDOR_CAP_FLAGS_CQE_128B_PAD;
>   
>   	if (resp.flags & MLX5_IB_QUERY_DEV_RESP_PACKET_BASED_CREDIT_MODE)
> -		mctx->vendor_cap_flags |= MLX5_VENDOR_CAP_FLAGS_PACKET_BASED_CREDIT_MODE;
> +		mctx->vendor_cap_flags |=
> +			MLX5_VENDOR_CAP_FLAGS_PACKET_BASED_CREDIT_MODE;
>   
>   	if (resp.flags & MLX5_IB_QUERY_DEV_RESP_FLAGS_SCAT2CQE_DCT)
>   		mctx->vendor_cap_flags |= MLX5_VENDOR_CAP_FLAGS_SCAT2CQE_DCT;
> -
> -	major     = (raw_fw_ver >> 32) & 0xffff;
> -	minor     = (raw_fw_ver >> 16) & 0xffff;
> -	sub_minor = raw_fw_ver & 0xffff;
> -	a = &attr->orig_attr;
> -	snprintf(a->fw_ver, sizeof(a->fw_ver), "%d.%d.%04d",
> -		 major, minor, sub_minor);
> -
> -	if (attr_size >= offsetof(struct ibv_device_attr_ex, pci_atomic_caps) +
> -			sizeof(attr->pci_atomic_caps))
> -		get_pci_atomic_caps(context, attr);
> -
> -	get_lag_caps(context);
> -
> -	return 0;
>   }
>   
>   static int rwq_sig_enabled(struct ibv_context *context)


