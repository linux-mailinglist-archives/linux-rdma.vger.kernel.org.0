Return-Path: <linux-rdma+bounces-7410-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C002A27E65
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 23:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55FB165921
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289F321B19F;
	Tue,  4 Feb 2025 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2niGG78"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56612163BA;
	Tue,  4 Feb 2025 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738708974; cv=none; b=OJVanNJhtuFSPfTQp2Us6uBik0+hQoZ0bEyjqTgnlkpYV+o7mZcUclyO5Y+GxN4FQiaT5FtiEgxooXw1am/Ik5/H6pEi99CcIJw/kKu9kNH+rGYCOcXkbA+V3mhFOX1gM+3KtXfl2zdxIbpaewrlEIvAbLek9IZ5owP8sM54iF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738708974; c=relaxed/simple;
	bh=liEe80ffb9ZrBUU5Ov2QO73gaE3D6j0BGKeOUYBC1Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+lqWwWV4O5llvhdoGPWDkdkJyHPBEUKv3AjGBTeijznq/p1WTd7cj4DyEQrJ1P4ioOGihwVqUSlHpJmrU+5kGCjN4b/+Ef9NVpfW2NwXUnlfy8fjiEFetJYpwUQrAt5vo9/HhQfEoDz76uGhcZH9dVNJ9Mlk7JBF9M3M7tfEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2niGG78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162F7C4CEDF;
	Tue,  4 Feb 2025 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738708974;
	bh=liEe80ffb9ZrBUU5Ov2QO73gaE3D6j0BGKeOUYBC1Gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z2niGG78tMLGF1ljCnx17WjqgZXPkkqBgARtqnApS4XocvWW76zwtjlHCuOlxELHT
	 mlYOq7++Hgq7n47U0krMm3bY9o4XVedjuiWitTz90/EZftl03XicaJeioMQPkdQLEj
	 IeEzpFM5+QRNVXyQOEX3/Z+5KHhzRaWBh7ebwDIBFtx23H8Tn2e0zK4LuCjB1JFRXi
	 MyoPztLnvOLmfFCQGp8r0/Sle+Y5io4kVWGTR+fn63jyPY72Alo3PvhtqdAwJ/+s0i
	 zjfEj2zXZo2nIRYkscEtglU/wSv8fCNIGM6Cv6Ff2UmMtmftVPaP2/A6+FatsEo0/q
	 /4iHSrS20jMgQ==
Date: Tue, 4 Feb 2025 14:42:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 michal.swiatkowski@linux.intel.com, sridhar.samudrala@intel.com,
 jacob.e.keller@intel.com, pio.raczynski@gmail.com,
 konrad.knitter@intel.com, marcin.szycik@intel.com,
 nex.sw.ncis.nat.hpm.dev@intel.com, przemyslaw.kitszel@intel.com,
 jiri@resnulli.us, horms@kernel.org, David.Laight@ACULAB.COM,
 pmenzel@molgen.mpg.de, mschmidt@redhat.com, tatyana.e.nikolova@intel.com,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 0/9][pull request] ice: managing MSI-X in
 driver
Message-ID: <20250204144252.686a466e@kernel.org>
In-Reply-To: <20250203210940.328608-1-anthony.l.nguyen@intel.com>
References: <20250203210940.328608-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Feb 2025 13:09:29 -0800 Tony Nguyen wrote:
> Now changing queues using ethtool is also changing MSI-X. If there is
> enough MSI-X it is always one to one. When there is not enough there
> will be more queues than MSI-X. There is a lack of ability to set how
> many queues should be used per MSI-X. Maybe we should introduce another
> ethtool param for it? Sth like queues_per_vector?

It's probably okay for today. AFAIU ethtool channels basically
correspond to IRQs. As the queue API matures we'll have
the ability to allocate more queues for "channel" == IRQ / event
queue.

> The following are changes since commit c2933b2befe25309f4c5cfbea0ca80909735fd76:
>   Merge tag 'net-6.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Tony, the patches in your tree are missing your SoB, and I suspect 
you may need the same PR to get pulled into RDMA, so I'm not applying
from the list... Please respin.
-- 
pw-bot: cr

