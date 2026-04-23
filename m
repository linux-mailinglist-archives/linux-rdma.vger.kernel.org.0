Return-Path: <linux-rdma+bounces-19520-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOeVBEuh6mlF1gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19520-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 00:46:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEAF458347
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 00:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5256D301E21F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 22:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9605833D6ED;
	Thu, 23 Apr 2026 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gHsocES4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393552E1746
	for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984389; cv=none; b=TY6PfQKjrfBJlZbKoofUD+4X5H33ss37Slzk/THaV40ihBK5LEXflPMwXSg6aluQjHFgj1h54r+bXy/5b+TzCy9yDSM3YlgLx5JUK2z4G+ywwdE4Cbh4723dPUADq1dJMRryRmybnYPbOTyolqAWUPfkzljKYXxopU0oUCZa13w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984389; c=relaxed/simple;
	bh=l9uHSdgj37MlVqmUNMTjAdytE8mxXV9iMRTSDZHL+Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrwCZSuegSKNjWpH3LU72R9HyFGawMwMkDsnGn+JFh6oWOT/SgCwTO0hF9PoKU4uyg+YxX+NfuOgebP3OWjWXv/KUcR6SQhiiTbCB8mns1MQobNiiG4rSEdO+MWSBh1lkUk0pKlf4uxRcAqEdjZkxoSJFBBGytghipRYQCT0jD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gHsocES4; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb38e86cf2so665726285a.1
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776984387; x=1777589187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOyCcpWY9ETk6/DQ/Zzf9IsC2/j7viPfylDYdsbXpuw=;
        b=gHsocES4rM2iEUWKqG8kp+69ntn5/8KkwOOSvqiYUtEDR23ce6l56FUnFcdYvMklOU
         d4iVS5lIb3Y+GL0Pnq9sDAjar03xr2XnLZije5OdOOdjBatHPNLRzHwLUkXjsDLM25G1
         HPol8Kez21ljDOoCS1nRmB9Bl2hxNYShOzDakJLxpTpzUDnbLkKpVZZe9Hf8si1UWDLl
         /Cj/tkVtPO0B6oC/FFGdIQihVUQjyOgTJxjcv9iAiTPKYvDblGzxvu9aLUQxbRuQ4I6I
         q9T4Qp3qASJDwtuUTFCpGZq4yXMEbbQ+J5KEDDPrrylcADSqCh6vlyled3ozriSBybLE
         EDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776984387; x=1777589187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOyCcpWY9ETk6/DQ/Zzf9IsC2/j7viPfylDYdsbXpuw=;
        b=XvnGNuOWYZomQnjOEkMhiFQJOeSLpxJLVtsrf9Ol45dH2Ax1H73sCW1wmh2FXJn2HW
         BZPyA/FyEoDM48UFfAP9Tbdg4nUHCSQfxbZfCL8ksMRSRYokvjEp1QnWNwdj4EN1pkQn
         oRyNpklZk2N7vzNiuqRLS2A69wHkAbOtcTz+vi+oKMGvRwjAN0ibYUJH8qHeIjz14hZq
         S3Cv+41YRSza9c/jl80EpzJMhABCsYHmE+reGP6gj/hnc//UZmGXIKA4vit1Ud2/9vWP
         VUHE/NilXHGY4QyrEE0txhEYiKFwAJjNNwxpnh5CzKbJ4auDr9QLFqaynJUAHnNEVvxe
         c93g==
X-Forwarded-Encrypted: i=1; AFNElJ994iGsyo8aGflMqVJaoMxOa7tBibQ0aVLYFdpGJXzqx+O7r/5gtVw496GCwb/2Eomox0z0dFKdqEmq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1PxbTAPK3McpfOyhw6C2EMR4G/iFdpNXBEKRh9MQvFAxb7D9Z
	WBk76sAMjNtYOWOXiuBXGt8HHU7hPw1q/uPHFzTQ+ZjtcqcOV6MfRyxnAwy4w0TvPFo=
X-Gm-Gg: AeBDieucbWQzIEOSzhDKN+7YtuoyXSzIe16BBHbkTfEBN4axkhByv5GkW98Qzph8RXT
	M9esqFOb7XUY/2UANGiQSD2SkGLA29NVfFI55ol0Hq3KS9g15QCSK7ze4wp8eulWCkrG1SXOOOy
	CxscbLmddi9iuRwsyXmHtxDRIps/RMbkAuQxvZ5rI8nrI1jTrFeGY1pmEFkNFrFb0QEFunPrX1e
	IjdbjqyPfjcg0rjWReGCRJxaDzpbHpiRh1VE2VLAvF7CVQh4hZJkH96rs//nFjC1c7nF2xrdPVX
	zGYgkI3i0JjpspBuOzq76h9E+yEeMj/LDxWyugb1kRcLKZEEFr8P61CdTDJ1X6ONtP1oNpWU2TJ
	gUpTw7FUz27AGkecfQ3gFG5y6gdKRqm0Pp+Y4Q0jGx0YHJKlDrXdI4sWmJSsxTAwPTA0NJHUg8q
	l8VSzorZTxAvP71v36V02tf0e7moDIVALjTrFqNH/taHfcrGTYk+wCpMqKJipHoKB4n/k/4gkjV
	VKsRwRJ/ZscINiM8ZukHX74K0g=
X-Received: by 2002:a05:620a:440d:b0:8ef:74c9:daa7 with SMTP id af79cd13be357-8ef74c9e32fmr1451093685a.8.1776984387201;
        Thu, 23 Apr 2026 15:46:27 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d98c15a9sm1970538185a.43.2026.04.23.15.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 15:46:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wG2oU-0000000GMBz-0jKo;
	Thu, 23 Apr 2026 19:46:26 -0300
Date: Thu, 23 Apr 2026 19:46:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
	Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260423224626.GV3611611@ziepe.ca>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
 <20260422162928.GL3611611@ziepe.ca>
 <20260422132740.5f809bf7@shazbot.org>
 <20260423142828.GQ3611611@ziepe.ca>
 <20260423132016.4a25e074@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423132016.4a25e074@shazbot.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19520-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: 6CEAF458347
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 01:20:16PM -0600, Alex Williamson wrote:

> My suggestion would be that we leave VFIO_DEVICE_FEATURE_DMA_BUF
> unchanged and add a VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl which takes
> the fd from VFIO_DEVICE_FEATURE_DMA_BUF, along with a steering tag and
> processing hint.  It would fdget() the dmabuf fd, validate it's a
> dmabuf via f_ops, validate it's a vfio exported dmabuf via dmabuf->ops,
> find the matching vfio_pci_dma_buf via priv under memory_lock, and
> stuff the provided TPH values into the object.  It would be left to the
> user to sequence setting the TPH values on the dmabuf before the dmabuf
> is consumed by the importer.
> 
> Is that a more reasonable uAPI?  Thanks,

Off hand I think it can work, with the proviso that if userspace uses
the dmabuf before setting the tph the importer may ignore it. I don't
think that is a problem in practice.

Jason

