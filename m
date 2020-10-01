Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6D427F8CD
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 07:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgJAFBG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 01:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgJAFBG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Oct 2020 01:01:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2ED20888;
        Thu,  1 Oct 2020 05:01:05 +0000 (UTC)
Date:   Thu, 1 Oct 2020 08:01:01 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blk-next 0/2] Delete the get_vector_affinity leftovers
Message-ID: <20201001050101.GT3094@unreal>
References: <20200929091358.421086-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929091358.421086-1-leon@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 12:13:56PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>
> There are no drivers that implement .get_vector_affinity(), so delete
> the RDMA function and simplify block code.
>
> Thanks
>
> P.S. Probably it should go through block tree.
>
> Leon Romanovsky (2):
>   blk-mq-rdma: Delete not-used multi-queue RDMA map queue code
>   RDMA/core: Delete not-implemented get_vector_affinity

Jens, Keith

How can we progress here?

Thanks

>
>  block/Kconfig                    |  5 ----
>  block/Makefile                   |  1 -
>  block/blk-mq-rdma.c              | 44 --------------------------------
>  drivers/infiniband/core/device.c |  1 -
>  drivers/nvme/host/rdma.c         |  7 ++---
>  include/linux/blk-mq-rdma.h      | 11 --------
>  include/rdma/ib_verbs.h          | 23 -----------------
>  7 files changed, 2 insertions(+), 90 deletions(-)
>  delete mode 100644 block/blk-mq-rdma.c
>  delete mode 100644 include/linux/blk-mq-rdma.h
>
> --
> 2.26.2
>
