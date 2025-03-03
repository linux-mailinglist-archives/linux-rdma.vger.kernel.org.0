Return-Path: <linux-rdma+bounces-8275-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C09A4CE2D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 23:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE373AD501
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA1D22F3AB;
	Mon,  3 Mar 2025 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvoPBHed"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F631EFFBA;
	Mon,  3 Mar 2025 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040390; cv=none; b=E55ABOlAR0SIq3xixhCe/d2oWsmeeSaVBl41+v8P57Usobot3e0nZuiwZtXz2EvZuezetDFA65PgG71YMAdd8xUsGhNdwXoSAC6s02vZZ0LzcqTWf+Wi2YKL5a4NGnskkpN6UM4AOnx/vk9cBZYCrH6n7GbSpX6NrLbOX+Eqk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040390; c=relaxed/simple;
	bh=lhz6YjfSTKtzAmONbQMPFT2eHdU4hQ3fNb+tQ4kLtBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJmrZ+SHJiCrAowQKJtKqg1nukY+aSW4iypIE8mRHyod3mMii7jCvIApCB/f/mCjBacWsKqY6GNMIZCcK0lTaU3wrx9jJwkaS70Sre02n3Vh/fjVTb3Zuj7CF4brPI0H+v+oMuUJAIVSBBCgW9jnMeL+rN9eP+cyvdKTxMPcpL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvoPBHed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEFFC4CED6;
	Mon,  3 Mar 2025 22:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040389;
	bh=lhz6YjfSTKtzAmONbQMPFT2eHdU4hQ3fNb+tQ4kLtBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UvoPBHedP90g0YpFicl7IKfoT1tdRFQD6k63Vjx1L59UfdvheV1y4EwUVIKFmuLcw
	 q0iqMYlci5Kj6/7aq/2vDNUeU7bo/4CbHRKoFlDslsesbsCSvPBR1YLhOvZ6NCIAoj
	 8dcfZaB1MewlbGBgR5GjPshSCRB0P22cADv4P9h8Gb+NudUQLTobuIxZQKjOX3+zEU
	 DZCH7gqSGpynwCGKN1oKqGW79Jv/EqyuJPew2T4juZ0q95UpJXWCJXtvlo8Mh2mJJL
	 ZpSMZXBGs0xROWiNVIJETIbkAW3zOQzRUesgLBSWiKki8x8YYkLbTbNFjKM1CmAgV4
	 RoQxjes3twGnw==
Date: Mon, 3 Mar 2025 14:19:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 3/6] net/mlx5e: Enable lanes configuration when
 auto-negotiation is off
Message-ID: <20250303141948.53a5cee6@kernel.org>
In-Reply-To: <c57977d0-5af6-44b7-80a4-00024f3e5e49@nvidia.com>
References: <20250226114752.104838-1-tariqt@nvidia.com>
	<20250226114752.104838-4-tariqt@nvidia.com>
	<20250228145135.57cf1a73@kernel.org>
	<c57977d0-5af6-44b7-80a4-00024f3e5e49@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Mar 2025 10:17:58 +0200 Shahar Shitrit wrote:
> On 01/03/2025 0:51, Jakub Kicinski wrote:
> > On Wed, 26 Feb 2025 13:47:49 +0200 Tariq Toukan wrote:  
> >> +		if (table[i].speed == info->speed) {
> >> +			if (!info->lanes || table[i].lanes == info->lanes)  
> > 
> > Hm, on a quick look it seems like lane count was added in all tables,
> > so not sure why the !info->lanes
> >  
> it's for the case only speed was passed from ethtool (then ethtool
> passes 0 for lanes)

Makes sense, I think I read the condition backwards TBH 
(table[i] vs info).

