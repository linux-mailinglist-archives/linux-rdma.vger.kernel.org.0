Return-Path: <linux-rdma+bounces-17921-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIs9Nn+qsGmYlwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17921-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 00:34:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5323C259489
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 00:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34C1C30156FC
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 23:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FC438737C;
	Tue, 10 Mar 2026 23:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n6uuBTok"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537572D0635
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773185660; cv=none; b=Fp0UbLKfUdS1ExKw0rUapOl3ow8oG8ZJKQDasLQhyJqxW1ErqZX99wmReN1dlzsxVpJlIw7Du+RpNPrzy3fKTtsQz5kGDjm6CIgTf+S0GhIObB5c6Ar0M0RtFu5vVt8fufBRbSZIaKo44dIRdreHNtc1yBOZ9yceyqy50jl8i3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773185660; c=relaxed/simple;
	bh=zCDQLm/ti7Fh+tEKDvr17wEEpnNO9M6S1JIlwzo9Acs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T97+lkNHguXQfs0GoMmFzr9um9XB3VYawdYj7NFJeqbBboHsXctuTWu69ifaVIZloJRv8uISUtstSrZw3RSj2HG4dBaLVmfNFVbrM6WpUP9WiVAhMu5Ffy4MxNAFCt0NccylC6lF/Nx7ja7Nf35Quf2aeuyCT9qf/KWKy2PJdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n6uuBTok; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cd79e43da3so350769185a.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 16:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773185658; x=1773790458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsiIyQd4tPWumA9ZQMQURKCway9cLZHNLfL2p5j0zPY=;
        b=n6uuBToksVmxqHTOnwcTLm8SqOdVqzC9hwvnG5NmSIkRODM387iQ8/SB+lOT8Ptfs7
         AntGAIHr2j+KJKd7Ht01wP3JHYioR+yBvDmqCsxS0ZNUT/MfxjV/9iKVqU6jWGvn3FRd
         S7jFewWF6fcI2P1pRFuDDfkRKgVTzvVxjdp0HaNP0zGhB+xerwfmKufsEJ37kdXXGPaa
         L84tACDnV+c6YuNSiEucEikNCfCd1GAteMIYcxM7lzkcrrj1/3QbYYdvDNNIEfwaYc81
         8qiLskG8qTIoCan1P8afsUeS7SOEGHdb8kkMe3+/G8joQgBS/Im9O8htDcO36Lu65AaN
         NtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773185658; x=1773790458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsiIyQd4tPWumA9ZQMQURKCway9cLZHNLfL2p5j0zPY=;
        b=UXp7ZtZaiRGlhvtg9mCKglDhG3cWav7DftXg08AUlWwLzlLJlfbjwCnJzRfrZu24oT
         wcBTOWCOzJEYnH1MWbzO1ZDYZNrpR6q0a9xMtD7CmqZPMTjA8cmRSmB7avtC6j34ZlQA
         f/+bgO6JUL/AZAJRIPc9p3dJBrKXOPoO5xgSFsidRTPfkcU2dDkW6wWcBOzb6ZPL2SI5
         ZvFlPWVXCTeLBvhh//+qfKoJrX8I4gesKuTPiA7ofSIsRZSS0e3PxdHwx7zAQcUcN5Wn
         PpNHal3FuNtwGyLWf1ZZNjdw1TC/V6WnbjITEamlEexRd4voDNAu1e5u2vmrT7aLPNks
         5big==
X-Forwarded-Encrypted: i=1; AJvYcCUMRKu0iYtukQS9dvIWllqMgCEKqQu+dyZ4f+Tx67MY2UWghxiZV81QptGwav3B3bS0EyqxOwv5NPpH@vger.kernel.org
X-Gm-Message-State: AOJu0YwGxEPsoMc1XoOpKDXMRoOlO352wjssHRU9dpeyxlpQlvrUJRQK
	weB+MCNdIkE4iEU3nTOB54UElxZ3ICDwRD3AdJcoBRFl5Rt2atG/xUNASWwJKH0zM7w=
