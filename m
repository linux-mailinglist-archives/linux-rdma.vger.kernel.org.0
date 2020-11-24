Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDAB2C2173
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 10:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgKXJcE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 04:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgKXJcE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Nov 2020 04:32:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277C9C0613D6
        for <linux-rdma@vger.kernel.org>; Tue, 24 Nov 2020 01:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0K5F7/ZiP054kVMvygqikQzypdat/4zA+V+MGZJ7QUM=; b=L2lebaDGYgDQN9mVMiE7RSMrJS
        FXW1whT6dFiIAsjidpgrhJBBIDsp6Fv3vWAV9fnbNygQ+x0Ll1iWHZqWPnoXK/FaLy1KgpPSNOPI1
        JvVqd+PG/u8Dhoy6j1d/cAhn/fTSeZZirqkCe2O6YkPBoWh9zGaZhEiuKIsdKzUPnBpf8qnQPTvUz
        HvApGjICBIYYpD8U4tTUzBBO6zNWdOBKHiucW9I01OeP1/IQqKuCeFXMcVrV+DOnQk7bygbWC01zg
        V4OB/vdqTF9OTNuQnOYWLxnNdKNgiNAv+pTYxt/Myl52oZufBb3fQwhpRoIpNsTu/WkV0/qJl2SRz
        53q1z7MQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khUfy-00081k-Hh; Tue, 24 Nov 2020 09:31:54 +0000
Date:   Tue, 24 Nov 2020 09:31:54 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] IB/mlx5: Use ib_dma APIs instead of open
 access to parent device
Message-ID: <20201124093154.GA29715@infradead.org>
References: <20201123082400.351371-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123082400.351371-1-leon@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 23, 2020 at 10:24:00AM +0200, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 090e204ef1e1..d24ac339c053 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -42,7 +42,7 @@
>  #include "mlx5_ib.h"
>  
>  /*
> - * We can't use an array for xlt_emergency_page because dma_map_single doesn't
> + * We can't use an array for xlt_emergency_page because ib_dma_map_single doesn't

Please avoid the pointlessly overly long line.

> +		ib_dma_sync_single_for_cpu(&dev->ib_dev, sg.addr, sg.length, DMA_TO_DEVICE);

And here and much more.
