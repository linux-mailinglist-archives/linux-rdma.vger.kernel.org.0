Return-Path: <linux-rdma+bounces-12011-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DC5AFF6FD
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 04:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95753A3AD8
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 02:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7746E27FB15;
	Thu, 10 Jul 2025 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCBs6n2A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7483208;
	Thu, 10 Jul 2025 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115639; cv=none; b=B8zg/3eNN5cik9sEJB+ZJrZD3Ojda1gQR+XWj2/87at7vgFksjG6rBx2lB/CiwkZM6BzfJLcBGVCcWPcaN0dId4Fkv5CSD73EjzBs0FhNOpZVj8M5xzcEy9oXl7oNHs68DEoG34Dyexiae2OwdtY6Xqc8/xBtxz1X8RX6mFLGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115639; c=relaxed/simple;
	bh=VeAI1FxBggyE+WQ47Zj1b5JN7ybUqwe9OVmx2IgcUNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ae9MIkxSIClbKkBvq3Frkny2dAGOpuK1L2bYASLjyaXZ8LvxeX53cZyf5OFlFJB7smBmnpjJqIJP7AwRTQva8kplHNMYX0YQMCPGei8ys+qXOslY4rUcijo6sGdLYp6h0D8AmMM6BxBs9wmgesHb2G+UvuKY2upDbIxc/BpbTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCBs6n2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556E5C4CEEF;
	Thu, 10 Jul 2025 02:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752115638;
	bh=VeAI1FxBggyE+WQ47Zj1b5JN7ybUqwe9OVmx2IgcUNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iCBs6n2Ay8o9kCaNx3pYsCaE0M80uKiSq72L69HaliTN8c5m2xXgPjF8WjOeQz5rh
	 /t/rcGkg3ZsExNRcFi7lrtNXAAIxz9BJACMzgiUp9vZaVgbr3n6ICeYykmPnWKclMV
	 EZ6p1hjH3BqjGslygJYT+cUvdu9CnVILBcfhtpTFKUIDfnayFlB2+kPnZ2JUsDXXRa
	 PWQUHkH/Pt86XUf6TqMBZv/IZl1hrtvZ+g91Zwaf8HH3Zm2G1c+3yXqNIFqyNTKS2T
	 ttblpCbqZPPJiLg3otPJElck9JLiSm3WNKZooBcrNTpxj3CNex9Thd5WlGiTV8NxE+
	 WilRlekjUJZ0A==
Date: Wed, 9 Jul 2025 19:47:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeed@kernel.org>, Gal Pressman
 <gal@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/5] net/mlx5e: Replace recursive VLAN push
 handling with an iterative loop
Message-ID: <20250709194717.101a7a22@kernel.org>
In-Reply-To: <1752009387-13300-4-git-send-email-tariqt@nvidia.com>
References: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
	<1752009387-13300-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 00:16:25 +0300 Tariq Toukan wrote:
> +		rcu_read_lock();
> +		*out_dev = dev_get_by_index_rcu(dev_net(vlan_dev),
> +						dev_get_iflink(vlan_dev));
> +		rcu_read_unlock();
> +		if (!*out_dev)
> +			return -ENODEV;
> +	} while (is_vlan_dev(*out_dev));

Would be good adding a comment here to explain why this odd rcu lock
/ lookup / rcu unlock / keep using the return value outside of rcu
protection - code flow is correct :S

