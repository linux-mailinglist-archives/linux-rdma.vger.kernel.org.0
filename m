Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE46AA1C94
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2019 16:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfH2OVK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Aug 2019 10:21:10 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:60595 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfH2OVK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Aug 2019 10:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567088467; x=1598624467;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ULPu82uL7J1zB7hXtY/qlVoaaYVMW8jQsw2vIz/J2wI=;
  b=nAyZwzRLOk1PuXFWAu+I5t8/cuyKe1YLXJyAazuBS8lbtPdXA+A9mceN
   dbPZAOeasklC3e+wOODTEg3sYpF3aXleBb6DgBbR2+hNLft8+YlCyMMmt
   IH8exBn6kKqPmpp+qDtKWEN39yleygQ4y/vWJgKfGuCLFoLrklJh/hOgU
   s=;
X-IronPort-AV: E=Sophos;i="5.64,443,1559520000"; 
   d="scan'208";a="747997851"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 29 Aug 2019 14:21:05 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 873621A589D;
        Thu, 29 Aug 2019 14:21:04 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 29 Aug 2019 14:21:04 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.100) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 29 Aug 2019 14:20:58 +0000
Subject: Re: [PATCH v8 rdma-next 3/7] RDMA/efa: Use the common mmap_xa helpers
To:     Michal Kalderon <michal.kalderon@marvell.com>
CC:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <sleybo@amazon.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        Ariel Elior <ariel.elior@marvell.com>
References: <20190827132846.9142-1-michal.kalderon@marvell.com>
 <20190827132846.9142-4-michal.kalderon@marvell.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <c8781373-53ec-649e-1f1d-56cc17c229f9@amazon.com>
Date:   Thu, 29 Aug 2019 17:20:53 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827132846.9142-4-michal.kalderon@marvell.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D30UWC003.ant.amazon.com (10.43.162.122) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/08/2019 16:28, Michal Kalderon wrote:
> +static void efa_qp_user_mmap_entries_remove(struct efa_ucontext *ucontext,
> +					    struct efa_qp *qp)
> +{
> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext, qp->sq_db_mmap_key);
> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext,
> +				    qp->llq_desc_mmap_key);
> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext, qp->rq_mmap_key);
> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext, qp->rq_db_mmap_key);

Please remove the entries in reverse insertion order.

