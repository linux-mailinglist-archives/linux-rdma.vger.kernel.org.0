Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1098360E79
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jul 2019 04:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfGFBr1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Jul 2019 21:47:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfGFBr1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 5 Jul 2019 21:47:27 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E0754A215B055AB3337A;
        Sat,  6 Jul 2019 09:47:24 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Sat, 6 Jul 2019
 09:47:14 +0800
Subject: Re: [PATCH for-next 5/8] RDMA/hns: Bugfix for calculating qp buffer
 size
From:   oulijun <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1561376872-111496-1-git-send-email-oulijun@huawei.com>
 <1561376872-111496-6-git-send-email-oulijun@huawei.com>
Message-ID: <997bdd68-8be1-9684-5d4d-d0b5bf202b80@huawei.com>
Date:   Sat, 6 Jul 2019 09:47:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <1561376872-111496-6-git-send-email-oulijun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/6/24 19:47, Lijun Ou 写道:
> From: o00290482 <o00290482@huawei.com>
Hi, Jason
   May be my local configuration error causing the wroong author.  How should I make changes?

The correct as follows:
From: Lijun Ou <oulijun@huawei.com>
> The buffer size of qp which used to allocate qp buffer space for
> storing sqwqe and rqwqe will be the length of buffer space. The
> kernel driver will use the buffer address and the same size to
> get the user memory. The same size named buff_size of qp. According
> the algorithm of calculating, The size of the two is not equal
> when users set the max sge of sq.
>
> Fixes: b28ca7cceff8 ("RDMA/hns: Limit extend sq sge num")
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index 305be42..d56c03d 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -392,8 +392,8 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
>  					     hr_qp->sq.wqe_shift), PAGE_SIZE);
>  	} else {
>  		page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
> -		hr_qp->sge.sge_cnt =
> -		       max(page_size / (1 << hr_qp->sge.sge_shift), ex_sge_num);
> +		hr_qp->sge.sge_cnt = ex_sge_num ?
> +		   max(page_size / (1 << hr_qp->sge.sge_shift), ex_sge_num) : 0;
>  		hr_qp->buff_size = HNS_ROCE_ALOGN_UP((hr_qp->rq.wqe_cnt <<
>  					     hr_qp->rq.wqe_shift), page_size) +
>  				   HNS_ROCE_ALOGN_UP((hr_qp->sge.sge_cnt <<



