Return-Path: <linux-rdma+bounces-4617-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AE3962A02
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 16:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402211C22A32
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 14:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BDE1BC20;
	Wed, 28 Aug 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hNHRkZXZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1385E1459FD
	for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854632; cv=none; b=CYdaCsPCPz49PIBQmNxefBS+puU/BBNrmtuR6g9yZtPYUC1xZtqjZ3V4TmY/OXfCQbnaQhi788jq3gnnFN21jCqs1rwG3na4NCUwo8YCJtWnibUU7y+tJfqiyF6ZC/Xr0mdvYLkK1yZWz6+RwTmbDkehH6VkuJ8di6ExzjgToNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854632; c=relaxed/simple;
	bh=ABVJBE8zlLuPd7dqkQYpgWIXcxwmIOidv8gNILHmEdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JB8kU0dgYHKg4b+5v1UuwsxZKw0K/gYwVH3pv1FcAvLZfQZpJfKCjF6uqH6ip0tR5/ipfPaUQ6nIwNezT2vT31jjQUazD0+tT7mCcZaB9YStFU5kP1iyIzq5bF2YbkWCDzigrwXms5jXLCcb7YjJYQubesq8sCtaTbOuhWTz9Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hNHRkZXZ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4567587224eso2514011cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724854630; x=1725459430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LBgc6xQ6rnnUOANkYW1zCbTnPsE9MHPciqZzRiqEJfk=;
        b=hNHRkZXZtZWH6BxgiWxDPMy3FMSEqLwhxPOHvi9VjsRW4EMKm8rizqW6RkTHCb3ym4
         at17FKM5GWKhZGqVY4yeJKz0NUADp7B6e4nL2hj4QoSVqlodKsFnQr99UftM7ZuYxMJp
         NeyQ9+gxqHYGE+QsSP0mQ/Q8A3I39vNGV1hM+GtBZ6oZ6LA8dCfnUbtKqvm5gM8MOL0B
         h5HddpVn/qcrrAPdD9WHnTFqHZTWTch927Aow8KFPm7zP10rSlb9cvmPdWrSNajuQzpy
         Z1/EIKqA2MKx1SEWhdwSAKUvnjxNeJuwN4CEOHe1pGYGXpdM+T83s1Wk4Cv5VaKPQUgb
         Ui4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854630; x=1725459430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBgc6xQ6rnnUOANkYW1zCbTnPsE9MHPciqZzRiqEJfk=;
        b=I1XQeBJEepX9XppNi04CuoAskwAmQdWEvT5bqPIvgXsaetA6FIY84/TqkOp+q2OtiT
         VQ8GNoZEoaFHWwDF7Uo07Gs9IYDtPLBHQKD0mW8D0A4jrgFcfDsm3LniceT5eoZGUb5y
         DlxsjgIDQ2ynCeAhndY5DshXjtaLvZZHZXF6yp7mNV/NTUE8FBST8VP2widLN0SMhBuA
         uv+evL+2iA/ZQ/4SyE9ejHNb9tHDqGBYvKqfQMUNqHEfDDwHjVAGHIfA6aOdsyS8A9u2
         GSgROkt3jT2mxkxf5JYUMi2L0hZcb2eJH5ugSWSZ+eCqffzi1Smtzu2LJ8diMBvZ+P0C
         T8hw==
X-Forwarded-Encrypted: i=1; AJvYcCXueQ3JKqpk4+N/5HnWHff174/LjeQ7PxEYazUA9CW6lkaXd+sqzazYPPNRO661zeXMJaFO/lwnCjr4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuc+bsv1RSeXbogEEFViDD0PZN+9IeZuu60YZk2GiP6yBVoLbq
	rWEoY2mKU038fx3UKIuJbkLWig3C7WBtvQzDWNTwUZuGILQw91/qsS7V+TNcBgq/LhMivGJH5pF
	d
X-Google-Smtp-Source: AGHT+IG9SK3M6EsZlpXj41JikrUEAGWuX8yghlRBi9RAPs6vJoNFmmStqQDbVDXsfnQ4pwhwORX8tw==
X-Received: by 2002:a05:622a:5a94:b0:447:dfe3:9e76 with SMTP id d75a77b69052e-455097e1ff8mr173478921cf.62.1724854629675;
        Wed, 28 Aug 2024 07:17:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0f54dasm62179621cf.52.2024.08.28.07.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:17:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sjJTw-005592-5D;
	Wed, 28 Aug 2024 11:17:08 -0300
Date: Wed, 28 Aug 2024 11:17:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Doug Miller <doug.miller@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-remoteproc@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Using RPMSG to communicate between host and guest drivers
Message-ID: <20240828141708.GQ3468552@ziepe.ca>
References: <133c1301-dd19-4cce-82dc-3e8ee145c594@cornelisnetworks.com>
 <842aef7f-d6e1-490a-97b9-163287ddfe2d@cornelisnetworks.com>
 <20240826234530.GK3468552@ziepe.ca>
 <0f6e27d3-8942-492e-86e8-730c00a5aa37@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f6e27d3-8942-492e-86e8-730c00a5aa37@cornelisnetworks.com>

On Wed, Aug 28, 2024 at 06:49:27AM -0500, Doug Miller wrote:
> > Typically in cases like this you'd paravirtualize some of the VF
> > before sticking it in the VM so that there is a tidy channel between
> > the VF driver and the VMM to do whatever this coordination is. There
> > are many examples, but it is hard to see if you don't know the device
> > architectures in detail.
>
> Can you give more detail on how this paravirtualization is accomplished?
> Or point to an example? 

Not sure I have easy examples, several devices I've seen proxy things
through their FW/HW. I think some of the Intel NICs were working like
this.

Some have full vfio-mdevs or qemu modules to intercept registers and
build it.

> It seems to me that rpmsg would be a cleaner solution, at least
> until I can see how paravirtualization is implemented for
> comparison.

I think you will find it very hard to connect such a thing up
throughout all the peices of software. Having two related devices
across everything is not easy.

Jason

