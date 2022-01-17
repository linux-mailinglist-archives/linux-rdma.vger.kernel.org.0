Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE7D490AF2
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jan 2022 15:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiAQO6R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 09:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiAQO6Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jan 2022 09:58:16 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C06CC061574
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jan 2022 06:58:16 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id f5so2939575qtp.11
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jan 2022 06:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7GAY+Em7jwAGgS9JzP3XYOzt6c+hBt1eI8NQCrnE6Pg=;
        b=LazVKJilXURMOoVRrXNaC9wbae1rwwIVJ7YtSi2tvUZrTTxC/3bIPmLArVgLCupKE8
         xK13/xp5Mw6EC/XXaIARyL06hlc/ncgPoQwSyEZHz25kLhCbVbTHdFbKOGHA457biBsS
         8WrBW6jFaqjT4LsaxzbKc0CiDzwqUIJTdb1+6m/kOilhXySfILMDRl478EZEmlE7tw2b
         PMYRQv4uwogIHVijpLR62NdrDcR3VZZU4/imOxgrWMrjbW6G4KgFoKaZfPh/ali1xQ7P
         YIemR94vylxQtz87G8HpH9BY81v41k9fuaoRCU/xHIW4R3H1QInlztGG+3NPdzdNuzXG
         Kvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7GAY+Em7jwAGgS9JzP3XYOzt6c+hBt1eI8NQCrnE6Pg=;
        b=1BqLJAnBhZ4b2krsuMzYDzCacWGe2XyPWhviOQo9icKFC6eiZdJAPbJxq2Mzwg8H9c
         baxq+DQEonqGEOy0mQLglJ25zcjZ64hFYQ0WO4/fHlKM9y3vv3ZM5AARSaODo4nhq+b8
         CkksMTFm6RcPKytmk/mty2yjIJ0FM0MN9Q1RSRuvczI9uoVDjop0Hk8lyNVKK8N36uyD
         1d3vtBPajFY+qRLDGp90WaGI04e6hsHRpzk/GzkUJKiJF5u7Tdg6C/4/B0xVi+FrModD
         nbAf5mgqN1Qij2Cx0ViDJ8W4cRHTC1Gcg1ysFmO1mh0y3o7VXsOIqSdKNsm/lU3jZ50L
         fTbw==
X-Gm-Message-State: AOAM531rkZ39pxKc4R/zlmzWFtGdVaRiW0IfyIg7zaohzLs+/cpeIRLi
        Y8axolqIUvMOFDqY2m8UHMGKMNYYTyQnNw==
X-Google-Smtp-Source: ABdhPJyfrgCF39gSGmjbtSjiuBEfb6RFvLqPR4qjlxm4YGJI5N05QwrZgJMAaM04ek+9PAqG3v2HgQ==
X-Received: by 2002:ac8:5c08:: with SMTP id i8mr17673296qti.457.1642431495441;
        Mon, 17 Jan 2022 06:58:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id t74sm8469500qke.12.2022.01.17.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 06:58:14 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n9TSY-000MGl-67; Mon, 17 Jan 2022 10:58:14 -0400
Date:   Mon, 17 Jan 2022 10:58:14 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next v2 03/11] RDMA/erdma: Add main include file
Message-ID: <20220117145814.GB8034@ziepe.ca>
References: <20220117084828.80638-1-chengyou@linux.alibaba.com>
 <20220117084828.80638-4-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117084828.80638-4-chengyou@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 17, 2022 at 04:48:20PM +0800, Cheng Xu wrote:
> Add ERDMA driver main header file, defining internal used data structures
> and operations. The defined data structures includes *cmdq*, which is used
> as the communication channel between ERDMA driver and hardware.
> 
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>  drivers/infiniband/hw/erdma/erdma.h | 392 ++++++++++++++++++++++++++++
>  1 file changed, 392 insertions(+)
>  create mode 100644 drivers/infiniband/hw/erdma/erdma.h
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
> new file mode 100644
> index 000000000000..ae9ec98e99d0
> +++ b/drivers/infiniband/hw/erdma/erdma.h
> @@ -0,0 +1,392 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +
> +/* Authors: Cheng Xu <chengyou@linux.alibaba.com> */
> +/*          Kai Shen <kaishen@linux.alibaba.com> */
> +/* Copyright (c) 2020-2022, Alibaba Group. */
> +
> +#ifndef __ERDMA_H__
> +#define __ERDMA_H__
> +
> +#include <linux/bitfield.h>
> +#include <linux/netdevice.h>
> +#include <linux/xarray.h>
> +#include <rdma/ib_verbs.h>
> +
> +#include "erdma_hw.h"
> +
> +#define DRV_MODULE_NAME "erdma"
> +
> +struct erdma_eq {
> +	void *qbuf;
> +	dma_addr_t qbuf_dma_addr;
> +
> +	u32 depth;
> +	u64 __iomem *db_addr;
> +
> +	spinlock_t lock;
> +
> +	u16 ci;
> +	u16 owner;
> +
> +	atomic64_t event_num;
> +	atomic64_t notify_num;
> +
> +	void *db_info;
> +};
> +
> +struct erdma_cmdq_sq {
> +	void *qbuf;
> +	dma_addr_t qbuf_dma_addr;
> +
> +	spinlock_t lock;
> +	u64 __iomem *db_addr;
> +
> +	u16 ci;
> +	u16 pi;
> +
> +	u16 depth;
> +	u16 wqebb_cnt;
> +
> +	void *db_info;

Why are there so many void *'s in these structs?

> +struct erdma_cmdq_cq {
> +	void *db_info;

> +struct erdma_cmdq {
> +	void *dev;

> +struct erdma_irq_info {
> +	void *data;

> +struct erdma_eq_cb {
> +	void *dev;

> +struct erdma_dev {
> +	void *dmadev;
> +	void *drvdata;
> +	/* reference to drvdata->cmdq */
> +	struct erdma_cmdq *cmdq;
> +
> +	void (*release_handler)(void *drvdata);

Why??

> +	int cc_method;
> +	int disable_dwqe;
> +	int dwqe_pages;
> +	int dwqe_entries;

Use proper types, bool unsinged int, etc.


> +#define ERDMA_CMDQ_BUILD_REQ_HDR(hdr, mod, op)\
> +do { \
> +	*(u64 *)(hdr) = FIELD_PREP(ERDMA_CMD_HDR_SUB_MOD_MASK, mod);\
> +	*(u64 *)(hdr) |= FIELD_PREP(ERDMA_CMD_HDR_OPCODE_MASK, op);\
> +} while (0)

Would prefer an inline wrappered in a macro

> +int erdma_post_cmd_wait(struct erdma_cmdq *cmdq, u64 *req, u32 req_size, u64 *resp0, u64 *resp1);
> +void erdma_cmdq_completion_handler(struct erdma_cmdq *cmdq);
> +
> +int erdma_ceqs_init(struct erdma_pci_drvdata *drvdata);
> +void erdma_ceqs_uninit(struct erdma_pci_drvdata *drvdata);
> +
> +int erdma_aeq_init(struct erdma_pci_drvdata *drvdata);
> +void erdma_aeq_destroy(struct erdma_pci_drvdata *drvdata);
> +
> +void erdma_aeq_event_handler(struct erdma_pci_drvdata *drvdata);
> +void erdma_ceq_completion_handler(struct erdma_eq_cb *ceq_cb);

Don't use the word 'drvdata' in a driver if you can avoid it. It
should only be used to describe the pointer stored in the struct
device, and ib devices don't work that way.

Jason
