Return-Path: <linux-rdma+bounces-6263-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5EB9E5007
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 09:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C5A16994A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 08:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA9E1D45F2;
	Thu,  5 Dec 2024 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQOqJ4UC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC9826AFF
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388160; cv=none; b=HLkRwjL2EdOcPtO/jDNQZsI5p1xCB2IQmjpXa5epWQQtRfJGZZeNbrzhQdR7x0zFgPPzvh37lDu9+PktQl5ieSA+c03yvjiu54r7wYJV1LhfMzmVRlGjmQrUsGxxCL5FbeR4qR7CSL625OtrjYSWDWJq+AHP1/2mwcR3CSIhloI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388160; c=relaxed/simple;
	bh=LJspr8J2PZoOfk/+RVs39Ac6XaLHU+L4bI/kDAl+Fog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfjKTxSq+je8UBjZy3d1KtiUdSSJA9cUxfMPw/NFsW/1kEkbgFgViLRnRowV43tzEFZDUa32fGebY6J0tetZ8o3dptQ0PBmYNkuIxK3TR8TPvJAtyEomUY0ZNREoqc7ch5cYPVDuF54AewWCvexCSIsf6oi/LkXQUFutG8nuYas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQOqJ4UC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8E2C4CED1;
	Thu,  5 Dec 2024 08:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733388159;
	bh=LJspr8J2PZoOfk/+RVs39Ac6XaLHU+L4bI/kDAl+Fog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQOqJ4UCypKXia3eI+UjE4fS17kYVxdJusWQO2FW50nED7P4SHWfiDslNfBZWdErv
	 yM+K3eyoPKVADnCHabOYGoif0dWI0Q+/gRJ5aamDrSdUhMDCIv18Uzv9iZbDJSCC49
	 D46gfOJiM/X3fxr3SlWwZ/HO/pISlfdAFdePywZjvFcQf93mFnWKQtJzNyT1Kovkm+
	 95djWvPl7R0r+ZNI9TLi3x+7tZtSUSFupiX1akRpxYE4bXbSYx17xW+KN58YWz3zMJ
	 34K6SX9zmzvoBYukkO2aaiCMN/HV9ce1G3NU6Uis9XkYeusyVamn+DHiQsgKa82Mzp
	 PdFrEHf4nQ2qw==
Date: Thu, 5 Dec 2024 10:42:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, bharat@chelsio.com
Subject: Re: [PATCH for-rc v2] RDMA/core: Fix ENODEV error for iWARP test
 over vlan
Message-ID: <20241205084234.GT1245331@unreal>
References: <20241203140052.3985-1-anumula@chelsio.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203140052.3985-1-anumula@chelsio.com>

On Tue, Dec 03, 2024 at 07:30:53PM +0530, Anumula Murali Mohan Reddy wrote:
> If traffic is over vlan, cma_validate_port() fails to match
> net_device ifindex with bound_if_index and results in ENODEV error.
> As iWARP gid table is static, it contains entry corresponding  to
> only one net device which is either real netdev or vlan netdev for
> cases like  siw attached to a vlan interface.
> This patch fixes the issue by assigning bound_if_index with net
> device index, if real net device obtained from bound if index matches
> with net device retrieved from gid table
> 
> Fixes: f8ef1be816bf ("RDMA/cma: Avoid GID lookups on iWARP devices")
> Link: https://lore.kernel.org/all/ZzNgdrjo1kSCGbRz@chelsio.com/
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
> Changes since v1:
> Addressed previous review comments
> ---
>  drivers/infiniband/core/cma.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

I added this patch to our regression run, if everything works, I will
merge it next week.

Thanks

