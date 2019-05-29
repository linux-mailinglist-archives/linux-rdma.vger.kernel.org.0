Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B652E2B8
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 19:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfE2RBS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 29 May 2019 13:01:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:37439 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfE2RBS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 May 2019 13:01:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 10:01:17 -0700
X-ExtLoop1: 1
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga005.jf.intel.com with ESMTP; 29 May 2019 10:01:17 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 29 May 2019 10:01:16 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.29]) by
 FMSMSX102.amr.corp.intel.com ([169.254.10.170]) with mapi id 14.03.0415.000;
 Wed, 29 May 2019 10:01:16 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Doug Ledford" <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Firas JahJah <firasj@amazon.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: RE: [PATCH for-rc 4/6] RDMA/efa: Use API to get contiguous memory
 blocks aligned to device supported page size
Thread-Topic: [PATCH for-rc 4/6] RDMA/efa: Use API to get contiguous memory
 blocks aligned to device supported page size
Thread-Index: AQHVFVN3lHBhqcKgs0S/UVTrJ3hegqaCVIBA
Date:   Wed, 29 May 2019 17:01:15 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A5B07A27@fmsmsx124.amr.corp.intel.com>
References: <20190528124618.77918-1-galpress@amazon.com>
 <20190528124618.77918-5-galpress@amazon.com>
In-Reply-To: <20190528124618.77918-5-galpress@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDUxOWViMmUtMDk5Ny00ZGJhLWFkMjQtMjIwYWQ5NzFmMGU0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMnhkVXVselBLN1A2OFpkWHNXMUJaUVhPMkZnUUNzam44TjJWRWRsc0U4eXJ2cEJHbFhET0RyaHpBTk1IMEhhUiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH for-rc 4/6] RDMA/efa: Use API to get contiguous memory blocks
> aligned to device supported page size
> 
> Use the ib_umem_find_best_pgsz() and rdma_for_each_block() API when
> registering an MR instead of coding it in the driver.
> 
> ib_umem_find_best_pgsz() is used to find the best suitable page size which
> replaces the existing efa_cont_pages() implementation.
> rdma_for_each_block() is used to iterate the umem in aligned contiguous memory
> blocks.
> 
> Cc: Shiraz Saleem <shiraz.saleem@intel.com>
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 81 +++++----------------------
>  1 file changed, 14 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c
> b/drivers/infiniband/hw/efa/efa_verbs.c
> index 0640c2435f67..c1246c39f234 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -1054,21 +1054,15 @@ static int umem_to_page_list(struct efa_dev *dev,
>  			     u8 hp_shift)
>  {
>  	u32 pages_in_hp = BIT(hp_shift - PAGE_SHIFT);
> -	struct sg_dma_page_iter sg_iter;
> -	unsigned int page_idx = 0;
> +	struct ib_block_iter biter;
>  	unsigned int hp_idx = 0;
> 
>  	ibdev_dbg(&dev->ibdev, "hp_cnt[%u], pages_in_hp[%u]\n",
>  		  hp_cnt, pages_in_hp);
> 
> -	for_each_sg_dma_page(umem->sg_head.sgl, &sg_iter, umem->nmap, 0)
> {
> -		if (page_idx % pages_in_hp == 0) {
> -			page_list[hp_idx] = sg_page_iter_dma_address(&sg_iter);
> -			hp_idx++;
> -		}
> -
> -		page_idx++;
> -	}
> +	rdma_for_each_block(umem->sg_head.sgl, &biter, umem->nmap,
> +			    BIT(hp_shift))
> +		page_list[hp_idx++] = rdma_block_iter_dma_address(&biter);
> 
>  	return 0;
>  }
> @@ -1402,56 +1396,6 @@ static int efa_create_pbl(struct efa_dev *dev,
>  	return 0;
>  }
> 
> -static void efa_cont_pages(struct ib_umem *umem, u64 addr,
> -			   unsigned long max_page_shift,
> -			   int *count, u8 *shift, u32 *ncont)
> -{
> -	struct scatterlist *sg;
> -	u64 base = ~0, p = 0;
> -	unsigned long tmp;
> -	unsigned long m;
> -	u64 len, pfn;
> -	int i = 0;
> -	int entry;
> -
> -	addr = addr >> PAGE_SHIFT;
> -	tmp = (unsigned long)addr;
> -	m = find_first_bit(&tmp, BITS_PER_LONG);
> -	if (max_page_shift)
> -		m = min_t(unsigned long, max_page_shift - PAGE_SHIFT, m);
> -
> -	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, entry) {
> -		len = DIV_ROUND_UP(sg_dma_len(sg), PAGE_SIZE);
> -		pfn = sg_dma_address(sg) >> PAGE_SHIFT;
> -		if (base + p != pfn) {
> -			/*
> -			 * If either the offset or the new
> -			 * base are unaligned update m
> -			 */
> -			tmp = (unsigned long)(pfn | p);
> -			if (!IS_ALIGNED(tmp, 1 << m))
> -				m = find_first_bit(&tmp, BITS_PER_LONG);
> -
> -			base = pfn;
> -			p = 0;
> -		}
> -
> -		p += len;
> -		i += len;
> -	}
> -
> -	if (i) {
> -		m = min_t(unsigned long, ilog2(roundup_pow_of_two(i)), m);
> -		*ncont = DIV_ROUND_UP(i, (1 << m));
> -	} else {
> -		m = 0;
> -		*ncont = 0;
> -	}
> -
> -	*shift = PAGE_SHIFT + m;
> -	*count = i;
> -}
> -

Leon - perhaps mlx5_ib_cont_pages() can also be replaced with the new core helper?

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
