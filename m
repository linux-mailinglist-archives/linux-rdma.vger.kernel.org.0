Return-Path: <linux-rdma+bounces-5818-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675499BFB3C
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 02:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CCF1C2109F
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 01:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C0B4A21;
	Thu,  7 Nov 2024 01:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g20UIQph"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C279DC;
	Thu,  7 Nov 2024 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942239; cv=none; b=fM8LHMXy/I7P60zj5T7FE65hgC/mhsLKfQHnFimenHXHAmSOlsLb6x4udIXCVis4YPXMiXZtkAUFqld4dmnO13R+35AYEoVncgLltZeZZrHxopmDl8xHPj77I8csamwgAbDJ7/QF9qV5i4e+ODelaXKWH20mCcOcVDuGzbWpzBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942239; c=relaxed/simple;
	bh=olvQqFHA0VXlofce8cYOdX7+1jqLoW3AbmHUMqvUUoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nn2XNvYhd0od8Y+ANqfi3olvgasnPIF54I3go1W5BgN81rFhjFysdJ5EJy8oya/77Q1btMnWNbjERs14qV0NHrE+HP3FePgbBM1NNdC+ZvjgM5Vudk9O7+L007W/dKCewrg3PpFNAXvuzDboFmnNxAksE0+yY15RKN/In6JFMYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g20UIQph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9059C4CEC6;
	Thu,  7 Nov 2024 01:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730942239;
	bh=olvQqFHA0VXlofce8cYOdX7+1jqLoW3AbmHUMqvUUoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g20UIQphyJqkNvrjgD284y8AmFfiLQRyGshcbW+nVukLF6mDj0jNCc/b2vdbxlAXF
	 or4JE9optmGkCoVJjdArRkQkHX+uET0a4NzsRvW+K3p0Azn/2KodUhEpzTIl+J4flH
	 Yoe56TAOyctNoOGPQ5j2/tdI1g+d86N2W2NT0ULkL9XWkC63TkTSE/MANENB8nx+Kr
	 PfYa4T+mT/FYVEfQf+JMJtwAyRdHCtNHpVQaDB6OHG2V5NYevKYY7zuE12p2FMGAMX
	 riiDXUoKj1C6hiGEaurJEFaG7Tfk0OOdlLpmIUXbFCTBweqtEj0VFAOThKORQu2VyN
	 YgvUohMGCcONw==
Date: Wed, 6 Nov 2024 17:17:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Tariq Toukan
 <ttoukan.linux@gmail.com>, saeedm@nvidia.com, tariqt@nvidia.com,
 leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: Report rx_discards_phy via rx_missed_errors
Message-ID: <20241106171717.1bf7331f@kernel.org>
In-Reply-To: <9b3af2dd-8b56-4817-b223-c6a85ba80562@nvidia.com>
References: <20241106064015.4118-1-laoar.shao@gmail.com>
	<b3c6601b-9108-49cb-a090-247d2d56e64b@gmail.com>
	<CALOAHbDPbwH7vqV2_NAm=_YnN2KnmVLOe7avWOYG+Rynd295Vg@mail.gmail.com>
	<9b3af2dd-8b56-4817-b223-c6a85ba80562@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 21:23:47 +0200 Gal Pressman wrote:
> > It appears that rx_fifo_errors is a more appropriate counter for this purpose.
> > I will submit a v2. Thanks for your suggestion.  
> 
> Probably not a good idea:
>  *   This statistics was used interchangeably with @rx_over_errors.
>  *   Not recommended for use in drivers for high speed interfaces.

FWIW we can change the definition. Let me copy paste below the commit
which added the docs because it has the background.

tl;dr is that I was trying to push drivers towards a single stat to
keep things simple. If we have a clear definition of how rx_fifo_errors
would differ - we can reuse it and update the doc. For example if
rx_discards_phy usually means that the adapter itself is overwhelmed
(too many rules etc) that would be a pretty clear, since rx_missed is
supposed to primarily indicate that the host rings are full or perhaps
the PCIe interface of the NIC is struggling. But not the packet
processing.



commit 0db0c34cfbc9838c1a14cb04dd880602abd699a7
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Thu Sep 3 16:14:31 2020 -0700

    net: tighten the definition of interface statistics
    
    This patch is born out of an investigation into which IEEE statistics
    correspond to which struct rtnl_link_stats64 members. Turns out that
    there seems to be reasonable consensus on the matter, among many drivers.
    To save others the time (and it took more time than I'm comfortable
    admitting) I'm adding comments referring to IEEE attributes to
    struct rtnl_link_stats64.
    
    Up until now we had two forms of documentation for stats - in
    Documentation/ABI/testing/sysfs-class-net-statistics and the comments
    on struct rtnl_link_stats64 itself. While the former is very cautious
    in defining the expected behavior, the latter feel quite dated and
    may not be easy to understand for modern day driver author
    (e.g. rx_over_errors). At the same time modern systems are far more
    complex and once obvious definitions lost their clarity. For example
    - does rx_packet count at the MAC layer (aFramesReceivedOK)?
    packets processed correctly by hardware? received by the driver?
    or maybe received by the stack?
    
    I tried to clarify the expectations, further clarifications from
    others are very welcome.
    
    The part hardest to untangle is rx_over_errors vs rx_fifo_errors
    vs rx_missed_errors. After much deliberation I concluded that for
    modern HW only two of the counters will make sense. The distinction
    between internal FIFO overflow and packets dropped due to back-pressure
    from the host is likely too implementation (driver and device) specific
    to expose in the standard stats.
    
    Now - which two of those counters we select to use is anyone's pick:
    
    sysfs documentation suggests rx_over_errors counts packets which
    did not fit into buffers due to MTU being too small, which I reused.
    There don't seem to be many modern drivers using it (well, CAN drivers
    seem to love this statistic).
    
    Of the remaining two I picked rx_missed_errors to report device drops.
    bnxt reports it and it's folded into "drop"s in procfs (while
    rx_fifo_errors is an error, and modern devices usually receive the frame
    OK, they just can't admit it into the pipeline).
    
    Of the drivers I looked at only AMD Lance-like and NS8390-like use all
    three of these counters. rx_missed_errors counts missed frames,
    rx_over_errors counts overflow events, and rx_fifo_errors counts frames
    which were truncated because they didn't fit into buffers. This suggests
    that rx_fifo_errors may be the correct stat for truncated packets, but
    I'd think a FIFO stat counting truncated packets would be very confusing
    to a modern reader.

