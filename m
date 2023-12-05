Return-Path: <linux-rdma+bounces-266-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D09F804992
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 06:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004421F21529
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 05:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97DCD50C;
	Tue,  5 Dec 2023 05:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sniVjpRX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD76C0
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 21:58:27 -0800 (PST)
Message-ID: <95f41a77-e283-4e86-82e1-4a46c9dfeb30@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701755906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DL3qjRnnr1J0x60ad6AbwIOX+fKEVZW9nzRwjVpt3vc=;
	b=sniVjpRXqnO7Qb50Blf1hSO8pzwvcCCgqRaUiWwWq/F4KLUIm+/hOEZo650a68X3lbtW13
	JgNPkkSTNs5Fa2iuQuFVzfC6U7ser+bYLqIPR6YNaNsQKPkMlhKyAjoFbPqttNYZVje8rV
	b8Y2udO125ZwU94LZEMTDc5TARg2EuI=
Date: Tue, 5 Dec 2023 13:58:23 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v5 7/7] RDMA/rxe: Add module parameters for mcast
 limits
To: Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
 linux-rdma@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org
References: <20231205002613.10219-1-rpearsonhpe@gmail.com>
 <20231205002613.10219-5-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231205002613.10219-5-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add  David S. Miller and  David Ahern.

They are the maintainers in netdev and very familiar with mcast.

Zhu Yanjun

在 2023/12/5 8:26, Bob Pearson 写道:
> Add module parameters for max_mcast_grp, max_mcast_qp_attach,
> and tot_mcast_qp_attach to allow setting these parameters to
> small values when the driver is loaded to support testing these
> limits.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/Makefile    |  3 ++-
>   drivers/infiniband/sw/rxe/rxe.c       |  6 +++---
>   drivers/infiniband/sw/rxe/rxe_param.c | 23 +++++++++++++++++++++++
>   drivers/infiniband/sw/rxe/rxe_param.h |  4 ++++
>   4 files changed, 32 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_param.c
>
> diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
> index 5395a581f4bb..b183924ea01d 100644
> --- a/drivers/infiniband/sw/rxe/Makefile
> +++ b/drivers/infiniband/sw/rxe/Makefile
> @@ -22,4 +22,5 @@ rdma_rxe-y := \
>   	rxe_mcast.o \
>   	rxe_task.o \
>   	rxe_net.o \
> -	rxe_hw_counters.o
> +	rxe_hw_counters.o \
> +	rxe_param.o
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 147cb16e937d..599fbfdeb426 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -59,9 +59,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>   	rxe->attr.max_res_rd_atom		= RXE_MAX_RES_RD_ATOM;
>   	rxe->attr.max_qp_init_rd_atom		= RXE_MAX_QP_INIT_RD_ATOM;
>   	rxe->attr.atomic_cap			= IB_ATOMIC_HCA;
> -	rxe->attr.max_mcast_grp			= RXE_MAX_MCAST_GRP;
> -	rxe->attr.max_mcast_qp_attach		= RXE_MAX_MCAST_QP_ATTACH;
> -	rxe->attr.max_total_mcast_qp_attach	= RXE_MAX_TOT_MCAST_QP_ATTACH;
> +	rxe->attr.max_mcast_grp			= rxe_max_mcast_grp;
> +	rxe->attr.max_mcast_qp_attach		= rxe_max_mcast_qp_attach;
> +	rxe->attr.max_total_mcast_qp_attach	= rxe_max_tot_mcast_qp_attach;
>   	rxe->attr.max_ah			= RXE_MAX_AH;
>   	rxe->attr.max_srq			= RXE_MAX_SRQ;
>   	rxe->attr.max_srq_wr			= RXE_MAX_SRQ_WR;
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.c b/drivers/infiniband/sw/rxe/rxe_param.c
> new file mode 100644
> index 000000000000..27873e7de753
> --- /dev/null
> +++ b/drivers/infiniband/sw/rxe/rxe_param.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2023 Hewlett Packard Enterprise, Inc. All rights reserved.
> + */
> +
> +#include "rxe.h"
> +
> +int rxe_max_mcast_grp = RXE_MAX_MCAST_GRP;
> +module_param_named(max_mcast_grp, rxe_max_mcast_grp, int, 0444);
> +MODULE_PARM_DESC(max_mcast_grp,
> +	"Maximum number of multicast groups per device");
> +
> +int rxe_max_mcast_qp_attach = RXE_MAX_MCAST_QP_ATTACH;
> +module_param_named(max_mcast_qp_attach, rxe_max_mcast_qp_attach,
> +		int, 0444);
> +MODULE_PARM_DESC(max_mcast_qp_attach,
> +	"Maximum number of QPs attached to a multicast group");
> +
> +int rxe_max_tot_mcast_qp_attach = RXE_MAX_TOT_MCAST_QP_ATTACH;
> +module_param_named(max_tot_mcast_qp_attach, rxe_max_tot_mcast_qp_attach,
> +		int, 0444);
> +MODULE_PARM_DESC(max_tot_mcast_qp_attach,
> +	"Maximum total number of QPs attached to multicast groups per device");
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index d2f57ead78ad..d6fe50f5f483 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -125,6 +125,10 @@ enum rxe_device_param {
>   	RXE_VENDOR_ID			= 0XFFFFFF,
>   };
>   
> +extern int rxe_max_mcast_grp;
> +extern int rxe_max_mcast_qp_attach;
> +extern int rxe_max_tot_mcast_qp_attach;
> +
>   /* default/initial rxe port parameters */
>   enum rxe_port_param {
>   	RXE_PORT_GID_TBL_LEN		= 1024,

