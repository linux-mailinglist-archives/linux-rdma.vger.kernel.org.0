Return-Path: <linux-rdma+bounces-13214-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD70B50A2C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 03:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6019441214
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 01:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0D61EFF8D;
	Wed, 10 Sep 2025 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWPk3uTx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4804928EB;
	Wed, 10 Sep 2025 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757467402; cv=none; b=I+H8mKY+4xsINi4RyjKgPP845Lfd0OfbQJ6RHf6u5xESgr3y7k0a6ZITx7NptPGINdMFHnSoLwtvjsI6aV/el625ohJen4FCKAJqobLZH6thjTz9Gbsr2F0nx1PAHDCxhC56d6jX7AF9SL8Y63sQwE0dfVKG68rJ6nMUHdYYA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757467402; c=relaxed/simple;
	bh=o0vciZAdTN6hRxPd/8cva0H8noNZQH8GL+sl7Ryf34w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtA9buKU/Ag0qEUM+mDbuT6mTVRM/eCflgUUuQ0RQLGd11K3wk+D8ef3BqNpVsa+3wwgFpGEM64W1HvI0oWSEuv7HsmhOmrNT+IuIoKKSNijZPszIo70IheJqSa6+rVD68oxYEkQOt7joTQHizyAfKHxBFJL1ABg7k4TdqTQwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWPk3uTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45157C4CEF4;
	Wed, 10 Sep 2025 01:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757467400;
	bh=o0vciZAdTN6hRxPd/8cva0H8noNZQH8GL+sl7Ryf34w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cWPk3uTxD2nsGcFORxKr3KINSeD5//ES9AWvBN8+vGtNE2CKsFF6EsJj8bhDGgE7P
	 2lBWVNE/uqhvkk0MA3OJvf0yduIdNnOxL6ejMdIV42GTLW/7Mo5RfSMo6LQfNvwTya
	 Qqf5TcB8bWo4C3iKiV9fGN5WEk7E/AsUDA8eP4gMGFbMvEiZnH5Nt/la5xAztriQA+
	 TaRJhr72rB1ekwkAfjRgayKol5jVW0XWumhAIMnlh/KyorxiTq82diivZOfgR+/U5u
	 KyJT6wT4aPrx8q5PVNCQxhiXBl4RipHu9qDCSjFEjaL1Vl1xwa7I+0p3Vlkg7UFMaF
	 1mY9cmC8mB5FA==
Date: Tue, 9 Sep 2025 18:23:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jianbo Liu
 <jianbol@nvidia.com>
Subject: Re: [PATCH net 2/3] net/mlx5e: Prevent entering switchdev mode with
 inconsistent netns
Message-ID: <20250909182319.6bfa8511@kernel.org>
In-Reply-To: <1757326026-536849-3-git-send-email-tariqt@nvidia.com>
References: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
	<1757326026-536849-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Sep 2025 13:07:05 +0300 Tariq Toukan wrote:
> If the PF's netns has been moved and differs from the devlink's netns,
> enabling switchdev mode would create an invalid state where
> representors and PF exist in different namespaces.
> 
> To prevent this inconsistent configuration,

Could you explain clearly what is the problem with having different
netdevs in different namespaces? From networking perspective it really
doesn't matter.
-- 
pw-bot: cr

