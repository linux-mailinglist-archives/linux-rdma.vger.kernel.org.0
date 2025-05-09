Return-Path: <linux-rdma+bounces-10206-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D22AB182A
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 17:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C443AD431
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478091E32D3;
	Fri,  9 May 2025 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qi4B+HiJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E7136672;
	Fri,  9 May 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803788; cv=none; b=OrucPl8H1ZSepcFg/PIIWZoI6/gi52ir6OwQzAMtRhJrdx8hOzmutzG1eQfld3C/9Xucmu9sfXNZMkV8FRO+k2ssaHBhpqm0UaYpIUZ9ME7T6UWGBYHCW87WPjpPZEP53G4GaxjGWm4LpZ07Ff2qhSyhRyDCmsUbZ2Ii3nyfNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803788; c=relaxed/simple;
	bh=Pmkce8qVMsNVwI69XQITO9G5V/cr9TvluNNQw1inero=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JwIlJFjYuhpWrVnmuCCpnWPeSDyZ0EJXWwoE8EIwt6FLHEx08S5fAc/pA9I79x/AKAdO3z3bgJY4aowMqoVoTnXJHTOg47DStk29i0eCY8KzfpCmWd7cuXobHAXzTN3jxNU9pD8PSri8bcMfcBSMM0X6ZANNRYngqhLQn40NHT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qi4B+HiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1058C4CEE4;
	Fri,  9 May 2025 15:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746803787;
	bh=Pmkce8qVMsNVwI69XQITO9G5V/cr9TvluNNQw1inero=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qi4B+HiJNPdyFh+T0o6JQZj8iKBeNJszyNC1/RPQ9AgHoXGNA55u9nyGGVqz/IcaU
	 Zm4fyb3VuAtTJcdgima7v5gDZceJjCCZuG+/025xshFU6fS4oxbXKWOhvfH3QSm6Ey
	 JR5nchlUK6MAsAIuaL0qVjzF7dDjw8T7ODEL65incR2M/mLbLJ4cITY9tMZTxMHCLy
	 Tz7cWGCiAiNgAewXktvhmPlct+LAU5jHyitUusWQWrJLTcZDNHaJoKMpnGgNDR9rtP
	 eF9FL0TmZlvs2VCu4FIq05RTFjq6N40yT+Q452/c1NbecURWdyhEnynjVSfiJtRH9R
	 g80hWSxmkKKYQ==
Date: Fri, 9 May 2025 08:16:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Jiri Pirko <jiri@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, Donald Hunter
 <donald.hunter@gmail.com>, "Jiri Pirko" <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V9 1/5] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <20250509081625.5d4589a5@kernel.org>
In-Reply-To: <1746769389-463484-2-git-send-email-tariqt@nvidia.com>
References: <1746769389-463484-1-git-send-email-tariqt@nvidia.com>
	<1746769389-463484-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 May 2025 08:43:05 +0300 Tariq Toukan wrote:
> +  -
> +    name:  devlink-rate-tc-index-max
> +    header: uapi/linux/devlink.h
> +    type: const
> +    value: 7

Ugh, still wrong, the user space headers don't have uAPI in the path
when installed. They go to /usr/include/linux/$name.h
But for defines "local" to the family you don't have to specify header:
at all, just drop it.

And please do build tests the next version:

	make -C tools/net/ynl/ W=1 -j

I'm going to also give you a hint that my next complaint will be that
there are no selftests in this series, and it extends uAPI.
-- 
pw-bot: cr