> +}
> +
>  static int qp_mmap_entries_setup(struct efa_qp *qp,
>  				 struct efa_dev *dev,
>  				 struct efa_ucontext *ucontext,
>  				 struct efa_com_create_qp_params *params,
>  				 struct efa_ibv_create_qp_resp *resp)
>  {
> -	/*
> -	 * Once an entry is inserted it might be mmapped, hence cannot be
> -	 * cleaned up until dealloc_ucontext.
> -	 */
> -	resp->sq_db_mmap_key =
> -		mmap_entry_insert(dev, ucontext, qp,
> -				  dev->db_bar_addr + resp->sq_db_offset,
> -				  PAGE_SIZE, EFA_MMAP_IO_NC);
> -	if (resp->sq_db_mmap_key == EFA_MMAP_INVALID)
> -		return -ENOMEM;
> +	u64 address;
> +	u64 length;
> +	int err;
> +
> +	err = efa_user_mmap_entry_insert(&ucontext->ibucontext,
> +					 dev->db_bar_addr +
> +					 resp->sq_db_offset,
> +					 PAGE_SIZE, EFA_MMAP_IO_NC,
> +					 &qp->sq_db_mmap_key);
> +	if (err)
> +		return err;
>  
> +	resp->sq_db_mmap_key = qp->sq_db_mmap_key;
>  	resp->sq_db_offset &= ~PAGE_MASK;
>  
> -	resp->llq_desc_mmap_key =
> -		mmap_entry_insert(dev, ucontext, qp,
> -				  dev->mem_bar_addr + resp->llq_desc_offset,
> -				  PAGE_ALIGN(params->sq_ring_size_in_bytes +
> -					     (resp->llq_desc_offset & ~PAGE_MASK)),
> -				  EFA_MMAP_IO_WC);
> -	if (resp->llq_desc_mmap_key == EFA_MMAP_INVALID)
> -		return -ENOMEM;
> +	address = dev->mem_bar_addr + resp->llq_desc_offset;
> +	length = PAGE_ALIGN(params->sq_ring_size_in_bytes +
> +			    (resp->llq_desc_offset & ~PAGE_MASK));
> +
> +	err = efa_user_mmap_entry_insert(&ucontext->ibucontext,
> +					 address,
> +					 length,
> +					 EFA_MMAP_IO_WC,
> +					 &qp->llq_desc_mmap_key);
> +	if (err)
> +		goto err1;
>  
> +	resp->llq_desc_mmap_key = qp->llq_desc_mmap_key;
>  	resp->llq_desc_offset &= ~PAGE_MASK;
>  
>  	if (qp->rq_size) {
> -		resp->rq_db_mmap_key =
> -			mmap_entry_insert(dev, ucontext, qp,
> -					  dev->db_bar_addr + resp->rq_db_offset,
> -					  PAGE_SIZE, EFA_MMAP_IO_NC);
> -		if (resp->rq_db_mmap_key == EFA_MMAP_INVALID)
> -			return -ENOMEM;
> +		address = dev->db_bar_addr + resp->rq_db_offset;
>  
> +		err = efa_user_mmap_entry_insert(&ucontext->ibucontext,
> +						 address, PAGE_SIZE,
> +						 EFA_MMAP_IO_NC,
> +						 &qp->rq_db_mmap_key);
> +		if (err)
> +			goto err2;
> +
> +		resp->rq_db_mmap_key = qp->rq_db_mmap_key;
>  		resp->rq_db_offset &= ~PAGE_MASK;
>  
> -		resp->rq_mmap_key =
> -			mmap_entry_insert(dev, ucontext, qp,
> -					  virt_to_phys(qp->rq_cpu_addr),
> -					  qp->rq_size, EFA_MMAP_DMA_PAGE);
> -		if (resp->rq_mmap_key == EFA_MMAP_INVALID)
> -			return -ENOMEM;
> +		address = virt_to_phys(qp->rq_cpu_addr);
> +		err = efa_user_mmap_entry_insert(&ucontext->ibucontext,
> +						 address, qp->rq_size,
> +						 EFA_MMAP_DMA_PAGE,
> +						 &qp->rq_mmap_key);
> +		if (err)
> +			goto err3;
>  
> +		resp->rq_mmap_key = qp->rq_mmap_key;
>  		resp->rq_mmap_size = qp->rq_size;
>  	}
>  
>  	return 0;
> +
> +err3:
> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext, qp->rq_db_mmap_key);
> +
> +err2:
> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext,
> +				    qp->llq_desc_mmap_key);
> +
> +err1:
> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext, qp->sq_db_mmap_key);

I prefer meaningful goto labels, e.g err_remove_sq_db instead of err1.

