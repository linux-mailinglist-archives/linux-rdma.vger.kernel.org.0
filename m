Return-Path: <linux-rdma+bounces-21527-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHhWDt/2GWos0QgAu9opvQ
	(envelope-from <linux-rdma+bounces-21527-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 22:28:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B91A608894
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 22:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C8AF307B564
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 20:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D124835E922;
	Fri, 29 May 2026 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W6mucJMI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437C3346A5
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085494; cv=none; b=h43YDHRihOQ9ConOzG9hzc1LEZbCSM47Y/cItM4OmfY5O8J6fbWCA32pgIOCz4n32byzzgaGCH1vNK7dQniZoFxSZebChcETyW3YgtsoAfqQWlpfuEMpi/lpVCRUMO25Yzcz/lEtuw70B5LnYTiaQQr2JIGxjy30KXTiVSS1HFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085494; c=relaxed/simple;
	bh=yIjjEsSzcNVlj5Jerb5VL9COIWs3RWb5zUy94AhWr9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pS/TxtNSB3wdShL4/oV5OHQDYsSY4alSgZt7TFJHTWzy5W0n4Z0StymmTr9LQi3YaW2RQhJl79BFjuvTCGoU8k6wH+eRaH1nNsVCfyT8fgAN7AbmfOXYA04rWF/BdjPullgueZxt+bSs2BJqC4aQNb6NHeeJd5tvEVb8kMzNfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=W6mucJMI; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9144163319fso1509299085a.2
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780085492; x=1780690292; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x50nMfXuC2+erTFJFRG2pVEkXmZORi5k9T8WBzn0C8s=;
        b=W6mucJMILm76P1OvgIkeoQrHk1o7XL8eEki7XJZS1XS2OjCf+Mt31OyMtZjR2qaphh
         JYplHQ+jawZn32wdHnTUZ7/BfzMzKsTBm8Fig6rF907+pur3pR03NcbXI3r1E4jPnjWi
         Pj4l7r9Cd2P7VD6P6PcOKOr4ri/urmF4R+FIVF9YA78pTdvWQQSYvF7Z7feosxpyprw7
         +tFE69MQ32W/Mxl0Hefoqfx48geK4OASrV2q31UfG3eYxFQEg3WoFwURPR8t8K7LU6Z6
         3WzIrlfGGwk+6WgLZUiy5+fga84k7c35MG0crSnEaA2c5absa3at7TeFsmJ2pdiwI3bK
         qt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780085492; x=1780690292;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x50nMfXuC2+erTFJFRG2pVEkXmZORi5k9T8WBzn0C8s=;
        b=XtX7FPZyx6S1EVKTC3EUW3CVXEt3UgOOJk+Gr53PiMQ57d393Z0Q3aroXzk0p8EGxN
         r09IpQfAZ80XzOl1oGTL5O+iSY4ELcSSucxQACLrlrmllJ0nPlaOSnyxnRalO8+dVoVz
         k6XFj2mqdKQhBlCtS9Q0FKsgoBkibEI/CLdGAaZYilrSYCTMgM6vwBPcDhC85udYxBLE
         ZUl5HwuVfqsrm+3YsgjgFlJEdChBrqSpuD6ZK9w/tq2IvRHyGW8Xoa9R5vLijiglOQJ4
         CPYd44B8cnWvqiSvmKPWPLcjEtJhSDTCPmWo8Od4TE3lt7MUUo9PfEDMP9N7MHKuE0mo
         A8dw==
X-Forwarded-Encrypted: i=1; AFNElJ/x0SumGaur8SYfJ0a3f+9jQ2BgEhJ2dDy9YX9JZpBGbmSmHk9wsGCKXGaGZpMBHiAKJp4IbG3q/5/d@vger.kernel.org
X-Gm-Message-State: AOJu0YzFmtlLUksNO/xQxvhXKniNijUchgLFnOeiHkER+kY8Bi/4KxWt
	0wvL34/t0YSmF2YNRkAgnnMbGrOiTV9MjQgjHO+fqz3UcQ/PnCBY/806uPYQPzpA51P43kiby2Q
	gKaxu
X-Gm-Gg: Acq92OEev1o8rcqILNOxSwxEJPl9dVdeRl4aJrTljroCCZsZJRwit71Mc7uRepROCtA
	wqegDWTjjK5BZb/hPeZET+5eTtScuxPhIc0HfKTYK/uC1flfdZs8NAl+hn9bsB8ltP7k2N7Koiw
	+DiF8YB5B361PKVgi5xLufgno7Vyo9WGHuqJcNAmqEdOYTbIshmBJvFczYB59RwsuQjgOjG+2/y
	7/rJpZ+1JK9XEhmvhUVXTnHvN2lY2Om5noG+N431Ii8UECJQ/72Z6syBcnhU2swjEqfG68PsxgV
	FqkcbcSeq4JsUgIHHvlWVGGp4VT1e9McxCikDzG07OtOJTAA0HY1J2r7wTXyfwu+bnXBrbmOtUs
	FTDQHTqbQrZV/FmNEDpu5KN8KbGpIpQII3ppWbX9Vg5AhaqSROBmwlpWVCDG3zcqGb8C3v2AGr8
	hk8ct6EX0NAwOk6kEBFLraqQcVo3uFuUuetoV/O9NhldHrsabADBg3Je3b15SLVumN/lacOM/g/
	ZPr3cf51GaZamM0
X-Received: by 2002:a05:620a:649c:b0:912:671b:d090 with SMTP id af79cd13be357-9153d999728mr194543785a.24.1780085492316;
        Fri, 29 May 2026 13:11:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153244de53sm312617585a.8.2026.05.29.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:11:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wT3YI-00000000q8h-45Mx;
	Fri, 29 May 2026 17:11:30 -0300
Date: Fri, 29 May 2026 17:11:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260529201130.GU2487554@ziepe.ca>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21527-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 8B91A608894
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 09:36:00AM +0200, Christian König wrote:
> On 5/29/26 08:34, Zhiping Zhang wrote:
> ...
> > There's no in-tree vendor PF driver
> 
> Well I have to admit it's a bit on the edge but this sentence is a
> show stopper.

I think he means the device is not SRIOV. vfio-pci is the in-kernel PF
driver.

> DMA-buf is an in kernel interface for buffer sharing between drivers
> and any change to it needs an in kernel driver as justification for
> the added complexity.

vfio is the in-kernel driver, this series fully shows the in-kernel
API using vfio as the exporter and mlx5 as the importer. It certainly
meets the standard required to show in-tree users.

> When you have a complete open source driver stack which utilizes
> VFIO passthrough as the interface to communicate with the kernel
> drivers then we can eventually talk about that.

That decision is not up to dmabuf - what VFIO subsystem requires to
accept a new UAPI is up to the VFIO maintainers.

DRM and VFIO have very different views on what is required to merge a
new uAPI.

Jason

