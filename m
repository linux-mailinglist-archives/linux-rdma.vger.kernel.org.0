Return-Path: <linux-rdma+bounces-3790-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38A192D226
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 15:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1033F1C2235F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BACA191F70;
	Wed, 10 Jul 2024 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ua3bxOpm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2190149C40;
	Wed, 10 Jul 2024 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616468; cv=none; b=HPmQrcm/zI6IAN6UMgiAv10jDg9DRCkZ1aa2PbSlT2KLj4hjcuakcCfnWS8F37iuJ2j4QDK+CulsXzwcSyuseBbU7hX8sETSsyxupLOS1jLacKEBVssm3nYbfxHh8zx6Km8/Dq4ZyN+KrvRMW0C7/1+yVNFzO2W1Q7Nh0/aSJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616468; c=relaxed/simple;
	bh=uRE4IQWMxKQIW7G4xAgQHp1q2BbAhCFYG2WGLJarPEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkzyDFmbK69Bubd5bATgjy+Lsr0q/RqJvZa+/Pfli30dISLTMI66r2d0xDERaqhgmwioDBn4t8KRLWe9H+YT/8TsaEYJ09Nt14G9x3AS6/3KBS2p7FwyYQoELNozY/GJf6EcOTyy2d5QaVUA2lUecjRM6Cldeyqh5ub6zmNyxds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ua3bxOpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEF1C32781;
	Wed, 10 Jul 2024 13:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720616467;
	bh=uRE4IQWMxKQIW7G4xAgQHp1q2BbAhCFYG2WGLJarPEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ua3bxOpmveB+0BtozVVJQWAjLZ2/zknyqCiKXU5M+MvD1xVGJGntBtZhL7f0Ohsfl
	 elnLIvHfDBnHa65GFyt3G0zC7dEjuKNvLELxA3Pjom7y6uzzOZ7R22vXC0CibjQNOO
	 wkgzdar/uFnWL1xybZOpem2IlslvIvkiZWtmNKJE=
Date: Wed, 10 Jul 2024 15:01:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shay Drory <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com, Simon Horman <horms@kernel.org>,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v10 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <2024071041-frosted-stonework-2c60@gregkh>
References: <20240708055537.1014744-1-shayd@nvidia.com>
 <20240708055537.1014744-2-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708055537.1014744-2-shayd@nvidia.com>

On Mon, Jul 08, 2024 at 08:55:36AM +0300, Shay Drory wrote:
> PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
> and virtual functions are anchored on the PCI bus. The irq information
> of each such function is visible to users via sysfs directory "msi_irqs"
> containing files for each irq entry. However, for PCI SFs such
> information is unavailable. Due to this users have no visibility on IRQs
> used by the SFs.
> Secondly, an SF can be multi function device supporting rdma, netdevice
> and more. Without irq information at the bus level, the user is unable
> to view or use the affinity of the SF IRQs.
> 
> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
> for supporting auxiliary devices, containing file for each irq entry.
> 
> For example:
> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
> 50  51  52  53  54  55  56  57  58
> 
> Cc: Simon Horman <horms@kernel.org>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>

Thanks for sticking with this.  As I'm guessing this is for the
networking tree, feel free for it to go through there:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

