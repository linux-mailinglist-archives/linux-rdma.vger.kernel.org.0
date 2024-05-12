Return-Path: <linux-rdma+bounces-2436-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEF48C3716
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 17:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FABD1F21620
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 15:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4463F4120B;
	Sun, 12 May 2024 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b9aNPznu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FFC381DA
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715527935; cv=none; b=uEwO719J3s2LAWpVggxgCsK5oDjq3+tqce/twSCn6yj4WCbV1DQntNmBQwZWh4BFlmek0ZRv/jBmU3BsUwZOPaKGotUNJIs1py4e17Ld0+GBslBYg3zWEXwgqlYqaLHV01XnZwuFA0I1quqKVlLyZzF1LasAwslhckHbjS/RtaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715527935; c=relaxed/simple;
	bh=c/xR6XWd0ZJ2Apihi/VXSlbxsQFdOfpx1NEcoN7iM1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtLdrRhfNHjdh4QFvqsA69powNY0m5hDTXLjfpSj/jp0dNMQd+Rk8mLgoJZ/BZDNYNlurIJNVzRunm/AvZNFDy3oh+CEJzZgHM/NysFREVNlo5dlqzQ2IQpBhCQPhPoQ0HMFo6ZUdEW4uufnqQV1+FnvuPZCzxYhGWtyronmnJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=b9aNPznu; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-792ce7a1febso59149685a.1
        for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715527932; x=1716132732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0efAPLV7gJorXuDH/HsiT6gIfHOKo8TmSCEI2yyuMFQ=;
        b=b9aNPznu8DLUvLVOpFdxSCp037hBpS1wchBMrc9ocgVegPi9Fz4P/QowVRwqtmuCDh
         BtEJIT4l7kX9aWVfDzEukPLA7NOooHfToaCJZUBETD+4GYRXcnPxST2pjUfRIhCaqyXa
         MS/71JyfLm90aAz0rACx9H4ElFucV/OflJJTl3mIRCm8ATbIQW4GCfO2KrPlm1+MgONj
         9CIhSBJcdoykJLBbTK2oZ9ZpRG0J1jclVxjL+WROzDYY5G2DMWNslJAmL9pBOKxnsyt2
         mq8baz4VnSv+0Z+NOG/DjRlXTK7blVuaOyJftshRhc/CKK7Dge6HjaAGH2T+3OgLazDK
         TjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715527932; x=1716132732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0efAPLV7gJorXuDH/HsiT6gIfHOKo8TmSCEI2yyuMFQ=;
        b=UV5tXKUr9QR262OB2ow+9FPZ+z139fL6+P0Aw5g0vDnfUics8AcJcBNQefSExT+7+m
         d6Y6qxvw2HkrNY4o6jD0Laa8/w1uRN+C1Pp1/X2284b9z6razCfxXxmsGHx1wBzriJ1D
         4OUJNXFvg+uNPcel5z3ZTQCOqN37zvDhV2hS0nwRJHb8qhgCPqBOoQ3UuRwAahoNv98R
         qE7YeCbixYBYf8bmlhhCvuOkxOsGAB6bzRm/3vAYDRLOGyVWCLDJpKTM7HBxlc62QZN8
         4rKiSBHng6841PML0Og7r1y3fTsVQGlsp8wdVI0XgIL3t418nnSwzErtf3xrVafUuRYT
         Y2VA==
X-Forwarded-Encrypted: i=1; AJvYcCWmcK1d7s4k4d2ngFCWE6L1CkajIgQICWQHgW7gSgqQWwkbH5NKcpAN6i5b9r/ynV/HFupUDZ5v2+KGAyheKHGFk3LD3VUuv1FD6Q==
X-Gm-Message-State: AOJu0YxOmt8IwCe9QKCyrTw1y6rWoAQeMZlZpeUWP9LM+H7/A/9+Ndtd
	TOlfLa5CnlcvQusGBYM88QWsPLpzUUyuyZtSg17RhrzaxsGjI2v+Nzwwsr+KM70=
X-Google-Smtp-Source: AGHT+IF6ABeDSAxVTyR4eCJ86ITbHVICbjDvsIz9fFFVAp47oxU8ErURGU+awbml0lKGxv/RxMvDfA==
X-Received: by 2002:a05:620a:3bc4:b0:790:fc71:26ec with SMTP id af79cd13be357-792c75ffcd1mr883079885a.48.1715527932515;
        Sun, 12 May 2024 08:32:12 -0700 (PDT)
Received: from ziepe.ca ([205.220.129.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf280390sm373982785a.35.2024.05.12.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 08:32:11 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s6BBA-0003W4-S6;
	Sun, 12 May 2024 12:32:00 -0300
Date: Sun, 12 May 2024 12:32:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Shay Drory <shayd@nvidia.com>,
	netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v4 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <ZkDg8Aj/TdOqFwqf@ziepe.ca>
References: <20240509091411.627775-1-shayd@nvidia.com>
 <20240509091411.627775-2-shayd@nvidia.com>
 <2024051056-encrypt-divided-30d2@gregkh>
 <22533dbb-3be9-4ff2-9b59-b3d6a650f7b3@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22533dbb-3be9-4ff2-9b59-b3d6a650f7b3@intel.com>

On Fri, May 10, 2024 at 02:54:49PM +0200, Przemek Kitszel wrote:
> > > +	refcount_set(new_ref, 1);
> > > +	ref = __xa_cmpxchg(&irqs, irq, NULL, new_ref, GFP_KERNEL);
> > > +	if (ref) {
> > > +		kfree(new_ref);
> > > +		if (xa_is_err(ref)) {
> > > +			ret = xa_err(ref);
> > > +			goto out;
> > > +		}
> > > +
> > > +		/* Another thread beat us to creating the enrtry. */
> > > +		refcount_inc(ref);
> > 
> > How can that happen?  Why not just use a normal simple lock for all of
> > this so you don't have to mess with refcounts at all?  This is not
> > performance-relevent code at all, but yet with a refcount you cause
> > almost the same issues that a normal lock would have, plus the increased
> > complexity of all of the surrounding code (like this, and the crazy
> > __xa_cmpxchg() call)
> > 
> > Make this simple please.
> 
> I find current API of xarray not ideal for this use case, and would like
> to fix it, but let me write a proper RFC to don't derail (or slow down)
> this series.

I think xarray can do this just fine already??

xa_lock(&irqs);
used = xa_to_value(xa_load(&irqs, irq));
used++;
ret = xa_store(&irqs, irq, xa_mk_value(used));
xa_unlock(&irqs);

And you can safely read the value using the typical xa_load RCU locking.

Jason

