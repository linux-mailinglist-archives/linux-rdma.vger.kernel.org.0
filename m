Return-Path: <linux-rdma+bounces-7397-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEEEA26EDD
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 10:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01109161CC2
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 09:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3292080C1;
	Tue,  4 Feb 2025 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HA3Feqks"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8BA207E14
	for <linux-rdma@vger.kernel.org>; Tue,  4 Feb 2025 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663016; cv=none; b=NZYF6eQy6pCRTyzt/9NxzreGDITl4HsM0Yz/28cBYArmJvxkLYeI3YlvSJ/6MewO7oOprPlB5EMKBgv3b0qPuBLvNLfiAKSa2dV1P8YKQjzqcDCZ5BxomG5LWoo8Pb+I/VFAHVCkey+fh41vDyRd1+fbo3CkxL6xsYaGS1Yvudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663016; c=relaxed/simple;
	bh=BIiH3i9O+2HMX+rFLAhInnWht9lYpAkgxqYa/w+MEgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjqN/dlMSHj17UavrR/uEWzwY472Vc03Idlbew7FbvHrV6vJtrxS7nFP+tZsvk1qi1iCtNdK2naVIsaDON8X6K3v6AiMu+6uho2CwEnayOAgp5dnw9dnffDNeA72xC9plXJ3zm5ZcpfU27biDw6gckITtK9VolIv9GaWzTe9ptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HA3Feqks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F357C4CEDF;
	Tue,  4 Feb 2025 09:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738663016;
	bh=BIiH3i9O+2HMX+rFLAhInnWht9lYpAkgxqYa/w+MEgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HA3FeqksVVDUEZ7Q6uDXmQQw/x9d0Vc5a6HxL2OWKJPYJEt8deWCkqxnjmhu24JtE
	 M2dlisbVQKpPHHj8tAsztxkmjBqxG7PRrkx5zSHk7ChVPolGAVMAMf7plamMGz8/I4
	 g7bxtRnyX3oL9gNWSBIp2FiRwAnKCNcUQC/IO8qQt62z1uujLBwVR1Y9Epl3X8pdDr
	 hdKqo63W39OsN0YkTAXaHfXdZoMeLp0ApbhpAMBLccrCTcV7gLZc31lOxrQtBbHZQr
	 rwopWvEHUfmKs+mxPK335Kn3KFUw0v6exhsIXns4Kh4WEUFcirkABmniDzWYzh6Bts
	 OR+dPlB3y61uQ==
Date: Tue, 4 Feb 2025 11:56:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next] RDMA/bnxt_re: Fix the error due to the array
 depth
Message-ID: <20250204095651.GI74886@unreal>
References: <1738659966-26557-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1738659966-26557-1-git-send-email-selvin.xavier@broadcom.com>

On Tue, Feb 04, 2025 at 01:06:06AM -0800, Selvin Xavier wrote:
> Fixing the issue reported by kernel test robot
> 
> drivers/infiniband/hw/bnxt_re/debugfs.h:34:40: error: variably modified 'gen0_parms' at file scope
> 
> Using the fixed size depth for the array.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502041114.K8XQYeJg-lkp@intel.com/
> Fixes: a3c71713d954 ("RDMA/bnxt_re: Congestion control settings using debugfs hook")
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/debugfs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, I squashed this patch into "RDMA/bnxt_re: Congestion control
settings using debugfs hook".

