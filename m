Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC55941D382
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 08:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348254AbhI3GjE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 02:39:04 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:51624 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348034AbhI3GjB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 02:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1632983840; x=1664519840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L3MfTYk/nzne0QjEFXIXt5n/VY8O11I6D1+HqZ/8uTw=;
  b=A2NFOYsj3bsYfREK+Gz5EvJMdJcmNXnCK1XHIQhnI5xB1ycpXG9KZ5c1
   om3fALNGzC1MRLhQf7PI1/s6Xha31PffqrmX8VYhI2uDra3RNNsKTsi4L
   dOsqQLT6D5HjdFdDQ1/qBFt/84SzXd0aCRqEBpQzuayTyI09ZMkg3fONo
   M=;
X-IronPort-AV: E=Sophos;i="5.85,335,1624320000"; 
   d="scan'208";a="141151538"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-cb1ffea5.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 30 Sep 2021 06:37:11 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-cb1ffea5.us-west-2.amazon.com (Postfix) with ESMTPS id D90D460D38;
        Thu, 30 Sep 2021 06:37:10 +0000 (UTC)
Received: from [10.95.88.219] (10.43.160.106) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 30 Sep
 2021 06:37:05 +0000
Message-ID: <e93eb617-b8db-2774-f577-32ae9f874c34@amazon.com>
Date:   Thu, 30 Sep 2021 09:36:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH for-next v2] RDMA/efa: CQ notifications
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20210913120406.61745-1-galpress@amazon.com>
 <20210927230411.GA1590967@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
In-Reply-To: <20210927230411.GA1590967@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.106]
X-ClientProxiedBy: EX13D24UWA001.ant.amazon.com (10.43.160.138) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 28/09/2021 2:04, Jason Gunthorpe wrote:
> On Mon, Sep 13, 2021 at 03:04:04PM +0300, Gal Pressman wrote:
> 
>> @@ -993,15 +1002,24 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>>  		  "Destroy cq[%d] virt[0x%p] freed: size[%lu], dma[%pad]\n",
>>  		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
>>  
>> -	rdma_user_mmap_entry_remove(cq->mmap_entry);
>> +	efa_cq_user_mmap_entries_remove(cq);
>>  	efa_destroy_cq_idx(dev, cq->cq_idx);
>> +	xa_erase(&dev->cqs_xa, cq->cq_idx);
>> +	if (cq->eq)
>> +		synchronize_irq(cq->eq->irq.irqn);
> 
> Why is this conditional? The whole thing should be conditional,
> including putting it in the XA in the first place if that is the
> intention
> 
> A comment on the xa_load would also be good to explain that it is safe
> because this must be a irq and snychronize_irq() manages lifetime

Will do, thanks.
