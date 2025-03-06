Return-Path: <linux-rdma+bounces-8428-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DCAA54BDC
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 14:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F592174E3D
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 13:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73243212FAA;
	Thu,  6 Mar 2025 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cs1bm37P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AHoNv05/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765CE211A14;
	Thu,  6 Mar 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266986; cv=none; b=JtstYELaWze/ECDVLJPtPuKuHzq2OQPbbfZms/y7cEAwrJs3W9SP19e2XGbyxgSWyngVh9OvXKuSogYcSFpEjlUCJqvu4rG9Fgicioox+3CNR+j7wj8JRSaa7uQW+P6ydW0+QaporI0Co7zdVh8VxDoqC0xsO0fgbrFK032j3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266986; c=relaxed/simple;
	bh=cjdfNIp25fnNmbsaWwbjSisi5TEcnV+fllrx2J8xHh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irZOicfq01xMdf2DMcnqrlHPRMy35aBgrk6PHubwUgepky2Adu1fksvwK3sLQYRYsNP6SfiMOLxTVBOrp1eCDUSXEMVoLiTjpH5+CcWwuR2w03wd4jM3vGsvwlWDjJi2K50orrVSgMYKSqcTAMTZmtFmX2kzN5fkkA+AF6Ez2Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cs1bm37P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AHoNv05/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Mar 2025 14:16:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741266982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCX/Mg+p1+rYS3wGtMpI0H2PIPYPLjGUvCzoulyosOQ=;
	b=cs1bm37PqFMun5TFC2G3C5nC5zaib9Du/2kfLG/+t3XywICa4kchAcZ67dC2R0dwzc9hq0
	wQTEo1EHoai7+t30G68x2QLDI06UDLGKD+Hm5cYsvsuziWdfOiOwkfntwu+NCysNwzqTXI
	jYmQA19ZCVbbjgdtlC/6F4Shgo/fO0p+KK0AptNBumv1oS5mB28SWr15sfSsnFQ+tbZAmU
	sD8xQifOIcfEyt6JqVyQrI1pKrL1ab3r3jKdGnG//BxoSlywDfFDntHbcqTTqjWYWhJoUS
	pKBd+1ybxJWq+awBI8irV7aRFcTA7ec4RshV1v8+hD0m2Or0Kl/BX2ZdJepTgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741266982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCX/Mg+p1+rYS3wGtMpI0H2PIPYPLjGUvCzoulyosOQ=;
	b=AHoNv05/3WRXAkxt/d8bpx7cKEHDLrk2gM689B8Ge74bIvBHUgtdGPt2hFIrJ4NUHi+1vM
	NpeuQUKywMZp/KDA==
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
Message-ID: <20250306131620.LvXx2kNB@linutronix.de>
References: <20250305121420.kFO617zQ@linutronix.de>
 <8168a8ee-ad2f-46c5-b48e-488a23243b3d@gmail.com>
 <20250305202055.MHFrfQRO@linutronix.de>
 <20250306083258.0pqISYSF@linutronix.de>
 <042d8459-e5be-4935-a688-9fe18b16afa1@gmail.com>
 <20250306095639.HpT1e8jH@linutronix.de>
 <59987f5c-daa1-4063-9781-ac50f7eabb6c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <59987f5c-daa1-4063-9781-ac50f7eabb6c@gmail.com>

On 2025-03-06 13:10:12 [+0200], Tariq Toukan wrote:
>=20
>=20
> On 06/03/2025 11:56, Sebastian Andrzej Siewior wrote:
> > On 2025-03-06 11:50:27 [+0200], Tariq Toukan wrote:
> > > On 06/03/2025 10:32, Sebastian Andrzej Siewior wrote:
> > > > Could I keep it as-is for now with the removal of the counter from =
the
> > > > RQ since we don't have the per-queue/ ring API for it now?
> > >=20
> > > I'm fine with transition to generic APIs, as long as we get no regres=
sion.
> > > We must keep the per-ring counters exposed.
> >=20
> > I don't see a regression.
> > Could you please show me how per-ring counters for page_pool_stats are
> > exposed at the moment? Maybe I am missing something important.
> >=20
>=20
> What do you see in your ethtool -S?

Now, after comparing it again I noticed that there is
|  rx_pp_alloc_fast: 27783
|  rx0_pp_alloc_fast: 441
|  rx1_pp_alloc_fast: 441

which I didn't noticed earlier. I didn't rx0,1,=E2=80=A6 for pp_alloc_fast.
Thanks.

Sebastian

