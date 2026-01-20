Return-Path: <linux-rdma+bounces-15757-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D0CD3C32C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 10:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19D086623E1
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E683BBA1C;
	Tue, 20 Jan 2026 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yCo7gQFv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FC02E6CD2
	for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900057; cv=none; b=X/WD3LCJG61T4ZuRsuL4VOsiqxoQRMOjjK+etbErIzGIRdpJE6zZDpwFFD/0Qt/0WTYm52A2T4/Mt3Sm4n6gAqvtCfBweYuYhI8dwdgx5zqUGJSj1+BfKln0NknC2j+VGH2B9EilaRS1rgHbXhBzrTMbbyAUlzRdWOO1rws1Dfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900057; c=relaxed/simple;
	bh=tmzHPVJWcVllsS6qjUH7Yr6YydliKQcgrtP3+8kpSo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkqRXAek0ocnnMCBtHyLjjb9GqS5gislxQRwUlM4MUN2yCwwRwiaPGNXHjfvwL+DI0TJpvU2GFsz1OmOvLtJcTEiMnwQU+5SJIvHqdIuMr9+4+wchkosJyw7LHlYTvQ6iOAfmW1Kw1qxthU3D88pdIYaxLN3tpyfO9goMGEJZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yCo7gQFv; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47ee4539adfso42396565e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 01:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768900053; x=1769504853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YBOmsfQsEC/QDMdusTEFByXKE9dxfSK6RyZMS2/2PRU=;
        b=yCo7gQFvx0h5bin9potzv8sQSlkOlanNf0sQmmEbcqt7OUn2lWo3rZ9OFzH2KMDjET
         q8Zlm+4hoLZUGFVYH1aEyGtBm7EppZN7wqQD6s80qe9G6tQa8YPkah5dpQOyQi+WEtj3
         /56VyEuFvltdtsqv1QGzatKkAGvAnQGYLJWhRNdRd+mfOaUiaOo6SLBNFgVqO3Qimeqe
         hGaFeKZLVDYMrIaQXPK6H1NyeWVWxSQ/NMdhRmcVtgzTiddujWC0Dc4HdteyH0/iz8ww
         pxdu35t4SR8cBjHFXKbjHTgTgnFWvWjXvDm5hEKoaRQmGn7pYPYE0ELo5s1/9c6/sIxI
         7puQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900053; x=1769504853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBOmsfQsEC/QDMdusTEFByXKE9dxfSK6RyZMS2/2PRU=;
        b=tHefB8SUhGh+a37HlqU7qHa7yTsWxNZumxGU8MJXwbxNdsiauBSRfDpAS0edVRizUx
         3dxKKBNZE1g+4HbWaTOCpiUkEtDDdlyBMYu0FwfhWaj5+x6Z89sa6bqDhYSX5/KwXAMe
         QKy+le6XK8cADXmkXwBJH9bpCvTMbWm5pYgJWpAeJ7wxnmB0b26eAnCDFtfUWG8tXlPQ
         W2xuTUZHi5GT7uew36qZlx2xtIGu3Sb9H5slxSEeBtJQnSGc8oBw5b03hqofGyP2cduQ
         7T5IWD1GXajIrhuCBTswPsLt7zZ1LHhESVFVXWGPX9eXfcsO0GVtLxlliiat2pjmScIB
         TmcA==
X-Forwarded-Encrypted: i=1; AJvYcCVKYnh/O/dMbdkzjb/V/aGGO/TiJe40lXwnEyCP9hrc0nZB7C8SkNPY/txjWDLqVmamDG8+RjoGRVRt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcv0hJa/PrZq9zfh32kAgP8h0wu7AYdYzSHLb9em+Zs7Q12fok
	/ki7iEZp8cJFh4HIT9YWvDtPfILm5tzJ/DBUVkvF3SA0gx7X8XWkuowKpwvfjNOfdW0=
X-Gm-Gg: AY/fxX7K77tojGpbeG/0r8FrazAZYGEXyET5yisvrl4XzRpfsPR1R4bsXr+DvMDzESx
	l8N937z32JSrBzdFJ0brYP6EAiHKXsNlrFTDcuPc+eBLBCcG/IMmjNaUtromPQWM1+M/NVaileU
	7Zw0Ic/2Hr5JR9Zkiqw5FV0PjlfnjF/XZ8ZnjmsbSfstO4cpoCg/8FS4H5hXypwAIiA3yZ8fxBI
	crfpkceZLk9qwRmHNQQ3aJyGefhb+oL9v0UGZRgCbGMVuV6/HBG5lLKfUlDd0P8zFNu5+fdT3T+
	RK3hsRqG4cmIfQ0X4dDgxgaijy3C5O4/x2ImSMyx6C8LJAXoSVHSMwF0bLiojo8Dfr++bUO+mAw
	SRd2tB7n4SDFhc/IUoaEBlXO8bygc1JBIETnS45i0BiGI6lBMKNHX02D8k2xoALI1hS3kKP7lBI
	XKKKNVE2R8dSM+Jf595BxUTFFV9pY=
X-Received: by 2002:a05:600c:3150:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-4803e7e7dacmr15742955e9.22.1768900053229;
        Tue, 20 Jan 2026 01:07:33 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8795f1sm237949385e9.6.2026.01.20.01.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:07:32 -0800 (PST)
Date: Tue, 20 Jan 2026 12:07:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
	Simon Horman <horms@kernel.org>, kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Usman Ansari <usman.ansari@broadcom.com>
Subject: Re: [v2] RDMA/bng_re: Unwind bng_re_dev_init properly and remove
 unnecessary rdev check
Message-ID: <aW9F0QZ5E-VaENOO@stanley.mountain>
References: <20260120090204.635526-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120090204.635526-1-siva.kallam@broadcom.com>

On Tue, Jan 20, 2026 at 09:02:04AM +0000, Siva Reddy Kallam wrote:
> Fix below smatch warnings:
> drivers/infiniband/hw/bng_re/bng_dev.c:113
> bng_re_net_ring_free() warn: variable dereferenced before check 'rdev'
> (see line 107)
> drivers/infiniband/hw/bng_re/bng_dev.c:270
> bng_re_dev_init() warn: missing unwind goto?

I would probably split this into two patches, one to remove the NULL
checks and one to fix the unwinding.  I would say that even though
removing the NULL checks doesn't fix a real life bug, it's probably
still worth having a Fixes tag because otherwise if this is backported
to an older kernel it will trigger the warning again and we'll have
to review it again.  Where if it has a fixes tag, the cleanup will be
backported as well.

> 
> The first warning is due to accessing rdev before validity check in
> bng_re_net_ring_free.So, removed unnecessary rdev check in
> bng_re_net_ring_free.
> The smatch also flagged about unwinding bng_re_dev_init. So, added proper
> unwinding ladder in bng_re_dev_init.
> 
> ------
> Changes from:
> v1->v2
> Addressed the following comments by Leon Romanovsky:
> - provide proper commit message
> - remove aux_dev check in bng_re_net_ring_free
> - remove uncessary validity checks in driver paths
> - remove uncessary NULL assignment to rdev->nqr in bng_re_dev_init.
> --------
> 

This isn't the right way to send a v2 patch.  I have written a blog
which explains more.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

> Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firmware channel")
> Reported-by: Simon Horman <horms@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202601010413.sWadrQel-lkp@intel.com/
> Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
> ---
>  drivers/infiniband/hw/bng_re/bng_dev.c | 56 +++++++++-----------------
>  1 file changed, 19 insertions(+), 37 deletions(-)
> 

regards,
dan carpenter


