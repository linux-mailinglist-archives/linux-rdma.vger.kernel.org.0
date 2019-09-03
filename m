Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF76A6C7D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2019 17:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfICPIW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Sep 2019 11:08:22 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:15407 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbfICPHh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Sep 2019 11:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567523256; x=1599059256;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/8qtzK4hbsE5iw1VGCKr0kfHebH2HzCsuE0OkwjZ1KU=;
  b=jae1imQX+XBgTTphCCfiX5f/pXKmswnA4e5Pr8ulzRlwY4yxjocEmCKF
   j3x+UZWm9jd49d32zoWl0ZPADCOVMHzsejr0b7AyXPh5Qm1E6u1h66Ihc
   lwuMo9b2bnRvNXBWvApMneOLmcv1wEBzhb0Nl9LVrtXddQF78lkEziEJI
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,463,1559520000"; 
   d="scan'208";a="826785236"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 03 Sep 2019 15:07:34 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 46769A2261;
        Tue,  3 Sep 2019 15:07:31 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Sep 2019 15:07:31 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.20) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Sep 2019 15:07:26 +0000
Subject: Re: [PATCH v9 rdma-next 3/7] RDMA/efa: Use the common mmap_xa helpers
To:     Michal Kalderon <mkalderon@marvell.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190902162314.17508-1-michal.kalderon@marvell.com>
 <20190902162314.17508-4-michal.kalderon@marvell.com>
 <c6a758ce-3b9e-5e95-5a44-d8add311d976@amazon.com>
 <MN2PR18MB31827812160980AA00992B92A1B90@MN2PR18MB3182.namprd18.prod.outlook.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <47b5d22f-e208-0ed2-19d3-b1beb22cf806@amazon.com>
Date:   Tue, 3 Sep 2019 18:07:22 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <MN2PR18MB31827812160980AA00992B92A1B90@MN2PR18MB3182.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.20]
X-ClientProxiedBy: EX13D24UWA003.ant.amazon.com (10.43.160.195) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03/09/2019 12:31, Michal Kalderon wrote:
>> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
>> owner@vger.kernel.org> On Behalf Of Gal Pressman
>>
>> On 02/09/2019 19:23, Michal Kalderon wrote:
>>>  int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)  {
>>> +	struct efa_ucontext *ucontext =
>> rdma_udata_to_drv_context(udata,
>>> +		struct efa_ucontext, ibucontext);
>>>  	struct efa_dev *dev = to_edev(ibqp->pd->device);
>>>  	struct efa_qp *qp = to_eqp(ibqp);
>>>  	int err;
>>>
>>>  	ibdev_dbg(&dev->ibdev, "Destroy qp[%u]\n", ibqp->qp_num);
>>> +
>>> +	efa_qp_user_mmap_entries_remove(ucontext, qp);
>>> +
>>>  	err = efa_destroy_qp_handle(dev, qp->qp_handle);
>>>  	if (err)
>>>  		return err;
>>> @@ -509,57 +412,114 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct
>> ib_udata *udata)
>>>  	return 0;
>>>  }
>>>
>>>  void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)  {
>>> +	struct efa_ucontext *ucontext =
>> rdma_udata_to_drv_context(udata,
>>> +			struct efa_ucontext, ibucontext);
>>> +
>>>  	struct efa_dev *dev = to_edev(ibcq->device);
>>>  	struct efa_cq *cq = to_ecq(ibcq);
>>>
>>> @@ -897,17 +862,28 @@ void efa_destroy_cq(struct ib_cq *ibcq, struct
>> ib_udata *udata)
>>>  	efa_destroy_cq_idx(dev, cq->cq_idx);
>>>  	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
>>>  			 DMA_FROM_DEVICE);
>>> +	rdma_user_mmap_entry_remove(&ucontext->ibucontext,
>>> +				    cq->mmap_key);
>>
>> How come in destroy_qp we do entry removal first, but in destroy_cq it's
>> last?
>> Shouldn't it be the same?
> Yes, you're right, it should be done after memory is unmapped, I'll move it down
> In the destroy qp flow. Is this the only comment on this series ? 

Other than that the patch looks good to me,
Acked-by: Gal Pressman <galpress@amazon.com>

A few nits (feel free to ignore):
* The rdma_user_mmap_entry is always referred to as rdma_entry except in
efa_mmap_free declaration and to_emmap.
* efa_qp_user_mmap_entries_remove isn't really in reverse insertion order but OK :).
* In case of length mismatch in __efa_mmap two error messages are printed,
consider keeping the "Couldn't mmap address ..." print in the if (not part of
the goto label).

Thanks for doing this!
