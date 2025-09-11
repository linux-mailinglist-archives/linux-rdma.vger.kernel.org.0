Return-Path: <linux-rdma+bounces-13258-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 232D8B5251B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 02:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771001BC6B45
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 00:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAC01DE881;
	Thu, 11 Sep 2025 00:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHJSdwWQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEDE13C3CD;
	Thu, 11 Sep 2025 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551521; cv=none; b=k7LUvo6gxjFCOUatuJ3NBfkQac6ACqCYdniBH93wjNDtYY0/Wd9EAJ4mUOyKRnNTCX/G3b+uIb988yYx4MhK6mGevwEsTOINDpbz2ITsz988+YKQWPMpoFACvNEdwNXbVcyXHQvXkVSbtuJOV5toy9kAgY5T8wYFuVvaCpaLfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551521; c=relaxed/simple;
	bh=v2ZqrhlSm1W415qGFUPkcy8KzMkQn2UIUPfngwncT6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ug7IaFvVd+LT4hMGIEMRkr5FAeDhmuspgM0WcVg/HdodAtvzAM3CNcDCmZBmEgzjIaQsBgXqthbhq2Nqz97Mur2MHWfmX98la1O0/8LaJ3F6rOcmR3hW9ToeC54nIv3SXYN8calNcIASIZmzYbX0prRK+F6xbJl7QsuLwwFr2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHJSdwWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D3DC4CEEB;
	Thu, 11 Sep 2025 00:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757551521;
	bh=v2ZqrhlSm1W415qGFUPkcy8KzMkQn2UIUPfngwncT6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jHJSdwWQ0DLdbZALIMHXFC+9CL7Ab58DlmvFyuAO4L/AL9OZaa9K8rJaf7+x3jc7I
	 PqnZ1xoxFTvuXSWHRzdPDziWJhbYMKa79UX8y8xQysdhO4+kGrEaygvNImVEBbv4ZB
	 BmpUs9ZtqLGTrTZQfV39MYcIXQJMUyGjMzx3oVvoIlR8Mj46NJa7TuZMIDR3zP++kV
	 tDsl7Ppk8TnVndFjUKO5TqT31q+Z8qi+0gxIcVGfBx/M7+onL63IVfDay8IVELttSN
	 o8FHWZj9BSt22VEB+5eFnZxRpsgCvsFFTgtBM4aAMAVIkQrGPvFPcDscEJhCNBLfv/
	 NHQdLTa21C0ww==
Date: Wed, 10 Sep 2025 17:45:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark Bloch"
 <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>
Subject: Re: [PATCH net 1/3] net/mlx5e: Harden uplink netdev access against
 device unbind
Message-ID: <20250910174519.2ec85ac2@kernel.org>
In-Reply-To: <cc776b20-7fc0-4889-be27-29d6fcb3d3ad@nvidia.com>
References: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
	<1757326026-536849-2-git-send-email-tariqt@nvidia.com>
	<20250909182350.3ab98b64@kernel.org>
	<cc776b20-7fc0-4889-be27-29d6fcb3d3ad@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 11:23:09 +0800 Jianbo Liu wrote:
> On 9/10/2025 9:23 AM, Jakub Kicinski wrote:
> > On Mon, 8 Sep 2025 13:07:04 +0300 Tariq Toukan wrote:  
> >> +	struct net_device *netdev = mlx5_uplink_netdev_get(dev);
> >> +	struct mlx5e_priv *priv;
> >> +	int err;
> >> +
> >> +	if (!netdev)
> >> +		return 0;  
> > 
> > Please don't call in variable init functions which require cleanup
> > or error checking.  
> 
> But in this function, a NULL return from mlx5_uplink_netdev_get is a 
> valid condition where it should simply return 0. No cleanup or error 
> check is needed.

You have to check if it succeeded, and if so, you need to clean up
later. Do no hide meaningful code in variable init.

