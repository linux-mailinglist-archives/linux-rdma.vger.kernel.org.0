Return-Path: <linux-rdma+bounces-15840-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELO3KqnycGk+awAAu9opvQ
	(envelope-from <linux-rdma+bounces-15840-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 16:37:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6C7594CE
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 16:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3053A6DFCB
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 14:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7CE413259;
	Wed, 21 Jan 2026 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEuuZ0Xk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B603E95A9
	for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005364; cv=none; b=O3GKQbEPmTRhzFovfj7W6Ix62JoKFkxfaP39N2rpUUgqAtOIRQEqJljwUDcLs2hdFPsKLjvkVjBLu7YS+d/6zDVW+MHqVGwpGEvnnQQKVVhWh0BgF+kpc8nJYM7/DUzRZ5tUyg4qoZkUsfDhlkVUKqVrNpHh1FCdO8pDE0Wve/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005364; c=relaxed/simple;
	bh=go5t4J2oCqftUfdoUso726J9QdhgF091WBBQZFq2rJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svEhNu29QP6W9xZQvXnLtDPCKhB9B+7vZx5I6lHm2vscWO4T1HIstrYuJlbfcRt1LycEo1tKWbb18ixGP/TWjgSuTkzSbPwtQUxRk8+tzgU1ut3UFLJ2Z82ZHsQp+13i5BavunrNhR3wzS3cA4pWg1El/y7qAullCWs2ZThmYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEuuZ0Xk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a1462573caso88715ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 06:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769005361; x=1769610161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Df9DnST7C0sPqC8cKGnMiT7cxfRi0XBTWHY9JjLQ7zk=;
        b=DEuuZ0XkakSV7FTRN1cRr2Mh3V1Zfd29nLH3JB4eLoNXzlaIF7KsXVYrmv1beTachE
         Fc93sSL9fQ9m4+JChiVRj+X1mHUJHiRc1yGvP5GS9Z12weUCEjaIN4sEMrye/9Td5BHl
         li16qPwg4geQMoZFQhYa7Hl4yoTKaBg+v7kceEsIhi8E9hBn7szXaNOCQSQ29FixYjNQ
         2oDbgik59ykQCCdRAJxfE5eKYONcU5RPE4u2exdcRcfD+iyub9WlO1+5Qs7qT4sGwsb8
         oacM+8Qb/95nczaI0mBHP8Nm3/WLsnWgaUh344xVKEQ6mJtCf93vLOUMPTSaE6yreEMY
         aAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769005361; x=1769610161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Df9DnST7C0sPqC8cKGnMiT7cxfRi0XBTWHY9JjLQ7zk=;
        b=MU2im2Y+muGXlwygMQAdaeSFyFewXVYYlyAL28x3/yVVcikwRwVYJSBdl7LlDrWxji
         VmsxMI0EwyygcTtISQzDAS119KHzIhMEmjc01+a62GpXW7kMrQD3/h4WYXxmWdEvnOBA
         CHqAjFwHAc5nNTrMCh7qK4t8ocNnQp3gqwgR0h9ueLEFMED0Dt/BeTDymxpcyiVT3mU8
         eTQEp7GaeqbULn9+rQme6Lt2V5tS5QI8n47ZbIoUlQU65j3dtVvC6DqO2cyFi1JELI8m
         m6M4WeMB5ERyiqvvEb/O/JuBJXrF3eXvif7gyUuDerOW/YhTTKkc6BiGix4ajQZ3s+bB
         5ddA==
X-Forwarded-Encrypted: i=1; AJvYcCUB5zNyXyjbW+9L0CloEkFtdX2vweGzuLxpPQRWFD4V+Srq0OUUOjoq9v2ARXrfngOkm2ETcNWAQA7I@vger.kernel.org
X-Gm-Message-State: AOJu0YyKtDm6hEyprhs6jKTnljyU4oOb91otZolbcOjrPkt4XW+Nw09f
	MKnyJIgbKNfyYTlFwmS2XimNhZUEvph69fupmfQyToH5TAaCoSCL2/6/kg+f4WK+eQ==
X-Gm-Gg: AZuq6aLkHw4KTgP/Q98vY9DeAVOkuVy0gr4HObR9avUYOliXpQUro25qFvsPpe2imJa
	Rt17jcJ7QVMzerhzfMmM6JGR9/vdTRG0TGXXGCZnrZumhljGq/psRAisirvwFOiNzoUZn0urODy
	N8iVkoJifjCXH8t4nIIqTOyMgSeK1kltY05ciOqowvWw0zixJjddvtzS1jh+yEJ/ahaVRfAuNzB
	XBY7djO6WTN+wu+dl3rYmnz1D7FdvWaS8k97EOxT1AF5A0dJwoPUfQFbxdsdFoqW67ndg05FLyV
	AqQHlRE03SzJF6Yjd3eK7HUKu2k832azYK4ByzDWORztGAM1nRDCaMg+DBOlH/+yXia3Ll8VNIa
	zI5wfHJmYnb7318rcVtBn1DQIQfA81J4E2+6TRatH2PtC+6eRBjnGqqGxmscptECgGXN1J5GXzf
	6li0ABNFRAVl5ZeATRZfGZCtDFkHXq8IWikKgkEhKlzbQ5SXKR
X-Received: by 2002:a17:903:1c8:b0:295:5405:46be with SMTP id d9443c01a7336-2a7a23cc8f3mr2519245ad.1.1769005361111;
        Wed, 21 Jan 2026 06:22:41 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce6a9sm159451235ad.34.2026.01.21.06.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:22:40 -0800 (PST)
Date: Wed, 21 Jan 2026 14:22:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
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
Message-ID: <aXDhJ89Yru577jeY@google.com>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121134712.GZ961572@ziepe.ca>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,amd.com,gmail.com,ffwll.ch,redhat.com,collabora.com,chromium.org,linux.intel.com,suse.de,intel.com,8bytes.org,arm.com,shazbot.org,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.linux.dev];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	TAGGED_FROM(0.00)[bounces-15840-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 1C6C7594CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 09:47:12AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 21, 2026 at 02:59:16PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Use the new dma_buf_attach_revocable() helper to restrict attachments to
> > importers that support mapping invalidation.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index 5fceefc40e27..85056a5a3faf 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -31,6 +31,9 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> >  	if (priv->revoked)
> >  		return -ENODEV;
> >  
> > +	if (!dma_buf_attach_revocable(attachment))
> > +		return -EOPNOTSUPP;
> > +
> >  	return 0;
> >  }
> 
> We need to push an urgent -rc fix to implement a pin function here
> that always fails. That was missed and it means things like rdma can
> import vfio when the intention was to block that. It would be bad for
> that uAPI mistake to reach a released kernel.
> 
> It's tricky that NULL pin ops means "I support pin" :|
> 

I've been wondering about this for a while now, I've been sitting on the
following:

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index a4d8f2ff94e4..962bce959366 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1133,6 +1133,8 @@ int dma_buf_pin(struct dma_buf_attachment *attach)

        if (dmabuf->ops->pin)
                ret = dmabuf->ops->pin(attach);
+       else
+               ret = -EOPNOTSUPP;

        return ret;
 }

But didn't get a chance to dive in the history yet. I thought there's a
good reason we didn't have it? Would it break exisitng dmabuf users?

Praan

