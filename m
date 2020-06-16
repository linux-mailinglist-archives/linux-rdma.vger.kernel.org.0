Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D561FAAC7
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 10:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgFPIJ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 04:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgFPIJ5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 04:09:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E7F20767;
        Tue, 16 Jun 2020 08:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592294996;
        bh=BZq6ea7RHR3r2HxQbmC2AeB2CeCsedrMeTKLuZcw7mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XtQK69m68XI+FmD1x+qVpMqJKOnwyeYMNSq6HTGs00XA5NZPAr1fexeprBuJ2O9He
         D7Kl/+jjPNvcwsbzNxew+3JDP90C8W0GNf2qU2uXhUP+pT9y1+1RnkM6By3YirtDH+
         S8qVT7q9QO/plY5U3fcR6v+XjRxgWn4KWMrURl1I=
Date:   Tue, 16 Jun 2020 09:30:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Move provider specific attributes to
 ucontext allocation response
Message-ID: <20200616063045.GC2141420@unreal>
References: <20200615075920.58936-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615075920.58936-1-galpress@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 15, 2020 at 10:59:20AM +0300, Gal Pressman wrote:
> Provider specific attributes which are necessary for the userspace
> functionality should be part of the alloc ucontext response, not query
> device. This way a userspace provider could work without issuing a query
> device verb call. However, the fields will remain in the query device
> ABI in order to maintain backwards compatibility.

I don't really understand why "should be ..."? Device properties exposed
here are per-device and will be equal to all ucontexts, so instead of
doing one very fast system call, you are "punishing" every ucontext
call.

What is wrong with calling one query_device before allocating any
ucontext? What are you trying to achieve and what will it give?

Thanks

>
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/775
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 10 ++++++++++
>  include/uapi/rdma/efa-abi.h           | 23 ++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 08313f7c73bc..519cc959acfe 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -1520,11 +1520,21 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
>
>  	ucontext->uarn = result.uarn;
>
> +	resp.comp_mask |= EFA_ALLOC_UCONTEXT_RESP_DEV_ATTR;
>  	resp.cmds_supp_udata_mask |= EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE;
>  	resp.cmds_supp_udata_mask |= EFA_USER_CMDS_SUPP_UDATA_CREATE_AH;
>  	resp.sub_cqs_per_cq = dev->dev_attr.sub_cqs_per_cq;
>  	resp.inline_buf_size = dev->dev_attr.inline_buf_size;
>  	resp.max_llq_size = dev->dev_attr.max_llq_size;
> +	resp.max_sq_sge = dev->dev_attr.max_sq_sge;
> +	resp.max_rq_sge = dev->dev_attr.max_rq_sge;
> +	resp.max_sq_wr = dev->dev_attr.max_sq_depth;
> +	resp.max_rq_wr = dev->dev_attr.max_rq_depth;
> +	resp.max_rdma_size = dev->dev_attr.max_rdma_size;
> +	resp.max_wr_rdma_sge = dev->dev_attr.max_wr_rdma_sge;
> +
> +	if (is_rdma_read_cap(dev))
> +		resp.device_caps |= EFA_ALLOC_UCONTEXT_DEVICE_CAPS_RDMA_READ;
>
>  	if (udata && udata->outlen) {
>  		err = ib_copy_to_udata(udata, &resp,
> diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
> index 53b6e2036a9b..12df5c1659b6 100644
> --- a/include/uapi/rdma/efa-abi.h
> +++ b/include/uapi/rdma/efa-abi.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
>  /*
> - * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
>   */
>
>  #ifndef EFA_ABI_USER_H
> @@ -20,6 +20,14 @@
>   * hex bit offset of the field.
>   */
>
> +enum {
> +	EFA_ALLOC_UCONTEXT_RESP_DEV_ATTR = 1 << 0,
> +};
> +
> +enum {
> +	EFA_ALLOC_UCONTEXT_DEVICE_CAPS_RDMA_READ = 1 << 0,
> +};
> +
>  enum efa_ibv_user_cmds_supp_udata {
>  	EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE = 1 << 0,
>  	EFA_USER_CMDS_SUPP_UDATA_CREATE_AH    = 1 << 1,
> @@ -31,6 +39,14 @@ struct efa_ibv_alloc_ucontext_resp {
>  	__u16 sub_cqs_per_cq;
>  	__u16 inline_buf_size;
>  	__u32 max_llq_size; /* bytes */
> +	__u32 max_sq_wr;
> +	__u32 max_rq_wr;
> +	__u16 max_sq_sge;
> +	__u16 max_rq_sge;
> +	__u32 max_rdma_size;
> +	__u32 device_caps;
> +	__u16 max_wr_rdma_sge;
> +	__u8 reserved_130[2];
>  };
>
>  struct efa_ibv_alloc_pd_resp {
> @@ -96,6 +112,11 @@ enum {
>
>  struct efa_ibv_ex_query_device_resp {
>  	__u32 comp_mask;
> +	/*
> +	 * Attributes which are required for userspace provider functionality
> +	 * should be in alloc ucontext response, the following fields have been
> +	 * moved.
> +	 */
>  	__u32 max_sq_wr;
>  	__u32 max_rq_wr;
>  	__u16 max_sq_sge;
>
> base-commit: fba97dc7fc76b2c9a909fa0b3786d30a9899f5cf
> --
> 2.27.0
>
