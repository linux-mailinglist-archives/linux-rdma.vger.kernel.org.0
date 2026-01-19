Return-Path: <linux-rdma+bounces-15719-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C176ED3B32F
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 18:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C5AD307873D
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B543B2F6560;
	Mon, 19 Jan 2026 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LA4MQ6LH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D729BDB4
	for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841927; cv=none; b=KTQ/uBvr5q6qmMkilZ/m1qH974Y+HNroQ6hI5hndZsQfU/+u8/LH08PIY9a9UztiKkq3hLGX7S1GKFM8RJ0DjTKJxsgT4TU75Nfpw0RlkoSSFNE5hbH3Ldqjn89SUMD+7cRX+IL9yaTt8cZNQMacIuBky1yC6OLqtSsRjcnjji0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841927; c=relaxed/simple;
	bh=nsqjKuZBX2xVAZ9wDedc6M6Km3uKRKGPzdUMml50yUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEZ740WU52A04hPtdRYekZNX7olBhc163OG2+uoAedvxv/jvf1ozWYUn4elJLBxNVJcGyMS0V+svDYVem397DayhrWC4wRaklyTy4BdY0Wm8GOoUSwUUqOJLoN4X7ErnjhW9UOyK+TdVpls7Xrza2RyxnvmAq7TmxMuQFUF1iCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LA4MQ6LH; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-88a3d2f3299so46752216d6.2
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 08:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768841925; x=1769446725; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ljxKTxaVdu8I0ces4FnKFMKgo+H8JcchtOlXOe2X8IE=;
        b=LA4MQ6LHmA3jMregg3JwmBDrlNIC6TKyIIRoqsj/MeU1Dsh3Q71mCDdmTdHoGQtVsN
         ZRrHL9mWWJsxeN2FDE1Hjtj6PvZ0arDGUT1e9HZIsSvIjnYe2SpfFRD5sasqcKL3JyXl
         aXI23p8ZI+7yyjhTbA4fRhrjxEC6exVDsBNDz+P/kmEtSJV/CknvREmwrZDJHWYUyb2E
         mNm2hs1qb8JDJ2XVCs7DEo3chAG5VztyMJLYH9BsfjRnrxw4x2H9PKSoWLzxnrG26WNg
         OrhsagYWLmM4Ktp7WrpWShtGcDuHTGATcf0yOQitnpMXIYgJTMfX9eYKKquGpVpl2F4D
         tA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841925; x=1769446725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljxKTxaVdu8I0ces4FnKFMKgo+H8JcchtOlXOe2X8IE=;
        b=B4rhydgjFrHJfMiCHADwhZlpzjNEpWibSgtNWXLsOR72mmi3QdWJ582b+wUp7I9JJ+
         Mbi5n1miUlVAgim2p2CRaOj7ozbNwh46zUz1EABPuqqMLYUYNt/Mhl8Lyen0JU7w0uYe
         QoaweVK+IMbR1WB+c3Map4pgH/gr3VWcvhlICr2cT2VdE/mxLb9PlUGPK7L1KJ0gyh9Y
         SQu0YrHU2GafjGnJUWYxK/Dq7JaxXclWI3VfpfDVrerTvgTynJO8em0UJkvmDoOnMSJ9
         QTLIqAUHJ2ON57Si4SduBiBD8p5PBZ1MR6dhCgX7htCy1NgYMyjb0dyiD4aIg7W3qdhC
         B6HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVHLOqN1iD40s+NJYfPFc1APNgGoaFSFpbyFB+YaQFSzoumYG2qsYom18OA7484LuDLDrKZgw55L4h@vger.kernel.org
X-Gm-Message-State: AOJu0YxbqKwnkAo1H1h8A+aOaITqJU7/cHIvtkX0gOQ2Y6HKEs0JOGk0
	r/qJk8PpNOIzCIz+mp8jrd3Nfc0LsAZsVNiSnn53y1e3WqCw2LLRU6I204UxqV2MvIs=
