Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1893208F3
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Feb 2021 07:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBUGYb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Feb 2021 01:24:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhBUGYa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Feb 2021 01:24:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21B8664EB4;
        Sun, 21 Feb 2021 06:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613888629;
        bh=38DJmkM0DFW3wAx845B4ZIR6igYJXiijIhkNnLNJbiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STN0mQMb6TptX7nVyvxY5Ib0o6p6Sp2j+ZKMGGEAAGU5gQ/xo3bUAJ0qn0jupeq+6
         uGRxQ9XmrT4vNKFzI0IIolWIveQlE99CIitqadBvhrBfSXsbYYUleLjCd2w6gsBjAH
         GYJubH9/UHMKMQflbKSaqf5rKIWnPBmcrgKSVwLkkIaVk/g4DaqcSfMrcdSFnF4lHS
         uxqtTFMedrk7GMWt0oQaz6SwNEVY0YpXC53iCgZSYJ2+CHmTRos9/qQGDRgzlc8oE2
         X5aBVMFjxXyT7uektGzYM2TA+5XuRach3dXikEk+ejdZoL6e7sMuMLB8xi+belwHL3
         hDNsAVnE2udlQ==
Date:   Sun, 21 Feb 2021 08:23:46 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, danil.kipnis@cloud.ionos.com
Subject: Re: [PATCH 1/2] RDMA/rtrs: Use new shared CQ mechanism
Message-ID: <YDH8ckNx/sEPlePt@unreal>
References: <20210219115019.38981-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219115019.38981-1-jinpu.wang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 19, 2021 at 12:50:18PM +0100, Jack Wang wrote:
> Has the driver use shared CQs providing ~10%-20% improvement during
> test.
> Instead of opening a CQ for each QP per connection, a CQ for each QP
> will be provided by the RDMA core driver that will be shared between
> the QPs on that core reducing interrupt overhead.
>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 10 +++++-----
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  1 +
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 10 +++++-----
>  drivers/infiniband/ulp/rtrs/rtrs.c     | 11 +++++++----
>  4 files changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 0a08b4b742a3..4e9cf06cc17a 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -325,7 +325,7 @@ static void rtrs_rdma_error_recovery(struct rtrs_clt_con *con)
>
>  static void rtrs_clt_fast_reg_done(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	struct rtrs_clt_con *con = cq->cq_context;
> +	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
>
>  	if (unlikely(wc->status != IB_WC_SUCCESS)) {
>  		rtrs_err(con->c.sess, "Failed IB_WR_REG_MR: %s\n",
> @@ -345,7 +345,7 @@ static void rtrs_clt_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
>  {
>  	struct rtrs_clt_io_req *req =
>  		container_of(wc->wr_cqe, typeof(*req), inv_cqe);
> -	struct rtrs_clt_con *con = cq->cq_context;
> +	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
>
>  	if (unlikely(wc->status != IB_WC_SUCCESS)) {
>  		rtrs_err(con->c.sess, "Failed IB_WR_LOCAL_INV: %s\n",
> @@ -586,7 +586,7 @@ static int rtrs_post_recv_empty_x2(struct rtrs_con *con, struct ib_cqe *cqe)
>
>  static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	struct rtrs_clt_con *con = cq->cq_context;
> +	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
>  	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
>  	u32 imm_type, imm_payload;
>  	bool w_inval = false;
> @@ -2241,7 +2241,7 @@ static int init_conns(struct rtrs_clt_sess *sess)
>
>  static void rtrs_clt_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	struct rtrs_clt_con *con = cq->cq_context;
> +	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
>  	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
>  	struct rtrs_iu *iu;
>
> @@ -2323,7 +2323,7 @@ static int process_info_rsp(struct rtrs_clt_sess *sess,
>
>  static void rtrs_clt_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	struct rtrs_clt_con *con = cq->cq_context;
> +	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
>  	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
>  	struct rtrs_msg_info_rsp *msg;
>  	enum rtrs_clt_state state;
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> index 8caad0a2322b..1b31bda9ca78 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> @@ -91,6 +91,7 @@ struct rtrs_con {
>  	struct ib_cq		*cq;
>  	struct rdma_cm_id	*cm_id;
>  	unsigned int		cid;
> +	u16                     cq_size;
>  };
>
>  struct rtrs_sess {
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index d071809e3ed2..37ba121564a2 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -199,7 +199,7 @@ static void rtrs_srv_wait_ops_ids(struct rtrs_srv_sess *sess)
>
>  static void rtrs_srv_reg_mr_done(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	struct rtrs_srv_con *con = cq->cq_context;
> +	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
>  	struct rtrs_sess *s = con->c.sess;
>  	struct rtrs_srv_sess *sess = to_srv_sess(s);
>
> @@ -720,7 +720,7 @@ static void rtrs_srv_stop_hb(struct rtrs_srv_sess *sess)
>
>  static void rtrs_srv_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	struct rtrs_srv_con *con = cq->cq_context;
> +	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
>  	struct rtrs_sess *s = con->c.sess;
>  	struct rtrs_srv_sess *sess = to_srv_sess(s);
>  	struct rtrs_iu *iu;
> @@ -862,7 +862,7 @@ static int process_info_req(struct rtrs_srv_con *con,
>
>  static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	struct rtrs_srv_con *con = cq->cq_context;
> +	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
>  	struct rtrs_sess *s = con->c.sess;
>  	struct rtrs_srv_sess *sess = to_srv_sess(s);
>  	struct rtrs_msg_info_req *msg;
> @@ -1110,7 +1110,7 @@ static void rtrs_srv_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
>  {
>  	struct rtrs_srv_mr *mr =
>  		container_of(wc->wr_cqe, typeof(*mr), inv_cqe);
> -	struct rtrs_srv_con *con = cq->cq_context;
> +	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
>  	struct rtrs_sess *s = con->c.sess;
>  	struct rtrs_srv_sess *sess = to_srv_sess(s);
>  	struct rtrs_srv *srv = sess->srv;
> @@ -1167,7 +1167,7 @@ static void rtrs_rdma_process_wr_wait_list(struct rtrs_srv_con *con)
>
>  static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	struct rtrs_srv_con *con = cq->cq_context;
> +	struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
>  	struct rtrs_sess *s = con->c.sess;
>  	struct rtrs_srv_sess *sess = to_srv_sess(s);
>  	struct rtrs_srv *srv = sess->srv;
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> index d13aff0aa816..d5ec78280937 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -218,14 +218,15 @@ static int create_cq(struct rtrs_con *con, int cq_vector, u16 cq_size,
>  	struct rdma_cm_id *cm_id = con->cm_id;
>  	struct ib_cq *cq;
>
> -	cq = ib_alloc_cq(cm_id->device, con, cq_size,
> -			 cq_vector, poll_ctx);
> +	cq = ib_cq_pool_get(cm_id->device, cq_size,
> +			    cq_vector, poll_ctx);
>  	if (IS_ERR(cq)) {
>  		rtrs_err(con->sess, "Creating completion queue failed, errno: %ld\n",
>  			  PTR_ERR(cq));
>  		return PTR_ERR(cq);
>  	}
>  	con->cq = cq;
> +	con->cq_size = cq_size;
>
>  	return 0;
>  }
> @@ -273,8 +274,9 @@ int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
>  	err = create_qp(con, sess->dev->ib_pd, max_send_wr, max_recv_wr,
>  			max_send_sge);
>  	if (err) {
> -		ib_free_cq(con->cq);
> +		ib_cq_pool_put(con->cq, con->cq_size);
>  		con->cq = NULL;
> +		con->cq_size = 0;

It is better do not clear fields that not used, it hides bugs.
Other than that.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
