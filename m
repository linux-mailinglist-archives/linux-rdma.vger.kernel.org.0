Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A04D3C8D40
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 17:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfJBPrf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 11:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfJBPrf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 11:47:35 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39CB921848;
        Wed,  2 Oct 2019 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570031254;
        bh=nwiMD1c6NiYKo9gsju2vE6E+Gr5/j828y/0tZcbuErA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRBgaBbYP88Os/fHb7KjEbIkzsygowZTDUBTeyImXSoLA1y7qnxZM0VBfL62tAuGT
         SN0oQrNGcY2skP93X2p6WnmxvG23GpD9cl3MWJr2hYwNlpaBY7o4T4CyyrOq8Ijzda
         74juEo+EtONfXuxGQ93fcruSwf0zi2PX7AWV/Lf4=
Date:   Wed, 2 Oct 2019 18:47:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com, jgg@ziepe.ca,
        nirranjan@chelsio.com, krishna2@chelsio.com, bvanassche@acm.org
Subject: Re: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ drain logic
Message-ID: <20191002154728.GH5855@unreal>
References: <20191002143858.4550-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002143858.4550-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 02, 2019 at 04:38:58PM +0200, Bernard Metzler wrote:
> Storage ULPs (e.g. iSER & NVMeOF) use ib_drain_qp() to
> drain QP/CQ. Current SIW's own drain routines do not properly
> wait until all SQ/RQ elements are completed and reaped
> from the CQ. This may cause touch after free issues.
> New logic relies on generic __ib_drain_sq()/__ib_drain_rq()
> posting a final work request, which SIW immediately flushes
> to CQ.
>
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
> v1 -> v2:
> - Accept SQ and RQ work requests, if QP is in ERROR
>   state. In that case, immediately flush WR's to CQ.
>   This already provides needed functionality to
>   support ib_drain_sq()/ib_drain_rq() without extra
>   state checking in the fast path.
>
>  drivers/infiniband/sw/siw/siw_main.c  |  20 -----
>  drivers/infiniband/sw/siw/siw_verbs.c | 103 +++++++++++++++++++++-----
>  2 files changed, 86 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
> index 05a92f997f60..fb01407a310f 100644
> --- a/drivers/infiniband/sw/siw/siw_main.c
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -248,24 +248,6 @@ static struct ib_qp *siw_get_base_qp(struct ib_device *base_dev, int id)
>  	return NULL;
>  }
>
> -static void siw_verbs_sq_flush(struct ib_qp *base_qp)
> -{
> -	struct siw_qp *qp = to_siw_qp(base_qp);
> -
> -	down_write(&qp->state_lock);
> -	siw_sq_flush(qp);
> -	up_write(&qp->state_lock);
> -}
> -
> -static void siw_verbs_rq_flush(struct ib_qp *base_qp)
> -{
> -	struct siw_qp *qp = to_siw_qp(base_qp);
> -
> -	down_write(&qp->state_lock);
> -	siw_rq_flush(qp);
> -	up_write(&qp->state_lock);
> -}
> -
>  static const struct ib_device_ops siw_device_ops = {
>  	.owner = THIS_MODULE,
>  	.uverbs_abi_ver = SIW_ABI_VERSION,
> @@ -284,8 +266,6 @@ static const struct ib_device_ops siw_device_ops = {
>  	.destroy_cq = siw_destroy_cq,
>  	.destroy_qp = siw_destroy_qp,
>  	.destroy_srq = siw_destroy_srq,
> -	.drain_rq = siw_verbs_rq_flush,
> -	.drain_sq = siw_verbs_sq_flush,
>  	.get_dma_mr = siw_get_dma_mr,
>  	.get_port_immutable = siw_get_port_immutable,
>  	.iw_accept = siw_accept,
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index 869e02b69a01..40e68e7a4f39 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -687,6 +687,47 @@ static int siw_copy_inline_sgl(const struct ib_send_wr *core_wr,
>  	return bytes;
>  }
>
> +/* Complete SQ WR's without processing */
> +static int siw_sq_flush_wr(struct siw_qp *qp, const struct ib_send_wr *wr,
> +			   const struct ib_send_wr **bad_wr)
> +{
> +	struct siw_sqe sqe = {};
> +	int rv = 0;
> +
> +	while (wr) {
> +		sqe.id = wr->wr_id;
> +		sqe.opcode = wr->opcode;
> +		rv = siw_sqe_complete(qp, &sqe, 0, SIW_WC_WR_FLUSH_ERR);
> +		if (rv) {
> +			if (bad_wr)
> +				*bad_wr = wr;
> +			break;
> +		}
> +		wr = wr->next;
> +	}
> +	return rv;
> +}
> +
> +/* Complete RQ WR's without processing */
> +static int siw_rq_flush_wr(struct siw_qp *qp, const struct ib_recv_wr *wr,
> +			   const struct ib_recv_wr **bad_wr)
> +{
> +	struct siw_rqe rqe = {};
> +	int rv = 0;
> +
> +	while (wr) {
> +		rqe.id = wr->wr_id;
> +		rv = siw_rqe_complete(qp, &rqe, 0, 0, SIW_WC_WR_FLUSH_ERR);
> +		if (rv) {
> +			if (bad_wr)
> +				*bad_wr = wr;
> +			break;
> +		}
> +		wr = wr->next;
> +	}
> +	return rv;
> +}
> +
>  /*
>   * siw_post_send()
>   *
> @@ -705,6 +746,12 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>  	unsigned long flags;
>  	int rv = 0;
>
> +	if (wr && !qp->kernel_verbs) {

It is not related to this specific patch, but all siw "kernel_verbs"
should go, we have standard way to distinguish between kernel and user
verbs.

Thanks
