Return-Path: <linux-rdma+bounces-14895-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A66BBCA50BC
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 20:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE4AB31AE74E
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B16F31B10F;
	Thu,  4 Dec 2025 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAByHYys"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E405C30B515;
	Thu,  4 Dec 2025 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874660; cv=none; b=Bsy/FPMdrvgEQt/DdCYF/bKz8fe/jQLYYc2jv+9zXHr42qpO8TeEQnuKw8Gvjh6B4cqNMrpFe8Okmr/uDJ5b8kT69lP9i8S9t4+YHNHi+8m+XQyiu3snkXYbTpfSx4KgdmNyKNU6w4teDMfeS75MdNQLN7RBgtJ6SPRTAgOzoE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874660; c=relaxed/simple;
	bh=9Zq1ES5P5+XVpaBu1aYtF4Iei5gaOpjPUkiNGe726QE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1KWqtmkNY5mI3o4oR9cM7c9GkkR24r6LoWwtBAC9n6LEtu2WNnQQl8lBhGG9jbSwQBK5y3jeNn9M4PyKws2R2rrf1eP/rMXZia+RSlpqderoywtl1irqh8jRSbDrXQp74SnAgp8Oh9VZkNg76FVOnzVzEkLayp1etwOVR4Rvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAByHYys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C84EC4CEFB;
	Thu,  4 Dec 2025 18:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764874659;
	bh=9Zq1ES5P5+XVpaBu1aYtF4Iei5gaOpjPUkiNGe726QE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JAByHYysumQIT2lLJhP2nDT8Z5GRTiTBJevp7KII5nkDuPaCs4TsaRkWV75R7j3zN
	 8+Cz/ihgjDjYoNdjFXAbDnrPNXGfZyevNytNtNZGYFB18iB+a1fm5c6+H4ANlj8T1t
	 TbjHgbV305y9tPtlriIyxeHBAhIq6bTHghtKyaDX4z6dREKlDSl6/ZPYwT12ksDNh1
	 3tVR2Zi1v/T6uCsnaaf1RKZLUOkWKtLL4wfhqkZKehE4aNNDSYo0tcQj86qVWipQTM
	 lO9SjS1zgh7ges2zciQw5Mb1j/PAVhWoAW03ysfJLu73vUxhs1ZJJx2v5HlZQT4jM0
	 +kBeWL/c2XuAg==
Date: Thu, 4 Dec 2025 10:57:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH net-next V4 02/14] documentation: networking: add shared
 devlink documentation
Message-ID: <20251204105737.551d1cc1@kernel.org>
In-Reply-To: <vwdbowwy3eivqwwypwo2klexhu47qpvb6nevjg3st7a43ucmxl@tllljudder3l>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
	<1764101173-1312171-3-git-send-email-tariqt@nvidia.com>
	<20251127201645.3d7a10f6@kernel.org>
	<hidhx467pn6pcisuoxdw3pykyvnlq7rdicmjksbozw4dtqysti@yd5lin3qft4q>
	<20251128191924.7c54c926@kernel.org>
	<n6mey5dbfpw7ykp3wozgtxo5grvac642tskcn4mqknrurhpwy7@ugolzkzzujba>
	<20251201134954.6b8a8d48@kernel.org>
	<2lnqrb3fu7dukdkgfculj53q2vwb36nrz5copjfg3khlqnbmix@jbfmhnks7svq>
	<20251202101444.7f6d14a8@kernel.org>
	<vwdbowwy3eivqwwypwo2klexhu47qpvb6nevjg3st7a43ucmxl@tllljudder3l>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Dec 2025 11:36:13 +0100 Jiri Pirko wrote:
> >To be clear -- I understand how you're laying things out. My point is
> >not about that. My question is how can user make intuitive sense of this
> >mess of random object floating around. Every SW engineering problem can
> >be solved by another layer of abstraction, that's not the challenge. 
> >The challenge is to design those layers so that they make intuitive
> >sense (to people who don't spend their life programming against mlx FW
> >interfaces).  
> 
> Well, this really has no relation to mlx FW interfaces. It is a generic
> issue of having multiple PFs backed by 1 physical device sharing
> resources. How to make things more intuitive, I don't know :/ Any
> suggestion?

We're talking in circles. Having a single devlink instance for the
"1 physical device" is far more intuitive than stringing together
ports from two devlink instances by using a third instance.

