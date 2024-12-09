Return-Path: <linux-rdma+bounces-6360-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E541A9EA13D
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 22:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9712812C9
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 21:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D9219C54A;
	Mon,  9 Dec 2024 21:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5KknzmR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE9137776;
	Mon,  9 Dec 2024 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733779656; cv=none; b=I2xWjt/c5YcouvamgjdKTr6/uUzjsJbCayWX/9NRjlBxcKi5u/zujvWHoubGf44NrgbS4MLeIoVXbpnidUVJgjNQ4XDH4W3faQJGa3NP6CVjbs1Eb7TnkE9VbVdaq1vF3fKmkoQ7dH6bCEVDf6A7KzVyviZG9izHCirunRvXKLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733779656; c=relaxed/simple;
	bh=+qukh2XbV6KaB9kzuTea5erliC1lN2pxF715VXXQbvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USNgFWuAXbQLl0qCP+N0x8tsNF3TQplGat3TG5peBFwaqLaQc6jzoco8oC6wCmxLpseiqk5rctK3+zmHNho0L7kTMoPRcunO9wpMxAOFUvd1ZoI36YBfRdhYfgeXtZpXCkSn3eDHtH/OfEJTxFJ951W65BHmBKGsexb8yTAPEd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5KknzmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35916C4CEDF;
	Mon,  9 Dec 2024 21:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733779655;
	bh=+qukh2XbV6KaB9kzuTea5erliC1lN2pxF715VXXQbvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F5KknzmRSLs/w7McMVMH7TzhP7U4noJrVHVhezDHxJHKRwhBzFgZzddaxcN7NkFdX
	 VJ54Rudji0tkWdHKG4MNr9/c9hEcjxV9+vSvWYqB3ysvCo9dBHkCkdwZfbPgDX5WrD
	 +XMztNQU5CCXJ2iNeOXfQ3EN/y00J37+wT3/Bl5g8GVzXn3ZoHAqVApdhUQCPQdG8E
	 aBe3gE/9MP1Bvf/tYVLipJb2qg2nHFY9h+qw6Ta/iA0jSksgynulWYggonwZdB868X
	 plLwp+uyt+h4UP1p3+TQUGi8vGV/rHd/VmfCH944cNT0dXc38Q0azayW8yYru17QQE
	 sJ5N737kslveg==
Date: Mon, 9 Dec 2024 13:27:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Leon Romanovsky
 <leonro@nvidia.com>, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 linux-rdma@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>, Cosmin
 Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V5 07/11] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <20241209132734.2039dead@kernel.org>
In-Reply-To: <89652b98-65a8-4a97-a2e2-6c36acf7c663@gmail.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
	<20241204220931.254964-8-tariqt@nvidia.com>
	<20241206181056.3d323c0e@kernel.org>
	<89652b98-65a8-4a97-a2e2-6c36acf7c663@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 23:03:04 +0200 Tariq Toukan wrote:
> >> +	tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
> >> +
> >> +	if (tc_index >= IEEE_8021QAZ_MAX_TCS) {  
> > 
> > This can't be enforced by the policy?
> >   
> 
> If we enforce by policy we need to use the constant 7, not the macro 
> IEEE_8021QAZ_MAX_TCS-1.
> I'll keep it.

The spec should support using "foreign constants"
Off the top of my head - you can define the ieee-8021qaz-max-tcs contant
as if you were defining a devlink constant, then add a header:
attribute. This will tell C codegen to include that header instead of
generating the definition.

