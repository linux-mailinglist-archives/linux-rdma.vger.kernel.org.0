Return-Path: <linux-rdma+bounces-13259-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C1CB52520
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 02:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA8E1BC11A0
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 00:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266A71C6FE1;
	Thu, 11 Sep 2025 00:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g65SBj0x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB22AEE4;
	Thu, 11 Sep 2025 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551723; cv=none; b=LTfJmAtyX935Wqvd4x2Y4DIgdsuNPxEAnAYJXsyFp1W2NaK3IysbPr7rFU8jfsbOZ5TVILgUjK1OJGSqSWmpApcOmXg9YIfohWeF4zUlFVoFtTEyNtZ3jUvvMu5AQnEYCn/ZmcCV2x/ajOQpfe1q/ERq2O26MvQ8AqBg5AkTTmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551723; c=relaxed/simple;
	bh=/eJqikfebvgK9kraiD2vwiU2CpuvZHNfPP1bDuDx014=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPgEHE37NgB8U6r1KcZ4lujn4hAmEqF1+ny5Ohua+iw7ZXXd/hHlUz6bk2DwlrsbQYDKdkvHh/HxohInWSed9+5LFuzeXtIHaGN8LzYdItET3Ig+kOZ6NtaiGuSljpe7WkRXOQ2I4L+aQHepjZSW686cKvhYf8WUeQR1CHUmEJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g65SBj0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBABEC4CEEB;
	Thu, 11 Sep 2025 00:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757551723;
	bh=/eJqikfebvgK9kraiD2vwiU2CpuvZHNfPP1bDuDx014=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g65SBj0xujDB8MHZ7zaWS5POad1W/jneD/oPcwSGnhp+zYCNaWOW3yxAp173sJkXk
	 7wDz/ZztUMG4Iyfp6zJjTCJsG65vTDQqK/4rRx4ai48P3ueo57EnfNz/11C6j3Ox1U
	 djMdaOdvKqfhQyU2P8oPsmrJVDvYGt7+2HesS8DYMbL3Z8j4lJADSpPVcRqrr01SFr
	 2ngdo0Q/AacneRnSQXmbsEQmoE1TfjeAjIBFvOdhGSNh9uXr6+UsN0SZmg+qMBNB3p
	 vKFGNLGJ9e+7y569Og+r0Az8S/mwhZfXldaBqCxEHKP5HdE+cFVmfydhDOib4GapSc
	 jRoGknviJzN8g==
Date: Wed, 10 Sep 2025 17:48:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark Bloch"
 <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>
Subject: Re: [PATCH net 2/3] net/mlx5e: Prevent entering switchdev mode with
 inconsistent netns
Message-ID: <20250910174842.6c82fb0c@kernel.org>
In-Reply-To: <05a83eb7-7fb1-46ae-b7ba-bd366446b5f5@nvidia.com>
References: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
	<1757326026-536849-3-git-send-email-tariqt@nvidia.com>
	<20250909182319.6bfa8511@kernel.org>
	<05a83eb7-7fb1-46ae-b7ba-bd366446b5f5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 11:01:18 +0800 Jianbo Liu wrote:
> On 9/10/2025 9:23 AM, Jakub Kicinski wrote:
> > On Mon, 8 Sep 2025 13:07:05 +0300 Tariq Toukan wrote:  
> >> If the PF's netns has been moved and differs from the devlink's netns,
> >> enabling switchdev mode would create an invalid state where
> >> representors and PF exist in different namespaces.
> >>
> >> To prevent this inconsistent configuration,  
> > 
> > Could you explain clearly what is the problem with having different
> > netdevs in different namespaces? From networking perspective it really
> > doesn't matter.  
> 
> There is a requirement from customer who wants to manage openvswitch in 
> a container. But he can't complete the steps (changing eswitch and 
> configuring OVS) in the container if the netns are different.

You're preventing a configuration which you think is "bad" (for a
reason unknown). How is _rejecting_ a config enabling you to fulfill
some "customer requirement" which sounds like having all interfaces 
in a separate ns?

> Besides, ibdev is dependent on netdev, there is refcnt issue if netdev 
> is moved to other netns but devlink netns is not changed by "devlink dev 
> reload netns" command.

shrug

