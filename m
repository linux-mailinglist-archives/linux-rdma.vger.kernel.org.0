Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5541018278E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 04:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbgCLDzk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Mar 2020 23:55:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387688AbgCLDzk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Mar 2020 23:55:40 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DFF3C176A240744C9F82;
        Thu, 12 Mar 2020 11:55:34 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 12 Mar 2020
 11:55:28 +0800
Subject: Re: [PATCH v2 for-next] RDMA/hns: Support to set mininum depth of qp
 to 0
From:   Weihang Li <liweihang@huawei.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1583984536-19200-1-git-send-email-liweihang@huawei.com>
Message-ID: <5a30bef5-c2ec-a0d8-ea31-17601b1c2de7@huawei.com>
Date:   Thu, 12 Mar 2020 11:55:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583984536-19200-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sorry, I forgot to update the commit description, please ignore this version.

Weihang

On 2020/3/12 11:46, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Minimum depth of qp should be allowed to be set to 0 according to the
> firmware configuration. And when qp is changed from reset to reset, the
> capability of minimum qp depth was used to identify hardware of hip06,
> it should be changed into a more readable form.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Previous discussions can be found at:
> https://patchwork.kernel.org/patch/11415067/
> 
> Changes since v1:
> - Fix comments from Leon about calculation of max_cnt, check for qp's depth
>   and modification of the prints.
> - Optimize logic of codes to make them more readable.
> - Replace dev_err() with ibdev_err().
> 
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 77 ++++++++++++++-------------------
>  1 file changed, 33 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index 5a28d62..22d438b 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -359,52 +359,44 @@ static int set_rq_size(struct hns_roce_dev *hr_dev,
>  				struct ib_qp_cap *cap, bool is_user, int has_rq,
>  				struct hns_roce_qp *hr_qp)
>  {
> -	struct ib_device *ibdev = &hr_dev->ib_dev;
>  	u32 max_cnt;
>  
> -	/* Check the validity of QP support capacity */
> -	if (cap->max_recv_wr > hr_dev->caps.max_wqes ||
> -	    cap->max_recv_sge > hr_dev->caps.max_rq_sg) {
> -		ibdev_err(ibdev, "Failed to check max recv WR %d and SGE %d\n",
> -			  cap->max_recv_wr, cap->max_recv_sge);
> -		return -EINVAL;
> -	}
> -
>  	/* If srq exist, set zero for relative number of rq */
>  	if (!has_rq) {
>  		hr_qp->rq.wqe_cnt = 0;
>  		hr_qp->rq.max_gs = 0;
>  		cap->max_recv_wr = 0;
>  		cap->max_recv_sge = 0;
> -	} else {
> -		if (is_user && (!cap->max_recv_wr || !cap->max_recv_sge)) {
> -			ibdev_err(ibdev, "Failed to check user max recv WR and SGE\n");
> -			return -EINVAL;
> -		}
>  
> -		if (hr_dev->caps.min_wqes)
> -			max_cnt = max(cap->max_recv_wr, hr_dev->caps.min_wqes);
> -		else
> -			max_cnt = cap->max_recv_wr;
> +		return 0;
> +	}
>  
> -		hr_qp->rq.wqe_cnt = roundup_pow_of_two(max_cnt);
> +	/* Check the validity of QP support capacity */
> +	if (!cap->max_recv_wr || cap->max_recv_wr > hr_dev->caps.max_wqes ||
> +	    cap->max_recv_sge > hr_dev->caps.max_rq_sg) {
> +		ibdev_err(&hr_dev->ib_dev, "RQ config error, depth=%u, sge=%d\n",
> +			  cap->max_recv_wr, cap->max_recv_sge);
> +		return -EINVAL;
> +	}
>  
> -		if ((u32)hr_qp->rq.wqe_cnt > hr_dev->caps.max_wqes) {
> -			ibdev_err(ibdev, "Failed to check RQ WQE count limit\n");
> -			return -EINVAL;
> -		}
> +	max_cnt = max(cap->max_recv_wr, hr_dev->caps.min_wqes);
>  
> -		max_cnt = max(1U, cap->max_recv_sge);
> -		hr_qp->rq.max_gs = roundup_pow_of_two(max_cnt);
> -		if (hr_dev->caps.max_rq_sg <= HNS_ROCE_SGE_IN_WQE)
> -			hr_qp->rq.wqe_shift =
> -					ilog2(hr_dev->caps.max_rq_desc_sz);
> -		else
> -			hr_qp->rq.wqe_shift =
> -					ilog2(hr_dev->caps.max_rq_desc_sz
> -					      * hr_qp->rq.max_gs);
> +	hr_qp->rq.wqe_cnt = roundup_pow_of_two(max_cnt);
> +	if ((u32)hr_qp->rq.wqe_cnt > hr_dev->caps.max_wqes) {
> +		ibdev_err(&hr_dev->ib_dev, "rq depth %u too large\n",
> +			  cap->max_recv_wr);
> +		return -EINVAL;
>  	}
>  
> +	max_cnt = max(1U, cap->max_recv_sge);
> +	hr_qp->rq.max_gs = roundup_pow_of_two(max_cnt);
> +
> +	if (hr_dev->caps.max_rq_sg <= HNS_ROCE_SGE_IN_WQE)
> +		hr_qp->rq.wqe_shift = ilog2(hr_dev->caps.max_rq_desc_sz);
> +	else
> +		hr_qp->rq.wqe_shift = ilog2(hr_dev->caps.max_rq_desc_sz *
> +					    hr_qp->rq.max_gs);
> +
>  	cap->max_recv_wr = hr_qp->rq.wqe_cnt;
>  	cap->max_recv_sge = hr_qp->rq.max_gs;
>  
> @@ -637,29 +629,27 @@ static int set_extend_sge_param(struct hns_roce_dev *hr_dev,
>  static int set_kernel_sq_size(struct hns_roce_dev *hr_dev,
>  			      struct ib_qp_cap *cap, struct hns_roce_qp *hr_qp)
>  {
> -	struct device *dev = hr_dev->dev;
>  	u32 page_size;
>  	u32 max_cnt;
>  	int size;
>  	int ret;
>  
> -	if (cap->max_send_wr  > hr_dev->caps.max_wqes  ||
> +	if (!cap->max_send_wr || cap->max_send_wr > hr_dev->caps.max_wqes ||
>  	    cap->max_send_sge > hr_dev->caps.max_sq_sg ||
>  	    cap->max_inline_data > hr_dev->caps.max_sq_inline) {
> -		dev_err(dev, "SQ WR or sge or inline data error!\n");
> +		ibdev_err(&hr_dev->ib_dev,
> +			  "SQ WR or sge or inline data error!\n");
>  		return -EINVAL;
>  	}
>  
>  	hr_qp->sq.wqe_shift = ilog2(hr_dev->caps.max_sq_desc_sz);
>  
> -	if (hr_dev->caps.min_wqes)
> -		max_cnt = max(cap->max_send_wr, hr_dev->caps.min_wqes);
> -	else
> -		max_cnt = cap->max_send_wr;
> +	max_cnt = max(cap->max_send_wr, hr_dev->caps.min_wqes);
>  
>  	hr_qp->sq.wqe_cnt = roundup_pow_of_two(max_cnt);
>  	if ((u32)hr_qp->sq.wqe_cnt > hr_dev->caps.max_wqes) {
> -		dev_err(dev, "while setting kernel sq size, sq.wqe_cnt too large\n");
> +		ibdev_err(&hr_dev->ib_dev,
> +			  "while setting kernel sq size, sq.wqe_cnt too large\n");
>  		return -EINVAL;
>  	}
>  
> @@ -672,7 +662,7 @@ static int set_kernel_sq_size(struct hns_roce_dev *hr_dev,
>  
>  	ret = set_extend_sge_param(hr_dev, hr_qp);
>  	if (ret) {
> -		dev_err(dev, "set extend sge parameters fail\n");
> +		ibdev_err(&hr_dev->ib_dev, "set extend sge parameters fail\n");
>  		return ret;
>  	}
>  
> @@ -1394,11 +1384,10 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  		goto out;
>  
>  	if (cur_state == new_state && cur_state == IB_QPS_RESET) {
> -		if (hr_dev->caps.min_wqes) {
> +		if (hr_dev->hw_rev == HNS_ROCE_HW_VER1) {
>  			ret = -EPERM;
>  			ibdev_err(&hr_dev->ib_dev,
> -				"cur_state=%d new_state=%d\n", cur_state,
> -				new_state);
> +				  "RST2RST state is not supported\n");
>  		} else {
>  			ret = 0;
>  		}
> 

