Return-Path: <linux-rdma+bounces-12651-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E196CB1FBBF
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 20:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F98178696
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 18:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5C91EBFE0;
	Sun, 10 Aug 2025 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a2CzljAQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155554207F;
	Sun, 10 Aug 2025 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754851326; cv=none; b=cjVCfNF6mrtjlDEMhFR5JQhLyKOaGfvsywaiOIub/y0xYGfe4SgHbYJwbDfOf9YviTj2WexxYs9Fmd6rTCs3AZscHiK/QFhLlKKqwo8Gu8yrUR+q2Y9bwtXdfKaz41FbpUpXTiJ5A+2B2mRZl4+NqXNQSMiF8zvvPF1pxCE7bZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754851326; c=relaxed/simple;
	bh=05OoLgUjm/sMyOkks4qo5633SwLMiUfps9/2r5+sQ28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmaLEFh4NcCG1HCXVMwzqdTXtok2xmykkPuPN2qtiaRQf3V14NCik3oPzKlP08XhNIPjq/5/OzD9G5b/NTI8NQwdjc0qvathmKvjJexVqc17GCehe53QiSjYlKJtCWB80Rld3u+yMpYIaGk94PzbLPAxurRjtnbluYlNEUb6KBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a2CzljAQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g+qKixqydqMdWcsT1LeozLR85ueaNxYxHtBFcJr9SNw=; b=a2CzljAQQkwhYARpXv9KoMdu9s
	k2dGfVfoeLeQv/UrAvJEZPkw7koOVoIf+U6TPST6ydqIQgfxmHjG+k0e3jL4YD1RdV/WmeNFvyGWw
	0bjOKkjfO5iGlrL5714zIMdTw788l2kKb+e4nto807v/P7Z1zVIes7fxOrRDBKy6U84Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ulAzN-004Ev7-7R; Sun, 10 Aug 2025 20:41:49 +0200
Date: Sun, 10 Aug 2025 20:41:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ujwal Kundur <ujwal.kundur@gmail.com>, allison.henderson@oracle.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rds: Fix endian annotations across various
 assignments
Message-ID: <398e53d8-906d-43c9-9395-f6115dcb945b@lunn.ch>
References: <20250810171155.3263-1-ujwal.kundur@gmail.com>
 <20250810174705.GK222315@ZenIV>
 <20250810182506.GL222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810182506.GL222315@ZenIV>

On Sun, Aug 10, 2025 at 07:25:06PM +0100, Al Viro wrote:
> On Sun, Aug 10, 2025 at 06:47:05PM +0100, Al Viro wrote:
> 
> > >  		switch (type) {
> > >  		case RDS_EXTHDR_NPATHS:
> > >  			conn->c_npaths = min_t(int, RDS_MPATH_WORKERS,
> > > -					       be16_to_cpu(buffer.rds_npaths));
> > > +					      (__force __u16)buffer.rds_npaths);
> > 
> > No.  It will break on little-endian.  That's over-the-wire data you are
> > dealing with; it's *NOT* going to be host-endian.  Fix the buggered
> > annotations instead.
> 
> PS: be16_to_cpu() is not the same thing as a cast.  On a big-endian box,
> a 16bit number 1000 (0x3e8) is stored as {3, 0xe8}; on a little-endian it's
> {3, 0xe8} instead; {0xe8, 3} means 59395 there (0xe8 * 256 + 3).

Hi Al

This smells of an LLM generated patch. So i think you are somewhat
wasting your time explaining in detail why this is wrong. Well, maybe
in a few generations of LLM it might learn from what you said, but
that does not address the immediate problem.

We need developers using LLM to accept they have often wrong, and you
need to spend time and effort:

1) Proving it got is wrong.
2) That after a lot of effort, failing to prove it wrong, accept it might be right.
3) Proving it actually got it right.

It took me about 60 seconds to prove the POLLERR change was wrong, and
i know nothing about this code base. So it is in fact not a lot of
effort.

	Andrew

