Return-Path: <linux-rdma+bounces-12193-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42429B06115
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 16:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E0A1896C92
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B92D2376FD;
	Tue, 15 Jul 2025 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chQWaN/0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9E70831;
	Tue, 15 Jul 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589111; cv=none; b=JT/lK6XNFwReINeoBs6/GT2BCcrEHZ8wR7tnk0xElfR8Ji9U1ZNEMkFporVcbRCVtfw9ebxlAYeBitY4NEDdHyRRdZ+CLOUiU7w2rD9b4rRIuboXT8Yj0L9jUVyNWIVsD25gfS/u/5aXLoMhPHYPkQnqRGbcnRjzlCClBB/fAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589111; c=relaxed/simple;
	bh=RkSHM+tFHM/HODKiKtPIYIBdRBDX30jv8ZIfBnB5DAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4NmTZXx3uVscyu00zLyxxC/fGNB9SkWLs3lAFH1WTaUrVnkQ0sGmMiSt+Ng5yQR3n23omdOM4i4HR8q+XVZ1TKsXAddERQ1kLfUZSzBs+Sqr7K5uB1tqZm3Yvx+ukAVdc+BVvNGJAy3vbfTLF3Ws+KzO07uLDJ+5qEXyyaMepg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chQWaN/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2246DC4CEE3;
	Tue, 15 Jul 2025 14:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589110;
	bh=RkSHM+tFHM/HODKiKtPIYIBdRBDX30jv8ZIfBnB5DAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=chQWaN/0TwbT2+kuQlNixbFhb8aWUnESCZ08IOWeZjb2+Ufd7Vs0EHrCma4LpEKds
	 tJXZ6l3EEuLBH/SKyl/cK6/HLSqSWi5M9jgeMtUM0HPFTKVUensZ4vhwvJLWGD0qx4
	 iadh60RWys3tT+9yKMrqa8qBt4RuCnqOte83enYaGZ7jEMK1VaJ1rozjwwbNodInCQ
	 DMaR68iXUqBkFUBuvCU2Je+NcNg7LZEqTkgpiZ3knx35T5lKcQCspuNSkkSM4MMmu1
	 bwv1wrT7J9f7rcjqkQBX/EcJbYaD//SAlZeZFk8xpkiPOKx+wUFzKceczXLuu6bdfy
	 tI73uCt5eP3CQ==
Date: Tue, 15 Jul 2025 07:18:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 2/3] net/mlx5e: Add device PCIe congestion
 ethtool stats
Message-ID: <20250715071829.04926bef@kernel.org>
In-Reply-To: <b921eefe-3220-4b38-8b41-be6ddd98f913@gmail.com>
References: <1752130292-22249-1-git-send-email-tariqt@nvidia.com>
	<1752130292-22249-3-git-send-email-tariqt@nvidia.com>
	<20250711162504.2c0b365d@kernel.org>
	<nqfa765k7djsxh7w5hecuzt6r4hakbyocrp5wtqv63jyrjv3z2@qdar7f2osjcj>
	<20250714082600.15113118@kernel.org>
	<b921eefe-3220-4b38-8b41-be6ddd98f913@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 16:59:43 +0300 Tariq Toukan wrote:
> NP with that.
> We'll add it as a followup patch, after it's implemented and properly 
> tested.
> 
> Same applies for the requested devlink config (replacing the sysfs).
> 
> For now, I'll respin without the configuration part and the extra counter.

SG.

