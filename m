Return-Path: <linux-rdma+bounces-12007-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8ACAFEFC9
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 19:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B73E4E7B22
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C73622A4DA;
	Wed,  9 Jul 2025 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhPTv66/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B072367C5;
	Wed,  9 Jul 2025 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081880; cv=none; b=jDzUhsoyZFSakop2FLOla9Es1UXnyN3IJ8ano/LEoRGNkEc3sG+ed5cml86AvwMVsRLXDladpmCfoyfp523o3JX+b1MxwoCqfgVmOSLGbgEtNVx0r5v/i5mpLPRWEucwTs9jSAPm58qIm2LUTVG+bbuPVJ+fwktLgaCrBZZ5Nn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081880; c=relaxed/simple;
	bh=CIOMlgRpUJugmEyrwKD0bvm4X9rssQ6N5IlGBU9Bk5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOU2+GEou44AHqg8rcY0uF4JdkRmyljT4lygdMBs2JDW1jvLcBqgcSAuXxo0k1ZyGxkW0mFlkmw/8ZqaQmjpZyBVwuy6GEaq8v8+YCQzAfApmG5YsaHfhgT6nA7PG92XlMNPsw3RaanfIjF5jleytzj9PLGiyoJvL2VnRawllsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhPTv66/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121F7C4CEF0;
	Wed,  9 Jul 2025 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752081878;
	bh=CIOMlgRpUJugmEyrwKD0bvm4X9rssQ6N5IlGBU9Bk5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhPTv66/TcKB3ymCVq19PUv2mqp6JP6PDQz8rcHnVDStvcmzicoGSLjRQRtg5X0dz
	 7qpgVe9/otyagPPNPEZyTIcuceM23C9xpIanI0CRw1fOBg5m8/2FeoZzNupXSktf6C
	 je5mT/1pnEz/UbYgKsWarZqYviBNSfAb0pyhglObb+bT8Zm5UJY/yDjA7aoNo1MnKL
	 wknJTiGPoJQ5TEqIx2zf+j/6FjWCgu9pjdg8KYOCkj6lczg+eA8h3CC8Hj+yrQR7tQ
	 JMbwrdg6bPIaabE03i9A/TvK99J8f9tW2E4I7JS8lZaNMmac1/cPAokDff2OPLu8SA
	 u7d8KUvdgRMag==
Date: Wed, 9 Jul 2025 18:24:33 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH net-next 4/5] net/mlx5: Warn when write combining is not
 supported
Message-ID: <20250709172433.GE721198@horms.kernel.org>
References: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
 <1752009387-13300-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752009387-13300-5-git-send-email-tariqt@nvidia.com>

On Wed, Jul 09, 2025 at 12:16:26AM +0300, Tariq Toukan wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> Warn if write combining is not supported, as it can impact latency.
> Add the warning message to be printed only when the driver actually
> run the test and detect unsupported state, rather than when
> inheriting parent's result for SFs.
> 
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


