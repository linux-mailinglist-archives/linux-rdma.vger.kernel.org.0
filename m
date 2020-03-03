Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169FE17755B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 12:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgCCLhp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 06:37:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgCCLhp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Mar 2020 06:37:45 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 367A120863;
        Tue,  3 Mar 2020 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583235463;
        bh=IQfQs+U4R2AUDHr0QD+4tghuuZvcz5ltuLZhtRS4o1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FjsbzxoNq9vr1BFLKO/1vSUcvIfqPS2t0mPRVv/IBaDOSqg5mzyov705kExgtwc57
         h0vnWs5e87i74L1qgjj6NKRPaU0ZAtrBKBRLZMJcs61TiCAxFir+mqWXVG3fgZ0IFW
         kT4mImDxDWWj9z1wjC1daJWBbjJlC1LdfFCOm6cY=
Date:   Tue, 3 Mar 2020 13:37:40 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v9 10/25] RDMA/rtrs: server: main functionality
Message-ID: <20200303113740.GM121803@unreal>
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-11-jinpuwang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221104721.350-11-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 21, 2020 at 11:47:06AM +0100, Jack Wang wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
>
> This is main functionality of rtrs-server module, which accepts
> set of RDMA connections (so called rtrs session), creates/destroys
> sysfs entries associated with rtrs session and notifies upper layer
> (user of RTRS API) about RDMA requests or link events.
>
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2164 ++++++++++++++++++++++++
>  1 file changed, 2164 insertions(+)
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.c
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> new file mode 100644
> index 000000000000..e60ee6dd675d
> --- /dev/null
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -0,0 +1,2164 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * RDMA Transport Layer
> + *
> + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> + */
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/mempool.h>
> +
> +#include "rtrs-srv.h"
> +#include "rtrs-log.h"
> +
> +MODULE_DESCRIPTION("RDMA Transport Server");
> +MODULE_LICENSE("GPL");
> +
> +/* Must be power of 2, see mask from mr->page_size in ib_sg_to_pages() */
> +#define DEFAULT_MAX_CHUNK_SIZE (128 << 10)
> +#define DEFAULT_SESS_QUEUE_DEPTH 512
> +#define MAX_HDR_SIZE PAGE_SIZE
> +#define MAX_SG_COUNT ((MAX_HDR_SIZE - sizeof(struct rtrs_msg_rdma_read)) \
> +		      / sizeof(struct rtrs_sg_desc))
> +
> +/* We guarantee to serve 10 paths at least */
> +#define CHUNK_POOL_SZ 10
> +
> +static struct rtrs_rdma_dev_pd dev_pd;
> +static mempool_t *chunk_pool;
> +struct class *rtrs_dev_class;
> +
> +static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
> +static int __read_mostly sess_queue_depth = DEFAULT_SESS_QUEUE_DEPTH;
> +
> +static bool always_invalidate = true;
> +module_param(always_invalidate, bool, 0444);
> +MODULE_PARM_DESC(always_invalidate,
> +		 "Invalidate memory registration for contiguous memory regions before accessing.");
> +
> +module_param_named(max_chunk_size, max_chunk_size, int, 0444);
> +MODULE_PARM_DESC(max_chunk_size,
> +		 "Max size for each IO request, when change the unit is in byte (default: "
> +		 __stringify(DEFAULT_MAX_CHUNK_SIZE) "KB)");
> +
> +module_param_named(sess_queue_depth, sess_queue_depth, int, 0444);
> +MODULE_PARM_DESC(sess_queue_depth,
> +		 "Number of buffers for pending I/O requests to allocate per session. Maximum: "
> +		 __stringify(MAX_SESS_QUEUE_DEPTH) " (default: "
> +		 __stringify(DEFAULT_SESS_QUEUE_DEPTH) ")");

We don't like module parameters in the RDMA.

> +
> +static char cq_affinity_list[256];
> +static cpumask_t cq_affinity_mask = { CPU_BITS_ALL };
> +
> +static void init_cq_affinity(void)
> +{
> +	sprintf(cq_affinity_list, "0-%d", nr_cpu_ids - 1);
> +}
> +
> +static int cq_affinity_list_set(const char *val, const struct kernel_param *kp)
> +{
> +	int ret = 0, len = strlen(val);
> +	cpumask_var_t new_value;
> +
> +	init_cq_affinity();
> +
> +	if (len >= sizeof(cq_affinity_list))
> +		return -EINVAL;
> +	if (!alloc_cpumask_var(&new_value, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	ret = cpulist_parse(val, new_value);
> +	if (ret) {
> +		pr_err("Can't set cq_affinity_list \"%s\": %d\n", val,
> +		       ret);
> +		goto free_cpumask;
> +	}
> +
> +	strlcpy(cq_affinity_list, val, sizeof(cq_affinity_list));
> +	*strchrnul(cq_affinity_list, '\n') = '\0';
> +	cpumask_copy(&cq_affinity_mask, new_value);
> +
> +	pr_info("cq_affinity_list changed to %*pbl\n",
> +		cpumask_pr_args(&cq_affinity_mask));
> +free_cpumask:
> +	free_cpumask_var(new_value);
> +	return ret;
> +}
> +
> +static struct kparam_string cq_affinity_list_kparam_str = {
> +	.maxlen	= sizeof(cq_affinity_list),
> +	.string	= cq_affinity_list
> +};
> +
> +static const struct kernel_param_ops cq_affinity_list_ops = {
> +	.set	= cq_affinity_list_set,
> +	.get	= param_get_string,
> +};
> +
> +module_param_cb(cq_affinity_list, &cq_affinity_list_ops,
> +		&cq_affinity_list_kparam_str, 0644);
> +MODULE_PARM_DESC(cq_affinity_list,
> +		 "Sets the list of cpus to use as cq vectors. (default: use all possible CPUs)");

I don't think that you should mess with device affinity assignment.
Why don't you use ib_get_vector_affinity()?

Thanks
