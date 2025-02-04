Return-Path: <linux-rdma+bounces-7400-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F2DA2708E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 12:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F06247A478B
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926220CCF0;
	Tue,  4 Feb 2025 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC711sTT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6820CCE5
	for <linux-rdma@vger.kernel.org>; Tue,  4 Feb 2025 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738669447; cv=none; b=iKONEHeFHyx0PFW98ymmXpLSJK/ZuNXFlacFzI9xF9Sn2RkjkQnYD9BGFrM8nEHkC8iZkXo6fTTiHvE3zhcv/WfMT0oxaeEYOkbET5ua7WRtuO9kKFVWjaTQIId4cVeMMy1T3u6bHuXwYl0b6Ved/5T1g/Nk4YK+DXFdNtQHCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738669447; c=relaxed/simple;
	bh=46o5ZEwG1OoY7SaQoJs7GzG/EpFgd3H7lFIB03WWiYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoSjcBPoyqA7B+miwWU2pJ1rA6foTOwv8noz223lIO1qg0Smke/O9khqO8MM9LQO+IqSl/wXRl/eTUryonG6kG4BYi18sFVzky4VG1nzV8ekY9nxif1s9hQTqEPbhTHzlCoo8MBgjAERhNatdwX6leKCGsUzKJeI/npOuj1BgkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC711sTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B70BC4CEE2;
	Tue,  4 Feb 2025 11:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738669446;
	bh=46o5ZEwG1OoY7SaQoJs7GzG/EpFgd3H7lFIB03WWiYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oC711sTT131NUCalc4faYN06fvuR6kWwNc03l0cbcd064n05fht/HRD+/E/xi5h5m
	 5DUPSzvm070fUlhL2cB4CchifB2ITWzzLurkLOBDX/HKS0XZsqMea0wbKgoxFrziT6
	 mu48qdEp1drrX65OQA1Zc35tKLtljyp3DKG9wsJJJ3FBUs8uwPC5h9aBwXXzsOR1aG
	 WdnHO/Tiq/LryzwvV6HMXeURYgBXwIJ6ZBKMvqXUYMy+dccCXTLAR29AB3Uz+ajr1b
	 GUuRCY29LPNMI/o6JAR0vDEYEWfCUm1Joc9bwrjedhJiRtKftRjd4ce2v8YMbrv3bd
	 Pi4C+PD9gycHQ==
Date: Tue, 4 Feb 2025 13:44:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-rc 2/4] RDMA/bnxt_re: Add sanity checks on rdev
 validity
Message-ID: <20250204114400.GK74886@unreal>
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
 <1738657285-23968-3-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1738657285-23968-3-git-send-email-selvin.xavier@broadcom.com>

On Tue, Feb 04, 2025 at 12:21:23AM -0800, Selvin Xavier wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> There is a possibility that ulp_irq_stop and ulp_irq_start
> callbacks will be called when the device is in detached state.
> This can cause a crash due to NULL pointer dereference as
> the rdev is already freed.

Description and code doesn't match. If "possibility" exists, there is
no protection from concurrent detach and ulp_irq_stop. If there is such
protection, they can't race.

The main idea of auxiliary bus is to remove the need to implement driver
specific ops.

> 
> Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW error is detected")
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index c4c3d67..89ac5c2 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -438,6 +438,8 @@ static void bnxt_re_stop_irq(void *handle, bool reset)
>  	int indx;
>  
>  	rdev = en_info->rdev;
> +	if (!rdev)
> +		return;

This can be seen as an example why I'm so negative about assigning NULL
to the pointers after object is destroyed. Such assignment makes layer
violation much easier job to do.

Thanks

>  	rcfw = &rdev->rcfw;
>  
>  	if (reset) {
> @@ -466,6 +468,8 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
>  	int indx, rc;
>  
>  	rdev = en_info->rdev;
> +	if (!rdev)
> +		return;
>  	msix_ent = rdev->nqr->msix_entries;
>  	rcfw = &rdev->rcfw;
>  	if (!ent) {
> @@ -2438,6 +2442,7 @@ static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
>  	ibdev_info(&rdev->ibdev, "%s: L2 driver notified to stop en_state 0x%lx",
>  		   __func__, en_dev->en_state);
>  	bnxt_re_remove_device(rdev, BNXT_RE_PRE_RECOVERY_REMOVE, adev);
> +	bnxt_re_update_en_info_rdev(NULL, en_info, adev);
>  	mutex_unlock(&bnxt_re_mutex);
>  
>  	return 0;
> -- 
> 2.5.5
> 

