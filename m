Return-Path: <linux-rdma+bounces-3362-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCBD9106BA
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 15:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8671C21920
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DCF1AD491;
	Thu, 20 Jun 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCq4pkoJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5F21AD3E7;
	Thu, 20 Jun 2024 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891497; cv=none; b=Mj1ORTHw+3W/CEz5JdVSWOd8QIXK6oVAmv0/6bDj5SxBd0fVjWqY5Z88DeiWuGVyyg4+TLrPCG3xEpxaYIs9AneCSt+5T2hoEuewMVPcPKqW19jxR1DovQtEBg1JVK8R1dHHbJRsQBTzOnCKNV58AyoXV0McE/PHqRtjoox+sYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891497; c=relaxed/simple;
	bh=NoN0yBxHD8GgnNnA8qv/Z0+nJZMr5eqvtKZvmOt/ABI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVOEVp7IZZc5taYpgoZn2yBatFlj+l8LaplFuumGI3Xrfasuy7o+Jy/TgFqs7EJXFNVxIRsS73o6rT920MnDS+fSlLc5L4GZwL7E7KdXUfXDfB6Lt9GQ5Tz1qNTeaM/JfWJdmKgEkTwhpu9qLTzzdlLi/L4tpi0xhoimb3tYRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCq4pkoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D39EC2BD10;
	Thu, 20 Jun 2024 13:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718891496;
	bh=NoN0yBxHD8GgnNnA8qv/Z0+nJZMr5eqvtKZvmOt/ABI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kCq4pkoJZO69wd4/U392ee7h74fLDIx6Ix0wMuYmhNF3a9+w6iKiYwEVm8xZkP1CN
	 R2rgkhL4KFMGTEaqe51/iokDg91nv2rWZZGVRVPPeAf0SU9AJCLyHW+Kucasqp+UZt
	 dLMdpFWewiPgWYEsp71JXGk7fP6uNIMyD4zvDLIM4JW6AVUMir2T3Or8fJmsKpiIl/
	 tHWk/k/wXILWTvP0WXK/gVawf2nbBO2GTgs+foEU09q7yzgs7diw+yu0PjC5Emk02Z
	 MpTPeYLryy6izNy/qtERVsw7pZYGosTEc4oRrtI6zEXYXmaVIgE4MUTT4E3weTpl4K
	 Ql+voDn8Q0UMg==
Date: Thu, 20 Jun 2024 06:51:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Andrew Lunn <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "ogabbay@kernel.org"
 <ogabbay@kernel.org>, Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 09/15] net: hbl_en: add habanalabs Ethernet driver
Message-ID: <20240620065135.116d8edf@kernel.org>
In-Reply-To: <5cb11774-a710-4edc-a55c-c529b0114ca4@habana.ai>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
	<20240613082208.1439968-10-oshpigelman@habana.ai>
	<10902044-fb02-4328-bf88-0b386ee51c78@lunn.ch>
	<bddb69c3-511b-4385-a67d-903e910a8b51@habana.ai>
	<621d4891-36d7-48c6-bdd8-2f3ca06a23f6@lunn.ch>
	<45e35940-c8fc-4f6c-8429-e6681a48b889@habana.ai>
	<20240619082104.2dcdcd86@kernel.org>
	<5cb11774-a710-4edc-a55c-c529b0114ca4@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 08:43:34 +0000 Omer Shpigelman wrote:
> > You support 400G, you really need to give the user the ability
> > to access higher pages.  
> 
> Actually the 200G and 400G modes in the ethtool code should be removed
> from this patch set. They are not relevant for Gaudi2. I'll fix it in the
> next version.

How do your customers / users check SFP diagnostics?

