Return-Path: <linux-rdma+bounces-12778-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C456B28655
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 21:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27899B62725
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 19:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69103296BDF;
	Fri, 15 Aug 2025 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSDhjSm+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFD722F75C;
	Fri, 15 Aug 2025 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285820; cv=none; b=tQApcCING/JF0fqKCZ3GUW6VBeCaq6i4FvUkuaV60j5ijfY+jaien3UMoSFKwcI9Tph0QNBydwAW37k2fLaR92cQmGQKv03vtGk1rWB7AdVtCMDnEe7YgPZj7sdrKDQytCuyoj2sHqQzHuv2vAAXQGBg26KiCv6ClquzElvWqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285820; c=relaxed/simple;
	bh=JtacZUTLhICvO5yuLBzEN+3vCLB7bp1fK7RdD5/lksY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2O8IOgJtxCjMfTdp9RM+kFD3NUfRPOpL6XDhg773ETCWJHbiL9buKPI7fynH7cRBafhOmBgxwDgJ8JbFzigGPbrrUONFkceKs39/GaJFNLCpT/84KLvlArvewDEB7+VKl0VE3qLjd7vH/n4We8R+WkR72meNYtwItbTe7bWuTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSDhjSm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A54C4CEEB;
	Fri, 15 Aug 2025 19:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755285819;
	bh=JtacZUTLhICvO5yuLBzEN+3vCLB7bp1fK7RdD5/lksY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aSDhjSm+hjhcyqFW5Zn3ElR2eNNM57vXdtPe4U9uZ9swYyEoVgIDsMcD9aic3XUuO
	 EEUqvo2T55OYe0w2a3QPWiZ05emD7U6s/w2WlRx/ipXbj7XDD1wTpCBmq3ldbLHv3z
	 ZtnCNvXdYX4QA2n2N69ma08fi+/WHPOX/UdM/bJhRFVNZfMycVQTQ9rm1g8ZEWTc/G
	 ZI8pYAFimYwzuFvi8MJi3SVYHQb8c1+2sad2ea3KkROM0AvExgNxTtaGNZZaYUctWH
	 7B4lSeBVmUW3pNt3hHO5SbAPqj8If/L5yPPhlgTjz7+A+9TiTviteU+Qnh1X5Clpup
	 +xXtsvKhm85hg==
Date: Fri, 15 Aug 2025 12:23:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Jiri Pirko <jiri@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Donald
 Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Brett
 Creeley <brett.creeley@amd.com>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, "Cai Huoqing"
 <cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham
 <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
 <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <linux-rdma@vger.kernel.org>, "Gal Pressman" <gal@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, "Shahar Shitrit" <shshitrit@nvidia.com>
Subject: Re: [PATCH net-next V3 3/5] devlink: Introduce error burst period
 for health reporter
Message-ID: <20250815122337.4aa50105@kernel.org>
In-Reply-To: <1755111349-416632-4-git-send-email-tariqt@nvidia.com>
References: <1755111349-416632-1-git-send-email-tariqt@nvidia.com>
	<1755111349-416632-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 21:55:47 +0300 Tariq Toukan wrote:
> + * @default_error_burst_period: default time (in msec) for
> + *				error recoveries before
> + *				starting the grace period

FWIW you don't have to indent the continuation lines this much,
one tab is enough to make it clear that it's a continuation.

> +static bool
> +devlink_health_reporter_burst_period_active(struct devlink_health_reporter *reporter)

Not sure what it means for a period to be active.

devlink_health_reporter_in_burst()

