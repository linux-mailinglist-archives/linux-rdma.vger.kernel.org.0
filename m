Return-Path: <linux-rdma+bounces-5922-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2A59C48EF
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2024 23:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1067EB28EA6
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2024 22:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5DB1BC9FB;
	Mon, 11 Nov 2024 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCQxBffB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3A21BC085;
	Mon, 11 Nov 2024 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363204; cv=none; b=UdstJqfoFJ3538L4dOzEWbWdnh+NG4f/1rWPrLXaFnixjM3TtM8zY46TGdDKv0d32Sm5U1+khR68C4EqvPAuF1QfUds/dUEDBbKR923pHR2wzhETqTuh55v3u8kBQ/K9S7rmrp+g0mxT77hLePhDFykKl2xXBwcgvH0tdMygP4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363204; c=relaxed/simple;
	bh=ojNX7ewQ5mBn+8GJnYQlZeE9p4+dRMgQGrBXvhs2+fI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3dqsvGOtMFKSYZvPlxpSw/jPxQSL4UJJNXhDNmypDRyBCASM25lIg6eF0Yf948n0S0YbB3rNg77mGpuFnhfV6CYE5/b5tBJZFlqsPgdkTXZwFRtkGtJ+pu+HUZd01JaNRUyXpgRA81JbNX4uiWJMNZjlA1wjBEzGGkIDNWHHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCQxBffB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103DDC4CECF;
	Mon, 11 Nov 2024 22:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731363203;
	bh=ojNX7ewQ5mBn+8GJnYQlZeE9p4+dRMgQGrBXvhs2+fI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TCQxBffBXyPKj2xKTDl6//xKba0ovCTA31loZDkm0SFTz3sw6YR/BHM/8Le7DZy7s
	 aiCYcBwPe8OWe/MfHs4mGq7nc3s7/t+YjKfEyECHQK/iqvBQlsJs35JxN7X6ZfVN08
	 slWovi9O55skKw5snL4fdwVQtWc9kESHJ0xulDXw5Qoh4ldQzDzpv8fSvzFFFch0pV
	 3V2GeJPXt22BZJYmLPnfGNRntFuddZsepZXdE0M+puQi0SvYuWd2AzvoeXB1w12n1K
	 Q6oZxiU8WsQlGyfbiZuw6JZuAxamncoYMg1bWVwxR1eT6ibE0HDBv2MJAe2CTM7yqf
	 551OIgpkhLONw==
Date: Mon, 11 Nov 2024 14:13:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Parav Pandit
 <parav@nvidia.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] mlx5/core: Schedule EQ comp tasklet only if
 necessary
Message-ID: <20241111141321.0d723c9d@kernel.org>
In-Reply-To: <20241105204000.1807095-1-csander@purestorage.com>
References: <ZypqYHaRbBCGo3FD@x130>
	<20241105204000.1807095-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Nov 2024 13:39:59 -0700 Caleb Sander Mateos wrote:
> Currently, the mlx5_eq_comp_int() interrupt handler schedules a tasklet
> to call mlx5_cq_tasklet_cb() if it processes any completions. For CQs
> whose completions don't need to be processed in tasklet context, this
> adds unnecessary overhead. In a heavy TCP workload, we see 4% of CPU
> time spent on the tasklet_trylock() in tasklet_action_common(), with a
> smaller amount spent on the atomic operations in tasklet_schedule(),
> tasklet_clear_sched(), and locking the spinlock in mlx5_cq_tasklet_cb().
> TCP completions are handled by mlx5e_completion_event(), which schedules
> NAPI to poll the queue, so they don't need tasklet processing.

Applied, thanks

