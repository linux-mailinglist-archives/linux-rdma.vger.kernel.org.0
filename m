Return-Path: <linux-rdma+bounces-6361-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BE09EA155
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 22:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1878F18883A3
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 21:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEAB19D06A;
	Mon,  9 Dec 2024 21:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXexPc3X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171AE46B8;
	Mon,  9 Dec 2024 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733780503; cv=none; b=KZc5mJZsKKIE6EgHmr3ZJdYQVcmyO4m0yKJ70rKumKAdaDv+4yf49PT/8sPByX1LFja+pLZhnFPK7B0LkG4vcTMoYeFzKSbfvJYjpODpaSJ/UK304O4p05/yVL6jPdO9EBAunHYV7s9lEAgi//yfagm088ZDf7M9ZfCX+i1SKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733780503; c=relaxed/simple;
	bh=0l5TuFgRmp+GXL7yja/u+yNnuIVsDN3v47iEWRBBSlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEj7Nsj9ukxlfUN5wRkG4jwJEpnjAtODfek/Fz3KU/bNeBC1FvOS/a9iK+Tu52xD/9eNHT9KCgEZ0Ge9cVNeAH6dC60dqrUdh1HtdEIDHoTMwfnTk+OEd8MgF/BY9ZjuQaxDpZtRCIsDW84ZjVErZuwD9TagRwSa+ST5r2rO1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXexPc3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB1DC4CEDF;
	Mon,  9 Dec 2024 21:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733780502;
	bh=0l5TuFgRmp+GXL7yja/u+yNnuIVsDN3v47iEWRBBSlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gXexPc3XP1XtZyX1VChkh8sss4pevk74oPygzre2rhYDrVlab1FfSbXYvF7i+g5QA
	 j7v3YxFGn6eFzzoZjcxJMQ5GXiR3mIjviERt2qT6pH4PFzGhAK5+EmmHEzZ5zvk3lt
	 TpdnHf4uCh1pTT81kHUVTkO5ufBLkLYS2xbDm/KZ+2AtFDh5imDmana4ybKgl5E9gU
	 zr+ClLZzGlNmO9dr2AiRdjhDq+qOniFTl1s/kxywduACvEJtF6Mh62QE6L81nePL0Y
	 K7Ucsm8G4ZIOm/gqkRaySozUiigRA6naTTmtihvPj4N9NyJNioeko+G5wujNBMh+Zv
	 a9hRFYdn8/Ikw==
Date: Mon, 9 Dec 2024 13:41:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Leon Romanovsky
 <leonro@nvidia.com>, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next V5 00/11] net/mlx5: ConnectX-8 SW Steering +
 Rate management on traffic classes
Message-ID: <20241209134141.508bb5be@kernel.org>
In-Reply-To: <d4890336-db2d-49f6-9502-6558cbaccefa@gmail.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
	<20241206181345.3eccfca4@kernel.org>
	<d4890336-db2d-49f6-9502-6558cbaccefa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 21:32:11 +0200 Tariq Toukan wrote:
> > Do you expect TC bw allocation to work on non-leaf nodes?
>
> Yes. That's the point. It works.

Let's level -- I'm not trying to be difficult, but you're defining
uAPI with little to no documentation. "It works" is not going to cut it.

> > How does this relate to the rate API which Paolo added? He was asked
> > to build in a way to integrate with devlink now devlink is growing
> > extra features again, which presumably the other API will also need.
> > And the integration may turn out to be challenging.
> 
> AFAIU Paolo's work is not for shapers 'above' the network device level, 
> i.e. groups.

What's the difference between queue group and a VF?

