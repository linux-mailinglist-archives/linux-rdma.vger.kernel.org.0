Return-Path: <linux-rdma+bounces-12656-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116FFB1FC17
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 23:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A43C3B907E
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 21:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E42D1D63E6;
	Sun, 10 Aug 2025 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mSKUn34r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25587566A;
	Sun, 10 Aug 2025 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754859666; cv=none; b=dfobalpdhHeg2/ta4O4i1aoCt7HVacJeLkNux6R5Xbvua4IM6AuWVA3BLNMMk4XGtx6o0++QxKsWLhNmU+KSzH/F0J7F32k84QR5AyaQSh0nH7gF08PatW1DXSZLAO8B1INagXlfLjSUMD+pBznrdRB4gppC6Fa2T1QkQPSKe3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754859666; c=relaxed/simple;
	bh=yPgCWX0SZqHIDGQdOpoYaYeM5jk995xjQprYk5t9kr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2cokWLhPPgw7qze9mjAS3ro1/wtWxS9mr5Lcww+xhU1+x0WS2b4eTOHlMW5P7B6ksawMPTYGqF6DWnhzv2ZGO9s6ZBgif26wO6NCsp46E/RDKZYvI2+wmjtkjxFvqoc05IIxPglQs0vtp1iEthogYiZriPTAI0xhNZCYYuq77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mSKUn34r; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=54R4LBaY4oClfMegkcQ+5wWDmu5/CubLOOyqTT0D1RU=; b=mSKUn34rvWD1ghDNgBeSe+jkjN
	IMOgGI3NmULa4l4DqqNTQR5BisBRsGmhm52zvFGX6oqdBDhlf1E7kl+5GRsJ4zVMH1I3xHVvr9P8D
	sEf6XtxxBKPTcdldMfVE+l8fBjFlgsJvQOLaxGBhnI5fe5bzdIl8eKeKZ1VzixirE8RDVSnL/1CU3
	UwWr3Ham6Aj9+JO0oml31YYEJhu+UDZo/O3JOK76Se6UhciGIvOx7ZrU1ZTicTtdq07WpJ0E7WY/t
	GeEDBsvekme45hPltXIkN2bZ05zAL4K2ZwYdF51wNJ64epDIn078BgXB2KGrMuQxCQA53JlJnlMn1
	8KtINZqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulDA2-0000000ASXK-2Y26;
	Sun, 10 Aug 2025 21:00:58 +0000
Date: Sun, 10 Aug 2025 22:00:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, allison.henderson@oracle.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rds: Fix endian annotations across various
 assignments
Message-ID: <20250810210058.GP222315@ZenIV>
References: <20250810171155.3263-1-ujwal.kundur@gmail.com>
 <20250810174705.GK222315@ZenIV>
 <20250810182506.GL222315@ZenIV>
 <398e53d8-906d-43c9-9395-f6115dcb945b@lunn.ch>
 <CALkFLLJkGqA7T5JhRQOs4spa+ihr-6RXA9xWwQRbRp6upLXBaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALkFLLJkGqA7T5JhRQOs4spa+ihr-6RXA9xWwQRbRp6upLXBaw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 11, 2025 at 01:01:01AM +0530, Ujwal Kundur wrote:

> > It took me about 60 seconds to prove the POLLERR change was wrong, and
> > i know nothing about this code base. So it is in fact not a lot of
> > effort.
> I looked up the definition of POLLERR on Elixir [1] and it seemed like
> a valid Sparse report to me. I wasn't aware of EPOLLERR, and now
> realize all the other operations are prefixed with EPOLL* in af_rds.c.
> I look forward to reviews/critiques to learn from them but being
> accused of using LLMs is kinda disheartening.

As for the POLLERR part of that, the thing about POLL* constants is that
beyond the first 6 (IN/PRI/OUT/ERR/HUP/NVAL) they are arch-dependent,
and not just in a sense of bit assignments.

generic:
IN  PRI  OUT  ERR  HUP  NVAL  RDNORM  RDBAND WRNORM  WRBAND  MSG  REMOVE  RDHUP
0   1    2    3    4    5     6       7      8       9       10   11      12
sparc:
0   1    2    3    4    5     6       7      =OUT    8       9    10      11
mips,m68k:
0   1    2    3    4    5     6       7      =OUT    8       10   11      12
xtensa:
0   1    2    3    4    5     6       7      =OUT    8       10   13      12

So these get mapped from/to by poll(2) (mangle_poll() and demangle_poll()
resp.) and __poll_t serves as a tool for catching the places that might
be confused.  The internal values (also used by eventpoll(2)) are

0   1    2    3    4    5     6       7      8       9       10   ---     12

POLLREMOVE is Solaris-only thing and we do not even attempt to implement
it.  So's POLLMSG, but there's a bit of a twist - nobody ever returns
that shit from ->poll(), but SIGIO from dnotify and from lease breaking
comes with ->si_band in siginfo set to POLLIN|POLLRDNORM|POLLMSG;

Warning about __poll_t is usually "mixing POLL... and EPOLL... is a bad idea".
Here it's not a bug (note that ERR gets the same bit in all of the above),
but it's trivial to annotate properly...

