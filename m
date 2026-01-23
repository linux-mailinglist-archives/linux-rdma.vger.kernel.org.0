Return-Path: <linux-rdma+bounces-15931-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH1FAHOic2lqxgAAu9opvQ
	(envelope-from <linux-rdma+bounces-15931-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 17:31:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C61E7887F
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 17:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C57B23023A5B
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D1F2BD013;
	Fri, 23 Jan 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o3OzDV4t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2012459C6
	for <linux-rdma@vger.kernel.org>; Fri, 23 Jan 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185896; cv=none; b=Acfv84GwaP2a/ZamsOVwqizEWhwdhU2a+FJm23BrgTJKrwUEPd2MUhw57deIsS1lKKPcXcUivSfTpveeNMwi5UVOdrQAZe39L5ygPcy1r1pNFW9HvdC0IHeO8Sepnuiw6bmdGf4mgOIB1P52HVJG+S/2bPRu6Y9irICVNIusyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185896; c=relaxed/simple;
	bh=/94C/UlPmwUDToYy/+qtR2DFocibuSIwzpBkOhnUW50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2ANTekuajwSgHyNraQYGmVAVflad8/e5qR2NHC0Q5RoiMUwsY5rqZHVilILz5xJbCznHL4SeNNDNwGul1ONoS3wIe6dzgk3TNYzuFakN3rhBZTiQ8X9MNuE7arbJMilQaO3laEJRrnFl+5X1Dgg3VLYhM2sFow2Od9Ky776rUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=o3OzDV4t; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c6b16bd040so280612285a.1
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jan 2026 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769185893; x=1769790693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=871+kMuUuN8eKawcT4NNcOEOt4uiGeIzveYuD9+CVek=;
        b=o3OzDV4t4A/czgtOv4h401QebNxVlHBgC/qEXYwyXIASd/oVqtIKVRzXKTcQXePL6v
         0a5KIwjfcIfv+zlKFF07BzM2CupGxb74gO6/DE2M8P9UOykTE8EvmBAZqW7efWG3w4/P
         RoweQ6r9U4tX5xboThcA8INKgFVEfTPlNU3VraBu5LcAXZNFkGlzha0cpPqBDb20HRD1
         awPgXYdiv3ID3jCl1PB6rEORWQKxk8cjKX+kFh0ol7dh1D0dwSaW7jXP5r/10uwv3U02
         9io8ffgJaLhUWoLuHIWmuc7oerRyvS1v4hSzdJ1TUXTVfTefX937FUXD35CtilGistww
         uCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185893; x=1769790693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=871+kMuUuN8eKawcT4NNcOEOt4uiGeIzveYuD9+CVek=;
        b=u5bnDN6Ml1wKLimC7PKCxm3sFX1VFIHXmVJ6K1i8ddMLmJk0NQZNjcgB3f4ra34WH5
         Etq3ySoc2IFWUNQnlv2WBi27lRV1x3bKl3t8udw2yFnL4F/Bzlpym8z5HrSMeo0G/Vsd
         DHy4gwSwp7dUkhSdK+sFPM/XrX28BEovyHeGncIZPTQ5o/fQ0dWTjweaAfcHIWxsRWWy
         f5DFx0z34cn+JPzL2pqy3YiDOrJfLMx+2fPqjEVgi+qdHqQB6oGaCeXPPkkl8RzNM3IF
         dshB59P4DEa/8sURDAZZVdFAjEgbyGqFViGcHgr+XEQeBWQLLzprnFq6rGvtd7OxQRaQ
         tBeA==
X-Forwarded-Encrypted: i=1; AJvYcCXMAHpFnfpxymaiR7IrCtl97ukhuuc+o9N1B3mP1EAXzi37yrJELHOSjxkimcOv+k9AG8H1WaxozuNH@vger.kernel.org
X-Gm-Message-State: AOJu0YwiIgI9l+n6X7y/Kwh1+PrHOIjWdSlU70bq/XHwHrqIPwtSZugx
	0JCewxeAWZkGEYULgAlRjeQE3MeizK0gycrAGP31Y/32Zp3+TPdGdA3H81g5mRP646U=
X-Gm-Gg: AZuq6aIO1yhI2Kr8c9vsl4VXMPltKeGAd05k3AX2VQLeCgWB/4eOF/7WD2YCF3VFoXK
	dgUGAdjswBxAI37Xnuds+6kUeCTUdV1xxadEVBXfd2X6qC3vpTtQ5doDE2UGUmX6uF7LxnAGsKn
	R3fGinEPEwCSKb4tVSK0A2cr/sf60LH7QRzCsdO0bzF7nmkzhxDl7kijtoTTNwxd9XQN9xhwwjF
	sGduO17PUmG/c5D8pnR1oHbm42qK55YcPjvElDmDxQJ7tZvlms4SJ/9o+H5+Mzkt8afMmOm6I5K
	UxYMGzqtcapt/uEWkKHkSmwvSYMZOSB0aR/UHaqjssDegyUHfCOaRm/vVfshJC5F2RVT32paR7L
	mESXpHq7Ab4rLSzKK/YI58M5s52nmUbXAfF4H5FX4qvZQINoOMvnBwpJF72/Oe/XVBKAldDNA5I
	XOxFsziSmPc6Err3DibhZDDzCym5yp0KlVNTVy0/ebKBrzFRC2h2b4oBUAOLLgJCtzWCA=
X-Received: by 2002:a05:620a:1901:b0:8c6:c9a2:504d with SMTP id af79cd13be357-8c6e2e48438mr431308085a.59.1769185893221;
        Fri, 23 Jan 2026 08:31:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8949193cdc1sm19709316d6.47.2026.01.23.08.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:31:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vjK4K-00000007Grc-04II;
	Fri, 23 Jan 2026 12:31:32 -0400
Date: Fri, 23 Jan 2026 12:31:32 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
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
Subject: Re: [PATCH v3 6/7] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260123163132.GA1641016@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
 <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
 <20260121133146.GY961572@ziepe.ca>
 <b88b500c-bacc-483d-9d1a-725d4158302a@amd.com>
 <20260121160140.GF961572@ziepe.ca>
 <a1c55bd8-9891-4064-83fe-ac56141e586f@amd.com>
 <20260122234404.GB1589888@ziepe.ca>
 <20260123141140.GC1589888@ziepe.ca>
 <98b74c7a-44c1-49ba-997b-bbbab60429ba@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98b74c7a-44c1-49ba-997b-bbbab60429ba@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,amd.com,gmail.com,ffwll.ch,redhat.com,collabora.com,chromium.org,linux.intel.com,suse.de,intel.com,8bytes.org,arm.com,shazbot.org,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-15931-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C61E7887F
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 05:23:34PM +0100, Christian König wrote:
> > It is illegal to call the DMA API after your driver is unprobed. The
> > kernel can oops. So if a driver is allowing remove() to complete
> > before all the dma_buf_unmaps have been called it is buggy and risks
> > an oops.
> > 
> > https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/#m0c7dda0fb5981240879c5ca489176987d688844c
> > 
> > As calling a dma_buf_unmap() -> dma_unma_sg() after remove() returns
> > is not allowed..
> 
> That is not even in the hands of the driver. The DMA-buf framework
> itself does a module_get() on the exporter.

module_get() prevents the module from being unloaded. It does not
prevent the user from using /sys/../unbind or various other ways to
remove the driver from the device.

rmmod is a popular way to trigger remove() on a driver but not the
only way, and you can't point to a module_get() to dismiss issues with
driver remove() correctness.

> Revoking the DMA mappings won't change anything on that, the
> importer needs to stop using the DMA-buf and drop all their
> references.

And to be correct an exporting driver needs to wait in its remove
function until all the unmaps are done.

Jason

