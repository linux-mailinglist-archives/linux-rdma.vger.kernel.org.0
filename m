Return-Path: <linux-rdma+bounces-6889-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770EEA04432
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 16:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E26F1666DE
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2D21F37A0;
	Tue,  7 Jan 2025 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEtXvzld"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368041F239B;
	Tue,  7 Jan 2025 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263497; cv=none; b=tSbnLRU6RZUL/1MRAAqxoIMheoW6Gx3dyCO6CRLnwKDOYKrdIVtBqaiwHEQXELTcRFiyaOAhIG9wOygpaTlm0t8HQ79Q7r1sIlDSp0SvzRGcFfnu+CMBI5gv8hH92w7SU8RUxZn1UjP7ScW0mv+Kp/8ynV5QcnwoepNjMJa5K9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263497; c=relaxed/simple;
	bh=AyibEnSH7sdYvbLamA8Gf2EJwq+kgDKu/gmWbJokmgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8Td/LkysmM5vgbLOyxFSXIP5ajOm3cIgaPve56lgWreVWrixF6cPWcKXKVx9wa4VNnUzjuyjMQhkosQNhr8K5EIa/VZHkhT9pcf4p0aGG8RQHBftA8bDO25tIqt1hxB4E/L2iqoG5k+bxmlfw5rcWTxBikl68j0JOwKikGg7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEtXvzld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817D9C4CED6;
	Tue,  7 Jan 2025 15:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736263497;
	bh=AyibEnSH7sdYvbLamA8Gf2EJwq+kgDKu/gmWbJokmgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IEtXvzldV+2++laHV09SEZcWqIYdGwsu/Swz+H3t20cx7hwhCLOOSRqfcDjSrtavT
	 2XzulOc0eF5UmEU/G7k1DaUlnhg25aJCs6dbL2R1kkIlGUZcu74Qimw4l/0HPEn36K
	 wFJPO4iu6AQoIE/D03P/xKJr7Zgp1qysjbm8tSLzo/U+Iuo7vi/BGoFJ4GyCGpUqtq
	 pqW7Fpkw7XrkxyLXeWOpR/q4SPf7wFxt3S7GfMv3BwZQ0vwUy0LOAWulJkdElMFD5x
	 dCjV5JjKlWzuiRpggSCoFZcgzRZQAurffmCgyCP3foQnXBqfoJMV/pCMFOHtVxLsks
	 ANR5Ji+V3b3uw==
Date: Tue, 7 Jan 2025 17:24:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com
Subject: Re: [PATCH rdma-next v2 RESEND 2/4] RDMA/bnxt_re: Add Async event
 handling support
Message-ID: <20250107152452.GE87447@unreal>
References: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>
 <20250107024553.2926983-3-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107024553.2926983-3-kalesh-anakkur.purayil@broadcom.com>

On Tue, Jan 07, 2025 at 08:15:50AM +0530, Kalesh AP wrote:
> Using the option provided by Ethernet driver, register for FW Async
> event. During probe, while registeriung with Ethernet driver, provide
> the ulp hook 'ulp_async_notifier' for receiving the firmware events.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h |  1 +
>  drivers/infiniband/hw/bnxt_re/main.c    | 47 +++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)

<...>

> +static void bnxt_re_net_unregister_async_event(struct bnxt_re_dev *rdev)
> +{
> +	int rc;
> +
> +	if (rdev->is_virtfn)
> +		return;
> +
> +	memset(&rdev->event_bitmap, 0, sizeof(rdev->event_bitmap));
> +	rc = bnxt_register_async_events(rdev->en_dev, &rdev->event_bitmap,
> +					ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
> +	if (rc)
> +		ibdev_err(&rdev->ibdev, "Failed to unregister async event");
> +}
> +
> +static void bnxt_re_net_register_async_event(struct bnxt_re_dev *rdev)
> +{
> +	int rc;
> +
> +	if (rdev->is_virtfn)
> +		return;
> +
> +	rdev->event_bitmap |= (1 << ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
> +	rc = bnxt_register_async_events(rdev->en_dev, &rdev->event_bitmap,
> +					ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
> +	if (rc)
> +		ibdev_err(&rdev->ibdev, "Failed to unregister async event");

s/Failed to unregister async event/Failed to register async event

If it is the only comment, we will get for this series. You don't need to resend, I'll fix it.

Thanks

> +}

