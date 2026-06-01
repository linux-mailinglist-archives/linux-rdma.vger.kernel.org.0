Return-Path: <linux-rdma+bounces-21590-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAMiBJDGHWrgdwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21590-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 19:51:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCEE6237C9
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 19:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3772C308AD7D
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 17:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814E23E0745;
	Mon,  1 Jun 2026 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JBYhAqZc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063A3E0224
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336058; cv=none; b=DKQqlXsPBKUtunsiV/Ggj01rh2aAPTAVhUFRGMhEtguc82EkkgttjkH50Qu44IgGGxDwYEWVvVbbrOo64mhltFgKEW2sOm1bz58VXgWjrUamsLAjZt3dKHkANn3EWXj5NVaKMAUThG4nKzVUFai0fkRc0EXhXBzuSNTJSWUmE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336058; c=relaxed/simple;
	bh=eDqBBuInzy1c9i8vrcrIJaFNBUagTiKlEOwIxuahu44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1Yv0dA+8ukbnCjTLrMECRI79umZGfSXaoYsoxSqnSk/sqggYs1uu5lz9PV9cFA/scP9zXApteTZOVo8i5rUvX7kV8VnNuLO9B0Ck7MzFXfY6zkIBYPXo/NFUYhRx/ULiBrMIl7NJd/0ebJxuyW85ZqvljTriU4pZEic0cxykrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JBYhAqZc; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ccce57762cso54642046d6.3
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jun 2026 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780336056; x=1780940856; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yZ9wJintER1aMQNJJDa24+/EucywMy/j2tmrZTRhl8o=;
        b=JBYhAqZcrdFABjH5HkSQ6NJsusDEPyaNx3vvmooevzrPf3fMyIsolj2AUHjspXjR4J
         F+nNZpzC3j3+xoAlPApfQdRSYv+RnG6xCEZkXzj+zLkyaUM6f07ZA1bK029II7sRJZQ1
         8mb6mCs7R9a54RwfAQBulmx1bryRUrJlOdCYoJLLDXvqsVZl63EOjr6deLshJ19RTTaX
         QGzMfSIm+4yCJd6s95DC0nEXdjkww26ZXt8SONmsbMRO20uIg2ozGQXqZWMzQv56i6Vc
         I3XxWperKVcR5Nh+gvyaYcp/1GBDI9Pz6SOhcKd4W1FuS1+KYCw/MA9B8XunvL20LNGF
         MGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336056; x=1780940856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ9wJintER1aMQNJJDa24+/EucywMy/j2tmrZTRhl8o=;
        b=oUXA9xKz1klXcxiOe/knWf6Cef6+C82FHoHDvNoeozpWoZ0ct3SEcXJNhdlTn1WKI1
         4x9YZGn+lEy9SXShHqpQ15GNrNh4B3TXmCQLJj1rnQj4ZZJXD866iadwih9Y2D3v3W6P
         wKpgKN5HFau1lZZD7OC5OBBFid3fSXne3bR7vXIdgGu3kNcZ3N6yO9hidOi1c2EcQfoi
         9Hwmc0evwtvErlhmSoqk6XA0AoGSHab0HsZi+LulJCLgjdGjtRoj8HN8cUl+4aVc3luq
         AHG+XhCA+Y+XCd3nHg98YirfyNOG4aPemUE8ych86YKLjlD4L+Qh5qh55XKfseJUHToc
         rnxg==
X-Forwarded-Encrypted: i=1; AFNElJ802yvGAJxdLNymJap88JMtj+8tMzP1msq23AAT/C7ybuddP7LUMKEdKeajoYmI3CssZS9UpoIoyaod@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqnyy+f1UOOzuNwBq+tdjgudx8hMOE71gErWSJvIcHF73ptkxq
	qY2pDg5+br78mDLdPixYwHP+8FWxEiKblHNERsEZ5QL9cvdfJmqpg8AFD7CpsAAuXWg=
