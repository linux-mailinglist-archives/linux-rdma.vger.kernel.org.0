Return-Path: <linux-rdma+bounces-15844-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOAaLY74cGmgbAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15844-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 17:02:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCBC599BD
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 17:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D02276B5F0
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3302D4B8DDF;
	Wed, 21 Jan 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yey+oVbG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7284B8DD1
	for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006862; cv=none; b=IpH/uhqaX9CAddXRmp9fij1aEZNu7cv1rD4YjE209RcjzGukONGT2c5RtxAoVLGaDNTNB5D9KakU8L/PP4qF1Y9vo+1xaYLBvQ9F2tFiKRK4E0UzE6Z31cjrBhQKZpOa45rKsEjg4MbNrtqFzt3WiY5r4odZ76rmZwUgAHzuHg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006862; c=relaxed/simple;
	bh=ACESqUkTA5xhzkocxzu1Q/cYXSAEkWy1ze88m+Pg+BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVZpoc1S6h6VCdiPXHdNLlGYO3giQ90Lmc8wPoa5luBjlJSO3y2FAYH4MKaYTzry8CyP/8BKPggREQAEoCdU0576SfB75/0+E1zeq/RPZkqH3mdKxlgJaEGrccuuGX+F9ZfLnTAQ0YOpY7l6h6VevrkaNp9Shk8ZyQJx0LyEu70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yey+oVbG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a76b39587aso92285ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 06:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769006859; x=1769611659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMkS4BFW7iikoL2BjP1nG2XKvn880JyWpxnGNG3+/cM=;
        b=yey+oVbGOy2ziOs0M8k3ZrA9edvNtdE03FMxfDRDoifwSsfAb0EE7GHHjZJzUd+MTs
         SvuC5M7f5WQiWgNrDPx5uw7akEzXnBnVI1QQ4ZX9E3vOA/hbeIbtsGYl6Qgoxi/Cl9XS
         7hMY4cLC/zEnCIzUJxRMRYWlz3mIzETDIb5dbFs4h8jX0x8w0lQ+jI+2voclHqR7wAAy
         G5Xt4MfWQqRvGEnV78wX1znSRFXl4x+CxsGqq+kv9BTI0UQVphGEFTYfydVB0EQfROaf
         UYc/cXx2GMnq/oBI//eTUlUP6Rvqysuwn7EOlCmIXYshtBrCQwyWWETrRCPautpjxFlO
         1b+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006859; x=1769611659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMkS4BFW7iikoL2BjP1nG2XKvn880JyWpxnGNG3+/cM=;
        b=cK41EWhxFDoJ8p8MFaQTLHiyl7kPcmsDel/dOvAjsyRVLr1v5AXyzFqm3SyvLhlTqC
         gie+dQw2cAqAZ4NzNzg36h847bPFeB2dOiSpcTalj/tCdi16DowrAuHTXmBa9Fg6FXLh
         nuP6UxOoL7ASBTebBzrlw2vpv7S5b4TSivlEYo7T41VxUhdLD4Zgz2eZNC+fwls1pL/u
         4AwsVa01DOBg7yLUrHARhbd8PLHFLPP6jJwjfeqzHT3yksmMYUg3eRYjGOgGgdcJt26E
         YtUqjiwALgygWlIm0ogyP0ZQryAx5Jh4L1guiqFBDY1FFfkUK/kD+3jEVHITFo+/rHVI
         nDpg==
X-Forwarded-Encrypted: i=1; AJvYcCWQmLI3GhC3T2ZUQkERPs17iFyApTGq+Gw0+BTNVhqDXXbjmtVob9XhNN/xuX/dD+n/7UejS2CksiER@vger.kernel.org
X-Gm-Message-State: AOJu0YyM3Ib0mshQfRWZofyXlv9UvFtgd1+zS1lOy5PjSgahm7e4j3VI
	eMF0uyumKub1jrZs0iHTH65y5ULhZ26llE7hT4C7rV71DuXpTI0f6JY58MPoiiCKdQ==
