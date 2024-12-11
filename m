Return-Path: <linux-rdma+bounces-6428-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCC59EC8D4
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 10:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85AE188CF90
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 09:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E11C2336A1;
	Wed, 11 Dec 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mpKm2Rk3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10A2336A4;
	Wed, 11 Dec 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908763; cv=none; b=LYLXqYoeAttqrL5pdJb2eMhBJ/Tty+qGtFb02VX8kSnZdLK19KRHTSraEjn1kohXSoTkUxiipJOhgcZ47IVui91zi2O60utT8GCcxU8uq6G08nbRbQ+qtHO2/uqNFnV7Ep5b8sEphOJF7sEA4/IVjrwcuWGyHS30ZGZyIDanR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908763; c=relaxed/simple;
	bh=5Zj9F6Cp4uvMjjvZ3FuxT+1lsAKj5je8ROGKo0mRbJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqasIWTMzx2J3A/lpTfdLjxdHaMI4r3Pxvis2cDUYOlhlJ16eddQFSm0xZdAoVBkVOtoyF0O6qjyZBpKB7nCoj18TuRw0bPdkQmDHQq2qgVIouzhudgnlEDmU7pt7T1xjJjKLgecCWPGqgB0LzykzxiJLJ80mdghsR1d7TjMglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mpKm2Rk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05104C4CED2;
	Wed, 11 Dec 2024 09:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733908762;
	bh=5Zj9F6Cp4uvMjjvZ3FuxT+1lsAKj5je8ROGKo0mRbJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpKm2Rk3FddeI8Ei4uiZbNP7W1JvxK1fjaXlSowmJSskMVf1tZL2SPV1FX+gKZ43s
	 Td3tN+RR+0gxseyXWQYRmOzGJw91VjqZe2az5MyFaENi5MVyPbsCF7lqUeqMCSVDCx
	 hr5qo4trOKn6qjN7jfEsS6DWi7iC2RGNmyX37hos=
Date: Wed, 11 Dec 2024 10:18:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: cratiu@nvidia.com, dtatulea@nvidia.com, tariqt@nvidia.com,
	pabeni@redhat.com, patches@lists.linux.dev, stable@vger.kernel.org,
	saeedm@nvidia.com, leon@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, roid@nvidia.com,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] net/mlx5e: Don't call cleanup on profile rollback
 failure
Message-ID: <2024121114-subsidize-tattered-dd8c@gregkh>
References: <20241211100953.2069964-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211100953.2069964-1-jianqi.ren.cn@windriver.com>

On Wed, Dec 11, 2024 at 06:09:53PM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> [ Upstream commit 4dbc1d1a9f39c3711ad2a40addca04d07d9ab5d0 ]

Please note that we can not apply a commit to an older stable tree that
is NOT in newer ones as you would obviously have a regression when
moving to a newer kernel.

I am guessing that you are being tasked with backporting CVE fixes to
older stable kernels, which is great, but please work "down the release
list" by starting with the newest one, and then moving to the older
ones.  Otherwise we just can't take these and you are causing a lot of
extra review/checking time on our side here to verify you are doing it
all correctly :(

thanks,

greg k-h

