Return-Path: <linux-rdma+bounces-13436-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED97B7D31B
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A1E1C00CDE
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D637F30BBB3;
	Wed, 17 Sep 2025 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5SHSj27"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6490A30ACF2;
	Wed, 17 Sep 2025 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098552; cv=none; b=CC8VrwgXAMfWK05MJiJjBmoq8C0IyQR+QaU0Ohw+kpkEAurecQK6RwkUUZA6LoT+ifvbzUbqPNJxqj/uPMYy8/CAXlXtfw2JOdT4+9B/I8XqwEs7OAqggBGYFW+yFUAQ8r9/d166JJNOw5DmwIwYsNvPKKWFvErawl03Tl0gAs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098552; c=relaxed/simple;
	bh=5yUOvbpMF0YrpVOgH4k1NI9yStaBqle8wEQnc8QY970=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZjM1KlLvQ7MASegDckERXS+P6K8Cw70p2uuSHQwDrMdLWW2XftU9xqt3XYb/MdoJrRVD5RFMSmm2o76bYuK9sULPUiBF+BjeUd3NQHxX05Z6mlzG8rSedfvN8nl57ghRRVdrQmvUmGT58lOc9rivMV05i0Lkxf6YHL6PUr4Tt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5SHSj27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82697C4CEF7;
	Wed, 17 Sep 2025 08:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758098552;
	bh=5yUOvbpMF0YrpVOgH4k1NI9yStaBqle8wEQnc8QY970=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5SHSj2782C56iypnnMDdc/9RwmVisOA7dyUNnMI2UCWrmyU+ftsU1Hqrm7tF7z6V
	 xr4YqWrOouFEm20iuoVauDt46YHz2dSfwU+qTld6YK+zXZ510pmd+AXNjDB7agpK6K
	 BHLuzNjH6Nk1OmHEN63BbkQAegMnxhRhYTBTp6AGlfCrMxTp53EsvHFl8kymW1XaNu
	 ZyBbU3g5nqhfshyaXSWdZaYmbWhu1BL2jmmiIkQGWLGytEgNlS/QwdjUZ+iB2UKd2i
	 jp0KcC4jpvtFoC8d+eWqmxXtrw0kGYsoXAzgnSIi7WD8X+LP9Tld6n+jm7ak6HMjCm
	 WFEpYT9GrDXuQ==
Date: Wed, 17 Sep 2025 11:42:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Bloch <mbloch@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH mlx5-next 0/3] mlx5-next updates 2025-09-11
Message-ID: <20250917084228.GA22855@unreal>
References: <1757574619-604874-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757574619-604874-1-git-send-email-tariqt@nvidia.com>

On Thu, Sep 11, 2025 at 10:10:16AM +0300, Tariq Toukan wrote:
> Hi,
> 
> This series by Carolina contains cleanups significantly touching shared
> mlx5 net and rdma headers.
> 
> Regards,
> Tariq
> 
> Carolina Jubran (3):
>   net/mlx5: Remove VLAN insertion fields from WQE Ether segment
>   net/mlx5: Refactor MACsec WQE metadata shifts
>   net/mlx5e: Prevent WQE metadata conflicts between timestamping and
>     offloads

Thanks, applied to mlx5-next.

