Return-Path: <linux-rdma+bounces-21591-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL2/E+rGHWrgdwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21591-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 19:52:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B34623810
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 19:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B40530234F5
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC1B3DF01A;
	Mon,  1 Jun 2026 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E1NRdFXs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441B73BCD07
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2026 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336207; cv=none; b=DasDnEz90Vg4Mv42xaUWIWYjj0OAUn+7W9hmucp9OAgrLPx+5AcXrqkAnzOJATNQmRiG7LVqfi7FP/z1HrZzb2D1fWe5W1XWOk+BdjOCOItGvJhy10TpL14wA+T7mqHn9Bq8FOLzQz1waG4CN/Fj+QzEJ0/u+Pi7j5pyDDayXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336207; c=relaxed/simple;
	bh=F2YxxOkKlKZBIWFURMEVCr5gD32ZZSGaaonobu2u2vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fn4sFxkN3Ro5anPcmGRqY2rNWpmevnrYQ6SmiAro+teVXIJcYBWvHFxjSvHDFZkOJfji5eLxXCvE+AkAJwOuhB6JKFt2qPFq6bhbSgHpfq8l+SAi2ZYvBRNRBR2iLjp9utSkp/OzREQ7yxdDAc2aTbRCCdtlqs5sVfRlEZ67Sfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E1NRdFXs; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5174a133bc3so19324931cf.1
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jun 2026 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780336205; x=1780941005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GKY9bYORGkGGjohi6puGGa+RVGmQ7HsclerYSswNqXE=;
        b=E1NRdFXsS+4pI/8us9aiFTiuOZ3sFgLkvWFF8gYQjhL9p10cYcKjMOBYXvv4sxqA7f
         ydRtf4GiDXCaBMupES4/hXlcFnSXwn8RQxh0I1mEjN0nGV14FOysSjd4SISi6gWIaxtN
         TPiNcOLVHcu6hSOjseVGwH42K7itWDC/CeqG2srydRM7E74Q3FspiyCsOsY/RzvtwJr4
         crdmag48U2+0A5DGllHS29LIV/q7CJ6xbHawWxDVfCKDQWLVWaPQWep+8UPgcIqSBznG
         Nq+dy69bBB05kU1MaW3d7GeDAAZH4ZYYNg9aC+8L9UN9EcB2lhR8tQKFgR+mOIGE3nyV
         UQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336205; x=1780941005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKY9bYORGkGGjohi6puGGa+RVGmQ7HsclerYSswNqXE=;
        b=Ac49EIHfOest5z9UNTTf+pFIMampTaUL0f+oS/7TIZaW/J656UNJG+sQl/NE06c7XT
         fNM4Aij+Avbfp4iltQX+OcwcVitGW3nZMXBnIKmwqOm5p0qj/o7G3KDS9CZl0OiLSYha
         7sPshPC5TI+O4O90ekcq1kf+6b7UALisVb+k7ZjLtqk6/MoT67q3ukdc5NzuLwfh73t1
         4TdWN43N4R1mUwS1uYjSZNnd/lRMSwpSyxmY/soGKiiiop6GAzoUuUMcZKVZnQO2iNhv
         Zi3LXYKU9Ttazu/rBgLUZej7opGUUMTrlIs+2qgZ4HC5md2AaFkE0mv6uPxyoU8Vs9L+
         Eg1A==
X-Forwarded-Encrypted: i=1; AFNElJ9gFvilnPOZ+t1xlwS9zpgk2v73KpY9LJerQLRAC9hIokj80ya4om+CDTNlGsMZCfVRgKWMopl3dFsz@vger.kernel.org
X-Gm-Message-State: AOJu0YxAfLjqPFhPDTiW9vnYU/GSyeDaQ2ggCpO3cOLtl92vrHnjzt7H
	eDezddcqzOiQd+X4Y9aCXIGWRhprejnpZPdQSxUrMfluMtO1EhYGKm+tkPrrSCu/vAk=
X-Gm-Gg: Acq92OHCcE0cR3mi+t3TTZGVdNLVgeCgwy0uVQWZiiG3aDzMACTvk8svoKCknTIFAbE
	YJgrCDj3JYQxC3zUZTBF/DZEdUIFw0/EHGWhCrDSu7KpWNTaDz92UWuUxxRrntBKjN4WxVysGNk
	xWeNqQneXsW8AlXaqJcH8ZMTdRasF+daFpdKR3HhCqnxAr2pMU0edb6A9tEfs7NYSSpXgfFcJnS
	JNPq+c8/fHNCaw4mRzzMArcVCe9mTWDbMtRxhxrq5fNYGzcpn0NS12soNeUVicP9RLVivKDHfEz
	Dp/nBXqzUE5eDnbJFulESajGILaufu6vTVQGkMUNoXOBPKA6fgLYZ1JepKov83ejS6R0EzCM+2G
	5+aI1RptyPwESDzVf+unycZh521Yj+k4Cyy0N4n7wT6mMnLfKrnOyNwJ1khUmR7TACjr24hpRw6
	l/qaM1UN4CETakv75Qc4ahHG06FN5EcWmb13etK0dufKxg2Rtursl0GBAXqIFo/DjdCZLWUwUqh
	NYC+fUxAmvxD2MC
X-Received: by 2002:a05:622a:1148:b0:50d:d1ea:65dd with SMTP id d75a77b69052e-5173a722af3mr169052191cf.14.1780336205151;
        Mon, 01 Jun 2026 10:50:05 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741d6a240sm60989871cf.18.2026.06.01.10.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:50:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wU6m4-000000027Uh-034u;
	Mon, 01 Jun 2026 14:50:04 -0300
Date: Mon, 1 Jun 2026 14:50:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Keith Busch <kbusch@kernel.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Zhiping Zhang <zhipingz@meta.com>,
	Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260601175003.GC2487554@ziepe.ca>
References: <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
 <ahn3ovmkEq-Y-LKt@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahn3ovmkEq-Y-LKt@kbusch-mbp>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21591-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 07B34623810
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 02:31:30PM -0600, Keith Busch wrote:
> On Fri, May 29, 2026 at 09:36:00AM +0200, Christian König wrote:
> > On 5/29/26 08:34, Zhiping Zhang wrote:
> > ...
> > > There's no in-tree vendor PF driver
> > 
> > Well I have to admit it's a bit on the edge but this sentence is a show stopper.
> > 
> > DMA-buf is an in kernel interface for buffer sharing between drivers and any change to it needs an in kernel driver as justification for the added complexity.
> > 
> > > - the device is a Meta MTIA
> > > accelerator managed entirely from userspace via VFIO passthrough.
> > 
> > When you have a complete open source driver stack which utilizes VFIO passthrough as the interface to communicate with the kernel drivers then we can eventually talk about that.
> > 
> > But as far as I can see without upstreaming or at least open sourcing the full stack to utilize this functionality it's a clear NAK to upstreaming this.
> 
> But the existing dmabuf for vfio-pci was accepted upstream without these
> requirements. I see you had concerns about even that, but still Acked
> under the same model that's propsed in this series:
> 
>   https://lore.kernel.org/linux-pci/57b8876f-1399-4e4d-a44b-1177787aa17d@amd.com/

To be fair that is quite different there isn't a proprietary userspace
issue for that series, and there should be more users of the API when
the GPU drivers migrate..

Jason

