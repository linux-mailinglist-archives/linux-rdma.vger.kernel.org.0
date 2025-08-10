Return-Path: <linux-rdma+bounces-12654-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36604B1FC08
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 22:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B578E3B653D
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 20:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09484204C0F;
	Sun, 10 Aug 2025 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Kh2r8tUm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68BB8BEE;
	Sun, 10 Aug 2025 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754857210; cv=none; b=n6ErP8dnHYesCj2Vphjgr8+59MbYoVhlXo2k0Yvs0H/iBl67I6Cl+vDFFtzcpk3QVGJQoAYac+Cs4aynfJdWkx47yAT3QrOSz3CmP4muGxJHEmtCSD6c78+YekSpcYQlnRim4VAiJHp6S77JdCPmaqh4PpcoTNdx6inKO8m8ZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754857210; c=relaxed/simple;
	bh=SK29jn8R4xzXjx47k/Sx2ahNb2fhc75hy8aTdP+6uoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzQncwnmp2x73kTQmu48tDQJMvCGUm0Yl4+L0pj7BgkB1vI/CSZ+63m0MXNiV2k27onAVCiIR9sxi/dc6yzznwR3h7rSzWbOV7SsT8QSkz9IW3mQW1JLaEWi4GdCcpYmOVoBM+X1QZUONb88gGkAbNNWLIPev8gGYke6EPQ+bB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Kh2r8tUm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9cKmtYSJg+15Z48bvfUgF0NQCiMXEeRkyLjdINLRnFw=; b=Kh2r8tUmvEQ9eRfd3ewTh8Fxoq
	jtLnwQZue+mPg6caqN/u3iBJGPHwkAYDe2MClpP2G6/ZkmSVLhc8AbbRx96fwnzO6uiA6qJxo5UlG
	4R+vt3H2l2r99qLo4oFhJPNQNvqv8FnzP08W1aP0g9hJ8ZLB15cl5LVXYFDa3p6DPrIE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ulCWI-004FH4-HI; Sun, 10 Aug 2025 22:19:54 +0200
Date: Sun, 10 Aug 2025 22:19:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, allison.henderson@oracle.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rds: Fix endian annotations across various
 assignments
Message-ID: <63a22c3c-ee9b-44cd-9e5a-a68bb366eba5@lunn.ch>
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

> > This smells of an LLM generated patch. So i think you are somewhat
> > wasting your time explaining in detail why this is wrong.
> I have never used (and will not use) LLMs :(

Sorry, I need to refine my sense of smell.

> P.S: I'm still learning the ropes as a contributor so please pardon my
> ignorance.

You might find this interesting:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You made a few process errors as well. Since you submitted this to
net, it needs a Fixes: tag.

Also:

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Particularly:

	It must either fix a real bug that bothers people

Sparse warnings don't really both people. But is the sparse warning
indicating a read bug which does bother people? If so, net is O.K, but
please add to the commit message what the real bug is. If this is
simply cleanup, not a bug fix, please submit to net-next.

You can also learn a lot by subscribing to the netdev mailing list,
and reading other peoples patches, and review comments they get.

	Andrew