> +
> +	/* If any error occurred, we init the keys back to invalid */
> +	efa_qp_init_keys(qp);
> +
> +	return err;
>  }
>  
>  static int efa_qp_validate_cap(struct efa_dev *dev,
> @@ -634,7 +594,6 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>  	struct efa_dev *dev = to_edev(ibpd->device);
>  	struct efa_ibv_create_qp_resp resp = {};
>  	struct efa_ibv_create_qp cmd = {};
> -	bool rq_entry_inserted = false;
>  	struct efa_ucontext *ucontext;
>  	struct efa_qp *qp;
>  	int err;
> @@ -687,6 +646,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>  		goto err_out;
>  	}
>  
> +	efa_qp_init_keys(qp);
>  	create_qp_params.uarn = ucontext->uarn;
>  	create_qp_params.pd = to_epd(ibpd)->pdn;
>  
> @@ -742,7 +702,6 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>  	if (err)
>  		goto err_destroy_qp;
>  
> -	rq_entry_inserted = true;
>  	qp->qp_handle = create_qp_resp.qp_handle;
>  	qp->ibqp.qp_num = create_qp_resp.qp_num;
>  	qp->ibqp.qp_type = init_attr->qp_type;
> @@ -759,7 +718,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>  			ibdev_dbg(&dev->ibdev,
>  				  "Failed to copy udata for qp[%u]\n",
>  				  create_qp_resp.qp_num);
> -			goto err_destroy_qp;
> +			goto err_remove_mmap_entries;
>  		}
>  	}
>  
> @@ -767,15 +726,17 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>  
>  	return &qp->ibqp;
>  
> +err_remove_mmap_entries:
> +	efa_qp_user_mmap_entries_remove(ucontext, qp);
>  err_destroy_qp:
>  	efa_destroy_qp_handle(dev, create_qp_resp.qp_handle);
>  err_free_mapped:
> -	if (qp->rq_size) {
> +	if (qp->rq_dma_addr)

What's the difference?

>  		dma_unmap_single(&dev->pdev->dev, qp->rq_dma_addr, qp->rq_size,
>  				 DMA_TO_DEVICE);
> -		if (!rq_entry_inserted)
> -			free_pages_exact(qp->rq_cpu_addr, qp->rq_size);
> -	}
> +
> +	if (qp->rq_mmap_key == RDMA_USER_MMAP_INVALID)
> +		free_pages_exact(qp->rq_cpu_addr, qp->rq_size);

This should be inside the previous if statement, otherwise it might try to free
pages that weren't allocated.

>  err_free_qp:
>  	kfree(qp);
>  err_out:
> @@ -887,6 +848,7 @@ static int efa_destroy_cq_idx(struct efa_dev *dev, int cq_idx)
>  
>  void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>  {
> +	struct efa_ucontext *ucontext;

Reverse xmas tree.

>  	struct efa_dev *dev = to_edev(ibcq->device);
>  	struct efa_cq *cq = to_ecq(ibcq);
>  
> @@ -894,20 +856,33 @@ void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>  		  "Destroy cq[%d] virt[0x%p] freed: size[%lu], dma[%pad]\n",
>  		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
>  
> +	ucontext = rdma_udata_to_drv_context(udata, struct efa_ucontext,
> +					     ibucontext);
>  	efa_destroy_cq_idx(dev, cq->cq_idx);
>  	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
>  			 DMA_FROM_DEVICE);
> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext,
> +				    cq->mmap_key);

Entry removal should be first.

>  }
>  
>  static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
>  		      struct vm_area_struct *vma, u64 key, u64 length)
>  {
> -	struct efa_mmap_entry *entry;
> +	struct rdma_user_mmap_entry *rdma_entry;
> +	struct efa_user_mmap_entry *entry;
>  	unsigned long va;
>  	u64 pfn;
>  	int err;
>  
> -	entry = mmap_entry_get(dev, ucontext, key, length);
> -	if (!entry) {
> +	rdma_entry = rdma_user_mmap_entry_get(&ucontext->ibucontext, key,
> +					      length, vma);
> +	if (!rdma_entry) {
>  		ibdev_dbg(&dev->ibdev, "key[%#llx] does not have valid entry\n",
>  			  key);
>  		return -EINVAL;
>  	}
> +	entry = to_emmap(rdma_entry);
> +	if (entry->length != length) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "key[%#llx] does not have valid length[%#llx] expected[%#llx]\n",
> +			  key, length, entry->length);

Need to put the entry.

> +		return -EINVAL;
> +	}
>  
>  	ibdev_dbg(&dev->ibdev,
>  		  "Mapping address[%#llx], length[%#llx], mmap_flag[%d]\n",
> -		  entry->address, length, entry->mmap_flag);
> +		  entry->address, entry->length, entry->mmap_flag);
>  
>  	pfn = entry->address >> PAGE_SHIFT;
>  	switch (entry->mmap_flag) {
> @@ -1637,6 +1630,10 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
>  			&dev->ibdev,
>  			"Couldn't mmap address[%#llx] length[%#llx] mmap_flag[%d] err[%d]\n",
>  			entry->address, length, entry->mmap_flag, err);
> +
> +		rdma_user_mmap_entry_put(&ucontext->ibucontext,
> +					 rdma_entry);
> +
>  		return err;
>  	}
>  
