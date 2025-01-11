Return-Path: <linux-rdma+bounces-6966-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DD3A0A05D
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jan 2025 03:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9AD188E539
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jan 2025 02:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2AB12C470;
	Sat, 11 Jan 2025 02:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2J60q8W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3123AD;
	Sat, 11 Jan 2025 02:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736563111; cv=none; b=R1GuBcFtsX9drOlXH95I8HxJzoFws/HJCQWrF/+so2bENVFjKjqHGM3EiaI9jOMhub/IrAtjD08DckVga+Igwh1+0TfR9HMMXjUHMCqYEb0pNecl+kZKKigwAKQOr8aZvrfZw/eUkpFbOR6etvYt2GsQAwAOlStUp+hniRY2sR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736563111; c=relaxed/simple;
	bh=WxM5iOIWEzH+FXy9JP80oVNfFIc77UhfwsAVI7ArMaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cp4xQPHWoRKWeCB3x+w5j0yenzSbRIvAnjCWLPkQCqt6XsO0f/pgF0vMLqB637O3MqJ80epsnLs5qg/OxwYazVpll65tLbl/VDL7z2y54gvN0f2hU6LE6Z7y8cszWj4QmUrWQoVjpyaMhzSi+R5RmpwMtlbzVFEBMFKA7QvVnTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2J60q8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856CAC4CED6;
	Sat, 11 Jan 2025 02:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736563110;
	bh=WxM5iOIWEzH+FXy9JP80oVNfFIc77UhfwsAVI7ArMaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K2J60q8WvXCoxiHVPkLLQMtoiEvUaBTmzteaJ2zpXb1UeZbL8cZ6WhZeTmkc5QU+v
	 fGt2jBaXqtcdEvR9s9OYvR9CDAYUjc5ib6eWRq6hSbCxvATzeUNTeWjcywTCq8V9pQ
	 aj22p/uZcIoj047iiM0vRTqE1XQIR1g/R2XXlyqLhNq4YhtxQWG/iGU+78EytqBuAM
	 JO6GJn2ZWKogQ1ziUHGhJZtoJcBLZwpwasVZWnBqBD5BZbjrhCX1r13V8+q50y2q8M
	 VNIDiF8RsNBogqcaxI4CNd+bFY7uGZZxRjtGANR3lTNXjzf/IGpD2MQH18ndyg5hLf
	 3OIkoN0OFN2zA==
Date: Fri, 10 Jan 2025 18:38:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Moshe Shemesh
 <moshe@nvidia.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3] net/mlx5: Fix variable not being completed when
 function returns
Message-ID: <20250110183829.5f60867f@kernel.org>
In-Reply-To: <20250110032038.973659-1-zhaochenguang@kylinos.cn>
References: <20250110032038.973659-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 11:20:38 +0800 Chenguang Zhao wrote:
> The cmd_work_handler function returns from the child function
> cmd_alloc_index because the allocate command entry fails,
> Before returning, there is no complete ent->slotted.

This is already 0e2909c6bec9048f49d0c8e16887c63b50b14647
in the tree

