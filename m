Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C09A644A
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2019 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfICIsB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Sep 2019 04:48:01 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:47252 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfICIsB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Sep 2019 04:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567500480; x=1599036480;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cqA30Z5ScfcVkn6ubI9Q7V7T4ccyUR4HkL7QmwE3sA4=;
  b=Y2Lt8bXA62KdBtHZ6csrLQdA7ghf+SMn4hAo0zdI70hAzcYTht9glsJG
   S07tjUcLqqJ8uypJ704Qr7eJFTW3Whl+MpMLVOWeoii9kFoH6WQfL68bJ
   SeUv5fsDwm9hgmISwY7GHfA3moDwZUEpRrk9FCpLbah9oa+uY30P0vHmh
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,462,1559520000"; 
   d="scan'208";a="700166195"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 03 Sep 2019 08:47:55 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 35731A32F9;
        Tue,  3 Sep 2019 08:47:55 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Sep 2019 08:47:54 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.20) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Sep 2019 08:47:49 +0000
Subject: Re: [PATCH v9 rdma-next 3/7] RDMA/efa: Use the common mmap_xa helpers
To:     Michal Kalderon <michal.kalderon@marvell.com>
CC:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>,
        "Ariel Elior" <ariel.elior@marvell.com>
References: <20190902162314.17508-1-michal.kalderon@marvell.com>
 <20190902162314.17508-4-michal.kalderon@marvell.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <c6a758ce-3b9e-5e95-5a44-d8add311d976@amazon.com>
Date:   Tue, 3 Sep 2019 11:47:44 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902162314.17508-4-michal.kalderon@marvell.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.20]
X-ClientProxiedBy: EX13D07UWA004.ant.amazon.com (10.43.160.32) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 02/09/2019 19:23, Michal Kalderon wrote:
>  int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>  {
> +	struct efa_ucontext *ucontext = rdma_udata_to_drv_context(udata,
> +		struct efa_ucontext, ibucontext);
>  	struct efa_dev *dev = to_edev(ibqp->pd->device);
>  	struct efa_qp *qp = to_eqp(ibqp);
>  	int err;
>  
>  	ibdev_dbg(&dev->ibdev, "Destroy qp[%u]\n", ibqp->qp_num);
> +
> +	efa_qp_user_mmap_entries_remove(ucontext, qp);
> +
>  	err = efa_destroy_qp_handle(dev, qp->qp_handle);
>  	if (err)
>  		return err;
> @@ -509,57 +412,114 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>  	return 0;
>  }
>  
>  void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>  {
> +	struct efa_ucontext *ucontext = rdma_udata_to_drv_context(udata,
> +			struct efa_ucontext, ibucontext);
> +
>  	struct efa_dev *dev = to_edev(ibcq->device);
>  	struct efa_cq *cq = to_ecq(ibcq);
>  
> @@ -897,17 +862,28 @@ void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>  	efa_destroy_cq_idx(dev, cq->cq_idx);
>  	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
>  			 DMA_FROM_DEVICE);
> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext,
> +				    cq->mmap_key);

How come in destroy_qp we do entry removal first, but in destroy_cq it's last?
Shouldn't it be the same?
