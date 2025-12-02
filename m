Return-Path: <linux-rdma+bounces-14864-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9C3C9C922
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Dec 2025 19:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD8B3349CED
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Dec 2025 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4DF2D028A;
	Tue,  2 Dec 2025 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUaxHgL4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26442C237E;
	Tue,  2 Dec 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699286; cv=none; b=Mz3rFuGcl/pjaGZzkCb7WmzX2JlYCHgmmpy1aK6Y//wSsfK/fOCf36WEIx1D4xPTXWIKz7Yz3KaF9KTv8OO5LIkU8enc6YqiSJfKhGT3yAhQOHVWdZ2G7yLX3XyOc6bb7khi2mRtKDSQJ449mA1nap9woW3yfGJTuGxwszxoOV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699286; c=relaxed/simple;
	bh=jRSbQ9Ne/+OOJgP0Z0DxW9fXwOZ0hOe2Zw0P1wm7xhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adgyFn1XZ5Gn/Cu6kvSve3NaRPbKUhXfciIPGKJO89avxHl4tc7IefFQyqg5aeMXoafddLCkdYBvridPKXQVso20e1i8HUtGdDl8DzuKiXKO0uVMO655LXQD2KzOCtwOK+8+D8bbB9TsqfHDhi7GBK5wAiKcgzxQpHdiIvwTOXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUaxHgL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80409C4CEF1;
	Tue,  2 Dec 2025 18:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764699286;
	bh=jRSbQ9Ne/+OOJgP0Z0DxW9fXwOZ0hOe2Zw0P1wm7xhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GUaxHgL4GY9fsqv8UmFGFWvYCTWtR5oAqKkY5DK6pcwDe9jAbJ2UB4/0V+u1bZS4P
	 zZ9Zgr1LxfvIs2gl1X+s0odz0wic1by62hkmzEyTrh7G1s/0JKW/8573fnlAoKahot
	 dR/NyjKNt9g6NgOYWQ8Sgs7/3Y1te65t1tWpFF7wqhsmKhwE+sfNCaiRPJRokrw7Ri
	 RqEU7zTiSrmOygOG60RIU5clxN3qwwdoHm1DcSAGjBnj5ShxGTUMgSvU2NAphVtVkX
	 taDq1uRV/mtBvHlAjjaaHFnHXx0uzrKhRW0DcAAZDTWZWBevB1AJiIo29QBzyq8P3e
	 fNoQPRtiMpmpA==
Date: Tue, 2 Dec 2025 10:14:44 -0800
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
Message-ID: <20251202101444.7f6d14a8@kernel.org>
In-Reply-To: <2lnqrb3fu7dukdkgfculj53q2vwb36nrz5copjfg3khlqnbmix@jbfmhnks7svq>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
	<1764101173-1312171-3-git-send-email-tariqt@nvidia.com>
	<20251127201645.3d7a10f6@kernel.org>
	<hidhx467pn6pcisuoxdw3pykyvnlq7rdicmjksbozw4dtqysti@yd5lin3qft4q>
	<20251128191924.7c54c926@kernel.org>
	<n6mey5dbfpw7ykp3wozgtxo5grvac642tskcn4mqknrurhpwy7@ugolzkzzujba>
	<20251201134954.6b8a8d48@kernel.org>
	<2lnqrb3fu7dukdkgfculj53q2vwb36nrz5copjfg3khlqnbmix@jbfmhnks7svq>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Dec 2025 08:43:49 +0100 Jiri Pirko wrote:
> Mon, Dec 01, 2025 at 10:49:54PM +0100, kuba@kernel.org wrote:
> >On Mon, 1 Dec 2025 11:50:08 +0100 Jiri Pirko wrote:  
> >> Correct. IFAIK there is one PF devlink instance per NUMA node.  
> >
> >You say "correct" and then disagree with what I'm saying. I said
> >ports because a port is a devlink object. Not a devlink instance.  
> 
> Okay, you mean devlink_port. You would like to see NUMA node leg as
> devlink_port? Having troubles to undestand exactly what you mean, lot of
> guessing on my side. Probably I'm slow, sorry.
> 
> But there is a PCI device per NUMA node leg. Not sure how to model it.
> Devink instances have 1:1 relationship with bus devices.
> 
> Care to draw a picture perhaps?
> 
> >> The shared instance on top would make sense to me. That was one of
> >> motivations to introduce it. Then this shared instance would hold
> >> netdev, vf representors etc.  
> >
> >I don't understand what the shared instance is representing and how
> >user is expect to find their way thru the maze of devlink instanced,
> >for real bus, aux bus, and now shared instanced.  
> 
> Well, I tried to desrtibe it in the documentation path, Not sure what is
> not clear :/
> 
> Nested devlinks expose the connections between devlink instances.

To be clear -- I understand how you're laying things out. My point is
not about that. My question is how can user make intuitive sense of this
mess of random object floating around. Every SW engineering problem can
be solved by another layer of abstraction, that's not the challenge. 
The challenge is to design those layers so that they make intuitive
sense (to people who don't spend their life programming against mlx FW
interfaces).

