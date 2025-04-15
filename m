Return-Path: <linux-rdma+bounces-9438-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD416A89457
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 08:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB1718869FA
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 07:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42126275848;
	Tue, 15 Apr 2025 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vuYrOTc8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NvPKiU/N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D22DFA34;
	Tue, 15 Apr 2025 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744700388; cv=none; b=GJZkaJhFPtAPswMm5C39TpDforvNYWGnAkGFdnlxOM+3t3nrmLbDqgIRgtBO68CJl0alzEwHOZFNXMloinyC/eG79C4gYcf7RYB/WzhiA7uFXitrtRhZQWLbnyh/J36kSNtgpuD/C4/iY9sIet23Vh9A7B8hW72LpTMBaHYQoBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744700388; c=relaxed/simple;
	bh=IexuHdflXNWNzZq5Hnzg9R61RzOTLbWrRYR7y7HFMfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyaMkoUrAEpBjwbpTBTBb+BmGb4R0734yK6DFuiCkIEa0gVq7Smv9oa1a6iof7eYUhqZA/RixURKmvNaYDu3GvL8tjSQps1WKxp0O2FwQzhA26/us8tNKQ/Bnz8GOj695MtqMR8RhfjdvcPMbL1hDUwXPj99cWTHmQ6XVQ61NeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vuYrOTc8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NvPKiU/N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Apr 2025 08:59:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744700384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4DddnPVge9/03hGcVhj2b0OGOQ590RpyA8OzYtklTQ=;
	b=vuYrOTc8QKwZILdPxE6nlighse8j5czreAU0NRRwXH1YPWLjdY3d2rgnmIBklwUTnZbJ4i
	mW3R7pbaGwblKuKhbYK+OyBN9orQD41H6M9HZkoPc4O2ZMShfJnMzwW56/2sxT762VPUye
	aoqHwtWY4NDMT4NWwcxAQZfSIloQ9K2b2iIiWhS2I1RGuC5Lz+VELCRHaU/4HJqS1JI5MQ
	yu/N9j8P9SKznAzYMKnOQeS03+PcDgn9hh7n5XkvDCVBT6vagGsuYB6cWn4m+MemWbcuQW
	AJiGvabKv5fvy2QuNIpq1ErGhlQhvivTDiAW0SW6YixSCrVD6XPUsVBEftmjyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744700384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4DddnPVge9/03hGcVhj2b0OGOQ590RpyA8OzYtklTQ=;
	b=NvPKiU/NFg6b2GvIsSSHtwZXG+jiIVYcV6xItmZvYPFCDeSuQXxyHYGrI0ugX2vU2lvaot
	V1nhHULnntqIsxDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Brian Norris <briannorris@chromium.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, 
	Loic Poulain <loic.poulain@linaro.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org, ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
	wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] net: Don't use %pK through printk
Message-ID: <20250415084250-8f385935-6e23-447d-8e94-3170d0d3ec9f@linutronix.de>
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
 <Z_1XiNY2ujreEo69@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_1XiNY2ujreEo69@google.com>

On Mon, Apr 14, 2025 at 11:44:24AM -0700, Brian Norris wrote:
> On Mon, Apr 14, 2025 at 10:26:01AM +0200, Thomas Weißschuh wrote:
> > Furthermore, restricted pointers ("%pK") were never meant to be used
> > through printk().
> 
> Is this really true? Documentation/admin-guide/sysctl/kernel.rst still
> has a section on kptr_restrict which talks about dmesg, CAP_SYSLOG, and
> %pK, which sounds like it's intended. But I'm not highly familiar with
> this space, so maybe I'm misreading something.

The wording about dmesg, etc was added in
commit 312b4e226951 ("vsprintf: check real user/group id for %pK").

Its commit message also notes:

    This is a only temporary solution to the issue.  The correct solution is
    to do the permission check at open() time on files, and to replace %pK
    with a function which checks the open() time permission.  %pK uses in
    printk should be removed since no sane permission check can be done, and
    instead protected by using dmesg_restrict.

Doing this is my goal. One of the later steps is to replace %pK completely.
Probably with a function similar to kallsyms_show_value().

> (I do see that commit a48849e2358e ("printk: clarify the documentation
> for plain pointer printing") updated
> Documentation/core-api/printk-formats.rst.)
> 
> In any case, even if the advice has changed, it seems (again, to an
> outsider) a bit much to say it was "never" meant to be used through
> printk().

IMO "never" is correct. Using %pK through printk() was only ever a bandaid to
get at least some of the security benefits of hashed pointers.


Thomas

