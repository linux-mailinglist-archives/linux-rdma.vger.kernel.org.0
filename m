Return-Path: <linux-rdma+bounces-13257-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EFEB524DE
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 02:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D9A561433
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 00:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D87270568;
	Thu, 11 Sep 2025 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/2gFd2S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3532248F64;
	Thu, 11 Sep 2025 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757548813; cv=none; b=GFQCpMmGfnwevd+dU1WKYqWcKa5Jw0fGs4GuTOOWp2K/sJ+zU2ztmoIw8LEKNAqhReUFgOW7EGZmmrFqTY1s2CLIxLoBP2jzgILVj1oJK4hVWj85QDz6l7hkD4swxn8eSBqSiOcsN7QiLO1HQPd8lMxdhjkkdkUnL0QH9xgJow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757548813; c=relaxed/simple;
	bh=R9vVY/11IKFzvQqXjwdt5i/XgL4e97P/ezQtVoljpMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYN/ptVo1RFcbpa1pn5tLKmNIzGrx9MrOIgfvYTb0d67pU2O/0fi3fOHtaRXnp7KGvVmikV2cMxkNcWjrCZluClVU0R1Omu/UhMhp/qgdxsJxteCUx6pPqANS9rfSfmrufZEs35eNgkORVzBqgr9w/8EoYU9iBH+/HENjjtz1ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/2gFd2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB84DC4CEEB;
	Thu, 11 Sep 2025 00:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757548813;
	bh=R9vVY/11IKFzvQqXjwdt5i/XgL4e97P/ezQtVoljpMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U/2gFd2SX47cMVveAmIQtU2/bMa/TVM2DJGHQ90XXetOjHKbkYv5NvZrPUS0J6jfK
	 2A6/BaidoFx2yQ0BGQQLJwVVMbvCpIfXrtIUZGmOQTal8FZS66HULpkw+ZmdjUHoc9
	 bS+LFcKUSpxiAlAGFzQePPiOBdm+JKGgDXko0TInz6j8IYF2W/eyIa4HYvS1KS/4o/
	 FtWX/1NORzTIgS2ItV1kkOC0cb5+xVKxSiEjvo2EcASJs7aGkWJ8xkqw8U9pt4SwAa
	 l93uEO3JMcML2GYq8whu0p4WCe+Z6auJcSQ4sbi98WAHI+A2hL50/h5GZnrm9m/hzF
	 Sxc9VXy+ib1jA==
Date: Wed, 10 Sep 2025 17:00:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, "Saeed Mahameed" <saeedm@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Alexei Lazar
 <alazar@nvidia.com>
Subject: Re: [PATCH net V2 10/11] net/mlx5e: Update and set Xon/Xoff upon
 port speed set
Message-ID: <20250910170011.70528106@kernel.org>
In-Reply-To: <20250825143435.598584-11-mbloch@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
	<20250825143435.598584-11-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 17:34:33 +0300 Mark Bloch wrote:
> Xon/Xoff sizes are derived from calculations that include
> the port speed.
> These settings need to be updated and applied whenever the
> port speed is changed.
> The port speed is typically set after the physical link goes down
> and is negotiated as part of the link-up process between the two
> connected interfaces.
> Xon/Xoff parameters being updated at the point where the new
> negotiated speed is established.

Hi, this is breaking dual host CX7 w/ 28.45.1300 (but I think most
older FW versions, too). Looks like the host is not receiving any
mcast (ping within a subnet doesn't work because the host receives
no ndisc), and most traffic slows down to a trickle.
Lost of rx_prio0_buf_discard increments.

Please TAL ASAP, this change went to LTS last week.

