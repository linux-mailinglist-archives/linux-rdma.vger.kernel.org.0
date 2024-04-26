Return-Path: <linux-rdma+bounces-2120-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92B8B409C
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 22:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009E01F20EAD
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 20:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8EE2231F;
	Fri, 26 Apr 2024 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsUJ4W5z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F5208AF;
	Fri, 26 Apr 2024 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161708; cv=none; b=TCrfUAfbRfaMycVGehzQTHdtX96l1bBweTVFJFYuux43Pwx0Tc+N6SVcDLESi/IuxHSsd3CQe9EPycGE7pzrIEGoqlF+xS+nUBd9UkWlJ4rNx2mJvyNTSOj6IQElGRhBHy4EdpFCEISeaMOo0a9V1nnY9e9Wtlh7XgIzCXRTRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161708; c=relaxed/simple;
	bh=MahVcYkWIW35DVjmo4wKi15I5PhvaEvUqhpmU0V8nRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHpZTYT5cVxKEfzZRtq2f9RWBq/UWTBwIY+5Z2LEPp5eAm8rzLficP1XljniJVAxh/nSe4RS9hfRSoqrke5bTpYW4sFkK4/7E4rhvARPmZttcqndPfvOZl7hvFAO8NsOz+E2X+tbRz45q4XW2Hv5spbBwDtDCe6AGPo1jZ0v6Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsUJ4W5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3542CC113CD;
	Fri, 26 Apr 2024 20:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161707;
	bh=MahVcYkWIW35DVjmo4wKi15I5PhvaEvUqhpmU0V8nRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZsUJ4W5zkrJZj0EhH2Iurfq2Ja+qWlfd5QYhfHA8YLWCdQzoFfciMtyIQ5WIz4G3Y
	 xK3PrvFE7EAATxDTl+0rgZMUDTW+j+9dTevDEYsYUjRGZ8MpxOq1BJphP80rdJ+Inq
	 0Gj1uLxz5iW07cIHdqxbp6VsnO4ZJ3MaIvCoWDklHew2tS1FtPOevyXyakhV9QZicJ
	 iCDdmXQatSpkN9F++xRnvcIoiGCya8565UaRpaxmaFPjNkvMLm08y61cqpdeVOEvv0
	 T0XdBn4JzqLkqy3E4+01k2cs8M2naFa+uqH2Hx6kmtTSnQgkHLw2jtNMIhXJq8QcNU
	 yd4M5gEJEUNBQ==
Date: Fri, 26 Apr 2024 13:01:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
 saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: Re: [PATCH net-next v2 2/3] net/mlx4: link NAPI instances to queues
 and IRQs
Message-ID: <20240426130146.241c7545@kernel.org>
In-Reply-To: <20240426183355.500364-3-jdamato@fastly.com>
References: <20240426183355.500364-1-jdamato@fastly.com>
	<20240426183355.500364-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 18:33:54 +0000 Joe Damato wrote:
> Make mlx4 compatible with the newly added netlink queue GET APIs.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>

Acked-by: Jakub Kicinski <kuba@kernel.org>

