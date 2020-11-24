Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFFC2C2174
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 10:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgKXJdz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 04:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731004AbgKXJdy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Nov 2020 04:33:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F4C0613D6
        for <linux-rdma@vger.kernel.org>; Tue, 24 Nov 2020 01:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AQMPq3UgFldamSC+aKXS0lVozJQO+s6p1ctNe6vlvlE=; b=WZvhlUntuP50u8vL5yPauBaZ7P
        m9TF8xxDdzCEWDOPnAOY6WmhH6icjk+zd4A5unr3bb3JG/Bic6iuj6hwrHTnf7GragTLml9c9bGEQ
        Y1UGuZjbbpqMjzFUSmyakQ73BLN5OCstVxr1EPxxO+TCfwVL6dbP2WEegMNYJx5Ryf+iOyVDmz2NK
        MtPqeEd45dmIeCvIQBSC+49hwBRmd8L7Um+zXQjdC9BtqxrSBezD71s3aoCuGaAzjXQNjX4YtiPJ0
        vwsxE/817mxZYpUVa4nZJ7E5pqL5ZmiEaY0tfLf/L7hsaXXUEgEka6nTy80fh4MsUXmR6bKfhARz4
        NDDV2SLw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khUhs-00088w-7Q; Tue, 24 Nov 2020 09:33:52 +0000
Date:   Tue, 24 Nov 2020 09:33:52 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v11 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201124093352.GB29715@infradead.org>
References: <1606153919-104513-1-git-send-email-jianxin.xiong@intel.com>
 <1606153919-104513-2-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606153919-104513-2-git-send-email-jianxin.xiong@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As these are mostly trivial wrappers around the EXPORT_SYMBOL_GPL
dmabuf exports please stick to that export style.

> --- /dev/null
> +++ b/drivers/infiniband/core/umem_dmabuf.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/*
> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
> + */
> +
> +#ifndef UMEM_DMABUF_H
> +#define UMEM_DMABUF_H
> +
> +void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
> +
> +#endif /* UMEM_DMABUF_H */

Does this really need a separate header?
