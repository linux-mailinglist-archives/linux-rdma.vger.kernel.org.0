Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B2E23808
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 15:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfETNbk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 09:31:40 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:22322 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbfETNbk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 May 2019 09:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1558359097; x=1589895097;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=AwQguLVXJdSHCOj35VzPKkb9TJRt4MB+fkxiin71iiE=;
  b=mWdrgIgoe8jLPKu/gHrb6UXTSsMoLdxRjChax/tifAAcLbn4bXTdKEn2
   1l+n3y5KpBPKoMhqwTJpkIp77MYO6qYWFAmoBsQiTigDnZawsXDikPYYN
   L+0nVv7kVQx/rF7H4Er1xtJAwgskqv3XR+949/bSen9lYEQSG8fXQtk+M
   g=;
X-IronPort-AV: E=Sophos;i="5.60,491,1549929600"; 
   d="scan'208";a="805561934"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 May 2019 13:31:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x4KDVV4k006497
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 20 May 2019 13:31:33 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 20 May 2019 13:31:32 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.4) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 20 May 2019 13:31:26 +0000
Subject: Re: [PATCH rdma-next 15/15] RDMA: Convert CQ allocations to be under
 core responsibility
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        "Steve Wise" <swise@opengridcomputing.com>
References: <20190520065433.8734-1-leon@kernel.org>
 <20190520065433.8734-16-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <9eb4853d-71cd-0335-bfaf-ce808ba21047@amazon.com>
Date:   Mon, 20 May 2019 16:31:22 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520065433.8734-16-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.4]
X-ClientProxiedBy: EX13D07UWB002.ant.amazon.com (10.43.161.131) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/05/2019 9:54, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Ensure that CQ is allocated and freed by IB/core and not by drivers.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
> index 8d8d3bd47c35..2ceb8067b99a 100644
> --- a/drivers/infiniband/hw/efa/efa.h
> +++ b/drivers/infiniband/hw/efa/efa.h
> @@ -137,9 +137,8 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>  			    struct ib_qp_init_attr *init_attr,
>  			    struct ib_udata *udata);
>  void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
> -struct ib_cq *efa_create_cq(struct ib_device *ibdev,
> -			    const struct ib_cq_init_attr *attr,
> -			    struct ib_udata *udata);
> +int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> +		  struct ib_udata *udata);
>  struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
>  			 u64 virt_addr, int access_flags,
>  			 struct ib_udata *udata);
> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
> index db974caf1eb1..27f8a473bde9 100644
> --- a/drivers/infiniband/hw/efa/efa_main.c
> +++ b/drivers/infiniband/hw/efa/efa_main.c
> @@ -220,6 +220,7 @@ static const struct ib_device_ops efa_dev_ops = {
>  	.reg_user_mr = efa_reg_mr,
>  
>  	INIT_RDMA_OBJ_SIZE(ib_ah, efa_ah, ibah),
> +	INIT_RDMA_OBJ_SIZE(ib_cq, efa_cq, ibcq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, efa_pd, ibpd),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, efa_ucontext, ibucontext),
>  };
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index e57f8adde174..6ccb85950439 100644
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
> @@ -876,20 +874,23 @@ static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
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
> +	struct ib_device *ibdev = ibcq->device;
> +	struct efa_dev *dev = to_edev(ibdev);

Nit, can we please keep the existing reverse xmas tree?

>  	struct efa_ibv_create_cq_resp resp = {};
>  	struct efa_com_create_cq_params params;
>  	struct efa_com_create_cq_result result;
> -	struct efa_dev *dev = to_edev(ibdev);
>  	struct efa_ibv_create_cq cmd = {};
> +	struct efa_cq *cq = to_ecq(ibcq);
>  	bool cq_entry_inserted = false;
> -	struct efa_cq *cq;
> +	int entries = attr->cqe;
>  	int err;
>  
> -	ibdev_dbg(ibdev, "create_cq entries %d\n", entries);
> +	ibdev_dbg(ibcq->device, "create_cq entries %d\n", entries);

