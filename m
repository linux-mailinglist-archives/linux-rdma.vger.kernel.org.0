Return-Path: <linux-rdma+bounces-2826-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA258FB1D4
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 14:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001AB28252A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 12:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DE113D609;
	Tue,  4 Jun 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAsEoXk0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C58145B0F;
	Tue,  4 Jun 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502932; cv=none; b=fvmxOvjGXiV9b0KfOlFvng9QsZAfHstFgXfixm9ds2vZAAV91bOmstyWZ1zz719oMSkGj9uoQNc4EiNSAaUWJ4/eXgZmjXGaOoZLjBTMC7wFIwa/okv5I9l/PDuNMAhNp17Bcf6qQN4846HgJpciD1qMkAYywTvcMP/x0dOhao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502932; c=relaxed/simple;
	bh=bgxIOsYWBKkIBR8cDcwU+wqQbc2n7LDeFJWgK0XOkx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWftyO6K2n6ab4K+2pfMYlpv9vxkhH/G0a2XrOHoVpMltu+hWcJVoIELSVwLezitDIyO91LdWixRaTb+JlUoTEXBRmJTJ5K8e3Qso3RnwLMdQL+68Ixv4ZIkwPckxhfOS9bRPhmGYyEiOkdyQNPGWDMiUiasKOcBQiPflIIGISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAsEoXk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A4BC2BBFC;
	Tue,  4 Jun 2024 12:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717502932;
	bh=bgxIOsYWBKkIBR8cDcwU+wqQbc2n7LDeFJWgK0XOkx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAsEoXk0PkW2z9iOxKVFVDH7hWoRF32USmdchbfexaYO9CEisnuvfjwVHwcfZADjM
	 x1RfxvkkmXvZMLrZY7ptMRuPrYiGYbs4nehEtRpwchXus4OD6W2/sbI2KYaUGMisaa
	 9Z2EmXcQYDZNxwkmI9KSLCNSUXdZ5ZIpD838y95GA8eyB1/eg8LtUzIl/zyactoc/O
	 u80oGsBN6+J3G4XzbnLCAGzIOQ7oXN72sRle5L7AfzCy5E2taPujtybzNcT7an5p+E
	 bjXF/srQ6HUBG6Zl7uaiOQAD6yv6ALV8NcnIs28Ch2eyexFZmiOwGyoIZoBKO2Wf/w
	 RLqWpDBJ8rNmw==
Date: Tue, 4 Jun 2024 15:08:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, weh@microsoft.com, sharmaajay@microsoft.com,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Message-ID: <20240604120846.GQ3884@unreal>
References: <1717500963-1108-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717500963-1108-1-git-send-email-kotaranov@linux.microsoft.com>

On Tue, Jun 04, 2024 at 04:36:03AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Process QP fatal events from the error event queue.
> For that, find the QP, using QPN from the event, and then call its
> event_handler. To find the QPs, store created RC QPs in an xarray.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Wei Hu <weh@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c           |  3 ++
>  drivers/infiniband/hw/mana/main.c             | 37 ++++++++++++++++++-
>  drivers/infiniband/hw/mana/mana_ib.h          |  4 ++
>  drivers/infiniband/hw/mana/qp.c               | 11 ++++++
>  .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
>  include/net/mana/gdma.h                       |  1 +
>  6 files changed, 55 insertions(+), 2 deletions(-)

<...>

> +static void
> +mana_ib_event_handler(void *ctx, struct gdma_queue *q, struct gdma_event *event)
> +{
> +	struct mana_ib_dev *mdev = (struct mana_ib_dev *)ctx;
> +	struct mana_ib_qp *qp;
> +	struct ib_event ev;
> +	unsigned long flag;
> +	u32 qpn;
> +
> +	switch (event->type) {
> +	case GDMA_EQE_RNIC_QP_FATAL:
> +		qpn = event->details[0];
> +		xa_lock_irqsave(&mdev->qp_table_rq, flag);
> +		qp = xa_load(&mdev->qp_table_rq, qpn);
> +		if (qp)
> +			refcount_inc(&qp->refcount);
> +		xa_unlock_irqrestore(&mdev->qp_table_rq, flag);
> +		if (!qp)
> +			break;
> +		if (qp->ibqp.event_handler) {
> +			ev.device = qp->ibqp.device;
> +			ev.element.qp = &qp->ibqp;
> +			ev.event = IB_EVENT_QP_FATAL;
> +			qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
> +		}
> +		if (refcount_dec_and_test(&qp->refcount))
> +			complete(&qp->free);
> +		break;
> +	default:
> +		break;
> +	}
> +}

<...>

> @@ -620,6 +626,11 @@ static int mana_ib_destroy_rc_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
>  		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
>  	int i;
>  
> +	xa_erase_irq(&mdev->qp_table_rq, qp->ibqp.qp_num);
> +	if (refcount_dec_and_test(&qp->refcount))
> +		complete(&qp->free);
> +	wait_for_completion(&qp->free);

This flow is unclear to me. You are destroying the QP and need to make
sure that mana_ib_event_handler is not running at that point and not
mess with refcount and complete.

Thanks

