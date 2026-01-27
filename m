Return-Path: <linux-rdma+bounces-16089-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDf4MpnneGmHtwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16089-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 17:28:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 353C697C33
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 17:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3D56302D96C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D84E35CBA5;
	Tue, 27 Jan 2026 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KlTE7ocJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0535FF52
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531279; cv=none; b=JYzfGjFE8yEwv3MTsCpg9EprcV5erMsSHhL8iXO1BEJp5pGxIxySZO3Tw58iiPVCbBlBIt+SrydpCXENV4lEutwNl9d6lxPbWWzdyaiY16lg1EEiNh6WznkRgdvUJQRCv5YTspS33s2nRXU2n07cmF3XbJQxzusVqsBP59fAz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531279; c=relaxed/simple;
	bh=EzvzbPpROKuqvVQCoJHluXwjW5pJqoCNcXzstaHV6s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ml7Nv0JGFC6gsOesN8hHFZG1rQj/f8aqY6ZSGVaB7c5Khz0o7zlbQz/o6HQ57YpVgJTePofJAYltfQ6iRuIlYr6RHDO9jEN9msCtIWU4ri2hRtexsFlaSYvZrTF6cL0OIO+EheDt5hABWXx0N+tPoDpHcKAZhejRq5F+SA6lLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KlTE7ocJ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-501469b598fso44445021cf.3
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 08:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769531276; x=1770136076; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Kat2TyZxDqTgTm8MMhUVYtoZ/z4BzE2I09fTuJqEpw=;
        b=KlTE7ocJAtXhGsD/ZpW2fgoxgrYuaHqmg4qYKFaH4AXvMmVwIXr2XDqLtaHCHYsBVs
         3x9kX3XNrOnS0sERj5ESgrOvOgAVZeWTt5suRDq+z2e1SFDjUB9rYGpHfiuklViAPQrc
         phlR/hBmICpevDQXsuIWf24zo+0lqSC31hlFBRxrF2TZPyjfx1oJKPyfV82E7wkMKpdH
         2dSIj92u+OTq5VNGOBvsOvBr+lc4pYFiAAHD9tNGfTbwO5J0KEI38nKkkt+Ex+fzPY4O
         fRdqZXrfnSawNSosTfCjM1qcm003ArXEnRXTHsLhZikFi/xGsVMfpCWwHf/IG6cMhY64
         MWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769531276; x=1770136076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Kat2TyZxDqTgTm8MMhUVYtoZ/z4BzE2I09fTuJqEpw=;
        b=VyZtSS4fy2Wj9PwvcqDgLjbgnLmVY0sFe4xJntS5rAdojaF1PCcnD1eMXdqwVvLHeC
         kKxIiuZbfHHuPJ08N6mFPWWsOivtlP3dq1bKQA1YNMnev5BAJQxrOrLYj+/6UIy7BMmd
         QfoGjeVEOjP45ftXjwuTnelZeScXxG2HgqoC1qx63B6WXoUOHRj7vFai2VmJU4+yjE2r
         ikpZ2RvJK4b4p+I1A8RWo2b6WYgZ2CtXCjSdKBvSrJq96f7QMkjg8UmxQnIbe450uTLb
         wzED9yI4Q9ef4+XltqTKcbY1g9+ElZXeF4R7/7bZrxBgrzx+Qoq+bEOpE0yv90JkkA8B
         HEZg==
X-Forwarded-Encrypted: i=1; AJvYcCVzpXyFvoxcsOktFW2fG1IkVUuVAkt0yOGhIH4OPaXwzs6/ZmqRv56JPu5Zj9IoXJzncQGSyowD4PTa@vger.kernel.org
X-Gm-Message-State: AOJu0Yylvc1IuPAK14OldVUB77dcKz1pYMPSHOT4n/iwqZ6y3lKcJElt
	Jaw7qqgQr8wD1J0XwPACwpaTXhzdJ3TOuZfDTp4lrIU20qsb0G+E9UY3iPKr/L9Oojw=
