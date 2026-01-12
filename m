Return-Path: <linux-rdma+bounces-15464-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66671D130A2
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 15:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E7E330248A4
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 14:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DA935CBC6;
	Mon, 12 Jan 2026 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EOQ+vO6S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DF635CB76
	for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227285; cv=none; b=fEd6PQ2rMRvTXo2xtJzuIU3bH+P/WsDSBOGFxmRifNrPYzG5Gw0W0QcOQQ+NFsP30HHR0gjpMNBafaYHdYZCYiQUng8MDW+glkkRg3BvTvW1eKTEKDq9AtT8xmxMTRPlxS/tS9WftJzOCX0tEqmcvySA73Ek6dChtX0tLX6HGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227285; c=relaxed/simple;
	bh=7i+3sgepeIF+4tn63uCW3DQ06nMK9p9dLiQLzqgxtAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTgI3ruXmgQYL31h8tXD5iOdVkIIU+/dGpe7sx4R+z1hbszDbv/9gCorT0MuFFzmBQXyPHfzKXarahjamc43eFF+tOZHfe4iOypr0Xq9fluBmdYRuLXjcQSTKqikBVo7uBd//9iQcN6cFiJb2UjOXd+U8ix8gj/MzPMReNxeV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EOQ+vO6S; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8907fb0188fso57093836d6.1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 06:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768227282; x=1768832082; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=idOldAb4LAo0ksi3bVUeAksa3fPCwgsdaazjCrmLC+c=;
        b=EOQ+vO6S8eClCM/BQB4cAc+L7WeEQ7IO60ocoVnoOu9Lt+9pXX6YH+ZuWRL+22kqE7
         rPRAKtnv6FPUB6zcliaw2AzOLLDtr4ORjVGm5/h/2XWh3EK1bLGu3oa+lFSgLBFCvQtM
         PmNCMvieF6zzsT1tTxV3E4/b9T5YZO8Mcb8QXRZUUh3zJBZXQITbR5QZYDaYWPXl+i8/
         X2/0o6IJhS64mvTLGv7GetsiwYp695c3buKnyIRPCLTnTaRse19BoDdz1jhsre+hVOhS
         GvvlYMo0YLe9pV3j1PLYU7J8BevvVOsDVU306uklMiks27kAsRB+4GJPOw2knlVn29x4
         hOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768227282; x=1768832082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idOldAb4LAo0ksi3bVUeAksa3fPCwgsdaazjCrmLC+c=;
        b=Hm2aVx2fXDd+CMq9c7uzZIl/aWic1CXYkcw4SWUfrMlDFqcafGcUCoT1gXPTl8YE8F
         691FLcxc31CDxVz8GhP9+sUdIcWQX2k9C72ntMChmQAHYGbk1rzcikYkmtcAzYgcikOr
         EMk1KKJEjToNy8BO9ScjF0afgeMkDbIOWcY2Ph/a4hIloxTUlZGXrlWsi4yNtqMiCsVw
         Vzr0kMRLPIHpS011uU9qwn/gCamlogKhlYWOLTG3aw5XaE/yKguEA1wihqCMXuceljSO
         S/p4QkuzjSajmXHd1vM7VbTZEHhficRrNvvhLl7cNI4xUtf0BnDNGA+xZ+5h0hP6r5e9
         B8qQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Qei+DEG7mx5rkWLazjfWFLeUR0OG2pwy/bmFGLUSPL0Lxl4Y9+pzGByAtJwFxRj6lWscVs2sysAN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbvkj90Kz0MNMtXFhWczJqJrRFUgCjsQ32rf6nXqIEauSM5qUU
	9a76bx41eu1D+SJ2q60sVRhrbuZqTJ+/vjYQspN8SEn1nrhy4WGDEVcm05roS0SnJkY=
