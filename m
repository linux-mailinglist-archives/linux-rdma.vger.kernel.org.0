Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B522B68C
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 15:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfE0NjA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 09:39:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46928 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726668AbfE0NjA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 May 2019 09:39:00 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 777592117F9CD32A84FA;
        Mon, 27 May 2019 21:38:56 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 27 May 2019
 21:38:45 +0800
Subject: Re: [PATCH for-next 2/3] RDMA/hns: add a group interfaces for
 optimizing buffers getting flow
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1558777808-93864-1-git-send-email-oulijun@huawei.com>
 <1558777808-93864-3-git-send-email-oulijun@huawei.com>
 <20190527120718.GB8519@ziepe.ca>
From:   oulijun <oulijun@huawei.com>
Message-ID: <2a44c00f-c74e-41e8-aca6-843fdf95a2bd@huawei.com>
Date:   Mon, 27 May 2019 21:38:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20190527120718.GB8519@ziepe.ca>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ÔÚ 2019/5/27 20:07, Jason Gunthorpe Ð´µÀ:
> On Sat, May 25, 2019 at 05:50:07PM +0800, Lijun Ou wrote:
>> Currently, the code for getting umem and kmem buffers exist many files,
>> this patch adds a group interfaces to simplify the buffers getting flow.
>>
>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>> Signed-off-by: Lijun Ou <oulijun@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_alloc.c  | 131 ++++++++++++++++++++++++++++
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  12 +++
>>  2 files changed, 143 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
>> index dac058d..7a08064 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
>> @@ -34,6 +34,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/vmalloc.h>
>>  #include "hns_roce_device.h"
>> +#include <rdma/ib_umem.h>
>>  
>>  int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj)
>>  {
>> @@ -238,6 +239,136 @@ int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
>>  	return -ENOMEM;
>>  }
>>  
>> +int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
>> +			   int buf_cnt, int start, struct hns_roce_buf *buf)
>> +{
>> +	int i, end;
>> +	int total;
>> +
>> +	end = start + buf_cnt;
>> +	if (end > buf->npages) {
>> +		dev_err(hr_dev->dev,
>> +			"invalid kmem region,offset %d,buf_cnt %d,total %d!\n",
>> +			start, buf_cnt, buf->npages);
>> +		return -EINVAL;
>> +	}
>> +
>> +	total = 0;
>> +	for (i = start; i < end; i++)
>> +		if (buf->nbufs == 1)
>> +			bufs[total++] = buf->direct.map +
>> +					(i << buf->page_shift);
>> +		else
>> +			bufs[total++] = buf->page_list[i].map;
>> +
>> +	return total;
>> +}
>> +
>> +int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
>> +			   int buf_cnt, int start, struct ib_umem *umem,
>> +			   int page_shift)
>> +{
>> +	struct scatterlist *sg;
>> +	int npage_per_buf;
>> +	int npage_per_sg;
>> +	dma_addr_t addr;
>> +	int n, entry;
>> +	int idx, end;
>> +	int npage;
>> +	int total;
>> +
>> +	if (page_shift < PAGE_SHIFT || page_shift > umem->page_shift) {
>> +		dev_err(hr_dev->dev, "invalid page shift %d, umem shift %d!\n",
>> +			page_shift, umem->page_shift);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* convert system page cnt to hw page cnt */
>> +	npage_per_buf = (1 << (page_shift - PAGE_SHIFT));
>> +	total = DIV_ROUND_UP(ib_umem_page_count(umem), npage_per_buf);
>> +	end = start + buf_cnt;
>> +	if (end > total) {
>> +		dev_err(hr_dev->dev,
>> +			"invalid umem region,offset %d,buf_cnt %d,total %d!\n",
>> +			start, buf_cnt, total);
>> +		return -EINVAL;
>> +	}
>> +
>> +	idx = 0;
>> +	npage = 0;
>> +	total = 0;
>> +	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, entry) {
> You should convert this driver to use the new APIs, see something like
>
> commit eb52c0333f06b88bca5bac0dc0aeca729de6eb11
> Author: Shiraz Saleem <shiraz.saleem@intel.com>
> Date:   Mon May 6 08:53:34 2019 -0500
>
>     RDMA/i40iw: Use core helpers to get aligned DMA address within a supported page size
>     
>     Call the core helpers to retrieve the HW aligned address to use for the
>     MR, within a supported i40iw page size.
>     
>     Remove code in i40iw to determine when MR is backed by 2M huge pages which
>     involves checking the umem->hugetlb flag and VMA inspection.  The new DMA
>     iterator will return the 2M aligned address if the MR is backed by 2M
>     pages.
>     
>     Fixes: f26c7c83395b ("i40iw: Add 2MB page support")
>     Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>     Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
>     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>
>
Thanks. We will fix it and send the V2.
>> +		npage_per_sg = sg_dma_len(sg) >> PAGE_SHIFT;
>> +		for (n = 0; n < npage_per_sg; n++) {
>> +			if (!(npage % npage_per_buf)) {
>> +				addr = sg_dma_address(sg) +
>> +					(n << umem->page_shift);
> No new references to umem->page_shift, this won't apply.
>
> Jason
>
> .
>


