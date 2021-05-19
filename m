Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83945388A42
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 11:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343713AbhESJMJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 05:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344703AbhESJLF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 05:11:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27634611AE;
        Wed, 19 May 2021 09:09:44 +0000 (UTC)
Date:   Wed, 19 May 2021 12:09:41 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: Re: [PATCH 5/5] RDMA/srp: Make struct scsi_cmnd and struct
 srp_request adjacent
Message-ID: <YKTV1RKf4Ms+Zzx0@unreal>
References: <20210512032752.16611-1-bvanassche@acm.org>
 <20210512032752.16611-6-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512032752.16611-6-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 11, 2021 at 08:27:52PM -0700, Bart Van Assche wrote:
> Define .init_cmd_priv and .exit_cmd_priv callback functions in struct
> scsi_host_template. Set .cmd_size such that the SCSI core allocates
> per-command private data. Use scsi_cmd_priv() to access that private
> data. Remove the req_ring pointer from struct srp_rdma_ch since it is
> no longer necessary. Convert srp_alloc_req_data() and srp_free_req_data()
> into functions that initialize one instance of the SRP-private command
> data. This is a micro-optimization since this patch removes several
> pointer dereferences from the hot path.
> 
> Note: due to commit e73a5e8e8003 ("scsi: core: Only return started requests
> from scsi_host_find_tag()"), it is no longer necessary to protect the
> completion path against duplicate responses.
> 
> Cc: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 156 ++++++++++++----------------
>  drivers/infiniband/ulp/srp/ib_srp.h |   2 -
>  2 files changed, 65 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index 52db42af421b..773ac5929082 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -965,69 +965,55 @@ static void srp_disconnect_target(struct srp_target_port *target)
>  	}
>  }
>  
> -static void srp_free_req_data(struct srp_target_port *target,
> -			      struct srp_rdma_ch *ch)
> +static int srp_exit_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
>  {
> +	struct srp_target_port *target = host_to_target(shost);
>  	struct srp_device *dev = target->srp_host->srp_dev;
>  	struct ib_device *ibdev = dev->dev;
> -	struct srp_request *req;
> -	int i;
> +	struct srp_request *req = scsi_cmd_priv(cmd);
>  
> -	if (!ch->req_ring)
> -		return;
> -
> -	for (i = 0; i < target->req_ring_size; ++i) {
> -		req = &ch->req_ring[i];
> -		if (dev->use_fast_reg)
> -			kfree(req->fr_list);
> -		if (req->indirect_dma_addr) {
> -			ib_dma_unmap_single(ibdev, req->indirect_dma_addr,
> -					    target->indirect_size,
> -					    DMA_TO_DEVICE);
> -		}
> -		kfree(req->indirect_desc);
> +	if (dev->use_fast_reg)
> +		kfree(req->fr_list);

Isn't cleaner will be to ensure that fr_list is NULL for !dev->use_fast_reg path?
In patch #4 https://lore.kernel.org/linux-rdma/20210512032752.16611-5-bvanassche@acm.org

Thanks
