Return-Path: <linux-rdma+bounces-9639-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC4A95192
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 15:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 093B17A63C4
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 13:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4189226560A;
	Mon, 21 Apr 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcEVkLLa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF0F264A8E;
	Mon, 21 Apr 2025 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745241756; cv=none; b=ozIoPvTUttKM+xD7Ll9yOFWRPgwyyBSe140xQNCvAotA2jhPriyyX23Ca704U0Iy4/rs6S0RGhq1kKWBmmVvbZBiRD2DUr7vPIyxOYiLZ48ePPOeHmbrRkq5nUz4uqvGL61xa3c7R4+JIUSy/RzY+eh21BZZKUTLfJTmP4xCs94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745241756; c=relaxed/simple;
	bh=O/Wl7D2AALWkD5h899UW87JVEqspsVHGQ7Vw+1YDJhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb+nr/xzIfrEPmNJFGsPUW8nscfTlVaEC7tjzMUfAgws2OGwE+q4+LetiPvUFZH9O7fdNNYQFVQxcxGxytg/4SLCfl3vj/Kd19NXke+y75q8mIi9ohz3eZht8icvpwd7vpbKezxy/gjX8TLrl4n9uzZW3uqdayk43EqgDXb+A8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcEVkLLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532B2C4CEF0;
	Mon, 21 Apr 2025 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745241755;
	bh=O/Wl7D2AALWkD5h899UW87JVEqspsVHGQ7Vw+1YDJhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XcEVkLLa18wZ/O/fdSVxTbdHCC+nICbmRPV8gkt1GbLw7ut8rPyP+enBmJ8BpaqWJ
	 nhpRMbAjrqJJPDT5ZpWQYYQkjkuGYgbkV5t/cml7Uf0qhK7BJmuXBvliG7SKCkeM0h
	 RT1Uhlqj/IoUY/8H5uRs5o7QDnS66tDCLJAO8MjYrW8r/p3Cm39rfDdjqd8bqjD7Uk
	 oum9ogqBnYatc27BOKnnqIP6WmZnHmdGKD/PL4otQH0S8eNOF3ArFjj9dcFEIlxZH8
	 xkFgqZn6HPRZ1iYjeCIPDxDFkUFzjI33Y4EKTRSkYhP02vdmbzlHhQzYvyhj7EBnp7
	 PFxw2WOx4gmJA==
Date: Mon, 21 Apr 2025 14:22:30 +0100
From: Simon Horman <horms@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	jiri@resnulli.us, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	aleksandr.loktionov@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org, Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH net-next v1 2/3] dpll: add reference sync get/set
Message-ID: <20250421132230.GE2789685@horms.kernel.org>
References: <20250415175115.1066641-1-arkadiusz.kubalewski@intel.com>
 <20250415175115.1066641-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415175115.1066641-3-arkadiusz.kubalewski@intel.com>

On Tue, Apr 15, 2025 at 07:51:14PM +0200, Arkadiusz Kubalewski wrote:
> Define function for reference sync pin registration and callback ops to
> set/get current feature state.
> 
> Implement netlink handler to fill netlink messages with reference sync
> pin configuration of capable pins (pin-get).
> 
> Implement netlink handler to call proper ops and configure reference
> sync pin state (pin-set).
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

...

> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
> index 2b6d8ef1cdf3..b77e021356ca 100644
> --- a/drivers/dpll/dpll_core.h
> +++ b/drivers/dpll/dpll_core.h
> @@ -56,6 +56,7 @@ struct dpll_pin {
>  	struct module *module;
>  	struct xarray dpll_refs;
>  	struct xarray parent_refs;
> +	struct xarray sync_pins;

nit: Please add sync_pins to the Kernel doc for struct dpll_pin.

     And, separately, it would be quite nice if documentation
     of the non-existent rclk_dev_name member removed too.

>  	struct dpll_pin_properties prop;
>  	refcount_t refcount;
>  	struct rcu_head rcu;

...

