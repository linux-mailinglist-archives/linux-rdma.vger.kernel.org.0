Return-Path: <linux-rdma+bounces-15732-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351AD3B7C5
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 20:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9EBB302FCCE
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 19:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0650F2E7657;
	Mon, 19 Jan 2026 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y8xzswM1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97AF2DCF58
	for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852490; cv=none; b=eLRsvkvuj6+Q8wh+1FaaPvZsOHcF3XXwSnxwWbb/zHLgJ3/ecgz91vz018qCdJIlx6s4pH+E6jHPOkjrHTPp3Jn6rDbWViQuTn/EPfWpbZlOsCDI+uYGFPERLUwHsTPm9Ts7QSA8/wVLURaopnTIc9e00NtrjRS9C+31vCYjquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852490; c=relaxed/simple;
	bh=EgdbrvHnoBh/zDpp9ewcIGQxrvWxBBXiNgVYU0RjdCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVQo2yWrTGClg/JliYMwi7NqljkXyd7DweQeXRmgd+87RgNBTs8umAtaRcCzQLj9opdBYUHh4gZfjoiSChKncmCRM0r6s5qVeYmu095Y4Nyi/MPEYDAYZ+UokHWNxmlAq42XSImzrb/AXLKqNevW7osobUauBrUq6G18ihhpMC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Y8xzswM1; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c5265d06c3so561414585a.1
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 11:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768852487; x=1769457287; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zwZ9o3ha19w1BUlcGeJzNZvsy/mlKSz+FRMjn04+Z/c=;
        b=Y8xzswM1blPsOkAhqH9fGcG5IadYE5sQt0vvRXgZTPwAqYIsRh7nfXeu6jNChZ9hKz
         pxh03Sf81TJGk6WYR/8QTTKv0398gWd3wYINx05q1DLlmDzVVk/NEVNNQwO+bPsjiEM+
         DwUUbkbk10s6Fp3bgZ57bQyIFL/QYcj3I6o6+LDJWtvZc2pKLOJKUzT1qPnWdD8nfsB8
         0yCZUa/cLOmqCmhtbTBryPRqR8QJa6sP4qKlGepQD5Upo2SfzMS2mOKHpFphA7+f7C5J
         BP85MmGwAh5gJ4jJ++0ltmFsTXWDGrIdPIsFj8/s8hh9WLBQHyZMI9O4mkorRJ3DA1nv
         FZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768852487; x=1769457287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwZ9o3ha19w1BUlcGeJzNZvsy/mlKSz+FRMjn04+Z/c=;
        b=E+qzGaizUJ6VOSsUViMQibeqLq+Ym4cN3dmt6R2wszbljg0k2f+FKmFSz75N4xIn1B
         4pts2E3do87gNMRi6aUsvxf7sahjjjxal1YRXcvI0SL7pFY3EBSRiMeivO0IZz/Cv/Ru
         cP5G6iGcHft1lddRCIqwf3LaH0uuCOK4ty3/fS9ZuU24imWF7I5VB43TU6hAXO9U0zbP
         lWV6SHGpsLpDmwbEJ3JP0mpiZuLMibsUrxqpi6X7Yi6OAEJSUI411TPHX/B3aM6sgqpq
         nPOSc9IhPCz6J+5oy2+subk+b/leq8cwdcRALxD4ElFrmBHef5A25UFKbfrc2eoawCxE
         Yojw==
X-Forwarded-Encrypted: i=1; AJvYcCXYDuMonbFPWBDz5Xkl0ybfGXoRK4K5b9BIpwaA91nLla8WXGN65lbrZgbqGxKwxXVRkM3xyUMyg8UZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzH4PwuZC5/yHP05sXcXnL/V+LV73RVAAlo/dHXzjOArkWJQzgI
	qFwycac0LQq3J04dV911RubcGrRP7IRDE8SXHvv1HzS+YCU4OQZvKvXio4AxSw6sfZ8=
