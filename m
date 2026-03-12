Return-Path: <linux-rdma+bounces-18104-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOnDH6uzsmmYOwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18104-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 13:38:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA55271E6D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 13:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CF54308C452
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7302D1F40;
	Thu, 12 Mar 2026 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ownQHuOT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89892D879F
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318880; cv=none; b=Hv1es0ppXZgOiS0go2l86qab6k/Zq5ojNvwAdYO0xRjB2QUEM8JHc74TSaz+5JEwwxx5vDJs6hMSl/Fb+vk9fgykK62RWrvloPDLDY4gW/IRl15bcBJJDtbxnFMEyAvmARc60HW5VRpF/E/eKxAVM9MiJ4Zqpo64IOsgQqOPPA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318880; c=relaxed/simple;
	bh=APBW+HdbDJGC0qi66ebGpgzi6a/5pJAPmLFyIpoPoUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4dZQFz3XRnrwxZwbTuF6HbMOeIwqyvyARh1DaYk7J4g23j7KqL90iziVea51af7XKb2xeJoLCD9OEJs3PVycwG2Hn8hYkUTrzzDzEnCZcV/SstIZ33AHhPkWBztFSz0nlEs5TQqTA+STMbKGUNj0+YCq4Vu0gILSbeptwRxvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ownQHuOT; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cd858e860aso134836085a.2
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 05:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773318878; x=1773923678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULg7grqreMOX2MMOX7z3yI5zs+73GrCTo1UP0N+hYkE=;
        b=ownQHuOTOoTG7P5CNB7JnKZ3YS6g/Kj+BPvHDxppydLUGu0P9FeCYCozpvrx+M0CvO
         6zQiTL2JTFDUIfRCZ9f6CCGls7LKo13jawgowaQLhPAh/yZrtsyaWL2k7d7XXUH460n2
         0Uxloj5c2y7Pb//ALmD0enI1ADfzsbNbpXJBzR+TpxF0z3V0pCXM/1wTaCy7HoJUxCTn
         uxAXPrvwy7I/0WQExRWhrFpLrCOjdwDbT2BnZitDU9ZthhtuIq+DOd+95U2kp/6iYjuD
         ut/cf4QpMNxMFY6pqgBQBfZXAuwC5O/8KD+P0aKFGwlu5yOwXjQ0xIYL9iJyV+JfI+g2
         hYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318878; x=1773923678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULg7grqreMOX2MMOX7z3yI5zs+73GrCTo1UP0N+hYkE=;
        b=PEFM7tGmIFUM2OFeNWIaFKy5irYQWFd9gUrFCP1mj4ZA33P5QhLcMhmBAmScr7mGp6
         JVDoQT2R5w8CHbi9q/FDbeZDVEt3WRpABZuDaY7yj6N89wlzpGz2sxlljLUub453EZSi
         rP9UX9vWGN08ojTMqRkqQtsVQ1Dq+hsNvxHdG8MlqEGvxPFo1eFpLXuYaZprwExCuaSr
         VzEAutYKFl2IS/9hdTKHkRWszsYlgKOul6/I2QBGcVP25+yhPjDcBpBeQjDzjaFmYLv9
         Y7nFG+mwXy0BDxsDawHsz2/g/LQj+TQsy8Bx7vBut0woJNK4RpJuR/aS/b4PHhr802nX
         DljQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjpLp12cn1Z1oRR6r4ztHI583hJG1BWTQPBD2wb9w3n+5ytb78TAoXnwl/AnAC/TIWmvFjxPDRF/V6@vger.kernel.org
X-Gm-Message-State: AOJu0YwHB8RQJna6vt7Pqa5D0dogLiofXO6BEG3jg+T4ELjyQi54AUwD
	rLXEwdBZfGLDylmb6fXXOrmKKH9UxkGzs9Dogpn6e/mvcbTF6NpYZUe/H5ynEZgBsrE=
X-Gm-Gg: ATEYQzxGIJOqRM0FM0fwjkOpiRXBHSIkUqDRJXGSAvGz3hZAuOd4F96Z6SpXL7Wq21z
	yqR4AjcbTnbr6AgtxstzqxWSF31hrDzXjcN1hh8b8ukXstyvJHIy9fs9SMk08b47wwPrF5YY1Ip
	jv1Uj8dxfqo2IliSFwtmplZl3TRdx0EpnrNjiG8zubUiLhDTE6lgYWHh++RMb0UVGnoUTzmQV78
	Xg6vPzShQfVpB3pXARjtpBGPMEqksa3Vqz427/3tsNYVah4P8in+xCLL6X+5/gEeaaE1cSWcLxe
	qKI/EV1ODs3QIo8pKIPRBEsW9lWysD/RtQhD9nubp2R8QHA7K9n3oqbmA0od4BgxfQvAMk0uJHj
	hPuLUjT1mRDlcWmPbmGTMIQKFferpdr2QksKXmVmCE/L8bXivoL7fPrFskZfw0tVLVHFBwyhm0C
	Fub2ZDDVHUk5t+zD7o9NeRhh0x8eOaf05BHiVLt1wnmdOaROBC1FMPYqHKcTPhtfFpL3PKzorTM
	ACk/o5L
X-Received: by 2002:a05:620a:46a8:b0:8cd:8938:eff9 with SMTP id af79cd13be357-8cda1936a90mr737651285a.1.1773318877767;
        Thu, 12 Mar 2026 05:34:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21346a0sm323887785a.34.2026.03.12.05.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:34:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0fFL-00000006ezF-1zix;
	Thu, 12 Mar 2026 09:34:35 -0300
Date: Thu, 12 Mar 2026 09:34:35 -0300
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
Subject: Re: [PATCH v2 7/8] RDMA/umem: Tell DMA mapping that UMEM requires
 coherency
Message-ID: <20260312123435.GH1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-7-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-7-e00bc2ca346d@nvidia.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18104-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid,nvidia.com:email]
X-Rspamd-Queue-Id: EBA55271E6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 09:08:50PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The RDMA subsystem exposes DMA regions through the verbs interface, which
> assumes a coherent system. Use the DMA_ATTR_REQUIRE_COHERENCE attribute to
> ensure coherency and avoid taking the SWIOTLB path.

Lets elaborate a bit more so people understand why verbs is like
this:

The RDMA verbs programming model is like HMM and assumes concurrent DMA and
CPU access to userspace memory in a process. The HW device and
programming model has so-called "one-sided" operations which are
initiated over the network by a remote CPU without notification or
involvement of the local CPU. These include things like ATOMIC
compare/swap, READ, and WRITE. Using these operations a remote CPU can
traverse data structures, form locks, and so on without awareness of
the host CPU. Having SWIOTLB substitute the memory or the DMA be cache
incoherent completely breaks these use cases.

RDMA in-kernel is OK with incoherence because none of the kernel use
cases make use of one-sided operations that would cause problems.

Jason