X-Gm-Gg: Acq92OFQp3BIUrBy7gN/AkdId5g2pQdPwuydbblmkG2VTwnpbW6xQuHjk69aI91AADw
	dZqRU2AOFYe2rCPj2o1nJllc6EGEoRDkrp7p5iYjkXXgf7qGfVWef5a/hiScc1Y+1uPyUBJke5o
	226nCwqOoz8WLVl4Dujh2vgNLP6ffGT/KovN68JsSKCrMR1cKDmQhFeQsRwjGaqf2vvmZcBy2OL
	PoTXqZ6YxUO/0j8Et0tezW/TycB12sugq4NhK/EeInfLDnl8N5sFodzbFmcdCdeK4PxqiofGG7c
	RyW8yQlqJC13iEW0C3zQI4CObCHXvipB9rwO7oDQrqfAKlGSmZljwbsjpg0CfKb/W1o/YvASi+0
	Aryuxf6Ugu1r+UfqauvRnr3Qoa2hRBS+bzdbep4/660Hs07jctXIa0wlqPsn0hUgLgXO9ChgFwu
	EgICqYRoh9dnP674W6HIw0F/OYI5UayHwiHlJjUPaFoLjhBnj/icb7+JCDkkaKlQWonjUo6HXXg
	5WC9wR2NudBZP4E
X-Received: by 2002:ad4:4eec:0:b0:8ac:b258:71d1 with SMTP id 6a1803df08f44-8ccefb29374mr211892386d6.3.1780336055817;
        Mon, 01 Jun 2026 10:47:35 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea25f64bsm96664256d6.47.2026.06.01.10.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:47:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wU6je-000000027Jd-2qcE;
	Mon, 01 Jun 2026 14:47:34 -0300
Date: Mon, 1 Jun 2026 14:47:34 -0300
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
Message-ID: <20260601174734.GB2487554@ziepe.ca>
References: <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
 <20260529201130.GU2487554@ziepe.ca>
 <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21590-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7BCEE6237C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 11:59:55AM +0200, Christian König wrote:
> >> When you have a complete open source driver stack which utilizes
> >> VFIO passthrough as the interface to communicate with the kernel
> >> drivers then we can eventually talk about that.
> > 
> > That decision is not up to dmabuf
> 
> Yes it is. This is the DMA-buf API which is added here.

It is a DMA-buf kernel API that is added, I think it is overreaching
to try to veto a VFIO uAPI that calls it..

> > - what VFIO subsystem requires to
> > accept a new UAPI is up to the VFIO maintainers.
> 
> As far as I can see vfio-pci is used as a stub driver to avoid
> opening up the real driver.

Yeah, that's probably true.

Frankly, I'd rather they use VFIO like this than to upstream another
driver for proprietary custom built HW which nobody except Meta even
has, let alone can use.

> Upstreaming an API changes only makes sense if others can use it and
> this here is something completely special to this particular use
> case, without all components involved nobody else can use it.

It is not 'nobody else can use it', if it was true VFIO wouldn't be
leaning toward the uAPI being OK.

This exposes a PCI SIG defined TPH capability in a reasonable simple
VFIO uAPI that can be re-used by any other device that happens to
support TPH on inbound MMIO. The uAPI has sensible general semantics
based around the PCI spec.

Anyone can repeat the demonstration Meta outlined in their cover
letter: Use this new VFIO uAPI, import the DMABUF to mlx5, use a PCI
analyzer and you will see the PCI SIG defined TPH bits set the way the
VFIO uAPI says they should be set.

There is nothing uniquely tied to Meta's device here, or unusable by
someone else's devices. Arguably this is actually a mlx5 feature to
allow VFIO to control its TPH generation HW.

For a long time the general kernel has had a philosophy that as long
as these niche features are generally implemented and *in theory*
usable by anyone who wants it is OK. Every knows the initial userspace
implementations of *alot* of stuff starts locked up in proprietary
software owned by database, and now cloud, companies. Yes, some
subystems are stricter, that's OK too.

> So as far as I can see that here is a no-go. But at the end of the
> day it's Linus who needs to say if that's ok or not, that's why I
> put him on CC.

Well, based on what I heard when I argued for fwctl, and the
discussion with sched_ext, I don't think implementing functionality a
standards body defined in a logical way is going to raise concerns..

Jason

