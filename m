Return-Path: <linux-rdma+bounces-5025-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A7D97D5E4
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 14:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9C21C215DB
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB33F16F0CF;
	Fri, 20 Sep 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YyvSUvZm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72316C850
	for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837072; cv=none; b=NLCzRG2UtYIr5lmFP1qQzEOjE49sLNMCHaIuEkDjNColYbJRJ/ZNIRpu4LJuem1XfsgL3Phw9vDUXiUru4f8jPboXVAvKUrTT7eyXPzptMJtNvoft6W+EhXDFn1t7tUPXFCRs1Q0VV4ePzpj6BHD/O59oOWiMKHu2iTzOvFPtdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837072; c=relaxed/simple;
	bh=hLhdjNdfiab/2EkfVlmYEGUJYgfZ03Yl0qvBdWvH9h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqQRSjMRCi2jAKAHX1SI814srua2G76mNbycbUvmC2SbHe4FJ/rFVSQBMhbaOwu4qz+MU6nxOIrUWv2COKljZ5jXPZOvvrDd3+AVjAapvqsMouNlWZcxv48m1FS0jbQojsDl/3fLh4lkglc5LSozxsMF2nNq5w7g9AU0oNeixv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YyvSUvZm; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-535dc4ec181so1956268e87.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2024 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726837069; x=1727441869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBNOoVCncAgnEXJ28ws1TvOLbbtYMgaYu1jjv19Rj3s=;
        b=YyvSUvZm8iaaRLENtfE+JQo1dlRfQFOtubPfduUkz1Z5suLIviKugcmO8VvjkPEGWT
         6QsmhSkeAmV18WFhCtvE1QLoHdNK+Dezq85lt3AHkC5hV2iwhoUjLYWnHrSNn3qG96V+
         t/oSEhTeG9cyXeoldRLkRlpoigEGfUgSrmK9ge/p5OBNhUqwksXktOlbtHJs3TtuTcnb
         GzPrPC7MmIOj0LWm/mT38vY6FvDNTWC9FiW8LtScpFIpicVHJlwaEQFY5Yzp/7LVaRPY
         4YVGLW/m/6GCTysCPvzzkxoV1MFb32Qv01GOIs990HDWoE57uF3DxcPPbD7wVZSfj9Kh
         rscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726837069; x=1727441869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBNOoVCncAgnEXJ28ws1TvOLbbtYMgaYu1jjv19Rj3s=;
        b=lgtqPbtvT5rdQwt1rXy8Ld4c1N5HMvHc7lWOZw+YEOBvY6I+mXFfFyY6+FP6sCs+WQ
         EZX/VYE4hiGFwH4XliFh/Qev9x+8pN/XDda2S5ZjtRjQTzaHd5i/HigKyIDH5qx7baSy
         oezBpTy0ug8hyv30O71obkUcVdtknbDDrMNgyFV+64K1srfUBartpGZ2H5gHicVOXvrc
         /QG8qOwgLaTp7ZYqudhhrprlZELnW00U3LppbxAKvDVjRBNQJLJG5/ZKFIkQzxCeHl70
         OU+97kcflOayrOPTKlByeiYODzp9SWTDwRUOvibzcLtRH9LtJsKjxnDGZK862PcjB04L
         Z/pA==
X-Forwarded-Encrypted: i=1; AJvYcCVQKd7d9oi/aJX00479jfqYqBx6SMkzsxmvYrNGAMQzQEPYMBkWQVZOGMz9PwSbfMr+7EaOl61Z2LGk@vger.kernel.org
X-Gm-Message-State: AOJu0YyTHHpDnsUc5LB7ieW7U3pQ0bnqxPj/dfli2E8XuOLVpeio16zm
	0sQDFRaKHWKyWUSyPl/WZUQCSOSeQ1LfgIPYN/FnFTBVJZIpLeQ+Nu35L2JwVDKx1YWGbnTtHvi
	2
X-Google-Smtp-Source: AGHT+IFL96h96UXHH5KpQ43VZ5dXdoAGDOaXzmRB7FdY2+9mC7tXyfOx4WKLAHcKL9GgYn35Bt0onQ==
X-Received: by 2002:a05:6512:3b22:b0:52f:1ef:bafe with SMTP id 2adb3069b0e04-536ad16548dmr1571690e87.22.1726837068640;
        Fri, 20 Sep 2024 05:57:48 -0700 (PDT)
Received: from ziepe.ca ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b99c3sm847972766b.127.2024.09.20.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:57:48 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1srdCl-0001Bw-Ez;
	Fri, 20 Sep 2024 09:57:47 -0300
Date: Fri, 20 Sep 2024 09:57:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: haixiao.yan.cn@windriver.com
Cc: liangwenpeng@huawei.com, liweihang@huawei.com, dledford@redhat.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Fix UAF for cq async event
Message-ID: <Zu1xS4dX77jikYw9@ziepe.ca>
References: <20240920124540.2392571-1-haixiao.yan.cn@windriver.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920124540.2392571-1-haixiao.yan.cn@windriver.com>

On Fri, Sep 20, 2024 at 08:45:40PM +0800, haixiao.yan.cn@windriver.com wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> [ Upstream commit a942ec2745ca864cd8512142100e4027dc306a42 ]
> 
> The refcount of CQ is not protected by locks. When CQ asynchronous
> events and CQ destruction are concurrent, CQ may have been released,
> which will cause UAF.
> 
> Use the xa_lock() to protect the CQ refcount.
> 
> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> Link: https://lore.kernel.org/r/20240412091616.370789-6-huangjunxian6@hisilicon.com
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
> ---
> This commit is backporting a942ec2745ca to the branch linux-5.15.y to
> solve the CVE-2024-38545. Please merge this commit to linux-5.15.y.

Don't you need to send this to the stable maintainers too?

Jason

