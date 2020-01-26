Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96281499A9
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 09:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgAZIgP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jan 2020 03:36:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10133 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727773AbgAZIgP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Jan 2020 03:36:15 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EB396E386D76991A3C04;
        Sun, 26 Jan 2020 16:36:12 +0800 (CST)
Received: from [127.0.0.1] (10.45.213.181) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Sun, 26 Jan 2020
 16:36:05 +0800
Subject: Re: [PATCH for-next 4/7] RDMA/hns: Optimize qp buffer allocation flow
To:     Leon Romanovsky <leon@kernel.org>
CC:     <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1579508377-55818-1-git-send-email-liweihang@huawei.com>
 <1579508377-55818-5-git-send-email-liweihang@huawei.com>
 <20200123143136.GO7018@unreal>
From:   Weihang Li <liweihang@huawei.com>
Message-ID: <61c73aa5-6f64-0dd4-1565-09cbe7264f9f@huawei.com>
Date:   Sun, 26 Jan 2020 16:35:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123143136.GO7018@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.213.181]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/1/23 22:31, Leon Romanovsky wrote:
> On Mon, Jan 20, 2020 at 04:19:34PM +0800, Weihang Li wrote:
>> From: Xi Wang <wangxi11@huawei.com>
>>
>> Encapsulate qp buffer allocation related code into 3 functions:
>> alloc_qp_buf(), map_qp_buf() and free_qp_buf().
>>
>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h |   1 -
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 268 +++++++++++++++-------------
>>  2 files changed, 147 insertions(+), 122 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index 1f361e6..9ddeb2b 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -660,7 +660,6 @@ struct hns_roce_qp {
>>  	/* this define must less than HNS_ROCE_MAX_BT_REGION */
>>  #define HNS_ROCE_WQE_REGION_MAX	 3
>>  	struct hns_roce_buf_region regions[HNS_ROCE_WQE_REGION_MAX];
>> -	int			region_cnt;
>>  	int                     wqe_bt_pg_shift;
>>
>>  	u32			buff_size;
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> index 3bd5809..5184cb4 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> @@ -716,23 +716,150 @@ static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
>>  	kfree(hr_qp->rq_inl_buf.wqe_list);
>>  }
>>
>> +static int map_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>> +		      u32 page_shift, bool is_user)
>> +{
>> +	dma_addr_t *buf_list[ARRAY_SIZE(hr_qp->regions)] = { NULL };
>> +	struct ib_device *ibdev = &hr_dev->ib_dev;
>> +	struct hns_roce_buf_region *r;
>> +	int region_count;
>> +	int buf_count;
>> +	int ret;
>> +	int i;
>> +
>> +	region_count = split_wqe_buf_region(hr_dev, hr_qp, hr_qp->regions,
>> +					ARRAY_SIZE(hr_qp->regions), page_shift);
>> +
>> +	/* alloc a tmp list for storing wqe buf address */
>> +	ret = hns_roce_alloc_buf_list(hr_qp->regions, buf_list, region_count);
>> +	if (ret) {
>> +		ibdev_err(ibdev, "alloc buf_list error for create qp\n");
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < region_count; i++) {
>> +		r = &hr_qp->regions[i];
>> +		if (is_user)
>> +			buf_count = hns_roce_get_umem_bufs(hr_dev, buf_list[i],
>> +					r->count, r->offset, hr_qp->umem,
>> +					page_shift);
>> +		else
>> +			buf_count = hns_roce_get_kmem_bufs(hr_dev, buf_list[i],
>> +					r->count, r->offset, &hr_qp->hr_buf);
>> +
>> +		if (buf_count != r->count) {
>> +			ibdev_err(ibdev, "get %s qp buf err,expect %d,ret %d.\n",
>> +				  is_user ? "user" : "kernel",
>> +				  r->count, buf_count);
>> +			ret = -ENOBUFS;
>> +			goto done;
>> +		}
>> +	}
>> +
>> +	hr_qp->wqe_bt_pg_shift = calc_wqe_bt_page_shift(hr_dev, hr_qp->regions,
>> +							region_count);
>> +	hns_roce_mtr_init(&hr_qp->mtr, PAGE_SHIFT + hr_qp->wqe_bt_pg_shift,
>> +			  page_shift);
>> +	ret = hns_roce_mtr_attach(hr_dev, &hr_qp->mtr, buf_list, hr_qp->regions,
>> +				  region_count);
>> +	if (ret)
>> +		ibdev_err(ibdev, "mtr attatch error for create qp\n");
>> +
>> +	goto done;
>> +
>> +	hns_roce_mtr_cleanup(hr_dev, &hr_qp->mtr);
>> +done:
>> +	hns_roce_free_buf_list(buf_list, region_count);
>> +
>> +	return ret;
>> +}
>> +
>> +static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>> +			struct ib_qp_init_attr *init_attr,
>> +			struct ib_udata *udata, unsigned long addr)
>> +{
>> +	u32 page_shift = PAGE_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
>> +	struct ib_device *ibdev = &hr_dev->ib_dev;
>> +	bool is_rq_buf_inline;
>> +	int ret;
>> +
>> +	is_rq_buf_inline = (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
>> +			   hns_roce_qp_has_rq(init_attr);
>> +	if (is_rq_buf_inline) {
>> +		ret = alloc_rq_inline_buf(hr_qp, init_attr);
>> +		if (ret) {
>> +			ibdev_err(ibdev, "alloc recv inline buffer error\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	if (udata) {
>> +		hr_qp->umem = ib_umem_get(udata, addr, hr_qp->buff_size, 0);
>> +		if (IS_ERR(hr_qp->umem)) {
>> +			ibdev_err(ibdev, "get umem error for qp buf\n");
>> +			ret = PTR_ERR(hr_qp->umem);
>> +			goto err_inline;
>> +		}
>> +	} else {
>> +		ret = hns_roce_buf_alloc(hr_dev, hr_qp->buff_size,
>> +					 (1 << page_shift) * 2,
>> +					 &hr_qp->hr_buf, page_shift);
>> +		if (ret) {
>> +			ibdev_err(ibdev, "alloc roce buf error\n");
>> +			goto err_inline;
>> +		}
>> +	}
>> +
>> +	ret = map_qp_buf(hr_dev, hr_qp, page_shift, udata);
> 
> 
> I don't remember what was the resolution if it is ok to rely on "udata"
> as an indicator of user/kernel flow.

Hi Leon,

Sorry for that I don't know much about previous discussions, will check for
that. Thanks for your reminder.


> 
>> +	if (ret) {
>> +		ibdev_err(ibdev, "map roce buf error\n");
> 
> You put ibdev_err() on almost every line in map_qp_buf(), please leave
> only one place.
> 
> Thanks
> 

OK, thank you.

Weihang

> .
> 

