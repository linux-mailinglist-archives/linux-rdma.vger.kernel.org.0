Return-Path: <linux-rdma+bounces-14103-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 286D8C14A38
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 13:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 792CF4FD7D8
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA7832D450;
	Tue, 28 Oct 2025 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqhYqjzw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B571D5147;
	Tue, 28 Oct 2025 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654668; cv=none; b=WQvYjKB4+7G+zt68kqbMd07gM6Vxc1W5792Ih3bzfYn0umJIF4MQI6clBv4MhPEoVvi9GJ8otmOmUNY3NlrAYf4tRifdnO+WPAZ3VPPYYYldIhIigoYSu3LKXDPN4ClLTUv9twZX3qvmIkNmKeHTG/TIprOA9FbxtMInYNYrnbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654668; c=relaxed/simple;
	bh=bp3dDj7WuCgUaozIZmBCOLT7S6dPjUy422kqru/krws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbbIPw4B/Ur6oOx/5IKKXZ0jr/nB8+RIBo6TKHxm/LWwAWsDnB6DvkZq+pzcUedHZaSjOVMIPWoizuRsb7xhkSPWKZkrCWQo9USXjOG+PSUDKgAKYOD1a0EWBDiqShvySQ789bHFmGR/07Z7KQtYwJtCfL/KFkadpp47MATrVqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqhYqjzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6128C4CEE7;
	Tue, 28 Oct 2025 12:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761654666;
	bh=bp3dDj7WuCgUaozIZmBCOLT7S6dPjUy422kqru/krws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqhYqjzwPAqrvZy+5lthpH7b+sHTqLCG3GPCT/sK1zBLYshcGv57uRgmwywUHvEdX
	 5sammRMOG23AlLMM3m0AoRRBpwJzKvJTbbRvUZisAp5DIbueJkQihcWM2VNHu57inM
	 Nwe3yv15/0dAqcafexYvDx5JQ0E8K2/tGy3Zq4ms5TpUD+f3cmWp4yq4fRl8JEftc2
	 K38c+XOVnKgfP2WIR2lL6T8MwvZOFhggFN89K/3iqug0c4Cbr8fxrVlyITjJwc2Df3
	 8gnyzGdDeL26rlulVbiCkl+WSVo8gy8Axggq0M4PIa29tIOI1Db6pk6n1GJeX+llBf
	 leMHOZuTLRwLw==
Date: Tue, 28 Oct 2025 14:31:01 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: mjambigi@linux.ibm.com, wenjia@linux.ibm.com, wintera@linux.ibm.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	sidraya@linux.ibm.com, jaka@linux.ibm.com
Subject: Re: [PATCH net-next v2] net/smc: add full IPv6 support for SMC
Message-ID: <20251028123101.GR12554@unreal>
References: <20251022032309.66386-1-alibuda@linux.alibaba.com>
 <20251027134227.GL12554@unreal>
 <20251028095450.GA38488@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028095450.GA38488@j66a10360.sqa.eu95>

On Tue, Oct 28, 2025 at 05:54:50PM +0800, D. Wythe wrote:
> On Mon, Oct 27, 2025 at 03:42:27PM +0200, Leon Romanovsky wrote:
> > On Wed, Oct 22, 2025 at 11:23:09AM +0800, D. Wythe wrote:
> > > The current SMC implementation is IPv4-centric. While it contains a
> > > workaround for IPv4-mapped IPv6 addresses, it lacks a functional path
> > > for native IPv6, preventing its use in modern dual-stack or IPv6-only
> > > networks.
> > > 
> > > This patch introduces full, native IPv6 support by refactoring the
> > > address handling mechanism to be IP-version agnostic, which is
> > > achieved by:
> > > 
> > > - Introducing a generic `struct smc_ipaddr` to abstract IP addresses.
> > > - Implementing an IPv6-specific route lookup function.
> > > - Extend GID matching logic for both IPv4 and IPv6 addresses
> > > 
> > > With these changes, SMC can now discover RDMA devices and establish
> > > connections over both native IPv4 and IPv6 networks.
> > 
> > Why can't you use rdma-cm in-kernel API like any other in-kernel RDMA consumers?
> > 
> > Thanks
> > 
> > >
> 
> Hi Leon,
> 
> Regarding RDMA-CM, I’m not sure if I’ve fully grasped your point, but
> based on my current understanding, I believe SMC cannot use RDMA-CM.
> There are a few reasons for this:
> 
> Firstly, SMC is designed to work not only with RDMA devices but also
> needs to negotiate with DIBS(DIRECT INTERNAL BUFFER SHARING) devices. This
> means we must support scenarios where no RDMA device is present.
> Therefore, we require a round of out-of-band negotiation regardless of
> the final device choice. In this context, even if we ultimately select
> an RDMA device, using rdma-cm to establish the connection would be
> redundant.

Ahh, yes, I always failed to remember this.

Thanks

> 
> Additionally, SMC requires multiplexing multiple connections over a
> single QP. We need to decide during the out-of-band negotiation which
> specific QP to reuse for the connection. From what I know, rdma-cm does
> not seem to offer this capability either.
> 
> Best regards,
> D. Wythe
> 

