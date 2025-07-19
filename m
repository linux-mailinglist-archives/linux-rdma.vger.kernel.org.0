Return-Path: <linux-rdma+bounces-12316-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C3B0AD18
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Jul 2025 02:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDAA5A3574
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Jul 2025 00:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A796813C3F2;
	Sat, 19 Jul 2025 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUkcr6sP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8407FD;
	Sat, 19 Jul 2025 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886299; cv=none; b=WugXFkUs7JH9F40FasdnWZG71GsfBEY1MP3ZvsjqCZqJvFWcsDthZX7JQh7dacRz/m3bU/BNLCGodUOVEpP+GEEL6CICFeriCbkWHvM6I8I2pbTNc2oPYr0gAszuRr5IQg//B2EHw2I7XBl98+9P+HTSvH9eKR4iCu8Rfwh/ABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886299; c=relaxed/simple;
	bh=9kJxhZth6grHo3I0CSXBwom48o2ExKgGl5rWqerKBiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVhCXXD64Cazvsv07+fy8dpZ9ffocWYoBO6+ML7zGRzojd/kqt4nsUuoboGXU80loWJKaLg1jdF4UTWEsnTxgWAzV9dNFXcUsIaWiQ308CSPD/ZsewwQfpQoW35CGSNX9Bwg0C9N4gP142EY6q0dL1Rvm/xoXS68s7M/4Wgkm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUkcr6sP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5882C4CEEB;
	Sat, 19 Jul 2025 00:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752886297;
	bh=9kJxhZth6grHo3I0CSXBwom48o2ExKgGl5rWqerKBiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tUkcr6sPsug/hB3yPND7FFHxRVfOfHwN1Aqkgeb1Mimp1m8HUXIYRsdijzn+uaYlx
	 JjWmGmAoMAQNi4gfHEcVtbVbA4QcHbRNr+KdkXV3VsvrYHiQMQFe8+K7Mi1AUOZRyb
	 F3czf9k/JukXjWroE8xqyO8kr5tu5Zm9FDm2ITtSsUgosLGFflMwIrpTh9lNI82nla
	 6B1Y1GrX7Grlxmm8cubOAT1Z5iyKBfxtnPLMTMPrCvyUs0PFckWd//n43aSeUs0r35
	 G4+h+NP6AXbZaSECVQPFeMhFDbrTWCn0EHBfyDfoFZ6EPLrt9RdVJIealii11cN4o4
	 NSYDUizP/6jlA==
Date: Fri, 18 Jul 2025 17:51:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>, Jiri Pirko
 <jiri@nvidia.com>, Saeed Mahameed <saeed@kernel.org>, Gal Pressman
 <gal@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Shahar Shitrit
 <shshitrit@nvidia.com>, "Donald Hunter" <donald.hunter@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, "Brett Creeley" <brett.creeley@amd.com>, Michael
 Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Cai Huoqing <cai.huoqing@linux.dev>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, "Subbaraya
 Sundeep" <sbhatta@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 4/5] devlink: Make health reporter grace period
 delay configurable
Message-ID: <20250718175136.265a64aa@kernel.org>
In-Reply-To: <1752768442-264413-5-git-send-email-tariqt@nvidia.com>
References: <1752768442-264413-1-git-send-email-tariqt@nvidia.com>
	<1752768442-264413-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 19:07:21 +0300 Tariq Toukan wrote:
> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
> index e72bcc239afd..42a11b7e4a70 100644
> --- a/include/uapi/linux/devlink.h
> +++ b/include/uapi/linux/devlink.h
> @@ -634,6 +634,8 @@ enum devlink_attr {
>  
>  	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
>  
> +	DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD_DELAY,	/* u64 */
> +
>  	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
>  	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
>  	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */

BTW the patch from Carolina to cut the TC attributes from the main enum
is higher prio that this.

