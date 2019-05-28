Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734272CD35
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 19:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfE1RKY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 13:10:24 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:19029 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE1RKY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 13:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559063422; x=1590599422;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ihIzcxzNdLnItF+7PibJc/bgCUutChdFNHMFSF6ePtw=;
  b=pLwYjYkJfykHR5wLT2JnFv4JtktWhe7BqSQok62hldlFbAQ1RX+0jjXU
   xoX/XxQF9Tt7L/m2sMFiRYzTkfp6GpI+nmymBjfJLvYgsM9p/CJYntGWP
   7XN3x8rjLb0Rkr7+1rfrVg+xpHcBCQ79jbhnUDPalc8QP0eRCfcmWxym9
   c=;
X-IronPort-AV: E=Sophos;i="5.60,523,1549929600"; 
   d="scan'208";a="767977060"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 May 2019 17:10:21 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x4SHAFo2107508
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 28 May 2019 17:10:19 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 17:10:19 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.237) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 May 2019 17:10:15 +0000
Subject: Re: [PATCH rdma-next v1 3/3] RDMA: Convert CQ allocations to be under
 core responsibility
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20190528113729.13314-1-leon@kernel.org>
 <20190528113729.13314-4-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <ecc6e5a9-c747-63f6-55ba-48f9b06b2589@amazon.com>
Date:   Tue, 28 May 2019 20:10:10 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528113729.13314-4-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.237]
X-ClientProxiedBy: EX13D20UWA002.ant.amazon.com (10.43.160.176) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 28/05/2019 14:37, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Ensure that CQ is allocated and freed by IB/core and not by drivers.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index e57f8adde174..fef760de0d6d 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -859,8 +859,6 @@ void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>  	efa_destroy_cq_idx(dev, cq->cq_idx);
>  	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
>  			 DMA_FROM_DEVICE);
> -
> -	kfree(cq);
>  }
>  
>  static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
> @@ -876,17 +874,20 @@ static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
>  	return 0;
>  }
>  
> -static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
> -				  int vector, struct ib_ucontext *ibucontext,
> -				  struct ib_udata *udata)
> +int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> +		  struct ib_udata *udata)
>  {
> +	struct efa_ucontext *ucontext = rdma_udata_to_drv_context(
> +		udata, struct efa_ucontext, ibucontext);
>  	struct efa_ibv_create_cq_resp resp = {};
>  	struct efa_com_create_cq_params params;
>  	struct efa_com_create_cq_result result;
> +	struct ib_device *ibdev = ibcq->device;
>  	struct efa_dev *dev = to_edev(ibdev);
>  	struct efa_ibv_create_cq cmd = {};
> +	struct efa_cq *cq = to_ecq(ibcq);
>  	bool cq_entry_inserted = false;
> -	struct efa_cq *cq;
> +	int entries = attr->cqe;
>  	int err;
>  
>  	ibdev_dbg(ibdev, "create_cq entries %d\n", entries);
> @@ -900,7 +901,7 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
>  	}
>  
>  	if (!field_avail(cmd, num_sub_cqs, udata->inlen)) {
> -		ibdev_dbg(ibdev,
> +		ibdev_dbg(ibcq->device,

You kept this change :\

Aside from that the EFA part LGTM, thanks Leon.
Acked-by: Gal Pressman <galpress@amazon.com>

>  			  "Incompatible ABI params, no input udata\n");
>  		err = -EINVAL;
>  		goto err_out;
> @@ -944,19 +945,13 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
>  		goto err_out;
>  	}
>  
> -	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
> -	if (!cq) {
> -		err = -ENOMEM;
> -		goto err_out;
> -	}
> -
> -	cq->ucontext = to_eucontext(ibucontext);
> +	cq->ucontext = ucontext;
>  	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
>  	cq->cpu_addr = efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
>  					 DMA_FROM_DEVICE);
>  	if (!cq->cpu_addr) {
>  		err = -ENOMEM;
> -		goto err_free_cq;
> +		goto err_out;
>  	}
>  
>  	params.uarn = cq->ucontext->uarn;
> @@ -975,8 +970,8 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
>  
>  	err = cq_mmap_entries_setup(dev, cq, &resp);
>  	if (err) {
> -		ibdev_dbg(ibdev,
> -			  "Could not setup cq[%u] mmap entries\n", cq->cq_idx);
> +		ibdev_dbg(ibdev, "Could not setup cq[%u] mmap entries\n",
> +			  cq->cq_idx);
>  		goto err_destroy_cq;
>  	}
>  
> @@ -992,11 +987,10 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
>  		}
>  	}
>  
> -	ibdev_dbg(ibdev,
> -		  "Created cq[%d], cq depth[%u]. dma[%pad] virt[0x%p]\n",
> +	ibdev_dbg(ibdev, "Created cq[%d], cq depth[%u]. dma[%pad] virt[0x%p]\n",
>  		  cq->cq_idx, result.actual_depth, &cq->dma_addr, cq->cpu_addr);
>  
> -	return &cq->ibcq;
> +	return 0;
>  
>  err_destroy_cq:
>  	efa_destroy_cq_idx(dev, cq->cq_idx);
> @@ -1005,23 +999,9 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
>  			 DMA_FROM_DEVICE);
>  	if (!cq_entry_inserted)
>  		free_pages_exact(cq->cpu_addr, cq->size);
> -err_free_cq:
> -	kfree(cq);
>  err_out:
>  	atomic64_inc(&dev->stats.sw_stats.create_cq_err);
> -	return ERR_PTR(err);
> -}
> -
> -struct ib_cq *efa_create_cq(struct ib_device *ibdev,
> -			    const struct ib_cq_init_attr *attr,
> -			    struct ib_udata *udata)
> -{
> -	struct efa_ucontext *ucontext = rdma_udata_to_drv_context(udata,
> -								  struct efa_ucontext,
> -								  ibucontext);
> -
> -	return do_create_cq(ibdev, attr->cqe, attr->comp_vector,
> -			    &ucontext->ibucontext, udata);
> +	return err;
>  }
>  
>  static int umem_to_page_list(struct efa_dev *dev,
