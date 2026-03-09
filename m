Return-Path: <linux-rdma+bounces-17793-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGJXBU/lrmmsJwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17793-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 16:20:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED5723B8CA
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 16:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3C6E3061CDB
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 15:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008063D75C3;
	Mon,  9 Mar 2026 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WNeaa7YG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933618B0A
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069239; cv=none; b=GKdzCbqqp5mFjsMXa/eUHb5qmU4VZ97dbPZmV3tPuKA0F0uozr/hRUnIWgHTBgDjRrfxzWZ1WiiCjaooRsnzlJURk6QtvfLElYy/VC622IN8k+UKTUuum29BQgacpXfmirn7fVVgWQppdfyrpc4ddiPiOaYfvOSBLNv2LU2Zzcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069239; c=relaxed/simple;
	bh=EmTN4lfqvNBf2NGWRvyoj3Pdz7Zrbn88TVlk/KgiBfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNqzg4+IeNWWj4ikMfZhkR17MQOnptmQ5wt3DTB4pZr4qW9xJ8ddpfpsSeZlEMfjUGNi331AaZsEbOn5g4jvn8yrzkp0YFRF1+gTNNIhqivTw4QCizltaFw646DMrdZZUtE0aJC/xeT4PbFTgzv01t8/kDM+YDh8yvoMj6A31DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WNeaa7YG; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899e43ae2e1so76830426d6.2
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2026 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773069237; x=1773674037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EmTN4lfqvNBf2NGWRvyoj3Pdz7Zrbn88TVlk/KgiBfY=;
        b=WNeaa7YGfwmalIyIddPyi87ky0tlETPmxVSf6ouKOCy6c4YUrm9CzKupbDmhfK/n/k
         WacY7dS0DnZ623k7+X5K3Z2noRhK5ldKi0eHFGLUMnE8FcuSbLb4gn5Zy+fr5uqob6hZ
         4QbupYTdyjvnKUGKkbZKrc53iyMZxhxzlHwyzhtI4wEGwL58etnB2J4pc6u6IgLJAt+3
         63GU7WNatzt8xQbypnZgiA85rLcJDhSiAeDkpMAmF9L/f7bO+nPy8NAvel/JZQLq+Sdp
         PQB3kUDFjO33RpW2jQ+xwIpxdWBZNi9y5DwzydXZqvSkfFu+yAO+BbFQQrmMT5rywzvn
         EScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069237; x=1773674037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmTN4lfqvNBf2NGWRvyoj3Pdz7Zrbn88TVlk/KgiBfY=;
        b=GVYNPnjd4qtbbfZTwKKl/zf3RgszSE9GFlw4NVXPv73LP8cSwfavUJ0WkTeHZWrKCx
         +FruICq79FDCNik799FL4/7sL1c9HftnqXi2UfSjqvVR7ZvkveuHU7fW24Cq7fI5ajbv
         jHZYWFx+T8oF6/2/nmldPi9ErsNVNG8/zY0Enk7zksqSSdRp5BTZ2UTnQ//IxIjDUluG
         EaMmtRUBqTF1bR+BUW7Bz4XsUh7uVBf/yG/5zpaOGLM7RjKdtMclilj9YQXI/BdzXOtX
         lU2GhyyTI/INDaByVfjyjTxvRjoOxO8LSOGGFXPqH1czhowALqLw+q2NUGAmKuWzYaS9
         YmNA==
X-Forwarded-Encrypted: i=1; AJvYcCUFIGQdtmIS8nWLs2f9PlHBBftaTYfpvRlON5/qD16JTCieylECEpTv5UgqOtLEgl3OJIppZ7noK3mi@vger.kernel.org
X-Gm-Message-State: AOJu0YyYjh1EpVDpEvz11aKXVHG082nvk0uM+QByH3/YwoHs9r1RkCUI
	vqF1O3Nxw+mvMUZYZPFMh1nc0wrT96ta47IC4R0Delqv2sapLVvi/e0CRYPanXjVzSEBq/sBg5+
	XH/1H
X-Gm-Gg: ATEYQzyBJFj7G/rK3d1vLMJGyO1C8YWKn4xOEC1BiyIJfCsr41uoxDVgphrenhBlPqi
	sSvHnRvvH9MXU80MpogI5NaVIwBfXAPP2SeTloW50HbCApVnrfRrc1AgSstRSYMWkWsNP9y8gWL
	2UhoNbXNl+CfvEi+4tVJVBH1L8D3ftcLpFL2ykgrXrSdmHihE/JikgDeuSRMZ5/3UJprUJQ4gQC
	7WjcORl1vri5TrjKTd4kQnHupmpCM5Ye39HvBQ/ruSk2Mow/fVu0Jd/8N3rExMPwaX+mpil4s4y
	UQlaTsUapjP8bgq9d4WfNRUmEq2zkfrtMhqKkPl5hv/9u+1DymvAoSfEciGrvv2PGC1XM42YVJA
	10460nXWX+2JHwMyHfH/8wMWsIVMTsXOdk8r6oJGHe7+0UTpS6KgkM8a3nDTZgTiA9i9Nxr3Fxa
	riKyXQS1Wz6rgmKXHajf57IyuB+BEb4PeKoeAQvXEW0cRQDjnAC9Ty4R+aLQO7Q2iyGUwzVOIc5
	HDMAMHq
X-Received: by 2002:a05:6214:224d:b0:89a:909:260 with SMTP id 6a1803df08f44-89a30acc08amr165840456d6.48.1773069237301;
        Mon, 09 Mar 2026 08:13:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316d8936sm85242106d6.28.2026.03.09.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:13:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzcIu-0000000GhN4-0sDe;
	Mon, 09 Mar 2026 12:13:56 -0300
Date: Mon, 9 Mar 2026 12:13:56 -0300
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
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] dma-mapping: Clarify valid conditions for CPU cache
 line overlap
Message-ID: <20260309151356.GN1687929@ziepe.ca>
References: <20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com>
 <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
 <20260308181920.GH1687929@ziepe.ca>
 <20260308184902.GR12611@unreal>
 <20260308230916.GI1687929@ziepe.ca>
 <CGME20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07@eucas1p2.samsung.com>
 <20260309090342.GS12611@unreal>
 <c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
 <20260309150502.GX12611@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309150502.GX12611@unreal>
X-Rspamd-Queue-Id: 7ED5723B8CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17793-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.953];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 05:05:02PM +0200, Leon Romanovsky wrote:

> Regarding failure on unsupported systems, I have tried more than once to
> make the RDMA fail when the device is known to take the SWIOTLB path
> in RDMA and cannot operate correctly, but each attempt was met with a
> cold reception:
> https://lore.kernel.org/all/d18c454636bf3cfdba9b66b7cc794d713eadc4a5.1719909395.git.leon@kernel.org/

I think alot of that is the APIs used there. It is hard to determine
if SWIOTLB is possible or coherent is possible, I've also hit these
things in VFIO and gave up.

However, DMA_ATTR_REQUIRE_COHERENCE can be done properly and not leak
alot of dangerous APIs to drivers (beyond itself).

It is also more important now with CC systems, I think.

Jason

