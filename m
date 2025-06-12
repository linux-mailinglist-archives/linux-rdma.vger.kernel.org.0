Return-Path: <linux-rdma+bounces-11253-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDFCAD6BF9
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 11:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1BE178CD9
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 09:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C244223DE1;
	Thu, 12 Jun 2025 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUdmJjaQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5DF2F4321;
	Thu, 12 Jun 2025 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719831; cv=none; b=NUEzX/kZCeWKKPy1KdsO3TGx8612R0+JgMqlgwqocuXVTGiExr1wy5/Fur6k65Tt5wJNs+fCjV3QMAq/muSpJKCNci7UgYbkRi/QqNqHs1e3tl6qc7cTzJggVxaX3oGZBbsH9k+KaUHhFdX2CVHbhLRQSb/IhlfxJBCT9zRf/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719831; c=relaxed/simple;
	bh=0CS6UxLwmkxg7FlF7moiajVuy5DQezaNlEbQHV6J/rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG5BSAKCkiO3kvzG8W/eysxEHf1x2jYDVEhalVlgtSSK2+/h0HpRibsHYtHk8IptLIZpmQreKD5ZWOk2tqAYVMhYNsSxyD5enesD5ZFpS0wLeQyCg/o/0t3IFujOery/+7JdUkFlIWVZ029JZ5waX7w0tt8SqQeBBeXS3o0dy2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUdmJjaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBD8C4CEEA;
	Thu, 12 Jun 2025 09:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749719830;
	bh=0CS6UxLwmkxg7FlF7moiajVuy5DQezaNlEbQHV6J/rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUdmJjaQDvxiDPfu/vHCbeYYirs+IqJEidua379Aou3fw3irSw9PPDC+ZsQcylCtb
	 Fqg5F33A+X+4tSIuJS18NydG7COronadV0ToXqOawRNP9uayHR9GhFjfwNO/gYyQTX
	 deto7JyvjkU1J+eT3TpsYCDGx37jSWs1980PX+5UeS7ABJa5b20SUgzerWcY8q/kEv
	 LwcWawBSSMrg3GXXRV645fOpyMtNPbjTMFJxqA+qnmI18rosEVkhEMp9/suFZplYlp
	 kWN3KiUEK5LZRnJqXGNRo4bsZz/MQCqLKXIn/rzEUAYYlwzKX02Y9M7umYiOjYpB/+
	 qc0igVATZJKkQ==
Date: Thu, 12 Jun 2025 12:05:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
	Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: reduce stack usage in mlx5_ib_ufile_hw_cleanup
Message-ID: <20250612090525.GT10669@unreal>
References: <20250610092846.2642535-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610092846.2642535-1-arnd@kernel.org>

On Tue, Jun 10, 2025 at 11:28:42AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function has an array of eight mlx5_async_cmd structures, which
> often fits on the stack, but depending on the configuration can
> end up blowing the stack frame warning limit:
> 
> drivers/infiniband/hw/mlx5/devx.c:2670:6: error: stack frame size (1392) exceeds limit (1280) in 'mlx5_ib_ufile_hw_cleanup' [-Werror,-Wframe-larger-than]
> 
> Change this to a dynamic allocation instead. While a kmalloc()
> can theoretically fail, a GFP_KERNEL allocation under a page will
> block until memory has been freed up, so in the worst case, this
> only adds extra time in an already constrained environment.
> 
> Fixes: 7c891a4dbcc1 ("RDMA/mlx5: Add implementation for ufile_hw_cleanup device operation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

<...>

> +	async_cmd = kcalloc(MAX_ASYNC_CMDS, sizeof(*async_cmd), GFP_KERNEL);
> +	if (WARN_ON(!async_cmd))
> +		return;

Patrisious,

I took this patch for now (without WARN_ON) as it fixes Arnd's issue.
We can provide followup patch if kcalloc() implementation hurts us.

Thanks

