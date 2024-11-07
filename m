Return-Path: <linux-rdma+bounces-5835-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E619C055F
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 13:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8887B24061
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 12:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B74320F5D7;
	Thu,  7 Nov 2024 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ67g59N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217301EF0A2;
	Thu,  7 Nov 2024 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981336; cv=none; b=uM8XIV84iF8PFcbLUXL4Vd3BPmcCzUnJlsyvPLvf8s+reEeKNxduHsZZwjM+LuM2qFcpoZCAe8FCL3/HRus2CNL5Z6vm5wIdeBqAfabnSVFAP0DMhz1Ah30smpzhFeN/VmEBxRIoY5prKYu0wB1GAW/J4intYbhc9Qwunvpugdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981336; c=relaxed/simple;
	bh=hmPkW9uhUlwVuQ8iJ/Kc8oa8R0ZnGAZKdsEl5ELReWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkRZbGfl7YfJEdBXOhVwjammxEkgYPRw24akjUoq3LtZkGMOxY2WNBuOpWV6ViEgJwsualvttaYGPl73/Jm0I22qKg+P901msP4X5qO1fb61ouVvz1PfCP2ThyAE17YAPMETgAx2VXbbeJmKo7D5ZCxxp7xmd+mX/0xEOEwfAjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ67g59N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E9CC4CECC;
	Thu,  7 Nov 2024 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730981335;
	bh=hmPkW9uhUlwVuQ8iJ/Kc8oa8R0ZnGAZKdsEl5ELReWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZ67g59NqXm9Yt6UeuueRSWLT6e6G9NDmOYVoXZ8LnoIwuPLckcrNpPybl8hvqC+b
	 VAMJ47gvKl12JhvRRfUGf8QJEonlxosc7e9H9vX2mBW0KAXmVZLzLjaHMhoCoL5E7z
	 pEeOw9NhBudEAWZUgHQUrrsRrpZ85cDZFEQe5aBWjHC7cWtBFQgPb/hJeK3g36LlsD
	 X/+GBYbXEZrqINcXc/hiOt6kv92Bigv6ndQuikNrXE5aCR8hjOzeg4bO2N0NqCSrcx
	 Z2ST9jKShs586s3QAuY7CcPqlzD7K/Jfx1kbJPgijtZAtw494J1CVw8Idcp1VUqC8E
	 9poyPkCEnNiDQ==
Date: Thu, 7 Nov 2024 14:08:48 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
Message-ID: <20241107120848.GM5006@unreal>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
 <20241027201857.GA1615717@unreal>
 <8d17b403-aefa-4f36-a913-7ace41cf2551@linux.ibm.com>
 <20241105112313.GE311159@unreal>
 <20241106102439.4ca5effc.pasic@linux.ibm.com>
 <20241106135910.GF5006@unreal>
 <20241107124711.2e9e7e8f.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107124711.2e9e7e8f.pasic@linux.ibm.com>

On Thu, Nov 07, 2024 at 12:47:11PM +0100, Halil Pasic wrote:
> On Wed, 6 Nov 2024 15:59:10 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > > I absolutely agree with that statement. But please notice that the
> > > commit date of commit c2261dd76b54 ("RDMA/device: Add
> > > ib_device_set_netdev() as an alternative to get_netdev") predates the
> > > commit date of commit 54903572c23c ("net/smc: allow pnetid-less
> > > configuration") only by 9 days. And before commit c2261dd76b54
> > > ("RDMA/device: Add ib_device_set_netdev() as an alternative to
> > > get_netdev") there was no 
> > > ib_device_get_netdev() AFAICT.  
> > 
> > It doesn't make it right.
> 
> I agree!
> > 
> > 1. While commit c2261dd76b54 was submitted and discussed, RDMA was not
> > CCed.
> 
> Would the RDMA community agree with adding 
> L:	linux-rdma@vger.kernel.org
> to the "SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS" section of the
> MAINTAINERS file, so that get_maintainer.pl tells contributors to cc
> RDMA?

Yes, of course. We always curious to see how our in-kernel API works and
if it needs adjustments rather than ULP hacks to overcome its limitations.

> 
> In my personal opinion SMC would have benefited greatly from review by
> the RDMA community, and this is not the first time where the RDMA
> community was not included where it should have been.

Jakub pushes SMC authors to CC RDMA, which is great, but it wasn't in
the past and your idea of adding new entry to MAINTAINERS file will
help.

>  
> > 2. Author didn't try to add his version of ib_device_get_netdev() as it
> > is done for all APIs exposed by RDMA core.
> 
> I understand now that direct access to ops callbacks is off limits for
> ULPs. I'm not sure I understand all the details, but I hope I don't have
> to.
> 
> Regards,
> Halil

