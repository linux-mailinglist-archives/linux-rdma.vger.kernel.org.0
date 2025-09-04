Return-Path: <linux-rdma+bounces-13085-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4AB43D86
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 15:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F293A7B73EE
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 13:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC0F3054D5;
	Thu,  4 Sep 2025 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+gMvT9D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99B14AA9;
	Thu,  4 Sep 2025 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993499; cv=none; b=i6tFVvd9ncyoXVUExL1qQhcIryTo9+eRb1AibpN5k3fwXMCJMfIonBLNh0FZ8herWD155NRNGUzGZLLgssQAvQ2X2V/ZYSJt1VCqt1rilLgZrk22LNa1ALDuQS2w+NGB04FUjMDJYUTpsEEmRIQqg+wD9s9qGbWkS3EagyZYLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993499; c=relaxed/simple;
	bh=+BW5/2LAZqixMbdbAbb7uoQXYsbhUfksqEkqBZNbAsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FjDE9qpBL4irDSt5lxd/Yzx6aOzJfnt5or6iStxnRhz9+hTbvp/dP4t4lnfg7zkt/4Rc0UrsF/3KQfoWJ2Urd4UTqP36yYOxv/eu49d7a+BP2VJjgidiTsctPxS/Xy6jV52Duzr0/vp3B++vYRwLcZEggOQLohRA5OhSzcNH3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+gMvT9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B12C4CEF1;
	Thu,  4 Sep 2025 13:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756993499;
	bh=+BW5/2LAZqixMbdbAbb7uoQXYsbhUfksqEkqBZNbAsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R+gMvT9D18jZ2jXV+iA4wFOqMy9mnXDMTzW/0LKvwO1K/P2flsluXjrpbLyJLz0n6
	 RJs+xHanRdtbJRbunnOfOhQW9/xi67S/douHd/jnVyHf6VLikeZgcXOeqU2Vt3LES9
	 29A63gt/3cT5z8uYKldFk96PiJYqcw8tVghAT0cVrCszRQ8WodXPA3nuN2G2ooF6z2
	 S7w9i/EAKknf6KzVse4oe/R8En8H73yqvoL6cNXrEA2Kjg5dII6ed4GFFkPnWqUZhZ
	 1pV8Z6pWxcbajsaV7FkEgOjthRF/7BgInfJiP71/VNRBvm2el/Z9huukV9Rk17xPo5
	 Q/VYU6tmhgqHQ==
Date: Thu, 4 Sep 2025 06:44:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Makar Semyonov <m.semenov@tssltd.ru>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca
 <sd@queasysnail.net>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macsec: fix double free of flow_table groups on
 allocation failure
Message-ID: <20250904064457.0b222da4@kernel.org>
In-Reply-To: <20250904114655.1674691-1-m.semenov@tssltd.ru>
References: <20250904114655.1674691-1-m.semenov@tssltd.ru>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Sep 2025 14:46:54 +0300 Makar Semyonov wrote:
> Subject: [PATCH] macsec: fix double free of flow_table groups on allocation failure

nit: please use the driver name as the first prefix, so "mlx5:" or 
"eth: mlx5:". "macsec:" would be appropriate for drivers/net/macsec

