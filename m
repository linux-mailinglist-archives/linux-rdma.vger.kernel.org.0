Return-Path: <linux-rdma+bounces-4356-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA1B9510F3
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 02:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEED1F236BD
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 00:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275FE10FA;
	Wed, 14 Aug 2024 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeOzVbpB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D332863A;
	Wed, 14 Aug 2024 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723594632; cv=none; b=cHTXMyiM3jnniJW0CI3RECz0npHkXGqCFoUBXrea3gAkHOb7nra2ZE7xbBFbqWfPpK3oAUfii3HD0QWvloK7cpEGEfMZE1TMGAgdmXY+eQbHngA40Zo6Ks7XI9nS4I5abw5lauFq7fKzXMp+TUzVFisCuvc/ttssj+KonWpP694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723594632; c=relaxed/simple;
	bh=pAYKiISv6wl68aJN4AwlbTi88MyEYMKFybMyQY8oMTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoeKGV9zTLdcUBAWAuV2XId5xQ4xGyagouDm86ynb3W6ZBwOyuoezauxXkUH2iBiHcAT5gdpTGl3/x7QX1AIodTDjfkHPQMOlg1PbMZiRvfZ7BoADx5xSPS3Dym4Nz9oXQcn3z96s3MwrCOCov28wjItEtsBFOBSvn7dXtLzQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeOzVbpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB95C32782;
	Wed, 14 Aug 2024 00:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723594632;
	bh=pAYKiISv6wl68aJN4AwlbTi88MyEYMKFybMyQY8oMTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SeOzVbpBsLYgf5HSBmlDL8qPjt3IGht8r5ZlHpIUVFX8LA3ObJ67q/eVE20wgIA1t
	 XqQk+uIHIIa/kBKv95DVmti4IKikq3bvB0CPr/nm2U0q9li8FGd4TJanDcrgbrxv9K
	 QQP34uAKdsOQxaicDxjI5f41mb3sbQh6tlYbKMGtsCBejgjdGsNEfzF+BOrh1z87b+
	 mD3oXGKX3qUHkbVAGagPfuVpHni+hljbJoxlr2LGP5Qjo7sIzZKxBuWxMb3d+ZHC1A
	 rb/Ys/l/Qwxu1bu5XuCplVIPPuh1FcOa7ltcfHM7CcdrTamyKHp5vy+z+U4ip/bbUr
	 O4gwFpCPnWdMw==
Date: Tue, 13 Aug 2024 17:17:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
 Jeroen de Borst <jeroendb@google.com>, Jiri Pirko <jiri@resnulli.us>, Leon
 Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org (open list),
 linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
 Lorenzo Bianconi <lorenzo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shailend Chand
 <shailend@google.com>, Tariq Toukan <tariqt@nvidia.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Willem de Bruijn <willemb@google.com>, Yishai
 Hadas <yishaih@nvidia.com>, Ziwei Xiao <ziweixiao@google.com>
Subject: Re: [RFC net-next 0/6] Cleanup IRQ affinity checks in several
 drivers
Message-ID: <20240813171710.599d3f01@kernel.org>
In-Reply-To: <20240812145633.52911-1-jdamato@fastly.com>
References: <20240812145633.52911-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 14:56:21 +0000 Joe Damato wrote:
> Several drivers make a check in their napi poll functions to determine
> if the CPU affinity of the IRQ has changed. If it has, the napi poll
> function returns a value less than the budget to force polling mode to
> be disabled, so that it can be rescheduled on the correct CPU next time
> the softirq is raised.

Any reason not to use the irq number already stored in napi_struct ?

