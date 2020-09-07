Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D1625FA60
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 14:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgIGMVH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 08:21:07 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:22934 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbgIGMUK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Sep 2020 08:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599481210; x=1631017210;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pHwdjcgcZ0MRsPOcO51Tb5RuzBtDKjL215nBXuSVSGw=;
  b=OjJXagDZ/x7kfBdrmmeK+6F2ViLtjci5TErFX42jtQlPxw+vXR/VWDtD
   rcC1yR2fKexfW2kjtoh9eBFbWLwq3xliNrGaKs/KhszV4a6B6K0uU+E+j
   /zcRmtKmb3IwbS+CtLHMcowEO/6VCZrCi3J9u1y+LwLacgKkoQ2AWOT2j
   s=;
X-IronPort-AV: E=Sophos;i="5.76,401,1592870400"; 
   d="scan'208";a="52309656"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 07 Sep 2020 12:20:09 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 8ADA5A24DA;
        Mon,  7 Sep 2020 12:20:06 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.34) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 7 Sep 2020 12:20:00 +0000
Subject: Re: [PATCH v2 07/17] RDMA/efa: Use ib_umem_num_dma_pages()
To:     Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Firas JahJah <firasj@amazon.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <7-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <d9cb7f02-86d0-25d6-1314-cc048fd1ebae@amazon.com>
Date:   Mon, 7 Sep 2020 15:19:54 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D39UWB001.ant.amazon.com (10.43.161.5) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/09/2020 1:41, Jason Gunthorpe wrote:
> If ib_umem_find_best_pgsz() returns > PAGE_SIZE then the equation here is
> not correct. 'start' should be 'virt'. Change it to use the core code for
> page_num and the canonical calculation of page_shift.

Should I submit a fix for stable changing start to virt?

> Fixes: 40ddb3f02083 ("RDMA/efa: Use API to get contiguous memory blocks aligned to device supported page size")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index d85c63a5021a70..72da0faa7ebf97 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/vmalloc.h>
> +#include <linux/log2.h>
>  
>  #include <rdma/ib_addr.h>
>  #include <rdma/ib_umem.h>
> @@ -1538,9 +1539,8 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
>  		goto err_unmap;
>  	}
>  
> -	params.page_shift = __ffs(pg_sz);
> -	params.page_num = DIV_ROUND_UP(length + (start & (pg_sz - 1)),
> -				       pg_sz);
> +	params.page_shift = order_base_2(pg_sz);

Not related to this patch, but indeed looks better :).

> +	params.page_num = ib_umem_num_dma_blocks(mr->umem, pg_sz);

Thanks,
Tested-by: Gal Pressman <galpress@amazon.com>
Acked-by: Gal Pressman <galpress@amazon.com>
