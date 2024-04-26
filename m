Return-Path: <linux-rdma+bounces-2118-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264958B4092
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 22:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01C11F241E7
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 20:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC59A208D6;
	Fri, 26 Apr 2024 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhzKShcu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281518C19;
	Fri, 26 Apr 2024 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161619; cv=none; b=o9af1KRJMTgFOE30ND/Tatr5chu6aMrjaiHoB4vtzXPbNPi3OJt5oDb3Ho4Xq7iiNEvU44RjZ3sqs9HEk0vWMpIpzDtmamnl7Vj8SUSPQiAfAptCI2J22adHx6at8l2hjBT/yHpee+ldaxBUkYLU3EsNjaKsdUlNoS6GP29VPfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161619; c=relaxed/simple;
	bh=q4aTlNNuHzD5E4RuEu0bUccWhm5zkk/pvW5+DG/vs0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLI2GXXXEGXZTk6atwzaAQpjqIiZ7VC8oRRqYtd0MmTTfGz5ZuZ2y/X5TTO0v9odyuLnfNJIq2AzVekO1tx0O+k2LLV0LuPmSmSrkCKfiW+1lgO/FM/BvoQ7H8NmQ1adugyFLAG6fcH8R4v4Bt1IKEYd3d9+7/ZO7URzeP1sKlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhzKShcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899AEC113CD;
	Fri, 26 Apr 2024 20:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161619;
	bh=q4aTlNNuHzD5E4RuEu0bUccWhm5zkk/pvW5+DG/vs0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jhzKShcuJk9piju/LR5do+bOKiVUfP+hO+LWVqc1oaalWIlBFcGzeu01fMLD0gO+l
	 pg20CvAo87PWVWbzE4bteMVzwkgRUzKPbA9wqoaQTG3/Y6p9XlzKHDeUaPksZZOLeC
	 ZppQe0YCp9rNVSXK6YJoisJ1zC1rWtc5Ew7UQ34h6aIzFaX2yiP7HT76DzdEk+PsiN
	 IeISpGtZ4c5YaaDiHO5f0TpAw9YVBe0GFur234h4QIM1ptKNjj45qGIqzq6kBJvWlN
	 o1NNsZ/UvcruMyvdzenexW6FbI0i1UshR/9b/BSc+nB8GGwQh/tSsKiGEU29T8ajZR
	 zVnN3Y+as+X6A==
Date: Fri, 26 Apr 2024 13:00:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
 saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: Re: [PATCH net-next v2 1/3] net/mlx4: Track RX allocation failures
 in a stat
Message-ID: <20240426130017.6e38cd65@kernel.org>
In-Reply-To: <20240426183355.500364-2-jdamato@fastly.com>
References: <20240426183355.500364-1-jdamato@fastly.com>
	<20240426183355.500364-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 18:33:53 +0000 Joe Damato wrote:
> --- a/drivers/net/ethernet/mellanox/mlx4/en_port.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_port.c
> @@ -151,7 +151,7 @@ void mlx4_en_fold_software_stats(struct net_device *dev)
>  {
>  	struct mlx4_en_priv *priv = netdev_priv(dev);
>  	struct mlx4_en_dev *mdev = priv->mdev;
> -	unsigned long packets, bytes;
> +	unsigned long packets, bytes, dropped;
>  	int i;
>  
>  	if (!priv->port_up || mlx4_is_master(mdev->dev))
> @@ -159,14 +159,17 @@ void mlx4_en_fold_software_stats(struct net_device *dev)
>  
>  	packets = 0;
>  	bytes = 0;
> +	dropped = 0;
>  	for (i = 0; i < priv->rx_ring_num; i++) {
>  		const struct mlx4_en_rx_ring *ring = priv->rx_ring[i];
>  
>  		packets += READ_ONCE(ring->packets);
>  		bytes   += READ_ONCE(ring->bytes);
> +		dropped += READ_ONCE(ring->dropped);
>  	}
>  	dev->stats.rx_packets = packets;
>  	dev->stats.rx_bytes = bytes;
> +	dev->stats.rx_missed_errors = dropped;

I'd drop this chunk, there's a slight but meaningful difference in
definition of rx_missed vs alloc-fail:

 * @rx_missed_errors: Count of packets missed by the host.
 *   Folded into the "drop" counter in `/proc/net/dev`.
 *
 *   Counts number of packets dropped by the device due to lack
 *   of buffer space. This usually indicates that the host interface
 *   is slower than the network interface, or host is not keeping up
 *   with the receive packet rate.
---
        name: rx-alloc-fail
        doc: |
          Number of times skb or buffer allocation failed on the Rx datapath.
          Allocation failure may, or may not result in a packet drop, depending
          on driver implementation and whether system recovers quickly.

tl;dr "packets dropped" vs "may, or may not result in a packet drop"

In case of mlx4 looks like the buffer refill is "async", the driver
tries to refill the buffers to max, but if it fails the next NAPI poll
will try again. Allocation failures are not directly tied to packet
drops. In case of bnxt if "replacement" buffer can't be allocated -
packet is dropped and old buffer gets returned to the ring (although 
if I'm 100% honest bnxt may be off by a couple, too, as the OOM stat
gets incremented on ifup pre-fill failures).

