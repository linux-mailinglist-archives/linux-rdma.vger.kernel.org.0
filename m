Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E078B1292F6
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2019 09:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfLWIOQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Dec 2019 03:14:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfLWIOQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Dec 2019 03:14:16 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C719620715;
        Mon, 23 Dec 2019 08:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577088855;
        bh=69bEfNVqv2+4Y+j3HsOHsujrZAikbG5YBwXZhBWLy2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yviDCdGCsQJ7+aTbvdZw00hU9QYmTFlrYsZ0K24MSwTm1GBI2VqILYIShgmkBL0il
         xp6HLcN+oX6ruO8DTgGKehu2xPaVBb6Q1NcUMNEqCsxDo/GZn2tuFbGfEUH3lzlJOa
         ytheN2nkkSSHEktAwQOmFiUw1X1szOO3x3Gsp8iQ=
Date:   Mon, 23 Dec 2019 10:14:12 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: Re: [PATCH v5 22/25] rnbd: server: sysfs interface functions
Message-ID: <20191223081412.GM13335@unreal>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
 <20191220155109.8959-23-jinpuwang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220155109.8959-23-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 20, 2019 at 04:51:06PM +0100, Jack Wang wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
>
> This is the sysfs interface to rnbd mapped devices on server side:
>
>   /sys/devices/virtual/rnbd-server/ctl/devices/<device_name>/
>     |- block_dev
>     |  *** link pointing to the corresponding block device sysfs entry
>     |
>     |- sessions/<session-name>/
>     |  *** sessions directory
>        |
>        |- read_only
>        |  *** is devices mapped as read only
>        |
>        |- mapping_path
>           *** relative device path provided by the client during mapping
>
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv-sysfs.c | 234 ++++++++++++++++++++++++++++
>  1 file changed, 234 insertions(+)
>  create mode 100644 drivers/block/rnbd/rnbd-srv-sysfs.c
>
> diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
> new file mode 100644
> index 000000000000..17258156cdf2
> --- /dev/null
> +++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * InfiniBand Network Block Driver
> + *
> + * Copyright (c) 2014 - 2017 ProfitBricks GmbH. All rights reserved.
> + * Authors: Fabian Holler <mail@fholler.de>
> + *          Jack Wang <jinpu.wang@profitbricks.com>
> + *          Kleber Souza <kleber.souza@profitbricks.com>
> + *          Danil Kipnis <danil.kipnis@profitbricks.com>
> + *          Roman Penyaev <roman.penyaev@profitbricks.com>
> + *          Milind Dumbare <Milind.dumbare@gmail.com>
> + *
> + * Copyright (c) 2017 - 2018 ProfitBricks GmbH. All rights reserved.
> + * Authors: Danil Kipnis <danil.kipnis@profitbricks.com>
> + *          Roman Penyaev <roman.penyaev@profitbricks.com>
> + *
> + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> + * Authors: Roman Penyaev <roman.penyaev@profitbricks.com>
> + *          Jack Wang <jinpu.wang@cloud.ionos.com>
> + *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
> + */
> +
> +/* Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
> + * Authors: Jack Wang <jinpu.wang@cloud.ionos.com>
> + *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
> + *          Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> + *          Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
> + */
> +#undef pr_fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> +
> +#include <uapi/linux/limits.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +#include <linux/stat.h>
> +#include <linux/genhd.h>
> +#include <linux/list.h>
> +#include <linux/moduleparam.h>
> +#include <linux/device.h>
> +
> +#include "rnbd-srv.h"
> +
> +static struct device *rnbd_dev;
> +static struct class *rnbd_dev_class;
> +static struct kobject *rnbd_devs_kobj;
> +
> +static struct kobj_type ktype = {
> +	.sysfs_ops	= &kobj_sysfs_ops,
> +};
> +
> +int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
> +			       struct block_device *bdev,
> +			       const char *dir_name)
> +{
> +	struct kobject *bdev_kobj;
> +	int ret;
> +
> +	ret = kobject_init_and_add(&dev->dev_kobj, &ktype,
> +				   rnbd_devs_kobj, dir_name);
> +	if (ret)
> +		return ret;
> +
> +	ret = kobject_init_and_add(&dev->dev_sessions_kobj,
> +				   &ktype,
> +				   &dev->dev_kobj, "sessions");
> +	if (ret)
> +		goto err;
> +
> +	bdev_kobj = &disk_to_dev(bdev->bd_disk)->kobj;
> +	ret = sysfs_create_link(&dev->dev_kobj, bdev_kobj, "block_dev");
> +	if (ret)
> +		goto err2;
> +
> +	return 0;
> +
> +err2:
> +	kobject_del(&dev->dev_sessions_kobj);
> +	kobject_put(&dev->dev_sessions_kobj);
> +err:
> +	kobject_del(&dev->dev_kobj);
> +	kobject_put(&dev->dev_kobj);

You are using this _del/_put pattern a lot, from what I see
kobject_put() is the only is needed.

Thanks
