Return-Path: <linux-rdma+bounces-6379-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313AD9EABC1
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 10:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA29168CF8
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 09:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9B6231C8F;
	Tue, 10 Dec 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TH2IE2kT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AC5230D24
	for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822298; cv=none; b=E11FQT1EjyMR82tUJeEFfUQOzzNrKV9G2P9AStzEbW/STFViKnEg+epzL5+vuf+aFCbC/rfC06dWfH65KkYEBgFG3FfZanTYOKPc7vQpDjMWazdLt7/2k12MtYRUMam7teiA/t+hgv9zPHiRqovev2RQItTf4rXacG5TZrbatVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822298; c=relaxed/simple;
	bh=omI4H5wEH8JLhRjGKGKPftUxFGeyKl21rA8XVcXsT0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTDczj1AIxugxBioZenQk8kIZba2Yg1kS+CEOugLPetXmzY75j4X4DvsVU6ep0MG1XMR06QiwcuZF4xXAhrUMDJfBdIwTVGJhOxt39A6gfRJ9AU00uNDjjqgm/VH0ekR984MOrhYC7dPpUyaeBXSh/Mqx5hntPuABdlqDrQSvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TH2IE2kT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-386329da1d9so1685790f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 01:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733822295; x=1734427095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5TYm2lhOjGpM9NhFrWhlK4D413vHYrOoe381gQTxjI=;
        b=TH2IE2kT6sebE/0jSvj43+KaXeTWtdwQhzBuicR0II+TZru6ddlEDwGCwKywhjLNI6
         yC/f478J8hKEESXp7bpySMqCJk++iIfbjfaMtUeE2gyU4RHJPCRiKXnHvsqDKjO2QwAD
         +8x5HSZToyvAlDI7qs4w51KcGTQOHwjSKrMwyf66q1WZcF41yOT3PJYTGjM6+EcOL4/G
         WKksOu2iUXIgM+NiJG6mKCE7axkTz+wWQCIDXJ0W6HlI5EYJNio5j8xrz5Z9P+pr0u2i
         3FIGy7N+VsHpaGryyx0/OVrWAq8EsaGBCw0cMS7dpM4K9N6w43hl4KB1jld+zTtIWV1f
         xjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822295; x=1734427095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5TYm2lhOjGpM9NhFrWhlK4D413vHYrOoe381gQTxjI=;
        b=mW835BZD6qtaT2xhfLC3B5AsmsRMTgw0jInLqG/sboRRUgqZnQWY4E6SCKC/8uy2gv
         gig7Ek9FkOmVFkn9vWF5qrJTYLzkBZEv94IUH1l7n1ZtQy+g0L5Fvig2fNepoTynnBay
         ea7Ylpne1xksSx+m/s0sB/BF+vKJ4rV36+hhHnog/n+mwZVmXOSub1u+ZiW1jH1RgGQH
         bwaMCqaMBvibYvz47vGlrlsIVE4BCaLFgQeMWu+F03k49pAe/M1/AXLD8Ecz+qrNnDTw
         JEKGif794hhTHCbh9c0fgodAX26dbMuNN1uzstkXv/t0cFCETV3j82jqf+/8ZHmGFsm0
         /Gkg==
X-Forwarded-Encrypted: i=1; AJvYcCUt0MQek5f3Zb5gva5qGIe6K2V+Gckdkm8t8TrQmkuSa4nh6UEaj9bxUYLp0omeIaX4uBfS9aMW/zar@vger.kernel.org
X-Gm-Message-State: AOJu0YwaNqKmnOSoWIDVUL5VfcHjGZb2zlnkrG6f7WRpO6OSMeoopuaD
	BA+QtAA46pxmUlt9soW5L6zGdmzWFPOjtaOcrSAi5OkOjBoTaV2BOx/us6Z9b+w=
X-Gm-Gg: ASbGncuDXLJZBSBfk2LWIjwgPaUggRbmKJnfOuV5aERbS3jxpyBKmVsF3NjqYX8/fTq
	iC8bvjRuluHtDB07yplC3zCVZuw1o03hP8aNNsF/UYUefjzluuV/o5Tofg3Wbj6Xk6sR4PEiLLi
	adkVlrt5qBzFaF4c7TRBRR2D088aVkE242xsuaqlRoqJ0pn0VyjGJU37H9hDhTPg8AhXcI9/dWP
	Dx0T5OCZtzPZoDdQyhvLEnR3qCzTPHSBmxA1HI5luQUxqHmFpelrRtt5AE=
X-Google-Smtp-Source: AGHT+IFjWDG/W2QUiJNWkvXL0j3HEL2mML/EEgKgjQFUReAFpFCpCXM9Ksl+aVXTWX9RQ6O6ancsng==
X-Received: by 2002:a05:6000:1acf:b0:385:f409:b42 with SMTP id ffacd0b85a97d-386453fe4d2mr2869941f8f.53.1733822294723;
        Tue, 10 Dec 2024 01:18:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a8758sm15221326f8f.27.2024.12.10.01.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:18:14 -0800 (PST)
Date: Tue, 10 Dec 2024 12:18:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Atul Gupta <atul.gupta@chelsio.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Casey Leedom <leedom@chelsio.com>,
	Michael Werner <werner@chelsio.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cxgb4: prevent potential integer overflow on 32bit
Message-ID: <65603cba-eeaa-41ef-8d62-3453f3d19c7b@stanley.mountain>
References: <86b404e1-4a75-4a35-a34e-e3054fa554c7@stanley.mountain>
 <20241209185556.GA2367494@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209185556.GA2367494@nvidia.com>

On Mon, Dec 09, 2024 at 02:55:56PM -0400, Jason Gunthorpe wrote:
> On Sat, Nov 30, 2024 at 01:01:37PM +0300, Dan Carpenter wrote:
> > The "gl->tot_len" variable is controlled by the user.  It comes from
> > process_responses().  On 32bit systems, the "gl->tot_len +
> > sizeof(struct cpl_pass_accept_req) + sizeof(struct rss_header)" addition
> > could have an integer wrapping bug.  Use size_add() to prevent this.
> > 
> > Fixes: a08943947873 ("crypto: chtls - Register chtls with net tls")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > This is from static analysis.  I've spent some time reviewing this code
> > but I might be wrong.
> 
> Applied to for-next
> 
> I fixed the Fixes line:
> 
>     Fixes: 1cab775c3e75 ("RDMA/cxgb4: Fix LE hash collision bug for passive open connection")

Aw crud.  There are two implementations of copy_gl_to_skb_pkt() and I
only patched one.  It's pretty weird how I mixed up the Fixes tags.
Anyway, I'll patch drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
as well.

regards,
dan carpenter


