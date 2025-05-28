Return-Path: <linux-rdma+bounces-10775-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D3BAC5E77
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 02:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BD24A5808
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 00:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F397C1A262D;
	Wed, 28 May 2025 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrGVmhzs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80BE19B3CB;
	Wed, 28 May 2025 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393398; cv=none; b=l2V+hgeudRPn3aq8+ntfdIrNnWQ3nsfcv3yuqmuVqxjJtS/cn9mc1aGQ3jlIvgwBJYnTUYgua1eovF0y2yM7E9Iw1y3/Lm5uR2hr8L9c+3NDZX+Yf/ROXMb2CL9NqBNliAk/yTsqCtAASafVdY+4L/JTNzi1R4S2gP/1BP7H4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393398; c=relaxed/simple;
	bh=f890H/9ruSdUbBUblSOTrcwaL+qMWsuG781EVPUlCwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXTbOVblmqIDMOsjXxa/3A3ai1H8TqVI3D/NcYcdQZtF4y6lqUG4ojxHu8ohcIj75zZtADBJhQCY4XehJNhHvI8E8+QL60tjZlIYbGFDF34U5J/oUdPQBKk2Ql/gzwO5VXzn6C2yInAUNPVH7bJntZLHNZMg4WRTg51gEgN8EVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrGVmhzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB7FC4CEE9;
	Wed, 28 May 2025 00:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748393397;
	bh=f890H/9ruSdUbBUblSOTrcwaL+qMWsuG781EVPUlCwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PrGVmhzsdkviPZe3jTbBmSyvTecbWoFgC9vt2lQHA+M9Wfrk36vrLDZUDAS8es1Q0
	 DS+PDRDPP51rQK47RGbcQeXMoEJvWeMvqHaJwXsXAjN8Avah1F9FKo8luB5xUATolk
	 TJoEziltm9pyXc8NnoMjAsXo/wRjakQ5E/Ukzvp3j25drNlcS81SsU55GTpsG1/jPm
	 AV9lzKT25wdPp6XwY/j275hWHSAggNPmMpxWiZt2pTUl8rCXeX01A2vAW9rnJasr0I
	 bfUL/RAhtxYTQdh/MeL6m3ObA7+bJ/vTXkDFuUhi+/SJLVh8SxqahHsiDYaaK1PMlo
	 SFh8NMg64PHYg==
Date: Tue, 27 May 2025 17:49:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
 <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Yael Chemla <ychemla@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5e: Log error messages when extack
 is not present
Message-ID: <20250527174955.594f3617@kernel.org>
In-Reply-To: <1748173652-1377161-3-git-send-email-tariqt@nvidia.com>
References: <1748173652-1377161-1-git-send-email-tariqt@nvidia.com>
	<1748173652-1377161-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 May 2025 14:47:32 +0300 Tariq Toukan wrote:
> Encapsulate netlink error message macros to ensure error message remain
> visible in dmesg when the userspace does not support netlink.
> 
> This allows drivers to continue providing meaningful error messages even
> when netlink is available in kernel but not in userspace.
> 
> Replace direct extack macro calls with new wrapper macros to support
> this fallback behavior.

Please break this down API by API and explain for each why user space
can't use netlink. If we thought this was a good idea we would have
added the pr_err() to the NL_SET_ERR_MSG_MOD() from the start.
-- 
pw-bot: cr

