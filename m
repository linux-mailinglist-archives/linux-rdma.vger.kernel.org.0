Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0475B080
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jun 2019 17:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfF3P6f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jun 2019 11:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfF3P6f (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 30 Jun 2019 11:58:35 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C522520665;
        Sun, 30 Jun 2019 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561910314;
        bh=H5ZFm/HIMCkfr2e043aMe3JT+LUQMFFiKXlq7j5bE/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgrxfFljJaRj+q32y+CyiLe74Ep/Z7CF5Ys4nFTwYSZe3uWx+KvGyEy+EXP+Vptgg
         O8yi6JhgXxYQB2ZZu0oTLdgJOYcHLS+CzBKRYVa8un2HxIgxvw/8jwbnLMzNm4MufO
         Rb1KnY0xNbLbhgXUnxrl84j/NP6nY+sPBzJXu19k=
Date:   Sun, 30 Jun 2019 18:58:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Liu, Changcheng" <changcheng.liu@intel.com>
Cc:     faisal.latif@intel.com, shiraz.saleem@intel.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/i40iw: set queue pair state when being queried
Message-ID: <20190630155829.GH4727@mtr-leonro.mtl.com>
References: <20190628061613.GA17802@jerryopenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628061613.GA17802@jerryopenix>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 28, 2019 at 02:16:13PM +0800, Liu, Changcheng wrote:
> 1. queue pair state should be clear when querying RDMA/i40iw state.
> attr is allocated from kmalloc with unclear value. resp.qp_state
> isn't clear if attr->qp_state isn't set.
> 2. attr->qp_state should be set to be iwqp->ibqp_state.
> 3. attr->cur_qp_state should be set to be attr->qp_state when querying
> queue pair state.
>
> Signed-off-by: Changcheng Liu <changcheng.liu@aliyun.com>

1. It is wrong patch format, there is lack of "---" after your Signed-off-by.
2. You should describe why you need this change and not what is done in
the change.
3. I suppose, there is a need to add Fixes line.

Thanks

>
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> index 5689d742bafb..4c88d6f72574 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> @@ -772,6 +772,8 @@ static int i40iw_query_qp(struct ib_qp *ibqp,
>  	struct i40iw_qp *iwqp = to_iwqp(ibqp);
>  	struct i40iw_sc_qp *qp = &iwqp->sc_qp;
>
> +	attr->qp_state = iwqp->ibqp_state;
> +	attr->cur_qp_state = attr->qp_state;
>  	attr->qp_access_flags = 0;
>  	attr->cap.max_send_wr = qp->qp_uk.sq_size;
>  	attr->cap.max_recv_wr = qp->qp_uk.rq_size;
> --
> 2.17.1
>
