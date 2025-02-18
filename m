Return-Path: <linux-rdma+bounces-7815-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0070CA3AA8D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 22:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4863D1689FE
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8E1AAA1F;
	Tue, 18 Feb 2025 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeHqxNc8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3E286288;
	Tue, 18 Feb 2025 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913227; cv=none; b=F3/1snLUfQhdQ48aXLALlpkLWldMqu6Di3vDyOtCkeyREMXXege9nTYDqUjfuu4s52aQeVfKYM5+0zFC7eZNr3pcuCFxBY6mWGbuTp9YpYw6fcWg0AwtevkL7q65Mpd7D+eH3q0XE35oieywJbJ+pfUGnlMgjJRhhIzWIbAV+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913227; c=relaxed/simple;
	bh=KATj1qETJsGK0zJSt9LilsCAIoK6W52KCkD9Mf6B7WI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4zccrN2eUhGjaR6JfcrVzD+AK4298fr7HHU+z3tt/QW2Jaket2IVqDtgCl7hV/PIfa769hmMKvgcJOsrbcCl/toLzFMAdYpbHUug+lMs5Mh7rPngML088ljYOmhzTQEAAZTGmUT2rWLMOjnNPG2VPcMUGPN8IOlaFfEcMdSFDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeHqxNc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF12C4CEE2;
	Tue, 18 Feb 2025 21:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739913226;
	bh=KATj1qETJsGK0zJSt9LilsCAIoK6W52KCkD9Mf6B7WI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZeHqxNc8bB/srOb5IZAdB6hIGh+lIBakxW6jGaleTqmLJtXX/PoU4F5jvduRIBvU7
	 nNHvDambushh2Xgcz3ERD3Dy4yEUlOdVXVAdWbSg06PYP1iRni9trJXUx4W2MhsNVx
	 l7ewzbo/g5ITFSXALogYxPbiaOkPpcSpX+gZ7H0wnZpMcoF92sTqT6cid5/782/Fh9
	 rbN5ATVPkgU4fkDwlB19mCZQj/dm6Awayo7fxAWbX68gLDOSUoMwB28xO9V8olFcrh
	 mneNxfpK9p96IetlXZ28Nb4R01WQe4PtClMW19c8ShWVdFy4PZmXZuK/OBj6whDUn6
	 qxj8N6gH+rPrA==
Date: Tue, 18 Feb 2025 13:13:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <20250218131345.6bd558cb@kernel.org>
In-Reply-To: <59b075bc-f6e6-42f0-bc01-c8921922299d@gmail.com>
References: <Z6GCJY8G9EzASrwQ@kspp>
	<4e556977-c7b9-4d37-b874-4f3d60d54429@embeddedor.com>
	<8d06f07c-5bb4-473d-90af-5f57ce2b068f@gmail.com>
	<7ce8d318-584f-42c2-b88a-2597acd67029@embeddedor.com>
	<5f2ca37f-3f6d-44d2-9821-7d6b0655937d@gmail.com>
	<36ab1f42-b492-497f-a1dc-34631f594da6@lunn.ch>
	<59b075bc-f6e6-42f0-bc01-c8921922299d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 17:53:14 +0200 Tariq Toukan wrote:
> Maybe it wasn't clear enough.
> We prefer the original patch, and provided the Reviewed-by tag for it.

Can you explain what do you mean by "cleaner"?
I like the alternative much more.

