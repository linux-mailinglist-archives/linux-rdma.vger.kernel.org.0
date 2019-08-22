Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBD4C994BC
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 15:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbfHVNTC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 09:19:02 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:47276 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730621AbfHVNTC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Aug 2019 09:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566479940; x=1598015940;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=n/3vAev783aW10q4zG7wP4DwkX2/tDR3BZut9NH2m5c=;
  b=rhgWLfgELWbQ3VB9EVk0Rh6jxOk6wrwvq+9iCwAB9fgvve6tQvDkEDfF
   3+fCtSHUpnNun8bDQP+ZagwQ71ZsdGXEjP6wpeuyCfMW7x4Q2uncfOoff
   xugOfRwcdxHKsTXR8Cisfq8Mim0TlPTCKyMtj7YRYFyzJ/YN6lf3FVkdm
   E=;
X-IronPort-AV: E=Sophos;i="5.64,416,1559520000"; 
   d="scan'208";a="780763984"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 22 Aug 2019 13:18:58 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id 20DC4A2FC0;
        Thu, 22 Aug 2019 13:18:55 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 22 Aug 2019 13:18:55 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.67) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 22 Aug 2019 13:18:50 +0000
Subject: Re: [PATCH v7 rdma-next 3/7] RDMA/efa: Use the common mmap_xa helpers
To:     Michal Kalderon <michal.kalderon@marvell.com>
CC:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <sleybo@amazon.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        Ariel Elior <ariel.elior@marvell.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-4-michal.kalderon@marvell.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <6f524e9e-b866-d538-3dc9-322aa4e30b5f@amazon.com>
Date:   Thu, 22 Aug 2019 16:18:45 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820121847.25871-4-michal.kalderon@marvell.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.67]
X-ClientProxiedBy: EX13D15UWA004.ant.amazon.com (10.43.160.219) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/08/2019 15:18, Michal Kalderon wrote:
>  int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>  {
> +	struct efa_ucontext *ucontext;

Reverse xmas tree please.

>  	struct efa_dev *dev = to_edev(ibqp->pd->device);
>  	struct efa_qp *qp = to_eqp(ibqp);
>  	int err;
>  
>  	ibdev_dbg(&dev->ibdev, "Destroy qp[%u]\n", ibqp->qp_num);
> +	ucontext = rdma_udata_to_drv_context(udata, struct efa_ucontext,
> +					     ibucontext);

Consider initializing on ucontext declaration.

> +
>  	err = efa_destroy_qp_handle(dev, qp->qp_handle);
>  	if (err)
>  		return err;
>  
> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext, qp->sq_db_mmap_key);
> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext,
> +				    qp->llq_desc_mmap_key);

The mmap entries removal should happen before efa_destroy_qp_handle.

