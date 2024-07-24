Return-Path: <linux-rdma+bounces-3945-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E1593B7D8
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 22:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398BB1F20FB7
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 20:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C494A16CD12;
	Wed, 24 Jul 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="qcp64IiJ";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="qcp64IiJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830B16C686;
	Wed, 24 Jul 2024 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721851972; cv=none; b=En+RKEIzBA20CKo2dhmVg2JZBdBhJHLOpq+xEXSUfxgvKo9uRaTp2b+QXzape0MNLyjiGyTrUziOHUvBy5wwnWc2iT/KnBiEiqmjP8GLVjOvd68JOvb/dG2r0p/sXTV8nNNBB+5KCDPtaWp2Q+SQWnkHNlgEGt5hKs7TlVU9FWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721851972; c=relaxed/simple;
	bh=zgh7UDrimSj4FVKvXjZq1LmBe1g5zO9SlxvpSZ91iSk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pvr0aAeNwaCbXOhtUudC1v8wSvyf+KTA9d1kTKroiezVex5pgPra1eidSu8ptiHq/p+K7f7KbGmmHdnvGnwLVGX5ddj7usqbEooGLy8kn1kng8TyMVD9Xx4nbCJkFU/fqGek/9TuDsWVtG5lt4PiiShBT3yt2Tce9ZH5/w3/lqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=qcp64IiJ; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=qcp64IiJ; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721851970;
	bh=zgh7UDrimSj4FVKvXjZq1LmBe1g5zO9SlxvpSZ91iSk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=qcp64IiJ9p9QpfUqrpPKeTCZT5dvmvO/EFQJ/mrGOgHNOKfMWn2aUPMfEpw6l3VFZ
	 B5ixxwX24qOTtoBr4OXtZwZ8ofsdO/NJtbCi8l9gwGC9O7PY7bsJCjGVJGM6nOPvJ8
	 0b2Q0IASv1T12JreWqO69xhqMkxlcTiTXsPVweTs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6AC8B1286830;
	Wed, 24 Jul 2024 16:12:50 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id PvhbaX-PrumA; Wed, 24 Jul 2024 16:12:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721851970;
	bh=zgh7UDrimSj4FVKvXjZq1LmBe1g5zO9SlxvpSZ91iSk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=qcp64IiJ9p9QpfUqrpPKeTCZT5dvmvO/EFQJ/mrGOgHNOKfMWn2aUPMfEpw6l3VFZ
	 B5ixxwX24qOTtoBr4OXtZwZ8ofsdO/NJtbCi8l9gwGC9O7PY7bsJCjGVJGM6nOPvJ8
	 0b2Q0IASv1T12JreWqO69xhqMkxlcTiTXsPVweTs=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9A24B1286594;
	Wed, 24 Jul 2024 16:12:49 -0400 (EDT)
Message-ID: <4c300d45b73aaecc1bfd1ab86502d0711238c698.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev, 
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org,  jgg@nvidia.com
Date: Wed, 24 Jul 2024 16:12:48 -0400
In-Reply-To: <nycvar.YFH.7.76.2407240119140.11380@cbobk.fhfr.pm>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
	 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
	 <nycvar.YFH.7.76.2407240119140.11380@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-07-24 at 01:22 +0200, Jiri Kosina wrote:
> On Tue, 23 Jul 2024, James Bottomley wrote:
> 
> > That's not entirely true.  FIDO tokens (the ones Konstantin is
> > recommending for kernel.org access) are an entire class of devices
> > that
> > use hidraw and don't have a kernel driver.  There's an array of
> > manufacturers producing them, but the CTAP specification and its
> > conformance is what keeps a single user mode driver (which is now
> > present as a separate implementation in all web browsers and the
> > userspace libfido2) for all of them.  
> 
> Agreed, but that pretty much underlines my point though.
> 
> The ecosystem didn't get shattered as a result of me having created 
> hidraw.

Yes, we're in agreement on this.  I was just extrapolating to not every
bypass is inherently evil.

> libfido2 is on pretty much everyone's machine now (at least for those
> who need it), and people are using that all the time to authenticate
> to kernel.org/Google/Okta/whatnot. No workflow got broken in the
> process.

Well, there is one use case I can think of that would have the kernel
talking to a fido token (i.e. us having a kernel driver): using it as
the root for trusted and encrypted keys.  It might be very useful for
security features like encrypted device tree or kernel command line
files, or even passing in a private X.509 key to add to the kernel
trusted keyrings or for module signing.   The rush to bypass the kernel
deprived us of thinking about this as an application, but, since the
spec is open, if anyone cares enough, I'm sure it will eventually get
written.

James


