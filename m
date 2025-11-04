Return-Path: <linux-rdma+bounces-14248-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAA8C32C35
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 20:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A13426BE6
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 19:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45442DC321;
	Tue,  4 Nov 2025 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+/TZv1X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757742DA74D;
	Tue,  4 Nov 2025 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284138; cv=none; b=OiD0w+lOqDPz3+Nr9KdiNQ9JBmo5nDHPsq1kB98/wVBhTkJS6inKvrm+p5+kG4dQg8pyyMSGCf8tl9UxcSKwA8m2QWEgqNpUThlmvNoNINJAo8+/pLHvYcmEwt2tFGLK+H0/AaRsj4roUqwc/2iFL+gvTGwp2lLb3YLzm7Di8XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284138; c=relaxed/simple;
	bh=+lf7dW++l2EW9+9yEsAcle5UBElW4w+UfVpXaHOHW2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiXUsgGjyXkPOmTLbUdAwSAhSJw+J8rDINuC46XCevETeFXg8hNauXVgEqYixPs/vraNT9hBxELvcYLV8PGkjuG2uubnb9FcbNgdtGypSqrPLNWFsaDElJjUYYoC1XBXLGmHUwzBru2CPfBaOGlJLFta5QUL/TZb2N1ccyM6qgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+/TZv1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A88DC16AAE;
	Tue,  4 Nov 2025 19:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762284138;
	bh=+lf7dW++l2EW9+9yEsAcle5UBElW4w+UfVpXaHOHW2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B+/TZv1XRq0zzd5NbGu3Z9bN5OyQZnNOsope6laxMrWxA3/9XRg7VX+3PhsjNe7lW
	 5cbgxn6SqwRaVkJbyodTHSn0LdeO5DaMLbCFV/YkdMgryijwrq6LyocnrsiVuNyhLv
	 xHsrmZselWKpvNIRQMjhLTdiIa0VnfoixY52BS0uFlEVig1wBgEFGzD/T3bGyB56e6
	 1l8b7lD0a36nrmABwnEvq70bPZRM5IzkSVy7iTQN+TPjab7k/GpzkYFUllJxth410q
	 4+JiRU+f29KNZ9lJy0ZuU0cQlh4AQfIsQMj0TIhuqexc7SbGFrZJBc5IimM07mEMvE
	 R1RZeW1bSnP0w==
Date: Tue, 4 Nov 2025 11:22:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Srujana Challa <schalla@marvell.com>, Bharat Bhushan
 <bbhushan2@marvell.com>, Herbert Xu <herbert@gondor.apana.org.au>, Brett
 Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham
 <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
 <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Tariq Toukan
 <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel
 <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Manish Chopra
 <manishc@marvell.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Loic Poulain
 <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean
 <olteanv@gmail.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Dave Ertman <david.m.ertman@intel.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net/mlx5: implement swp_l4_csum_mode
 via devlink params
Message-ID: <20251104112214.7f60b252@kernel.org>
In-Reply-To: <mhm4hkz52gmqok56iuiukdcz2kaowvppbqrfi3zxuq67p3otit@5fhpgu2axab2>
References: <20251103194554.3203178-1-daniel.zahka@gmail.com>
	<20251103194554.3203178-3-daniel.zahka@gmail.com>
	<mhm4hkz52gmqok56iuiukdcz2kaowvppbqrfi3zxuq67p3otit@5fhpgu2axab2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Nov 2025 11:14:03 +0100 Jiri Pirko wrote:
> >@@ -548,6 +703,12 @@ static const struct devlink_param mlx5_nv_param_devlink_params[] = {
> > 			     mlx5_nv_param_devlink_cqe_compress_get,
> > 			     mlx5_nv_param_devlink_cqe_compress_set,
> > 			     mlx5_nv_param_devlink_cqe_compress_validate),
> >+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_SWP_L4_CSUM_MODE,
> >+			     "swp_l4_csum_mode", DEVLINK_PARAM_TYPE_STRING,  
> 
> I still think that even unlikely this will be implemented in other
> driver, it is generic param. Could you please treat it as such?

We need a clearer definition of what this does then.

Is it basically disabling silicon validation of L4 checksum and allows
for the FW to compute the L4 checksum? Which may negatively impact
performance? (hence disabled by default?)

