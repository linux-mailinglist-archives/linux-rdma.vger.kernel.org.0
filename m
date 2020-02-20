Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72299165B90
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 11:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBTKbm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 05:31:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgBTKbm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Feb 2020 05:31:42 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3293924673;
        Thu, 20 Feb 2020 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582194701;
        bh=gXK4XC3m6BZ9H7GyYIybqa1dnxsd4qWiYA6P3RB8cLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xlwdTsco0QPpbhWdSzWBTHUgfqRfRJwTlcbq85dEBwUT91oIDY9BNfI+ugcI5iNdQ
         T/g2gq2cPZwBguf8k2xtAYMJK6DlDzVY4P0FDaWi86A1R6RbB7HpuAMIuESYrqmkkT
         flG5qo0vKrmiXFdd4P3yarjK1uLIQrXx2KMFN1xE=
Date:   Thu, 20 Feb 2020 12:31:37 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     jgg@mellanox.com, linux-rdma@vger.kernel.org, israelr@mellanox.com,
        logang@deltatee.com
Subject: Re: [PATCH v2 1/2] RDMA/rw: fix error flow during RDMA context
 initialization
Message-ID: <20200220103137.GB209126@unreal>
References: <20200220100819.41860-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220100819.41860-1-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 20, 2020 at 12:08:18PM +0200, Max Gurtovoy wrote:
> In case the SGL was mapped for P2P DMA operation, we must unmap it using
> pci_p2pdma_unmap_sg.
>
> Fixes: 7f73eac3a713 ("PCI/P2PDMA: Introduce pci_p2pdma_unmap_sg()")
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/infiniband/core/rw.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
> index 4fad732f9b3c..69513b484507 100644
> --- a/drivers/infiniband/core/rw.c
> +++ b/drivers/infiniband/core/rw.c
> @@ -273,6 +273,24 @@ static int rdma_rw_init_single_wr(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
>  	return 1;
>  }
>
> +static void rdma_rw_unmap_sg(struct ib_device *dev, struct scatterlist *sg,
> +		u32 sg_cnt, enum dma_data_direction dir)
> +{
> +	if (is_pci_p2pdma_page(sg_page(sg)))
> +		pci_p2pdma_unmap_sg(dev->dma_device, sg, sg_cnt, dir);
> +	else
> +		ib_dma_unmap_sg(dev, sg, sg_cnt, dir);
> +}
> +
> +static int rdma_rw_map_sg(struct ib_device *dev, struct scatterlist *sg,
> +		u32 sg_cnt, enum dma_data_direction dir)
> +{
> +	if (is_pci_p2pdma_page(sg_page(sg)))
> +		return pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
> +	else

This "else" is not needed.

> +		return ib_dma_map_sg(dev, sg, sg_cnt, dir);
> +}> +
>  /**

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
