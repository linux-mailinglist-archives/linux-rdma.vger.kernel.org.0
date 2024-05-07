Return-Path: <linux-rdma+bounces-2315-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60F18BE0FE
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 13:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CD81F25298
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 11:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D13152176;
	Tue,  7 May 2024 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1mNa/gE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF385522E;
	Tue,  7 May 2024 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715081254; cv=none; b=hmwgDV92LoVio/W2vfHHeVxs6SDlZOXW0e1qCsHzeD59kbILRaedNBm/dXxvIYlg0F4p6Zs1u2jjAn2dP0i6ejx7npb/FXNf0OwZQgAWHlDuRtbdDXMJG7jcMRltr1QKs4VYImhYJXenCYioNatM+B2HxzaCEm4jj+HEwIpC+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715081254; c=relaxed/simple;
	bh=WEWSfC7Gz68oRoxYdd0juQwDeu8SJZ34kb6UowW7I4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkVZPfRpzJS1QYAgChxqjMw79qOTlVNHHq9sZW5uy+UhbNw1D9SSc9HV8rbmboFVKFuAOjiLHq1OgwKg1csfjtWuV/TtTFgHb8PYVBbMeyjVbkWqukfyKTZx8xtttxgND/tNEuzohUoMYeEoSzrDOi/m/zlU+7HuGUKokQ06YCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1mNa/gE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5996C2BBFC;
	Tue,  7 May 2024 11:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715081254;
	bh=WEWSfC7Gz68oRoxYdd0juQwDeu8SJZ34kb6UowW7I4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W1mNa/gEJRNnSYVxqWNeMNcuHewFBzYLzV+U7JfasQNSJwcqalT67aUeY+B3hXv5C
	 u3cDQ2zl9k9Vkf0S9oTMOsP7e+zPsb6Lx/o61Tbi17u6Z1YXUmESc5OjV6IsttRTSd
	 OucVltt3jSFzxe6+cYrsIOEUjaitvlXTegKj0rkptNNQiiCKZa04l3xP/ZyW+7nXRB
	 ZiukhZddb0HCstkzkRen4TBVTDK4fPPpaxLg6yr/3hy2RJyx4Bd4jhC2tV0+fOTzUE
	 qWvx6/PPsuDMMJgtK2Gdn0kG7z1OqxGy8/S8hxkKcjElYX+RUl/7zLq78VMpPSaECJ
	 0iJaaxfVJCyyA==
Date: Tue, 7 May 2024 14:27:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Brian Baboch <brian.baboch@gmail.com>
Cc: linux-rdma@vger.kernel.org, stable@vger.kernel.org,
	florent.fourcot@wifirst.fr, brian.baboch@wifirst.fr
Subject: Re: Excessive memory usage when infiniband config is enabled
Message-ID: <20240507112730.GB78961@unreal>
References: <2b4f7f6e-9fe5-43a4-b62e-6e42be67d1d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b4f7f6e-9fe5-43a4-b62e-6e42be67d1d9@gmail.com>

On Mon, May 06, 2024 at 05:15:55PM +0200, Brian Baboch wrote:
> Hello,
> 
> 
> We discovered that the CONFIG_INFINIBAND_IRDMA configuration option in the
> linux kernel is causing excessive memory usage on idle mode on specific
> servers like the DELL VEP4600
> (https://www.dell.com/en-us/shop/ipovw/virtual-edge-platform-4600.
> 
> By default we were using Debian's linux-image-6.1.0-13-amd64 which is the
> stable 6.1.55-1 amd64, we then compiled the kernel again with the same
> config file from the stable 6.1.55 tag and had the same problem. We were
> able to resolve the memory problem by removing the `CONFIG_INFINIBAND_IRDMA`
> option from the kernel config.
> 
> The tag used to reproduce the problem is v6.1.55.
> adding the following config `CONFIG_INFINIBAND_IRDMA=m` causes the excessive
> memory usage to go from 1.4Gb to 7Gb.

Hi Brian,

Why do you think that this is a bug?
DELL VEP4600 supports RDMA, so by enabling CONFIG_INFINIBAND_IRDMA, you
compiled RDMA support for Intel NIC.
https://dl.dell.com/topicspdf/vep4600_tech_guide_en-us.pdf

You can unload irdma.ko module and restore memory footprint.

Thanks

