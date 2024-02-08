Return-Path: <linux-rdma+bounces-980-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEE384E6F1
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 18:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B446F2890CF
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61F782D71;
	Thu,  8 Feb 2024 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNILuT/b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E31481AC7;
	Thu,  8 Feb 2024 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414080; cv=none; b=ZDwZmESg5F4k1dm76urOSB1GYPoisEafnSpV85EOGes4D4EMCGN7GG9yNw0XOK3dHCKK2jrEMoLOXzbHnZDQX1rROPVmOsyPFnGNP2GDC3S2iMMAfnN4E4rrcI7oSaOVVW0H4oBE9X25VE4HOceuhcEAtalmSPJNjfGInOkWwL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414080; c=relaxed/simple;
	bh=zE4ayhFFYfUDtHfPqiCEReBzVlFLFlP5UT0Q/CEWF0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQKVY3ScbPMDWEBFJtDRSMS71kq3ngOiiTdahSpNWPoRZEJVanrJwNV6sXE8oPC7NKUXROo9rI7t3KENrNHqzWCXZGJ1TP9z3zZed0xL6nCtkF6AGIVbfK57DX4iNQkVqDHkRdngYBFIjA2Cqn0fHLUwmxnQ6uhPSF+caNiwMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNILuT/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD68C433C7;
	Thu,  8 Feb 2024 17:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707414080;
	bh=zE4ayhFFYfUDtHfPqiCEReBzVlFLFlP5UT0Q/CEWF0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HNILuT/bOnIxnBOONTmETYLb7XVvN00ysIs/QVFbjYMyq8alZ1Owti/YEDJqdHb38
	 te+OUrj20aU2R9NTMM5tzDBRUuu1oKxVWBaKve5Pv/lDZIzdrTG7/rluP7AulciOAJ
	 7KoXTdIsuLrhYeDz7HOge6fhmP9u8SEFRH9dZd0TomdZ+iHwz76YnP12th/DyNcG9o
	 qIqxp3NuzwNpFHSidQQYxwX/hmWMAmhn+57IGjYDlvSDFicIJ1AyG1FgjIREZ9qotd
	 arx04erUjonACvwh7/jFlDRc/ad/yg0PG9sveOJx/LBUe82csxmL6zdbcyFQDnqimA
	 TpzEe121juV0g==
Date: Thu, 8 Feb 2024 09:41:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com, rrameshbabu@nvidia.com
Cc: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-rdma@vger.kernel.org (open list:MELLANOX
 MLX5 core VPI driver)
Subject: Re: [PATCH net-next v3] net/mlx5e: link NAPI instances to queues
 and IRQs
Message-ID: <20240208094118.0b74bbcf@kernel.org>
In-Reply-To: <20240208030702.27296-1-jdamato@fastly.com>
References: <20240208030702.27296-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 03:07:00 +0000 Joe Damato wrote:
> Make mlx5 compatible with the newly added netlink queue GET APIs.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

nVidia folks, I'm also waiting to use this, so I'd like to apply
this directly. Please review.

