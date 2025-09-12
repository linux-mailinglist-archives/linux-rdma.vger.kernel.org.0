Return-Path: <linux-rdma+bounces-13316-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A56DB5507D
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 16:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657ED7C3F33
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8827E30F924;
	Fri, 12 Sep 2025 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3pBrEpn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB6A12FF69;
	Fri, 12 Sep 2025 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686284; cv=none; b=gFQD3vcnAbFL0BdWn6c9U4QUoGTqsSi189D28KDsxlscWE70AgHv66LQDxclmGEwzcTLDCH3I2hXEn6+UhHbjvpZedrURCjZuqF3lJcLSY/b6mZjtmr8H3Gw0wmqJUzt7wY0YhK9I0HCQ3tm+4gOfaXBVSilSnqxkHbE+2BbS28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686284; c=relaxed/simple;
	bh=rBpG3eaqLE9M10FwEe6tvyrr+q2pih8o8QYHwXGHIJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtnoPHBmHZ6HRKNy6Y8DswI6lVNuuCT/0vn9RowfuVdzp1EZHRT+7jWY9saL00TvyihyeEP1fMZ4r1iM6xVGNaJUVSWh3mW8BQ2rnBnnUKcU/cZk6S6Cao1hu8uNgezvqnG0hIAgCcMWLZNSHngwqsCkA8Lh2FTHqA9zXHQ1Ils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3pBrEpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13FBC4CEF1;
	Fri, 12 Sep 2025 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757686283;
	bh=rBpG3eaqLE9M10FwEe6tvyrr+q2pih8o8QYHwXGHIJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N3pBrEpny58EMToJA0KxQT5/B1xODZ5G9khzbVeSNeHdCYtuBDTFWzKnjTwzEe39t
	 /DxSlmTrwvoXo3rSqyTPlEircc94HAc7PT9ZHhYlJIv6DFbiSopCF+KmQrz2yxWUql
	 u0dT/N+psXzEdTfemm2qmY0Y0NESqg3XxJgNIevQ0OqWtBxvcaCkAZhTZHOrhtkoNl
	 8q6W4yCQw23yRoxNS1PNFLMHx7Po7/SRF3DU+XYkQgPyesGw1INu8QAZDFc7tMXZea
	 XL9ub5OPLUaZpjOA/g5Su8bzF32d2r6xJX500CfZxdFD/iw3eQ5q1d4wAPkCaCYOh9
	 e0O2pKFGpFSJg==
Date: Fri, 12 Sep 2025 15:11:18 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH net-next 3/4] net/mlx5: Add net namespace support to
 devcom
Message-ID: <20250912141118.GD30363@horms.kernel.org>
References: <1757572267-601785-1-git-send-email-tariqt@nvidia.com>
 <1757572267-601785-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757572267-601785-4-git-send-email-tariqt@nvidia.com>

On Thu, Sep 11, 2025 at 09:31:06AM +0300, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Extend the devcom framework to support namespace-aware components.
> 
> The existing devcom matching logic was based solely on numeric keys,
> limiting its use to the global (init_net) scope or requiring clients
> to ignore namespaces altogether, both of which are incorrect in
> multi-namespace environments.
> 
> This patch introduces namespace support by allowing devcom clients to
> provide a namespace match attribute. The devcom pairing mechanism is
> updated to compare the namespace, enabling proper isolation and
> interaction of components across different net namespaces.
> 
> With this change, components that require namespace aware pairing,
> such as SD groups or LAG, can now work correctly in multi-namespace
> scenarios. In particular, this opens the way to support hardware LAG
> within a net namespace.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

I've reviewed this with the assumptions that; mlx5_core_net() returns the
devlink net namespace, and; that the devlink net namespace is fixed.

With those assumptions, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

