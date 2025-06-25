Return-Path: <linux-rdma+bounces-11648-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCEDAE92DF
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 01:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F657BCBDB
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 23:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832F1DF755;
	Wed, 25 Jun 2025 23:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBfAijyO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD62F1FC1;
	Wed, 25 Jun 2025 23:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750894922; cv=none; b=r7xU1LrnYLB4vOjM2Zu7RAt4/7ZcFG5I0YNuG/n0UsH8J5ZWozvrWG5ucplkXplGrjBrhgojZgx6NEgC87/iNFz63cqaTdTcoeESLxu1rrRz7dRtRGsqNAcIFUzpCaeupLiR2rbAqCB8szIBEipaffuZybNzwpfoqgDU/LtRcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750894922; c=relaxed/simple;
	bh=XYurk1xjjfIc6lTB2QIOzbn7VsI9XPb8Y+6r/neSisQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ej9WuHzUBqbxA8IVmJvVMBy3K6+hkOniD7nYMelu0ZSDvUyxU8X6bFDscRVAZUITuy2cqVSiXDFrJewhoF8iQqvhgZFxMig8+BgFhIQpoQKcA8/70CkVS6e8C8GSk2YDkeJAI5eMuZc3NK+NtFfXwevCuMkT8uN09uHcxjeW01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBfAijyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69D9C4CEEA;
	Wed, 25 Jun 2025 23:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750894922;
	bh=XYurk1xjjfIc6lTB2QIOzbn7VsI9XPb8Y+6r/neSisQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EBfAijyOdA/LzgvsDKr9E/I/W9HUtOmVakDgIJt/ZLxLyf5q9YIW+IUEVzRrfTwgl
	 esnEoeG21T8SZp8R348OMYw4iZId2arUbjodZICvBc4aUeP0vfdCb1QGM3pJw1H/0A
	 OiAUN+2KH9aWZ0FoMaVZ6V2jecAupK9rH/zdAu5rY+SflOLcU3TICyvUc4K9VBvlmK
	 feYZ+oPJSmQlQzij6dubIfffd+ijwRl6ZaNeyifF/hAbBlxbr2kwk01fSHMgh25QoN
	 Zoh391KiwSNxM6KqbGUi/R4ZrNLCdgKaTB8FOAY6WRjrS6adhevIlDgvLq8Ayyv+jn
	 Z6Jmi8x66ByRw==
Date: Wed, 25 Jun 2025 16:42:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, linux-rdma@vger.kernel.org, Mark Bloch
 <mbloch@nvidia.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next 1/2] net/mlx5: fs, add multiple prios to RDMA
 TRANSPORT steering domain
Message-ID: <20250625164200.45fb717d@kernel.org>
In-Reply-To: <b299cbb4c8678a33da6e6b6988b5bf6145c54b88.1750148083.git.leon@kernel.org>
References: <cover.1750148083.git.leon@kernel.org>
	<b299cbb4c8678a33da6e6b6988b5bf6145c54b88.1750148083.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 11:19:15 +0300 Leon Romanovsky wrote:
> +	for (i = 0; i < MLX5_RDMA_TRANSPORT_BYPASS_PRIO; i++) {
> +		prio = fs_create_prio(&root_ns->ns, i, 1);
> +		if (IS_ERR(prio))
> +			return PTR_ERR(prio);
> +	}
> +	set_prio_attrs(root_ns);

Looking at the PR now -- y'all sure this doesn't need any extra cleanup
if creation of non-first prio fails?

