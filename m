Return-Path: <linux-rdma+bounces-8411-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76012A546F5
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 10:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64657A7C5D
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31DC20A5F0;
	Thu,  6 Mar 2025 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMuS5bSZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TH88ptt3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F92080D4;
	Thu,  6 Mar 2025 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255005; cv=none; b=oWzoo1ssAluGfdkxQgNy9ohfOmwRAEZyW8Bv1jshw84QQdYMI6O9+Tjuex+CNQE9CA+Vf4mW4Bj8fjcZ1xvXx4VdEIVmSB42VXJaoPFgJJsHfFBk4n/Z0MeUWDH0/D66QSzM2ruaAdL/WRkSmCy7za/tlRTCvz/ZPwLRKMYSpio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255005; c=relaxed/simple;
	bh=zBqKLeLcKRYNMfeqT2BCbDBp9u+d5ynueRcK+eTycdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeTvnEtLNVKHw2eAiezajVQU19rwENy9+Jh9y7ABZgXzb69yI35MpU0km9Or0YefaJNpEl7LzSNBSz5MAp7zKeK1VlQYsVSphlCj6pUQUsMmyY6D21a7YRDcLg354A2L79ZIEmX6J8w5IJwHnZamcFN+ETjt5u93eBOgQJJjwec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMuS5bSZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TH88ptt3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Mar 2025 10:56:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741255001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b0hBTOKk34vwmWSLU8KV6qhcfbvYPUsAocrMEWuIr0s=;
	b=DMuS5bSZgTBx+JCWBVj/s9j/dleIr+1rJAiFtbNBenDPkNc7UTd71WSft0POQ96oLe/Cwu
	qlV2uKD7Yq7VRBB59ay8v19yBFX5Hsbrkac804Hewz0OZSlAennDmLfyRXClEHMVi/C+nH
	xOa0b4v6xW/HG0xXhSOg0GIoZA44Pd0lxYIk2fP2d9j/oCd63tP86+WM/i4huvptLL7K43
	OATQpOoIv94OQYPhmSgeNDm2s/2L/TlXZoQXBk1TJs48ajlkAKOid3X6p9oXw/qVNuH6Ef
	FAQD8U1A5ofKQ/avQ3vLFvCbJ+3coBB/8nQavYf8ztk6IT72tUwOxu5ngZ+lmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741255001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b0hBTOKk34vwmWSLU8KV6qhcfbvYPUsAocrMEWuIr0s=;
	b=TH88ptt31qssT1yc02e+CpNdG48MsE8zU2taGb9wo7RyEjXbIyza3vD5bprMJABrxDWz3P
	jOJOf9ixiduVlACQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next] net/mlnx5: Use generic code for page_pool
 statistics.
Message-ID: <20250306095639.HpT1e8jH@linutronix.de>
References: <20250305121420.kFO617zQ@linutronix.de>
 <8168a8ee-ad2f-46c5-b48e-488a23243b3d@gmail.com>
 <20250305202055.MHFrfQRO@linutronix.de>
 <20250306083258.0pqISYSF@linutronix.de>
 <042d8459-e5be-4935-a688-9fe18b16afa1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <042d8459-e5be-4935-a688-9fe18b16afa1@gmail.com>

On 2025-03-06 11:50:27 [+0200], Tariq Toukan wrote:
> On 06/03/2025 10:32, Sebastian Andrzej Siewior wrote:
> > Could I keep it as-is for now with the removal of the counter from the
> > RQ since we don't have the per-queue/ ring API for it now?
> 
> I'm fine with transition to generic APIs, as long as we get no regression.
> We must keep the per-ring counters exposed.

I don't see a regression.
Could you please show me how per-ring counters for page_pool_stats are
exposed at the moment? Maybe I am missing something important.

Sebastian


