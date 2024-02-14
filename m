Return-Path: <linux-rdma+bounces-1019-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF9854500
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Feb 2024 10:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7301C21490
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Feb 2024 09:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6217C125BC;
	Wed, 14 Feb 2024 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOeZpdxH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14677CA73;
	Wed, 14 Feb 2024 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902510; cv=none; b=F/1n1olLE17WKK39VquAtaYH7P0t3lmFgSRUs39PuC3sC3r5yt/s6LpbuNbSCl7PpOm8DzscSwFXfMDjaGFrhUtWNFobL0znvo779glCl/+Ke27rJTAoUbKczr+j8QhYyVvjTy7tG38Wo6SWFyPUhfVzeO4RPDNGfu7PjQ69xjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902510; c=relaxed/simple;
	bh=ir1ZTlVuKq3OpAEOdgpZVagRG7UpTq1IJDjRKpFOG3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mO7q7QXRkNVQs67QXfc1ukPPiqhWc4hGX8Scl0yReUgSD1R61dflQWJ5FDSzuv/Dg5y6loP3nGgLHMCaTzDylTJKO1gly02c/M3Sv6sUSsJSCASgcOyNFv0JCursO/YX4MeFLvp5QnvkGbb1juC5adrCsbiRIpnynlbDSgoOOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOeZpdxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0BAC433F1;
	Wed, 14 Feb 2024 09:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707902509;
	bh=ir1ZTlVuKq3OpAEOdgpZVagRG7UpTq1IJDjRKpFOG3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOeZpdxHh+ZiAtHiKBZvRMtcQJNYSTn6wJIgQPyGtTmCeoX72gy4L5K0v34adO0J3
	 SwASsrRv+tR5NhoN5YO+iA2I6TTRMphhDLoAw6nMs9XqQ2rQrIP006wI70orMouo7Z
	 bIpIZWYMFOz8/a2AbvMPcPZfG3fKQCNsIcFKbmlbevq6OvqGie/CJGgzrkw+7E3AzH
	 UWvvEEfLvWdZV3nvPlf01b548oZp1eg6b3jFjFjfzHdBPaoc6aQxdsrzj0Pt3LIcA1
	 nfKunJSrcf5cbtEnNLTQ4LKb7UGPVBNco7QzOGx5r6Wtc35gwI3WjardFa3ughUyrH
	 YX0KJiHXIGj5Q==
Date: Wed, 14 Feb 2024 11:21:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Nicholas A. Bellinger" <nab@risingtidesystems.com>,
	linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] RDMA/srpt: fix function pointer cast warnings
Message-ID: <20240214092144.GF52640@unreal>
References: <20240213100728.458348-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213100728.458348-1-arnd@kernel.org>

On Tue, Feb 13, 2024 at 11:07:13AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-16 notices that srpt_qp_event() gets called through an incompatible
> pointer here:
> 
> drivers/infiniband/ulp/srpt/ib_srpt.c:1815:5: error: cast from 'void (*)(struct ib_event *, struct srpt_rdma_ch *)' to 'void (*)(struct ib_event *, void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>  1815 |                 = (void(*)(struct ib_event *, void*))srpt_qp_event;
> 
> Change srpt_qp_event() to use the correct prototype and adjust the
> argument inside of it.
> 
> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)


This patch generates the following warnings, fixed and applied.
➜  kernel git:(wip/leon-for-rc) mkt ci
f17a855457db (HEAD -> build) RDMA/srpt: fix function pointer cast warnings
drivers/infiniband/ulp/srpt/ib_srpt.c:220: warning: Function parameter or struct member 'ptr' not described in 'srpt_qp_event'
drivers/infiniband/ulp/srpt/ib_srpt.c:220: warning: Excess function parameter 'ch' description in 'srpt_qp_event'
drivers/infiniband/ulp/srpt/ib_srpt.c:220: warning: Function parameter or struct member 'ptr' not described in 'srpt_qp_event'
drivers/infiniband/ulp/srpt/ib_srpt.c:220: warning: Excess function parameter 'ch' description in 'srpt_qp_event'


> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 0875f197118f..942b311b6296 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -216,8 +216,10 @@ static const char *get_ch_state_name(enum rdma_ch_state s)
>   * @event: Description of the event that occurred.
>   * @ch: SRPT RDMA channel.
>   */
> -static void srpt_qp_event(struct ib_event *event, struct srpt_rdma_ch *ch)
> +static void srpt_qp_event(struct ib_event *event, void *ptr)
>  {
> +	struct srpt_rdma_ch *ch = ptr;
> +
>  	pr_debug("QP event %d on ch=%p sess_name=%s-%d state=%s\n",
>  		 event->event, ch, ch->sess_name, ch->qp->qp_num,
>  		 get_ch_state_name(ch->state));
> @@ -1811,8 +1813,7 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
>  	ch->cq_size = ch->rq_size + sq_size;
>  
>  	qp_init->qp_context = (void *)ch;
> -	qp_init->event_handler
> -		= (void(*)(struct ib_event *, void*))srpt_qp_event;
> +	qp_init->event_handler = srpt_qp_event;
>  	qp_init->send_cq = ch->cq;
>  	qp_init->recv_cq = ch->cq;
>  	qp_init->sq_sig_type = IB_SIGNAL_REQ_WR;
> -- 
> 2.39.2
> 