X-Gm-Gg: AY/fxX5vrlBfojeRzJfeIgYAmvbvBWNaG5Z6y0p7YEHrkESGlVfCRC8VkhVwUkmN8Bp
	HlJHRhnTbsWPMJM11i6looaHJtr3/X3paNOfYEwl1QEZqGegAEA2yOU/5w2oaviRpsmTWdARs2W
	tOG65Vy/HmsfXpz3BhpssdNlT1i/WX09x2ws5n79ZHA9kZrhDbB3cKBHFFnGeV8ZE/YgSFJ793g
	zGZjyQ/x3XxLSj6fKAuc7SUfutf0TCVb1uVU1x876GzR7UkzOJvKrPFgd6sutXnL6bFd63CG+Tf
	/X3daKMFrPWBtaES7UtGLKqS2YQ7q9MHwCAYtYK98wGfkIvrwU8Rj31FrJ61T3CSUZ9vphcgLEv
	H5toRFofPklFh47x2MC5o/2z3b+ncBwTZ0436RFZAEtrIt3ZTuvTkbrFZTBxnP+GZE0xnmlnq+G
	Xko61EzZTqNy7/iBEJPyz9eZif7LM7kl1xMNp7XV7ZAXJVqNRbCk44iaq7AhCbeDaTyXk=
X-Received: by 2002:a05:620a:4606:b0:8a3:a42e:6e14 with SMTP id af79cd13be357-8c589b9706emr2117693085a.10.1768852486747;
        Mon, 19 Jan 2026 11:54:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad75asm86947906d6.31.2026.01.19.11.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:54:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhvKm-00000005JRT-0mKA;
	Mon, 19 Jan 2026 15:54:44 -0400
Date: Mon, 19 Jan 2026 15:54:44 -0400
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
Subject: Re: [PATCH v2 3/4] iommufd: Require DMABUF revoke semantics
Message-ID: <20260119195444.GL961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-3-a03bb27c0875@nvidia.com>
 <20260119165951.GI961572@ziepe.ca>
 <20260119182300.GO13201@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119182300.GO13201@unreal>

On Mon, Jan 19, 2026 at 08:23:00PM +0200, Leon Romanovsky wrote:
> On Mon, Jan 19, 2026 at 12:59:51PM -0400, Jason Gunthorpe wrote:
> > On Sun, Jan 18, 2026 at 02:08:47PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > IOMMUFD does not support page fault handling, and after a call to
> > > .invalidate_mappings() all mappings become invalid. Ensure that
> > > the IOMMUFD DMABUF importer is bound to a revoke‑aware DMABUF exporter
> > > (for example, VFIO).
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/iommu/iommufd/pages.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> > > index 76f900fa1687..a5eb2bc4ef48 100644
> > > --- a/drivers/iommu/iommufd/pages.c
> > > +++ b/drivers/iommu/iommufd/pages.c
> > > @@ -1501,16 +1501,22 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
> > >  		mutex_unlock(&pages->mutex);
> > >  	}
> > >  
> > > -	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> > > +	rc = dma_buf_pin(attach);
> > >  	if (rc)
> > >  		goto err_detach;
> > >  
> > > +	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> > > +	if (rc)
> > > +		goto err_unpin;
> > > +
> > >  	dma_resv_unlock(dmabuf->resv);
> > >  
> > >  	/* On success iopt_release_pages() will detach and put the dmabuf. */
> > >  	pages->dmabuf.attach = attach;
> > >  	return 0;
> > 
> > Don't we need an explicit unpin after unmapping?
> 
> Yes, but this patch is going to be dropped in v3 because of this
> suggestion.
> https://lore.kernel.org/all/a397ff1e-615f-4873-98a9-940f9c16f85c@amd.com

That's not right, that suggestion is about changing VFIO. iommufd must
still act as a pinning importer!

Jason

