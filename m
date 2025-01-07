Return-Path: <linux-rdma+bounces-6877-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5EFA03C2E
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 11:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D931661D6
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 10:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270A21E47C8;
	Tue,  7 Jan 2025 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsLh5MsE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E451E3DE8
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jan 2025 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736245156; cv=none; b=OpUxwTdm8IamOOoIocvAwc9i+VFbavH06j3f9Lym4Lr3XUx0UjpUXoM2g44MI7ccRAIggLl/8zRjygLnCJ0DmTq4iwEhUu1HICvdjCn1LAZSXQsu+IMGb+2N5JBQJeZuWoiYM8m/yMtCl1q733JQVypiMgdP7Bv95v6lUOmgR/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736245156; c=relaxed/simple;
	bh=pRqxukP27Qcyi2SIR3OQy9/ovYviZz1XUAExAz980q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWElA1Kjmrh+g/SsKpKfEaojqfdEYZh/8mQcHQtBV+qZ3z7WkJN0Rpjgf2TpBtPDMyk2A4dgQD6kx2PvCB2RF/bORrT8Zw7TbuEJ3tjS5PGH7vk+Ec20sDeE4J8lofE81Z9HCu8Wbb1euY/w3Rhb5pTtu5uvtZUZACzMFuiHUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsLh5MsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EBCC4CEDD;
	Tue,  7 Jan 2025 10:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736245156;
	bh=pRqxukP27Qcyi2SIR3OQy9/ovYviZz1XUAExAz980q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsLh5MsEwBM8M1ElRCmxwlHWWrnx/mkvlzqpSUojyGMaVGK87NcCYodNWz2s7++QF
	 xn7CbGO3lyhBsY8xQjyTJWM5GeMPVF0B/vMiz4ap25/+8KfPrKF5cIlNvszBYj0Qbb
	 ZFuEBnEY6VpkWVKDvw4daoMGxscm/n8GZ/VV3JOZYDeTN2GiNYBTh6lczIWxE087zX
	 4biRxdR1cpKEltgY0LsycfC9HLRynyvYOInkexDSQAQg3rDrVPkwwgSVuXgPEBoac4
	 bncpQAaMbgs5eJwSzxbvse9T7N9iNB/miClI8SWPwqUyMZVhIaxleNuHZ6I2VuSr/7
	 q9n1Sw6s94Q6w==
Date: Tue, 7 Jan 2025 12:19:11 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, bharat@chelsio.com
Subject: Re: [PATCH for-rc v2] RDMA/cxgb4: notify rdma stack for
 IB_EVENT_QP_LAST_WQE_REACHED event
Message-ID: <20250107101911.GA87447@unreal>
References: <20250107095053.81007-1-anumula@chelsio.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107095053.81007-1-anumula@chelsio.com>

On Tue, Jan 07, 2025 at 03:20:53PM +0530, Anumula Murali Mohan Reddy wrote:
> This patch sends IB_EVENT_QP_LAST_WQE_REACHED event on a QP that is in
> error state and associated with an SRQ. This behaviour is incorporated
> in flush_qp() which is called when QP transitions to error state.
> Supports SRQ drain functionality added by commit 844bc12e6da3 ("IB/core:
> add support for draining Shared receive queues")
> 
> Fixes: 844bc12e6da3 ("IB/core: add support for draining Shared receive queues")
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
> Changes since v1:
> Addressed previous review comments

There are two review comments. One is Fixes line, which is not a big deal
as I can add it when applying patch, but what about second comment?

Why is this event limited to QP with SRQ only?
https://lore.kernel.org/all/20250105090622.GA5511@unreal/

Thanks

> ---
>  drivers/infiniband/hw/cxgb4/qp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
> index 7b5c4522b426..10f61bc16dd5 100644
> --- a/drivers/infiniband/hw/cxgb4/qp.c
> +++ b/drivers/infiniband/hw/cxgb4/qp.c
> @@ -1599,6 +1599,7 @@ static void __flush_qp(struct c4iw_qp *qhp, struct c4iw_cq *rchp,
>  	int count;
>  	int rq_flushed = 0, sq_flushed;
>  	unsigned long flag;
> +	struct ib_event ev;
>  
>  	pr_debug("qhp %p rchp %p schp %p\n", qhp, rchp, schp);
>  
> @@ -1607,6 +1608,14 @@ static void __flush_qp(struct c4iw_qp *qhp, struct c4iw_cq *rchp,
>  	if (schp != rchp)
>  		spin_lock(&schp->lock);
>  	spin_lock(&qhp->lock);
> +	if (qhp->srq) {
> +		if (qhp->attr.state == C4IW_QP_STATE_ERROR && qhp->ibqp.event_handler) {
> +			ev.device = qhp->ibqp.device;
> +			ev.element.qp = &qhp->ibqp;
> +			ev.event = IB_EVENT_QP_LAST_WQE_REACHED;
> +			qhp->ibqp.event_handler(&ev, qhp->ibqp.qp_context);
> +		}
> +	}
>  
>  	if (qhp->wq.flushed) {
>  		spin_unlock(&qhp->lock);
> -- 
> 2.39.3
> 
> 

