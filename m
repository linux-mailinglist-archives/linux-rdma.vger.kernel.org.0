Return-Path: <linux-rdma+bounces-14673-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFA1C772C8
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Nov 2025 04:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C4FF4E7276
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Nov 2025 03:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CD12727FD;
	Fri, 21 Nov 2025 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty/EFn9x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C818A956;
	Fri, 21 Nov 2025 03:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763696384; cv=none; b=lVD/0uukjhuA2BTp0mdn9uV/IqDTZdhYVhhM0ebSzDPCcXvowhFwmFb+lRae+QvUxCeLUojGtgV+km/MUTnvMoy9Ybv42unuZLvhBcTHNfbylXm9Eyxfr3Bzq41qIU/PkkvI06eRdJfROPId6cdRUkHhk76+3BDEme6F2+7i3Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763696384; c=relaxed/simple;
	bh=gsyvr6N3w0w8TUaKcqtHGPW+xZFPpFRf3IaY0bUKitQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLRZZtQv9qlJOXg/unQMx7n45O4wO5k10f4ni+53dLFwDBYfuT9oa8hoCBeJGYhshohTgEWztc6/sFKiJ8VqfiJ4QFLNPp0Z88KPGZUea4j7QyVuJhkkUQ9NYeRo/qqImj3fvV5a24BNNnulejBShPnGFWdjuRsPGok7AIeZaeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ty/EFn9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0585DC4CEF1;
	Fri, 21 Nov 2025 03:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763696383;
	bh=gsyvr6N3w0w8TUaKcqtHGPW+xZFPpFRf3IaY0bUKitQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ty/EFn9xV5fGi4rA6Mo7gWH1xwwVYl1XgK3dT1nLx3GZ5TsfXqybwvgw74/IewClS
	 U2uIoIwPQld+z6ILQ7SBjRaW6DAmj0GNGT0B7FpjTRdykMP7KiEVUcpxlcbcGDA+kn
	 6Zb/hvKfG2hWqpyn4m6jBsbFELvSHe/Lv9j6TS3K/8Sd9ixm6s1zxAC1wTaSdZFGeI
	 k3YR7T0GJc+gpSVPxmTpCOmOviR7d5XrzEs0tuHDeWdPamxq/GCArn5P0j0cRF3pjQ
	 aXYIDF7a8deHP+njNufod0tnLXaBOk62v7/Vk8hsmFPQPeWmlB03FhOzko8OqxNrhn
	 HgWbamji+jNZw==
Date: Thu, 20 Nov 2025 19:39:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 00/14] devlink and mlx5: Support cross-function
 rate scheduling
Message-ID: <20251120193942.51832b96@kernel.org>
In-Reply-To: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 15:09:12 +0200 Tariq Toukan wrote:
> Code dependency:
> This series should apply cleanly after the pulling of
> 'net-2025_11_19_05_03', specifically commit f94c1a114ac2 ("devlink:
> rate: Unset parent pointer in devl_rate_nodes_destroy").

repost please, we don't do dependencies

