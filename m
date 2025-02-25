Return-Path: <linux-rdma+bounces-8063-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633B2A43690
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 08:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911923A7975
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 07:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B248A25A34C;
	Tue, 25 Feb 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVut6nzu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA025A32D;
	Tue, 25 Feb 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470135; cv=none; b=ti4gLWdh3cWz6vjq0/hRbqQZasHws0yKylFKfFWbLdsuFF8CLSFWQJyJAPSxo3+tJHewvcT+zy6hNVQwD//5g/G13eT+GvE8jhSX6MwF5ENNVy3vZU/jQalhPzYMTh9h/TiKNJicPypR3kSggTdZNrYH/F0vQ2PwExMLUXjNqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470135; c=relaxed/simple;
	bh=26kEWrHsJUAlh0ZBlcW151O8ytU26+XAmiyBTfJHjuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuqY8+7esGQESPiDyfCgatWOY9yzoDR+R4Ec2dpdDlJYclnlc2cdvnX7aXcgc+62ih29tyjMkuqtyPmxwsJ7BZQSSCJlIsqXK1jGmYf4JmoLibHF+bh7DbS1I/sT7I0uTCw5T4n5uojoEBNO7Ups7nFfPCWHnQm48q7f9Cpdrjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVut6nzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08CDC4CEDD;
	Tue, 25 Feb 2025 07:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740470135;
	bh=26kEWrHsJUAlh0ZBlcW151O8ytU26+XAmiyBTfJHjuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVut6nzuR9giRKPXY4xVu2aIIY+V1CAxMbDfW7/hqsw0oDsfXkzJrGryRePr7QF8T
	 FdAi1+SczvwO2Y2SGetPuPR4Oe/vHRGnB0A3KwBmfMGX1wiETbKfey9ZA0tP51z/pi
	 cghhL6C68iNC7wx6YNTAMzWwfa++Z4aFCvANUYWS1IJ8wP5sNony4xqdLOatm+ZkZP
	 FAbSF5nK1BmvCNZfoN5MvTs/7z3PZqhn+AT51q3uWxPZhmHqHNbKPBlb8oPb0usZg+
	 YGiOGZP89gvw42MIyYHsfI/RIVFHOBX7sMmjIkIyoyHlB/VFryur9z/0Hzwauyje4H
	 pGZcwr/2rybpw==
Date: Tue, 25 Feb 2025 09:55:30 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: jgg@nvidia.com, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	david.m.ertman@intel.com
Subject: Re: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support multiple
 consumers
Message-ID: <20250225075530.GD53094@unreal>
References: <20250225050428.2166-1-tatyana.e.nikolova@intel.com>
 <20250225050428.2166-2-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225050428.2166-2-tatyana.e.nikolova@intel.com>

On Mon, Feb 24, 2025 at 11:04:28PM -0600, Tatyana Nikolova wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> To support RDMA for E2000 product, the idpf driver will use the IDC
> interface with the irdma auxiliary driver, thus becoming a second
> consumer of it. This requires the IDC be updated to support multiple
> consumers. The use of exported symbols no longer makes sense because it
> will require all core drivers (ice/idpf) that can interface with irdma
> auxiliary driver to be loaded even if hardware is not present for those
> drivers.

In auxiliary bus world, the code drivers (ice/idpf) need to created
auxiliary devices only if specific device present. That auxiliary device
will trigger the load of specific module (irdma in our case).

EXPORT_SYMBOL won't trigger load of irdma driver, but the opposite is
true, load of irdma will trigger load of ice/idpf drivers (depends on
their exported symbol).

> 
> To address this, implement an ops struct that will be universal set of
> naked function pointers that will be populated by each core driver for
> the irdma auxiliary driver to call.

No, we worked very hard to make proper HW discovery and driver autoload,
let's not return back. For now, it is no-go.

<...>

> +/* Following APIs are implemented by core PCI driver */
> +struct idc_rdma_core_ops {
> +	int (*vc_send_sync)(struct idc_rdma_core_dev_info *cdev_info, u8 *msg,
> +			    u16 len, u8 *recv_msg, u16 *recv_len);
> +	int (*vc_queue_vec_map_unmap)(struct idc_rdma_core_dev_info *cdev_info,
> +				      struct idc_rdma_qvlist_info *qvl_info,
> +				      bool map);
> +	/* vport_dev_ctrl is for RDMA CORE driver to indicate it is either ready
> +	 * for individual vport aux devices, or it is leaving the state where it
> +	 * can support vports and they need to be downed
> +	 */
> +	int (*vport_dev_ctrl)(struct idc_rdma_core_dev_info *cdev_info,
> +			      bool up);
> +	int (*request_reset)(struct idc_rdma_core_dev_info *cdev_info,
> +			     enum idc_rdma_reset_type reset_type);
> +};

Core driver can call to callbacks in irdma, like you already have for
irdma_iidc_event_handler(), but all calls from irdma to core driver must
be through exported symbols. It gives us race-free world in whole driver
except one very specific place (irdma_iidc_event_handler).

Thanks