X-Gm-Gg: AZuq6aIj8/WtpQQk2c2PXW/aeqgqb51LxKKnBTbYwhThIGFgWY3EtgJDy6LuQFojKeu
	XgNU0uYMUuKi6A2lj8pz82WTD1yghWrRnp+7tk8P2e8R0aHYaM/bwpMLeG1FiNbQf0Y+kdRZrl+
	bjYkjGk8d9IKPf1e8kwLUpf4fw28AvxSKh1tSty1IDMnDs+n7QJLXDy2/tTBtFoCreCS/7eel43
	eujL8Ut9GIVEnkb+EmDeF3OhTMPqABwkLkjm/rlfANMM6f5Y3fZ0e8gsiv1c0wZh1WHqV+7Xw88
	BWEHqb0bsAODdhJ6xpVsXDpvkw+Wcy9uFctXtzxs7OGka/T412zM8bYR3UIYPxorplYex7xek7q
	7p9vxWYeGSvppTVUJLWL6un/x3kdnifQ5B6TL2Tzyu8TxwmwaF7Wl0TAveZKzKvLj7bfO3DnmOG
	FufZL0YJGgibORd9nDB+aEuxErlwo4PqYN3IvBGceANz3ngnT/37b/UC959oakncCtYe+MT53ln
	PoxRg==
X-Received: by 2002:a05:622a:612:b0:4f1:ba00:4cc6 with SMTP id d75a77b69052e-5032fc167d4mr25702421cf.79.1769531275530;
        Tue, 27 Jan 2026 08:27:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502fb8e74ebsm102277581cf.0.2026.01.27.08.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 08:27:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vklv0-000000095Ys-1TUe;
	Tue, 27 Jan 2026 12:27:54 -0400
Date: Tue, 27 Jan 2026 12:27:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
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
Subject: Re: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260127162754.GH1641016@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <aXfUZcSEr9N18o6w@google.com>
 <20260127085835.GQ13967@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127085835.GQ13967@unreal>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linaro.org,amd.com,gmail.com,ffwll.ch,redhat.com,collabora.com,chromium.org,linux.intel.com,kernel.org,suse.de,intel.com,8bytes.org,arm.com,shazbot.org,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-16089-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 353C697C33
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 10:58:35AM +0200, Leon Romanovsky wrote:
> > > @@ -333,7 +359,37 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
> > >  			dma_resv_lock(priv->dmabuf->resv, NULL);
> > >  			priv->revoked = revoked;
> > >  			dma_buf_invalidate_mappings(priv->dmabuf);
> > > +			dma_resv_wait_timeout(priv->dmabuf->resv,
> > > +					      DMA_RESV_USAGE_BOOKKEEP, false,
> > > +					      MAX_SCHEDULE_TIMEOUT);
> > >  			dma_resv_unlock(priv->dmabuf->resv);
> > > +			if (revoked) {
> > > +				kref_put(&priv->kref, vfio_pci_dma_buf_done);
> > > +				/* Let's wait till all DMA unmap are completed. */
> > > +				wait = wait_for_completion_timeout(
> > > +					&priv->comp, secs_to_jiffies(1));
> > 
> > Is the 1-second constant sufficient for all hardware, or should the 
> > invalidate_mappings() contract require the callback to block until 
> > speculative reads are strictly fenced? I'm wondering about a case where
> > a device's firmware has a high response latency, perhaps due to internal
> > management tasks like error recovery or thermal and it exceeds the 1s 
> > timeout. 
> > 
> > If the device is in the middle of a large DMA burst and the firmware is
> > slow to flush the internal pipelines to a fully "quiesced"
> > read-and-discard state, reclaiming the memory at exactly 1.001 seconds
> > risks triggering platform-level faults..
> > 
> > Since the wen explicitly permit these speculative reads until unmap is
> > complete, relying on a hardcoded timeout in the exporter seems to 
> > introduce a hardware-dependent race condition that could compromise
> > system stability via IOMMU errors or AER faults. 
> > 
> > Should the importer instead be required to guarantee that all 
> > speculative access has ceased before the invalidation call returns?
> 
> It is guaranteed by the dma_resv_wait_timeout() call above. That call ensures
> that the hardware has completed all pending operations. The 1‑second delay is
> meant to catch cases where an in-kernel DMA unmap call is missing, which should
> not trigger any DMA activity at that point.

Christian may know actual examples, but my general feeling is he was
worrying about drivers that have pushed the DMABUF to visibility on
the GPU and the move notify & fences only shoot down some access. So
it has to wait until the DMABUF is finally unmapped.

Pranjal's example should be covered by the driver adding a fence and
then the unbounded fence wait will complete it.

I think the open question here is if drivers that can't rely on their
fences should return dma_buf_attach_revocable() = false ? It depends
on how long they will leave the buffers mapped, and if it is "bounded
time".

The converse is we want to detect bugs where drivers have wrongly set
dma_buf_attach_revocable() = true and this turns into an infinite
sleep, so the logging is necessary, IMHO.

At worst the code should sleep 1s, print, then keep sleeping..

Jason

