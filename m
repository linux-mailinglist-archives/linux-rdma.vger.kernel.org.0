Return-Path: <linux-rdma+bounces-12005-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1054CAFEFC2
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 19:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075355A4B03
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 17:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08273228C9D;
	Wed,  9 Jul 2025 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx5IrapT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F584A32;
	Wed,  9 Jul 2025 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081851; cv=none; b=PSStyFiOUktxrs3mk6Vzav5/W/7kxAD7WLyN96Gz3lypFwbt6JdDfwUWazT7d6T08OFZN3wvt1YkdXwpZ3CxjbUCUcz3cZ8h6EojSEESj8zNvHPTkDMMvePJpo+tvM5bPV0PNQ1TKM1I2ZwhNWXs5IUNWux9c1rhw/0Tc9CukmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081851; c=relaxed/simple;
	bh=Gqu/D8I9Qt870Zwfncdc8ao7xDI5/KVbSstaCW2IGNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEwJCJ7qS8EbogLdBao8bfSN1Derh71nPo1ayBh49L+McZL2qMqzUCqiTAjKF4zuJlXKCWMVz9LNgHkhK0e5oht4rBVRQrZkNQ+4Y8lbNbCPCG1fz7L/9a5M6II03pO0LOVd3Fzwo3vc8Htvl5QhOpoVwesALeauhnMcfFbhsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx5IrapT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753C7C4CEEF;
	Wed,  9 Jul 2025 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752081851;
	bh=Gqu/D8I9Qt870Zwfncdc8ao7xDI5/KVbSstaCW2IGNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yx5IrapTqnUFrnQW5xRxzg9gxEkFEbmGW6bZHKk9PWFSvP97kd2bDKh9PjRqA2bGM
	 cC+BlpCqGwUNQ/N8ivitPf4yYFQHFodu2xsxyUsorRgLYi23NffQaZ0YmV9q1b+xXK
	 iT5wbhjkISYtxDZ801iZz49dFFUozX3q7s88nT2OUTIGMJunlTPREQ/HqkNSYUyYpP
	 kmaR6yavl7DRvz91reHRyQpK0bsa/fEgE1HNBfl5Ro6/1j9QYStZ+wL4fow9CUInl8
	 6FVomvUOWBsjJLwPg4ZeMIS0e/TlX++n46QKIqdUmycgIHRC1Ce9aloXSppOPsXWQE
	 08Z86LCV5VMUA==
Date: Wed, 9 Jul 2025 18:24:06 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 2/5] net/mlx5e: CT: extract a memcmp from a
 spinlock section
Message-ID: <20250709172406.GC721198@horms.kernel.org>
References: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
 <1752009387-13300-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752009387-13300-3-git-send-email-tariqt@nvidia.com>

On Wed, Jul 09, 2025 at 12:16:24AM +0300, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> This reduces the time the lock is held and reduces contention.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


