Return-Path: <linux-rdma+bounces-13384-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58983B58530
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 21:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2614485A49
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 19:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19D72820AC;
	Mon, 15 Sep 2025 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSjghQhq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F0280339;
	Mon, 15 Sep 2025 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963688; cv=none; b=j/YoEIvU+dl8ODbM/MqrW/OB1SMQA53i/B7LRee8sPJyjWY51B8TK+1+tFCQuobmAmKU8zWhZYyvXTF5VG0CuItV7VV/YdxG+Z+bfMnHLm8PrXKxwICqXGxZU6bTLGBwqij0SwGC64RoydzR179lgXAEavLPJx2+waCYQwZXTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963688; c=relaxed/simple;
	bh=KAfEVizCS8VNcth378q7CbYSTJqnIREoAS9Sg1lT1Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdl928ORgy1nNgkKOUg4XJRWeAdWQwl9BV6UwlFsoR8dJYR9jzDnoej1JBZdxS3e1mvnB4AwxpQJzXrJKJxOrpRMo1bSdm3EYihBKU5xpna9x+/Vq/KYmY0JyNxtZtw8QjAhEZMKPJorFUdHsqjUEv6FfOWtOAGE3B0tN3t3L8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSjghQhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE807C4CEF1;
	Mon, 15 Sep 2025 19:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757963687;
	bh=KAfEVizCS8VNcth378q7CbYSTJqnIREoAS9Sg1lT1Fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSjghQhqHREFpEb7V2ai3N4dAtNSKizxC3ibdIUnqalNqj0e0ZCXq57KvvOqTWgA9
	 K1ZzBkG2wlbBrmYRRUI5qRrQdFL+SOS3rFYoiLM9FjZjzEIPF/tVHP4THe6lP0bmqW
	 Evue2rNbhX0Q38v5FHOaT5U7OkqucpoNmSheyboZVC+1y5vFIl+UqW0IpOUWIkt65c
	 dZD3njzICBQ4NUOi4qre+A3lUhU9W+6IafAEkH+MFDWboheCBO62iW+1AaiAq/TRPJ
	 3TlvcEyMlIA/oiM8zYDCcyEda1XPdjfnA8Q4VopSveQtS8ETh4hDlXIoIwPCsVNKVu
	 2xtDPhr/11chw==
Date: Mon, 15 Sep 2025 20:14:42 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Bloch <mbloch@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH mlx5-next 3/3] net/mlx5e: Prevent WQE metadata conflicts
 between timestamping and offloads
Message-ID: <20250915191442.GB322881@horms.kernel.org>
References: <1757574619-604874-1-git-send-email-tariqt@nvidia.com>
 <1757574619-604874-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757574619-604874-4-git-send-email-tariqt@nvidia.com>

On Thu, Sep 11, 2025 at 10:10:19AM +0300, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Update the WQE metadata assignment to avoid overriding existing
> metadata when setting the sysport timestamp ID. Since timestamp IDs are
> limited to 256 values, they use only the lower 8 bits of the metadata
> field.
> 
> To avoid conflicts, move IPsec and MACsec metadata ID to bits 8 and 9,
> and shift the MACsec fs_id accordingly. This ensures safe coexistence
> of timestamping and offload features that use the same metadata field.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


