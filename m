Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63315A070E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 04:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiHYCAp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 22:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiHYCAZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 22:00:25 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8858C1EC40
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 18:59:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VNB83ob_1661392745;
Received: from 30.43.105.159(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VNB83ob_1661392745)
          by smtp.aliyun-inc.com;
          Thu, 25 Aug 2022 09:59:06 +0800
Message-ID: <528b85de-f9e0-6900-cc50-2af440615476@linux.alibaba.com>
Date:   Thu, 25 Aug 2022 09:59:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH for-next 2/2] RDMA/erdma: Add drain_sq and drain_rq
 support
Content-Language: en-US
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20220824094251.23190-1-chengyou@linux.alibaba.com>
 <20220824094251.23190-3-chengyou@linux.alibaba.com>
In-Reply-To: <20220824094251.23190-3-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/24/22 5:42 PM, Cheng Xu wrote:
> For erdma, hardware won't process any WRs after modifying QP state to
> error, so the default __ib_drain_sq and __ib_drain_rq can not work for
> erdma device. Here, we introduce custom implementation of drain_sq and
> drain_rq interface to fit erdma hardware.
> 
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_qp.c    | 71 +++++++++++++++++++++++
>  drivers/infiniband/hw/erdma/erdma_verbs.h | 10 ++++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
> index abf8b134d076..57fdb946fbfd 100644
> --- a/drivers/infiniband/hw/erdma/erdma_qp.c
> +++ b/drivers/infiniband/hw/erdma/erdma_qp.c
> @@ -599,3 +599,74 @@ int erdma_post_recv_nodrain(struct ib_qp *ibqp,
>  {
>  	return erdma_post_recv(ibqp, recv_wr, bad_recv_wr, false);
>  }
> +
> +static void erdma_drain_qp_done(struct ib_cq *cq, struct ib_wc *wc)
> +{
> +	struct erdma_drain_cqe *cqe =
> +		container_of(wc->wr_cqe, struct erdma_drain_cqe, cqe);
> +
> +	complete(&cqe->done);
> +}
> +
> +static void erdma_drain_qp_common(struct ib_qp *ibqp, struct completion *comp,
> +				  struct ib_cq *ibcq)
> +{
> +	struct ib_qp_attr attr = { .qp_state = IB_QPS_ERR };
> +	struct erdma_qp *qp = to_eqp(ibqp);
> +	const struct ib_send_wr *bad_swr;
> +	const struct ib_recv_wr *bad_rwr;
> +	struct ib_rdma_wr swr = {
> +		.wr = {
> +			.next = NULL,
> +			{ .wr_cqe   = &qp->kern_qp.sdrain.cqe, },
> +			.opcode = IB_WR_RDMA_WRITE,
> +			.send_flags = IB_SEND_SIGNALED,
> +		},
> +	};
> +	struct ib_recv_wr rwr = {
> +		.next = NULL,
> +		.wr_cqe = &qp->kern_qp.rdrain.cqe,
> +		.num_sge = 0,
> +	};
> +
> +	if (qp->flags & ERDMA_QP_FLAGS_DRAIN_ISSUED)
> +		goto wait_for_completion;
> +
> +	qp->flags |= ERDMA_QP_FLAGS_DRAIN_ISSUED;
> +
> +	qp->kern_qp.rdrain.cqe.done = erdma_drain_qp_done;
> +	init_completion(&qp->kern_qp.rdrain.done);
> +
> +	qp->kern_qp.sdrain.cqe.done = erdma_drain_qp_done;
> +	init_completion(&qp->kern_qp.sdrain.done);
> +
> +	if (erdma_post_recv(ibqp, &rwr, &bad_rwr, true))
> +		return;
> +
> +	if (erdma_post_send(ibqp, &swr.wr, &bad_swr, true))
> +		return;
> +
> +	if (ib_modify_qp(ibqp, &attr, IB_QP_STATE))
> +		return;
> +
> +wait_for_completion:
> +	if (ibcq->poll_ctx == IB_POLL_DIRECT)
> +		while (wait_for_completion_timeout(comp, HZ / 10) <= 0)
> +			ib_process_cq_direct(ibcq, -1);
> +	else
> +		wait_for_completion(comp);
> +}
> +
> +void erdma_drain_sq(struct ib_qp *ibqp)
> +{
> +	struct erdma_qp *qp = to_eqp(ibqp);
> +
> +	erdma_drain_qp_common(ibqp, &qp->kern_qp.sdrain.done, ibqp->send_cq);
> +}
> +
> +void erdma_drain_rq(struct ib_qp *ibqp)
> +{
> +	struct erdma_qp *qp = to_eqp(ibqp);
> +
> +	erdma_drain_qp_common(ibqp, &qp->kern_qp.rdrain.done, ibqp->recv_cq);
> +}
> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
> index f4148fbac878..4cec92c8a737 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.h
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
> @@ -133,6 +133,11 @@ struct erdma_uqp {
>  	u32 rq_offset;
>  };
>  
> +struct erdma_drain_cqe {
> +	struct ib_cqe cqe;
> +	struct completion done;
> +};
> +
>  struct erdma_kqp {
>  	u16 sq_pi;
>  	u16 sq_ci;
> @@ -155,6 +160,9 @@ struct erdma_kqp {
>  	void *sq_db_info;
>  	void *rq_db_info;
>  
> +	struct erdma_drain_cqe sdrain;
> +	struct erdma_drain_cqe rdrain;
> +
>  	u8 sig_all;
>  };
>  
> @@ -341,6 +349,8 @@ int erdma_post_send_nodrain(struct ib_qp *ibqp,
>  int erdma_post_recv_nodrain(struct ib_qp *ibqp,
>  			    const struct ib_recv_wr *recv_wr,
>  			    const struct ib_recv_wr **bad_recv_wr);
> +void erdma_drain_sq(struct ib_qp *ibqp);
> +void erdma_drain_rq(struct ib_qp *ibqp);
>  int erdma_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
>  struct ib_mr *erdma_ib_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>  				u32 max_num_sg);

I'm sorry that I forgot to involved the corresponding assignment of struct ib_device_ops
into this patch. I will send v2 to fix this.


diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 4921ebc1286d..e4ce77607f10 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -446,6 +446,8 @@ static const struct ib_device_ops erdma_device_ops = {
        .dereg_mr = erdma_dereg_mr,
        .destroy_cq = erdma_destroy_cq,
        .destroy_qp = erdma_destroy_qp,
+       .drain_rq = erdma_drain_rq,
+       .drain_sq = erdma_drain_sq,
        .get_dma_mr = erdma_get_dma_mr,
        .get_port_immutable = erdma_get_port_immutable,
        .iw_accept = erdma_accept,




