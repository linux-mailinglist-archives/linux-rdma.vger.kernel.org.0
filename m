Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93F817E35C
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2020 16:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCIPST (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 11:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgCIPSS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Mar 2020 11:18:18 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7561B20578;
        Mon,  9 Mar 2020 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583767098;
        bh=A9g/8BNv6HBuSiETy6ZY3A8+0+tfM0iP1cq8Krqrouo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bMA4cZcV5jb+Q2FQ0tfqkmcoKH8siwlkgB4AAvlhhqOjH9O75MGD6p4AJXy6orTGH
         f7D9N1ymmGP9V5bAmsob9FiPA87rBDoXwgqhLjYgWBzOeBpZSEbk7Hgwoy7RrvmlwR
         muDUwTEBHXxW35l5Yn/cq/6oJcFZP30zzWYMu82E=
Date:   Mon, 9 Mar 2020 17:18:13 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Support to set mininum depth of qp to
 0
Message-ID: <20200309151813.GE172334@unreal>
References: <1583140937-2223-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583140937-2223-1-git-send-email-liweihang@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 02, 2020 at 05:22:17PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
>
> Minimum depth of qp should be allowed to be set to 0 according to the
> firmware configuration. And when qp is changed from reset to reset, the
> capability of minimum qp depth was used to identify hardware of hip06,
> it should be changed into a more readable form.


And what does it mean "qp depth == 0"?

>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index 2a75355..10c4354 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -382,10 +382,10 @@ static int set_rq_size(struct hns_roce_dev *hr_dev,
>  			return -EINVAL;
>  		}
>
> -		if (hr_dev->caps.min_wqes)
> +		if (cap->max_recv_wr)
>  			max_cnt = max(cap->max_recv_wr, hr_dev->caps.min_wqes);
>  		else
> -			max_cnt = cap->max_recv_wr;
> +			max_cnt = 0;

It is basically the same thing: cap->max_recv_wr == 0.

>
>  		hr_qp->rq.wqe_cnt = roundup_pow_of_two(max_cnt);
>
> @@ -652,10 +652,10 @@ static int set_kernel_sq_size(struct hns_roce_dev *hr_dev,
>
>  	hr_qp->sq.wqe_shift = ilog2(hr_dev->caps.max_sq_desc_sz);
>
> -	if (hr_dev->caps.min_wqes)
> +	if (cap->max_send_wr)
>  		max_cnt = max(cap->max_send_wr, hr_dev->caps.min_wqes);
>  	else
> -		max_cnt = cap->max_send_wr;
> +		max_cnt = 0;

Ditto

>
>  	hr_qp->sq.wqe_cnt = roundup_pow_of_two(max_cnt);
>  	if ((u32)hr_qp->sq.wqe_cnt > hr_dev->caps.max_wqes) {
> @@ -1394,11 +1394,10 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  		goto out;
>
>  	if (cur_state == new_state && cur_state == IB_QPS_RESET) {
> -		if (hr_dev->caps.min_wqes) {
> +		if (hr_dev->hw_rev == HNS_ROCE_HW_VER1) {
>  			ret = -EPERM;
>  			ibdev_err(&hr_dev->ib_dev,
> -				"cur_state=%d new_state=%d\n", cur_state,
> -				new_state);
> +				  "Unsupport to modify qp from reset to reset\n");

"RST2RST state is not supported\n"

>  		} else {
>  			ret = 0;
>  		}
> --
> 2.8.1
>
