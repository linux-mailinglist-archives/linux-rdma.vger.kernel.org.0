Return-Path: <linux-rdma+bounces-6322-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7599E7E06
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Dec 2024 03:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5900416669E
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Dec 2024 02:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8DF1A28C;
	Sat,  7 Dec 2024 02:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbXrWZMg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9282134BD;
	Sat,  7 Dec 2024 02:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733537627; cv=none; b=l5nmxVawITBsNAwT7q6CMfMYGAfh/GbscNxWmO5ipBGc8zTtNEf9+LomGEQCqIvfmAaMrttQgj8r8Upc9QO1oT+Cey0hNIvBQecLSF7kYPLLV600MuITJLPdWRnkqpEJqIqhAl+02hBBuIJtpIIb8clVNc9BQGWf7zsOE8kGj04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733537627; c=relaxed/simple;
	bh=NnCCWMZAvbyD3/h8PCJLyD8nj+3jPhKCnVbz0IqNkyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkN62iFY/udf4wYqjkblpWC6SwBq8h3rcIvdWnZ3HD7ZwEwZ6ZvSqGFOrBBPjZhtbD6qjm2N/zsAEDJsDuonEkX4E0cPpsG+EvlI6qEtM9EP8Ksb89ewfN6dX27VUQiNu7n4wZK4uTt6FXG193yG6InsjDdqn2WqRBL3PsONkSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbXrWZMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF08C4CED1;
	Sat,  7 Dec 2024 02:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733537627;
	bh=NnCCWMZAvbyD3/h8PCJLyD8nj+3jPhKCnVbz0IqNkyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SbXrWZMgegj393Juj2gLOe5N+KtqeqYv1Jxnr2asn5L0mswzircCOu7AV5iJvil6+
	 EkebNcCMDB6EXMxOVrVhuR04ud2J85RPtz+fic4yGG1SrkgMxg2WtNtQqpVEFsnvlq
	 +tFfLFVKZH6363YiN5FiMm/PZVbBJsJr4pXjp/fKnklh+6cg+Km7EU2o/RQ0gzFHuB
	 oWoRrGhyZvID4tI9M80UIC7oKM7IGRBvgXSNsf8IO34Wz6EG/c7eFcprUX4W62Tav+
	 Bk+mQgjj+1t41XkiJtPJ+XOjKh4hLBXPPBYWrZUBYxHDxO6aWhppERoeRgl5E4qPhn
	 XpzUTCbmUFpEQ==
Date: Fri, 6 Dec 2024 18:13:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next V5 00/11] net/mlx5: ConnectX-8 SW Steering +
 Rate management on traffic classes
Message-ID: <20241206181345.3eccfca4@kernel.org>
In-Reply-To: <20241204220931.254964-1-tariqt@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Dec 2024 00:09:20 +0200 Tariq Toukan wrote:
> This patch series extends the devlink-rate API to support traffic class
> (TC) bandwidth management, enabling more granular control over traffic
> shaping and rate limiting across multiple TCs. The API now allows users
> to specify bandwidth proportions for different traffic classes in a
> single command. This is particularly useful for managing Enhanced
> Transmission Selection (ETS) for groups of Virtual Functions (VFs),
> allowing precise bandwidth allocation across traffic classes.
> 
> Additionally the series refines the QoS handling in net/mlx5 to support
> TC arbitration and bandwidth management on vports and rate nodes.
> 
> Extend devlink-rate API to support rate management on TCs:
> - devlink: Extend the devlink rate API to support traffic class
>   bandwidth management
> 
> Introduce a no-op implementation:
> - net/mlx5: Add no-op implementation for setting tc-bw on rate objects
> 
> Add support for enabling and disabling TC QoS on vports and nodes:
> - net/mlx5: Add support for setting tc-bw on nodes
> - net/mlx5: Add traffic class scheduling support for vport QoS
> 
> Support for setting tc-bw on rate objects:
> - net/mlx5: Manage TC arbiter nodes and implement full support for
>   tc-bw

Do you expect TC bw allocation to work on non-leaf nodes?

How does this relate to the rate API which Paolo added? He was asked 
to build in a way to integrate with devlink now devlink is growing
extra features again, which presumably the other API will also need.
And the integration may turn out to be challenging.

