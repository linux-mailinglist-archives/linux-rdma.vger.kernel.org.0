Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27D82FA878
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 19:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407040AbhARRVB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 12:21:01 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:52786 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406369AbhARRCr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 12:02:47 -0500
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 10IH1suX005156;
        Mon, 18 Jan 2021 09:01:55 -0800
Date:   Mon, 18 Jan 2021 22:31:54 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/cxgb4: Fix the reported max_recv_sge value
Message-ID: <YAW/AseJZpaL2/RY@chelsio.com>
References: <20210114191423.423529-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114191423.423529-1-kamalheib1@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Friday, January 01/15/21, 2021 at 00:44:23 +0530, Kamal Heib wrote:
> The max_recv_sge value is wrongly reported when calling query_qp, This
> is happening due to a typo when assigning the max_recv_sge value, the
> value of sq_max_sges was assigned instead of rq_max_sges.
> 
> Fixes: 3e5c02c9ef9a ("iw_cxgb4: Support query_qp() verb")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---

Thanks for the patch Kamal.
Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
>  drivers/infiniband/hw/cxgb4/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
> index a7401398cb34..d109bb3822a5 100644
> --- a/drivers/infiniband/hw/cxgb4/qp.c
> +++ b/drivers/infiniband/hw/cxgb4/qp.c
> @@ -2474,7 +2474,7 @@ int c4iw_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  	init_attr->cap.max_send_wr = qhp->attr.sq_num_entries;
>  	init_attr->cap.max_recv_wr = qhp->attr.rq_num_entries;
>  	init_attr->cap.max_send_sge = qhp->attr.sq_max_sges;
> -	init_attr->cap.max_recv_sge = qhp->attr.sq_max_sges;
> +	init_attr->cap.max_recv_sge = qhp->attr.rq_max_sges;
>  	init_attr->cap.max_inline_data = T4_MAX_SEND_INLINE;
>  	init_attr->sq_sig_type = qhp->sq_sig_all ? IB_SIGNAL_ALL_WR : 0;
>  	return 0;
> -- 
> 2.26.2
> 
