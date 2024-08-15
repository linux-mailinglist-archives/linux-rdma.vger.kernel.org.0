Return-Path: <linux-rdma+bounces-4372-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439229526CD
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2024 02:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FDE1C215F4
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2024 00:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE0715CB;
	Thu, 15 Aug 2024 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDPO14qK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA9A35;
	Thu, 15 Aug 2024 00:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723681249; cv=none; b=GtFHbRv7L3a2L/p16Y9sZyFx2h8KoG372ne46QI754YP4U3ztOm1wkW9MlIqjhXdyQz82sV5HChbV1CfC28WBL9tRQpbKVDWciAkbTRUO7aiDtlxky/ff5u4KQpgv/VRuM2oIoUrpNk9p6EP9Aj+tcg0Mu8gZjToRN3bnuJAT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723681249; c=relaxed/simple;
	bh=FSrgGRb2+2F//PvIuCsVOMjuXhKEz50wuCkJVSwdb+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3+WJjEzZ7yOVMgf2uxa/WTeS79Ho5arksLldlLXzsdaoACQI6QH1iAgAVP+HHNKqi5Tikqi5NCj0YcopX5mPi3sTapt3HfEp0CWgtjBvwnOYT5SV13cDST///yNkmaJ9LfTq0URswsyYNVHn6v9NaaZ93O6VrI2cHhgFe4WK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDPO14qK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EF3C32786;
	Thu, 15 Aug 2024 00:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723681248;
	bh=FSrgGRb2+2F//PvIuCsVOMjuXhKEz50wuCkJVSwdb+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rDPO14qKjJ1wnJ5ZxvYB9oMTm0/dws2WGAOGyl+hbv6KhS7THK4MgXl5q5cfVfsnq
	 zgV9IHzFBohsEXiQzywZv65pzVGd9Qb+xnraM5bvU64DylyBf7QpsVihlIwMEttQ3G
	 hzFh+IRclmhDON97ZiVB1HbgZKQSFjjFv58beXMeaJEM0ZnT9yFaK5ERXdF6zAHZaG
	 9z8P6BwK//xXongNDIzPn/rySWH5hk75m+HFbk6WeOIqRsOTBwBl2bv4AKKEHmyKy3
	 n3TduAjS4Thzq+grfjIa6nb6jrMEE6gF06O+/Hw606DJ/UlKnUS5tPJ5yeblHKnGZg
	 6Y/Aozow4NgSw==
Date: Wed, 14 Aug 2024 17:20:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Shay Drori <shayd@nvidia.com>, netdev@vger.kernel.org, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, "moderated list:INTEL ETHERNET DRIVERS"
 <intel-wired-lan@lists.osuosl.org>, Jeroen de Borst <jeroendb@google.com>,
 Jiri Pirko <jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:MELLANOX MLX4 core VPI driver"
 <linux-rdma@vger.kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shailend Chand <shailend@google.com>, Tariq Toukan <tariqt@nvidia.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Willem de Bruijn
 <willemb@google.com>, Yishai Hadas <yishaih@nvidia.com>, Ziwei Xiao
 <ziweixiao@google.com>
Subject: Re: [RFC net-next 0/6] Cleanup IRQ affinity checks in several
 drivers
Message-ID: <20240814172046.7753a62c@kernel.org>
In-Reply-To: <ZrzxBAWwA7EuRB24@LQ3V64L9R2>
References: <20240812145633.52911-1-jdamato@fastly.com>
	<20240813171710.599d3f01@kernel.org>
	<ZrxZaHGDTO3ohHFH@LQ3V64L9R2.home>
	<ZryfGDU9wHE0IrvZ@LQ3V64L9R2.home>
	<20240814080915.005cb9ac@kernel.org>
	<ZrzLEZs01KVkvBjw@LQ3V64L9R2>
	<701eb84c-8d26-4945-8af3-55a70e05b09c@nvidia.com>
	<ZrzxBAWwA7EuRB24@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 19:01:40 +0100 Joe Damato wrote:
> If it is, then the only option is to have the drivers pass in their
> IRQ affinity masks, as Stanislav suggested, to avoid adding that
> call to the hot path.
> 
> If not, then the IRQ from napi_struct can be used and the affinity
> mask can be generated on every napi poll. i40e/gve/iavf would need
> calls to netif_napi_set_irq to set the IRQ mapping, which seems to
> be straightforward.

It's a bit sad to have the generic solution blocked.
cpu_rmap_update() is exported. Maybe we can call it from our notifier?
rmap lives in struct net_device

