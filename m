Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715ED47C0BA
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 14:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbhLUN0a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 08:26:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57282 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbhLUN0a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Dec 2021 08:26:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F17F4B816AD
        for <linux-rdma@vger.kernel.org>; Tue, 21 Dec 2021 13:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE82FC36AE9;
        Tue, 21 Dec 2021 13:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640093187;
        bh=1NTet3GFRoecNki34z+Rk6g9z5T8XRnSN3l4IucOCjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHOl1cZM/bYH7/NIJ9TzCLAp0S0unoxfhTe1NlURhiOGTWH2a9/n57OZRSPOpOj3R
         nZGBQOQGVEZ3yE1R+6PRzORyjG13h+poPbkoLe4+ti38RzeOkcFlwLOI17L12SWeH5
         dDD/ZjJ54us9EfPbL+PnR9vjY0ha+e4QcMEegXlAkO2Vd5Y0g47uPd7lDy6P7Ihdum
         9lV1R32dhETGzh9iX1rXmIOoUZethRVQAJj/PuceWRYRtogY9IAHULe+2GJPlHNBb5
         Eq1xuVs+Bg9vkZiO6+5SgFUJO+Fr+a9MUs4WWFnIM8atci+KYx0/k8KBFNe/Rybamb
         Serfeg7zZ5MVA==
Date:   Tue, 21 Dec 2021 15:26:23 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next 09/11] RDMA/erdma: Add the erdma module
Message-ID: <YcHV/+VeD2xxIU3I@unreal>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-10-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221024858.25938-10-chengyou@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 21, 2021 at 10:48:56AM +0800, Cheng Xu wrote:
> Add the main erdma module and debugfs files. The main module provides
> interface to infiniband subsytem, and the debugfs module provides a way
> to allow user can get the core status of the device and set the preferred
> congestion control algorithm.

debugfs is for debug - dump various information.
It is not the right interface to set configuration properties.

> 
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_debug.c | 314 ++++++++++
>  drivers/infiniband/hw/erdma/erdma_debug.h |  18 +
>  drivers/infiniband/hw/erdma/erdma_main.c  | 711 ++++++++++++++++++++++
>  3 files changed, 1043 insertions(+)
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_debug.c
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_debug.h
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_main.c
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma_debug.c b/drivers/infiniband/hw/erdma/erdma_debug.c
> new file mode 100644
> index 000000000000..3cbed4dde0e2
> --- /dev/null
> +++ b/drivers/infiniband/hw/erdma/erdma_debug.c
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Authors: Cheng Xu <chengyou@linux.alibaba.com>
> + *          Kai Shen <kaishen@linux.alibaba.com>
> + * Copyright (c) 2020-2021, Alibaba Group.
> + */
> +#include <linux/errno.h>
> +#include <linux/types.h>
> +#include <linux/list.h>
> +#include <linux/debugfs.h>
> +
> +#include <rdma/iw_cm.h>
> +#include <rdma/ib_verbs.h>
> +#include <rdma/ib_smi.h>
> +#include <rdma/ib_user_verbs.h>
> +
> +#include "erdma.h"
> +#include "erdma_cm.h"
> +#include "erdma_debug.h"
> +#include "erdma_verbs.h"
> +
> +char *cc_method_string[ERDMA_CC_METHODS_NUM] = {
> +	[ERDMA_CC_NEWRENO] = "newreno",
> +	[ERDMA_CC_CUBIC] = "cubic",
> +	[ERDMA_CC_HPCC_RTT] = "hpcc_rtt",
> +	[ERDMA_CC_HPCC_ECN] = "hpcc_ecn",
> +	[ERDMA_CC_HPCC_INT] = "hpcc_int"
> +};
> +
> +static struct dentry *erdma_debugfs;
> +
> +
> +static int erdma_dbgfs_file_open(struct inode *inode, struct file *fp)
> +{
> +	fp->private_data = inode->i_private;
> +	return nonseekable_open(inode, fp);
> +}
> +
> +static ssize_t erdma_show_stats(struct file *fp, char __user *buf, size_t space,
> +			      loff_t *ppos)
> +{
> +	struct erdma_dev *dev = fp->private_data;
> +	char *kbuf = NULL;
> +	int len = 0;
> +
> +	if (*ppos)
> +		goto out;
> +
> +	kbuf = kmalloc(space, GFP_KERNEL);
> +	if (!kbuf)
> +		goto out;
> +
> +	len = snprintf(kbuf, space, "Resource Summary of %s:\n"
> +		"%s: %d\n%s: %d\n%s: %d\n%s: %d\n%s: %d\n%s: %d\n",
> +		dev->ibdev.name,
> +		"ucontext ", atomic_read(&dev->num_ctx),
> +		"pd       ", atomic_read(&dev->num_pd),
> +		"qp       ", atomic_read(&dev->num_qp),
> +		"cq       ", atomic_read(&dev->num_cq),
> +		"mr       ", atomic_read(&dev->num_mr),

Why do you need to duplicate "restrack res ..."?

> +		"cep      ", atomic_read(&dev->num_cep));
> +	if (len > space)
> +		len = space;
> +out:
> +	if (len)
> +		len = simple_read_from_buffer(buf, len, ppos, kbuf, len);
> +
> +	kfree(kbuf);
> +	return len;
> +
> +}
> +

Thanks
