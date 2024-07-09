Return-Path: <linux-rdma+bounces-3768-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD1292B9E2
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 14:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063432852F1
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 12:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF5215A843;
	Tue,  9 Jul 2024 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UavG2XuC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1A14F9E9;
	Tue,  9 Jul 2024 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529255; cv=none; b=FQ9r7juSOdETWGesHdIMvIoIV70IT0ioCZYAt8aSLePM1c8I+5gZPiuTWWMgTioA9rag1KxKdalF+jnF2eTx12Sk7QRuoxwn7ZzS0FNaswHmHQJfsYXGVLsL82dIRTYcjX3W9nU43pz9F8BlpQ3cSv1poBLwB4hEDOrsUhAdhYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529255; c=relaxed/simple;
	bh=kMEaRYq3F5vW2DfrUKcjrKB27TOAq/dT2dKCzGIKpA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBAX7qeRBhldzpG3GSHCh2mp+cxbzAB2KPBkMh1LKVTNnwDBmH5mnGcgcdQdDJuxAE4UvcxD7j9i6Apap957V3UK6+gmzhn5K/uazsZzmRU68IYNAMzqW8+NEeDX943795rsOVyenF9uQiryYz6cP9JYv63Qjewcdj6sJp6Gn+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UavG2XuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AE3C3277B;
	Tue,  9 Jul 2024 12:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720529254;
	bh=kMEaRYq3F5vW2DfrUKcjrKB27TOAq/dT2dKCzGIKpA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UavG2XuCrq7dd8xbcrI8m3wSL4ZeQTVW6lyD0YisZCs4fUjyJjfCKqQZiGRNXspg8
	 iUmDsjF5rPedHoVJz3nKZ44Z3m+PTsP7mqOjL8mSTlu4r8IknoEgazNtGsyT0jvPC0
	 nCBYarWp3Dqu/umwVDdeKgOtjeNu/4oea1YfdZnE1gsa+v/iQLr8pbjR4Ws66mOgM+
	 CLIpPxEkYRae/UGMuRnf+L+7i1kxzyCAGR3h+4OwbLNVzB5RuzLr6umx38wsSbKw6h
	 DYt3TF4wikk29NFbmBvKgQDCHS9YNY+qEP0G/AK+TLmPOm0xgvqHLPYawp44cl2rsW
	 kY4rmHx2N4/Vw==
Date: Tue, 9 Jul 2024 15:47:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240709124723.GE6668@unreal>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <2024070910-rumbling-unrigged-97ba@gregkh>
 <20240709122547.GC6668@unreal>
 <2024070933-commerce-duress-935a@gregkh>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024070933-commerce-duress-935a@gregkh>

On Tue, Jul 09, 2024 at 02:33:17PM +0200, Greg KH wrote:
> On Tue, Jul 09, 2024 at 03:25:47PM +0300, Leon Romanovsky wrote:
> > On Tue, Jul 09, 2024 at 12:01:06PM +0200, Greg KH wrote:
> > > On Mon, Jul 08, 2024 at 03:26:43PM -0700, Dan Williams wrote:
> > 
> > <...>
> > 
> > > > It sets common expectations for
> > > > device designers, distribution maintainers, and kernel developers. It is
> > > > complimentary to the Linux-command path for operations that need deeper
> > > > kernel coordination.
> > > 
> > > Yes, it's a good start, BUT by circumventing the network control plane,
> > > the network driver maintainers rightfully are worried about this as
> > > their review comments seem to be ignored here.  The rest of us
> > > maintainers can't ignore that objection, sorry.
> > 
> > Can you please point to the TECHNICAL review comments that were
> > presented and later ignored?
> 
> I can't remember review comments that were made yesterday, let alone
> months ago, sorry.

So I will summarize the situation for you. There are NO technical review
comments from netdev maintainer (not plural maintainers). The difference
is philosophical and not technical.

And yes, "rest of us maintainers" can ignore philosophical objections.
At the end, Linux kernel is distributed open-source project with
different people who have different opinions.

Thanks

> 
> greg k-h

