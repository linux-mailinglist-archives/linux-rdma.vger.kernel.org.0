Return-Path: <linux-rdma+bounces-8931-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78930A7031C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 15:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A101690F6
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6962580E1;
	Tue, 25 Mar 2025 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ap4WG8wP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C171EEA4E
	for <linux-rdma@vger.kernel.org>; Tue, 25 Mar 2025 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910936; cv=none; b=QvvbtSJTpEkok8DECRyNawWhV2stTAp6VOdECpRwSQZAo3OrahMCOLMCJ11dg7ruv5uS6umjMmnc3gbOAa70SZTDkSGLA2/DP1++v5Phak8iMKFpzu3ZxV1wFCwEz41z8iGxYBt6sLRG+OYWxhXtoY6IIRi6M8f0349w2d9TZ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910936; c=relaxed/simple;
	bh=OSX0TORPiNrDXa8v+Fpy4Nylpvg63xS3qyc2FnH4q+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNCO1ceYkIGy6/ge7Va7fN36IeQ1nPqj096UtbzQ/sf6gidINukbPdi18tndNNTA+bsyluj5e2B5r3qmL0vu3ZLZcytsnPses+vTKyW5pHY6A5dWT/qgpzwVS/wpxt3DuFMnPpUB3fYf62NMPzhAo+wyiGM1gSejdsCy5cBq3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ap4WG8wP; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-477296dce76so31285401cf.3
        for <linux-rdma@vger.kernel.org>; Tue, 25 Mar 2025 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742910932; x=1743515732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVfx3UQRZQeGiEfg09GHBIEEGmSfPB7wa4J0uKs3RME=;
        b=ap4WG8wPmBSb8/XdIF83BORCSmQzjffScOehv78NDPDGzmMYIKI+wdfemY6XVPmUYa
         4rt2IIYPrKGiSLROMekcY8725sxV1KSPZjzEegh+VeN3uFiRx+PWfBXPM2zGnARSDR0e
         AFwyvOn/9TH8HlBmI7XJUH81Vd/NyCzbwYvYhE0NIRXJezZcgLxdKnjn9T8lI5Vc4C4i
         joEIvrDjVeT83p6pIYxYZctUSNOuj1GgGqytQvNEYGlZIuCYE/73zhyQzUhWwkZSQHAD
         ajmtPcaojEsW1Gn/Fu2EYzIgatIS9YwGRExVVy6Gni9RpY/go6oQx4NVBENAdmYYPaED
         qmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910932; x=1743515732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVfx3UQRZQeGiEfg09GHBIEEGmSfPB7wa4J0uKs3RME=;
        b=G9lGrj4mz/vmjhPRKf52L1RFqjxtDHJCghLMxoiWnSDs6QUAP93fDRUQQh986DzT7p
         04JyqlCVpYNXEKjkjnLRKKZs64G+lMP/5W4/9wKEGqeV5XI9KIlr+SJz91v+hBDioPK6
         oLgLzYxNlt1oEO/HAiECZow2/b/Ui2+fAe6VU1xRf6t6p4Z0geAWXR3g6z7WL2sZKsRa
         DLJ+KGBNeGuBTRZj9vwXwxxQSkpVUm97eW5rTqeCXHt3FYb0j0ePiQajEvvX48PbaXnc
         a8qUpxd+i7NcTsEEmXD6PHLPdRYO1EDkxi+AS9lg+AaYbCsG7HFf0dSxl0Pi2XBqRkbJ
         4jUg==
X-Forwarded-Encrypted: i=1; AJvYcCWrX3M3y7w3fGo0mv3S3NipF7A3s7u4J2FxLoa5ENUG7vTo8r+zqZ+VIY3/IovQmWNYET1bq4XgCEwX@vger.kernel.org
X-Gm-Message-State: AOJu0YyehgkFRMnb2csuRMa6qKxqjZfovz8Xt2fencC/vLhzjwm4a2m5
	r32I38htCkVMHkDY1MWNhafeMyjPqco4NwnQa20ZmpIqkuBEIgPX3OfpxEP4QHA=
X-Gm-Gg: ASbGnctmIa4jUlNUKlN9j6GoaCwh4y8+1o7/fR0mzHEO95LX2aaMLxvlW+DjzU6e8SF
	w8gyy4OGK3kIjwEXLRYz9Crx5M19KXI4vNqniJCa31u9FPhV9CnwieAAWLgClw8Plt8AEhngOq2
	eJm9K9SRo5Z3K7REPaISF9UT+U590Se0mdynE9uZNVkli1ev2D6zC8wAp0sSfrshbb5UMcRecp9
	qSDwKOZ+aCfRpcfjsXQYM8Mw0y4AVi0ekpSDYQwFVT0qlizLLdA8Lv1WPmB5bzNJR6kN70wj6p2
	H8ME68XmAvSHZyOZWWxqw4+1XsN/
X-Google-Smtp-Source: AGHT+IEw+cUq8N3YnTJQvX1WmFYfTqQVR7hTqQXnoJ+ZcLi1ljTgfQoIUXe99s2hH3estqLJNitCKQ==
X-Received: by 2002:a05:622a:58c6:b0:476:909b:8287 with SMTP id d75a77b69052e-4771dd801c5mr305002311cf.20.1742910932009;
        Tue, 25 Mar 2025 06:55:32 -0700 (PDT)
Received: from ziepe.ca ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d18f7f5sm60098791cf.35.2025.03.25.06.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:55:31 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1tx4kd-0009Ay-2x;
	Tue, 25 Mar 2025 10:55:31 -0300
Date: Tue, 25 Mar 2025 10:55:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: benve@cisco.com, neescoba@cisco.com, leon@kernel.org,
	liyuyu6@huawei.com, roland@purestorage.com, umalhi@cisco.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	yanjun.zhu@linux.dev
Subject: Re: [PATCH v2 -next] RDMA/usnic: Fix passing zero to PTR_ERR in
 usnic_ib_pci_probe()
Message-ID: <Z+K103IYCOwa/pwg@ziepe.ca>
References: <20250324123132.2392077-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324123132.2392077-1-yuehaibing@huawei.com>

On Mon, Mar 24, 2025 at 08:31:32PM +0800, Yue Haibing wrote:
> drivers/infiniband/hw/usnic/usnic_ib_main.c:590
>  usnic_ib_pci_probe() warn: passing zero to 'PTR_ERR'
> 
> Make usnic_ib_device_add() return NULL on fail path, also remove
> useless NULL check for usnic_ib_discover_pf()
> 
> Fixes: e3cf00d0a87f ("IB/usnic: Add Cisco VIC low-level hardware driver")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> v2: remove useless null check for usnic_ib_discover_pf
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_main.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

