Return-Path: <linux-rdma+bounces-4101-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BCC94131E
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 15:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE911F24A8D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD949194098;
	Tue, 30 Jul 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfpNHrFm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B51E86F
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jul 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346229; cv=none; b=pCfLTfGMlEI7hBbsdiaDIbCBYXkFL0M3+TFrUCL4gr0BBuHurgh9SuBIeTBF6PwDtkBrsNjGCdxj9muXWPmKmLVu0i/NVJYIY2BwzL4K3EuHBDVCGXbU/8vJwJh2iiLXyMwI0joq7P1ym5HkIB6mEwD2tVnHASxHu7Y3YZy5iZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346229; c=relaxed/simple;
	bh=gVicrh3jvYLnTMxXhgMab0yBqgqb1GZVpcr3RF8zNmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDg1keTwJxb/WhH4yEJivVFo1mShQAVMIfFNdLe9Av3vH3tDJyjPywzy5kfMsPYIetZFknVI2V4bCSxqcPazrn5G+ysJDSSqQhzM17A7Aezd54lx1uI2lgeaeAu31GqFvfNCe5UPN5L9tfX8LWsVGP5NTLswbW8UCCuAzXhTlVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfpNHrFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73829C32782;
	Tue, 30 Jul 2024 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722346229;
	bh=gVicrh3jvYLnTMxXhgMab0yBqgqb1GZVpcr3RF8zNmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfpNHrFmSwoijbxAsAiXMVVwOrH3xjozuYpjaB8VVARTQWRBy2tCHUWg/Vh/qSB/0
	 ThTlK+addcZpaHhPkRTkC6yI2DLGaYiksj7xaz1UuyJnuODl7WqoKm874o6I3yBcuG
	 KMbXy0/hzgIac4Rx2Q9LxSUnFR/Wye1qPRSEjfwLCrFyw7z7w8yqYvcMqA4MVTttua
	 3AJM0DHQcL6cBOupUuchkkwceqtUlRkGU7IR4AzJCLt4kwNwJH1WVsVKBXX1kNpEWY
	 Tx7A46cJK4kg1xbVgDoZ/Far7yr24cuRRIF9tldsRFxluHjDwdbaaWp8WEvT9QI5Du
	 RkqBKTlhd3Lpw==
Date: Tue, 30 Jul 2024 16:30:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Andrew Sheinberg <as1669@princeton.edu>
Cc: linux-rdma@vger.kernel.org
Subject: Re: Seeking Guidance: Creating an IBV Multicast Group?
Message-ID: <20240730133023.GC4209@unreal>
References: <1FF42574-65B2-493A-A779-D27F853063A7@princeton.edu>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1FF42574-65B2-493A-A779-D27F853063A7@princeton.edu>

On Mon, Jul 29, 2024 at 01:10:29PM -0400, Andrew Sheinberg wrote:
> Hello all,
> 
> I’m not sure if this the right place to ask, but I will give it a try.
> 
> I have a system with many initialized UD queue pairs (info for address handle creations and qp numbers exchanged out-of-band). I am only using libibverbs for establishment (purposefully not using librdmacm, to allow for more flexible environment configuration) — everything is working smoothly for unicast.  Now I would like to create a multicast group and attach some of these queue pairs (ibv_mcast_attach); however I am struggling to find any details on how to create such a group (and obtain a proper MGID and MLID). 

First call to ibv_attach_mcast() will create a new multicast group.

> 
> I found a few examples online but am left with questions:
> 	- There is code within perftest's "multicast_resources.c", but this seems a bit hacky and oddly verbose
> 	- There is code within Nvidia Docs’  "Programming Examples using IBV” showcasing joining an already created multicast group at a given IP address using rdma_cm, but It is unclear how to create the group in the first place
> 
> 
> Questions (please correct me if these do not make sense):
> 
> 1. What is the role of the OpenSM — is there a C API?

SM stands for subnet management and its goal to oversee fabric topology
and manage path routing among the nodes.

Thanks

