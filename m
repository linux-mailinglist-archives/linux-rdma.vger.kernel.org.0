Return-Path: <linux-rdma+bounces-4586-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1535F960F39
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 16:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D3BB26872
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34071C7B92;
	Tue, 27 Aug 2024 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UZGIV/mE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEDB1C6F51
	for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2024 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770551; cv=none; b=axNTmUqxmupPHqp5fPAwK/VGWguMFX+jLMncF2w1NwNHr5268PhjpMN7R0P/fT/YEtJA1qQF64oOTgZI3AvHvtD2b37TGVfOSsCf353TZI8uIJy1zy2yH+LDswHZXTDrgiT2WP89wXZxeWV5ieO0NgAMGhpM3FyWaOCjCJbHrj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770551; c=relaxed/simple;
	bh=8HSarZ+8nzsJzyaAJYvcMCaBCggraLP2yW+oVniMdgk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az4ETqVDy5jU6bI/3LA8a8jxwwAmUUf4fyJdYVYv6U1vQFV2C2pv+ZEj9XSV2s39XeDu9gokRdruSD0qxG8AhPlaRilvkGgqAhXW5G07LkOkXzeXUpiNmZA8AQ0gBaXjh0b3JwpkpBJkY6NcPTWYmpCCOJ3cFCVyqm6XjVZEYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UZGIV/mE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20203988f37so55034465ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2024 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724770548; x=1725375348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBO6oUVdPjvB+r5bbjNGUYFA648GtqCIp/SzDJKU1FA=;
        b=UZGIV/mEsC8s/2FRE1wHKBZbFulwJO5u+0CpmzEvTzpE4o2nelCvqF97KadFRxzHdG
         czYv4MApD6G84a7+tKGDECy1sYJGUBBj9og4CCXE6vHYx6hDiZaxb8ZNxsh1q1yYthl4
         d45bSRMwoUQMVSmEw5MFYSuQqAUEBwjIX15ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770548; x=1725375348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBO6oUVdPjvB+r5bbjNGUYFA648GtqCIp/SzDJKU1FA=;
        b=LN9zmU08SZ8Kogz7kM//TVdq4OOsQtm2GBOJKiz7w7SATX4eacurmw71FRehIHAn9+
         0YtrVYpCIj4vIxHM8UPh+b/b7rKYy1CAEe5DXET6cy/5QzUCdUJaAFHj+cYQ3JnhtZu/
         P6VbtRUqtoxza3Z+pWtWBLZYT4i/dwa9AxbmFa76029eWnmotAkSoSFQVA2GbBLM8KrY
         8ycjAYbb0IQXRm8w7K7cmbmZ5GLp3Nguv0cgq0QXVi+kDHcZFQRFkgw8y5AwNO1/4+i0
         9O2E+51n+AqFZVdrhN5KtHbfB/1zhAhQq7aHt9TjdXxYL5wf/3+5WvxIpoe869Neh8D3
         9Wqg==
X-Forwarded-Encrypted: i=1; AJvYcCUeYOMnOoIsdG88jsdWdGgOWgJRM1FpBplya7/ggjeVug775/MPUsYwE/Cp47wccG7X8pu6ZYcuIamk@vger.kernel.org
X-Gm-Message-State: AOJu0YysahrY+CE3avoZQhgxARgBRWzAdiYTLoNsVDomDS5g5MfgxIHV
	ynXU9P9cN6t3UnvLr9xV8S9En/o8T9ie/I+5nCnU3gD4IrCkun3P8vt2yoIfcA==
X-Google-Smtp-Source: AGHT+IGOdOD65p46d8D5A+CoFrY2JwvN2o97JFne5WPEIsCcfzr6E+eD5trJl6EMpv0QLzky5qVCKQ==
X-Received: by 2002:a17:903:32ca:b0:201:e7c2:bd03 with SMTP id d9443c01a7336-2039e544ebamr164312585ad.60.1724770548278;
        Tue, 27 Aug 2024 07:55:48 -0700 (PDT)
Received: from C02YVCJELVCG ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038b7ebe0dsm81973395ad.287.2024.08.27.07.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:55:47 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Tue, 27 Aug 2024 10:55:42 -0400
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v3 03/10] fwctl: FWCTL_INFO to return basic information
 about the device
Message-ID: <Zs3o7m0rBmuCXWoe@C02YVCJELVCG>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <3-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <20240823151411.00004b30@Huawei.com>
 <20240827144723.GO3773488@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827144723.GO3773488@nvidia.com>

On Tue, Aug 27, 2024 at 11:47:23AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 23, 2024 at 03:14:11PM +0100, Jonathan Cameron wrote:
> > On Wed, 21 Aug 2024 15:10:55 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > > Userspace will need to know some details about the fwctl interface being
> > > used to locate the correct userspace code to communicate with the
> > > kernel. Provide a simple device_type enum indicating what the kernel
> > > driver is.
> > > 
> > > Allow the device to provide a device specific info struct that contains
> > > any additional information that the driver may need to provide to
> > > userspace.
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Just one minor question: How likely is the data being passed back
> > from the driver to be const?  
> 
> I'm guessing not very? I expect alot of drivers will want to include
> dynamic information about their FW
> 

Agreed.  The presumption is that this will be used to query information from
FW that has no existing API to discover the values.

> > Feels like it might be and should
> > be easy enough to support either const or not.
> 
> It would by easy, lets wait and see, adding another op is trivial.
> Allocating memory is not the end of the world on this path anyhow.

+1 

> 
> Thanks,
> Jason

