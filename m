Return-Path: <linux-rdma+bounces-802-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 738AB840B6D
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jan 2024 17:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B92B277E2
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jan 2024 16:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F223158D65;
	Mon, 29 Jan 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KHaGZ+Vk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EFC1586E9;
	Mon, 29 Jan 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545685; cv=none; b=heXqYskJJ+R4C62H6Tcn7sYENEb8/TeFlz7GdJyGxiv2y1pFDEV25/jAk21MZrJQCUpmeoYxvqbWwIfRAHf0z2zsFF/mKZLPeu/742ktzijwilTP4WmIxt/2L+qQCKmxc75prEhUAZfX8eNg/rv9nTzXEcWxzwGuLj5X+5Yb4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545685; c=relaxed/simple;
	bh=ENdXUOpq1v8IP9es9Ii2NQgnRKNefy/wgebpGtDK/wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myi3Mz7/bVQwIkj4iyBNZ2hXayr0xqAYci21GwQl65vXlUmklA6397OrzYQaLO7dwXrMMp2CIdfp6qDG9ik87KTDyhQ3KuP6fRckdkZX8nCxWX2DmSiZoe/4gIQz8EM2pqPyxv619o617kMnjYbTl9ZhiVYy7dJ4c7616HWQJQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KHaGZ+Vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678A2C43399;
	Mon, 29 Jan 2024 16:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706545684;
	bh=ENdXUOpq1v8IP9es9Ii2NQgnRKNefy/wgebpGtDK/wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHaGZ+VkdAKqV1VIcfkzPtiBCFsKeab2vqcWnZmzS8MyGd0km7I8P5LrQfs34l5Jp
	 9gtWwN0eH7dqfb6kG4nAVOQsc9GtEN4VqRgp+7XpedgyMVopuSzJ2iJ/v9/XJiGYQU
	 90PDUPfO2fexwxd98FhdCR3K1mpAcbyRabF/Yl8I=
Date: Mon, 29 Jan 2024 08:28:03 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-stable <stable@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
	linux-rdma@vger.kernel.org, lkft-triage@lists.linaro.org,
	Sasha Levin <sashal@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: stable-rc: 6.1: mlx5: params.c:994:53: error:
 'MLX5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
Message-ID: <2024012915-enlighten-dreadlock-54e9@gregkh>
References: <CA+G9fYvYQRnBbZhHknSKbwYiCr_3vPwC5zPz2NsV9_1F7=paQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvYQRnBbZhHknSKbwYiCr_3vPwC5zPz2NsV9_1F7=paQQ@mail.gmail.com>

On Mon, Jan 29, 2024 at 09:17:31PM +0530, Naresh Kamboju wrote:
> Following build errors noticed on stable-rc linux-6.1.y for arm64.
> 
> arm64:
> --------
>   * build/gcc-13-lkftconfig
>   * build/gcc-13-lkftconfig-kunit
>   * build/clang-nightly-lkftconfig
>   * build/clang-17-lkftconfig-no-kselftest-frag
>   * build/gcc-13-lkftconfig-devicetree
>   * build/clang-lkftconfig
>   * build/gcc-13-lkftconfig-perf
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build errors:
> ------
> drivers/net/ethernet/mellanox/mlx5/core/en/params.c: In function
> 'mlx5e_build_sq_param':
> drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: error:
> 'MLX5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
>   994 |                     (mlx5_ipsec_device_caps(mdev) &
> MLX5_IPSEC_CAP_CRYPTO);
>       |
> ^~~~~~~~~~~~~~~~~~~~~
> 
> Suspecting commit:
>   net/mlx5e: Allow software parsing when IPsec crypto is enabled
>   [ Upstream commit 20f5468a7988dedd94a57ba8acd65ebda6a59723 ]

Something looks very odd here, as the proper .h file is being included,
AND this isn't a build failure on x86, so why is this only arm64 having
problems?  What's causing this not to show up?

thanks,

greg k-h

