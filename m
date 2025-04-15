Return-Path: <linux-rdma+bounces-9439-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BAEA896B2
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 10:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 981957ACC66
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 08:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C7F28FFD4;
	Tue, 15 Apr 2025 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="avoJCGzO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715EA284691;
	Tue, 15 Apr 2025 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705787; cv=none; b=rpE59I9JjzQvwv3zx2lwnyPRSgdgitN6LLqYX/YjtEe7R9hT35TSt107bwL+x1W1bFtXQtxCGdiVFENUFACp9Pzl75sFxwOJHEtOhjiDZm+OsTyRyDnP5SDmvI9QOidYzU3NGu60AVaKLolzoQ/kpsnaPwX7jAvlfKyxzkTcMfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705787; c=relaxed/simple;
	bh=iHJWbSB0ymhRZHV1VgYAg5TLOfdwWd395GC4IpAL4TA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkXCyQNRdwPAthF2URKHew6yhmMyRF26Vm/TimkiztxMMyhUDEn9rtwz1QU4hcny4g9nOI2cPLGszKbKDbLy1vX2TqS3TDmcyuyBoI7rK38zpjQdKSlhQrYu+OSXgWf1aXBbGPkSw8hQKP/5d2X5K12CRyTdQQyCcAV5hXxhWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=avoJCGzO; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1910F1FCE6;
	Tue, 15 Apr 2025 08:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744705782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHJWbSB0ymhRZHV1VgYAg5TLOfdwWd395GC4IpAL4TA=;
	b=avoJCGzOyI+/qeQWpTYUeIpFAimgxpl3v3j63LrJbyqibztcNuLa5wdrkXU7UG3C7DND4I
	U1/0jPMqPqlHPCpMQ0a0IXq376F4eRg0NQQyusk+eJKvrOJVWDKG+T6DQ5oCyvJ0a18u66
	nMTvMqicqSWk6+EwZN9vIDLqpn+GNF9bUqPpA99323paG1mXgLCaS+e/QIluqgHUB9B6ol
	R6cdP3JhJFPDyGX1FzAvLevIq4svrl6rBsiqN+nmLYJnRG89pYhAeFulyDxFytGzdVhxKX
	dONbEoR4IKeeIAQ1Mn5nJFlVQK3SJlAHUcTIsX39lhMAVO69xIDcI4YpSw4SJg==
Date: Tue, 15 Apr 2025 10:29:38 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Bryan
 Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?=
 <niklas.soderlund@ragnatech.se>, Richard Cochran
 <richardcochran@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Andrei Botila <andrei.botila@oss.nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: ptp: driver opt-in for supported
 PTP ioctl flags
Message-ID: <20250415102938.53665eda@kmaincent-XPS-13-7390>
In-Reply-To: <20250414-jk-supported-perout-flags-v2-0-f6b17d15475c@intel.com>
References: <20250414-jk-supported-perout-flags-v2-0-f6b17d15475c@intel.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeftddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmeelugejtgemudgrudgsmegvkehfugemuggruddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkeehkeejmeejuddttdemlegujegtmedurgdusgemvgekfhgumegurgduvddphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedtpdhrtghpthhtohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepohhlt
 hgvrghnvhesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhhthhhonhihrdhlrdhnghhuhigvnhesihhnthgvlhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 14 Apr 2025 14:26:29 -0700
Jacob Keller <jacob.e.keller@intel.com> wrote:

> Both the PTP_EXTTS_REQUEST(2) and PTP_PEROUT_REQUEST(2) ioctls take flags
> from userspace to modify their behavior. Drivers are supposed to check
> these flags, rejecting requests for flags they do not support.
>=20
> Many drivers today do not check these flags, despite many attempts to
> squash individual drivers as these mistakes are discovered. Additionally,
> any new flags added can require updating every driver if their validation
> checks are poorly implemented.
>=20
> It is clear that driver authors will not reliably check for unsupported
> flags. The root of the issue is that drivers must essentially opt out of
> every flag, rather than opt in to the ones they support.
>=20
> Instead, lets introduce .supported_perout_flags and .supported_extts_flags
> to the ptp_clock_info structure. This is a pattern taken from several
> ethtool ioctls which enabled validation to move out of the drivers and in=
to
> the shared ioctl handlers. This pattern has worked quite well and makes it
> much more difficult for drivers to accidentally accept flags they do not
> support.
>=20
> With this approach, drivers which do not set the supported fields will ha=
ve
> the core automatically reject any request which has flags. Drivers must o=
pt
> in to each flag they support by adding it to the list, with the sole
> exception being the PTP_ENABLE_FEATURE flag of the PTP_EXTTS_REQUEST ioctl
> since it is entirely handled by the ptp_chardev.c file.
>=20
> This change will ensure that all current and future drivers are safe for
> extension when we need to extend these ioctls.
>=20
> I opted to keep all the driver changes into one patch per ioctl type. The
> changes are relatively small and straight forward. Splitting it per-driver
> would make the series large, and also break flags between the introduction
> of the supported field and setting it in each driver.
>=20
> The non-Intel drivers are compile-tested only, and I would appreciate
> confirmation and testing from their respective maintainers. (It is also
> likely that I missed some of the driver authors especially for drivers
> which didn't make any checks at all and do not set either of the supported
> flags yet)
>=20
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

