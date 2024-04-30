Return-Path: <linux-rdma+bounces-2164-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E908B775D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 15:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAED21C22381
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 13:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3513171E60;
	Tue, 30 Apr 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CxlVORiS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11E712CD90
	for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2024 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484477; cv=none; b=oNLR/hb1E2AuRfvVG5mTF9eh2ZjoT/0vVwwC7x26Gkbk5rrJCfVmuUqvFDygHrTTcBRCjHKU2EVhsDr10fQwMtJeL2tSaQsOKiFuK4joJW0Wfnk+8eL775KUoD16Gtx4EzxwHaR148rvwbM1bWqxtcHf/CqZqqH+fBzgVr5vU6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484477; c=relaxed/simple;
	bh=F1qt8VVpzCRzm8FHEJTQ7+DA8vuSysbZAqcXhPKDx5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLJOsZD+9lm7sW24OWz2RJqR9bogc06es6JaE28AWfnewp7ClA7Vv4si/EZWGKevQjas+AgrdoUb/ifj54fvCttlUJFBVA6GcczZ06nSsxrfxMwafV1PiuFK9+NODhjqhRinKcfGLR7FK2jIKh+Skjd0y0CL2jyDTAYXv5nsZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CxlVORiS; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ad21f3e5dcso3982087eaf.3
        for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2024 06:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714484474; x=1715089274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dzw9A3IXUr1HMpouSEVNHEKHoRky87JvxE7doN13XH4=;
        b=CxlVORiSz8Ft+XhknC5X7p8hpv95R1hsLSjC2Z7cgeB39Jg9Az+wAdgRgN8sXMuZ8A
         QnUwjKbSE44px15olS+y8Hk7BNVKJS/EDEFonQA1pFbFnQ6GFUNx2mxi2iDlA0Ntn2+C
         IdV9sLgmp8ex1V69i/eu8EznerLW7BGFqeusmNTkyB9QJfCPDq0xheSAvk4QEhQEwfAP
         pvenH7QkCbYV/fwdiKXfFvSsQCR0jYSj6+dKhjqWHS//Nzg6UZM+RlK3WbUUIxiT5y/G
         GP2k8VKC9UffkWuV3HFbDmrVi2CgHYBk8fo5LDOgeiA3j+09q98iCxFHDeBJIWL4bNUP
         GLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714484474; x=1715089274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dzw9A3IXUr1HMpouSEVNHEKHoRky87JvxE7doN13XH4=;
        b=ORddpuXo5UGZUjUVfw7D1nRyhSYZlEL8osmhX3xNmAYe3+ysuk8SP50AsiPq7nDhtC
         ZZWXwaRkHCdUiMZQzPOFzkGQFTqD9S8P6X3GVdWd50neIfjX0x19R4YGhWgXhhFdOqKS
         1nTvvr9RfuI7CQ0wtHTg0MSNrk+V9UqlBboL5oibzu/MfuJsyg4vJ/ibXaTxHAe7s8HQ
         Z2m+nRkm4YmeDPiOmIzi2QvL4FOYuvOa26eX+Hq1xyOm/38xNMJ4l1wuXiTpj2qrI/Z0
         XWcpxVW/2jL8r27kdKPbLolx8urOHBkHaRpZels1NesHzP9sUjSemBbTvJTcakdC3BO3
         bOiA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ4GytnhxEMvS6i/z3QG3XmHPrhUGzai5pqhvb48WuCBbYBEd4OoOgffSQzfL95JzbbS1E1nqhmTLPZC9k/W+vEy+qov6EG/9eUA==
X-Gm-Message-State: AOJu0YxSdAN2HmmkhXRyJ0oonUObhJeQF0gOrPj0mWvb2jnMdQu4XK36
	8+HBzXawRKpz2bxrtDEriL0AFQPaWQchrWT5dRfaSGLJVOK+RMDIHSe4jfNmSQE=
X-Google-Smtp-Source: AGHT+IErvqN1PfglDscv/jolNjD1aPMMQBUx3pTu9Z5oQ/rvoiryaovZZiP9EN0L/oH7dvTP46YYxQ==
X-Received: by 2002:a4a:bd0a:0:b0:5af:bf76:e3d with SMTP id n10-20020a4abd0a000000b005afbf760e3dmr3781473oop.2.1714484474715;
        Tue, 30 Apr 2024 06:41:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ch14-20020a0568200a0e00b005afafa10ed7sm766053oob.33.2024.04.30.06.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 06:41:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s1njN-007E4h-2V;
	Tue, 30 Apr 2024 10:41:13 -0300
Date: Tue, 30 Apr 2024 10:41:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hns: Support flexible WQE buffer page size
Message-ID: <20240430134113.GU231144@ziepe.ca>
References: <20240430092845.4058786-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430092845.4058786-1-huangjunxian6@hisilicon.com>

On Tue, Apr 30, 2024 at 05:28:45PM +0800, Junxian Huang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> Currently, driver fixedly allocates 4K pages for userspace WQE buffer
> and results in HW reading WQE with a granularity of 4K even in a 64K
> system. HW has to switch pages every 4K, leading to a loss of performance.

> In order to improve performance, add support for userspace to allocate
> flexible WQE buffer page size between 4K to system PAGESIZE.
> @@ -90,7 +90,8 @@ struct hns_roce_ib_create_qp {
>  	__u8    log_sq_bb_count;
>  	__u8    log_sq_stride;
>  	__u8    sq_no_prefetch;
> -	__u8    reserved[5];
> +	__u8    pageshift;
> +	__u8    reserved[4];

It doesn't make any sense to pass in a pageshift from userspace.

Kernel should detect whatever underlying physical contiguity userspace
has been able to create and configure the hardware optimally. The umem
already has all the tools to do this trivially.

Why would you need to specify anything?

Jason

