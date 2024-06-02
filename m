Return-Path: <linux-rdma+bounces-2749-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EE38D7404
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 08:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD011C20A67
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 06:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C11BC49;
	Sun,  2 Jun 2024 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b33G+vHm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA3118622;
	Sun,  2 Jun 2024 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717311403; cv=none; b=GDLm8QKwHqIByXAkyWiNQxICdtDngEyAMfXjRUeEXb3deFNRb0veYySwb66WT0BRFosj7IS2JFDCkr4Az5vYql0GdXAP3sG+Z51wffl3h65XPRXxjy/0JcQqdcZDp50fOPGfGnbrWmdyahiSLg3VIpRogYYiIonO0GCV9BMkxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717311403; c=relaxed/simple;
	bh=m2hTycT7b9I8OtE98CrtrOs2gLvWL0tABdGXhMXVPGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+00tH6tSmCSCByj8GSTF5NAmKaOsq7uYkPGo5mXzWpC6yGhMGi05dnHCu3ARR/Al69ToWp91EFQUgcLxpgTwXq+DiC8QGXxtLGo4qH3D2g+QCU+TLF3PapRT50VlqslZ6UQlhWjHp5K1e5lqdo0KlVNTM8FvNhoq2+uP+d36uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b33G+vHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86767C2BBFC;
	Sun,  2 Jun 2024 06:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717311403;
	bh=m2hTycT7b9I8OtE98CrtrOs2gLvWL0tABdGXhMXVPGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b33G+vHmE24iEodIAibxO1C8u+/3rl3ozdtEuzZ5cRGPU5ecH95gALS7ESjyC8QAf
	 6Ob+YDE8FPXtxOZBP4veD8WWUDzkHZhyrSrbN2GMQUU9FRWh6XVXmnrY+la8y34ih8
	 inafnPqJwoXdqpMA/Ybf3qO0OaFJOuekaSLtyJ4biya3EuFY2tSGjlIY9Hn+PMcu04
	 9qzBdVcHSUZCJAsvPoPtRQRY5K2I4nkk0bMkgWPdwm53l7uYRS04eGXAtfXBbPTtck
	 X0aTwyUnViXciAvD4xBe8TT0gckTmX0ExXAHdF6NO/rVLAj4iw6WZKD0vvU2hwXZcL
	 lYapyvygNt7vQ==
Date: Sun, 2 Jun 2024 09:56:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <20240602065638.GI3884@unreal>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
 <ZljyqODpCD0_5-YD@slm.duckdns.org>
 <20240531034851.GF3884@unreal>
 <ZloMv29mmAKNPTrg@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZloMv29mmAKNPTrg@slm.duckdns.org>

On Fri, May 31, 2024 at 07:45:35AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, May 31, 2024 at 06:48:51AM +0300, Leon Romanovsky wrote:
> > We have similar issues but with different workqueue.
> 
> So, the problem with the proposed patch is that pwq may still be in use by
> then (due to async freeing) and thus can't be freed immediately. I still
> don't understand why KASAN is triggering there. I tried to repro by
> introducing a pwq alloc failure but couldn't. Can you please share the
> repro?

The repro is part of our CI test, where we run traffic tests and at the
end perform "restart driver" stage. At that stage, this lockdep is
printed.

The test is:
1. Create bond interfaces
2. Run traffic
3. Strop traffic and check that everything is OK
4. Restart driver:
modprobe -r -a bonding
modprobe -r -a vfio-pci ip_gre ip6_gre bonding geneve ipip ip6_tunnel
modprobe -r -a ib_umad ib_ipoib rdma_ucm mlx5_vfio_pci mlx5_ib mlx5_core mlx5-vfio-pci nf_tables

Thanks

> 
> Thanks.
> 
> -- 
> tejun
> 

