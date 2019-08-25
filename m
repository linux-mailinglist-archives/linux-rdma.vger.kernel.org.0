Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 823799C2EF
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Aug 2019 12:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfHYKpj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Aug 2019 06:45:39 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:19730 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfHYKpj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 25 Aug 2019 06:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566729937; x=1598265937;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qHs7d9fAbYKTXVEdMOaDRsxDOmoo07NS2GpPvTKCybY=;
  b=viBr/6DfbmJ7vxTSGMGAVZrRuMSXkJI+v4cpCfWm50KvERNQ1I4yrO+T
   xQU7xiDfRj65PTIUjqkSX9tpyiUFmsM4IfsjXmg95Ezm6z0qOk8GwiAvP
   ScldYAnEjGCEdT6nyFKhKosZI6OLzToQPxJy7wuR4p9YubUJleVZChQFz
   o=;
X-IronPort-AV: E=Sophos;i="5.64,429,1559520000"; 
   d="scan'208";a="781268814"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 25 Aug 2019 10:45:37 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 39817A1FF2;
        Sun, 25 Aug 2019 10:45:34 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 25 Aug 2019 10:45:34 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.167) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 25 Aug 2019 10:45:30 +0000
Subject: Re: [PATCH v7 rdma-next 3/7] RDMA/efa: Use the common mmap_xa helpers
To:     Michal Kalderon <mkalderon@marvell.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-4-michal.kalderon@marvell.com>
 <6f524e9e-b866-d538-3dc9-322aa4e30b5f@amazon.com>
 <MN2PR18MB3182C05D896D4FCA5CC86019A1A60@MN2PR18MB3182.namprd18.prod.outlook.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <942f87b9-53dd-88ff-9045-2f3de7cc719c@amazon.com>
