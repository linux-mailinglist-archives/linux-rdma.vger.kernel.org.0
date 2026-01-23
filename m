Return-Path: <linux-rdma+bounces-15922-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO3KEjuCc2kDxAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15922-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 15:14:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A6976D06
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 15:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71CF530420A8
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157C3318EF6;
	Fri, 23 Jan 2026 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C0Uqq+VZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2882D223705
	for <linux-rdma@vger.kernel.org>; Fri, 23 Jan 2026 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177504; cv=none; b=kMZH22+X2nJ35cibytis3bygmn95GTWLdgAO77/gSZ4pEgo86GHL2LwLQwiI9fQuXrOOF+o7UhbXgsbV/SGKL8mkoUq8iYafyU9TeQQvd6mw91T1QEuV5NqB8TkaTqoxrBqx8j8iNKQk7LloaHJ0uQ4Pg35r8j4rREH3jNrib3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177504; c=relaxed/simple;
	bh=58had73B0AHtHiPbJGrC4Y2rRw/02IpIYPrJvcRhLO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCuGHbCUFhNELy9r/IEJxHa/eBprXci0fQPhRiic/PgDZdYZuGMI6sa5l/tQjPlG87BrVDAjAZVDam4knU9JSAvGghSnZAFV+upsQpMD+hIbx+BA2VwT+e+pjKZaPv6TMkEIWbMblVyK2Pd9kEcwSCmwGq4nwssmpsI49LFrQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C0Uqq+VZ; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8947e6ffd30so25947926d6.0
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jan 2026 06:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769177502; x=1769782302; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A5PKpJ/4T6+3Viu0suTKGZFl50yyl7xVfieAULiIAgY=;
        b=C0Uqq+VZawmT5EaGo/9vHmRPXawiuY2+AI85l4+cD0a6Su5zkhTpoX/FlMcYZ04mkw
         aOmEYGoPZ1/HuCxAZjn+g9KW1gvYWd6zyvF6o+Rr2qiVVWAuYp1OVdKZcERI3Cu7U156
         m0SlyUp3PhQ3tugG/fIti/LjSJE6EiDAum3E72JYVdkX8YTsgPnxOwDemTaLr3+ORJIj
         6ai8JjK3Rlw0dFWlZmSZH97cuFECxaKdmJKxc7ZtxpxebYi1QUZj4SftTrsTiK3RPdaY
         ZX5wMvoPN1024KOc4foiHXMoTFMdqwXI2bLdsD62NBepnhQ0Lf4QVTvyUe34U8NgESMI
         ysNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769177502; x=1769782302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5PKpJ/4T6+3Viu0suTKGZFl50yyl7xVfieAULiIAgY=;
        b=qfxUvicQ1jXZi+4LUtoOHfLixc9+bkrE165K0pXFwkELG3VmCkVgGTYeXNGepO4ERO
         f8LPzODUmHMqiuK/7kTMhRHs45dkESLMDwdSQjPt5MKtVMwIpEKGxM/QZNHyXeQx2f4T
         ClsH4/DT1QBaxwGUnYu/lLiHLXjZFOCgzx7SMhSeTXe8LHmM2gGzo+DJLPGl1l3aH7yT
         3+HFQq5DAFKXfDzwzQPb5Kzj43scqAE+E+w+lUjwIgD3NlIiDXn2AA3h6srZ31VPFES0
         +rGFj46idCDXM3gcFfTcqNS7s/zywEeci5enn82sFjMBF9UURTDmooNJ3hejOV5I5vao
         LWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWRuACxk7kcXxz0J5LD2Ofk9dQn5KgaJCGJPbd0GmHUrnv6owr8l/2yvudq+qAnE9gM8egv7iTgI+g@vger.kernel.org
X-Gm-Message-State: AOJu0Yziu3RSMxiqkuIRtoXSENZ61fyqdnVPL/s6ozrpDBZ91d9Xbqwt
	HLbJCFP7vtXzTRT8bv+MfgMuXK/c9WsFV/pYrFAZohvdJHV/gvO3Bxl8Rt4yFTSUmMU=
