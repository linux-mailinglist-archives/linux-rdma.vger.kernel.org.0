Return-Path: <linux-rdma+bounces-5930-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC319C5068
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 09:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE04B23F6B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 08:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6F320B80B;
	Tue, 12 Nov 2024 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPqfli8q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA04209F43
	for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399473; cv=none; b=OuteVb0YwOz4Qef1CMzrBMTFtGKBv/Q/rODlCFNAAuIbs/Howu0FSnXm/+BlchQ7Kx9eKOr7IqoIIi4+9wodFXh4e0s1qEi0Pf0PxNoYoS3iK+lp0JfsiK4lAiP5AcjCTRVNcdDqO2C3VPc8nM1PEiVL1nQUg+k/LaTSpnJU8r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399473; c=relaxed/simple;
	bh=btYoDioZqFaM3h4NzeJIQcCWJohvgSKPjjaYiOiTJis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXdXNk3/jjf1mQVuM+ME211nPMRjWs8peb9doBBMXLh6RX6nbHimRUh8oGpRYr1gxxaNaLSsUqqIVYKlYNma6xRYODpUBWlartHrQjETvFb8HTtkLIWozgtpJTuAfNxjQ55oluXkM69KmGa6xnmci6iRx/JVrQR4Dl1Coh4gNpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPqfli8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD86C4CECD;
	Tue, 12 Nov 2024 08:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731399473;
	bh=btYoDioZqFaM3h4NzeJIQcCWJohvgSKPjjaYiOiTJis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPqfli8qml/tjsBSWZHYRluxtkWlYiaPDoNt94prCiKFASZeTZjStoWdkbV7qJpwD
	 G3LBbNpr4GQP7adNpdqY25Y4VPX5wOY8Lnn1nC7CvwMAn8QCARauD0xieHCHJ2BHCP
	 prWmYEj/ADOKBMBoQRemeJVTYsrhQPFnyKboBDxJ+8jXC+cQ8Ptfmagn5RtfWPfjKA
	 O2cu3LKh1Q28HKdMmG/odM51k5W2DE6luS9/t+hi6G98A1OEufE35YT30XEvYR5/0N
	 NRwIdUsBx3CcPN1yLRq9g12TpkZCTRdjOtS0HsjjwAnAVcLdH+f76Px3IzB3T3SJxr
	 //G4AA6sQUluA==
Date: Tue, 12 Nov 2024 10:17:46 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [rdma-next 5/5] RDMA/bnxt_re: Add new function to setup NQs
Message-ID: <20241112081746.GI71181@unreal>
References: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
 <1731055359-12603-6-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1731055359-12603-6-git-send-email-selvin.xavier@broadcom.com>

On Fri, Nov 08, 2024 at 12:42:39AM -0800, Selvin Xavier wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> Move the logic to setup and enable NQs to a new function.
> Similarly moved the NQ cleanup logic to a common function.
> Introdued a flag to keep track of NQ allocation status
> and added sanity checks inside bnxt_re_stop_irq() and
> bnxt_re_start_irq() to avoid possible race conditions.
> 
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h |   2 +
>  drivers/infiniband/hw/bnxt_re/main.c    | 204 +++++++++++++++++++-------------
>  2 files changed, 123 insertions(+), 83 deletions(-)

<...>

>  
> +	rtnl_lock();
> +	if (test_and_clear_bit(BNXT_RE_FLAG_SETUP_NQ, &rdev->flags))
> +		bnxt_re_clean_nqs(rdev);
> +	rtnl_unlock();

<...>

> +		rtnl_lock();
>  		bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ctx);
>  		bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
>  		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
>  		bnxt_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
> +		rtnl_unlock();

Please don't add rtnl_lock() to drivers in RDMA subsystem. BNXT driver
is managed through netdev and it is there all proper locking should be
done.

Please work to remove existing rtnl_lock() from bnxt_re_update_en_info_rdev() too.
IMHO that lock is not needed after your driver conversion to auxbus.

Thanks

