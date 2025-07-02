Return-Path: <linux-rdma+bounces-11838-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E097AF5B5B
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 16:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBFC52078B
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D98309DAD;
	Wed,  2 Jul 2025 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx+t9G6j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D20309DA2;
	Wed,  2 Jul 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467271; cv=none; b=XCUh2JRaxpz+YVPd3wpYT0fJyTB4Kq1V3VLb9/Ah8YN8IsUC89F8PwoSv4iYU8DJDPTWFTfgJLDCvBzpuOaj6cK68YfUIg1gZz2PGAuBjixHREFU/pA9sjx+V+rdTBBtETfmac7Eq7U5hoQ897S4jN693mGBbgxABDoB3scDGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467271; c=relaxed/simple;
	bh=GuwRVD/Uyg3Uu3CqWllUlTZS5g06hIK2uOZsGz6LAgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coJXlZLCVQAGZqhsxyqKMYGow+IZr3jYhNEd9MjWYy86+lQoUczyP6aMwB/Rt/i8X4nIU2ROfBJux/gZqt6KUih1U49F30LS1q0ad+4AHWwvM7dUMCmvOGuqqOYtlq/foc4/3R2gX259Z87Tp8PiZlPOSH4IH3ajq/tmKua7Hi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx+t9G6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CD3C4CEE7;
	Wed,  2 Jul 2025 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751467270;
	bh=GuwRVD/Uyg3Uu3CqWllUlTZS5g06hIK2uOZsGz6LAgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mx+t9G6jLcvfp9KBRuE6eWMP0bw732dFZIQa4cvx2vLeYTWD3TYnU/1oFaUDXPZyT
	 8j4mZlB6NJsTi+BFqxQgBp9xD9AU/tMihhSIRT/BmihXYd70DmBFSge8YUPx9MnGuk
	 lm5q3Y6CpAQ5/XwS0CVGVV3YiviwDdv6tzsJhSUzAolgzbODnKwTJdd2dwOUfpW0Tk
	 rNJNz+dagsFCS0c1DFN69L86an5d69fl6745fp9FHGhYP3jLfe7Okc3AR+s/XHreD0
	 2JBthzule/XwSXHQAf3RaZ6ElGShvnkjQW+BmEHMswEgHF+P3WIVTUJGHmy2eEwmZw
	 p6cQuQfbdtH9w==
Date: Wed, 2 Jul 2025 15:41:06 +0100
From: Simon Horman <horms@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next] net/mlx5: fs, fix RDMA TRANSPORT init cleanup
 flow
Message-ID: <20250702144106.GF41770@horms.kernel.org>
References: <78cf89b5d8452caf1e979350b30ada6904362f66.1751451780.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78cf89b5d8452caf1e979350b30ada6904362f66.1751451780.git.leon@kernel.org>

On Wed, Jul 02, 2025 at 01:24:04PM +0300, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Failing during the initialization of root_namespace didn't cleanup
> the priorities of the namespace on which the failure occurred.
> 
> Properly cleanup said priorities on failure.
> 
> Fixes: e6746b0c7423 ("net/mlx5: fs, add multiple prios to RDMA TRANSPORT steering domain")

Hi Leon and Patrisious,

Maybe there has been a rebase, there is something weird on my side, or for
some reason it doesn't matter. But I see a different hash in mlx5-next [1].

Fixes: 52931f55159e ("net/mlx5: fs, add multiple prios to RDMA TRANSPORT steering domain")

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next

> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Otherwise, LGTM.

Reviewed-by: Simon Horman <horms@kernel.org>


