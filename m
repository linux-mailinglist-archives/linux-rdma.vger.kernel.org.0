Return-Path: <linux-rdma+bounces-12650-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE33B1FBBC
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 20:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FB118947C9
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3281DC99C;
	Sun, 10 Aug 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="u249ab44"
X-Original-To: linux-rdma@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13DF18C02E;
	Sun, 10 Aug 2025 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754851141; cv=none; b=hsMHIiyuRfNiOKkb7btcXASLIR/FvZbL3mzBqLdirKPgRjP5rVsGFbyLdd0YcOHTn2cBTvRQlgSsw/qRt52NRHbnqlZP8akt01RXIwtebzp9oEz/wP20UWd5Ms2qWrO1l9BLffgNp6GlkL2jFws0Mp3t4ECLIjPcJDpKj7Vvexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754851141; c=relaxed/simple;
	bh=2pxIunrK+DIu9mz2KWuoD7aixDasG1+87XXLlBJTCB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcpy6fHbH53ogpUk01Lutc4WHKemnO4St7lZ3ugFAaD47Wl+dBUW2mhRIr4rFBJ/+HqKHE/us5tSAyJ0wraXD8A4TxwXNZHSQffN/d4l5kXrs8/PqSQb8fF0LFHmipOD+seBROgDKhcwmC4vbxbMW4ZrS1DacFb7Y3B0Z0P93gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=u249ab44; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yUMCa4w9svyioXQNttakOymn8yTglpKhtPu4rxJCdf4=; b=u249ab44Y270B/QR9Udm/NSXu7
	felKX52XlkUMh63R9nN/q1zEvLei2IL4aTKHsQwPRDh9ZGAAVZRSF7AOBJG5OMK6wbMXPDXZSzFrA
	0ljC1DUC9HZwXifugxlB1ho8N6vMHlB9hTmwTwnyM3xzjdatW28V33NQ1Vz+wcGs42AogdiASfmms
	u1QCIyL+B95MGVrSl4uTwYyIuanU699K45Mo/Rtu0DtT2CQtClfRIOVq6hXb2/YW3OqZaERU2rioO
	gzw/ifvjQrou5JM8Ge//NX/Ff1rzQK4X9Jf7aJ1LVxdwfr1ATXGEB+gmFi7fHVzPoZ4Dq+VkYmqP5
	8SYOnFhA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulAwZ-00000009RAX-2SN4;
	Sun, 10 Aug 2025 18:38:55 +0000
Date: Sun, 10 Aug 2025 19:38:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rds: Fix endian annotations across various
 assignments
Message-ID: <20250810183855.GN222315@ZenIV>
References: <20250810171155.3263-1-ujwal.kundur@gmail.com>
 <20250810174705.GK222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810174705.GK222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Aug 10, 2025 at 06:47:05PM +0100, Al Viro wrote:

> > diff --git a/net/rds/connection.c b/net/rds/connection.c
> > index d62f486ab29f..0047b76c3c0b 100644
> > --- a/net/rds/connection.c
> > +++ b/net/rds/connection.c
> > @@ -62,13 +62,13 @@ static struct hlist_head *rds_conn_bucket(const struct in6_addr *laddr,
> >  	net_get_random_once(&rds_hash_secret, sizeof(rds_hash_secret));
> >  	net_get_random_once(&rds6_hash_secret, sizeof(rds6_hash_secret));
> >  
> > -	lhash = (__force u32)laddr->s6_addr32[3];
> > +	lhash = (__force __u32)laddr->s6_addr32[3];
> >  #if IS_ENABLED(CONFIG_IPV6)
> >  	fhash = __ipv6_addr_jhash(faddr, rds6_hash_secret);
> >  #else
> > -	fhash = (__force u32)faddr->s6_addr32[3];
> > +	fhash = (__force __u32)(faddr->s6_addr32[3]);
> >  #endif
> > -	hash = __inet_ehashfn(lhash, 0, fhash, 0, rds_hash_secret);
> > +	hash = __inet_ehashfn((__force __be32)lhash, 0, (__force __be32)fhash, 0, rds_hash_secret);
> 
> what the...  You have lhash and fhash set to __be32 values, then
> feed them to function that expects __be32 argument.  Just turn
> these two variables into __be32 and lose the pointless casts.

FWIW, here you do have a missing cast -
	fhash = __ipv6_addr_jhash(faddr, rds6_hash_secret);
should be
	fhash = (__force __be32)__ipv6_addr_jhash(faddr, rds6_hash_secret);
With both fhash and lhash declared as __be32.