No need to change, we can keep using 'ibdev'. Same applies for other prints.

>  
>  	if (entries < 1 || entries > dev->dev_attr.max_cq_depth) {
>  		ibdev_dbg(ibdev,
> @@ -900,7 +901,7 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
>  	}
>  
>  	if (!field_avail(cmd, num_sub_cqs, udata->inlen)) {
> -		ibdev_dbg(ibdev,
> +		ibdev_dbg(ibcq->device,
>  			  "Incompatible ABI params, no input udata\n");
>  		err = -EINVAL;
>  		goto err_out;
> @@ -909,7 +910,7 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
>  	if (udata->inlen > sizeof(cmd) &&
>  	    !ib_is_udata_cleared(udata, sizeof(cmd),
>  				 udata->inlen - sizeof(cmd))) {
> -		ibdev_dbg(ibdev,
> +		ibdev_dbg(ibcq->device,
>  			  "Incompatible ABI params, unknown fields in udata\n");
>  		err = -EINVAL;
>  		goto err_out;
> @@ -918,45 +919,39 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
>  	err = ib_copy_from_udata(&cmd, udata,
>  				 min(sizeof(cmd), udata->inlen));
>  	if (err) {
> -		ibdev_dbg(ibdev, "Cannot copy udata for create_cq\n");
> +		ibdev_dbg(ibcq->device, "Cannot copy udata for create_cq\n");
>  		goto err_out;
>  	}
>  
>  	if (cmd.comp_mask || !is_reserved_cleared(cmd.reserved_50)) {
> -		ibdev_dbg(ibdev,
> +		ibdev_dbg(ibcq->device,
>  			  "Incompatible ABI params, unknown fields in udata\n");
>  		err = -EINVAL;
>  		goto err_out;
>  	}
>  
>  	if (!cmd.cq_entry_size) {
> -		ibdev_dbg(ibdev,
> +		ibdev_dbg(ibcq->device,
>  			  "Invalid entry size [%u]\n", cmd.cq_entry_size);
>  		err = -EINVAL;
>  		goto err_out;
>  	}
>  
>  	if (cmd.num_sub_cqs != dev->dev_attr.sub_cqs_per_cq) {
> -		ibdev_dbg(ibdev,
> +		ibdev_dbg(ibcq->device,
>  			  "Invalid number of sub cqs[%u] expected[%u]\n",
>  			  cmd.num_sub_cqs, dev->dev_attr.sub_cqs_per_cq);
>  		err = -EINVAL;
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
> @@ -975,7 +970,7 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
>  
>  	err = cq_mmap_entries_setup(dev, cq, &resp);
>  	if (err) {
> -		ibdev_dbg(ibdev,
> +		ibdev_dbg(ibcq->device,
>  			  "Could not setup cq[%u] mmap entries\n", cq->cq_idx);
>  		goto err_destroy_cq;
>  	}
> @@ -986,17 +981,17 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
>  		err = ib_copy_to_udata(udata, &resp,
>  				       min(sizeof(resp), udata->outlen));
>  		if (err) {
> -			ibdev_dbg(ibdev,
> +			ibdev_dbg(ibcq->device,
>  				  "Failed to copy udata for create_cq\n");
>  			goto err_destroy_cq;
>  		}
>  	}
>  
> -	ibdev_dbg(ibdev,
> +	ibdev_dbg(ibcq->device,
>  		  "Created cq[%d], cq depth[%u]. dma[%pad] virt[0x%p]\n",
>  		  cq->cq_idx, result.actual_depth, &cq->dma_addr, cq->cpu_addr);
>  
> -	return &cq->ibcq;
> +	return 0;
>  
>  err_destroy_cq:
>  	efa_destroy_cq_idx(dev, cq->cq_idx);
> @@ -1005,23 +1000,9 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
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
