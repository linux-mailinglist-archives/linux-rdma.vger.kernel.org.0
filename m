Return-Path: <linux-rdma+bounces-9195-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A6A7E6CA
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35AF016EE36
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BC6206F15;
	Mon,  7 Apr 2025 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BEzljU0P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CCB207DE7
	for <linux-rdma@vger.kernel.org>; Mon,  7 Apr 2025 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043163; cv=none; b=mGDxvbd24ELfkkdwlSgg4s4LaEgYJEOR/MccxKllmyNepp+k1A9X7su5emCdjav47VgDGHzRSaO9atGYMux+syygoNwAmfyUekiPg9LPaTXBSsbAO93p+HyZzHJc1adbhusZgaIWofu+nAzpBXD5dUGSlv9U4U7F5I6Xoi13gGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043163; c=relaxed/simple;
	bh=GMvaB3Mzb4QuxEqJ77ptGlToNSrLtUC7nn+mY9oNs94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcjfVqaLQMp1GP/hctXtoGbArMOcys29tpZi1PVUCQrfR9ehxWvuAHF7Ldao3hbLqRG8R+yzVBgx4Tb/lrpmLGNronO6qGQPDSUw52dyGLa75cofzPnBNe5zM7WpzfNnQbdLfw9RA9d3JTmFQB6f4IwSs4ekbaJhBbn6Zkp26f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BEzljU0P; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so46660246d6.2
        for <linux-rdma@vger.kernel.org>; Mon, 07 Apr 2025 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744043160; x=1744647960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+iCbhKN/vcDN+xhzXNKoawXibM8X0AG5KtFkzYcV9TI=;
        b=BEzljU0P+1J2qYRt5ZjzzhsUAzbCPxZj9HMuMV0Y+AGVW3zYemgEkl7LFdssaBQgP9
         IBgjTcfbxLsjwYaLL98VrqeDgFM4753fTj4yewr8IrJV9KDZKS/LbXuAsJwNTKHQw8d4
         KyWQLCv5fU7iIo6bGYMuXdBgGthxlrsoX4dRyoBzg+MgVI8vRBG6fCfiZu29lPw7HJ5+
         /LBlTko+INhtqOKllKeog96oEkFnjTidqonNlsRWweqQFBUZiAhA4HKDEJMZQo5gw+1H
         dLXt27ThzXgy5wfeOwmmvf9PmXOpedrbnt6gLBzOxLxRF8wNHyfhy1DxUAeV47HOqR2g
         NFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043160; x=1744647960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iCbhKN/vcDN+xhzXNKoawXibM8X0AG5KtFkzYcV9TI=;
        b=PIBrs48kPhfZ9zZ00GsWxfkCPAgMfMuFy3wjl+/DLgOXH6x13ORDISEnRraKK4lURG
         R68PVOPxBB4ZlA0T/fp+1OTSqacOB+WhP3y2JojgCIIsarQ70WUSd+6/nJoMtJHD9ccz
         wDyV276LVqX+XlCol2BTbH9pSwVnL6ohDdXK/KvXoWx2a2v1BCgGCnqviuDYtZu0dx2y
         2e6M4tgoKaAdOFqVXCnA17Y1jAmH43sTC0OdG4kkhqNDqp3+cctyKg24YUU6MPHL8DyA
         RWtmAT3dRAoP4qO6/tmxtLcM7SrruVce/j7PXmYll+JjEFb+ZWe3QfwqHRyz3w9S9Yxz
         Rywg==
X-Forwarded-Encrypted: i=1; AJvYcCVXcWVVty85doG2C02F1j8nhtajdahGsXl+1XD8YURMH3ViQdngeJrSbhhz+4rltJCsAo+eqYsBWQNs@vger.kernel.org
X-Gm-Message-State: AOJu0YxfqKQQ9NYH09SDxvisJHGwp/xdQk3F6bXjkIKz7xX1XuMpn2bM
	i0mLpflI3dbZljn3KWpnrISbSzXu0h7AhSjJkjuXnroFN2EmczuX0F+NReWhk6s=
X-Gm-Gg: ASbGnctmIIrNVP7VtprGi9+QAlNQYSKSHkB5rBJwXA/cLGHEZuj0AVgKJ0rzjKkhllW
	4vK1509+hxbg1rSycbyYi5WcbHYmyts64CQPPL3K0NOfsYnEUHj3d83JJk+n3vH3KqoQDuIaAts
	g/5VkWdVZbxa9t76eYhUx1QV7sdqjlrwLV9vDrlL8geycP8hPlFOBkWy+8yFxKWXQt2FlSNlpRZ
	6jSmNAvI400OTxu0n5N0k39CnBxV2SSPA0SXTr0lq5r+dkgnIi0gRhRZJok4gdrQhO3Hkkac3PQ
	E7mfWr9Jm9GE4eV1Y0QsEagcjcUNPkSaQCCXk46LgxljGnJPVDeRsvD4QnpyfDF1eBK+UO+OEAh
	++9ubHh13MDxzw9313kq/JwI=
X-Google-Smtp-Source: AGHT+IEg3Lx6+oE5FhUSj9L70cdQ4V88WkIK1cwdCX/+smOJLjX9bN7bqLLW99Cz3jwxXg7No7sDEQ==
X-Received: by 2002:a05:6214:2aa1:b0:6e4:3eb1:2bde with SMTP id 6a1803df08f44-6f00dfd7017mr269610496d6.19.1744043159997;
        Mon, 07 Apr 2025 09:25:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f138c5bsm60200316d6.72.2025.04.07.09.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:25:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u1pIN-00000007DAh-0BNd;
	Mon, 07 Apr 2025 13:25:59 -0300
Date: Mon, 7 Apr 2025 13:25:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: luoqing <l1138897701@163.com>
Cc: luoqing@kylinos.cn, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rdma: infiniband: Added __alloc_cq request value Return
 value non-zero value determination
Message-ID: <20250407162559.GA1562048@ziepe.ca>
References: <20250407093341.3245344-1-l1138897701@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407093341.3245344-1-l1138897701@163.com>

On Mon, Apr 07, 2025 at 05:33:41PM +0800, luoqing wrote:
> From: luoqing <luoqing@kylinos.cn>
> 
> When the kernel allocates memory for completion queue object ib_cq on the specified
> InfiniBand device dev and ensures that the allocated memory is cleared to zero,
> if the ib_cq object is not initialized to 0, a non-null value is still returned,
> and the kernel should exit and give a warning.
> Avoid kernel crash when this memory is initialized.

?? This doesn't make any sense.

> ib_mad_init_device
> 	-->ib_mad_port_open
> 		-->__ib_alloc_cq
> 			-->rdma_zalloc_drv_obj(dev, ib_cq);

rdma_zalloc_drv_obj() must return memory that is validly castable to
the struct ib_cq.

> When ib_cq is zero, the return value of cq is ZERO_SIZE_PTR ((void *)16) and is not non-null
> cq = rdma_zalloc_drv_obj(dev, ib_cq);

It looks to me like the driver returned the wrong size for the ib_cq
in the ops->size_ib_cq. It is not allowed to be 0 if the driver is
supporting cq.

Arguably we should check that the size_* pointers have the requirement
minimum size when registering the driver.

Allocation time is too late.

Jason

