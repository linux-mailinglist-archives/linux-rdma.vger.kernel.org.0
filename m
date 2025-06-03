Return-Path: <linux-rdma+bounces-10932-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4F8ACBE6E
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jun 2025 04:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD7C7A8D38
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jun 2025 02:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1EA1FDD;
	Tue,  3 Jun 2025 02:16:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F243C173
	for <linux-rdma@vger.kernel.org>; Tue,  3 Jun 2025 02:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748916995; cv=none; b=DQ8Tq7nhxyQfTOOO7GSXtgBuzkxt7x054baayA0MRnzLu9qC6bi0rzosB0mf776WmOwVHlIb00l6htuDfzwBvvwqoJPyOLuibbPUU6Yzm3Bo8aVbfFdJ7jt8/gQ02LF4QMzFk7mCRf1bzbeEobd8XlcLxGxKpdoYp+Y6DQGfiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748916995; c=relaxed/simple;
	bh=ueWyLGY4Qg3BBwCXYQnCTUGhFhsRjrHTeGsnfFfQHRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gGWgSyKYMDoucARX4JRv5/iVkiKVln5Ht0NFxaqN4vG2g9ICHA4J0JmgZ8UgHnRhS42/eDiQMBd7xCYXP6+bxzZzVs89uAG2O/Xvxf1Wndm5DZr04x6vpsgT/rE8aV5qxJk5NSY1+onm6Hb3QLUw/nSKLAQHiHHkeY1GdLi1+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bBDmM0yCdz1R850;
	Tue,  3 Jun 2025 10:14:11 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 012F41402C1;
	Tue,  3 Jun 2025 10:16:29 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Jun 2025 10:16:28 +0800
Message-ID: <bfa2366e-6876-ad51-ce07-fe98a46f7833@hisilicon.com>
Date: Tue, 3 Jun 2025 10:16:21 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] RDMA/hns: ZERO_OR_NULL_PTR macro overdetection
Content-Language: en-US
To: luoqing <l1138897701@163.com>
CC: <tangchengchang@huawei.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
	<luoqing@kylinos.cn>, linux-rdma <linux-rdma@vger.kernel.org>
References: <20250603015936.103600-1-l1138897701@163.com>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250603015936.103600-1-l1138897701@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/6/3 9:59, luoqing wrote:
> From: luoqing <luoqing@kylinos.cn>
> 
> sizeof(xx) these variable values' return values cannot be 0.
> For memory allocation requests of non-zero length,
> there is no need to check other return values;
> it is sufficient to only verify that it is not null.
> 
> Signed-off-by: luoqing <luoqing@kylinos.cn>

For future patches, please add RDMA maillist.

Thanks,
Reviewed-by: Junxian Huang <huangjunxian6@hisilicon.com>

> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
>  drivers/infiniband/hw/hns/hns_roce_qp.c    | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 160e8927d364..65884f63fc7c 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -2613,7 +2613,7 @@ static struct ib_pd *free_mr_init_pd(struct hns_roce_dev *hr_dev)
>  	struct ib_pd *pd;
>  
>  	hr_pd = kzalloc(sizeof(*hr_pd), GFP_KERNEL);
> -	if (ZERO_OR_NULL_PTR(hr_pd))
> +	if (!hr_pd)
>  		return NULL;
>  	pd = &hr_pd->ibpd;
>  	pd->device = ibdev;
> @@ -2644,7 +2644,7 @@ static struct ib_cq *free_mr_init_cq(struct hns_roce_dev *hr_dev)
>  	cq_init_attr.cqe = HNS_ROCE_FREE_MR_USED_CQE_NUM;
>  
>  	hr_cq = kzalloc(sizeof(*hr_cq), GFP_KERNEL);
> -	if (ZERO_OR_NULL_PTR(hr_cq))
> +	if (!hr_cq)
>  		return NULL;
>  
>  	cq = &hr_cq->ib_cq;
> @@ -2677,7 +2677,7 @@ static int free_mr_init_qp(struct hns_roce_dev *hr_dev, struct ib_cq *cq,
>  	int ret;
>  
>  	hr_qp = kzalloc(sizeof(*hr_qp), GFP_KERNEL);
> -	if (ZERO_OR_NULL_PTR(hr_qp))
> +	if (!hr_qp)
>  		return -ENOMEM;
>  
>  	qp = &hr_qp->ibqp;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index 9f376a2232b0..6ff1b8ce580c 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -1003,14 +1003,14 @@ static int alloc_kernel_wrid(struct hns_roce_dev *hr_dev,
>  	int ret;
>  
>  	sq_wrid = kcalloc(hr_qp->sq.wqe_cnt, sizeof(u64), GFP_KERNEL);
> -	if (ZERO_OR_NULL_PTR(sq_wrid)) {
> +	if (!sq_wrid) {
>  		ibdev_err(ibdev, "failed to alloc SQ wrid.\n");
>  		return -ENOMEM;
>  	}
>  
>  	if (hr_qp->rq.wqe_cnt) {
>  		rq_wrid = kcalloc(hr_qp->rq.wqe_cnt, sizeof(u64), GFP_KERNEL);
> -		if (ZERO_OR_NULL_PTR(rq_wrid)) {
> +		if (!rq_wrid) {
>  			ibdev_err(ibdev, "failed to alloc RQ wrid.\n");
>  			ret = -ENOMEM;
>  			goto err_sq;

