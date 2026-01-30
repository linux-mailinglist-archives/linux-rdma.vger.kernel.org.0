Return-Path: <linux-rdma+bounces-16211-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ueCBLZb4e2n4JgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16211-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 01:17:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E9FB5D61
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 01:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C5373016281
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 00:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3233A273D9F;
	Fri, 30 Jan 2026 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KA7biT7z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8432417C6
	for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769732236; cv=none; b=Kg1+pNkCQmL9Ot8907hj1kvRx10i71MEMVaR9knFoX74TufBsmVn/aD8eA60NzmB4P8oYRinaZDercQFdyqWmEuA0jhjSniXD+pP/aG1+fBY9RL7SI2agjYUyHNGP97WTvYUFcIIayKkCYPLc+pqRTS5cUnorR74y2V3W3IK6ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769732236; c=relaxed/simple;
	bh=PgxWXxtJeqUdvgjP5KxrfenUWVrCXmnl/Ip3hY3gzr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHufKybpIwYfcUotPTv1PI+x+pRazx2R8J9Gj+dT91eg4okioE5LCf6PlLH5dzdoRSn+cE5Gj0K2/E2zQKiMgJM1Z/rWmHBW7iH0+sRyo1MYrP5/N68hFxRm7GcONLIBFLsRBYDdix4m4cVW7WoQQY6wkIqXogvGot+JxAnjlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KA7biT7z; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c532d8be8cso157741885a.2
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 16:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769732232; x=1770337032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JQnCcQDZjp9U0R1Q7JCyNDeekOxxS8phMo1p2crcsis=;
        b=KA7biT7z2WPIJqn1yWtupwtFpuiVSND6sCJuDPiqtvlV/udtpzWhHBdHKHzdXfdrt9
         s5ff0uj0MnRJ2qUUQNgrd0lk2LV/u1TJUfKQTbzPIGnBZoQoPXVw92tOcr4jJ+o6LTsh
         pmrSmwNEYgAYmP11U4AzdudTpUbSJ/6lGl2fTB0tpVVeZ5pwjPdB10zBv03zrqTMm32F
         XRxwdujmIDrabfqlhXdKEogyduDcZ/LafEpZu5i5+k5xCZIZggCdPOPnVishQAaKjj5E
         KENQjSUQFCVdWDnSRyM99hu8FmY0ffQviK954nkYYxdhylaquDPwhk4OhuIA+A5fqMJJ
         rp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769732232; x=1770337032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQnCcQDZjp9U0R1Q7JCyNDeekOxxS8phMo1p2crcsis=;
        b=DGAq3nC0hPRD6TgqWm3vR69RObnsqWjm/jQU3X9X4xrSIVCwHVtONYFiNjcdW61I97
         trB0aisSK3r1T/1ToT/PKjaqKm/IE4mPIIfn+DM+MGd+5K1WV+lY8K1ByiOvtAr0H3/l
         EVkHS+d1m4Rl0dOT/8mqdP2KutgKuInaLFv9CXUqZqXGldf6vrH1Y9UDOcXEPXwjaO3G
         jthSwj6MwWhLhngogbiON36+LZ65Kqr2V53yoUPavWFynCk4EA5bJwOJJvphpFFJ7VaH
         sHEx1iQy5l0bWavwmAQO9KAKadc/pmePKJ6vwnadKuPuam3iH4B/lNqsfndHXwKuPyU3
         PpMg==
X-Forwarded-Encrypted: i=1; AJvYcCWtnqTXkhD3TWhjJTZ68VaKBgj/wodatuC3hLlbo4H/uhV1mycmpA+y382lwSV+in0qJshQTXTiLvZi@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUQPdk22xqx7FQmHbrbVynm4tllCWvFDTiWB50dpGQJrm1KbW
	h2KykjH+zFUgWrFoieLWfpWUP7rQgKm4IBPTsbEWCm666IssVpL+H61TrZ1JXvCg9Tw=
X-Gm-Gg: AZuq6aL30A+hZMNGlrjl0xFEgA/1LwTlBm2it2kilYya3MxvlmQYhKGu7wF7FlYzDUa
	nwwVHVelZlutnUQDbGT426uETgNzlwxPNnfNBTGLoLIvadwdkSawGEIsyZ7gPa77WsQnM3ZM4Rr
	B8Z3+8JPnuBvj0/tIsi7H0EnqVAE66Cn79xaj3Zwz3LcXNdvTRqL/kkssPQrBcPlZSgo3w8BIur
	4ENWn5Rn1y0tUn0O8RKp91cJ+h4qI9sW6SSunLaMDlFJqNQWaSgpEmNiHbDjohWNjZoM+ITlwqj
	Yi29gfFo6CmXBQtMPuGyGVyT/ArUlBLaKBFJaPcQT0du96iLe4HoHVqiMagI9rwdCIhTTfVzeXc
	Qn4ZftB0b0M2M48NeJ1TayNT97zQF1M6Jeb59KNJAAI+4KDirIFhzEqjBzQ0csmUdY7d4f0oE7P
	DUry9bLBCGIaaTJYc0rKHk2YRWEYo/2GQrfBGnyrrSNbm9/8q6yWWqMm31gZfNvZV38N/ovPfyt
	U5c9Q==
X-Received: by 2002:ac8:5781:0:b0:4f3:5f7b:cc1d with SMTP id d75a77b69052e-505d21846b4mr19549181cf.34.1769732232444;
        Thu, 29 Jan 2026 16:17:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337cc19d7sm45008611cf.35.2026.01.29.16.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 16:17:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlcCE-0000000AQZD-13C4;
	Thu, 29 Jan 2026 20:17:10 -0400
Date: Thu, 29 Jan 2026 20:17:10 -0400
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
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v5 8/8] iommufd: Add dma_buf_pin()
Message-ID: <20260130001710.GB2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-8-f98fca917e96@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260124-dmabuf-revoke-v5-8-f98fca917e96@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,amd.com,gmail.com,ffwll.ch,redhat.com,collabora.com,chromium.org,linux.intel.com,kernel.org,suse.de,intel.com,8bytes.org,arm.com,shazbot.org,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-16211-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 64E9FB5D61
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 09:14:20PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> IOMMUFD relies on a private protocol with VFIO, and this always operated
> in pinned mode.
> 
> Now that VFIO can support pinned importers update IOMMUFD to invoke the
> normal dma-buf flow to request pin.
> 
> This isn't enough to allow IOMMUFD to work with other exporters, it still
> needs a way to get the physical address list which is another series.
> 
> IOMMUFD supports the defined revoke semantics. It immediately stops and
> fences access to the memory inside it's invalidate_mappings() callback,
> and it currently doesn't use scatterlists so doesn't call map/unmap at
> all.
> 
> It is expected that a future revision can synchronously call unmap from
> the move_notify callback as well.
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommufd/pages.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

