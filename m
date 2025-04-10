Return-Path: <linux-rdma+bounces-9320-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E7A83BF1
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 10:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C2C1B64DA4
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127011E5729;
	Thu, 10 Apr 2025 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWEIc/rX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D1B1E32A3;
	Thu, 10 Apr 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271976; cv=none; b=SXEHF9keqtCHEw4/GSzOaVIuryxQDrN8K/WNwoPnTUXWqLTYhB+9xxFI2rX2Z95ToKUqq1TQQPzsmadBqphqi57KRLNByTywAyWRjL3EQYLCdSd1ybC4YExpn/W8APIKi1L5PzIFuJyy4jM02p2VR3CjA5ehnhN/3zRoCDNGzqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271976; c=relaxed/simple;
	bh=UiSeec8bgOQw16nTOooUF8MdvjIJ33hXBd2rH5yhSCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abDF0E6WcfwK7Zv6awIDvA4ouT5Mek1PNEEGsn4usxOMRHEQVMSCSYADRcZtUTLZmFlqBx0kbOFIvbcrfbeJXO5pNC1AHQs85KewF9437r0Ej039biHpaa7DIka2JkLDlpmnwC1Ms0+QqFcCr2uMB8iR+whpy7xzpWPh+n6UzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWEIc/rX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36842C4CEDD;
	Thu, 10 Apr 2025 07:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744271976;
	bh=UiSeec8bgOQw16nTOooUF8MdvjIJ33hXBd2rH5yhSCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWEIc/rX/KxApXAtDmJfJ55hJ00ScI52B8dPy00YaUEhWl7b6YeJK5+n+uSuWPWkL
	 QBC76xoUicSo3qCD42e89bWhRzl4iPw0eN7pSlFjz43l5OYcj8fkS9aF0xw7NgaLgX
	 KBG9QOUmtc3wFsGq/9x+4D4/p2Uwy1CBFw2s8JZ1m82o2OWcpUvGbJuXxWd2SxRDhT
	 JRRoLND1ivpuU3OrOUgySVUBYvFmK8doxbEDflMlUmgnOWuQM8/uhWilR/nRztPFiT
	 sQP0kkZ+NGj9lBcH+R1XI7zd6oKHrSWnTXYmPj5sHx7iEE8zeVEClEwWvFzLDZQkaI
	 HttyTZWdQt65g==
Date: Thu, 10 Apr 2025 10:59:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux <linux@treblig.org>, Maher Sanalla <msanalla@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hfi1: use a struct group to avoid warning
Message-ID: <20250410075928.GN199604@unreal>
References: <20250403144801.3779379-1-arnd@kernel.org>
 <20250407182750.GA1727154@ziepe.ca>
 <e477f8c0-5478-43b5-9d59-297efc32d20e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e477f8c0-5478-43b5-9d59-297efc32d20e@app.fastmail.com>

On Tue, Apr 08, 2025 at 02:40:38PM +0200, Arnd Bergmann wrote:
> On Mon, Apr 7, 2025, at 20:27, Jason Gunthorpe wrote:
> > On Thu, Apr 03, 2025 at 04:47:53PM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> On gcc-11 and earlier, the driver sometimes produces a warning
> >> for memset:
> >> 
> >> In file included from include/linux/string.h:392,
> >>                  from drivers/infiniband/hw/hfi1/mad.c:6:
> >> In function 'fortify_memset_chk',
> >>     inlined from '__subn_get_opa_hfi1_cong_log' at drivers/infiniband/hw/hfi1/mad.c:3873:2,
> >>     inlined from 'subn_get_opa_sma' at drivers/infiniband/hw/hfi1/mad.c:4114:9:
> >> include/linux/fortify-string.h:480:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror]
> >>     __write_overflow_field(p_size_field, size);
> >>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> 
> >> This seems to be a false positive, and I found no nice way to rewrite
> >> the code to avoid the warning, but adding a a struct group works.
> >
> > Er.. so do we really want to fix it or just ignore this on gcc-11? Or
> > is there really a compile bug here and it is mis-generating the code?
> >
> > The unneeded struct group seems ugly to me?
> 
> Having a clean build would be nice though. Do you think a patch
> that just turns off the warning locally would be better?

I don't think so, as you will need to disable warning for specific
compiler, which won't be nice.

My preference is to have a fix.

Thanks

> 
>       Arnd

