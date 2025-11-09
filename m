Return-Path: <linux-rdma+bounces-14346-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 452A0C43CF2
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 12:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C58D4E59E3
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 11:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617B22DF158;
	Sun,  9 Nov 2025 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tY4wTb1t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC42DECB9;
	Sun,  9 Nov 2025 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762689250; cv=none; b=gqNLgx3zqoegrXJnh2L1rUH1eZ3rZ8QVB5GVZ+Bxv12ZbTc5OtvygD5xIqzfJ3pYmq+T2v2ob3rBHaTnnG3JKbMDDtn9d6zYKIhZfmzxcKyAcyYz20/g9TkRxR7hCzgHqgJJzdRUHXacHlunjoAc1O8XcuKsNDJYZWgq9oVinF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762689250; c=relaxed/simple;
	bh=qMI82FSP6fLOot/rSu0OSi8+FrtRlHvHpIOYbeczqn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmlVqbZQyMqLksR5cNtykdVxe0OZOu09xXXPbb60S6XmMSpq/vQS/BB5DuBUueC3avZ6kEKB0fFLgBJj8tKH7+RExuGmqxDUDa9LaGkhWh5Xy278SN3wOW/9YxVtcc1ZWIfQm9Y3wbapJkN6BIV92oA4JhxVyTgpoqRxKH12o8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tY4wTb1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE19C19421;
	Sun,  9 Nov 2025 11:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762689247;
	bh=qMI82FSP6fLOot/rSu0OSi8+FrtRlHvHpIOYbeczqn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tY4wTb1tT0bsdnv9d1axVIrJFU1xXJsvkQHKv79pDxGxia+ye7cZTq2Mm6uyylzrr
	 M7aw2e/2OmH1lU5aYiuyFj51gn8QHOPO053AK5haTOgPquC7NWOcEJReFKR74zxL4s
	 5jjwvjcEf4aBxEZqKZLVA8kflXimWsoeww6roS3lhwE6xX/sMigRgA3hFv7joy6VtR
	 4KQ6+Ab2EFYuiH91vx/BoOFORlHc+Z1y+ipWAA9V5Oe/BtgnM/lprfBW30CQnKcGs7
	 eKiwEutUweHUMRORbFMQJ+k8rgMa+AjboUm7K6kw6YWeGMHmp+yrmTrUz3Fp7BUt0b
	 ClazXFVBF/O4w==
Date: Sun, 9 Nov 2025 13:54:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, Gal Pressman <gal@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Akiva Goldberger <agoldberger@nvidia.com>
Subject: Re: [PATCH net] mlx5: Fix default values in create CQ
Message-ID: <20251109115402.GJ15456@unreal>
References: <1762681743-1084694-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1762681743-1084694-1-git-send-email-tariqt@nvidia.com>

On Sun, Nov 09, 2025 at 11:49:03AM +0200, Tariq Toukan wrote:
> From: Akiva Goldberger <agoldberger@nvidia.com>
> 
> Currently, CQs without a completion function are assigned the
> mlx5_add_cq_to_tasklet function by default. This is problematic since
> only user CQs created through the mlx5_ib driver are intended to use
> this function.
> 
> Additionally, all CQs that will use doorbells instead of polling for
> completions must call mlx5_cq_arm. However, the default CQ creation flow
> leaves a valid value in the CQ's arm_db field, allowing FW to send
> interrupts to polling-only CQs in certain corner cases.
> 
> These two factors would allow a polling-only kernel CQ to be triggered
> by an EQ interrupt and call a completion function intended only for user
> CQs, causing a null pointer exception.
> 
> Some areas in the driver have prevented this issue with one-off fixes
> but did not address the root cause.
> 
> This patch fixes the described issue by adding defaults to the create CQ
> flow. It adds a default dummy completion function to protect against
> null pointer exceptions, and it sets an invalid command sequence number
> by default in kernel CQs to prevent the FW from sending an interrupt to
> the CQ until it is armed. User CQs are responsible for their own
> initialization values.
> 
> Callers of mlx5_core_create_cq are responsible for changing the
> completion function and arming the CQ per their needs.
> 
> Fixes: cdd04f4d4d71 ("net/mlx5: Add support to create SQ and CQ for ASO")
> Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/cq.c               | 11 +++++---

It can safely go to net as we already sent our rdma-rc PR to Linus
and won't have any fixes in drivers/infiniband/hw/mlx5/cq.c in this
cycle.

Acked-by: Leon Romanovsky <leon@kernel.org>

Thanks

>  drivers/net/ethernet/mellanox/mlx5/core/cq.c  | 23 +++++++++++++--
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |  1 -
>  .../ethernet/mellanox/mlx5/core/fpga/conn.c   | 15 +++++-----
>  .../mellanox/mlx5/core/steering/hws/send.c    |  7 -----
>  .../mellanox/mlx5/core/steering/sws/dr_send.c | 28 +++++--------------
>  drivers/vdpa/mlx5/net/mlx5_vnet.c             |  6 ++--
>  include/linux/mlx5/cq.h                       |  1 +
>  8 files changed, 44 insertions(+), 48 deletions(-)

