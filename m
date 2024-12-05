Return-Path: <linux-rdma+bounces-6269-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4309E513B
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 10:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1831881F18
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FE71D61A5;
	Thu,  5 Dec 2024 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W27tjTcL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F04D1D5CEA;
	Thu,  5 Dec 2024 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390640; cv=none; b=KxihblO8DVs25cU8nuCZQzBh4mnUlEwnH6LGDz0E9wEXFlQNtAhbkvbKqz4l7Yu9g/73hdc2JMU1JsYN5NCjDcw7PvKEhDh+bhAT1aN8QxEx4xWy7Z4RXrrozpxQjNFmLhx1lPG8CR5nL6mqs+1L0vAmJ086FzCPStLsUXozLPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390640; c=relaxed/simple;
	bh=/mg1IxF3kvQ9NbO2mUJkLJr2O/j0Y5dHSawH3caqhrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=io9cb2ZZvJQaNUlVoUmgy6neJ6ZH3LGirE0Qog+DzDukn0vMdAcW4sjfV0vrzhGfYoty6Dhi8UepflcQdi3Mq9uDNEsJa9Cch/ca32HM5KmUHa+JOFhBY5lAPv/qEBk8m3gisoEO8dvFRGxMeXwD/hPeffB5nPMyG1QqIuspJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W27tjTcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B753C4CED6;
	Thu,  5 Dec 2024 09:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733390640;
	bh=/mg1IxF3kvQ9NbO2mUJkLJr2O/j0Y5dHSawH3caqhrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W27tjTcL0n1ZrdzZx8+HLr9j8SigSyMQNxMragTkrORbUMrjrj9RSi+SxS947g7Sr
	 NS4dS4NnGuUUzv3IXfUKxe1oPMLwHxHggBKcOqN7OYNUclnkG2LdHDqZOwYMJqoMIo
	 7YQbeEESLud5VmEQGF0GCUHvUCK8WsVIhp6mivt84eW9qYF1Shk3lwMOGDkkb+zR9+
	 4QUbW4Shidz8kritcJ9gSkKm9dcoNcQBFODWpCekp2B8kDYeRhUtZAa/tOVgIOW+ST
	 2sxA7r04r9MF79UL6B7hqCbgXbFoL66/uBDlW8vobARYrFDlFjdx4hjfYbM0j0zk1T
	 ZQtLI0+iRRyUw==
Date: Thu, 5 Dec 2024 11:23:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next V5 00/11] net/mlx5: ConnectX-8 SW Steering +
 Rate management on traffic classes
Message-ID: <20241205092355.GX1245331@unreal>
References: <20241204220931.254964-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204220931.254964-1-tariqt@nvidia.com>

On Thu, Dec 05, 2024 at 12:09:20AM +0200, Tariq Toukan wrote:
> Hi,
> 
> This patchset starts with 4 patches that modify the IFC, targeted to
> mlx5-next in order to be taken to rdma-next branch side sooner than in
> the next merge window.
> 
> This patchset consists of two features:
> 1. In patches 5-6, Itamar adds SW Steering support for ConnectX-8.
> 2. Followed by patches by Carolina that add rate management support on
> traffic classes in devlink and mlx5, more details below [1].
> 
> Series generated against:
> commit bb18265c3aba ("r8169: remove support for chip version 11")
> 
> Regards,
> Tariq

<...>

> Carolina Jubran (6):
>   net/mlx5: Add support for new scheduling elements
> 
> Cosmin Ratiu (2):
>   net/mlx5: ifc: Reorganize mlx5_ifc_flow_table_context_bits
>   net/mlx5: qos: Add ifc support for cross-esw scheduling
> 
> Yevgeny Kliteynik (1):
>   net/mlx5: Add ConnectX-8 device to ifc

I applied these IFC patches to our mlx5-next shared branch.
https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next

Thanks

