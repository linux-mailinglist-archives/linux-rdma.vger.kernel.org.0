Return-Path: <linux-rdma+bounces-17869-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI6lKssbsGnufwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17869-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 14:25:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A82250332
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 14:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 093843190889
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 13:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3AE3D47DC;
	Tue, 10 Mar 2026 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f8K5CocJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2743D47CB
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146049; cv=none; b=IZXsoFqnvVm2v2PNilakkHcTvyIwHnVN3H+OL47bv27dmegOEgtHVA+iTrziMPvlpaJm8QZh3S/zxlAid/GmoCS7I24rudwCRH4W5t5APw2bokfOOj+ZkII++kg546Ym6FOF6CoWnk3sqtOlG/SbKCkEYwkxDbm32NgmmanYeFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146049; c=relaxed/simple;
	bh=cHUF2XHSTidsSmxJD0bQdgzaHWB25qEwufJ2YTbQfJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUc8/4YIrW/k+I5aDam//IGp5pCWsxA2/ljnzMLm/jy1OzWcIDtB8/BEpMIA7EKCAJtd7k4QNcXL5W8ALrn/NFGGbGdizDIQWfxWE6C9lzmRU6PpJZKjWXj1wt2hudj/unRajO0DhZNMpqZRIc8ywcJRaHEL7XscFGswLa/EuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=f8K5CocJ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c9f6b78ca4so1654224685a.0
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773146046; x=1773750846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JidrQO5YBoJChSM6WSALz7pLZEnTQpjujRwwjFND6W8=;
        b=f8K5CocJqmPZcA0JrprlJiEZ2g14B0IWLg0GGSVzL0LlWh+EAGKuT1VLTD+AAZ27Mp
         67jd/prM/RG8fMw8rZ3mHJ0uwowArAbb0viDvMduw4XEO/0gdcq9qLk9+2WuecSdTBZA
         g60CVjew09aSoUQo3E5eq41c3iE/3AXgQ1uu+zuOKG4pAQFCSZPtp3MsRyfJA3wglIhe
         CWf/pm5mroT/yGMG+zdum/O8i0XcsweYKnqTxgr/fg/C64a33bzEXYET2DUUvYwU6eX5
         lQPFcASb+VVORr6PAjR89Se21fl5SJcLJFlqELzOKd+zv8bRbUDvLa4NljX+8Zsh6CPc
         AHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773146046; x=1773750846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JidrQO5YBoJChSM6WSALz7pLZEnTQpjujRwwjFND6W8=;
        b=DFxhV+tsjp2fSLRLBlpSkwgQTw005ZBWcBZeo6bd7A6bfXrNk74lzU9eHwbdGTgswf
         BMofg353bACJ0toUCumqDczkerk1sC+dOyKuq1AZBei0u8BhDCANCWsKhbtYCpxO9RUE
         Xmt+qr/UQfZ54fzGK6MOOhA2drlqTKinb3IoyxRbZ+FzBk8SW1X2gZ5ol7fFuedmIQ9r
         qq9hCBhUNkA2Bdtwo9gNbzHxFfOZBDyRrOE2Pqpf2IK73VYbAMsqE3vWYEJTGFX6x5fa
         lwnC/nw0XSSDVjO+H4GnAEivp07C0Q12czBU8ctk+X9JP/1f82tNhqR88rqHEGq2oLE8
         3Erw==
X-Forwarded-Encrypted: i=1; AJvYcCU1VLjQQu7dtZJUi+BFTTxfqfCkC61vKPJCO7C0pGoeiWSRivG7hBN8fJHSf1ZQeFJKm90NKQ7JZkFq@vger.kernel.org
X-Gm-Message-State: AOJu0YwNAVwLtLJd2rTjLUhVjkx9agWxLzNx1u814mYqeONYPLWwx1mf
	WEH0ezJ0idDO4HJOCGZ1S5z9pVaYHunhY40L1YNU/u6WmjkNy/1mng50QDTfKsFD8lA=
X-Gm-Gg: ATEYQzx5IKRjfHeZfw3rT+11/bz6n8GmzXwVKKlzViWTf3wNXv0qQ8vmO6X0b5eEAhn
	nfrA70rlOPcBHMjsX7MGKmo7VSy6AiDUpZUUduCFhxeNBDvGhHQgPp5vAStqFGFyqFvUYULIBsw
	L1ggQAbyxuQiiIMBmxjVOYHct0pmJzq5fnXfvk/Gg7zxVT5iCx08FK6dSggSn/7IYbR2AMwAY+b
	FN1Lful17pn+LVHmzSjHS45Hs/aEL6kOxmbkdGTn/aKdZi4dnexOoirLfuTUTl9DCm1NAE5Y8Eg
	9wCslkRAyPyRQBO8NYUKew6K7Kv3l4UEBPa1qNFIRs7rArarZ+awVE7gg6ixONv0G/XRydVkn6n
	tkAe50eBepMWvJsdQHLneJQaY4JtOuA0+vfLB2CymWbiuwiSpTct14dIOm27Hg0G3CPEPyFbOfS
	CZ3tsrdaph0HTlQ94f3o2zLcgMfL2/aHQyFH15Zsi6DP1iDEu9tIl9o5lF8u4ehn6WGBnwkgBzz
	piMH/Nd
X-Received: by 2002:a05:620a:4004:b0:8cd:9365:f27f with SMTP id af79cd13be357-8cd9365fb75mr416301385a.51.1773146046495;
        Tue, 10 Mar 2026 05:34:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd827a1ebbsm505561785a.8.2026.03.10.05.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:34:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzwHl-00000005N1Z-0e7z;
	Tue, 10 Mar 2026 09:34:05 -0300
Date: Tue, 10 Mar 2026 09:34:05 -0300
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
Message-ID: <20260310123405.GR1687929@ziepe.ca>
References: <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
 <20260308181920.GH1687929@ziepe.ca>
 <20260308184902.GR12611@unreal>
 <20260308230916.GI1687929@ziepe.ca>
 <CGME20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07@eucas1p2.samsung.com>
 <20260309090342.GS12611@unreal>
 <c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
 <20260309150502.GX12611@unreal>
 <20260309151356.GN1687929@ziepe.ca>
 <aaebc5b6-2805-46d3-a68e-549c26a3ef03@samsung.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaebc5b6-2805-46d3-a68e-549c26a3ef03@samsung.com>
X-Rspamd-Queue-Id: 61A82250332
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17869-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 10:45:38AM +0100, Marek Szyprowski wrote:
> Jason is right. Indeed the rdma/uverbs case needs some extension to 
> ensure that the coherent mapping is used, what is not possible now. This 
> however doesn't mean that the DMA_ATTR_CPU_CACHE_OVERLAP is not needed 
> for that use case too. I'm open to accept both. The only question I have 
> is which name should we use? We already have DMA_ATTR_CPU_CACHE_CLEAN, 
> while DMA_ATTR_CPU_CACHE_OVERLAP and 
> DMA_ATTR_DEBUGGING_IGNORE_CACHELINES were proposed here. The last seems 
> to be most descriptive.

If we do DMA_ATTR_REQUIRE_COHERENCE then I imagine it would internally
also set DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, but I'd prefer that
detail not leak into the callers.

Jason

