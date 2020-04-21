Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAB21B2B0D
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2020 17:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgDUPVZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Apr 2020 11:21:25 -0400
Received: from verein.lst.de ([213.95.11.211]:47297 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgDUPVY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Apr 2020 11:21:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EC80668C4E; Tue, 21 Apr 2020 17:21:21 +0200 (CEST)
Date:   Tue, 21 Apr 2020 17:21:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
Subject: Re: [PATCH 09/17] nvmet: prepare metadata request
Message-ID: <20200421152121.GB10837@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-11-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327171545.98970-11-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 27, 2020 at 08:15:37PM +0300, Max Gurtovoy wrote:
> From: Israel Rukshin <israelr@mellanox.com>
> 
> Allocate the metadata SGL buffers and set metadata fields for the
> request. This is a preparation for adding metadata support over the
> fabrics.

I don't think having this as a separate prep patch is a good idea, it
should go with the code making use of it.

> -						       req->transfer_len);
> -			if (req->sg) {
> -				req->p2p_dev = p2p_dev;
> -				return 0;
> +						       data_len);
> +			if (!req->sg)
> +				goto fallback;
> +
> +			if (req->md_len) {
> +				req->md_sg =
> +					pci_p2pmem_alloc_sgl(p2p_dev,
> +							     &req->md_sg_cnt,
> +							     req->md_len);
> +				if (!req->md_sg) {
> +					pci_p2pmem_free_sgl(req->p2p_dev,
> +							    req->sg);
> +					goto fallback;
> +				}
>  			}
> +			req->p2p_dev = p2p_dev;
> +			return 0;
>  		}
>  
>  		/*
> @@ -984,23 +1001,40 @@ int nvmet_req_alloc_sgl(struct nvmet_req *req)
>  		 */
>  	}
>  
> -	req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
> +fallback:
> +	req->sg = sgl_alloc(data_len, GFP_KERNEL, &req->sg_cnt);
>  	if (unlikely(!req->sg))
>  		return -ENOMEM;
>  
> +	if (req->md_len) {
> +		req->md_sg = sgl_alloc(req->md_len, GFP_KERNEL,
> +					 &req->md_sg_cnt);
> +		if (unlikely(!req->md_sg)) {
> +			sgl_free(req->sg);
> +			return -ENOMEM;
> +		}
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(nvmet_req_alloc_sgl);

I suspect this might be a little cleaner with a nvmet_alloc_sgl
helper that returns a scatterlist instead of duplicating all the
code for data vs metadata.
