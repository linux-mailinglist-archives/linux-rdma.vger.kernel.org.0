Return-Path: <linux-rdma+bounces-11216-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D0BAD61BB
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 23:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28553ACE6D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE30F2472B6;
	Wed, 11 Jun 2025 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsJ1X0T/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F2246BD5;
	Wed, 11 Jun 2025 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678194; cv=none; b=gDhJjso50tRFfffZpz2O3EQ1MlTA4+qHk6Q2p1aBUbeXylje4NzGrDyEbL3r3hB0vh3HV2tCxafLr5Xa+uo2j7A3Rrt0vYaDjHaHGmMrXgOoTB2IgwcwjeAW9xNm50T2Q8dbhvt3bH0gZPzr1mgcWEmqXZcLlkG8vYWQanFD8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678194; c=relaxed/simple;
	bh=InCi4uyqM7ljrwy7jzwa0FLc7x89wcJyuX+nURtQgko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVAhwuQWger3UZqp/9gTMz/IM02clWwvKo5O3pNValRBexdLbvOp69c4r2BxxuFFeHAyWf3KipxKkms7mwxg+b8c34Z3T8UkuFDvJYKREzKDpQEw6JRvBTHG5usrrgy2OYwQEC6GKnAuaON+TMOxqwjE1tlWSUDU3ecskdkp23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsJ1X0T/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9815EC4CEE3;
	Wed, 11 Jun 2025 21:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749678194;
	bh=InCi4uyqM7ljrwy7jzwa0FLc7x89wcJyuX+nURtQgko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RsJ1X0T/2SFxJG7twmsamolxYScalqPLLIxtXoeQfHAUDaIIWtzgnC2EYv4VqzXlE
	 ukckMtzg9tg2SfaEYE7iT8l8mkq9rol5imfaed1EsBR4ig5H7mZg2WnGUp2imRorpn
	 BcIwUysUnjt0ZpLtv4sfZUNjQpj2a74vtPlzOXfEJMw3zvKqB9N5brxHP23gw7lhnm
	 CtKH7NlBjXv1Bc18RmDfJzASLUf6BHwg++JfEer8dWoWX+jBEYPYRUodYnbXBXv+qb
	 V4mR/Cz1/KONWaIeU6m7jDGRXoPI9vA2trzpzzCepo9WBZ7MLMEfImprSRCCGodbLz
	 pK0JGqTfTZJAg==
Date: Wed, 11 Jun 2025 14:43:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
 <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 0/9] mlx5 misc fixes 2025-06-10
Message-ID: <20250611144312.5baaa786@kernel.org>
In-Reply-To: <20250610151514.1094735-1-mbloch@nvidia.com>
References: <20250610151514.1094735-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 18:15:05 +0300 Mark Bloch wrote:
> This patchset includes misc fixes from the team for the mlx5 core
> and Ethernet drivers.

I'll apply the good patches, the one that should go to net-next looks
completely unrelated to the rest.

