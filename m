Return-Path: <linux-rdma+bounces-14478-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 182E5C5AC88
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Nov 2025 01:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F30BB4E2FE2
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Nov 2025 00:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FDC20298C;
	Fri, 14 Nov 2025 00:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umrU52ZK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B8A258ECA;
	Fri, 14 Nov 2025 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080514; cv=none; b=fBQQo1+hNxt5zTmVDRqIN8OEG7GGaqQC0rIso89kF2tlD0mObRQZNZ5rEAeyblo4SCozCIchCz10vRR0OvhKHMpmXcTwP2f6EHUGMJUeHxDBVyzcH1wkz/O8IwLa7B9BmRJMAycX+0+238jLjVfNr9JuS/2dt5sG4GBCtpN2M5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080514; c=relaxed/simple;
	bh=DKiX7r/u3ppf71FZ5T7/ToJ60ib6nWoUzLzpPbIa9r0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m18vsxaIrX1Ii5U/N059ZGf1Pk6grFggLCr8+SnxKn6T1953cojb0agojmxFOKz1iJU0lSRW1uWQNUPKtXqgS22ka/R4ymuqmWuUZVP+MNkeVV6SEn+eyiRtIS1BHBbovuD6RTxPMLHAHbKgmFGoAmEkdrSfnsa4F0+rWSu5UIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umrU52ZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F4DC4CEFB;
	Fri, 14 Nov 2025 00:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763080513;
	bh=DKiX7r/u3ppf71FZ5T7/ToJ60ib6nWoUzLzpPbIa9r0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=umrU52ZKNzS7B/nubQ3Nj05ro32b/rvUc9BgTLUBXv6zq76wzUnbUjuB6I63frKin
	 euzeaNheLvIKswH8000ylc3SrjHePbhIvIkGje7Aktj2+56YAcgNfj30h3Q+dGtzfe
	 j/O6slAcquNthZmewZEOLmq2uO+Q/HD6sgda6IEtOw7EfHDxx/Kz0H+j61VkXdmrSm
	 vVd+M/JPA3K0gGcBcc7dhSSCSVcy2tQirywT4Oq+1ZqWBnZ/R53Zb6jiXku/AZLFoX
	 k+Lx7Mfy4IwUjgymfT7JapzBMaAqSWu/D52FMa3vcgHVVwwIQGUmHQCgLGdLgu4OFM
	 JG6UfqDwjmOIA==
Date: Thu, 13 Nov 2025 16:35:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/2] net: mlx: migrate to new get_rx_ring_count ethtool
 API
Message-ID: <20251113163511.50626066@kernel.org>
In-Reply-To: <lto3b6lf2ic6ajph74ljo2ibpmoltkgpswfbvcprx5pr3iqfoi@67u4olbyq4km>
References: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>
	<lto3b6lf2ic6ajph74ljo2ibpmoltkgpswfbvcprx5pr3iqfoi@67u4olbyq4km>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Nov 2025 08:48:20 -0800 Breno Leitao wrote:
> On Thu, Nov 13, 2025 at 08:46:02AM -0800, Breno Leitao wrote:
> > This series migrates the mlx4 and mlx5 drivers to use the new
> > .get_rx_ring_count() callback introduced in commit 84eaf4359c36 ("net:
> > ethtool: add get_rx_ring_count callback to optimize RX ring queries").  
> 
> This is "net-next" material. I will update and resend with the proper
> "net-next" tag.

No need to repost. net-next is the default

