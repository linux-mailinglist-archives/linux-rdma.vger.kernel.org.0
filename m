Return-Path: <linux-rdma+bounces-7610-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E74FA2DEDE
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 16:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2BFB7A2B6D
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C2B1DF72E;
	Sun,  9 Feb 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hlc9BCgF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C66199223;
	Sun,  9 Feb 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739115858; cv=none; b=Bnwf4pmdA1dtaUB89YWYYM2hqYW7wCBwuLJNe2ssrd3QsZmeG0FBiL24vJT9hLfrKg6j/MC3YqpNphUwEQCy6yhzRmkcLO36ON27WcqokqrObDJBU93eLgA1TDqZYscijEJah4rV1hXl87jX15FurHG9IqDrZiFKrqx/joEnPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739115858; c=relaxed/simple;
	bh=dGPpB9t+4RudLOtvR40Tcn15xSyprmOSWpFz5CYcR0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPhPcYejf58Pf+ui3fXkqPweHzPKYMoL1FNL1rXIlvpcDFT0mpmT9E4N7zH/DG+iJ2rw+ts5Jni2qmfxDk719a8+BqoTpmdfeJFay9wBJXU51elpDrAsOxF31WvIWbOynxnJdOI8/pjwb0O5qP7/szdJ+WWmbe/g9w9hfr1nPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hlc9BCgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59EBC4CEDD;
	Sun,  9 Feb 2025 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739115857;
	bh=dGPpB9t+4RudLOtvR40Tcn15xSyprmOSWpFz5CYcR0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hlc9BCgFJfjwnjU/0v9DW0tP7/1WDWbvRt8ti/LqDQLSJjKPqoVFOwcsRB3DYrjbS
	 gPhP+IV8CA3CNjyrnKutAqQrfXMOJZSutbaVKGhcITFEhfl4ZpgcOKwtTPpous0kbk
	 dgIs6ZQ/6tdD6G8Ouh0/nbzyNn/sOpaoNU+tcX6zxBL5qqTYuXfAd4Nh627WZh8EoU
	 QOHFa97jPzOxFCeLxsEzhB0vmtIrVwa4qj1KSDtsI4EhtX1R9QFmE26nWRLmtXVScu
	 LH13mMdwU9z7nql+L4nhEg20kLuisAWsi6J/kdMw7U4YcwrUwYIIxZjnFXANEETVq3
	 92Dlj92cXjd+Q==
Date: Sun, 9 Feb 2025 07:44:16 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/irdma: switch to using the crc32c library
Message-ID: <20250209154416.GA1230@sol.localdomain>
References: <20250207033643.59904-1-ebiggers@kernel.org>
 <20250207035750.GA43210@sol.localdomain>
 <20250209091255.GA17863@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209091255.GA17863@unreal>

On Sun, Feb 09, 2025 at 11:12:55AM +0200, Leon Romanovsky wrote:
> On Thu, Feb 06, 2025 at 07:57:50PM -0800, Eric Biggers wrote:
> > On Thu, Feb 06, 2025 at 07:36:43PM -0800, Eric Biggers wrote:
> > > +int irdma_ieq_check_mpacrc(const void *addr, u32 len, u32 val)
> > >  {
> > > -	u32 crc = 0;
> > > -
> > > -	crypto_shash_digest(desc, addr, len, (u8 *)&crc);
> > > -	if (crc != val)
> > > +	if (~crc32c(~0, addr, len) != val)
> > >  		return -EINVAL;
> > >  
> > >  	return 0;
> > >  }
> > 
> > Sorry, I just realized this isn't actually equivalent on big endian CPUs, since
> > the byte array produced by crypto_shash_digest() used little endian byte order,
> > whereas crc32c() just returns a CPU endian value.
> > 
> > And of course this broken subsystem uses u32 for the little endian values
> > instead of __le32 like the result of the kernel.
> > 
> > Not sure it's worth my time to continue to try to fix this subsystem properly.
> 
> There is no need to be such dramatic. You are not fixing anything by
> switch to new APIs

Exactly.  That's because I dropped the patches that actually did fix real
endianness bugs, because of the pointless pushback I received -- see
https://lore.kernel.org/linux-rdma/20250127223840.67280-1-ebiggers@kernel.org/T/#u

- Eric

