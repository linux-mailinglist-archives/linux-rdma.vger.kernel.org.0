Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04D02B46B
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 14:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfE0MHV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 08:07:21 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38876 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfE0MHV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 08:07:21 -0400
Received: by mail-qk1-f195.google.com with SMTP id p26so14929467qkj.5
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 05:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X5+W2fww7Xv52pujiVpkW311+QFFfBgmSuq5pTrXETU=;
        b=YPmdM5eMCU1UslD6Nph6F4rxHmBdxvjjomPDRr9WekdxuxDLE4yw96xccM9GYaPZfj
         hlmm/sxIdFGmLeDT/Yp1yq7w+UWHeu41xUDdL9YKpzcZ5rw7Gf7RCYLw6vrylFfKKUII
         foUnTRMEBRNMUWZRSZntH/qzq0j++CP/JTzEjK+BhMN+bfIwSDfB72JYEls8KgAK+i2G
         veZUHrNGO3SDbDgIdCOyktTxR3pdeCN/ExWqtGfZd//sVh/mkeX8txohCzua9oUa52Ib
         XbuuqcOfhIh1R9/E4WFyQeBIof8Xl80SMkAsoc/3cH0FJgeqo5SufJYlvuvV22vGR7ON
         qSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X5+W2fww7Xv52pujiVpkW311+QFFfBgmSuq5pTrXETU=;
        b=RTzY7vv0SQtTbg3zO9DH0KTojv1H/xkRHStz/EaNVsot74JUloARDmw2O7ExZsOXsc
         bXShM/d8BTpRy7AeoXRf0lGvJ1WRBEYyxwTKPllD7bc0qd/CatWs2caeSPBcLerJ/pS0
         I4yQB9nrkozb0VnXf68zE8a+jqI3W5l0a82VD/UBz7omTND0kr+F5TvCF0pfMLTBrwb3
         lRbvy3lIiRTMxuR90t2bhGd7CM40a5IKcDtNfDl8VUVqafo/dwz/5W0x21FOMi/fiRe+
         mhH+j4C5e/KUdqW6ijC1A8v+adwqJdYHjpoROWaiCYxV+BPy+cs3ju+8SM4NhTir4Xja
         WoiA==
X-Gm-Message-State: APjAAAUZkwEAbl0xdIkB/sEMIFtFANrAvGzGtCDn6pXqnNmVA8McLmnu
        oVij70L9E/LYQMfJHLFJ+7OW9g==
X-Google-Smtp-Source: APXvYqxWF9urSulXGBZfaKidBlnuEpTk5fC2ufSo8MUC1lgDq8nsxHmoHb4xPQhdHlDTfpl0oy/UlQ==
X-Received: by 2002:a37:4f10:: with SMTP id d16mr72839650qkb.71.1558958839996;
        Mon, 27 May 2019 05:07:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id h128sm4208098qkc.27.2019.05.27.05.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 05:07:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVEPO-0003XR-4Z; Mon, 27 May 2019 09:07:18 -0300
Date:   Mon, 27 May 2019 09:07:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 2/3] RDMA/hns: add a group interfaces for
 optimizing buffers getting flow
Message-ID: <20190527120718.GB8519@ziepe.ca>
References: <1558777808-93864-1-git-send-email-oulijun@huawei.com>
 <1558777808-93864-3-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558777808-93864-3-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 25, 2019 at 05:50:07PM +0800, Lijun Ou wrote:
> Currently, the code for getting umem and kmem buffers exist many files,
> this patch adds a group interfaces to simplify the buffers getting flow.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_alloc.c  | 131 ++++++++++++++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_device.h |  12 +++
>  2 files changed, 143 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
> index dac058d..7a08064 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
> @@ -34,6 +34,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/vmalloc.h>
>  #include "hns_roce_device.h"
> +#include <rdma/ib_umem.h>
>  
>  int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj)
>  {
> @@ -238,6 +239,136 @@ int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
>  	return -ENOMEM;
>  }
>  
> +int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
> +			   int buf_cnt, int start, struct hns_roce_buf *buf)
> +{
> +	int i, end;
> +	int total;
> +
> +	end = start + buf_cnt;
> +	if (end > buf->npages) {
> +		dev_err(hr_dev->dev,
> +			"invalid kmem region,offset %d,buf_cnt %d,total %d!\n",
> +			start, buf_cnt, buf->npages);
> +		return -EINVAL;
> +	}
> +
> +	total = 0;
> +	for (i = start; i < end; i++)
> +		if (buf->nbufs == 1)
> +			bufs[total++] = buf->direct.map +
> +					(i << buf->page_shift);
> +		else
> +			bufs[total++] = buf->page_list[i].map;
> +
> +	return total;
> +}
> +
> +int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
> +			   int buf_cnt, int start, struct ib_umem *umem,
> +			   int page_shift)
> +{
> +	struct scatterlist *sg;
> +	int npage_per_buf;
> +	int npage_per_sg;
> +	dma_addr_t addr;
> +	int n, entry;
> +	int idx, end;
> +	int npage;
> +	int total;
> +
> +	if (page_shift < PAGE_SHIFT || page_shift > umem->page_shift) {
> +		dev_err(hr_dev->dev, "invalid page shift %d, umem shift %d!\n",
> +			page_shift, umem->page_shift);
> +		return -EINVAL;
> +	}
> +
> +	/* convert system page cnt to hw page cnt */
> +	npage_per_buf = (1 << (page_shift - PAGE_SHIFT));
> +	total = DIV_ROUND_UP(ib_umem_page_count(umem), npage_per_buf);
> +	end = start + buf_cnt;
> +	if (end > total) {
> +		dev_err(hr_dev->dev,
> +			"invalid umem region,offset %d,buf_cnt %d,total %d!\n",
> +			start, buf_cnt, total);
> +		return -EINVAL;
> +	}
> +
> +	idx = 0;
> +	npage = 0;
> +	total = 0;
> +	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, entry) {

You should convert this driver to use the new APIs, see something like

commit eb52c0333f06b88bca5bac0dc0aeca729de6eb11
Author: Shiraz Saleem <shiraz.saleem@intel.com>
Date:   Mon May 6 08:53:34 2019 -0500

    RDMA/i40iw: Use core helpers to get aligned DMA address within a supported page size
    
    Call the core helpers to retrieve the HW aligned address to use for the
    MR, within a supported i40iw page size.
    
    Remove code in i40iw to determine when MR is backed by 2M huge pages which
    involves checking the umem->hugetlb flag and VMA inspection.  The new DMA
    iterator will return the 2M aligned address if the MR is backed by 2M
    pages.
    
    Fixes: f26c7c83395b ("i40iw: Add 2MB page support")
    Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
    Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>



> +		npage_per_sg = sg_dma_len(sg) >> PAGE_SHIFT;
> +		for (n = 0; n < npage_per_sg; n++) {
> +			if (!(npage % npage_per_buf)) {
> +				addr = sg_dma_address(sg) +
> +					(n << umem->page_shift);

No new references to umem->page_shift, this won't apply.

Jason
