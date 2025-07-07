Return-Path: <linux-rdma+bounces-11922-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95E9AFB1F5
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 13:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2477C3AD23F
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 11:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1AD292900;
	Mon,  7 Jul 2025 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImKWaoah"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818CB21C16A;
	Mon,  7 Jul 2025 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886518; cv=none; b=pNF3DAw9BoSHKDX286I+spCUWhu/L2z4LZ7T7R0k3a2t7/OxYXyyd8+WHDkn3zBdSKJnZscETKBoMbJDYhiVCG5Mt+2h1TUvfrEdBctGo2YoLQnaGnKQJGY2E6vta4zi7ivkMl+M8Ai6YiHIQJu05NoBuUeGCeRGulI9MbJEH1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886518; c=relaxed/simple;
	bh=FKI2rB/yPC5QIf4NASTeFT8bZ3rOKSe+XXaI45t3Ulo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkABrg/fxJ6aeqt9BtYyULsbugEjzvo87ox7haihJyIw1ARKEcMi1iESuL8xQS3wFx3U9jHcpiudeIO2qTC7hKm1YZmqEC4w7zwCYqMEOI4HB5WoWy8On3rx5xay8pxUrgXLrTkpJJLL+u6XSK/41T5X+0pmTFSnj7j67binNVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImKWaoah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7378EC4CEE3;
	Mon,  7 Jul 2025 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751886518;
	bh=FKI2rB/yPC5QIf4NASTeFT8bZ3rOKSe+XXaI45t3Ulo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ImKWaoahWJkxUWVYCpuxAwUqBTTIy8JZ08E6hO+Sit5Y1jnCyQ5aIHr/v4uAt6a18
	 CVERX4tzF2CDoOHnSm2+oqbDCCbv8EwMxIZh3Y6FJOfuXtX2WP71Zo5Bsr4glLiEkt
	 lcVEk3JDr4UqtAJg2bfctNCzZCnUA666Uyj1QcPgLv856r/SGClZMm5J0gDa/q/owl
	 EBicNqme8LGthbLbjKfwiVSRV5moOoRTDwFAAnY68STQkFiU0H/WCmC5nl98UnRM/G
	 MU5skokokystoUszqIQhoarqPaIUH63rKLTB6JKk9GiBY9MXeNMlXhYfvtfFfHLoos
	 m9aHe36JbKgXg==
Date: Mon, 7 Jul 2025 12:08:33 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com,
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vlad Dogaru <vdogaru@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next v3 03/10] net/mlx5: HWS, Export rule skip logic
Message-ID: <20250707110833.GG89747@horms.kernel.org>
References: <20250703185431.445571-1-mbloch@nvidia.com>
 <20250703185431.445571-4-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703185431.445571-4-mbloch@nvidia.com>

On Thu, Jul 03, 2025 at 09:54:24PM +0300, Mark Bloch wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> The bwc layer will use `mlx5hws_rule_skip` to keep track of numbers of
> RX and TX rules individually, so export this function for future usage.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


