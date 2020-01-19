Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26EF9141E9C
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2020 15:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgASOsl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Jan 2020 09:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgASOsl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Jan 2020 09:48:41 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E632620684;
        Sun, 19 Jan 2020 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579445320;
        bh=h0OccMla/A1fPRNcbM4J8EJeEen0km861giS0yVbNuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rHOkWOtNoq5tbL4H5TExYk084il/0c0utd3VT6ksbXowsGxLmpwKShrGhhoDNMMSZ
         JfxTPNz2hGgpIk42pjtPEF+bnjKouRC58siY4z8GfF6VSGr+UsvSAef3AlGyEixDMB
         f73x9BwdkjTbCn/N5qorfPt4RYbFMXhQuJywaZRk=
Date:   Sun, 19 Jan 2020 16:48:37 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: Re: [PATCH v7 04/25] RDMA/rtrs: core: lib functions shared between
 client and server modules
Message-ID: <20200119144837.GE51881@unreal>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
 <20200116125915.14815-5-jinpuwang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116125915.14815-5-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 01:58:54PM +0100, Jack Wang wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
>
> This is a set of library functions existing as a rtrs-core module,
> used by client and server modules.
>
> Mainly these functions wrap IB and RDMA calls and provide a bit higher
> abstraction for implementing of RTRS protocol on client or server
> sides.
>
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs.c | 597 +++++++++++++++++++++++++++++
>  1 file changed, 597 insertions(+)
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.c
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> new file mode 100644
> index 000000000000..7b84d76e2a67
> --- /dev/null
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -0,0 +1,597 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * RDMA Transport Layer
> + *
> + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> + *
> + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> + *
> + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> + */
> +#undef pr_fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/inet.h>
> +
> +#include "rtrs-pri.h"
> +#include "rtrs-log.h"
> +
> +MODULE_DESCRIPTION("RDMA Transport Core");
> +MODULE_LICENSE("GPL");
> +
> +struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
> +			      struct ib_device *dma_dev,
> +			      enum dma_data_direction dir,
> +			      void (*done)(struct ib_cq *cq, struct ib_wc *wc))
> +{
> +	struct rtrs_iu *ius, *iu;
> +	int i;
> +
> +	WARN_ON(!queue_size);
> +	ius = kcalloc(queue_size, sizeof(*ius), gfp_mask);
> +	if (unlikely(!ius))
> +		return NULL;

Let's do not add useless WARN_ON() and unlikely to every error path.

> +	for (i = 0; i < queue_size; i++) {
> +		iu = &ius[i];
> +		iu->buf = kzalloc(size, gfp_mask);
> +		if (unlikely(!iu->buf))
> +			goto err;
> +
> +		iu->dma_addr = ib_dma_map_single(dma_dev, iu->buf, size, dir);
> +		if (unlikely(ib_dma_mapping_error(dma_dev, iu->dma_addr)))
> +			goto err;
> +
> +		iu->cqe.done  = done;
> +		iu->size      = size;
> +		iu->direction = dir;
> +	}
> +	return ius;
> +err:
> +	rtrs_iu_free(ius, dir, dma_dev, i);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(rtrs_iu_alloc);
> +
> +void rtrs_iu_free(struct rtrs_iu *ius, enum dma_data_direction dir,
> +		   struct ib_device *ibdev, u32 queue_size)
> +{
> +	struct rtrs_iu *iu;
> +	int i;
> +
> +	if (!ius)
> +		return;
> +
> +	for (i = 0; i < queue_size; i++) {
> +		iu = &ius[i];
> +		ib_dma_unmap_single(ibdev, iu->dma_addr, iu->size, dir);
> +		kfree(iu->buf);
> +	}
> +	kfree(ius);
> +}
> +EXPORT_SYMBOL_GPL(rtrs_iu_free);
> +
> +int rtrs_iu_post_recv(struct rtrs_con *con, struct rtrs_iu *iu)
> +{
> +	struct rtrs_sess *sess = con->sess;
> +	struct ib_recv_wr wr;
> +	struct ib_sge list;
> +
> +	list.addr   = iu->dma_addr;
> +	list.length = iu->size;
> +	list.lkey   = sess->dev->ib_pd->local_dma_lkey;
> +
> +	if (WARN_ON(list.length == 0)) {
> +		rtrs_wrn(con->sess,
> +			  "Posting receive work request failed, sg list is empty\n");

Both WARN_ON and warning message?

Thanks
