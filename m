Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F7D1E4360
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 15:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725267AbgE0NTA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 09:19:00 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44577 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730270AbgE0NS6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 09:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590585537; x=1622121537;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=aL2VtrysRQmmZsITosVkkV3mNcShsiLr8kEVg8JPsWY=;
  b=ICJd61NZR99mznIXaIrNAViMGOLXIjCHEJNkAdYMaNw5paLUPnyM9SDL
   8DLQc8FYcy8+j7npR3jTKDjr4ZnED7rku2yMEGpNKeWJZtiw4pevJ+i8c
   q2B4lKdWuYyFctkketEKU4FpOyTc8fnLhz9h+da6yEohpqQQ6xVq4G9Bn
   4=;
IronPort-SDR: 20apxnyaH0liuFuc6E74EUk5BRCWQM1r3w1PqX2pJeWz0VcuW3YcSotSIJccrO6rNRP2S8kYg5
 LntVBBgPg35A==
X-IronPort-AV: E=Sophos;i="5.73,441,1583193600"; 
   d="scan'208";a="32589545"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 27 May 2020 13:18:42 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id EE9EC1416B5;
        Wed, 27 May 2020 13:18:40 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 27 May 2020 13:18:40 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.180) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 27 May 2020 13:18:36 +0000
Subject: Re: Issue in "Introduce create/destroy QP commands over ioctl"?
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>,
        "Leybovich, Yossi" <sleybo@amazon.com>
References: <948a84a4-a8f7-5554-111a-4b191ed0344b@amazon.com>
 <20200527125301.GP744@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <2d635709-1868-e829-e27e-3fff1a7f47aa@amazon.com>
Date:   Wed, 27 May 2020 16:18:30 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527125301.GP744@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D43UWC001.ant.amazon.com (10.43.162.69) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/05/2020 15:53, Jason Gunthorpe wrote:
> On Wed, May 27, 2020 at 03:34:33PM +0300, Gal Pressman wrote:
>> Hi,
>>
>> The recent transition of create/destroy QP commands to ioctl broke the EFA
>> provider in [1].
>> With the new ioctl the 'ibv_resp' part of the response is all zero'd, opposed to
>> the write method.
> 
> It is a bug in the efa provider. It is not allowed to touch the
> 'ibv_resp' parts of the structure from a provider.

Thanks Jason, I did not know that.

> Something like this
> 
> diff --git a/providers/efa/verbs.c b/providers/efa/verbs.c
> index 5f8e7b800210bb..92bb7432a92a2b 100644
> --- a/providers/efa/verbs.c
> +++ b/providers/efa/verbs.c
> @@ -541,7 +541,9 @@ static void efa_sq_terminate(struct efa_qp *qp)
>  	efa_wq_terminate(&qp->sq.wq);
>  }
>  
> -static int efa_sq_initialize(struct efa_qp *qp, struct efa_create_qp_resp *resp)
> +static int efa_sq_initialize(struct efa_qp *qp,
> +			     const struct ibv_qp_init_attr_ex *attr,
> +			     struct efa_create_qp_resp *resp)
>  {
>  	struct efa_dev *dev = to_efa_dev(qp->verbs_qp.qp.context->device);
>  	size_t desc_ring_size;
> @@ -559,7 +561,7 @@ static int efa_sq_initialize(struct efa_qp *qp, struct efa_create_qp_resp *resp)
>  	desc_ring_size = qp->sq.wq.wqe_cnt * sizeof(struct efa_io_tx_wqe);
>  	qp->sq.desc_ring_mmap_size = align(desc_ring_size + qp->sq.desc_offset,
>  					   qp->page_size);
> -	qp->sq.max_inline_data = resp->ibv_resp.max_inline_data;
> +	qp->sq.max_inline_data = attr->cap.max_inline_data;
>  
>  	qp->sq.local_queue = malloc(desc_ring_size);
>  	if (!qp->sq.local_queue) {
> @@ -840,7 +842,7 @@ static struct ibv_qp *create_qp(struct ibv_context *ibvctx,
>  	if (err)
>  		goto err_destroy_qp;
>  
> -	err = efa_sq_initialize(qp, &resp);
> +	err = efa_sq_initialize(qp, attr, &resp);
>  	if (err)
>  		goto err_terminate_rq;
>  
> 

I'll send a PR.
