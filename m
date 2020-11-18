Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC882B7DC4
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 13:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKRMqD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 07:46:03 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:18506 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKRMqD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Nov 2020 07:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605703563; x=1637239563;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=l30GIg8dXwzeQoqMoj5Z2NzIJFdrV4R5CMkEEckh6sU=;
  b=jbarLmp6U9IVADqyDdj4DPiG/ZF+cOZBuwV6o3ZN7VFHgEHDdvBSR+N9
   tLjAXROBbG4Yea1/aJYQiDfLxmLGVwEA6lz9XKn3L3FIBpTJuMFF6mIc9
   4QAMPSvpAerSYvrGTYWR0Tx/pdSXqdHWoYqVBqpabUjnWf6nvJopeYwHM
   8=;
X-IronPort-AV: E=Sophos;i="5.77,486,1596499200"; 
   d="scan'208";a="96605231"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 18 Nov 2020 12:45:51 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com (Postfix) with ESMTPS id E05D3BF9B7;
        Wed, 18 Nov 2020 12:45:49 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.59) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Nov 2020 12:45:47 +0000
Subject: Re: [PATCH 4/9] efa: Move the context intialization out of
 efa_query_device_ex()
To:     Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
References: <4-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <3ef1c929-5a36-9d55-091c-2a983c450f38@amazon.com>
Date:   Wed, 18 Nov 2020 14:45:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <4-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.59]
X-ClientProxiedBy: EX13d09UWC002.ant.amazon.com (10.43.162.102) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 16/11/2020 22:23, Jason Gunthorpe wrote:
> When the user calls efa_query_device_ex() it should not cause the context
> values to be mutated, only the attribute shuld be returned.
> 
> Move this code to a dedicated function that is only called during context
> setup.
> 
> Cc: Gal Pressman <galpress@amazon.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  providers/efa/efa.c   | 14 +------------
>  providers/efa/verbs.c | 46 +++++++++++++++++++++++++++++++++++--------
>  providers/efa/verbs.h |  1 +
>  3 files changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/providers/efa/efa.c b/providers/efa/efa.c
> index 35f9b246a711ec..b24c14f7fa1fe1 100644
> --- a/providers/efa/efa.c
> +++ b/providers/efa/efa.c
> @@ -54,10 +54,7 @@ static struct verbs_context *efa_alloc_context(struct ibv_device *vdev,
>  {
>  	struct efa_alloc_ucontext_resp resp = {};
>  	struct efa_alloc_ucontext cmd = {};
> -	struct ibv_device_attr_ex attr;
> -	unsigned int qp_table_sz;
>  	struct efa_context *ctx;
> -	int err;
>  
>  	cmd.comp_mask |= EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH;
>  	cmd.comp_mask |= EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR;
> @@ -86,17 +83,8 @@ static struct verbs_context *efa_alloc_context(struct ibv_device *vdev,
>  
>  	verbs_set_ops(&ctx->ibvctx, &efa_ctx_ops);
>  
> -	err = efa_query_device_ex(&ctx->ibvctx.context, NULL, &attr,
> -				  sizeof(attr));
> -	if (err)
> +	if (!efa_query_device_ctx(ctx))

Remove the not.

>  		goto err_free_spinlock;
> -
> -	qp_table_sz = roundup_pow_of_two(attr.orig_attr.max_qp);
> -	ctx->qp_table_sz_m1 = qp_table_sz - 1;
> -	ctx->qp_table = calloc(qp_table_sz, sizeof(*ctx->qp_table));
> -	if (!ctx->qp_table)
> -		goto err_free_spinlock;
> -
>  	return &ctx->ibvctx;
>  
>  err_free_spinlock:
> diff --git a/providers/efa/verbs.c b/providers/efa/verbs.c
> index 1a9633155c62f8..52d6285f1f409c 100644
> --- a/providers/efa/verbs.c
> +++ b/providers/efa/verbs.c
> @@ -106,14 +106,6 @@ int efa_query_device_ex(struct ibv_context *context,
>  	if (err)
>  		return err;
>  
> -	ctx->device_caps = resp.device_caps;
> -	ctx->max_sq_wr = resp.max_sq_wr;
> -	ctx->max_rq_wr = resp.max_rq_wr;
> -	ctx->max_sq_sge = resp.max_sq_sge;
> -	ctx->max_rq_sge = resp.max_rq_sge;
> -	ctx->max_rdma_size = resp.max_rdma_size;
> -	ctx->max_wr_rdma_sge = a->max_sge_rd;
> -
>  	a->max_qp_wr = min_t(int, a->max_qp_wr,
>  			     ctx->max_llq_size / sizeof(struct efa_io_tx_wqe));
>  	snprintf(a->fw_ver, sizeof(a->fw_ver), "%u.%u.%u.%u",
> @@ -122,6 +114,44 @@ int efa_query_device_ex(struct ibv_context *context,
>  	return 0;
>  }
>  
> +int efa_query_device_ctx(struct efa_context *ctx)
> +{
> +	struct ibv_device_attr_ex attr;
> +	struct efa_query_device_ex_resp resp;

Preferably I would put this first.

> +	size_t resp_size = sizeof(resp);
> +	unsigned int qp_table_sz;
> +	int err;
> +
> +	if (ctx->cmds_supp_udata_mask & EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE) {
> +		err = ibv_cmd_query_device_any(&ctx->ibvctx.context, NULL,
> +					       &attr, sizeof(attr),
> +					       &resp.ibv_resp, &resp_size);
> +		if (err)
> +			return err;
> +
> +		ctx->device_caps = resp.device_caps;
> +		ctx->max_sq_wr = resp.max_sq_wr;
> +		ctx->max_rq_wr = resp.max_rq_wr;
> +		ctx->max_sq_sge = resp.max_sq_sge;
> +		ctx->max_rq_sge = resp.max_rq_sge;
> +		ctx->max_rdma_size = resp.max_rdma_size;
> +		ctx->max_wr_rdma_sge = attr.orig_attr.max_sge_rd;

max_wr_rdma_sge assignment can be done in the else clause as well.

> +	} else {
> +		err = ibv_cmd_query_device_any(&ctx->ibvctx.context, NULL,
> +					       &attr, sizeof(attr.orig_attr),
> +					       NULL, NULL);
> +		if (err)
> +			return err;
> +	}
> +
> +	qp_table_sz = roundup_pow_of_two(attr.orig_attr.max_qp);
> +	ctx->qp_table_sz_m1 = qp_table_sz - 1;
> +	ctx->qp_table = calloc(qp_table_sz, sizeof(*ctx->qp_table));
> +	if (!ctx->qp_table)
> +		return ENOMEM;
> +	return 0;
> +}
