Return-Path: <linux-rdma+bounces-8213-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C31FA4A6BC
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 00:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827D1178083
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA58D1DF744;
	Fri, 28 Feb 2025 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9ZnM6JH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F27B1DEFFE;
	Fri, 28 Feb 2025 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740786879; cv=none; b=WWwMp/j/1naIw8gHReroNNEkQ9mmu8PkzIPDZBj55Af2UEANgfYtcFByJ5fS6dr2FB2KmmuOAuFUn17mxi6o9LbblXUse6VZLXAf/wynPctR3biW7kEN/kLKWpofbVrYb47khGAr7LqFOCWhzkuAqXSr7D2KwpYPPS1PL/5IaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740786879; c=relaxed/simple;
	bh=meXfgJ4qxRqs856ARbJTcb0is5paBEeQc14p2Gq+rlg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDTMCPFov578QiwNIXDBd9N555ImgJopn7dFg90z97xvv0j7sHB4S/EkY+n1utD2ZEEn+EFpaM0jnMvkL6G27mb3SZT2Z8fJG+6MKgxQLFfZxnE7kA4JyccfERSVQ1OJu/dMhfBKqtMgDbD0+3UF2tjwlm/dzzymDsHdCMr9BDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9ZnM6JH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A05BC4CED6;
	Fri, 28 Feb 2025 23:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740786879;
	bh=meXfgJ4qxRqs856ARbJTcb0is5paBEeQc14p2Gq+rlg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R9ZnM6JH0pKLzwVyveSo5/ao6bSPuqZewXvvSjOciLJSedR0I8JFU4fM2fn2eGXDJ
	 kpRQDZNpMp22IXlRJ+0KBqoGD5WJHNrW4MJOi/GU7wTKjs0i515Ls84RsMKRk8hKfw
	 AOfCDaeV5J1CoOp/ryFvmnHiCiDXUPWEuIabh9tcAbew8Q4Ddz+rftbPXKd1YiMyOK
	 /9ipD9vxBbEuyViTdcxKDwnNHFwdAW2/L4TtnERBv2gbvzCpup+c6Iros7tqxYoOdw
	 At9YwBe7OH/ykd9GC84fSCKtkWitVBnyz3vz2alwBlVxCbuEY8RLPtbrLELnH9uGfO
	 BoPeLQ9WAAHpw==
Date: Fri, 28 Feb 2025 15:54:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 3/6] net/mlx5e: Enable lanes configuration when
 auto-negotiation is off
Message-ID: <20250228155437.0a6ec42a@kernel.org>
In-Reply-To: <20250226114752.104838-4-tariqt@nvidia.com>
References: <20250226114752.104838-1-tariqt@nvidia.com>
	<20250226114752.104838-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 13:47:49 +0200 Tariq Toukan wrote:
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index 84833cca29fe..49d50afb102c 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -2192,6 +2192,8 @@ enum ethtool_link_mode_bit_indices {
>  #define SPEED_800000		800000
>  
>  #define SPEED_UNKNOWN		-1
> +#define LANES_UNKNOWN		 0
> +#define MAX_LANES		 8

Almost missed this.

Any reason you're adding to the uAPI header?
Just because that's where SPEED_UNKNOWN is defined?
IIRC lanes are only reported via netlink, so we don't need 
to worry about sharing unspecified values with user space.
Stuff added to the uAPI header is harder to clean up,
if you don't have a strong reason I think we should move 
these defines to the kernel header.
-- 
pw-bot: cr

