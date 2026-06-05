Return-Path: <linux-rdma+bounces-21827-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U9foN+qjImpwbQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21827-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 12:24:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E88336474B3
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 12:24:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b="PNS/8oTZ";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21827-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21827-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36C2C3064000
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732753F44D9;
	Fri,  5 Jun 2026 10:10:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD07637646A;
	Fri,  5 Jun 2026 10:09:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654200; cv=none; b=uRuFCMegyg8AK2a4JDaRgiTjtmpLcDxh3D/UGMebZfyhusHwajN7oW0Xy0znHunlHozvwmmV1efzIHe8cg+NajBuyXl9tzHRiXKJuISuEQlqGjLm5sGqHgAzjdAuq/iZoSwDp+GMXDVGcA3OCRXYAXmgNw8z177oQhjFraq9EBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654200; c=relaxed/simple;
	bh=yGy9BI2lX3e4L6ehvaOo7NKyNAOxB5+brzo5zNYOt8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdEB8/8WU+SzY5v/RzLmvxOorrag3DbAghuDvpEoMSUVYZy5Wepmr+//xNbteW0mENyQwyVrcCZ52vUiMKrcVbO7cZIcMp8YgF2hjVV1cEBFwjFU1qTtm6ldFb/Nvw6IoJbR7o4vzoySloTWtoEAdE4/1mQlU2ix2rzs6s4Z3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=PNS/8oTZ; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l+jYg9iV99SJr57yhVuMIBoraQjmKqhBTn14aNvbcq8=; b=PNS/8oTZzoJ0T82HX4aeYMeRlS
	PJhNMHJy7BMN54cYeH/9RSKm34Q8uINR4/tridmtvJfdhlUToFtKZYmIbzmbeLo2HMxOGUpcccIim
	MJN3QdR9bIZVuOczbQFTOorouVFrEME33p6k7LUoQVJpe58+Xel/03JLwNcMr/s3ejnrfRPAkA+0L
	qMa4WhRyGyodPX9GFyP0eUqYMfjL9UiF7cRo5NMoc447w6iR6zKdGSTH8EfgVyPnB6KCMLSoPTOpg
	ZFuM+Pj8yDG4ApxJoeOtptweUvVZAAQxIuio57inZe3eNbC8sEKo9dGaluQhql6wh/8l1ZtFy+ohs
	ArxrGcig==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVRUu-005DLB-0h;
	Fri, 05 Jun 2026 10:09:52 +0000
Date: Fri, 5 Jun 2026 03:09:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Allison Henderson <achender@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/2] selftests: net: rds: add getsockopt()
 conversion test
Message-ID: <aiKgGJpCWs8zxNKx@gmail.com>
References: <20260603-getsock_more-v1-0-43b8d40c8849@debian.org>
 <20260603-getsock_more-v1-2-43b8d40c8849@debian.org>
 <134c50a1ca2d2f2bc06336072c89ff011a9842cb.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <134c50a1ca2d2f2bc06336072c89ff011a9842cb.camel@kernel.org>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-21827-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E88336474B3

On Fri, Jun 05, 2026 at 02:56:09AM -0700, Allison Henderson wrote:
> Hi Breno,
> 
> Thanks for working on this.  Your test covers a lot of socket behavior that the
> existing packet test doesn't get into, so I definitely think it's worth adding.
> I ran it locally under vng and it passes for me.  I did notice one nit below, but
> otherwise I think it looks really good.

Good, thanks for the direction and review!

> > +TEST_F(rds, info_counters_snapshot)
> > +{
> > +	struct rds_info_counter *ctr;
> > +	socklen_t need = 0, len;
> > +	long pagesz = sysconf(_SC_PAGESIZE);
> > +	unsigned int i, n;
> > +	char *region, *buf;
> > +	int ret;
> > +
> > +	/* Probe for the required size. */
> > +	getsockopt(self->fd, SOL_RDS, RDS_INFO_COUNTERS, NULL, &need);
> > +	ASSERT_GT(need, 0);
> > +
> > +	region = mmap(NULL, 2 * pagesz, PROT_READ | PROT_WRITE,
> > +		      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 
> The 2-page mapping (and the ASSERT_LE guarding it) ties the test to the snapshot
> fitting in two pages.  This works right now, but ideally the region here should
> account for the number of counters that come back from RDS_INFO_COUNTERS so that
> if the total number of counters were to grow later, we don't overrun a region
> that's set to a fixed number of pages.  So in this case, we'd want the need + offset,
> and then page align that so we can mmap it:
> 
> 	offset	= pagesz - 64; 
> 	map_len	= ((offset + need + pagesz - 1) / pagesz) * pagesz;  /* round (off+need) up to whole pages */
> 	region  = mmap(NULL, map_len, ...);                 

Good point - sizing the mapping from the probed length keeps it correct if the
counter set ever grows. In v2 I'll derive map_len from need + offset and drop
the fixed 2-page assumption:

        long pagesz = sysconf(_SC_PAGESIZE);
        size_t offset, map_len;
        ...
        getsockopt(self->fd, SOL_RDS, RDS_INFO_COUNTERS, NULL, &need);
        ASSERT_GT(need, 0);

        /* Unaligned start that runs past the first page boundary. */
        offset  = pagesz - 64;
        map_len = ((offset + need + pagesz - 1) / pagesz) * pagesz;

        region = mmap(NULL, map_len, PROT_READ | PROT_WRITE,
                      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        ASSERT_NE(MAP_FAILED, region);

        buf = region + offset;

with the ASSERT_LE() dropped and munmap(region, map_len) at the end.

Thanks for the review,
--breno

