Return-Path: <linux-rdma+bounces-11847-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B250DAF60BB
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 20:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8501D7B53A6
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 18:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB3B30E821;
	Wed,  2 Jul 2025 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTW+SqDO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7CA30AAD2;
	Wed,  2 Jul 2025 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479368; cv=none; b=USEOzGRjUZd7RtzvLB5KeyraPtTYdfs/V3nBSQbCmN3VHmn724tLAcft/f3w6uzKEbC4tY3ExM34Mh5OzQc1eC6HHfSuNYyNo7I8n77mSEid6Dz9BphFfFb8NOc9UWXt7Mv35Fk2J4qgjeLSlGGhi2wd6i+lv92Q52rm2vNNUdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479368; c=relaxed/simple;
	bh=9Jva+FUFd+WMjvRdwYglGsBefAHSYxrAouNCnelCBdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B72eqcGBQEzDYTy6nCPsjS4HY7I3OVNhtO/K+7CzwrhyiLGDpa0KA1onz0v+K4/1IcMkVPkzZAnOmyQJ5cLRtA6WL0M8zxPz+tky+YSorbRzK+SSJhe+TJYq8Api1S9pep5cLrulvM8kgeQqHV5Tg+l0O5KmOCn7XU9FUw/RRLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTW+SqDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD69C4CEE7;
	Wed,  2 Jul 2025 18:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751479367;
	bh=9Jva+FUFd+WMjvRdwYglGsBefAHSYxrAouNCnelCBdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cTW+SqDOSrJ3/CzLAnekqMNZDc3/mp2hGo/XU5dTcHR2PdpbKetSRxqw5V5IE9I/T
	 cwhfy1BlZuosPUcQCFEQYkFSPRf0C6rNewcNi9XBx/vlih0EMG8fV/prZzZ51TLqUZ
	 H/OheYSeEUC5wXzcbJFFo/UhqHHM7fQMPl+PqxUXn5R82OIy9sWy5rr/+5oPSoz+WA
	 cCJ45PAQKK7EwbNJKyoPIaozcm2jBaNt7pSCOEbKMYVRt6xMHKsuFq0kEyuxR0ngG7
	 HGPYSqXSFlS8EXx9EIe5oOYwley/eM5sU8ccSiEgfeaner5RBtg7e3TBsQNv0uQvbN
	 mHUlHLytXOzeQ==
Date: Wed, 2 Jul 2025 21:02:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Simon Horman <horms@kernel.org>
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
Message-ID: <20250702180243.GL6278@unreal>
References: <78cf89b5d8452caf1e979350b30ada6904362f66.1751451780.git.leon@kernel.org>
 <20250702144106.GF41770@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702144106.GF41770@horms.kernel.org>

On Wed, Jul 02, 2025 at 03:41:06PM +0100, Simon Horman wrote:
> On Wed, Jul 02, 2025 at 01:24:04PM +0300, Leon Romanovsky wrote:
> > From: Patrisious Haddad <phaddad@nvidia.com>
> > 
> > Failing during the initialization of root_namespace didn't cleanup
> > the priorities of the namespace on which the failure occurred.
> > 
> > Properly cleanup said priorities on failure.
> > 
> > Fixes: e6746b0c7423 ("net/mlx5: fs, add multiple prios to RDMA TRANSPORT steering domain")
> 
> Hi Leon and Patrisious,
> 
> Maybe there has been a rebase, there is something weird on my side, or for
> some reason it doesn't matter. But I see a different hash in mlx5-next [1].
> 
> Fixes: 52931f55159e ("net/mlx5: fs, add multiple prios to RDMA TRANSPORT steering domain")
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next
> 
> > Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Otherwise, LGTM.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks a lot, you are right about Fixes lines, I fixed it locally when
applied the patch.

> 

