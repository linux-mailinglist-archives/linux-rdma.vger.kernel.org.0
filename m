Return-Path: <linux-rdma+bounces-11827-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC109AF5873
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 15:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AB4484A8A
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AF4277009;
	Wed,  2 Jul 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OrKKARZv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF712DDD3
	for <linux-rdma@vger.kernel.org>; Wed,  2 Jul 2025 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462287; cv=none; b=DHZhLojQji9++MOJDc6VL7vNfXaUcTWV2kWq4MoNPnjrDaYj0ivVoGwz3ODRl6TWRNZziYf6zkelFh5ZOzAhZN/np8Lq5O8qF7Tx5OuRtVVKYwCgmqTXpJQmw6/qjHv4Z5IgpDHEsM5LExDumL9B8OLPyBn+BJ3C6dDS8yfsRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462287; c=relaxed/simple;
	bh=5kZlihYIZFmatXI4cBGB+TFOdpXZ12A7UPeui5kT3wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ev6ZN/2sHfPCSmkQwV1XAlQwEgWFdqtRn1cHicgJZmMgdcXIHi+ffkBa9GVj1uebstiCGLrQQ2hXylcXo20+HlM/klCDZDvOVPZHFQ973G3Q86OBdhCOZeEbsx9C4/O+FneJGuPg0YcJLEhxrBCCKcNkPpteeQFb7Mu/dxPhuMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OrKKARZv; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74b52bf417cso423445b3a.0
        for <linux-rdma@vger.kernel.org>; Wed, 02 Jul 2025 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1751462285; x=1752067085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz23Tyg/+cYmV17yzTrHH8B+H8AlynLVnYk/5oZAsnA=;
        b=OrKKARZv8psod2z7g4d9SL5QvcXG/puN9MiuhOZ2cR0S7A+s2F+V2qP0eZaFxV2PuQ
         FMb+s28Yy8kYEsxsmG1ZMb458A+GPuDibC6YXlmnSTJJyWnh0WLUGtsCWrFBffK9/kU/
         PYgBhFfCHzvNtH5UjNVjfPibwvbqY/b3sGibgVqKGmdR9F8WxaGulbmvnAbkvTGk0qJC
         z1xkS2TrCOAxGEhdiBK8E7dIKRVN1DV86sozCOXoJ3ZF9h20WNYKL8yreSDnOjbCKQgs
         ZW1wpRLlBkSt8jwK6NxfsV/SESGY1HUo0XRgg8Arj6amgRKnDLE3wPMjeheWwsjgd2rx
         JjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751462285; x=1752067085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz23Tyg/+cYmV17yzTrHH8B+H8AlynLVnYk/5oZAsnA=;
        b=GDMm6Kwns6WwEIs/uax+pOQ2pLuxv9S3fmqKdKyB9boKw5So9Yco03ZrERUSUmG4xL
         Xl9Wc1ShKFStwW30Hl/K13GX0m/92JLRgN2w1k2HSNyFttFzWXpvhWYsf6Bg/52TwyNq
         X8fQJsK+how2cnwUp+/XqIyWuFa5KyELGSpmUEEp7nFmP0Hi3nM8bb7aN4oBPzYHZTS5
         wc1F9QH8ugoBZi4O4wBrceoY+4CMFTod7L7bLyIY9T1oQBBgQIAG8YrtCuSQ5ld+dne4
         DXjHTWnRMFUJupS7/UaUtVwFw0bBNTIB79/6CatiZ3+RMY4R8XplBzzi4iQfO8ZwE5/T
         3vwg==
X-Forwarded-Encrypted: i=1; AJvYcCXqcO9McoiWZL5bS2K0kvw7GhvR/pTTuuvqODRY2qPVrQNgtaEfP3qCHeS/4QSaWxesguVRwr40jXUi@vger.kernel.org
X-Gm-Message-State: AOJu0YyRrCx9QRY5NSLMZ/kcfco83gicM6/tYNDRpZHoRFxoW6+es1cW
	kxOn6KuZU8/RRw41GX989l9lqZ8UOGLUOqLm/NIkqhcRY8dLR45x83tc3Q2btUbUeS4=
X-Gm-Gg: ASbGncvdRrrybLmbj4VKtpOzxK0eyh9/qg1wck8eiMdb9p38oQW/SYhEh3fZfSdfjAM
	GlDW8F2ueI0C3jpTkRBs1HS/W3avMqXtq6SlsSt0zKNgU8YTWsPAOqkK4St62nHRwEiX0Q9BJoy
	H76e0PWe0ZCVHBKEkEfmjSzj2DsKt41S77QCBcQjh6wU12Ks6Ar2s4/VvwAYhO+Ea4XEMuYXsak
	JQBSCvpcHr9BPrZ6gq0svTU6NcpRWFMyYfgX2w7boq+uuJgSVBOi9A7guglN25KN/EEEampSPSj
	vOWOCsuB9Ve56R7YF6oCAj/3irxnOL4Oh2a/XNFiD2CuQNc=
X-Google-Smtp-Source: AGHT+IEGc1zq93nkJMavPRth5ri3c2hUYnAePkxmcp9zyThS7yDUwDvLudNNxEfu++eq0S0smDF4tg==
X-Received: by 2002:a05:6300:6199:b0:21f:a883:d1dd with SMTP id adf61e73a8af0-222d7defa65mr6135557637.14.1751462285065;
        Wed, 02 Jul 2025 06:18:05 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e300d02bsm12981443a12.6.2025.07.02.06.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 06:18:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uWxLf-00000004c0r-0w5g;
	Wed, 02 Jul 2025 10:18:03 -0300
Date: Wed, 2 Jul 2025 10:18:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>, shannon.nelson@amd.com,
	brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Boyer <andrew.boyer@amd.com>
Subject: Re: [PATCH v3 10/14] RDMA/ionic: Register device ops for control path
Message-ID: <20250702131803.GB904431@ziepe.ca>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-11-abhijit.gangurde@amd.com>
 <20250701103844.GB118736@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701103844.GB118736@unreal>

On Tue, Jul 01, 2025 at 01:38:44PM +0300, Leon Romanovsky wrote:
> > +static void ionic_flush_qs(struct ionic_ibdev *dev)
> > +{
> > +	struct ionic_qp *qp, *qp_tmp;
> > +	struct ionic_cq *cq, *cq_tmp;
> > +	LIST_HEAD(flush_list);
> > +	unsigned long index;
> > +
> > +	/* Flush qp send and recv */
> > +	rcu_read_lock();
> > +	xa_for_each(&dev->qp_tbl, index, qp) {
> > +		kref_get(&qp->qp_kref);
> > +		list_add_tail(&qp->ibkill_flush_ent, &flush_list);
> > +	}
> > +	rcu_read_unlock();
> 
> Same question as for CQ. What does RCU lock protect here?

It should protect the kref_get against free of qp. The qp memory must
be RCU freed.

But this pattern requires kref_get_unless_zero()

Jason

