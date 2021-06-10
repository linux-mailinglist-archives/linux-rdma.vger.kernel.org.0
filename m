Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E883A2558
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 09:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhFJHZh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 03:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230377AbhFJHZd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 03:25:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F09C6613FE;
        Thu, 10 Jun 2021 07:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623309817;
        bh=lHI0t5rHu2d3Ygzn1tfIFyvxIq4U3dYmF3djqqE4dzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kseY4RXSQ3rW6AKrehr+iYyPCSHEGfIGFQRpZFnFNbAg8Buw1eCZ8aDr9Xf2O+vPQ
         2DqMAQJifF/CfsE30FlF9+m11Cr2zEYR44Ylk8sFrrvx6HmypkkEYFvtvkkcxxMhbX
         qwCO7k6EfLsohoWLVcC+q9yeD/VfG2piMtww/3UW6w/1bbX/0ouRG23/KKn78pnprb
         He4ToJn0qqrm+VCBst3rLCuxz2qQb35MtvHSm7rQ2iG4hfm4EKEiiQibhTubjr+MZX
         RGMbfSeoXzNkcS5p2vtk9cVycfxvukVhlqFqhKbFqzW4Wf/55KITzdhGLNkmSDjEJT
         Y7WXPO7sW136g==
Date:   Thu, 10 Jun 2021 10:23:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH for-next 3/4] RDMA/rtrs: RDMA_RXE requires more number of
 WR
Message-ID: <YMG99IVNqCK8OIVX@unreal>
References: <20210608103039.39080-1-jinpu.wang@ionos.com>
 <20210608103039.39080-4-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608103039.39080-4-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 08, 2021 at 12:30:38PM +0200, Jack Wang wrote:
> From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> 
> When using rdma_rxe, post_one_recv() returns
> NOMEM error due to the full recv queue.
> This patch increase the number of WR for receive queue
> to support all devices.

Why don't you query IB device to get max_qp_wr and set accordingly?

Thanks

> 
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 ++++---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index cd53edddfe1f..acf0fde410c3 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1579,10 +1579,11 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
>  	lockdep_assert_held(&con->con_mutex);
>  	if (con->c.cid == 0) {
>  		/*
> -		 * One completion for each receive and two for each send
> -		 * (send request + registration)
> +		 * Two (request + registration) completion for send
> +		 * Two for recv if always_invalidate is set on server
> +		 * or one for recv.
>  		 * + 2 for drain and heartbeat
> -		 * in case qp gets into error state
> +		 * in case qp gets into error state.
>  		 */
>  		max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
>  		max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 04ec3080e9b5..bb73f7762a87 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1656,7 +1656,7 @@ static int create_con(struct rtrs_srv_sess *sess,
>  		 * + 2 for drain and heartbeat
>  		 */
>  		max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
> -		max_recv_wr = SERVICE_CON_QUEUE_DEPTH + 2;
> +		max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
>  		cq_size = max_send_wr + max_recv_wr;
>  	} else {
>  		/*
> -- 
> 2.25.1
> 
