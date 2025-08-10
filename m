Return-Path: <linux-rdma+bounces-12657-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38321B1FC4C
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 23:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE52A16CC8A
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 21:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F15225760;
	Sun, 10 Aug 2025 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fhbLTKp0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082861C07C3;
	Sun, 10 Aug 2025 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860389; cv=none; b=ic7/eJNSLgpRzcdya1LeJcUR5HuXCQECW4S2/XyO03LHGG55XoV8LwRnea8gu7C5lkzpnco9YvHJ/kA23o7RfKYiThWhDwqSsAII3ZrZV/47kPfJKDYKt5fNtFnVAytbXe2xuxnTz+6hTCi4enbutko5BplM+sCwOaXb5DnUb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860389; c=relaxed/simple;
	bh=MCn7L2oMDXqpaBL68ifUAKfNI6ZgEO9AvUjGAwdqGzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHHwm0DHZfGyKSLrxYTczDbWJMB/8dkjgS5fjNlN6H7I13rLlaZ3716wIf7G2cQp4Y/f7UZf7FFoe9fsBWmSyVC9kkR8e1VTbkpQxW4Di8YjVWg+6FbksW/FpNekQTREI5gACmPl76KWVtmw6HY7PcrebPOn6y2FFRwDJPq/KSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fhbLTKp0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a08pxIKssvva7WGMOpdQs7q50iSGhijNpUjVdmBVafU=; b=fhbLTKp0cHKqEl0SQ3eao1jBUI
	U3VY98wdyOIDCYXjKKGLsw8r3dtC6OyQZ19VzOA4mJutCclYgT5mTevdbGCfVT5XFOElCLc+z4aBW
	liI0zxI5TPxQi9ChdMOb/RWDOXdeVQirMml2aP0ydzD89E3tKJ2L9G4JjGfzJo3gGa5+S1LQ6XJdc
	wCHfIGYv/GZsKMHuqGNuSiRTJ1YgaBzO/S2PM4wb+9vg5IJdXoICZxCGOIYy3rK96NzD/1TjgkGl9
	jjAk0rmXZSr499Fs074dnjGssHkUZJWAIUTUNSlc1F5u2AeoF8TYNKeHPCl7kT4QUNWviG9JC54fS
	qV7QEa0g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulDLi-0000000AWXo-29XN;
	Sun, 10 Aug 2025 21:13:02 +0000
Date: Sun, 10 Aug 2025 22:13:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, allison.henderson@oracle.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rds: Fix endian annotations across various
 assignments
Message-ID: <20250810211302.GQ222315@ZenIV>
References: <20250810171155.3263-1-ujwal.kundur@gmail.com>
 <20250810174705.GK222315@ZenIV>
 <20250810182506.GL222315@ZenIV>
 <398e53d8-906d-43c9-9395-f6115dcb945b@lunn.ch>
 <CALkFLLJkGqA7T5JhRQOs4spa+ihr-6RXA9xWwQRbRp6upLXBaw@mail.gmail.com>
 <20250810210058.GP222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810210058.GP222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Aug 10, 2025 at 10:00:58PM +0100, Al Viro wrote:
> On Mon, Aug 11, 2025 at 01:01:01AM +0530, Ujwal Kundur wrote:
> 
> > > It took me about 60 seconds to prove the POLLERR change was wrong, and
> > > i know nothing about this code base. So it is in fact not a lot of
> > > effort.
> > I looked up the definition of POLLERR on Elixir [1] and it seemed like
> > a valid Sparse report to me. I wasn't aware of EPOLLERR, and now
> > realize all the other operations are prefixed with EPOLL* in af_rds.c.
> > I look forward to reviews/critiques to learn from them but being
> > accused of using LLMs is kinda disheartening.
> 
> As for the POLLERR part of that, the thing about POLL* constants is that
> beyond the first 6 (IN/PRI/OUT/ERR/HUP/NVAL) they are arch-dependent,
> and not just in a sense of bit assignments.

> generic:
> IN  PRI  OUT  ERR  HUP  NVAL  RDNORM  RDBAND WRNORM  WRBAND  MSG  REMOVE  RDHUP
> 0   1    2    3    4    5     6       7      8       9       10   11      12
> sparc:
> 0   1    2    3    4    5     6       7      =OUT    8       9    10      11
> mips,m68k:
> 0   1    2    3    4    5     6       7      =OUT    8       10   11      13
> xtensa:
> 0   1    2    3    4    5     6       7      =OUT    8       10   11      12

Ugh...

My apologies - messed table above in the last two columns.

REMOVE is 10 for sparc, 11 for xtensa and 12 for everybody else.
RDHUP is 11 for sparc and 13 for everybody else.

generic:
IN  PRI  OUT  ERR  HUP  NVAL  RDNORM  RDBAND WRNORM  WRBAND  MSG  REMOVE  RDHUP
0   1    2    3    4    5     6       7      8       9       10   12      13
sparc:
0   1    2    3    4    5     6       7      =OUT    8       9    10      11
mips,m68k:
0   1    2    3    4    5     6       7      =OUT    8       10   12      13
xtensa:
0   1    2    3    4    5     6       7      =OUT    8       10   11      13

