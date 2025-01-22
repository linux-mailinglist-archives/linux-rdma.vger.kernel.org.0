Return-Path: <linux-rdma+bounces-7179-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE5A193E6
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 15:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE163AC78C
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40942135A5;
	Wed, 22 Jan 2025 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo/Jg9TO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB84C145B00;
	Wed, 22 Jan 2025 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556239; cv=none; b=NnXs/w685rjbDvOevaZt44U5+ybh+ElMFfgh2VK6zs+YhY0711Yot1CTL5mzVAoV0H9/0HuJr8yFrWQT87dW7ReV6JDbkB/XzH0StilbUL7MkQ5BVJ7DAfxxpEY2EMMctFsobDRriHxApG9CORFEb6zAz3V9Dz1D4rLIueWoGqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556239; c=relaxed/simple;
	bh=aHbrfQdsKDsfaCUxOPl2sjEPpqczDwuzK1JwJBd7uCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zl3d0BcrVR2hU7wHqA1jMgzKxdlKaZTV9/I2PinuYuTxPuMgjU7ydyYXWo2cD4pYuVaO+c06JsmliXc6tl6rTIf/JUhoxGmR4gkoIsEduQVr5kTAcWfM2y9r8tjjfEiNaK9pVNsd2D8G8Fmy7LJySNaORRJFtjNQMDmc2qYdSE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo/Jg9TO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A322DC4CED3;
	Wed, 22 Jan 2025 14:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737556239;
	bh=aHbrfQdsKDsfaCUxOPl2sjEPpqczDwuzK1JwJBd7uCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qo/Jg9TOoALLSn1WU1RH+78RJKtUjLuPwzIaTCiCx5wv0gmzi2Yaklx/PfngmWvEb
	 6a7Jj+6o0d45/AbIoy55B9vkX66d8baISmn/RFfoBz5J9SR9dwkVDMsiIENhZ3bojo
	 ve8uyOGxMGopI3fd8lUIKOVrWuOSqBoPQBxO/e37zwf0kxEghsYnLvdY7j4+V0wnl5
	 HiBKu/rotV93vmx1LnYaHtsftSh8WyeJvD0ImUsZopPztmBTSmtVR5uOVUTTWEqUaa
	 dNl67bIIPJymSz0u6A6f7Z70lyBr3CdyYtgFg+0+H+nHtT8SOr54ucMxXpgYVD4b1T
	 4zMGx7wqkR5fw==
Date: Wed, 22 Jan 2025 06:30:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Tariq Toukan
 <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, linux-rdma@vger.kernel.org, Cosmin Ratiu
 <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V5 07/11] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <20250122063037.1f0b794a@kernel.org>
In-Reply-To: <8dbc731c-2cff-4995-b579-badfc32584a1@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
	<20241204220931.254964-8-tariqt@nvidia.com>
	<20241206181056.3d323c0e@kernel.org>
	<89652b98-65a8-4a97-a2e2-6c36acf7c663@gmail.com>
	<20241209132734.2039dead@kernel.org>
	<1e886aaf-e1eb-4f1a-b7ef-f63b350a3320@nvidia.com>
	<20250120101447.1711b641@kernel.org>
	<a76be788-a0ae-456a-9450-686e03209e84@nvidia.com>
	<8dbc731c-2cff-4995-b579-badfc32584a1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 14:48:55 +0200 Carolina Jubran wrote:
> Since this worked and the devlink patch now depends on it, would it be 
> possible to include the top two patches
> https://github.com/kuba-moo/linux/tree/ynl-limits in the next submission 
> of the devlink and mlx5 patches?

I'll post the two patches right after the merge window.
They stand on their own, and we can keep your series short-ish.

