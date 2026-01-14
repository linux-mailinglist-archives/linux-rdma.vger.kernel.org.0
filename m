Return-Path: <linux-rdma+bounces-15548-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F06B5D1D7BB
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 10:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 931AF300C5C2
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 09:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0C53876A1;
	Wed, 14 Jan 2026 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yyhei6ub"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0EE387379;
	Wed, 14 Jan 2026 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382344; cv=none; b=fh89n5KVOF4BPBn76jSGIuH6aD2pWIhjfXrCA1t/sanIX4DRNLjq60izHccJiwcv7JI4fYy/7kpwK0y9+3ldvO2sr8uneEljaHoW/ll8frNU1aPiPohY2e63YPLiUc8S8TJyOJWE8sHtqy3VaO7SuJHHrNLEJhr7zIBYxNYlFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382344; c=relaxed/simple;
	bh=KbxC/u6GYTvYowvO8ObDteC116pJA/MVS+KEXLvVvMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF5Hgd2AT5OBdXHCtHuygg9CljC75Ibdw6ocMvJ4EnHW/J6Iaa1OOO4KezE30b6FGzt8u7NpCrUvv3tfvvV3LUS83PPwayK3aMGujvtHbMq6VPWOj7cnEGQdoVovbpFG2+cG/6uvxm9Y9/TUvJVt3TgkpmbSzZW1GEjylsxPOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yyhei6ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101D1C4CEF7;
	Wed, 14 Jan 2026 09:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768382343;
	bh=KbxC/u6GYTvYowvO8ObDteC116pJA/MVS+KEXLvVvMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yyhei6ubgbQaWNU/bF8i9yhMDk6SzUDFYyxPtuayfkkDSLG16q/qypY7Rcf09Oxq7
	 Ho1BSMlr0wCWaM+rlpAj5856juRSgv6gwRcjutJUv5eNJve6+wVGVOfeSRTcqbWnEu
	 Zc9lvK6mhIevgI4Ox2US6qIxIYunLhXXxCcUckP1lpvlBD7G5Un2+UBuWHqZhE/Jum
	 ujZIahDRdFEVPX5PUK9mCFWNCIVqwh6mqQF6nWJKDBrA/aPujWxT7LQVeZVlvUytYt
	 NQx2Ff6eayTtSQGXUDJAQ+unIfYyyYPzeu2+IxbkJJN5k/uTZzq9LQ4687MqrvD/Yo
	 qc7yxorYw/R7A==
Date: Wed, 14 Jan 2026 09:18:57 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Yael Chemla <ychemla@nvidia.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH net-next V2 0/3] Introduce and use
 netif_xmit_timeout_ms() helper
Message-ID: <aWdfgaA2543svwNi@horms.kernel.org>
References: <1768209383-1546791-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1768209383-1546791-1-git-send-email-tariqt@nvidia.com>

On Mon, Jan 12, 2026 at 11:16:20AM +0200, Tariq Toukan wrote:
> Hi,
> 
> This is V2, find V1 here:
> https://lore.kernel.org/all/1764054776-1308696-1-git-send-email-tariqt@nvidia.com/
> 
> This series by Shahar introduces a new helper function
> netif_xmit_timeout_ms() to check if a TX queue has timed out and report
> the timeout duration.
> It also encapsulates the check for whether the TX queue is stopped.
> 
> Replace duplicated open-coded timeout check in hns3 driver with the new
> helper.
> 
> For mlx5e, refine the TX timeout recovery flow to act only on SQs whose
> transmit timestamp indicates an actual timeout, as determined by the
> helper. This prevents unnecessary channel reopen events caused by
> attempting recovery on queues that are merely stopped but not truly
> timed out.
> 
> Regards,
> Tariq
> 
> V2:
> - Rebase.
> - Move helper to include/net/netdev_queues.h.
> - Remove output paramter trans_start from the new helper.
> - Revert the code in dev_watchdog to not use the helper.
> - Fix the helper name in commit message.

Thanks for the updates.
I agree the address the review of v1.
And, overall, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

