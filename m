Return-Path: <linux-rdma+bounces-12312-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B38B0AC8D
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Jul 2025 01:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F401C26F4F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 23:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DA722B595;
	Fri, 18 Jul 2025 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzsxy/Bg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC6D2206B1;
	Fri, 18 Jul 2025 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752881387; cv=none; b=S02U8DHQqpen2QSmqXftYdTcwfbbGnO6et8eFSc+yoF6c2eTeo2tW8Cu24NhaZlq4CxdP3BZJRScS6l22935GkZPAf2XfJj5BfEJNvOJOZaQ4oFzD8wN4zdaTm8H1R3fZZvIZ8xW+mSURHAv4n7fIbVxRcU1l4pGIXqKe1upCLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752881387; c=relaxed/simple;
	bh=g61IKfodzjokruztSESID1IfnyBW+0gIC9iZUUN0Dog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvURFgaDI7AEU4wu3KkhC21CO5XnmZjkvqmf25zQvHB7Adep84i0U7mLXmpUzod0pHD96mtOzjtbRmdrjQV40Q5OPglBtAHen4/B5s6EWmQjXXu6A1hzwMBNfqQrGR4NRn8fgvxDrGTjiDDl15r8N7ZpkxDkIWdR3ZTGrN/WBwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzsxy/Bg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AB7C4CEEB;
	Fri, 18 Jul 2025 23:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752881387;
	bh=g61IKfodzjokruztSESID1IfnyBW+0gIC9iZUUN0Dog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gzsxy/BgJp5e/wdTTAHufgZBb3yLY+dEBFJvRfWg7fvfzsYG+M0JEJs1FALh8IZei
	 J/NyykbnrRG65lLcrVZ5Lyt6qDadA0KNPHNHelBw29FP6gd85mmjFhWTQG282rKY+1
	 6o2PajKywwNoLbIrIyCBfGI0F5mgXeA05/mf+WRudSofxuYrjdmChkoxCCZjXoDuux
	 HAGzpCuQWE6FKLxQvqM8XUD3m9Xn6ItxtamiiKF+8X8isURUbB1fwAwc/szjP+mwf9
	 3O/s1bDx3KXDEpUS2OSMMITqh8QR+e5MbWV9X9rDYMDsYCU5FTl9ZbFzSfhx0tAobx
	 kfX4B8HjP1n5Q==
Date: Fri, 18 Jul 2025 16:29:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>, "Richard Cochran"
 <richardcochran@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next 0/3] Support exposing raw cycle counters in PTP
 and mlx5
Message-ID: <20250718162945.0c170473@kernel.org>
In-Reply-To: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 08:15:30 +0300 Tariq Toukan wrote:
> This patch series introduces support for exposing the raw free-running
> cycle counter of PTP hardware clocks. Some telemetry and low-level
> logging use cycle counter timestamps rather than nanoseconds.
> Currently, there is no generic interface to correlate these raw values
> with system time.
> 
> To address this, the series introduces two new ioctl commands that
> allow userspace to query the device's raw cycle counter together with
> host time:
> 
>  - PTP_SYS_OFFSET_PRECISE_CYCLES
> 
>  - PTP_SYS_OFFSET_EXTENDED_CYCLES
> 
> These commands work like their existing counterparts but return the
> device timestamp in cycle units instead of real-time nanoseconds.
> 
> This can also be useful in the XDP fast path: if a driver inserts the
> raw cycle value into metadata instead of a real-time timestamp, it can
> avoid the overhead of converting cycles to time in the kernel. Then
> userspace can resolve the cycle-to-time mapping using this ioctl when
> needed.
> 
> Adds the new PTP ioctls and integrates support in ptp_ioctl():
> - ptp: Add ioctl commands to expose raw cycle counter values
> 
> Support for exposing raw cycles in mlx5:
> - net/mlx5: Extract MTCTR register read logic into helper function
> - net/mlx5: Support getcyclesx and getcrosscycles

It'd be great to an Ack from Thomas or Richard on this (or failing that
at least other vendors?) Seems like we have a number of parallel
efforts to extend the PTP uAPI, I'm not sure how they all square
against each other, TBH.

Full thread for folks I CCed in:
https://lore.kernel.org/all/1752556533-39218-1-git-send-email-tariqt@nvidia.com/