Date:   Sun, 25 Aug 2019 13:45:25 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <MN2PR18MB3182C05D896D4FCA5CC86019A1A60@MN2PR18MB3182.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.167]
X-ClientProxiedBy: EX13D18UWC002.ant.amazon.com (10.43.162.88) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 25/08/2019 11:41, Michal Kalderon wrote:
>>> @@ -515,46 +408,55 @@ static int qp_mmap_entries_setup(struct efa_qp
>> *qp,
>>>  				 struct efa_com_create_qp_params
>> *params,
>>>  				 struct efa_ibv_create_qp_resp *resp)  {
>>> +	u64 address;
>>> +	u64 length;
>>> +
>>>  	/*
>>>  	 * Once an entry is inserted it might be mmapped, hence cannot be
>>>  	 * cleaned up until dealloc_ucontext.
>>>  	 */
>>>  	resp->sq_db_mmap_key =
>>
>> Not a big deal, but now it makes more sense to assign qp-
>>> sq_db_mmap_key and assign the response later on.
> ok
>>
>>> -		mmap_entry_insert(dev, ucontext, qp,
>>> -				  dev->db_bar_addr + resp->sq_db_offset,
>>> -				  PAGE_SIZE, EFA_MMAP_IO_NC);
>>> -	if (resp->sq_db_mmap_key == EFA_MMAP_INVALID)
>>> +		rdma_user_mmap_entry_insert(&ucontext->ibucontext, qp,
>>> +					    dev->db_bar_addr +
>>> +					    resp->sq_db_offset,
>>> +					    PAGE_SIZE, EFA_MMAP_IO_NC);
>>> +	if (resp->sq_db_mmap_key == RDMA_USER_MMAP_INVALID)
>>>  		return -ENOMEM;
>>> -
>>> +	qp->sq_db_mmap_key = resp->sq_db_mmap_key;
>>>  	resp->sq_db_offset &= ~PAGE_MASK;
>>>
>>> +	address = dev->mem_bar_addr + resp->llq_desc_offset;
>>> +	length = PAGE_ALIGN(params->sq_ring_size_in_bytes +
>>> +			    (resp->llq_desc_offset & ~PAGE_MASK));
>>>  	resp->llq_desc_mmap_key =
>>> -		mmap_entry_insert(dev, ucontext, qp,
>>> -				  dev->mem_bar_addr + resp-
>>> llq_desc_offset,
>>> -				  PAGE_ALIGN(params-
>>> sq_ring_size_in_bytes +
>>> -					     (resp->llq_desc_offset &
>> ~PAGE_MASK)),
>>> -				  EFA_MMAP_IO_WC);
>>> -	if (resp->llq_desc_mmap_key == EFA_MMAP_INVALID)
>>> +		rdma_user_mmap_entry_insert(&ucontext->ibucontext, qp,
>>> +					    address,
>>> +					    length,
>>> +					    EFA_MMAP_IO_WC);
>>> +	if (resp->llq_desc_mmap_key == RDMA_USER_MMAP_INVALID)
>>>  		return -ENOMEM;
>>> -
>>> +	qp->llq_desc_mmap_key = resp->llq_desc_mmap_key;
>>>  	resp->llq_desc_offset &= ~PAGE_MASK;
>>>
>>>  	if (qp->rq_size) {
>>> +		address = dev->db_bar_addr + resp->rq_db_offset;
>>>  		resp->rq_db_mmap_key =
>>> -			mmap_entry_insert(dev, ucontext, qp,
>>> -					  dev->db_bar_addr + resp-
>>> rq_db_offset,
>>> -					  PAGE_SIZE, EFA_MMAP_IO_NC);
>>> -		if (resp->rq_db_mmap_key == EFA_MMAP_INVALID)
>>> +			rdma_user_mmap_entry_insert(&ucontext-
>>> ibucontext, qp,
>>> +						    address, PAGE_SIZE,
>>> +						    EFA_MMAP_IO_NC);
>>> +		if (resp->rq_db_mmap_key ==
>> RDMA_USER_MMAP_INVALID)
>>>  			return -ENOMEM;
>>> -
>>> +		qp->rq_db_mmap_key = resp->rq_db_mmap_key;
>>>  		resp->rq_db_offset &= ~PAGE_MASK;
>>>
>>> +		address = virt_to_phys(qp->rq_cpu_addr);
>>>  		resp->rq_mmap_key =
>>> -			mmap_entry_insert(dev, ucontext, qp,
>>> -					  virt_to_phys(qp->rq_cpu_addr),
>>> -					  qp->rq_size,
>> EFA_MMAP_DMA_PAGE);
>>> -		if (resp->rq_mmap_key == EFA_MMAP_INVALID)
>>> +			rdma_user_mmap_entry_insert(&ucontext-
>>> ibucontext, qp,
>>> +						    address, qp->rq_size,
>>> +						    EFA_MMAP_DMA_PAGE);
>>> +		if (resp->rq_mmap_key == RDMA_USER_MMAP_INVALID)
>>>  			return -ENOMEM;
>>> +		qp->rq_mmap_key = resp->rq_mmap_key;
>>>
>>>  		resp->rq_mmap_size = qp->rq_size;
>>>  	}
>>> @@ -775,6 +677,9 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>>>  				 DMA_TO_DEVICE);
>>>  		if (!rq_entry_inserted)
>>
>> Now that we store the keys on the QP object we can remove the
>> rq_entry_inserted variable and test for !qp->rq_mmap_key.
> ok
>>
>>>  			free_pages_exact(qp->rq_cpu_addr, qp->rq_size);
>>> +		else
>>> +			rdma_user_mmap_entry_remove(&ucontext-
>>> ibucontext,
>>> +						    qp->rq_mmap_key);
>>
>> Other entries need to be removed as well, otherwise the refcount won't
>> reach zero. This error flow should now be similar to efa_destroy_qp. I think
>> that means losing the free_pages_exact too.
> Not sure I understand, how can we loose the free_pages_exact ? if the entry wasn’t 
> Inserted into the mmap_xa what flow will free the pages ? 

You're right.
Still need to remove other entries though.
