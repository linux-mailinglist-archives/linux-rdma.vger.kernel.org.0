Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B82B1B2B48
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2020 17:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgDUPhr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Apr 2020 11:37:47 -0400
Received: from verein.lst.de ([213.95.11.211]:47419 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgDUPhr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Apr 2020 11:37:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7AF7968C4E; Tue, 21 Apr 2020 17:37:44 +0200 (CEST)
Date:   Tue, 21 Apr 2020 17:37:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
Subject: Re: [PATCH 17/17] nvmet-rdma: Add metadata/T10-PI support
Message-ID: <20200421153744.GG10837@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-19-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327171545.98970-19-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>  /* Assume mpsmin == device_page_size == 4KB */
>  #define NVMET_RDMA_MAX_MDTS			8
> +#define NVMET_RDMA_MAX_MD_MDTS			5

Can you spell out METADATA everywhere?

> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +	/* Data Out / RDMA WRITE */
> +	r->write_cqe.done = nvmet_rdma_write_data_done;
> +#endif
>  	return 0;
>  
>  out_free_rsp:
> @@ -498,6 +507,138 @@ static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
>  	spin_unlock(&queue->rsp_wr_wait_lock);
>  }
>  
> +#ifdef CONFIG_BLK_DEV_INTEGRITY

Any chance we could use IS_ENABLED() instead of all these ifdefs?

> +	/*
> +	 * At the moment we hard code those, but in the future
> +	 * we will take them from cmd.
> +	 */

Same weird comment as on the host side.

> +	struct nvme_command *cmd = req->cmd;
> +	struct blk_integrity *bi = bdev_get_integrity(req->ns->bdev);
> +	u16 control = le16_to_cpu(cmd->rw.control);
> +
> +	WARN_ON(bi == NULL);

No need for this WARN_ON either I think.

> +	port->pi_capable = ndev->device->attrs.device_cap_flags &
> +			IB_DEVICE_INTEGRITY_HANDOVER ? true : false;

No need for the ? :, but then again personally I'd prefer a good old:

	if (ndev->device->attrs.device_cap_flags & IB_DEVICE_INTEGRITY_HANDOVER)
		port->pi_capable = true;

anyway.
