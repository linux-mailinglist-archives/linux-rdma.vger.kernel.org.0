Return-Path: <linux-rdma+bounces-15831-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMTwJUDgcGnCaQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15831-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 15:18:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 163D5584CC
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 15:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5175E6CDF92
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0522283FCF;
	Wed, 21 Jan 2026 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VlCcRk7t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC5346FC6
	for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003236; cv=none; b=mEQGqHTFOWP5lcoVWSSNKIEKFiY4U2RgCnSFjgzvd4DS5r5PP/c8ar3CbGcrRdqsnwgj9O/lFI39TaZlChsh2DB8UufD5x0rqTv0XMHvQvMU6RUs6EnNT/6KzwHskbnf58KPZC0Dn1fz8COkXrw6BzOCFsK18Oo5IViAjxWD7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003236; c=relaxed/simple;
	bh=fn6QDJCmTOKiiaWIAjab6bH+PZ+yr8u3rj/vi81/cYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRzrkAy3f7fS/Mo6oOBOF6dfLWz89VkOzMppuNjPfXsQwRbSqDVbsWfMrwwUh/wXL8DtCMmqdMgALcJaWgGQ7VwOE+t9jXQuv8d9WkfULWtsZAT1TWtf4CVWSwmNzDXRjGJkBsQdOM9F0iX/VdARC4czDcChf3K16loT/n8diKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VlCcRk7t; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c655e0ee70so695406485a.3
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 05:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769003234; x=1769608034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPFd5kAX+x+JPapHwkry8xE9pec/AtWEm0UrVlklyxQ=;
        b=VlCcRk7tbIkcBEUHA4PO6on6QbkqigpTvnikJFIkXo5T13ih9tMng1POxdqu6NGNT+
         786MunCZ5VX9UE8sych+WI3dQiajLJg92g4+oen8h0tA73qVmDUfgHhevuZ8PTPwRInt
         Xpccqylt7F7+NSjSxdRF2dHUcI/kTjk4KIxoG/6bkngvMwivqJzgVL3ujyXQdHhUufBk
         0bO2Dr5WIrEDnndruRN6OYX6p+VJvgnHrx6PW1z+Juk8ROYKODXRXjx9RSLESf4dctcJ
         DgM2xrTwMvrjdIZvo9xiSZ8bFb8OJreocjaP5GHQznyD/1q4ENlM2HHP1JR13ICqshrR
         iAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003234; x=1769608034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPFd5kAX+x+JPapHwkry8xE9pec/AtWEm0UrVlklyxQ=;
        b=usSm4eu32OdWJzoyoyk0pvfs4rbARdiMiPn0V/ogpP5DSYzXOUc5aToviQL/YyO6yz
         KUt+vZtSH6J4ibidRrE0sjsHQSeHDR3kFvKlfm1zJNSFDsESt8kfbcWz9DZYzvQqyN4w
         sVj5fwXv1JikojebtttWD+VijVgqlRP2axID93wn2/Ohvbs3u0qQwk2v5GoeYV23pCUN
         0NeUbBfk5xBzu+Teuce3JLj8itQFoyezC0KOe0uNSioQGPvb+3TZn4ZGCnNEK6LVGXW5
         gazeviMjRW76R+9mNhCkKMxnwp6nGWSNyPFzuW+bT85bE3jDokJBgPsdGuGfhJtsrJ6o
         /0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTfAHp+Pm1LIi2Q41LaTLiRmJFqeBq94pMe1nPHu6vR/VLuw2m+UDcL/tsjpl2+bWRD8Z+lokrRV7X@vger.kernel.org
X-Gm-Message-State: AOJu0YxI7ggrfIPtqRs+HjvMg3WFFj2cJfPGKE6yymbTB6gCg6Q+vGLH
	CsS77ITOsCrTVl9OSvpupOrcpkzqNk6kuEf8rxX3yhlGX1W8/vRlA25bhAJ+6PjNehw=
X-Gm-Gg: AZuq6aJh535LqQmljOoz0BQ56AmjuQvbzmQYeywSgXzsAt5PnFe4N+mgD0sChmWy0L1
	Y1fvQqEyaP6uJGvBQh96gkKMUmgj34AccQLETivhllMKCYFSbvpt/EZbC1fOAUysXxCMRuQZ7Sw
	s0p32YYsy3FFJmx02OFDwe1nr7bdeIImLktEi3vhQ6Jb7hiw4WfQkFXlmA/welHAzxc0QjF0OeO
	J6b+xl187WRizpGbCzcG1pCX95ay4j4Jip+TewaSqAIWGKa9ikZWcI0nz9+UBqpm686luI16ga4
	wh8uFFxpgAxepb8CHSob661se5RZ0MxDoFXKqQwTnQv2e6M4jb4kUzZLhLYpjCcFEd54v/UQLhU
	vvgZ+BtB9XkvCiyevsNvj5okmgrEQ/U2yjNQtpq2iBDaIKGg0ilWsagtWzeURIQgx0bqfwSLtq+
	M6eE4mWaNpeg9w7feDsjb2Bm0cjXoAox/O6hubvCAhwZTfUay9yN3VIWRUPkuiw6Tu9i34N71eH
	H291A==
X-Received: by 2002:a05:620a:4003:b0:8b2:f090:b167 with SMTP id af79cd13be357-8c6ccdbf81fmr639187685a.24.1769003233554;
        Wed, 21 Jan 2026 05:47:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab288sm1307247385a.6.2026.01.21.05.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:47:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viYYC-00000006Dum-1GTZ;
	Wed, 21 Jan 2026 09:47:12 -0400
Date: Wed, 21 Jan 2026 09:47:12 -0400
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
Subject: Re: [PATCH v4 8/8] vfio: Validate dma-buf revocation semantics
Message-ID: <20260121134712.GZ961572@ziepe.ca>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linaro.org,amd.com,gmail.com,ffwll.ch,redhat.com,collabora.com,chromium.org,linux.intel.com,kernel.org,suse.de,intel.com,8bytes.org,arm.com,shazbot.org,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15831-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCPT_COUNT_TWELVE(0.00)[34];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 163D5584CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 02:59:16PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Use the new dma_buf_attach_revocable() helper to restrict attachments to
> importers that support mapping invalidation.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 5fceefc40e27..85056a5a3faf 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -31,6 +31,9 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>  	if (priv->revoked)
>  		return -ENODEV;
>  
> +	if (!dma_buf_attach_revocable(attachment))
> +		return -EOPNOTSUPP;
> +
>  	return 0;
>  }

We need to push an urgent -rc fix to implement a pin function here
that always fails. That was missed and it means things like rdma can
import vfio when the intention was to block that. It would be bad for
that uAPI mistake to reach a released kernel.

It's tricky that NULL pin ops means "I support pin" :|

Jason

