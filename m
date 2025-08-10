Return-Path: <linux-rdma+bounces-12648-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972F5B1FBA7
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 20:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984AE176D1C
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 18:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DA426B95B;
	Sun, 10 Aug 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fIaNi4tQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0611B3930;
	Sun, 10 Aug 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754850315; cv=none; b=ZbPp5hngAi249uC/NwCFSoZM6BI2tKNECnxPsf2ERVU3GXPIW1AzPv1SIo71zQfb/cqv7nLBL6C/0Qb3Vm6D4eFgRBQ0/ghykFotD/pwLs+clRfBZvszzKGWMO0B2QIhUDsdxFTz/VT5iNB5mFRi0hs4UuBjKLSxanJGFuEBOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754850315; c=relaxed/simple;
	bh=TyvCHPY9P3lMRaF6lSp0JQKuHHe/JAv74uMi9eYnFm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKV/cdVBelHt3i/X7BXQv9ZB2Cy6NGFGuidBXYG9ValBwlmDUBcr5NuBVhz3jUR/oL3RCPZwwG8YnBUdmd9zQkEQelqFwF9Vls7PJLhly/zgIajL13W6zXG3+Y9v5AoZFGLNHTyvasT+iAHP41Jc79HEwGDpAQUjDjrdT67lC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fIaNi4tQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tmF4w1SpmzwBXdBcTEr+W1a6c89LE5d+jxlzQIeWzEY=; b=fIaNi4tQOldJ6q8G6UTrNYayA4
	i4C1TYPv8fk4I4rzyGjacsUA8/dNh8D/i80DPZu7pkdH1DdWe9RE3XNZ8sBEITQk9mkHxCPI9Dfew
	qTa+M26dKGI9/6v2Ye8wVMNcKNKqUoYFZd8eTWRgK7qnm9BFuRH8IUwuyHCn7aEEL+AI0ODO0zgFC
	7WpsAzkCkuuzkhE84qXwfI67+/zQj9RbPlnxSK/8hX3hMUjBCSBtiHFi5PDLQkjt5N2rSYuhHE/fD
	F8iiXzySp64WerkMRpeV+PPqzw+QAqXhzXT5m8IbWpXu8ir6z3TXtWSz8WxUcOEY5Oe0ysiAFPUf9
	3nISP7Xw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulAjC-00000009Kir-2Ztg;
	Sun, 10 Aug 2025 18:25:06 +0000
Date: Sun, 10 Aug 2025 19:25:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rds: Fix endian annotations across various
 assignments
Message-ID: <20250810182506.GL222315@ZenIV>
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

> >  		switch (type) {
> >  		case RDS_EXTHDR_NPATHS:
> >  			conn->c_npaths = min_t(int, RDS_MPATH_WORKERS,
> > -					       be16_to_cpu(buffer.rds_npaths));
> > +					      (__force __u16)buffer.rds_npaths);
> 
> No.  It will break on little-endian.  That's over-the-wire data you are
> dealing with; it's *NOT* going to be host-endian.  Fix the buggered
> annotations instead.

PS: be16_to_cpu() is not the same thing as a cast.  On a big-endian box,
a 16bit number 1000 (0x3e8) is stored as {3, 0xe8}; on a little-endian it's
{3, 0xe8} instead; {0xe8, 3} means 59395 there (0xe8 * 256 + 3).

be16_to_cpu() is a no-op on big-endian; on little-endian it converts the
big-endian 16bit to host-endian (internally it's a byteswap).

If over-the-wire data is stored in big-endian order (bits 8..15 in the
first byte, bits 0..7 in the second one) and you want to do any kind
of arithmetics with the value you've received, you can't blindly treat
it as u16 (unsigned short) field of structure - on big-endian boxen
it would work, but on little-endian it would give the wrong values
(59395 when sender had meant 1000).  be16_to_cpu() adjusts for that.

In the above, you have ->c_npaths definitely used as a number - this
net/rds/connection.c:924:       } while (++i < conn->c_npaths);
alone is enough to be convincing.  All other uses are of the same
sort - it's used in comparisons, so places using it are expecting
host-endian integer.

Assignment you've modified sets it to lesser of RDS_MPATH_WORKERS (8,
apparently) and the value of buffer.rds_npaths decoded as big-endian.

"buffer" is declared as
        union {
		struct rds_ext_header_version version;
		u16 rds_npaths;
		u32 rds_gen_num;
	} buffer;
and the value in it comes from
                type = rds_message_next_extension(hdr, &pos, &buffer, &len);
Then we look at the return value of that rds_message_next_extension() thing
and if it's RDS_EXTHDR_NPATHS we hit that branch.

That smells like parsing the incoming package, doesn't it?  A look at
rds_message_next_extension() seems to confirm that - we fetch the next
byte (that's our return value), then pick the corresponding size from
rds_exthdr_size[that_byte] and copy that many following bytes.

That code clearly expects the data to be stored in big-endian order -
it is not entirely impossible that somehow it gets host-endian (in
which case be16_to_cpu() would be a bug), but that's very unlikely.

*IF* that's over-the-wire data, the code is actually correct and the
problem is with wrong annotations -
        union {
		struct rds_ext_header_version version;
		__be16 rds_npaths;
		__be32 rds_gen_num;
	} buffer;
to reflect the actual data layout to be found in there.  Probably
static unsigned int     rds_exthdr_size[__RDS_EXTHDR_MAX] = {
[RDS_EXTHDR_NONE]       = 0,
[RDS_EXTHDR_VERSION]    = sizeof(struct rds_ext_header_version),
[RDS_EXTHDR_RDMA]       = sizeof(struct rds_ext_header_rdma),
[RDS_EXTHDR_RDMA_DEST]  = sizeof(struct rds_ext_header_rdma_dest),
[RDS_EXTHDR_NPATHS]     = sizeof(__be16),
[RDS_EXTHDR_GEN_NUM]    = sizeof(__be32),
};
for consistency sake.  Note that e.g. struct rds_ext_header_rdma_dest
is
struct rds_ext_header_rdma_dest {
        __be32                  h_rdma_rkey;
	__be32                  h_rdma_offset;
};
which also points towards "protocol data, fixed-endian"...

