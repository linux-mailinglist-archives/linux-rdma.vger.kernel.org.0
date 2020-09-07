Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308A225F4B4
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 10:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgIGIMC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 7 Sep 2020 04:12:02 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728054AbgIGIMB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 04:12:01 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 60A1D63C5C299EA0583A;
        Mon,  7 Sep 2020 16:11:55 +0800 (CST)
Received: from dggemi711-chm.china.huawei.com (10.3.20.110) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 7 Sep 2020 16:11:55 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemi711-chm.china.huawei.com (10.3.20.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 7 Sep 2020 16:11:54 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Mon, 7 Sep 2020 16:11:54 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        "Huwei (Xavier)" <xavier.huwei@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        oulijun <oulijun@huawei.com>
Subject: Re: [PATCH v2 12/17] RDMA/hns: Use ib_umem_num_dma_blocks() instead
 of opencoding
Thread-Topic: [PATCH v2 12/17] RDMA/hns: Use ib_umem_num_dma_blocks() instead
 of opencoding
Thread-Index: AQHWgwypFlejl7L8mkGmitUIXL1wBg==
Date:   Mon, 7 Sep 2020 08:11:54 +0000
Message-ID: <d0aea0dfb6154838bfded3eeacb22221@huawei.com>
References: <12-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/9/5 6:42, Jason Gunthorpe wrote:
> mtr_umem_page_count() does the same thing, replace it with the core code.
> 
> Also, ib_umem_find_best_pgsz() should always be called to check that the
> umem meets the page_size requirement. If there is a limited set of
> page_sizes that work it the pgsz_bitmap should be set to that set. 0 is a
> failure and the umem cannot be used.
> 
> Lightly tidy the control flow to implement this flow properly.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_mr.c | 49 ++++++++++---------------
>  1 file changed, 19 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index e5df3884b41dda..16699f6bb03a51 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -707,19 +707,6 @@ static inline size_t mtr_bufs_size(struct hns_roce_buf_attr *attr)
>  	return size;
>  }
>  
> -static inline int mtr_umem_page_count(struct ib_umem *umem,
> -				      unsigned int page_shift)
> -{
> -	int count = ib_umem_page_count(umem);
> -
> -	if (page_shift >= PAGE_SHIFT)
> -		count >>= page_shift - PAGE_SHIFT;
> -	else
> -		count <<= PAGE_SHIFT - page_shift;
> -
> -	return count;
> -}
> -
>  static inline size_t mtr_kmem_direct_size(bool is_direct, size_t alloc_size,
>  					  unsigned int page_shift)
>  {
> @@ -767,12 +754,10 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
>  			  struct ib_udata *udata, unsigned long user_addr)
>  {
>  	struct ib_device *ibdev = &hr_dev->ib_dev;
> -	unsigned int max_pg_shift = buf_attr->page_shift;
> -	unsigned int best_pg_shift = 0;
> +	unsigned int best_pg_shift;
>  	int all_pg_count = 0;
>  	size_t direct_size;
>  	size_t total_size;
> -	unsigned long tmp;
>  	int ret = 0;
>  
>  	total_size = mtr_bufs_size(buf_attr);
> @@ -782,6 +767,9 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
>  	}
>  
>  	if (udata) {
> +		unsigned long pgsz_bitmap;
> +		unsigned long page_size;
> +
>  		mtr->kmem = NULL;
>  		mtr->umem = ib_umem_get(ibdev, user_addr, total_size,
>  					buf_attr->user_access);
> @@ -790,15 +778,17 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
>  				  PTR_ERR(mtr->umem));
>  			return -ENOMEM;
>  		}
> -		if (buf_attr->fixed_page) {
> -			best_pg_shift = max_pg_shift;
> -		} else {
> -			tmp = GENMASK(max_pg_shift, 0);
> -			ret = ib_umem_find_best_pgsz(mtr->umem, tmp, user_addr);
> -			best_pg_shift = (ret <= PAGE_SIZE) ?
> -					PAGE_SHIFT : ilog2(ret);
> -		}
> -		all_pg_count = mtr_umem_page_count(mtr->umem, best_pg_shift);
> +		if (buf_attr->fixed_page)
> +			pgsz_bitmap = 1 << buf_attr->page_shift;
> +		else
> +			pgsz_bitmap = GENMASK(buf_attr->page_shift, PAGE_SHIFT);
> +
> +		page_size = ib_umem_find_best_pgsz(mtr->umem, pgsz_bitmap,
> +						   user_addr);
> +		if (!page_size)
> +			return -EINVAL;
> +		best_pg_shift = order_base_2(page_size);
> +		all_pg_count = ib_umem_num_dma_blocks(mtr->umem, page_size);
>  		ret = 0;
>  	} else {
>  		mtr->umem = NULL;
> @@ -808,16 +798,15 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
>  			return -ENOMEM;
>  		}
>  		direct_size = mtr_kmem_direct_size(is_direct, total_size,
> -						   max_pg_shift);
> +						   buf_attr->page_shift);
>  		ret = hns_roce_buf_alloc(hr_dev, total_size, direct_size,
> -					 mtr->kmem, max_pg_shift);
> +					 mtr->kmem, buf_attr->page_shift);
>  		if (ret) {
>  			ibdev_err(ibdev, "Failed to alloc kmem, ret %d\n", ret);
>  			goto err_alloc_mem;
> -		} else {
> -			best_pg_shift = max_pg_shift;
> -			all_pg_count = mtr->kmem->npages;
>  		}
> +		best_pg_shift = buf_attr->page_shift;
> +		all_pg_count = mtr->kmem->npages;
>  	}
>  
>  	/* must bigger than minimum hardware page shift */
> 

Thanks

Acked-by: Weihang Li <liweihang@huawei.com>
