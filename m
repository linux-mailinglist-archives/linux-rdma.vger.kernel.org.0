Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E51B3892B6
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 17:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354940AbhESPeH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 11:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354936AbhESPeG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 11:34:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BBDE611AD;
        Wed, 19 May 2021 15:32:45 +0000 (UTC)
Date:   Wed, 19 May 2021 18:32:42 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: Re: [PATCH 5/5] RDMA/srp: Make struct scsi_cmnd and struct
 srp_request adjacent
Message-ID: <YKUvmo4a0+gL+LDi@unreal>
References: <20210512032752.16611-1-bvanassche@acm.org>
 <20210512032752.16611-6-bvanassche@acm.org>
 <YKTV1RKf4Ms+Zzx0@unreal>
 <7a66efb0-7195-aed1-7085-02374028f079@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a66efb0-7195-aed1-7085-02374028f079@acm.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 19, 2021 at 08:13:09AM -0700, Bart Van Assche wrote:
> On 5/19/21 2:09 AM, Leon Romanovsky wrote:
> > On Tue, May 11, 2021 at 08:27:52PM -0700, Bart Van Assche wrote:
> >> -static void srp_free_req_data(struct srp_target_port *target,
> >> -			      struct srp_rdma_ch *ch)
> >> +static int srp_exit_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
> >>  {
> >> +	struct srp_target_port *target = host_to_target(shost);
> >>  	struct srp_device *dev = target->srp_host->srp_dev;
> >>  	struct ib_device *ibdev = dev->dev;
> >> -	struct srp_request *req;
> >> -	int i;
> >> +	struct srp_request *req = scsi_cmd_priv(cmd);
> >>  
> >> -	if (!ch->req_ring)
> >> -		return;
> >> -
> >> -	for (i = 0; i < target->req_ring_size; ++i) {
> >> -		req = &ch->req_ring[i];
> >> -		if (dev->use_fast_reg)
> >> -			kfree(req->fr_list);
> >> -		if (req->indirect_dma_addr) {
> >> -			ib_dma_unmap_single(ibdev, req->indirect_dma_addr,
> >> -					    target->indirect_size,
> >> -					    DMA_TO_DEVICE);
> >> -		}
> >> -		kfree(req->indirect_desc);
> >> +	if (dev->use_fast_reg)
> >> +		kfree(req->fr_list);
> > 
> > Isn't cleaner will be to ensure that fr_list is NULL for !dev->use_fast_reg path?
> > In patch #4 https://lore.kernel.org/linux-rdma/20210512032752.16611-5-bvanassche@acm.org
> 
> Hi Leon,
> 
> I think that per-request private data is zero-initialized and hence that
> it is not necessary to clear req->fr_list explicitly. blk_mq_alloc_rqs()
>  passes __GFP_ZERO to alloc_pages_node(). blk_mq_alloc_rqs() does not
> only allocate block layer requests (struct request) but also per-request
> private data (set->cmd_size).

So you don't need this "if (dev->use_fast_reg)" check.

Thanks

> 
> Thanks,
> 
> Bart.
> 
> 
