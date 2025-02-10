Return-Path: <linux-rdma+bounces-7623-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A504DA2EAB3
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 12:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535DA161CBD
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 11:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E536B1DC996;
	Mon, 10 Feb 2025 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNF7Nax0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A13189B80;
	Mon, 10 Feb 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185781; cv=none; b=t2TmOEUxss+u4T8GLapTp9+82TRnXCSuixKHFG9D1nXiI5S2So471Zg8HZ8X5lVB1FD3zddX+mJjl6+O4hqbjlJDCksGRFV9TTY4yt+CItTlMWeUk5KfWtzNie9YBx4tmXZSyJWO0eVVUzm/Bs3CAkn7YasR3nlsuD3i6lTYFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185781; c=relaxed/simple;
	bh=tdfBLbo2ufEVYX0IYmxEP5OjhHmRvkZtyjWgTNoblrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkzCQTJ9AW3oK9C7MyV5/sN1uLIJV8KDmArmWmaw9PP6E/kz2wlfCZ9dhQN7hOy2C2cr+XH2NjgtKrnRQ+khy+AAlNWoR/aZjVUZHTsiIShcrR6wQsyjCjVGzcvZBUv2RLvFlBae/9dfpbsne7YBqoTKyUY+838lsoSRSQNHJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNF7Nax0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD74C4CED1;
	Mon, 10 Feb 2025 11:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739185780;
	bh=tdfBLbo2ufEVYX0IYmxEP5OjhHmRvkZtyjWgTNoblrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNF7Nax03oWlEfNri2Tt3DxBonSlyZ20uduGAa1jJ12jz/OlKMn0kyHxnGEHWRjUT
	 kBGsjGcTAlxwTATifYPl05XyuF+kSVWs5mCMPymDzttrcRjIX+OSywThF1cGOAgNsY
	 SFe4S1PMrQZP36DoWsvRAbzmuvta5ZgOLpA8gR55221UJ2flx/WQRrXzHJTEdz/aqz
	 98gX2QvrowQZVr8ZMnvIUN4PGmhO5NsRZ83i9lJRQegK1jbEEPRFvxUpBoE6ek5Hbv
	 zMOCkw0YLJc6F6V2RuoaZvMe3QKOYvJEvZwCJkRskLSqujPVdU3quDycpIgtVRArxa
	 OyP3UbFFMAnHA==
Date: Mon, 10 Feb 2025 13:09:35 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tatyana Nikolova <tatyana.e.nikolova@intel.com>, jgg@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [iwl-next,rdma v3 00/24] Add RDMA support for Intel IPU E2000
 (GEN3)
Message-ID: <20250210110935.GE17863@unreal>
References: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
 <7e12c97d-8733-44df-b80e-2956c0e59dae@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e12c97d-8733-44df-b80e-2956c0e59dae@intel.com>

On Mon, Feb 10, 2025 at 11:41:31AM +0100, Przemek Kitszel wrote:
> On 2/7/25 20:49, Tatyana Nikolova wrote:
> > This patch series is based on 6.14-rc1 and includes both netdev and RDMA
> > patches for ease of review. It can also be viewed here [1]. A shared pull
> > request will be sent for patches 1-7 following review.
> > 
> 
> [...]
> TLDR of my mail: could be take 1st patch prior to the rest?
> 
> > V2 RFC series is at https://lwn.net/Articles/987141/.
> 
> code there was mostly the same, and noone commented, I bet due
> to the sheer size of the series

It was very optimistic to expect for a review during holiday season
and merge window, especially series of 25 patches which are marked
as RFC.

Thanks

