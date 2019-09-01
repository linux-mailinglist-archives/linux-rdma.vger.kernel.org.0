Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6630AA4802
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2019 08:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfIAG5L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Sep 2019 02:57:11 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:61206 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbfIAG5L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Sep 2019 02:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567321029; x=1598857029;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=j01AUuTTf/NvC++ABIVmbkBI2juIrLkkmIluvfVwQ+o=;
  b=LtH+S0L8TkobENhKxWMsYvArwd37j8h1n1kDeGBqRqi2DcSUsXI7u3lm
   zbeR6dqcijXcEe8s0Mnjf6GRg5GxYmyhyufwWHL0d3g+Zkfz9/k75xQE5
   7VmGkjsChtzjr1mQIbq49Z3JmJG+pucuC4tsy0ReGa4tCg6IlZq2ucx+U
   0=;
X-IronPort-AV: E=Sophos;i="5.64,454,1559520000"; 
   d="scan'208";a="825997287"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 01 Sep 2019 06:57:08 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id C676CA07D1;
        Sun,  1 Sep 2019 06:57:07 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 1 Sep 2019 06:57:07 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.242) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 1 Sep 2019 06:57:02 +0000
Subject: Re: [PATCH v8 rdma-next 3/7] RDMA/efa: Use the common mmap_xa helpers
To:     Michal Kalderon <mkalderon@marvell.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190827132846.9142-1-michal.kalderon@marvell.com>
 <20190827132846.9142-4-michal.kalderon@marvell.com>
 <c8781373-53ec-649e-1f1d-56cc17c229f9@amazon.com>
 <MN2PR18MB31820C96A5906F9054AE23D6A1BD0@MN2PR18MB3182.namprd18.prod.outlook.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <61cf039c-793e-e9e6-60e0-cd93b6da4815@amazon.com>
Date:   Sun, 1 Sep 2019 09:56:58 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <MN2PR18MB31820C96A5906F9054AE23D6A1BD0@MN2PR18MB3182.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.242]
X-ClientProxiedBy: EX13D15UWA004.ant.amazon.com (10.43.160.219) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 30/08/2019 9:15, Michal Kalderon wrote:
>> From: Gal Pressman <galpress@amazon.com>
>> Sent: Thursday, August 29, 2019 5:21 PM
>>
>> On 27/08/2019 16:28, Michal Kalderon wrote:
>>> +static void efa_qp_user_mmap_entries_remove(struct efa_ucontext
>> *ucontext,
>>> +					    struct efa_qp *qp)
>>> +{
>>> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext, qp-
>>> sq_db_mmap_key);
>>> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext,
>>> +				    qp->llq_desc_mmap_key);
>>> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext, qp-
>>> rq_mmap_key);
>>> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext,
>>> +qp->rq_db_mmap_key);
>>
>> Please remove the entries in reverse insertion order.
> I don't mind fixing, but why ? 

So the flows will be symmetric.

>>
>>> +}
>>> +
>>> @@ -767,15 +726,17 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>>>
>>>  	return &qp->ibqp;
>>>
>>> +err_remove_mmap_entries:
>>> +	efa_qp_user_mmap_entries_remove(ucontext, qp);
>>>  err_destroy_qp:
>>>  	efa_destroy_qp_handle(dev, create_qp_resp.qp_handle);
>>>  err_free_mapped:
>>> -	if (qp->rq_size) {
>>> +	if (qp->rq_dma_addr)
>>
>> What's the difference?
> Seemed a better query since it now only covers the rq_dma_addr unmapping. 
> 
>>
>>>  		dma_unmap_single(&dev->pdev->dev, qp->rq_dma_addr,
>> qp->rq_size,
>>>  				 DMA_TO_DEVICE);
>>> -		if (!rq_entry_inserted)
>>> -			free_pages_exact(qp->rq_cpu_addr, qp->rq_size);
>>> -	}
>>> +
>>> +	if (qp->rq_mmap_key == RDMA_USER_MMAP_INVALID)
>>> +		free_pages_exact(qp->rq_cpu_addr, qp->rq_size);
>>
>> This should be inside the previous if statement, otherwise it might try to free
>> pages that weren't allocated.
> If they weren't allocated the key will be INVALID and they won't be freed.

If the key is INVALID you call free_pages_exact, but rq_cpu_addr might have
never been allocated (if RQ is of size zero).

> 
>>
>>>  err_free_qp:
>>>  	kfree(qp);
>>>  err_out:
>>> @@ -887,6 +848,7 @@ static int efa_destroy_cq_idx(struct efa_dev *dev,
>>> int cq_idx)
>>>
>>>  void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)  {
>>> +	struct efa_ucontext *ucontext;
>>
>> Reverse xmas tree.
> ok
>>
>>>  	struct efa_dev *dev = to_edev(ibcq->device);
>>>  	struct efa_cq *cq = to_ecq(ibcq);
>>>
>>> @@ -894,20 +856,33 @@ void efa_destroy_cq(struct ib_cq *ibcq, struct
>> ib_udata *udata)
>>>  		  "Destroy cq[%d] virt[0x%p] freed: size[%lu], dma[%pad]\n",
>>>  		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
>>>
>>> +	ucontext = rdma_udata_to_drv_context(udata, struct efa_ucontext,
>>> +					     ibucontext);
>>>  	efa_destroy_cq_idx(dev, cq->cq_idx);
>>>  	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
>>>  			 DMA_FROM_DEVICE);
>>> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext,
>>> +				    cq->mmap_key);
>>
>> Entry removal should be first.
> Why ? removing can lead to freeing, why would we want that before unmapping ? 

Makes sense, thanks.

>>
>>>  }
>>>