X-Gm-Gg: AZuq6aJgiOpvD8k/bdrTqDjRSiVIZz4hprPiSrpgQtpgBBXv5bhmHY7oqx2dZrARVic
	MPw+lOWod/Gfox+8bVQbk5R2f7Ny5cFhyqEKwUi9KMV5U/HdaWJ5T976pZfV21/iLLPT8BvIhyA
	dJiMpUtue+f9gthsnHBd0zpi99j2Jr4MCAQIV04bSZDmWFeDzn66ml8mKYSsaeGdCAx6A9VS6Jt
	XiTkX4XLZEm3Quqg0QCXkl4CHfdUmYOwzMVgbpISjAd28ZkBbIkUoyB63aBwXpUaBlhpgozk9vR
	Wue6bCDM6DAUMb5rFbx1IHRRfGq/E8JnASlXcfxQ9c85RTDP+XeC3+EriV4HdqtclhYu4Kj3pOg
	LjXwH8OD2pOEFMz5CzpQAqfyfs5iiP6a34Z/TrlmlDDPj2TC1nnP2TXbRzNdABIIDy4eer2tcKC
	QRKxeiPk1VxOGjUhDvdBjA6KTq1YuXheVlJmQhywTUCr67XFRSLpe6jHHfmMoFnD7I9lyXsxUFr
	JM8sQ==
X-Received: by 2002:ad4:5c46:0:b0:88a:589b:5db5 with SMTP id 6a1803df08f44-894900d6bccmr42275406d6.0.1769177502022;
        Fri, 23 Jan 2026 06:11:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37c8fa6sm187731585a.4.2026.01.23.06.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 06:11:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vjHsy-00000006stw-3Bfb;
	Fri, 23 Jan 2026 10:11:40 -0400
Date: Fri, 23 Jan 2026 10:11:40 -0400
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
Message-ID: <20260123141140.GC1589888@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
 <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
 <20260121133146.GY961572@ziepe.ca>
 <b88b500c-bacc-483d-9d1a-725d4158302a@amd.com>
 <20260121160140.GF961572@ziepe.ca>
 <a1c55bd8-9891-4064-83fe-ac56141e586f@amd.com>
 <20260122234404.GB1589888@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122234404.GB1589888@ziepe.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,amd.com,gmail.com,ffwll.ch,redhat.com,collabora.com,chromium.org,linux.intel.com,suse.de,intel.com,8bytes.org,arm.com,shazbot.org,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-15922-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0A6976D06
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 07:44:04PM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 22, 2026 at 12:32:03PM +0100, Christian König wrote:
> > >> What roughly happens is that each DMA-buf mapping through a couple
> > >> of hoops keeps a reference on the device, so even after a hotplug
> > >> event the device can only fully go away after all housekeeping
> > >> structures are destroyed and buffers freed.
> > > 
> > > A simple reference on the device means nothing for these kinds of
> > > questions. It does not stop unloading and reloading a driver.
> > 
> > Well as far as I know it stops the PCIe address space from being re-used.
> > 
> > So when you do an "echo 1 > remove" and then an re-scan on the
> > upstream bridge that works, but you get different addresses for your
> > MMIO BARs!
> 
> That's pretty a niche scenario.. Most people don't rescan their PCI
> bus. If you just do rmmod/insmod then it will be re-used, there is no
> rescan to move the MMIO around on that case.

Ah I just remembered there is another important detail here.

It is illegal to call the DMA API after your driver is unprobed. The
kernel can oops. So if a driver is allowing remove() to complete
before all the dma_buf_unmaps have been called it is buggy and risks
an oops.

https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/#m0c7dda0fb5981240879c5ca489176987d688844c

As calling a dma_buf_unmap() -> dma_unma_sg() after remove() returns
is not allowed..

Jason