X-Gm-Gg: AZuq6aKOWc0UaqtTdBeSd1/+Z1l/RVXu+bdVr8nfsbEqRxHakg70lrcJ4kvVLS5IudH
	cnxk2PJYJlkaAERhUQqzrdJKWplFAYIk+5eFmTdy3pOOuMULiiNQvWiIl46LLQLXD7a+BUcHuaa
	AcwrsHcjJvOKlJissxwmxTc+lXxUfkRPRZ6rxugK00ShcbV9v1ctkhJGqFWoZUfCjOodtsKfEdD
	CQZ6KB7H6s8Viu7LeTcmJ6WMnwHQX1yPZFL703nXnFuLE75lGW1pxXbLumuMM/IB8n6ZLBMACUE
	IijHNjoHI6Cw7b2QTrTzswyTdhX2L3M5IeWUFvOraZ/QCYqZ+7MKr35SYn5dzoCBKhpTs0PVIuX
	sWCYqacMWEkROPoNTxOT5vbs6gMA2BXKIavljyR0T3lt+Z7VFVbl4bOfZySxiId2yAxvL3PTOdG
	VQFxHC6lFI7VamerQ1vbX9vQqOpAil01z3dBHEv/kaNuVQURS/9fm/ccVuVWX5Si2Zp6OWBDJ0L
	4TjDA==
X-Received: by 2002:a05:6214:2523:b0:88a:2e39:957e with SMTP id 6a1803df08f44-8942dd9e90fmr129930286d6.57.1768841924690;
        Mon, 19 Jan 2026 08:58:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e526dsm87021366d6.12.2026.01.19.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:58:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhsaR-00000005IQb-2Wqn;
	Mon, 19 Jan 2026 12:58:43 -0400
Date: Mon, 19 Jan 2026 12:58:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dma-buf: document revoke mechanism to invalidate
 shared buffers
Message-ID: <20260119165843.GH961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>

On Sun, Jan 18, 2026 at 02:08:44PM +0200, Leon Romanovsky wrote:
> Changelog:
> v2:
>  * Changed series to document the revoke semantics instead of
>    implementing it.
> v1: https://patch.msgid.link/20260111-dmabuf-revoke-v1-0-fb4bcc8c259b@nvidia.com
> 
> -------------------------------------------------------------------------
> This series documents a dma-buf “revoke” mechanism: to allow a dma-buf
> exporter to explicitly invalidate (“kill”) a shared buffer after it has
> been distributed to importers, so that further CPU and device access is
> prevented and importers reliably observe failure.
> 
> The change in this series is to properly document and use existing core
> “revoked” state on the dma-buf object and a corresponding exporter-triggered
> revoke operation. Once a dma-buf is revoked, new access paths are blocked so
> that attempts to DMA-map, vmap, or mmap the buffer fail in a consistent way.

I think it would help to explain the bigger picture in the cover letter:


DMABUF has quietly allowed calling move_notify on pinned DMABUFs, even
though legacy importers using dma_buf_attach() would simply ignore
these calls.

RDMA saw this and needed to use allow_peer2peer=true, so implemented a
new-style pinned importer with an explicitly non-working move_notify()
callback.

This has been tolerable because the existing exporters are thought to
only call move_notify() on a pinned DMABUF under RAS events and we
have been willing to tolerate the UAF that results by allowing the
importer to continue to use the mapping in this rare case.

VFIO wants to implement a pin supporting exporter that will issue a
revoking move_notify() around FLRs and a few other user triggerable
operations. Since this is much more common we are not willing to
tolerate the security UAF caused by interworking with
non-move_notify() supporting drivers. Thus till now VFIO has required
dynamic importers, even though it never actually moves the buffer
location.

To allow VFIO to work with pinned importers, according to how DMABUF
was intended, we need to allow VFIO to detect if an importer is legacy
or RDMA and does not actually implement move_notify().

Introduce a new function that exporters can call to detect these less
capable importers. VFIO can then refuse to accept them during attach.

In theory all exporters that call move_notify() on pinned DMABUF's
should call this function, however that would break a number of widely
used NIC/GPU flows. Thus for now do not spread this further than VFIO
until we can understand how much of RDMA can implement the full
semantic.

In the process clarify how move_notify is intended to be used with
pinned DMABUFs.

Jason

