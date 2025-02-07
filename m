Return-Path: <linux-rdma+bounces-7521-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F574A2C65A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 15:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5DFE16B2D7
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA7238D38;
	Fri,  7 Feb 2025 14:59:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F0C238D2E;
	Fri,  7 Feb 2025 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738940371; cv=none; b=EUIPsXuSFslWgohLZ/K1LxDiP5yGqhlXULy/csD2e7vCvqnvHV6C9m9aHlBMv5rPXKxDz0kfjNAaGZe5jNyyxvbZ9bC7WyISEoYmRqpsDxQd7wrGwKB1woNXg0Qd2oD7qs/XFDGD/g3ax6LNFbgwTMv2MZsN9broXxBFS99bh3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738940371; c=relaxed/simple;
	bh=rmZr9HCPCElSz0+WiHiZD0EiNZtU+Ri5hWC5RXhinyI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RS8cYxeOYeUM4blMbittfIXy04ktwy7NqQhM9ByjWX93OyzzQG3ZbZTKiqzUY2+BEHtrS3cfvWtBk59j146D4kp0TACPMX+PfRy5uuE06xmkyJKcsFrRhfyPcUg6w+qepMJZPbQAP36L6lYGv0yMevNPIdYwgmhaA4T4jCnYZKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqH9j0Ns3z6L4yw;
	Fri,  7 Feb 2025 22:56:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 132471402A5;
	Fri,  7 Feb 2025 22:59:26 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Feb
 2025 15:59:25 +0100
Date: Fri, 7 Feb 2025 14:59:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Daniel
 Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, David
 Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>, Christoph
 Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Leonid Bloch
	<lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Nelson,
 Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 09/10] fwctl/bnxt: Support communicating with bnxt fw
Message-ID: <20250207145923.0000335e@huawei.com>
In-Reply-To: <9-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<9-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  6 Feb 2025 20:13:31 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> From: Andy Gospodarek <gospo@broadcom.com>
> 
> This patch adds basic support for the fwctl infrastructure.  With the
> approriate tool, the most basic RPC to the bnxt_en firmware can be
> called.
> 
> Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
As commented on below, this one should perhaps have been marked
RFC given there are a bunch of FIXME inline.


> diff --git a/drivers/fwctl/bnxt/bnxt.c b/drivers/fwctl/bnxt/bnxt.c
> new file mode 100644
> index 00000000000000..d2b9a64a1402bf
> --- /dev/null
> +++ b/drivers/fwctl/bnxt/bnxt.c
> @@ -0,0 +1,167 @@

> +
> +/*
> + * bnxt_fw_msg->msg has the whole command
> + * the start of message is of type struct input
> + * struct input {
> + *         __le16  req_type;
> + *         __le16  cmpl_ring;
> + *         __le16  seq_id;
> + *         __le16  target_id;
> + *         __le64  resp_addr;
> + * };
> + * so the hwrm op should be (struct input *)(hwrm_in->msg)->req_type
> + */
> +static bool bnxtctl_validate_rpc(struct fwctl_uctx *uctx,
> +				 struct bnxt_fw_msg *hwrm_in)
> +{
> +	struct input *req = (struct input *)hwrm_in->msg;

hwrm_in->msg is void * so should be no need to cast here.

> +
> +	switch (req->req_type) {
> +	case HWRM_VER_GET:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static void *bnxtctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> +			    void *in, size_t in_len, size_t *out_len)
> +{
> +	struct bnxtctl_dev *bnxtctl =
> +		container_of(uctx->fwctl, struct bnxtctl_dev, fwctl);
> +	struct bnxt_aux_priv *bnxt_aux_priv = bnxtctl->aux_priv;
> +	/* FIXME: Check me */

With the various FIXME in here I'm guessing this is an RFC for now?
Maybe better to make that clear in the patch title.

> +	struct bnxt_fw_msg rpc_in = {
> +		// FIXME: does bnxt_send_msg() copy?
> +		.msg = in,
> +		.msg_len = in_len,
> +		.resp = in,
> +		// FIXME: Dynamic memory for out_len
> +		.resp_max_len = in_len,
> +	};
> +	int rc;
> +
> +	if (!bnxtctl_validate_rpc(uctx, &rpc_in))
> +		return ERR_PTR(-EPERM);
> +
> +	rc = bnxt_send_msg(bnxt_aux_priv->edev, &rpc_in);
> +	if (!rc)
> +		return ERR_PTR(-EOPNOTSUPP);
> +	return in;
> +}

> +
> +static int bnxtctl_probe(struct auxiliary_device *adev,
> +			 const struct auxiliary_device_id *id)
> +{
> +	struct bnxt_aux_priv *aux_priv =
> +		container_of(adev, struct bnxt_aux_priv, aux_dev);
> +	struct bnxtctl_dev *bnxtctl __free(bnxtctl) =
> +		fwctl_alloc_device(&aux_priv->edev->pdev->dev, &bnxtctl_ops,

Does this make more sense than setting parent to the
auxiliary device?  (same applies to the mlx5 driver but I didn't notice
it there).  That will result in a deeper nest in sysfs but
at least makes it obvious what the aux dev is doing.

> +				   struct bnxtctl_dev, fwctl);
> +	int rc;
> +
> +	if (!bnxtctl)
> +		return -ENOMEM;
> +
> +	bnxtctl->aux_priv = aux_priv;
> +
> +	rc = fwctl_register(&bnxtctl->fwctl);
> +	if (rc)
> +		return rc;
> +
> +	auxiliary_set_drvdata(adev, no_free_ptr(bnxtctl));
> +	return 0;
> +}

> +static const struct auxiliary_device_id bnxtctl_id_table[] = {
> +	{ .name = "bnxt_en.fwctl", },
> +	{},

Trivial but no need for that trailing comma given this will always
be the last entry.

> +};
> +MODULE_DEVICE_TABLE(auxiliary, bnxtctl_id_table);
> +
> +static struct auxiliary_driver bnxtctl_driver = {
> +	.name = "bnxt_fwctl",
> +	.probe = bnxtctl_probe,
> +	.remove = bnxtctl_remove,
> +	.id_table = bnxtctl_id_table,
> +};
> +
> +module_auxiliary_driver(bnxtctl_driver);

> diff --git a/include/uapi/fwctl/bnxt.h b/include/uapi/fwctl/bnxt.h
> new file mode 100644
> index 00000000000000..ea47fdbbf6ea3e
> --- /dev/null
> +++ b/include/uapi/fwctl/bnxt.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2024, Broadcom Corporation
> + *
> + */
> +#ifndef _UAPI_FWCTL_BNXT_H_
> +#define _UAPI_FWCTL_BNXT_H_
> +
> +#include <linux/types.h>
> +
> +enum fwctl_bnxt_commands {
> +	FWCTL_BNXT_QUERY_COMMANDS = 0,
> +	FWCTL_BNXT_SEND_COMMAND,
> +};
> +
> +/**
> + * struct fwctl_info_bnxt - ioctl(FWCTL_INFO) out_device_data
> + * @uctx_caps: The command capabilities driver accepts.

Silly though it may be, if the kernel-doc script runs on this I'm fairly
sure it will moan about lack of docs for reserved.

> + *
> + * Return basic information about the FW interface available.
> + */
> +struct fwctl_info_bnxt {
> +	__u32 uctx_caps;
> +	__u32 reserved;
> +};
> +
> +#endif