X-Gm-Gg: AY/fxX7nZZVEU4ft5Fm2Lxx4GEJsMpQfFRmrcrpD/O5ccY9PxcYhNH1UZBj2uZp/NHM
	glzAj0ZVEO5x6sAHn3qb3GxKYR8HCA39WvHklE/siQfrSQ9J9UlVJIBpFjwJ9wa5iivjYiNDzIb
	no16/5Bn6x4HYOTdHWRAdStq3ZxZAqJFC/rgcOm8B/Fu1IUjfXJ3z7ZO/mFgpfUPYEPX0CEmuHk
	Wks2Twyn01oueEKixNm8yNXUilTdTpasEri7noB/inp9uq0gN6V1GR+WoQKRUnw6oshlRHSUtzI
	cNPSFKvpCgvS+6fJ8r+8AvJGj8mljBT1HZK3fCuwD/EE9codtJh+axwo33UvyO8kkFGa6cSObcL
	Gy4qYnu7rlWVfOrCwHIRAP3k6K9ySNF3igTzp4K4/aS2OpGu1qMvCNMyY5JPhPljymM8fOYe4rb
	hchHPwuuUC+N/B8eAw2/5pUZ9QW/GDyR7Ne/cqCwqXuHSIDgVIXcQ4WtUtux3ouiqiUog=
X-Google-Smtp-Source: AGHT+IF7Zvp/3g9UZvP3sG1m9fZ0kBeHeUwdq4Y0K8ZVazGpfRYYWPSZc44gsn+OV4Jjh6pl1L7JlA==
X-Received: by 2002:a05:6214:460e:b0:888:8913:89af with SMTP id 6a1803df08f44-8908418b4f4mr232874836d6.15.1768227281987;
        Mon, 12 Jan 2026 06:14:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907723436fsm157350086d6.34.2026.01.12.06.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:14:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfIgr-00000003QFh-01tA;
	Mon, 12 Jan 2026 10:14:41 -0400
Date: Mon, 12 Jan 2026 10:14:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Simona Vetter <simona.vetter@ffwll.ch>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 0/4] dma-buf: add revoke mechanism to invalidate shared
 buffers
Message-ID: <20260112141440.GE745888@ziepe.ca>
References: <20260111-dmabuf-revoke-v1-0-fb4bcc8c259b@nvidia.com>
 <eed9fd4c-ca36-4f6a-af10-56d6e0997d8c@amd.com>
 <20260112121956.GE14378@unreal>
 <2db90323-9ddc-4408-9074-b44d9178bc68@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2db90323-9ddc-4408-9074-b44d9178bc68@amd.com>

On Mon, Jan 12, 2026 at 01:57:25PM +0100, Christian König wrote:
> Clear NAK to that plan. This is not something DMA-buf should need to
> deal with and as far as I can see is incompatible with the UAPI.

We had this discussion with Simona and you a while back and there was
a pretty clear direction we needed to add a revoke to sit inbetween
pin and move. I think Leon has no quite got the "dmabuf lingo" down
right to explain this.

 https://lore.kernel.org/dri-devel/Z4Z4NKqVG2Vbv98Q@phenom.ffwll.local/

   Since you mention pin here, I think that's another aspect of the revocable
   vs dynamic question. Dynamic buffers are expected to sometimes just move
   around for no reason, and importers must be able to cope.

   For recovable exporters/importers I'd expect that movement is not
   happening, meaning it's pinned until the single terminal revocation. And
   maybe I read the kvm stuff wrong, but it reads more like the latter to me
   when crawling through the pfn code.

The issue is that DMABUF only offers two attachment options today, pin
and move. iommufd/kvm can implement pin, but not move because they
don't support faulting.

vfio and others don't need move with faulting but they do need pin
with a terminal, emergency, revocation.

The purpose of revoke is to add a new negotiated attachment mode
between exporter and importer that behaves the same as pin up until
the user does something catastrophic (like ubind a driver) then a
revoke invalidation is used to clean everything up safely.

You are right that the existing move_notify already meets this
semantic, and today VFIO exporter, RDMA ODP importer even implement
this. Upon VFIO revoke move_notify() will invalidate and map() will
fail. RDMA ODP then HW fails all faults.

The problem revoke is designed to solve is that many importers have
hardware that can either be DMA'ing or failing. There is no fault
mechanims that can be used to implement the full "move around for no
reason" semantics that are implied by move_notify.

Thus they can't implement move_notify!

Revoke allows this less capable HW to still be usable with exporters,
so long as exporters promise only to issue an invalidation for a
"single terminal revocation". Which does nicely match the needs of
exporters which are primarily pin based.

IOW this is an enhancement to pin modes to add a terminal error case
invalidation to pinned attachments.

It is not intended to be UAPI changing, and Leon is not trying to say
that importers have to drop their attachment. The attachment just
becomes permanently non-present.

Jason

