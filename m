Return-Path: <linux-rdma+bounces-12378-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE24B0CE9A
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 02:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3509188CAE5
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 00:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C47EC5;
	Tue, 22 Jul 2025 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNLmcEic"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B4FA2D;
	Tue, 22 Jul 2025 00:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142960; cv=none; b=g9PFdeBN+xzrOCq98vHEaeohQd9kLA86mRdTomrvp266SaYxxMOkwn1I/AVFhW/5FVpwotdWbP/Rq7GuLZ+cXc8dzwoDP8G18p4EEqyD8udQbyI5LSl7HdMCSITsofRcYQ514z9eDhffZAN4gszNudfOdQmdXFr7vnY6HznRQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142960; c=relaxed/simple;
	bh=lbtlLZkbEB/EKwqUWL21/TxtNsN+Km6zXftxmbHKI90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PR2eTgNJhWik1dmx0N6VoOwJ1WzPHajPjJTjmQcHuMsL80DgpeDIQWbNcPp1eu8GbRkpCfO5Zt9HqjLhnNvBJwLZmW4Hl4oGYzE+styCIo8CFSN8kWRNVoJb2OaOoobccur9VseQx738wXpHlaeakAtCC/xdpTOMjP4XoxgJyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNLmcEic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6346C4CEED;
	Tue, 22 Jul 2025 00:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753142957;
	bh=lbtlLZkbEB/EKwqUWL21/TxtNsN+Km6zXftxmbHKI90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XNLmcEicLOwOBti6m2OnAc7zta+ylIXlNd8VxOf1R3PYYahhH3ojAckLK+SssIHEy
	 NpUlh+PhubS6v8uqeGtHZxOFQKMZsI+dQzfAh1vBwUylt+mIAdNy1jxCRsiSLkYSDz
	 4UNGJfRgB9FqwItCRIX37w/nqea3rtrfczpy1z0ECkrGJ/88gIWzwXLiXl7xC/EN+s
	 kzWtmKUkE1GkR+2SaxqqDrzba8mhODTzvQehRSBZq4YZSLnAHTqZB5NcigwpJnTnGH
	 OsUVbsbvo6LMeyydoWmFWpX4noF1uU59r/NUNJlxL8A+Wpv2YK9Pg6JsQsGPrl2hZh
	 a+YCA9ZLYSgOA==
Date: Mon, 21 Jul 2025 17:09:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, "Richard Cochran"
 <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina
 Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 0/3] Support exposing raw cycle counters in PTP
 and mlx5
Message-ID: <20250721170916.490ce57e@kernel.org>
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
> cycle counter of PTP hardware clocks. 

Could you say more about use cases? I realized when massaging the cover
letter to apply the series that all the use cases are vague and
hypothetical.

> Some telemetry and low-level logging use cycle counter timestamps
> rather than nanoseconds.

What is that "some telemetry"?

> Currently, there is no generic interface to
> correlate these raw values with system time.
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

There is no API to achieve that today, right? The XDP access helpers
are supposed to return converted time. Are you planning to add new
callbacks?

If there are solid networking use cases for this I'd prefer we fully
iron them out before merging this uAPI. If there are RDMA use cases
please spell them out in more detail.
-- 
pw-bot: cr

