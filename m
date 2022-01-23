Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4014970F2
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 11:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbiAWKep (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 05:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiAWKeo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 05:34:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C080C06173B
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jan 2022 02:34:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFE8FB80C73
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jan 2022 10:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE82CC340E2;
        Sun, 23 Jan 2022 10:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642934081;
        bh=LsfPKp9+qGcxDplOICFKEjdp1AWla9VpG7SJ7NT/5Gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUY1b2Ryn/Ka9+vQQKq86v66KNBXoVgzYvHx2ufmGU4cQDe4sR5NG5ZbOO0h5ops2
         10ZuB5p0kGpjP9IPPfs6XBvFRZoZw6I8hbgpf7cItchrxBScbTogUcNB8SDoZsEN3K
         HB66Ct3/RrX/qlCouyBH13VywlSQc8GsXmKOuOvYOJLXY3I8OjTIOL4izToo/i125A
         00naPURl90UMMR4nciTPYG009kI1buQarMrxcc9iOj9JP8o7cqifHFyM1lZmtDs2Z2
         +Pp2goevuxzFjzxEO5bh+sbIP38zuty5Ei39QIEJXmGIjzha0JMxBnBj64JgqAHwqI
         TBRF4tGOddoGw==
Date:   Sun, 23 Jan 2022 12:34:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     mike.marciniszyn@cornelisnetworks.com
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] IB/rdmavt: Validate remote_addr during loopback
 atomic tests
Message-ID: <Ye0vPMAF6NdF0pMu@unreal>
References: <1642584489-141005-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642584489-141005-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 19, 2022 at 04:28:09AM -0500, mike.marciniszyn@cornelisnetworks.com wrote:
> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> 
> The rdma-core test suite sends an unaligned remote address
> and expects a failure.
> 
> ERROR: test_atomic_non_aligned_addr (tests.test_atomic.AtomicTest)
> 
> The qib/hfi1 rc handling validates properly, but the test has the
> client and server on the same system.
> 
> The loopback of these operations is a distinct code path.
> 
> Fix by syntaxing the proposed remote address in the loopback
> code path.
> 
> Fixes: 15703461533a ("IB/{hfi1, qib, rdmavt}: Move ruc_loopback to rdmavt")
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> ---
>  drivers/infiniband/sw/rdmavt/qp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
> index 3305f27..ae50b56 100644
> --- a/drivers/infiniband/sw/rdmavt/qp.c
> +++ b/drivers/infiniband/sw/rdmavt/qp.c
> @@ -3073,6 +3073,8 @@ void rvt_ruc_loopback(struct rvt_qp *sqp)
>  	case IB_WR_ATOMIC_FETCH_AND_ADD:
>  		if (unlikely(!(qp->qp_access_flags & IB_ACCESS_REMOTE_ATOMIC)))
>  			goto inv_err;
> +		if (unlikely(wqe->atomic_wr.remote_addr & (sizeof(u64) - 1)))

Isn't this "!PAGE_ALIGNED(wqe->atomic_wr.remote_addr)" check?

Thanks

> +			goto inv_err;
>  		if (unlikely(!rvt_rkey_ok(qp, &qp->r_sge.sge, sizeof(u64),
>  					  wqe->atomic_wr.remote_addr,
>  					  wqe->atomic_wr.rkey,
> -- 
> 1.8.3.1
> 
