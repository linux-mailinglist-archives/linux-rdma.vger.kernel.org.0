Return-Path: <linux-rdma+bounces-4308-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAE994E08F
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 10:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52C31F21507
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34AC6AB8;
	Sun, 11 Aug 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myhNFXVm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22421CAAF
	for <linux-rdma@vger.kernel.org>; Sun, 11 Aug 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723365674; cv=none; b=hYiec9RIKVeXbpjP4jrGhwIKy4ufVn5/SY1UHk80VbTnOKUP3s7dUhDADz90bdTWLLz9xufKDS8Fc2TNEiu59pQzglX/v+8JhEzyGTAdkE1WnsngI1r6gDKDH8At/+4SxDRkbGSqo2m+aIhJhMjYOIq4gy561UnJ2qBvQmGIHgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723365674; c=relaxed/simple;
	bh=qX/5ce7eT3ZetaqdJPucU2AabQ3fpWNpucvRxm3VSQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7YBfFi9rduOrFfxTx92MmZ2RreigoXkOfs/vLzke/9VSgjAzmJQWgAHxAdqRmUesjqIgUW9YiXkJA6m1aqWZK6Jq+AnqGur1O/T7o6u4QcIzy2WY3Zu+ehwsqdlEMREGPOgN03pSW8km3Z2NUjdaSzDjOq5TE6zwDPg5qknWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myhNFXVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B160C4AF0C;
	Sun, 11 Aug 2024 08:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723365674;
	bh=qX/5ce7eT3ZetaqdJPucU2AabQ3fpWNpucvRxm3VSQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=myhNFXVmAn9BhSdONzjUVlXBhzUWPYveuU2q6f2X8hiGOimGMwytalO/9Mrtd3ixc
	 TX9y/5Qdz0aLASRgWvqcafNqFy1BrURPPsJ/qc9iiCHUigjNz9iAR/Rql0M8nJtUai
	 eLa8NlsWTWyp7at6Xhm9DiQjtbT8PrQl0fYwU2Qm35pY/dCk3oPlmHyWKmWy4EgKGm
	 0cckFu+ZFPh27QECpOC8oBoI9U5Hj1e6I9X9sjoj7e/Pc23d1FoMjtSD7QPU7xLpz5
	 GMUcGj/dcYBwmDxgHESSOtP8jROlFK5aONLOZfFADaKhh29SEaWve07Wxyrn8pmXcS
	 p6c4Wz8djFKVA==
Date: Sun, 11 Aug 2024 11:41:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Md Haris Iqbal <haris.iqbal@ionos.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: Re: [PATCH for-next 02/13] RDMA/rtrs-srv: Fix use-after-free during
 session establishment
Message-ID: <20240811084110.GC5925@unreal>
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
 <20240809131538.944907-3-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809131538.944907-3-haris.iqbal@ionos.com>

On Fri, Aug 09, 2024 at 03:15:27PM +0200, Md Haris Iqbal wrote:
> From: Jack Wang <jinpu.wang@ionos.com>
> 
> In case of error happening during session stablishment, close_work is
> running. A new RDMA CM event may arrive since we don't destroy cm_id
> before destroying qp. To fix this, we first destroy cm_id after drain_qp,
> so no new RDMA CM event will arrive afterwards.
> 
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
>  drivers/infiniband/ulp/rtrs/rtrs.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index fb67b58a7f62..90ea25ad6720 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1540,6 +1540,7 @@ static void rtrs_srv_close_work(struct work_struct *work)
>  		con = to_srv_con(srv_path->s.con[i]);
>  		rdma_disconnect(con->c.cm_id);
>  		ib_drain_qp(con->c.qp);
> +		rdma_destroy_id(con->c.cm_id);
>  	}
>  
>  	/*
> @@ -1564,7 +1565,6 @@ static void rtrs_srv_close_work(struct work_struct *work)
>  			continue;
>  		con = to_srv_con(srv_path->s.con[i]);
>  		rtrs_cq_qp_destroy(&con->c);
> -		rdma_destroy_id(con->c.cm_id);
>  		kfree(con);
>  	}
>  	rtrs_ib_dev_put(srv_path->s.dev);
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> index 4e17d546d4cc..44167fd1c958 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> @@ -318,7 +318,7 @@ EXPORT_SYMBOL_GPL(rtrs_cq_qp_create);
>  void rtrs_cq_qp_destroy(struct rtrs_con *con)
>  {
>  	if (con->qp) {
> -		rdma_destroy_qp(con->cm_id);
> +		ib_destroy_qp(con->qp);

You created that QP with rdma_create_qp() and you should destroy it with rdma_destroy_qp().

Thanks

>  		con->qp = NULL;
>  	}
>  	destroy_cq(con);
> -- 
> 2.25.1
> 

