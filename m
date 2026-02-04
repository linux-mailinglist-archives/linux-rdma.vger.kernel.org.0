Return-Path: <linux-rdma+bounces-16534-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B8xMSh6g2nyngMAu9opvQ
	(envelope-from <linux-rdma+bounces-16534-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 17:56:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB57EA9CE
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 17:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19A26301C900
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2576933EAE4;
	Wed,  4 Feb 2026 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dJ3wMTjl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AE333E362
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224109; cv=none; b=cfl90/F9iDfqSTFhzPc6pdc1KKOGEkE2id0LAmzcC9GdFJpgh3h/YUip0fXblOWCTj7Xv6XtP5Qbuf+6qgOF81FztG8tIoVeu0HcxApV/CsmjLKiQXATr4BOmKbBT46+UlAuKWmJVnkX7Tj16UV/maYkFupRZRTUWoleLb+Pxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224109; c=relaxed/simple;
	bh=5K5fR+HxBrdqjMKErGIv55w9oITaTZk9Qf+xlROKnSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKWJHZDEiN2hFx/4vfyVD0RGCKrpCJ+tjSaBR99+RDhjX+22JKzdMpmWMGn/uF5r8yhFN6uGRfpO5B+WkeVZ9D23XfkjQkPVmPWNDzr8WvjtaSW8keI7PKfQtvmk7uxKhZo1yeLTSWy+pgrW80dsiQi+cAodnBI4pm+t/0G1OLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dJ3wMTjl; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c710439535so563069885a.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 08:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770224108; x=1770828908; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+k5zz356tCtx+TsrSTgNS2LOgl52lZtCniOLQPd/1s0=;
        b=dJ3wMTjlcrFt0OJax/CsfN1yUyB6wvWMaelcWV9nhohy8QA3GVs7AF6ZtNBdf9OjXZ
         ajkkkzyh+ZvPwYDwiFPktPG7VGNkGPuB03uPbwGQFroNvICbrlkz9Z7q6QgY8p4Srvmy
         aoD+KvnxxZ/ClqJg66luHVlFyv045VhXvyEvAs/+6pRZyqjBx5MsAhNeUwPJ00he+TTL
         9jkH7yrYoucRIQdFBYM6v+ePbpC6OHYM39YtbPIn6Dfa/zLh0h5wzq/0TmheDXvPv6mp
         XBxl7+OdSx9S3klWiruBg0MptbEC0lznV5E0sHEmcIc6uOdE9MX3ZF5AEBrNGgBV9aX5
         wo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770224108; x=1770828908;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+k5zz356tCtx+TsrSTgNS2LOgl52lZtCniOLQPd/1s0=;
        b=YcMRb5C2Eyo3H7Y3vW21r0UwzNbO2Yj9w0nolyjn1fh1Cd2q/CiomXt0ddiJyBjQZG
         lsV2e9aNdSr7uDbnmZN/NLM3Smz+ZasjPz4+0FPh43vE7IUINErELwivp4EvQ81IfAUC
         pjX45DA7ITB+j9LcfXqpRGErlWdIJa6r5VmNoP4EW5DdBMQKzuCWxkd3W/UGXJUtrpha
         V1ZHl4q4J1amEC4zEmGC9rTclcnpexJm78PEhDwD5wA704QeRdMLLqNYGRJBP6YoQt/Q
         EJt5ecrFVA1pup7KDCxltnlbdKJTCS2MjPBsOVU1wLkQRzJtQBmzWnsA+0bx75joC+30
         HH3w==
X-Forwarded-Encrypted: i=1; AJvYcCWgr95N9kFM4TMX18JkVjKExk26eJfZOWbFxyEtgK2A8N83gpl2OuWxlMajgCXQngK704X7WT1iMZyu@vger.kernel.org
X-Gm-Message-State: AOJu0YwqXuKJ6e1wUXR1m0MmBzNZdiUiWkhnGozBovhvxaq5FSR0gYmE
	7icroWvHx7J1RlAI5Cn52kaclJUBaCv7OJYr+U/W08xpoCettbMzHEFAhJsz9sZvc8o=
X-Gm-Gg: AZuq6aK6LdDBd5zCYABVRTRQsu76Aaun7AVCZBTjgKvCgPf7eRIzjG6m5DQBBz2iPe9
	Rhkn3uNZEGT5nGxNaAAxGS3qyMG0mvBBWSEtxoSPkUfafTa7G97AnGgsLJrvIeZQlEPvRmwRXTc
	OlOOwP1tGihxqRxtGpwFVjjaDbxVEnoKURbaDBv/m6N0p82nEbgjcItCMcxbE4fu7UZm20Zojkz
	mq9ZZ11AHd9onoWN5XELI9ba0CT/Bhw2E0FLjv/F+l+RuSZEJ983L3FvMRH53i6uy6xrm2ytq7U
	BEoe8jfGikX1jFZuPSnvzw8uNrgb8/9ODgFidU3b/r+Ri+T7gtPfpajwe3gzJfuw3NLjNGmVeA+
	9OLsj+2evCIRKNtKQkDc1Vvo0ECY6vKa0KigOxPQA3G7CCXH1PvdneQZ8zJzfY9/q2T0MMJflrR
	Ayjm1inD0G2RaAKV5NJ2MU5OV5qvbOPJLYTOV3QLNCV26IX8u8QyUAiR79l1NTNXwLAh4=
X-Received: by 2002:a05:620a:4627:b0:8c7:177f:cc17 with SMTP id af79cd13be357-8ca2f9bbb5amr467025085a.46.1770224108469;
        Wed, 04 Feb 2026 08:55:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd2cfb4sm226461485a.33.2026.02.04.08.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 08:55:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vng9j-0000000HH15-13rk;
	Wed, 04 Feb 2026 12:55:07 -0400
Date: Wed, 4 Feb 2026 12:55:07 -0400
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
Subject: Re: [PATCH v7 7/8] vfio: Permit VFIO to work with pinned importers
Message-ID: <20260204165507.GH2328995@ziepe.ca>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260131-dmabuf-revoke-v7-7-463d956bd527@nvidia.com>
 <fb9bf53a-7962-451a-bac2-c61eb52c7a0f@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb9bf53a-7962-451a-bac2-c61eb52c7a0f@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,amd.com,gmail.com,ffwll.ch,redhat.com,collabora.com,chromium.org,linux.intel.com,suse.de,intel.com,8bytes.org,arm.com,shazbot.org,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-16534-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,amd.com:email,intel.com:email,shazbot.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FB57EA9CE
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 05:21:45PM +0100, Christian König wrote:
> On 1/31/26 06:34, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Till now VFIO has rejected pinned importers, largely to avoid being used
> > with the RDMA pinned importer that cannot handle a move_notify() to revoke
> > access.
> > 
> > Using dma_buf_attach_revocable() it can tell the difference between pinned
> > importers that support the flow described in dma_buf_invalidate_mappings()
> > and those that don't.
> > 
> > Thus permit compatible pinned importers.
> > 
> > This is one of two items IOMMUFD requires to remove its private interface
> > to VFIO's dma-buf.
> > 
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Reviewed-by: Alex Williamson <alex@shazbot.org>
> > Reviewed-by: Christian König <christian.koenig@amd.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 15 +++------------
> >  1 file changed, 3 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index 78d47e260f34..a5fb80e068ee 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -22,16 +22,6 @@ struct vfio_pci_dma_buf {
> >  	u8 revoked : 1;
> >  };
> >  
> > -static int vfio_pci_dma_buf_pin(struct dma_buf_attachment *attachment)
> > -{
> > -	return -EOPNOTSUPP;
> > -}
> > -
> > -static void vfio_pci_dma_buf_unpin(struct dma_buf_attachment *attachment)
> > -{
> > -	/* Do nothing */
> > -}
> > -
> 
> This chunk here doesn't want to apply to drm-misc-next, my educated
> guess is that the patch adding those lines is missing in that tree.

Yes. It looks like Alex took it to his next tree:

commit 61ceaf236115f20f4fdd7cf60f883ada1063349a
Author: Leon Romanovsky <leon@kernel.org>
Date:   Wed Jan 21 17:45:02 2026 +0200

    vfio: Prevent from pinned DMABUF importers to attach to VFIO DMABUF
    
    Some pinned importers, such as non-ODP RDMA ones, cannot invalidate their
    mappings and therefore must be prevented from attaching to this exporter.
    
    Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
    Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
    Reviewed-by: Pranjal Shrivastava <praan@google.com>
    Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
    Link: https://lore.kernel.org/r/20260121-vfio-add-pin-v1-1-4e04916b17f1@nvidia.com
    Signed-off-by: Alex Williamson <alex@shazbot.org>

The very best thing would be to pull
61ceaf236115f20f4fdd7cf60f883ada1063349a which is cleanly based on
v6.19-rc6 ?

> How should we handle that? Patches 1-3 have already been pushed to
> drm-misc-next and I would rather like to push patches 4-6 through
> that branch as well.

Or we get Alex to take a branch from you for the first 3 and push it?

Jason

