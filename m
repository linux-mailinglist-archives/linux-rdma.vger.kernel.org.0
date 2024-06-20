Return-Path: <linux-rdma+bounces-3372-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19575911284
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 21:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1992872E5
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 19:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF77A57CB5;
	Thu, 20 Jun 2024 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxalFKXS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3AF13AF9;
	Thu, 20 Jun 2024 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912919; cv=none; b=Rn/KykWteYqZwJQ2iLPCHJ85bxF4MpIHhd1c/Bz6irqWJig8XDljBi9JQR1xGkVmuQs/xIhpT4dremxL4vL729KNr/58bt55ez3KEWcrVf7fc3ag21sSJxHjbq3P9jL0TcXka7oWn14RmGtfpettpI1z/7U3hao0pFN0xOJ7dkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912919; c=relaxed/simple;
	bh=qECrFUuwCG5ensq/HKwHGZQXIUHLMnGWYeGU1OVtFlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9pDF/5xPtifd7V69ZvLVrg95LNjKqGBKPmWXg58pvNgUkijSqr+GJwxHhH5cwyJ7Qx/0FpB1Rv3Y9gtlX24YxQAoTFIW1OD/Op3TQHeBM6ncMAEoXFfcRNIhZOaRX1YOeyR35irK+cGy39/d61DuqwgPjHVHkf6teUjMqg68C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxalFKXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565E7C2BD10;
	Thu, 20 Jun 2024 19:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718912919;
	bh=qECrFUuwCG5ensq/HKwHGZQXIUHLMnGWYeGU1OVtFlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxalFKXSAH1kQlVold7J2HZYuOhpb3bXJqWNrTTaizCK8LvHmhntXTTS7yNlBK31s
	 n1Zvpe8in7/8/MSKHaJujhz3+FVFQe00Sspy1okcjGBvU+DYktWvdYbdWXUNfT5vww
	 wpqkzVdyPlOn+lkgPaAM9GUJpUhSI1yXAoG22/KoQWmAGwpntPrD2unzbXkMV6WMS1
	 SKWgXTQdCyzhldIORjvDYR4KocoLjEFdpcvsV7mTjCUx26L7fTzCTayp4pdlrWAwnL
	 iEOtp0J9mzQRcIuuqra6cA/ECSCbRPUmYp71ESE72Hrm6fwx6gNjK/6tJNA4UmVlUa
	 i/M7aK96AMrAw==
Date: Thu, 20 Jun 2024 20:48:34 +0100
From: Simon Horman <horms@kernel.org>
To: Shay Drory <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, gregkh@linuxfoundation.org,
	david.m.ertman@intel.com, rafael@kernel.org, ira.weiny@intel.com,
	linux-rdma@vger.kernel.org, leon@kernel.org, tariqt@nvidia.com,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v7 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <20240620194834.GU959333@kernel.org>
References: <20240618150902.345881-1-shayd@nvidia.com>
 <20240618150902.345881-2-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618150902.345881-2-shayd@nvidia.com>

On Tue, Jun 18, 2024 at 06:09:01PM +0300, Shay Drory wrote:
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
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>

...

> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -58,6 +58,7 @@
>   *       in
>   * @name: Match name found by the auxiliary device driver,
>   * @id: unique identitier if multiple devices of the same name are exported,
> + * @irqs: irqs xarray contains irq indices which are used by the device,

Hi Shay,

A minor nit from my side: please also add entries for @lock and @dir_exists.

Flagged by kernel-doc -none

>   *
>   * An auxiliary_device represents a part of its parent device's functionality.
>   * It is given a name that, combined with the registering drivers
> @@ -138,7 +139,10 @@
>  struct auxiliary_device {
>  	struct device dev;
>  	const char *name;
> +	struct xarray irqs;
> +	struct mutex lock; /* Protects "irqs" directory creation */
>  	u32 id;
> +	u8 dir_exists:1;
>  };
>  
>  /**

...

