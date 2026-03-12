Return-Path: <linux-rdma+bounces-18103-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFqSAxyysmmYOwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18103-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 13:31:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7A0271CCB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 13:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EBEF30D4BF7
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 12:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEC73246EB;
	Thu, 12 Mar 2026 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IA4RNZY5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FA93093B2
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318420; cv=none; b=HKXmTKKPz04QaPCWFp8V4JV4ZsiWZggrctU32ihiBujNgYMqeUqBb6akSRf9aorpjZav3yVZi1kVLAGQenSlfqah/BBDSduz00BbJplThDm+8rO0HciA07m9QY1EXPwIN1UBVa85kNYQ4/ZgezIWvUlKfzARr/WXgwLEIMwSaP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318420; c=relaxed/simple;
	bh=kL0Vtw+iePKp4mxXk49bsuyKV2vV08txbV9fCNpa5ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euimheetz8yAqLD5OUrdWMUx8baBJY68Q+QrT7HCnbh3EnolwiSUozxcd71Rlzcp6xPD4qMlTc3eubUIwCJKljA03SDuEhSJCJShaTpf4WPtYojOFwWVEf/nDOd04PHbdGy6FgCcvebvkF2p0IH5BvGUHybLQ3+bvIQos7NHO38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IA4RNZY5; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cd785a8783so102346285a.0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 05:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773318418; x=1773923218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bVLYsZeqdLLR0Cw+BVzWgzWP+lyAr3AqcCFZTxFfl4=;
        b=IA4RNZY54MlZRH6gImDutdbmqWRi5s7Aq0rG19UOYiw/P/ndeNshlYrf9zUbaGIe/8
         is5ZjhqWU35yFqgB50yrzrB3lGuzyyssyNXeGIoUiqCddW8B1VOE3zJ0b4QK1sfz6aQf
         z1GGlY7AceS4ExYFXcnq8CCVd7jCS0RF0o373hRB0hNBRXgxou97eJIshDm0kZl0+deW
         Vml5iVgIVGBi3mb3I3LM+JyP9bx4tVcP1nZ/5EDCklLHrUXs1m1w8wO9cC1HQJL39UKB
         jCbkJPVpLUCVBqptxF/N+ANFSsg10lUTtIhtQHIDbEr6rix5Z0FfcPxTIjo0oYNAqOCv
         rHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318418; x=1773923218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bVLYsZeqdLLR0Cw+BVzWgzWP+lyAr3AqcCFZTxFfl4=;
        b=V936yUgDaNrhOynlIYVi+zoWLW4FJWfczGiO/3/94jx0oywrDIAgLNEkxC5FM706Jg
         pixiHr8P9xWuYhT5W6PLXSPatO+YqYXylgYCSZYV0mUY+++pUZe9yfV7DGKGV5CjHC+1
         j09N530wrGYbuoNYBoq1UnW1QF5+t1UpbXCf3lkXI4FMu6vH5tUgLyzl1QmdtU8FPOoK
         tB/oFj/0qdbnC/KHlg46uC6z1AiBtczv8QK56gx1RvRH7wAqzuhfx0eTy4cg1W4sH/hx
         yixjPjRLEEHgzOuFyyf+ohvemhB9r3S53PTdEbNkLr0Ob/ZX2DEFJU/7q7Q6+3jaDEKN
         h+OA==
X-Forwarded-Encrypted: i=1; AJvYcCWYYWN4OvCFlZQ76dRQwL/Il2wAFWekYfU/XBXQ6AQdxEadxtuet34VtoeFv9tEyXOgnhh3wHfaTq6U@vger.kernel.org
X-Gm-Message-State: AOJu0YzyblPXr4Z1E2l2LNMe4s/884+NMgiK4Cd7neaNcUuLaaYLwUJ+
	9YeMCsiYIczLzsMbXBs/973fCNcOCZ2kjJqDKz9+1nr3KoIVvH7SDTVSHo0ssVtEt4s=
X-Gm-Gg: ATEYQzzkuCn5GEFYlJuHWJlU+h+DKOGGFv6Ke79V17fFuiLfM9B6Jep/BNwNhWh74kS
	5Fos01j9i1sAQy0URZJeqRm0h3iJ3KFrSOEaEaWAb55Lw+sLnmbMC32A4mbwmKhf1FMTziAKmW8
	FwsH3/BAR0CQEmhDAchgdoaf3ArgAgU3PlCtQyafib13i7QBraYvS1UFg61mq45Q0kSLMyAzoqv
	jpWRy2ffz3sTNCYcrEXKNxepfCVIP0sjE6qavOMVAA+4kLVgIqxA+Kk1c9dKd9U6Dvr9hUG1ULr
	N9A8gEKR8Z4/dDcHDRs6pzBpUlepaj2eJ94Huw14OW+1IOJ/+U64SjjIaxRmoDdg+ufxI/mw0No
	dWR6v5Vyle42M2nVfInagS5UFjqQRDKBws8Rjq4h4GEQjnrjyRSVurP7if9rbcNKeOBPgQjOytm
	zP7mzzx02hL0Q1cGU/FyJleAaDZfUINyiCTJvOfteQPmB256qlYGWrJA2gI8QIpNAQGJ59xKlh6
	cwST5l5
X-Received: by 2002:a05:620a:4692:b0:8cd:9322:7c55 with SMTP id af79cd13be357-8cda193043amr787228385a.17.1773318418176;
        Thu, 12 Mar 2026 05:26:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fddfe8sm328304485a.12.2026.03.12.05.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:26:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0f7l-00000006ewH-1owB;
	Thu, 12 Mar 2026 09:26:45 -0300
Date: Thu, 12 Mar 2026 09:26:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 8/8] mm/hmm: Indicate that HMM requires DMA coherency
Message-ID: <20260312122645.GG1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-8-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-8-e00bc2ca346d@nvidia.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18103-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid,nvidia.com:email]
X-Rspamd-Queue-Id: AD7A0271CCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 09:08:51PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> HMM mirroring can work on coherent systems without SWIOTLB path only.
> Until introduction of DMA_ATTR_REQUIRE_COHERENT, there was no reliable
> way to indicate that and various approximation was done:

HMM is fundamentally about allowing a sophisticated device to
independently DMA to a process's memory concurrently with the CPU
accessing the same memory. It is similar to SVA but does not rely on
IOMMU support. Since the entire use model is concurrent access to the
same memory it becomes fatally broken as a uAPI if SWIOTLB is
replacing the memory, or the CPU caches are incoherent with DMA.

Till now there was no reliable way to indicate that and various
approximation was done:

> int hmm_dma_map_alloc(struct device *dev, struct hmm_dma_map *map,
>                       size_t nr_entries, size_t dma_entry_size)
> {
> <...>
>         /*
>          * The HMM API violates our normal DMA buffer ownership rules and can't
>          * transfer buffer ownership.  The dma_addressing_limited() check is a
>          * best approximation to ensure no swiotlb buffering happens.
>          */
>         dma_need_sync = !dev->dma_skip_sync;
>         if (dma_need_sync || dma_addressing_limited(dev))
>                 return -EOPNOTSUPP;

Can it get dropped now then?

> So let's mark mapped buffers with DMA_ATTR_REQUIRE_COHERENT attribute
> to prevent DMA debugging warnings for cache overlapped entries.

Well, that isn't the main motivation, this prevents silent data
corruption if someone tries to use hmm in a system with swiotlb or
incoherent DMA,

Looks OK otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