X-Gm-Gg: AZuq6aJJut2TaPapYPxhs0JsBSSEk3jUj+FkMErj6g/qVty8BF17nAHwkfxrL5lje4z
	nrV8ibnrbAtsPsbHThlk13Y0LYukHXZlLkRkxv7q/F+vdbggGeP73M2d3j5Rmf/MIxfZhSddVX2
	h+RtLolArAm2YGW9rtkn2SkFiswysnEb9hqEyxWt2Wf6zCmRyMdiiw7++MW4s8tdmjgUVdrs6LE
	rakrZ4mop3kXand8ElhmslUE3p89pL3sSFd7U8Ac+c8B9v3iSZoH30AaYiWXqqp+ZgJa5RYU/ti
	Onn5Bpmljb+i/mh1HhC6llYGgXRtxTq9a1m8e9P/y7CxWdUEipGO0OJWLa8o7XLApDPOlbBxrVa
	KOSsvxXFduUQqIXkWUv3c967EXviIzeea++PBv98cFSX/x/aCIuJl1TdrASVg3H4oqbAVuslfUE
	8mfSS6C9WUpFuq9UindkB7rCSz04IOIvenYkYybv7X4XysvKx9
X-Received: by 2002:a17:902:dac8:b0:2a7:87c2:fcde with SMTP id d9443c01a7336-2a7a245b58cmr2655545ad.15.1769006858836;
        Wed, 21 Jan 2026 06:47:38 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa108b21fsm15434806b3a.13.2026.01.21.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:47:38 -0800 (PST)
Date: Wed, 21 Jan 2026 14:47:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
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
Subject: Re: [PATCH v4 8/8] vfio: Validate dma-buf revocation semantics
Message-ID: <aXDnAVzTuCSZHxgF@google.com>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca>
 <aXDhJ89Yru577jeY@google.com>
 <20260121142528.GC13201@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121142528.GC13201@unreal>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15844-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[ziepe.ca,linaro.org,amd.com,gmail.com,ffwll.ch,redhat.com,collabora.com,chromium.org,linux.intel.com,kernel.org,suse.de,intel.com,8bytes.org,arm.com,shazbot.org,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	ASN_FAIL(0.00)[4.1.0.0.3.0.0.0.4.9.9.1.0.0.0.0.0.0.0.0.0.0.0.0.a.0.6.0.1.0.a.2.asn6.rspamd.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-rdma@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3CCBC599BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 04:25:28PM +0200, Leon Romanovsky wrote:
> On Wed, Jan 21, 2026 at 02:22:31PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jan 21, 2026 at 09:47:12AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Jan 21, 2026 at 02:59:16PM +0200, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > Use the new dma_buf_attach_revocable() helper to restrict attachments to
> > > > importers that support mapping invalidation.
> > > > 
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > ---
> > > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > > index 5fceefc40e27..85056a5a3faf 100644
> > > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > > @@ -31,6 +31,9 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > > >  	if (priv->revoked)
> > > >  		return -ENODEV;
> > > >  
> > > > +	if (!dma_buf_attach_revocable(attachment))
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > >  	return 0;
> > > >  }
> > > 
> > > We need to push an urgent -rc fix to implement a pin function here
> > > that always fails. That was missed and it means things like rdma can
> > > import vfio when the intention was to block that. It would be bad for
> > > that uAPI mistake to reach a released kernel.
> > > 
> > > It's tricky that NULL pin ops means "I support pin" :|
> > > 
> > 
> > I've been wondering about this for a while now, I've been sitting on the
> > following:
> > 
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index a4d8f2ff94e4..962bce959366 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1133,6 +1133,8 @@ int dma_buf_pin(struct dma_buf_attachment *attach)
> > 
> >         if (dmabuf->ops->pin)
> >                 ret = dmabuf->ops->pin(attach);
> > +       else
> > +               ret = -EOPNOTSUPP;
> > 
> >         return ret;
> >  }
> > 
> > But didn't get a chance to dive in the history yet. I thought there's a
> > good reason we didn't have it? Would it break exisitng dmabuf users?
> 
> Probably every importer which called to dma_buf_pin() while connecting
> to existing exporters as many in tree implementation don't have ->pin()
> implemented.

Fair point. I agree with Jason that we cannot leave this open for VFIO
and we can have a pin op that always fails.

But at the same time, I'd like to discuss if we should think about
changing the dmabuf core, NULL op == success feels like relying on a bug
I agree that it means the exporter has no mm, but I believe there should
be some way for the importer to know that.. the importer can still
decide to use the exported dmabuf while being aware.

Thanks,
Praan

