Return-Path: <linux-rdma+bounces-8908-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF904A6CFED
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Mar 2025 17:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CD83ACFC6
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Mar 2025 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164D37E792;
	Sun, 23 Mar 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ0yj1vC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007F13AC1;
	Sun, 23 Mar 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742745777; cv=none; b=aNngXnqraNp1xcgYP9xJKqp+/mkWfLFxS2EcAdsjOr9Fqy3N9EgztyqwZtSguj4o4PXfdrETAxQ5MF1hCwckcCUbn2gjf5tilfjCUCjtoMfSQmqoC87A4ee/6o7w8SAd7cQDJycxcpNbNFp7S8Gg9yyHdaHcYaqIdo3KtkQtgCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742745777; c=relaxed/simple;
	bh=H7w/BjMPnYgmMenGfqzBfq/qcAtJzqu15o6ToUZvRwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQtkQwcTZQET8Grdyg/ugKICggdqkDH9mzHZlVux5X2lmJfYzDHQZemQhtlkKJliUb7J4QRUdSrElp9+BhChdjps4dnpMaOsqEqHHkIuByNECLcp6Nor2N5Wsij5ELkpixt9jpOV5yOjRuab2WKH1ZTlHl3QRhkqV8ozmh70Rdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ0yj1vC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E268C4CEE2;
	Sun, 23 Mar 2025 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742745777;
	bh=H7w/BjMPnYgmMenGfqzBfq/qcAtJzqu15o6ToUZvRwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZ0yj1vC8haewJgaec1HBq77BTW0SfsoME8Nmw+oPpG0g/E9dN9E6quj2rSlYPq34
	 g1PyXkA8HvH+OyoK9oEzDptSNP+WO1rE2ttaq4h+P9iofLaAY9VGx9z+vtWmQJfjml
	 r0tzSzqEAgNE7f8e0SwdzUCdi2w2bOd2cdoxyhwyxLDRQTgKEbHaItQCJcjHqISJep
	 0BSzd0purxOWnl/2teRAlqIqtJiUsFZf2cQRRrs9VFH0IVng4Shv/WC+1JWWOBgD8Q
	 yi6EGq9W39IO8yZNz63pv4B2K5w4318tgt99lZyZggTouUgN5sQbnW0huCaKm8nK2e
	 hF2ISgb/DeOSQ==
Date: Sun, 23 Mar 2025 16:02:50 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5e: TX, Utilize WQ fragments edge for
 multi-packet WQEs
Message-ID: <20250323160250.GQ892515@horms.kernel.org>
References: <1742391746-118647-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1742391746-118647-1-git-send-email-tariqt@nvidia.com>

On Wed, Mar 19, 2025 at 03:42:26PM +0200, Tariq Toukan wrote:
> For simplicity reasons, the driver avoids crossing work queue fragment
> boundaries within the same TX WQE (Work-Queue Element). Until today, as
> the number of packets in a TX MPWQE (Multi-Packet WQE) descriptor is not
> known in advance, the driver pre-prepared contiguous memory for the
> largest possible WQE. For this, when getting too close to the fragment
> edge, having no room for the largest WQE possible, the driver was
> filling the fragment remainder with NOP descriptors, aligning the next
> descriptor to the beginning of the next fragment.
> 
> Generating and handling these NOPs wastes resources, like: CPU cycles,
> work-queue entries fetched to the device, and PCI bandwidth.
> 
> In this patch, we replace this NOPs filling mechanism in the TX MPWQE
> flow. Instead, we utilize the remaining entries of the fragment with a
> TX MPWQE. If this room turns out to be too small, we simply open an
> additional descriptor starting at the beginning of the next fragment.
> 
> Performance benchmark:
> uperf test, single server against 3 clients.
> TCP multi-stream, bidir, traffic profile "2x350B read, 1400B write".
> Bottleneck is in inbound PCI bandwidth (device POV).
> 
> +---------------+------------+------------+--------+
> |               | Before     | After      |        |
> +---------------+------------+------------+--------+
> | BW            | 117.4 Gbps | 121.1 Gbps | +3.1%  |
> +---------------+------------+------------+--------+
> | tx_packets    | 15 M/sec   | 15.5 M/sec | +3.3%  |
> +---------------+------------+------------+--------+
> | tx_nops       | 3  M/sec   | 0          | -100%  |
> +---------------+------------+------------+--------+
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


