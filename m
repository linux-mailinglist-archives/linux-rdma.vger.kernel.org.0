Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6423746A8D
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jul 2023 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjGDH0v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jul 2023 03:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjGDH0u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jul 2023 03:26:50 -0400
X-Greylist: delayed 352 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 00:26:47 PDT
Received: from out-53.mta0.migadu.com (out-53.mta0.migadu.com [91.218.175.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C78E199
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jul 2023 00:26:46 -0700 (PDT)
Message-ID: <5b57402b-b238-7fe5-c1e7-75937c3c1480@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688455251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k5r+3mhkwJ3ZW5QYTu3esWyhD4POwJCWHMjddEJiN2g=;
        b=WTFQptTKCj40Ml0kXLVsWhzfCp9qRHgL01AK6ThWyUsO07SZOES/Dmg/g06tFwXZEq0NNj
        5qa+hqdUuFHyeQaeoh5vaTfOUXw76LpyBviOWdWVIvGjYdUuyszTjuwL7zq6Vzu0PWfrS7
        Jav8nocmcmoo/fyzHJS35DUMcrg0DGA=
Date:   Tue, 4 Jul 2023 10:20:48 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/efa: Add RDMA write HW statistics counters
To:     Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     sleybo@amazon.com, matua@amazon.com,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Yonatan Nachum <ynachum@amazon.com>
References: <20230703153404.30877-1-mrgolin@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <20230703153404.30877-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03/07/2023 18:34, Michael Margolin wrote:
> Update device API and request RDMA write counters if RDMA write is
> supported by device. Expose newly added counters through ib core
> counters mechanism.
> 
> Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  .../infiniband/hw/efa/efa_admin_cmds_defs.h    | 13 +++++++++++++
>  drivers/infiniband/hw/efa/efa_com_cmd.c        |  8 +++++++-
>  drivers/infiniband/hw/efa/efa_com_cmd.h        | 10 +++++++++-
>  drivers/infiniband/hw/efa/efa_verbs.c          | 18 ++++++++++++++++++
>  4 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> index 4e93ef7f84ee..9c65bd27bae0 100644
> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> @@ -66,6 +66,7 @@ enum efa_admin_get_stats_type {
>  	EFA_ADMIN_GET_STATS_TYPE_BASIC              = 0,
>  	EFA_ADMIN_GET_STATS_TYPE_MESSAGES           = 1,
>  	EFA_ADMIN_GET_STATS_TYPE_RDMA_READ          = 2,
> +	EFA_ADMIN_GET_STATS_TYPE_RDMA_WRITE         = 3,
>  };
>  
>  enum efa_admin_get_stats_scope {
> @@ -570,6 +571,16 @@ struct efa_admin_rdma_read_stats {
>  	u64 read_resp_bytes;
>  };
>  
> +struct efa_admin_rdma_write_stats {
> +	u64 write_wrs;
> +
> +	u64 write_bytes;
> +
> +	u64 write_wr_err;
> +
> +	u64 write_recv_bytes;
> +};
> +
>  struct efa_admin_acq_get_stats_resp {
>  	struct efa_admin_acq_common_desc acq_common_desc;
>  
> @@ -579,6 +590,8 @@ struct efa_admin_acq_get_stats_resp {
>  		struct efa_admin_messages_stats messages_stats;
>  
>  		struct efa_admin_rdma_read_stats rdma_read_stats;
> +
> +		struct efa_admin_rdma_write_stats rdma_write_stats;
>  	} u;
>  };
>  
> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
> index 8f8885e002ba..576811885d59 100644
> --- a/drivers/infiniband/hw/efa/efa_com_cmd.c
> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>  /*
> - * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Copyright 2018-2023 Amazon.com, Inc. or its affiliates. All rights reserved.
>   */
>  
>  #include "efa_com.h"
> @@ -794,6 +794,12 @@ int efa_com_get_stats(struct efa_com_dev *edev,
>  		result->rdma_read_stats.read_wr_err = resp.u.rdma_read_stats.read_wr_err;
>  		result->rdma_read_stats.read_resp_bytes = resp.u.rdma_read_stats.read_resp_bytes;
>  		break;
> +	case EFA_ADMIN_GET_STATS_TYPE_RDMA_WRITE:
> +		result->rdma_write_stats.write_wrs = resp.u.rdma_write_stats.write_wrs;
> +		result->rdma_write_stats.write_bytes = resp.u.rdma_write_stats.write_bytes;
> +		result->rdma_write_stats.write_wr_err = resp.u.rdma_write_stats.write_wr_err;
> +		result->rdma_write_stats.write_recv_bytes = resp.u.rdma_write_stats.write_recv_bytes;
> +		break;
>  	}
>  
>  	return 0;
> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
> index 0898ad5bc340..fc97f37bb39b 100644
> --- a/drivers/infiniband/hw/efa/efa_com_cmd.h
> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>  /*
> - * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Copyright 2018-2023 Amazon.com, Inc. or its affiliates. All rights reserved.
>   */
>  
>  #ifndef _EFA_COM_CMD_H_
> @@ -262,10 +262,18 @@ struct efa_com_rdma_read_stats {
>  	u64 read_resp_bytes;
>  };
>  
> +struct efa_com_rdma_write_stats {
> +	u64 write_wrs;
> +	u64 write_bytes;
> +	u64 write_wr_err;
> +	u64 write_recv_bytes;
> +};
> +
>  union efa_com_get_stats_result {
>  	struct efa_com_basic_stats basic_stats;
>  	struct efa_com_messages_stats messages_stats;
>  	struct efa_com_rdma_read_stats rdma_read_stats;
> +	struct efa_com_rdma_write_stats rdma_write_stats;
>  };
>  
>  int efa_com_create_qp(struct efa_com_dev *edev,
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 2a195c4b0f17..7a27d79c0541 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -61,6 +61,10 @@ struct efa_user_mmap_entry {
>  	op(EFA_RDMA_READ_BYTES, "rdma_read_bytes") \
>  	op(EFA_RDMA_READ_WR_ERR, "rdma_read_wr_err") \
>  	op(EFA_RDMA_READ_RESP_BYTES, "rdma_read_resp_bytes") \
> +	op(EFA_RDMA_WRITE_WRS, "rdma_write_wrs") \
> +	op(EFA_RDMA_WRITE_BYTES, "rdma_write_bytes") \
> +	op(EFA_RDMA_WRITE_WR_ERR, "rdma_write_wr_err") \
> +	op(EFA_RDMA_WRITE_RECV_BYTES, "rdma_write_recv_bytes") \
>  
>  #define EFA_STATS_ENUM(ename, name) ename,
>  #define EFA_STATS_STR(ename, nam) \
> @@ -2080,6 +2084,7 @@ static int efa_fill_port_stats(struct efa_dev *dev, struct rdma_hw_stats *stats,
>  {
>  	struct efa_com_get_stats_params params = {};
>  	union efa_com_get_stats_result result;
> +	struct efa_com_rdma_write_stats *rws;
>  	struct efa_com_rdma_read_stats *rrs;
>  	struct efa_com_messages_stats *ms;
>  	struct efa_com_basic_stats *bs;
> @@ -2121,6 +2126,19 @@ static int efa_fill_port_stats(struct efa_dev *dev, struct rdma_hw_stats *stats,
>  	stats->value[EFA_RDMA_READ_WR_ERR] = rrs->read_wr_err;
>  	stats->value[EFA_RDMA_READ_RESP_BYTES] = rrs->read_resp_bytes;
>  
> +	if (EFA_DEV_CAP(dev, RDMA_WRITE)) {

I wonder if the same check is missing for RDMA_READ? Or is it redundant
for RDMA_WRITE?

Patch looks good,
Reviewed-by: Gal Pressman <gal.pressman@linux.dev>

> +		params.type = EFA_ADMIN_GET_STATS_TYPE_RDMA_WRITE;
> +		err = efa_com_get_stats(&dev->edev, &params, &result);
> +		if (err)
> +			return err;
> +
> +		rws = &result.rdma_write_stats;
> +		stats->value[EFA_RDMA_WRITE_WRS] = rws->write_wrs;
> +		stats->value[EFA_RDMA_WRITE_BYTES] = rws->write_bytes;
> +		stats->value[EFA_RDMA_WRITE_WR_ERR] = rws->write_wr_err;
> +		stats->value[EFA_RDMA_WRITE_RECV_BYTES] = rws->write_recv_bytes;
> +	}
> +
>  	return ARRAY_SIZE(efa_port_stats_descs);
>  }
>  