X-Gm-Gg: ATEYQzysC2t7Jp0Km6CC6jOIHAa5ylLiIGkHqnMR0E2/hGe4YVmrBpDB2kJ1HP7Wi73
	ObqFEiTW5iOGut7T8HOfcQxakt2i28/Gq/EJfqa3V/bF+yZQLpJvYiMzme00fy9/XawWRrezWAi
	7Gjxysf1qCCM7RE0JC4ZiSLHysW6XcF9c78d9sg3IJJR5OBiI++ZPh2Z2NCNSJaLptx8GyZHr7H
	SMro+riyHHcfyy0MOZnd24jWyzKNqz1b2xxaH10z2VUehA9ixuGe16iYYkNIinH6gsD/wXs4FHn
	O5cnZ54LS+GgIPTOc73tCFB7H5WVbASTZMs4pOv0ZAMO8bulPmuoG6RNaDn4D6PlIzU0evt5bC1
	bJxXrHtTNeHcPPo55xC4xTk0WlaZDwunx4tgQ2IZSAUL03Yz7IRdO47fmoLBGwDJc4pZWII38cp
	jjupH6scfdY3RPw8hg8NJu3to30F6lecGyZ7OkqlsKTcSUqQ3GjxpHWz7jrkIlNTW4X/mbn0A9N
	ngBaRQl
X-Received: by 2002:a05:620a:3941:b0:8cd:982d:4101 with SMTP id af79cd13be357-8cda1a28be2mr93012785a.27.1773185658222;
        Tue, 10 Mar 2026 16:34:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fd6325sm24946085a.11.2026.03.10.16.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:34:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w06ae-000000064gS-3fKz;
	Tue, 10 Mar 2026 20:34:16 -0300
Date: Tue, 10 Mar 2026 20:34:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] dma-mapping: Clarify valid conditions for CPU cache
 line overlap
Message-ID: <20260310233416.GT1687929@ziepe.ca>
References: <20260308184902.GR12611@unreal>
 <20260308230916.GI1687929@ziepe.ca>
 <CGME20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07@eucas1p2.samsung.com>
 <20260309090342.GS12611@unreal>
 <c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
 <20260309150502.GX12611@unreal>
 <20260309151356.GN1687929@ziepe.ca>
 <aaebc5b6-2805-46d3-a68e-549c26a3ef03@samsung.com>
 <20260310123405.GR1687929@ziepe.ca>
 <a61f8814-b896-4ec0-bb83-a8cbd8aca4e8@samsung.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61f8814-b896-4ec0-bb83-a8cbd8aca4e8@samsung.com>
X-Rspamd-Queue-Id: 5323C259489
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17921-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 10:08:38PM +0100, Marek Szyprowski wrote:
> On 10.03.2026 13:34, Jason Gunthorpe wrote:
> > On Tue, Mar 10, 2026 at 10:45:38AM +0100, Marek Szyprowski wrote:
> >> Jason is right. Indeed the rdma/uverbs case needs some extension to
> >> ensure that the coherent mapping is used, what is not possible now. This
> >> however doesn't mean that the DMA_ATTR_CPU_CACHE_OVERLAP is not needed
> >> for that use case too. I'm open to accept both. The only question I have
> >> is which name should we use? We already have DMA_ATTR_CPU_CACHE_CLEAN,
> >> while DMA_ATTR_CPU_CACHE_OVERLAP and
> >> DMA_ATTR_DEBUGGING_IGNORE_CACHELINES were proposed here. The last seems
> >> to be most descriptive.
> > If we do DMA_ATTR_REQUIRE_COHERENCE then I imagine it would internally
> > also set DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, but I'd prefer that
> > detail not leak into the callers.
> 
> Why DMA_ATTR_REQUIRE_COHERENCE should imply 
> DMA_ATTR_DEBUGGING_IGNORE_CACHELINES?

AFAICT the purpose of the DMA API debugging cacheline tracking is to
ensure that drivers are mapping things properly such that the cache
flushing in incoherent systems can properly cache flush them without
creating bugs (ie a dirty line overwriteing DMA'd data or something).

If the mapping is REQUIRE_COHERENCE then it is prevented from running
on systems where these cache artifacts can cause corruption, so we
don't need to track them and we don't need the strict restrictions on
what can be mapped.

Which trips up and gives false positives for cases like RDMA, DRM, etc
that are allowing userspace to multi-map userspace memory.

Jason

