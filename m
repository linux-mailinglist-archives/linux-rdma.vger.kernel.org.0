Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418E81B2B19
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2020 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgDUPXM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Apr 2020 11:23:12 -0400
Received: from verein.lst.de ([213.95.11.211]:47308 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUPXL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Apr 2020 11:23:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BEEA168C4E; Tue, 21 Apr 2020 17:23:07 +0200 (CEST)
Date:   Tue, 21 Apr 2020 17:23:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
Subject: Re: [PATCH 10/17] nvmet: add metadata characteristics for a
 namespace
Message-ID: <20200421152307.GC10837@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-12-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200327171545.98970-12-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 27, 2020 at 08:15:38PM +0300, Max Gurtovoy wrote:
> From: Israel Rukshin <israelr@mellanox.com>
> 
> Fill those namespace fields from the block device format for adding
> metadata (T10-PI) over fabric support with block devices.
> 
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>  drivers/nvme/target/io-cmd-bdev.c | 22 ++++++++++++++++++++++
>  drivers/nvme/target/nvmet.h       |  3 +++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index ea0e596..bdf611f 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -50,6 +50,9 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
>  int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>  {
>  	int ret;
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +	struct blk_integrity *bi;
> +#endif
>  
>  	ns->bdev = blkdev_get_by_path(ns->device_path,
>  			FMODE_READ | FMODE_WRITE, NULL);
> @@ -64,6 +67,25 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>  	}
>  	ns->size = i_size_read(ns->bdev->bd_inode);
>  	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
> +
> +	ns->md_type = 0;
> +	ns->ms = 0;
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +	bi = bdev_get_integrity(ns->bdev);
> +	if (bi) {
> +		ns->ms = bi->tuple_size;
> +		if (bi->profile == &t10_pi_type1_crc)
> +			ns->md_type = NVME_NS_DPS_PI_TYPE1;
> +		else if (bi->profile == &t10_pi_type3_crc)
> +			ns->md_type = NVME_NS_DPS_PI_TYPE3;
> +		else
> +			/* Unsupported metadata type */
> +			ns->ms = 0;
> +	}
> +
> +	pr_debug("ms %d md_type %d\n", ns->ms, ns->md_type);
> +#endif

Given that bdev_get_integrity is stubbed out and returns NULL
for the !CONFIG_BLK_DEV_INTEGRITY case, can we just skip the ifdef and
let the compiler optimize the dead code away?  I also don't think we
need the pr_debug.

> +	int			md_type;
> +	int			ms;

Can we use more descriptive names?  md_type seems to be what we call
pi_type elsewhere, anѕ ms could be spelled out as metadata_size.
