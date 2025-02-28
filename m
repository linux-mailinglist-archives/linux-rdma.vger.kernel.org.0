Return-Path: <linux-rdma+bounces-8211-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD346A4A62D
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 23:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BDDB7AA553
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 22:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34B51DE88A;
	Fri, 28 Feb 2025 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ3Xc38e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B323F372;
	Fri, 28 Feb 2025 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783097; cv=none; b=gEYocPMleyZOoirHHrkvWF+I7+VNccXZ1w2vye98qQ/HuRy1pdkuxslT4CvmFB5Op857LK1tUHS60hS5/Pt3kKcjyeBK7HYdiQQI/QuWo+qnv4SBRWQrdlEHtU5VFf0V1SykhQSj0Lo7I8yYEZn3bTtIQBr606hMlUcSoRdQcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783097; c=relaxed/simple;
	bh=b3khscYAvq89JD3v8j8cIFkjxDHXws6PJuQma8+Stgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYaVx6TUf1wTJJh3vGeAAJztZ9Y/3fbnHnVs8AZfAy86pRZLVVKumjZtUchTWpY8Gzki/bTKTbevZWnQeCfpZGrXpFqZRxNJ8nAMRIWyUJstxCVs/AjWAuStmgBzYEYnxN90FzTG2+sAQalU2p3RnB6qlVeJE5WxzkoRSITLI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJ3Xc38e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766F7C4CED6;
	Fri, 28 Feb 2025 22:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740783096;
	bh=b3khscYAvq89JD3v8j8cIFkjxDHXws6PJuQma8+Stgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KJ3Xc38ePlenpi81a6XgL3BuXLR42texMnOjZgddxpJ3SWhjusKI+qWlwFyKG2D+W
	 qC9yC98ur25UTWfXLSXBHN9AerHfhBl1EjE//o/DSDoKSd+glfN4eieWilixS6OA1G
	 B7jFfbotwjrT+UtpLUOrWulI1Vkdq5S4I8rwwxLZuonD60UJD/823lzNoexWa7tGB+
	 eu3e1REsS5cZ0h2bKYI5nx0JTaaajhQLI/vq9ItrQkiv30FDfMZ9vX+Pg7ESwWSvBi
	 YBkxBks5xktlkD+Lah0x9FyoJkVJd7tOsdBSg5XjJM37xZSBIkRdAHJ5VvI7TO2nWT
	 CfhAy+3EOFfWg==
Date: Fri, 28 Feb 2025 14:51:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 3/6] net/mlx5e: Enable lanes configuration when
 auto-negotiation is off
Message-ID: <20250228145135.57cf1a73@kernel.org>
In-Reply-To: <20250226114752.104838-4-tariqt@nvidia.com>
References: <20250226114752.104838-1-tariqt@nvidia.com>
	<20250226114752.104838-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 13:47:49 +0200 Tariq Toukan wrote:
> +		if (table[i].speed == info->speed) {
> +			if (!info->lanes || table[i].lanes == info->lanes)

Hm, on a quick look it seems like lane count was added in all tables,
so not sure why the !info->lanes

> +				link_modes |= MLX5E_PROT_MASK(i);