>  	if (qp->rq_cpu_addr) {
>  		ibdev_dbg(&dev->ibdev,
>  			  "qp->cpu_addr[0x%p] freed: size[%lu], dma[%pad]\n",
> @@ -503,6 +392,10 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>  			  &qp->rq_dma_addr);
>  		dma_unmap_single(&dev->pdev->dev, qp->rq_dma_addr, qp->rq_size,
>  				 DMA_TO_DEVICE);
> +		rdma_user_mmap_entry_remove(&ucontext->ibucontext,
> +					    qp->rq_mmap_key);
> +		rdma_user_mmap_entry_remove(&ucontext->ibucontext,
> +					    qp->rq_db_mmap_key);

Same.

>  	}
>  
>  	kfree(qp);
> @@ -515,46 +408,55 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
>  				 struct efa_com_create_qp_params *params,
>  				 struct efa_ibv_create_qp_resp *resp)
>  {
> +	u64 address;
> +	u64 length;
> +
>  	/*
>  	 * Once an entry is inserted it might be mmapped, hence cannot be
>  	 * cleaned up until dealloc_ucontext.
>  	 */
>  	resp->sq_db_mmap_key =

Not a big deal, but now it makes more sense to assign qp->sq_db_mmap_key and
assign the response later on.

> -		mmap_entry_insert(dev, ucontext, qp,
> -				  dev->db_bar_addr + resp->sq_db_offset,
> -				  PAGE_SIZE, EFA_MMAP_IO_NC);
> -	if (resp->sq_db_mmap_key == EFA_MMAP_INVALID)
> +		rdma_user_mmap_entry_insert(&ucontext->ibucontext, qp,
> +					    dev->db_bar_addr +
> +					    resp->sq_db_offset,
> +					    PAGE_SIZE, EFA_MMAP_IO_NC);
> +	if (resp->sq_db_mmap_key == RDMA_USER_MMAP_INVALID)
>  		return -ENOMEM;
> -
> +	qp->sq_db_mmap_key = resp->sq_db_mmap_key;
>  	resp->sq_db_offset &= ~PAGE_MASK;
>  
> +	address = dev->mem_bar_addr + resp->llq_desc_offset;
> +	length = PAGE_ALIGN(params->sq_ring_size_in_bytes +
> +			    (resp->llq_desc_offset & ~PAGE_MASK));
>  	resp->llq_desc_mmap_key =
> -		mmap_entry_insert(dev, ucontext, qp,
> -				  dev->mem_bar_addr + resp->llq_desc_offset,
> -				  PAGE_ALIGN(params->sq_ring_size_in_bytes +
> -					     (resp->llq_desc_offset & ~PAGE_MASK)),
> -				  EFA_MMAP_IO_WC);
> -	if (resp->llq_desc_mmap_key == EFA_MMAP_INVALID)
> +		rdma_user_mmap_entry_insert(&ucontext->ibucontext, qp,
> +					    address,
> +					    length,
> +					    EFA_MMAP_IO_WC);
> +	if (resp->llq_desc_mmap_key == RDMA_USER_MMAP_INVALID)
>  		return -ENOMEM;
> -
> +	qp->llq_desc_mmap_key = resp->llq_desc_mmap_key;
>  	resp->llq_desc_offset &= ~PAGE_MASK;
>  
>  	if (qp->rq_size) {
> +		address = dev->db_bar_addr + resp->rq_db_offset;
>  		resp->rq_db_mmap_key =
> -			mmap_entry_insert(dev, ucontext, qp,
> -					  dev->db_bar_addr + resp->rq_db_offset,
> -					  PAGE_SIZE, EFA_MMAP_IO_NC);
> -		if (resp->rq_db_mmap_key == EFA_MMAP_INVALID)
> +			rdma_user_mmap_entry_insert(&ucontext->ibucontext, qp,
> +						    address, PAGE_SIZE,
> +						    EFA_MMAP_IO_NC);
> +		if (resp->rq_db_mmap_key == RDMA_USER_MMAP_INVALID)
>  			return -ENOMEM;
> -
> +		qp->rq_db_mmap_key = resp->rq_db_mmap_key;
>  		resp->rq_db_offset &= ~PAGE_MASK;
>  
> +		address = virt_to_phys(qp->rq_cpu_addr);
>  		resp->rq_mmap_key =
> -			mmap_entry_insert(dev, ucontext, qp,
> -					  virt_to_phys(qp->rq_cpu_addr),
> -					  qp->rq_size, EFA_MMAP_DMA_PAGE);
> -		if (resp->rq_mmap_key == EFA_MMAP_INVALID)
> +			rdma_user_mmap_entry_insert(&ucontext->ibucontext, qp,
> +						    address, qp->rq_size,
> +						    EFA_MMAP_DMA_PAGE);
> +		if (resp->rq_mmap_key == RDMA_USER_MMAP_INVALID)
>  			return -ENOMEM;
> +		qp->rq_mmap_key = resp->rq_mmap_key;
>  
>  		resp->rq_mmap_size = qp->rq_size;
>  	}
> @@ -775,6 +677,9 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>  				 DMA_TO_DEVICE);
>  		if (!rq_entry_inserted)

Now that we store the keys on the QP object we can remove the rq_entry_inserted
variable and test for !qp->rq_mmap_key.

>  			free_pages_exact(qp->rq_cpu_addr, qp->rq_size);
> +		else
> +			rdma_user_mmap_entry_remove(&ucontext->ibucontext,
> +						    qp->rq_mmap_key);

Other entries need to be removed as well, otherwise the refcount won't reach
zero. This error flow should now be similar to efa_destroy_qp. I think that
means losing the free_pages_exact too.

>  	}
>  err_free_qp:
>  	kfree(qp);

Pretty much the same comments for the CQ parts as the QP.
