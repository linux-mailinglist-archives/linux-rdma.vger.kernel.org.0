Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D388182CBE
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 10:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgCLJwi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 05:52:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36532 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbgCLJwh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Mar 2020 05:52:37 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2FA6E2B6928D9A0437BC;
        Thu, 12 Mar 2020 17:52:30 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 12 Mar 2020
 17:52:21 +0800
Subject: Re: [PATCH v4 for-next] RDMA/hns: Support to set mininum depth of qp
 to 0
From:   Weihang Li <liweihang@huawei.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "leon@kernel.org" <leon@kernel.org>
References: <1584005467-19602-1-git-send-email-liweihang@huawei.com>
Message-ID: <3b09094b-c901-a2a3-1efa-7f62be1809fb@huawei.com>
Date:   Thu, 12 Mar 2020 17:52:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584005467-19602-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Again... Please ignore this version because I forgot to modify the title
and description.

Sorry for keep resending this one.

Weihang.

On 2020/3/12 17:35, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Minimum depth of qp should be allowed to be set to 0 according to the
> firmware configuration. And when qp is changed from reset to reset, the
> capability of minimum qp depth was used to identify hardware of hip06,
> it should be changed into a more readable form.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> This patch is named "RDMA/hns: Support to set mininum depth of qp to 0"
> before v3, and previous discussions can be found at:
> https://patchwork.kernel.org/patch/11415067/
> 
> Changes since v3:
> - Remove a "Reviewed-by" tag that hasn't been authorized.
> 
> Changes since v2:
> - Update this patch's name and description according to the modification of
>   code.
> 
> Changes since v1:
> - Fix comments from Leon about calculation of max_cnt, check for qp's depth
>   and modification of the prints.
> - Optimize logic of codes to make them more readable.
> - Replace dev_err() with ibdev_err().
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 77 ++++++++++++++-------------------
>  1 file changed, 33 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index 09e4c46..d8cadbb 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -360,52 +360,44 @@ static int set_rq_size(struct hns_roce_dev *hr_dev,
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
> +		cap->max_recv_sge > hr_dev->caps.max_rq_sg) {
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
> @@ -614,29 +606,27 @@ static int set_extend_sge_param(struct hns_roce_dev *hr_dev,
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
> @@ -649,7 +639,7 @@ static int set_kernel_sq_size(struct hns_roce_dev *hr_dev,
>  
>  	ret = set_extend_sge_param(hr_dev, hr_qp);
>  	if (ret) {
> -		dev_err(dev, "set extend sge parameters fail\n");
> +		ibdev_err(&hr_dev->ib_dev, "set extend sge parameters fail\n");
>  		return ret;
>  	}
>  
> @@ -1373,11 +1363,10 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
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

