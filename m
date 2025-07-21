Return-Path: <linux-rdma+bounces-12371-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955D7B0C948
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 19:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C1E16F177
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 17:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC962E11A8;
	Mon, 21 Jul 2025 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hnm5NpTk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8Fva8l85"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A821F8690;
	Mon, 21 Jul 2025 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118069; cv=none; b=trTBhavw7/aAIiLthoKZcxd/qiqh+4EIw0Fnsd5bqWhIRqRM0ujTMx0EYIIB5SMG/0MB2QvrU5X1qvONCjKLErIiwRRg0ho5EnfdHY0yjlwLIE83EERDSTt6xPIJmFE6mgzDJp6SuxU3SYxz0+kxTx87gRFf6dj0U0QKDkcJvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118069; c=relaxed/simple;
	bh=zbFpru6Ppf/KfQvFt8+fF05yu0oX1LG57Uu1Rok2wQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VslXgbrsm0fBZQHQqpuKH1+N8zOSlM8CqS5HrBAdJLjp//j0b+xIIVFIacnZty/p690WPxBmAB7jlkGXhMynGu3EaiH/8wJXoWVVvVhJDvVF+a7GG8Tc2x7VW7HmYAnJhZlLyFVOiCBYRS0ZtTdclyOzQrc5G0AGB+eP5KVKMxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hnm5NpTk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8Fva8l85; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753118065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HtQaFsRn8UOT9lqlW5J2FlikhtRrn+UC61/UC7I4Lo=;
	b=hnm5NpTktw2V72uQVlmKYFxxHiwtPKdVY01EG88EmvDdJgCo2pqGhceO/uQAW8O7Ck0A5D
	xSviHp4v6sX6KUEhAlpprCblZGaExdDnN6D8YFqyvo2kD0STNV2dP4Jz11xhORUsKJ/Zv0
	30MvZEaHnSeNptP/BCP92huqE2c6ttWzfv9J+x6cKubLlk9HvNQxsNeelJySkwR3HCJ0nR
	Q9vS3hSPVUO3817dKhe7Aq4GjHmPliO1s/eQNneUKzNZKoyHBYxfmlF9pGUmA6j6Bxy3Rc
	R58zNB7ZgtbEDSNXe+fXhkBbmfIY8b1eVySN2Lc1UmZhGC1ave9D9irdkQaoKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753118065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HtQaFsRn8UOT9lqlW5J2FlikhtRrn+UC61/UC7I4Lo=;
	b=8Fva8l85EfRdoa9Mp8ZgJUsH6Mmde8RANxY4hMlY9K4+8kp/tYWo+8fXEPwXjGNJrF88Y6
	hxZ/KKx0iOslcNCA==
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Carolina Jubran
 <cjubran@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next 0/3] Support exposing raw cycle counters in PTP
 and mlx5
In-Reply-To: <20250718162945.0c170473@kernel.org>
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
 <20250718162945.0c170473@kernel.org>
Date: Mon, 21 Jul 2025 19:14:24 +0200
Message-ID: <87ldohtqj3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 18 2025 at 16:29, Jakub Kicinski wrote:
> On Tue, 15 Jul 2025 08:15:30 +0300 Tariq Toukan wrote:
>> This patch series introduces support for exposing the raw free-running
>> cycle counter of PTP hardware clocks. Some telemetry and low-level
>> logging use cycle counter timestamps rather than nanoseconds.
>> Currently, there is no generic interface to correlate these raw values
>> with system time.
>> 
>> To address this, the series introduces two new ioctl commands that
>> allow userspace to query the device's raw cycle counter together with
>> host time:
>> 
>>  - PTP_SYS_OFFSET_PRECISE_CYCLES
>> 
>>  - PTP_SYS_OFFSET_EXTENDED_CYCLES
>> 
>> These commands work like their existing counterparts but return the
>> device timestamp in cycle units instead of real-time nanoseconds.
>> 
>> This can also be useful in the XDP fast path: if a driver inserts the
>> raw cycle value into metadata instead of a real-time timestamp, it can
>> avoid the overhead of converting cycles to time in the kernel. Then
>> userspace can resolve the cycle-to-time mapping using this ioctl when
>> needed.
>> 
>> Adds the new PTP ioctls and integrates support in ptp_ioctl():
>> - ptp: Add ioctl commands to expose raw cycle counter values
>> 
>> Support for exposing raw cycles in mlx5:
>> - net/mlx5: Extract MTCTR register read logic into helper function
>> - net/mlx5: Support getcyclesx and getcrosscycles
>
> It'd be great to an Ack from Thomas or Richard on this (or failing that
> at least other vendors?) Seems like we have a number of parallel
> efforts to extend the PTP uAPI, I'm not sure how they all square
> against each other, TBH.

I don't see a conflict vs. the aux clock support. These are orthogonal
issues and from a conceptual point it makes sense to me to expose the
raw cycles for the purposes Tariq described.

Thanks,

        tglx

