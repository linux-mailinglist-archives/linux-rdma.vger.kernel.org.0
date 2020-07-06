Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDA321539B
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 09:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGFH7Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 03:59:25 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:61737 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgGFH7Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 03:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594022365; x=1625558365;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=JTPyaHr8fmDcScbt/jPcAHUdzao0iGidQOS2ck6ARPA=;
  b=B/AWPkLzYqXkXy64YCXuVn9i2z7AwUXwGE/evv3TZLKk8fQ3VykFfmbh
   SjwcgUZ+ttKe1TDHvpt0+Nk+CvKKC2zf8KtELqzvrNH5Ez/B0GNMOp5AQ
   odXzmkzgCrOZ/5CHwDFu1je9erryt+zNPzkpkc0L62USp0Xm03cCGhLO3
   s=;
IronPort-SDR: IjgpeUlJM9+hZ3ryUVmOq58H7C1xONpU4iNU3hxhLnmGyo4BjPoSudmLPrxP8MslePV1j/OCPl
 RRbthuTLCosA==
X-IronPort-AV: E=Sophos;i="5.75,318,1589241600"; 
   d="scan'208";a="57537603"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 06 Jul 2020 07:59:23 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id A5773A00CD;
        Mon,  6 Jul 2020 07:59:21 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 07:59:21 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.100) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 07:59:17 +0000
Subject: Re: [PATCH for-next 2/5] RDMA/efa: Set max_pkeys attribute
To:     Kamal Heib <kamalheib1@gmail.com>, <linux-rdma@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
References: <20200706075419.361484-1-kamalheib1@gmail.com>
 <20200706075419.361484-3-kamalheib1@gmail.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <864f9e35-5223-db52-1c6e-ac1b2a4079ed@amazon.com>
Date:   Mon, 6 Jul 2020 10:58:34 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706075419.361484-3-kamalheib1@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D32UWA003.ant.amazon.com (10.43.160.167) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 06/07/2020 10:54, Kamal Heib wrote:
> Make sure to set the max_pkeys attribute to indicate the maximum number
> of partitions supported by the efa device.
> 
> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Cc: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 08313f7c73bc..7dd082441333 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -212,6 +212,7 @@ int efa_query_device(struct ib_device *ibdev,
>  	props->max_send_sge = dev_attr->max_sq_sge;
>  	props->max_recv_sge = dev_attr->max_rq_sge;
>  	props->max_sge_rd = dev_attr->max_wr_rdma_sge;
> +	props->max_pkeys = 1;
>  
>  	if (udata && udata->outlen) {
>  		resp.max_sq_sge = dev_attr->max_sq_sge;
> 

Thanks Kamal, a similar patch was already merged:
f25022a53ef3 ("RDMA/efa: Set maximum pkeys device attribute")
