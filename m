Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B82B133F
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 01:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgKMAak (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 19:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMAaj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 19:30:39 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A85C0613D1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 16:30:39 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id f93so5574922qtb.10
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 16:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VAUTqaRdYriL9ikCRyVwcZhWWf8pr98Y/t+SUiAJzpQ=;
        b=OFwmO73kjrLq0BTbsquDWMAHhUunDpspnVxYzG0hKspTPGPEwchpFJalE4CVxdq/6N
         hntAyBrWm0lED/RAeNlq5qKcuzUtjaHx3gqLpZ/rY2M785ZpAxxk22r7lseJfmoEC4Kl
         ymj0FWovEzLaSvIjoKjUtXNz1D7X4F0Fno+HVMxg7I5SVvuBmCg5vugsxOJ4Mkc6YGeb
         ENlF+JYCqb5dJvwf9SnTndBID73lQMysH1HblCef8scatZgKoUkI0tHJSMxRlOZlEOSd
         Q/IVryXvSzQxBs3749Ljycf6rRwxNa8djZ/CEljOeYcqw3rAsqrXtB1NDllYBrr3lSoR
         sKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VAUTqaRdYriL9ikCRyVwcZhWWf8pr98Y/t+SUiAJzpQ=;
        b=GrvLFEizB/dZ33VwFG+pry9/yui3I65p7t1H9hGEULz/zDiPLPiTmwdzvKejnk0Qml
         H9AXB4xZiAFGC+13H41pscLcV7kCh7EmmUrWOTuch1trsomd2Az1Hvrin3Me+JeJIo8N
         U508O8tl2A5TFDp9uvL92CSZzEN7MOkJrpQglaPvQ6z1dQ2tVTlHg+lITmAUOAVIJMS5
         IRkvl8qthG8m+5/ZXzIsac+Sqqgw1NwD/X8miaJfuxp26jP8FBIFbw6+MpCORhb4t8jW
         AAwrDG/a/EP1HCI7tD33MC4N6C+ajoyR4/ZUPnJml7nw0no6CgXjWwkmWVihZhAqcq7C
         TT/g==
X-Gm-Message-State: AOAM531qiZ6ZNCiA8ZJkgGbfOqM99dAS310xlhRbhTE59pXUDFnWE7dD
        QpWQmHyIhMD+MyUENkQNzwf41Q==
X-Google-Smtp-Source: ABdhPJyqkJZqj9tYMcUaitD2/SN0Z1DZJXYlAje/elLKwN4YiBqOPqIwise8iROhXPOy1oeUtklPAA==
X-Received: by 2002:ac8:c02:: with SMTP id k2mr1892470qti.189.1605227438686;
        Thu, 12 Nov 2020 16:30:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x24sm1703606qkx.23.2020.11.12.16.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:30:37 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kdMz7-004CTI-A4; Thu, 12 Nov 2020 20:30:37 -0400
Date:   Thu, 12 Nov 2020 20:30:37 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v10 1/6] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201113003037.GY244516@ziepe.ca>
References: <1605044477-51833-1-git-send-email-jianxin.xiong@intel.com>
 <1605044477-51833-2-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605044477-51833-2-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 10, 2020 at 01:41:12PM -0800, Jianxin Xiong wrote:
> +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> +				   unsigned long offset, size_t size,
> +				   int fd, int access,
> +				   const struct dma_buf_attach_ops *ops)
> +{
> +	struct dma_buf *dmabuf;
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +	struct ib_umem *umem;
> +	unsigned long end;
> +	long ret;
> +
> +	if (check_add_overflow(offset, (unsigned long)size, &end))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (unlikely(PAGE_ALIGN(end) < PAGE_SIZE))
> +		return ERR_PTR(-EINVAL);

This is weird, what does it do?

> +
> +	if (unlikely(!ops || !ops->move_notify))
> +		return ERR_PTR(-EINVAL);
> +
> +	umem_dmabuf = kzalloc(sizeof(*umem_dmabuf), GFP_KERNEL);
> +	if (!umem_dmabuf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	umem = &umem_dmabuf->umem;
> +	umem->ibdev = device;
> +	umem->length = size;
> +	umem->address = offset;
> +	umem->writable = ib_access_writable(access);
> +	umem->is_dmabuf = 1;
> +
> +	if (unlikely(!ib_umem_num_pages(umem))) {
> +		ret = -EINVAL;
> +		goto out_free_umem;
> +	}
> +
> +	dmabuf = dma_buf_get(fd);
> +	if (IS_ERR(dmabuf)) {
> +		ret = PTR_ERR(dmabuf);
> +		goto out_free_umem;
> +	}
> +
> +	if (dmabuf->size < offset + size) {
> +		ret = -EINVAL;
> +		goto out_release_dmabuf;

offset + size == end, already computed, in fact move this above the
kzalloc

Jason
