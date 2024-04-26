Return-Path: <linux-rdma+bounces-2122-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753688B42DA
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Apr 2024 01:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17EC283E7D
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 23:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E203BBF8;
	Fri, 26 Apr 2024 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jqsc11mz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E083BBC5;
	Fri, 26 Apr 2024 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175535; cv=none; b=KjPpGYEQ9ggHPmYY09XI4FIpHX+1IuLHRPzbseQaS7jE2BtGIOD4tT1eBdcVvC/AmK3Gac1psyZGdVHD03001CbQFsbl0OE21hTX5l2DUhwJerP9fgc6d9p13sZvq89ZCmotGPXUFSX9zZ1gLNXSRvZm5iUw83VcIAfZDnl0BOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175535; c=relaxed/simple;
	bh=H/sLcQKdw9O29se32jTxTWE1RQxSOatw8x3g3EsaaCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yr8o2YUtiHQVjkz3haBakhphkAL3pRk9w9UtlInajDIXURF79WEBGLLA0ueikLFTM16n8VSyxG6KV9Xp52G0+eemgRKUqqhvPcibETzEHbyA+UN0uFvzySpPHrKlv04FLEMQaw7xG8xfHQlPt1Pm5ONQYUmYvgFZyqXClG4yNcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jqsc11mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618CFC113CD;
	Fri, 26 Apr 2024 23:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714175534;
	bh=H/sLcQKdw9O29se32jTxTWE1RQxSOatw8x3g3EsaaCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jqsc11mzcF+Ti0Cr1i/rzdC1wnB5utX0rXr6TsRCf2xyh2CeSl4WJPE4zLPqgyOtl
	 RaevFikEgloO38h8pMH41z4Vy9IMVVDswj59pNLvhdXF/FSQajKyYqSPwqn0wUMvPM
	 GmOBD/s2/UHsy5bpIVd7XMTF7iMSO0WPZOe/lJSsUKvPWsmip37yJNE7A5FhVACkei
	 KJtxUo/4qoR+h+eb8nC+aw1CUU1qYTHX/6yJjKVvBTBkS2SN7xFJBUHl3jikTUUZ5z
	 9o3SZAOxOWCWfK3X+OfBxi4h/KbLE9+ZEeiBn8lUjQSrqCxUnfZrU3rNzNWcAzMyX9
	 m8kkVk9oXFk0A==
Date: Fri, 26 Apr 2024 16:52:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
 saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "open list:MELLANOX
 MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] net/mlx4: Track RX allocation failures
 in a stat
Message-ID: <20240426165213.298d8409@kernel.org>
In-Reply-To: <Ziw8OSchaOaph1i8@LQ3V64L9R2>
References: <20240426183355.500364-1-jdamato@fastly.com>
	<20240426183355.500364-2-jdamato@fastly.com>
	<20240426130017.6e38cd65@kernel.org>
	<Ziw8OSchaOaph1i8@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 16:43:53 -0700 Joe Damato wrote:
> > In case of mlx4 looks like the buffer refill is "async", the driver
> > tries to refill the buffers to max, but if it fails the next NAPI poll
> > will try again. Allocation failures are not directly tied to packet
> > drops. In case of bnxt if "replacement" buffer can't be allocated -
> > packet is dropped and old buffer gets returned to the ring (although 
> > if I'm 100% honest bnxt may be off by a couple, too, as the OOM stat
> > gets incremented on ifup pre-fill failures).  
> 
> Yes, I see that now. I'll drop this patch entirely from v3 and just leave
> the other two and remove alloc_fail from the queue stats patch.

Up to you, but I'd keep alloc_fail itself.
If mlx4 gets page pool support one day it will be useful to run this:
https://lore.kernel.org/all/20240426232400.624864-1-kuba@kernel.org/

And I think it's useful to be able to check in case there are Rx
discards whether the system was also under transient memory pressure 
or not.

